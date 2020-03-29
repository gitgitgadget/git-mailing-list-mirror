Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EE7C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 10:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD6520732
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 10:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGgSmCoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgC2KMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:12:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33516 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgC2KMt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 06:12:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id j1so7079011pfe.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbCIY9ofOVkSw58Iabwkz7wpJvJjdprJDEH1wNf/vbw=;
        b=RGgSmCoGVQS/EdDyaqAgF/c4/clFRB5SIILgCC1jRqAWSofT6yk3bl+TdTsfvFosnT
         Bgt2A+7C7bUIh3qAWBwW3bgLoihg+WJOCUjq1aivPKCrExP9DkVhUx+i2+7/K/7pT5L/
         73OcMPvy0AK8v3WoKPuHFv0JhAaNDUZB34LKe+BGqafQZG3La822rebWQtWfyveqgymv
         UIuMn6VITXFqsedYoXb5+VUoMXp+77hpeKKEgA+NzLqfjb4Fi8E6vWsMfO8J4l4E0znS
         fw69+vREBgG7aRkqf0Exvso7WoldKji7cOfK3v1lQ/5EWzvFckIqObZXIOremwjoofDp
         bgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbCIY9ofOVkSw58Iabwkz7wpJvJjdprJDEH1wNf/vbw=;
        b=ht9H/E2FliUUOEIVlUqCp7Gwbs7LCJGIjMiJ8QKGHvMjZ2Y1Z7myVxU/DfzvbLhGB2
         +iPv7eylAWCGiPDiAMOYTbACVpAZvRi+Q+7RsC7bbG1gJyMy7SqWHKof9l6+HJ5KEzxm
         qEuKTsv/uUbEg3e8Q1rpY9TXICOqgjSE0s5NcEuhu0YgQET0IswKPaU92DTPLreZOBkg
         YJJrSr5AlHsKjPBQhZJ1P7GdQjTTeIsBTdLgGxqLvn8f6ArAjoGq3P8yHCUI1mDd36VZ
         caUsiDiEeKmTH6n4gHAJoTEZ6bOjLfRYkC0yHkB4uovmKwILAwJuM5cimhpFR/0B7Jnk
         iwBQ==
X-Gm-Message-State: ANhLgQ3U9EC3XMoFtRC7i9VwVxs0w0rwkz5fl0Iq7srfag/Iz8pDZit0
        iFSCMN6B/hFeq7mxzmt84ineCXiE
X-Google-Smtp-Source: ADFU+vsCd3qrvULRtW3tJtub9TTuBtcmMQVOKFTyt3ZTaXmsw2Vvotkaz+rFRmjCZPwYgDcLFTXTFw==
X-Received: by 2002:a62:8343:: with SMTP id h64mr8359562pfe.166.1585476765912;
        Sun, 29 Mar 2020 03:12:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:f121:1d2a:e7e0:840f:1f18])
        by smtp.gmail.com with ESMTPSA id v26sm7757386pfn.51.2020.03.29.03.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 03:12:45 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] Travis + Azure jobs for linux with musl libc
Date:   Sun, 29 Mar 2020 17:12:28 +0700
Message-Id: <cover.1585474409.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.302.g234993491e
In-Reply-To: <cover.1585203294.git.congdanhqx@gmail.com>
References: <cover.1585203294.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently, we've un-broken git for Linux with musl libc,
and we have a serie to fix false negative with busybox shell utils.

Add a CI job on Travis and Azure to make sure we won't break it again.

There is a sample travis build for this serie applied on top of:
jt/rebase-allow-duplicate
https://travis-ci.org/github/sgn/git/builds/668300819

And, after merging with junio's pu to fix busybox false negative:
https://travis-ci.org/github/sgn/git/builds/668300919
https://dev.azure.com/git/git/_build/results?buildId=1910&view=results

Change from v1:
- fix spelling
- run-docker.sh: use "jobname" environment variable instead of passing argument
- add linux-musl job on Azure
- Add 4th patch for jt/rebase-allow-duplicate (feel free to squash into
 jt/rebase-allow-duplicate)

The first 3 patches could be applied on top of master,
but the last patch needs to be applied on top of jt/rebase-allow-duplicate


Đoàn Trần Công Danh (4):
  ci: libify logic for usage and checking CI_USER
  ci: refactor docker runner script
  travis: build and test on Linux with musl libc and busybox
  t3402: use POSIX compliant regex(7)

 .travis.yml                                 | 10 +++++-
 azure-pipelines.yml                         | 39 +++++++++++++++++++--
 ci/lib-docker.sh                            | 37 +++++++++++++++++++
 ci/run-alpine-build.sh                      | 31 ++++++++++++++++
 ci/{run-linux32-docker.sh => run-docker.sh} | 26 ++++++++++----
 ci/run-linux32-build.sh                     | 35 +-----------------
 t/t3402-rebase-merge.sh                     |  8 ++---
 7 files changed, 139 insertions(+), 47 deletions(-)
 create mode 100644 ci/lib-docker.sh
 create mode 100755 ci/run-alpine-build.sh
 rename ci/{run-linux32-docker.sh => run-docker.sh} (46%)

