Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1267B2023D
	for <e@80x24.org>; Fri,  3 Mar 2017 11:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbdCCLH7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 06:07:59 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37258 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdCCLH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 06:07:57 -0500
Received: by mail-wm0-f53.google.com with SMTP id n11so12582638wma.0
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 03:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i5tKDsqD2H7RksD+V3s8F4XISSg7J7R5oslvfA1LUSo=;
        b=BKRmxDO6iZHQFkRUgdw0CUKyNy53eJTPB7j+DP1J1EawAmvSDbRA8HJIhRCgvVtUHN
         5p1DbtzwIXfVD0uwdoX/xV/TUXrC/0MwBWpqL+Wg2AGekBGLQKNlER/C6RdZuOQXhgZ4
         j08Zyl47LuG+6JL3pZOqxhNlNLSI1KzGea1bYQjTfQS6XGh7Cvy0o5Ru5RIkvravX7rr
         o/xlAA43P31YL+JtP5U4BiQWdnudtLJt1vEB9rdtWuTr9FV9XJXj8TaRrFfe1GETmnEX
         64L7sBjaeuoUyT4xjUCNiC9QoiZOqrvz6pd7S5Mx1BUqzJ/vDAbF+ohEjjk7kyfFVIZi
         z+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i5tKDsqD2H7RksD+V3s8F4XISSg7J7R5oslvfA1LUSo=;
        b=aRqWuZrlNz/slX1kKaaGUkaVkSuZ+EwkVfcP9cnayoIMk2QynxKFPcL6aix+7d1kFJ
         UzKnVF+OzcEou2/ztAq7qPa9BQ/KknyiQq52rc6TBs4nPgHs0dh8Ma43/CindrLyeh37
         vbtQkNbrccs35h3CEAHzoGEl4DQLiwR0WdJToKaRMXAJHlJdiLIHzwgovu8JI0N0FoAW
         +3MRrrN3dJ5lHcO6qoa5kphtEI+MQygfmvqhkyzIIhlDATQ2uF8yI0Lda3GEOTqVyKvZ
         4CDv8XiG6D1qo/8SDfhpi86qz9CP3t93t744lxnmwkm6WNVjRXxZTQSlhSjothujr7+e
         vucg==
X-Gm-Message-State: AMke39koC+byd7JUC4ch0Phl9uFLCWE3xQAfgBxVxh2C9Gsa+9uIVBnoKSr+753gD5oVOA==
X-Received: by 10.28.196.142 with SMTP id u136mr2122972wmf.93.1488538888467;
        Fri, 03 Mar 2017 03:01:28 -0800 (PST)
Received: from miljwg8b32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 63sm14780612wrh.68.2017.03.03.03.01.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 03 Mar 2017 03:01:27 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, christian.couder@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] Travis: also test on 32-bit Linux
Date:   Fri,  3 Mar 2017 12:01:25 +0100
Message-Id: <20170303110125.43332-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git v2.9.1 was released, it had a bug that showed only on Windows
and on 32-bit systems: our assumption that `unsigned long` can hold
64-bit values turned out to be wrong.

This could have been caught earlier if we had a Continuous Testing
set up that includes a build and test run on 32-bit Linux.

Let's do this (and take care of the Windows build later). This patch
asks Travis CI to install a Docker image with 32-bit libraries and then
goes on to build and test Git using this 32-bit setup.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

changes based on reviews since v2:
    - removed "set -e"
    - pass docker image name to run-linux32-build script
    - use Dscho's docker run formatting

other changes:
    - We run "make" with "-j2" and "make test" without parallelization because
      prove already parallelizes the tests (see GIT_PROVE_OPTS in .travis.yml).
    - If the tests fail then I make all output files readable to everyone.
      This is necessary because the files are created with a root account
      inside the docker container and I want to allow the "after_failure" step
      outside the container to read the files without root permissions.


The job passes on the current master:
https://travis-ci.org/larsxschneider/git/jobs/207168867 (JS)
https://api.travis-ci.org/jobs/207168867/log.txt?deansi=true (non-JS)

The job fails on v2.9.1:
https://travis-ci.org/larsxschneider/git/jobs/207306002 (JS)
https://api.travis-ci.org/jobs/207306002/log.txt?deansi=true (non-JS)


