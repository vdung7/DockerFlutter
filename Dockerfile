FROM --platform=linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x ubuntu:20.04

RUN apt-get update && \
    apt-get install -y bash curl file git unzip xz-utils zip libglu1-mesa && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r -g 1441 flutter && useradd --no-log-init -r -u 1441 -g flutter -m flutter

USER flutter:flutter

WORKDIR /home/flutter

ARG flutterVersion=stable

ADD https://api.github.com/repos/flutter/flutter/compare/${flutterVersion}...${flutterVersion} /dev/null

RUN git clone https://github.com/flutter/flutter.git -b 3.7.1 flutter-sdk

RUN flutter-sdk/bin/flutter precache

RUN flutter-sdk/bin/flutter config --no-analytics

ENV PATH="$PATH:/home/flutter/flutter-sdk/bin"
ENV PATH="$PATH:/home/flutter/flutter-sdk/bin/cache/dart-sdk/bin"

RUN flutter doctor
