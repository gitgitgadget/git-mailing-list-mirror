Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A960BC2D0E7
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 10:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802442076A
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 10:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHX5fs4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgC2KNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:13:02 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:40089 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgC2KNC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 06:13:02 -0400
Received: by mail-pj1-f41.google.com with SMTP id kx8so5960453pjb.5
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IzUc5asZit39Tse4zGkRlshXbcjT5AWF0ICnq8VI8k=;
        b=mHX5fs4m2ESlp1rdja2pSPgpOyNhNissdLfPVRp0gWG2X76h8vWB9gPIdv1ZqXh6K6
         eGogXUjT3HXYkTC1eAioeX6dngabtYjv5svvYTcCVIM/v0z+Hs85ocIbfw0COImxMFUe
         S40LsvQWJB5FQFCX6t/GJnvE/bMOX3h0GzuH8ijmZiBCtaTl6vO9yZoEez3QEyKTy/Ym
         f/v/rFa3pUWXxesu8qv5+n1yoXiGEvLEFgDVuOrxT7U1gQBfn2++nkigkjFjd6NwSrff
         YRJDm9h0FgdTh2gGsmqKguETGN4pTsEN567HdDrFRlye4UyukllE08gyDX6Qx52Z8eG6
         5RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IzUc5asZit39Tse4zGkRlshXbcjT5AWF0ICnq8VI8k=;
        b=tHcF/hoMuO20CTG2gIWpWiT3rtMfZWR6eP0x2kh3eSdAZZXIDD5IPyj0EpJd+sAwh/
         7Pb+4+rcG7WC4j5arQv7E/hZXGuBLdUGzevSIUFHpkS7bXGgC2rxMXkj0O6eNwYb5QuC
         h+bpTb5RQi+MvjInWn9V/VrFzn6xYVLgqGIKsmNYTCU36QhBA58GyfKoVVQUx6bLMQ4F
         lWec92z2BhA5UFnq/3aSeQx8kamJtkjuVEnTZ1FuYYwrzA9+DELivFg/uLhXy8RIfEQM
         YspuhMSRDo9Vqg3y8b5jP90LP5ZCg6tBT2bx/ZBAXLxaseo8k64mC8jdNSqf1nS1icpw
         iN+g==
X-Gm-Message-State: ANhLgQ1W87Km2JTAOWRdZUkVyFclKV5Qbk9avQ1CJ6okhy70G4PaaBF3
        DJS4khG2R5SkgIbLktqFbGFn0BzQ
X-Google-Smtp-Source: ADFU+vuKqZyVcoBiegyXa/BeZ/Kof0R+2TRTZW2mdfWeLXiLKphofBnmZA152ChDyaql/Z2ry2WyIQ==
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr8734699pjb.97.1585476780547;
        Sun, 29 Mar 2020 03:13:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:f121:1d2a:e7e0:840f:1f18])
        by smtp.gmail.com with ESMTPSA id v26sm7757386pfn.51.2020.03.29.03.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 03:13:00 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 2/4] ci: refactor docker runner script
Date:   Sun, 29 Mar 2020 17:12:30 +0700
Message-Id: <140e0ef39064d0194e05cad6d9f48e8e5b03aacc.1585474409.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.302.g234993491e
In-Reply-To: <cover.1585474409.git.congdanhqx@gmail.com>
References: <cover.1585203294.git.congdanhqx@gmail.com> <cover.1585474409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will support alpine check in docker later in this series.

While we're at it, tell people to run as root in podman.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .travis.yml                                 |  2 +-
 azure-pipelines.yml                         |  4 ++--
 ci/{run-linux32-docker.sh => run-docker.sh} | 22 +++++++++++++++------
 3 files changed, 19 insertions(+), 9 deletions(-)
 rename ci/{run-linux32-docker.sh => run-docker.sh} (48%)

diff --git a/.travis.yml b/.travis.yml
index fc5730b085..069aeeff3c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -32,7 +32,7 @@ matrix:
       services:
         - docker
       before_install:
-      script: ci/run-linux32-docker.sh
+      script: ci/run-docker.sh
     - env: jobname=StaticAnalysis
       os: linux
       compiler:
diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index af2a5ea484..f6dcc35ad4 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -478,14 +478,14 @@ jobs:
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
 
        res=0
-       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
+       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=Linux32 bash -lxc ci/run-docker.sh || res=1
 
        sudo chmod a+r t/out/TEST-*.xml
        test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
 
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
        exit $res
-    displayName: 'ci/run-linux32-docker.sh'
+    displayName: 'jobname=Linux32 ci/run-docker.sh'
     env:
       GITFILESHAREPWD: $(gitfileshare.pwd)
   - task: PublishTestResults@2
diff --git a/ci/run-linux32-docker.sh b/ci/run-docker.sh
similarity index 48%
rename from ci/run-linux32-docker.sh
rename to ci/run-docker.sh
index 751acfcf8a..be698817cb 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-docker.sh
@@ -1,15 +1,25 @@
 #!/bin/sh
 #
-# Download and run Docker image to build and test 32-bit Git
+# Download and run Docker image to build and test Git
 #
 
 . ${0%/*}/lib.sh
 
-docker pull daald/ubuntu32:xenial
+case "$jobname" in
+Linux32)
+	CI_TARGET=linux32
+	CI_CONTAINER="daald/ubuntu32:xenial"
+	;;
+*)
+	exit 1 ;;
+esac
+
+docker pull "$CI_CONTAINER"
 
 # Use the following command to debug the docker build locally:
-# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
-# root@container:/# /usr/src/git/ci/run-linux32-build.sh <host-user-id>
+# <host-user-id> must be 0 if podman is used in place of docker
+# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/sh "$CI_CONTAINER"
+# root@container:/# /usr/src/git/ci/run-$CI_TARGET-build.sh <host-user-id>
 
 container_cache_dir=/tmp/travis-cache
 
@@ -23,8 +33,8 @@ docker run \
 	--env cache_dir="$container_cache_dir" \
 	--volume "${PWD}:/usr/src/git" \
 	--volume "$cache_dir:$container_cache_dir" \
-	daald/ubuntu32:xenial \
-	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
+	"$CI_CONTAINER" \
+	"/usr/src/git/ci/run-$CI_TARGET-build.sh" $(id -u $USER)
 
 check_unignored_build_artifacts
 
-- 
2.26.0.302.g234993491e