Cheers,
Lars


Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/c5d84e8785
    Checkout: git fetch https://github.com/larsxschneider/git travisci/linux32-v2 && git checkout c5d84e8785

    Interdiff (v1..v2):

    diff --git a/.travis.yml b/.travis.yml
    index c8c789c437..fd60fd8328 100644
    --- a/.travis.yml
    +++ b/.travis.yml
    @@ -47,7 +47,7 @@ matrix:
           before_install:
             - docker pull daald/ubuntu32:xenial
           before_script:
    -      script: ci/run-linux32-build.sh
    +      script: ci/run-linux32-build.sh daald/ubuntu32:xenial
         - env: Documentation
           os: linux
           compiler: clang
    diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
    index b892fbdc9e..13c184d41c 100755
    --- a/ci/run-linux32-build.sh
    +++ b/ci/run-linux32-build.sh
    @@ -2,20 +2,30 @@
     #
     # Build and test Git in a docker container running a 32-bit Ubuntu Linux
     #
    +# Usage:
    +#   run-linux32-build.sh [container-image]
    +#

    -set -e
    -
    -APT_INSTALL="apt update >/dev/null && apt install -y build-essential "\
    -"libcurl4-openssl-dev libssl-dev libexpat-dev gettext python >/dev/null"
    +CONTAINER="${1:-daald/ubuntu32:xenial}"

    -TEST_GIT_ENV="DEFAULT_TEST_TARGET=$DEFAULT_TEST_TARGET "\
    -"GIT_PROVE_OPTS=\"$GIT_PROVE_OPTS\" "\
    -"GIT_TEST_OPTS=\"$GIT_TEST_OPTS\" "\
    -"GIT_TEST_CLONE_2GB=$GIT_TEST_CLONE_2GB"
    +sudo docker run --interactive --volume "${PWD}:/usr/src/git" "$CONTAINER" \
    +    /bin/bash -c 'linux32 --32bit i386 sh -c "
    +    : update packages &&
    +    apt update >/dev/null &&
    +    apt install -y build-essential libcurl4-openssl-dev libssl-dev \
    +        libexpat-dev gettext python >/dev/null &&

    -TEST_GIT_CMD="linux32 --32bit i386 sh -c "\
    -"'$APT_INSTALL && cd /usr/src/git && $TEST_GIT_ENV make -j2 test'"
    +    : build and test &&
    +    cd /usr/src/git &&
    +    export DEFAULT_TEST_TARGET='$DEFAULT_TEST_TARGET' &&
    +    export GIT_PROVE_OPTS=\"'"$GIT_PROVE_OPTS"'\" &&
    +    export GIT_TEST_OPTS=\"'"$GIT_TEST_OPTS"'\" &&
    +    export GIT_TEST_CLONE_2GB='$GIT_TEST_CLONE_2GB' &&
    +    make --jobs=2 &&
    +    make --quiet test || (

    -sudo docker run \
    -    --interactive --volume "${PWD}:/usr/src/git" \
    -    daald/ubuntu32:xenial /bin/bash -c "$TEST_GIT_CMD"
    +    : make test-results readable to non-root user on TravisCI &&
    +    test '$TRAVIS' &&
    +    find t/test-results/ -type f -exec chmod o+r {} \; &&
    +    false )
    +"'

    \0

 .travis.yml             |  9 +++++++++
 ci/run-linux32-build.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100755 ci/run-linux32-build.sh

diff --git a/.travis.yml b/.travis.yml
index 9c63c8c3f6..fd60fd8328 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,6 +39,15 @@ env:

 matrix:
   include:
+    - env: Linux32
+      os: linux
+      sudo: required
+      services:
+        - docker
+      before_install:
+        - docker pull daald/ubuntu32:xenial
+      before_script:
+      script: ci/run-linux32-build.sh daald/ubuntu32:xenial
     - env: Documentation
       os: linux
       compiler: clang
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
new file mode 100755
index 0000000000..13c184d41c
--- /dev/null
+++ b/ci/run-linux32-build.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# Build and test Git in a docker container running a 32-bit Ubuntu Linux
+#
+# Usage:
+#   run-linux32-build.sh [container-image]
+#
+
+CONTAINER="${1:-daald/ubuntu32:xenial}"
+
+sudo docker run --interactive --volume "${PWD}:/usr/src/git" "$CONTAINER" \
+    /bin/bash -c 'linux32 --32bit i386 sh -c "
+    : update packages &&
+    apt update >/dev/null &&
+    apt install -y build-essential libcurl4-openssl-dev libssl-dev \
+        libexpat-dev gettext python >/dev/null &&
+
+    : build and test &&
+    cd /usr/src/git &&
+    export DEFAULT_TEST_TARGET='$DEFAULT_TEST_TARGET' &&
+    export GIT_PROVE_OPTS=\"'"$GIT_PROVE_OPTS"'\" &&
+    export GIT_TEST_OPTS=\"'"$GIT_TEST_OPTS"'\" &&
+    export GIT_TEST_CLONE_2GB='$GIT_TEST_CLONE_2GB' &&
+    make --jobs=2 &&
+    make --quiet test || (
+
+    : make test-results readable to non-root user on TravisCI &&
+    test '$TRAVIS' &&
+    find t/test-results/ -type f -exec chmod o+r {} \; &&
+    false )
+"'

base-commit: 3bc53220cb2dcf709f7a027a3f526befd021d858
--
2.11.1