Range-diff against v1:
1:  f23f2a563a = 1:  1ec7c2024d ci: libify logic for usage and checking CI_USER
2:  6fd1370678 ! 2:  140e0ef390 ci: refactor docker runner script
    @@ Metadata
      ## Commit message ##
         ci: refactor docker runner script
     
    -    We will support alpine check in docker later in this serie.
    +    We will support alpine check in docker later in this series.
     
         While we're at it, tell people to run as root in podman.
     
    @@ .travis.yml: matrix:
              - docker
            before_install:
     -      script: ci/run-linux32-docker.sh
    -+      script: ci/run-docker.sh linux32
    ++      script: ci/run-docker.sh
          - env: jobname=StaticAnalysis
            os: linux
            compiler:
    @@ azure-pipelines.yml: jobs:
      
             res=0
     -       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
    -+       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-docker.sh linux32 || res=1
    ++       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=Linux32 bash -lxc ci/run-docker.sh || res=1
      
             sudo chmod a+r t/out/TEST-*.xml
             test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
    @@ azure-pipelines.yml: jobs:
             test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
             exit $res
     -    displayName: 'ci/run-linux32-docker.sh'
    -+    displayName: 'ci/run-docker.sh linux32'
    ++    displayName: 'jobname=Linux32 ci/run-docker.sh'
          env:
            GITFILESHAREPWD: $(gitfileshare.pwd)
        - task: PublishTestResults@2
    @@ ci/run-docker.sh (new)
     @@
     +#!/bin/sh
     +#
    -+# Download and run Docker image to build and test git
    ++# Download and run Docker image to build and test Git
     +#
     +
     +. ${0%/*}/lib.sh
     +
    -+CI_TARGET=${1:-linux32}
    -+case "$CI_TARGET" in
    -+linux32) CI_CONTAINER="daald/ubuntu32:xenial" ;;
    -+*)       exit 1 ;;
    ++case "$jobname" in
    ++Linux32)
    ++	CI_TARGET=linux32
    ++	CI_CONTAINER="daald/ubuntu32:xenial"
    ++	;;
    ++*)
    ++	exit 1 ;;
     +esac
     +
     +docker pull "$CI_CONTAINER"
3:  2f68e65fb7 ! 3:  6cf6400f2e travis: build and test on Linux with musl libc and busybox
    @@ .travis.yml
     @@ .travis.yml: matrix:
              - docker
            before_install:
    -       script: ci/run-docker.sh linux32
    -+    - env: jobname=linux-musl-busybox
    +       script: ci/run-docker.sh
    ++    - env: jobname=linux-musl
     +      os: linux
     +      compiler:
     +      addons:
     +      services:
     +        - docker
     +      before_install:
    -+      script: ci/run-docker.sh alpine
    ++      script: ci/run-docker.sh
          - env: jobname=StaticAnalysis
            os: linux
            compiler:
     
    + ## azure-pipelines.yml ##
    +@@ azure-pipelines.yml: jobs:
    +       PathtoPublish: t/failed-test-artifacts
    +       ArtifactName: failed-test-artifacts
    + 
    ++- job: linux_musl
    ++  displayName: linux-musl
    ++  condition: succeeded()
    ++  pool:
    ++    vmImage: ubuntu-latest
    ++  steps:
    ++  - bash: |
    ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
    ++
    ++       res=0
    ++       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=linux-musl bash -lxc ci/run-docker.sh || res=1
    ++
    ++       sudo chmod a+r t/out/TEST-*.xml
    ++       test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
    ++
    ++       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
    ++       exit $res
    ++    displayName: 'jobname=linux-musl ci/run-docker.sh'
    ++    env:
    ++      GITFILESHAREPWD: $(gitfileshare.pwd)
    ++  - task: PublishTestResults@2
    ++    displayName: 'Publish Test Results **/TEST-*.xml'
    ++    inputs:
    ++      mergeTestResults: true
    ++      testRunTitle: 'musl'
    ++      platform: Linux
    ++      publishRunAttachments: false
    ++    condition: succeededOrFailed()
    ++  - task: PublishBuildArtifacts@1
    ++    displayName: 'Publish trash directories of failed tests'
    ++    condition: failed()
    ++    inputs:
    ++      PathtoPublish: t/failed-test-artifacts
    ++      ArtifactName: failed-test-artifacts
    ++
    + - job: static_analysis
    +   displayName: StaticAnalysis
    +   condition: succeeded()
    +
      ## ci/run-alpine-build.sh (new) ##
     @@
     +#!/bin/sh
    @@ ci/run-alpine-build.sh (new)
     +'
     
      ## ci/run-docker.sh ##
    -@@
    - CI_TARGET=${1:-linux32}
    - case "$CI_TARGET" in
    - linux32) CI_CONTAINER="daald/ubuntu32:xenial" ;;
    -+alpine)  CI_CONTAINER="alpine" ;;
    - *)       exit 1 ;;
    +@@ ci/run-docker.sh: Linux32)
    + 	CI_TARGET=linux32
    + 	CI_CONTAINER="daald/ubuntu32:xenial"
    + 	;;
    ++linux-musl)
    ++	CI_TARGET=alpine
    ++	CI_CONTAINER=alpine
    ++	;;
    + *)
    + 	exit 1 ;;
      esac
    - 
-:  ---------- > 4:  a4eacb4362 t3402: use POSIX compliant regex(7)
-- 
2.26.0.302.g234993491e

