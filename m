Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351E5C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0997E20757
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3I4w028"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbgDBNEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:04:50 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:39057 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbgDBNEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:04:49 -0400
Received: by mail-pl1-f182.google.com with SMTP id k18so1310506pll.6
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOnEAcuytkdcItWsdyHCKGXs/Kf+95y4g8FgJKho6xQ=;
        b=Y3I4w028Zq0pK62mLdRKv25offgiwZpz2+lHuvTokQL2cNIhyvxKZwxoQ5vfwrKk/i
         o90Bq9hnt8nVEiye0jxwvrdnTzoKL6T0kht5HaR2AWfvqXwWnBHZebZ0BXCMzkjNeWNW
         m7iwQTUTzB7jl1lnpfI5vFqJaJJE8r9ld2uBPHnFS1slEH2L/j7At0Db0Y7GD2Utsn5Z
         itfcvJKhHjTV1+kkdj135q3dVg21swLUuQIhuL6PbsMS0+OR45cwb9hOd3mlX6uXf6jB
         dv9ULLQywIUJg1v7EvYqCkpIhMS7f7DZqs0/9o78c6IAwc0P1y0+hSwYSNxXby2zX/n9
         f4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOnEAcuytkdcItWsdyHCKGXs/Kf+95y4g8FgJKho6xQ=;
        b=Pmpd0oXksNO80zPsEUQUmVI3EaIPBgVCMvwwLP/hgxOP6e9zQlfyg3gfLpeicZxy32
         NMQQMB5kIM5r9kw3TnmdCXdkrCADHURDA29Emfy+Z35Fk7CsYFwINPJvvEYW4HZU4k06
         broxO5myDXCAE+oYhBC54EkF6Qldw/uTModKDJLusAAAXL5zowbOhn1GPI0LJ6SESwYf
         fNEVE+aSBsrprJadV3rfWy+bDbdc3pCkRJmbOcaPhjLui6g2+GO7eRCscBARoZZdxFKp
         AtNf1q7G9o98NR+nM8ItdRDQypJdXptqyS+9nCpvNyNhZN8v7g/Rtc1asV0FkVjeHABX
         B1fw==
X-Gm-Message-State: AGi0PuY8R4UdzcRQG19s1IxP7TS3+qJH9y6pldYl8pE4bSLA2j/xVWAn
        N/X9HAk7MG1AxCQjpTh0v79mFwu5
X-Google-Smtp-Source: APiQypIj0BF2PI/tbBvDKSrt6fn303oGIuSGIWyYfDBDAOBtgH+e7f4bYS4gDiXJTcwpc8HiXdMgug==
X-Received: by 2002:a17:902:b905:: with SMTP id bf5mr2704489plb.162.1585832687426;
        Thu, 02 Apr 2020 06:04:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o15sm3371124pgj.60.2020.04.02.06.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:04:46 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 6/6] travis: build and test on Linux with musl libc and busybox
Date:   Thu,  2 Apr 2020 20:04:05 +0700
Message-Id: <b61ed50cf63371858c74efc19797342107fdff3d.1585832270.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585832270.git.congdanhqx@gmail.com>
References: <cover.1585474409.git.congdanhqx@gmail.com> <cover.1585832270.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .travis.yml                       |  8 +++++++
 azure-pipelines.yml               | 35 +++++++++++++++++++++++++++++++
 ci/install-docker-dependencies.sh |  4 ++++
 ci/lib.sh                         |  5 +++++
 ci/run-docker-build.sh            |  4 ++++
 ci/run-docker.sh                  |  3 +++
 6 files changed, 59 insertions(+)

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
index 11413f66f8..84ecad76ec 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -514,6 +514,41 @@ jobs:
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
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
index a104c61d29..26a6689766 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -11,4 +11,8 @@ Linux32)
 			libssl-dev libexpat-dev gettext python >/dev/null
 	'
 	;;
+linux-musl)
+	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
+		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
+	;;
 esac
diff --git a/ci/lib.sh b/ci/lib.sh
index d637825222..87cd29bab6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -201,6 +201,11 @@ GIT_TEST_GETTEXT_POISON)
 Linux32)
 	CC=gcc
 	;;
+linux-musl)
+	CC=gcc
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3 USE_LIBPCRE2=Yes"
+	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
index 4a153492ba..8d47a5fda3 100755
--- a/ci/run-docker-build.sh
+++ b/ci/run-docker-build.sh
@@ -18,6 +18,10 @@ case "$jobname" in
 Linux32)
 	switch_cmd="linux32 --32bit i386"
 	;;
+linux-musl)
+	switch_cmd=
+	useradd () { adduser -D "$@"; }
+	;;
 *)
 	exit 1
 	;;
diff --git a/ci/run-docker.sh b/ci/run-docker.sh
index 3881f99b53..37fa372052 100755
--- a/ci/run-docker.sh
+++ b/ci/run-docker.sh
@@ -9,6 +9,9 @@ case "$jobname" in
 Linux32)
 	CI_CONTAINER="daald/ubuntu32:xenial"
 	;;
+linux-musl)
+	CI_CONTAINER=alpine
+	;;
 *)
 	exit 1
 	;;
-- 
2.26.0.334.g6536db25bb

