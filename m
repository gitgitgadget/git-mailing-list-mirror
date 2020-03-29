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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53834C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 10:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B06620732
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 10:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWDtcRUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgC2KNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:13:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47092 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgC2KNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 06:13:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id k191so7157771pgc.13
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPuGnm0/GoR6u/KoUqrv/BXfj/vfsz+s2f6TEm9ouBw=;
        b=cWDtcRUnvVfRfpfXUrpBP5lJxNy5tNQzOkeqcNdr218WCFWPVzrQa6CcG3BILeB0jc
         gHhFAMihsnrDeFWASe/JXAMRqYSdC6X8ctkhYEnIv66POMugXl5UuyOh1w6gJk6PaFyz
         QUxHC/Kx1YoaWjbZYaXiTzKdSQtyEkHPb1K43zrkaDNVTfHzEU/fGaR0iw5ntUSl0oKX
         7aniX39ur95eViPSL21S9oFtrmZBUsXvXuEllzdwjFHC39Po0FBNFbcqfJVWkB3quo/4
         C8q5Y17r6kg/yTUKUyBHuam9sMfjxUj1UkaMmL5QEpvhTeKxiKqV/Bts1ETMEHmyhm9b
         teig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPuGnm0/GoR6u/KoUqrv/BXfj/vfsz+s2f6TEm9ouBw=;
        b=GDouqCtSuux4/W2BMsNjaEt6R/0QCohV7PSmwqHDGHJYoxHbR3Q4TydW6SQaSHf/ma
         Bf29HvaOsD1geeS21d5DwM4DLc9uX61tZHdj188Yk+FspphbLHO+bWaNldHtfJaZ0pPY
         2tnFDn4AThwTF6BB6hdfg/Mww7wusJIXgNLOx/8yAjhwhPZre6B+mMW6bG5ALieTyHv5
         DUeeVZniUwb0ppe1m1R8q5Lz3D8PLnrgbeaRAAaI7tLAardOTqits8YnK+aoKSp6MRAO
         OEntgT3cFpCK0scjXCsoA/fZyL4ynFMx1OSv7ElVNMvKx8Or5O6yZ1Zecl8vGvIn0h3p
         J0PQ==
X-Gm-Message-State: ANhLgQ3gEAazZN+V0hru69cTAi8HqkA8q0N8nlBrEamL/UNDG0npf9OA
        2eGD8HGcRwwSHz4RLQtBKB5y/IhP
X-Google-Smtp-Source: ADFU+vvaOqPsK1k2D9Lifu7F5Z/xqKBMO8Gla+Z4+bpkq+Yzx62YZ6ZZlwwgEXhRki2a/udzwmyoiA==
X-Received: by 2002:a63:1e59:: with SMTP id p25mr8123189pgm.219.1585476787975;
        Sun, 29 Mar 2020 03:13:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:f121:1d2a:e7e0:840f:1f18])
        by smtp.gmail.com with ESMTPSA id v26sm7757386pfn.51.2020.03.29.03.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 03:13:07 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 3/4] travis: build and test on Linux with musl libc and busybox
Date:   Sun, 29 Mar 2020 17:12:31 +0700
Message-Id: <6cf6400f2e0f7336e9b13ddbf412101c4ab48dc5.1585474409.git.congdanhqx@gmail.com>
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

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .travis.yml            |  8 ++++++++
 azure-pipelines.yml    | 35 +++++++++++++++++++++++++++++++++++
 ci/run-alpine-build.sh | 31 +++++++++++++++++++++++++++++++
 ci/run-docker.sh       |  4 ++++
 4 files changed, 78 insertions(+)
 create mode 100755 ci/run-alpine-build.sh

diff --git a/.travis.yml b/.travis.yml
index 069aeeff3c..0cfc3c3428 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -33,6 +33,14 @@ matrix:
         - docker
       before_install:
       script: ci/run-docker.sh
+    - env: jobname=linux-musl
+      os: linux
+      compiler:
+      addons:
+      services:
+        - docker
+      before_install:
+      script: ci/run-docker.sh
     - env: jobname=StaticAnalysis
       os: linux
       compiler:
diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index f6dcc35ad4..615289167b 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -503,6 +503,41 @@ jobs:
       PathtoPublish: t/failed-test-artifacts
       ArtifactName: failed-test-artifacts
 
+- job: linux_musl
+  displayName: linux-musl
+  condition: succeeded()
+  pool:
+    vmImage: ubuntu-latest
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       res=0
+       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=linux-musl bash -lxc ci/run-docker.sh || res=1
+
+       sudo chmod a+r t/out/TEST-*.xml
+       test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
+       exit $res
+    displayName: 'jobname=linux-musl ci/run-docker.sh'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - task: PublishTestResults@2
+    displayName: 'Publish Test Results **/TEST-*.xml'
+    inputs:
+      mergeTestResults: true
+      testRunTitle: 'musl'
+      platform: Linux
+      publishRunAttachments: false
+    condition: succeededOrFailed()
+  - task: PublishBuildArtifacts@1
+    displayName: 'Publish trash directories of failed tests'
+    condition: failed()
+    inputs:
+      PathtoPublish: t/failed-test-artifacts
+      ArtifactName: failed-test-artifacts
+
 - job: static_analysis
   displayName: StaticAnalysis
   condition: succeeded()
diff --git a/ci/run-alpine-build.sh b/ci/run-alpine-build.sh
new file mode 100755
index 0000000000..c83df536e4
--- /dev/null
+++ b/ci/run-alpine-build.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# Build and test Git in Alpine Linux
+#
+# Usage:
+#   run-alpine-build.sh <host-user-id>
+#
+
+set -ex
+
+useradd () {
+	adduser -D "$@"
+}
+
+. "${0%/*}/lib-docker.sh"
+
+# Update packages to the latest available versions
+apk add --update autoconf build-base curl-dev openssl-dev expat-dev \
+	gettext pcre2-dev python3 musl-libintl >/dev/null
+
+# Build and test
+su -m -l $CI_USER -c '
+	set -ex
+	cd /usr/src/git
+	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
+	autoconf
+	echo "PYTHON_PATH=/usr/bin/python3" >config.mak
+	./configure --with-libpcre
+	make
+	make test
+'
diff --git a/ci/run-docker.sh b/ci/run-docker.sh
index be698817cb..f203db03cf 100755
--- a/ci/run-docker.sh
+++ b/ci/run-docker.sh
@@ -10,6 +10,10 @@ Linux32)
 	CI_TARGET=linux32
 	CI_CONTAINER="daald/ubuntu32:xenial"
 	;;
+linux-musl)
+	CI_TARGET=alpine
+	CI_CONTAINER=alpine
+	;;
 *)
 	exit 1 ;;
 esac
-- 
2.26.0.302.g234993491e

