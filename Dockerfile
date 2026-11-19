FROM quay.io/rockylinux/rockylinux@sha256:d24beedc58f79b9e0e9289fedaa4fcbcbe692b1438883a86f177fd7c51053ca8

ENV SUMMARY="Network Presence Binding Daemon." \
    DESCRIPTION="Tang is a small daemon for binding data to the presence of a third party. This is a containerized Tang server." \
    VERSION=1 \
    TANG_LISTEN_PORT=80

LABEL name="stackhpc/tang" \
      summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      version="${VERSION}" \
      usage="podman run -d -p 8080:80 -v tang-keys:/var/db/tang --name tang stackhpc/tang"

RUN dnf update -y && \
    dnf install -y \
             tang \
             socat && \
    dnf clean all && \
    rm -rf /var/cache/yum

COPY root /

VOLUME ["/var/db/tang"]
EXPOSE "${TANG_LISTEN_PORT}"

HEALTHCHECK CMD ["/usr/bin/tangd-healthcheck"]
CMD ["/usr/bin/tangd-entrypoint"]
