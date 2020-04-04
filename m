Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5F0C43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637D020731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzolGEDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDDBJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:09:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40012 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgDDBJD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:09:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so4441208pgj.7
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZNOzGxV5nntRAz8Eb6AS6T+BLtcAg/2YhQTd96gHpY=;
        b=DzolGEDLaj7RFbLzqqU+hNFSAbMhlxBSTrjop/blY8JCkafunu9EFnd2NC87bnMmLb
         McPeObRP2TeeG5vTaeZudphE+vZ1wE1/uX7j/+MpXN1yRiBfxT4Z+Dm+CRjmi9ON4hqM
         kijcSRmh/VBXiw1nyUq4wK3rn9FJeAbtMHhaprZ2h+ZqBgrxTyL4kSunftQrINt3xf/0
         tQph4nl/V1tmcYuzegb58e6Eq040PAHmo85gBTpcHgrLeEtl6fiwrCUWyEQ7ZSEZ/qNO
         I5V9Zv+CQpbiHfPQLqTsHYtDJUK4DtJBakneTKOKcdlzAEkhjStpgIZ7PCakgPjpXhKH
         Gflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZNOzGxV5nntRAz8Eb6AS6T+BLtcAg/2YhQTd96gHpY=;
        b=bRw7IKJe3BvYRotOgRqfjtA+VlPifuq24mx3nFRoFZ9tSMaCQ00AOhQrjTydAv0Ys1
         PXHhYpjizA6/eYtLPwCoruVLwNqTUqyYS2gqBvDmk+g6VDWsmO9sF8vD/PhW5ea77iQt
         ZbPC9drHzWjwZf3teueT2Ib6sMl0dtXjy62CIToTz4Kl4rcaasP490I3+fpiz4xTo1FI
         XwaX2qdQ9QSXzr40i4ySRG+tuVd1oTUzGoGnPfxOuvnPOsxydNDtCAAIm20XZ2WzOO7K
         e4pRpJsi1wA6V//+bgho0ZrdssJRNumcBncYv1hYpeHwYxJgTQ1iTjvDIEUt7HDYZz5k
         7NZQ==
X-Gm-Message-State: AGi0PuYClyfa/XPyOAeFS0dUvusSAx1nNsS+j8y2Vb4NpAYVndjW2Wra
        9OiQ98eEsEMAysNS8oNhYesYwm3k
X-Google-Smtp-Source: APiQypKBvoNnyvYMIxmaVefI1oPJpVn//bK6Zfj751kr99lBUWnE8Z5CeHPs6iTV/Zvrptwuo3gHQQ==
X-Received: by 2002:a63:2b8d:: with SMTP id r135mr10714256pgr.329.1585962539095;
        Fri, 03 Apr 2020 18:08:59 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o12sm6664319pjt.16.2020.04.03.18.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 18:08:58 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/6] Travis jobs for linux with musl libc
Date:   Sat,  4 Apr 2020 08:08:44 +0700
Message-Id: <cover.1585961568.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585474409.git.congdanhqx@gmail.com>
References: <cover.1585474409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc: Junio C Hamano <gitster@pobox.com>,
 SZEDER Gábor <szeder.dev@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>

Recently, we've un-broken git for Linux with musl libc,
and we have a serie to fix false negative with busybox shell utils.

Add a CI job on Travis and Azure to make sure we won't break it again.

Change from v3:
* reword 2/6: adding su behavior in util-linux and busybox
* 6/6: Drop change to azure-pipelines.yml, and declare this series will
  be used for Travis only. Since Azure will be replaced by GitHub Action
  in a later series.

Hi Junio,
The series for GitHub Actions will need to be rebased on this series again.
6/6 in that seriess will have UD conflicts.
Please "git rm azure-pipelines.yml" to fix conflicts.

SZEDER Gábor (1):
  ci: make MAKEFLAGS available inside the Docker container in the
    Linux32 job

Đoàn Trần Công Danh (5):
  ci/lib-docker: preserve required environment variables
  ci/linux32: parameterise command to switch arch
  ci: refactor docker runner script
  ci/linux32: libify install-dependencies step
  travis: build and test on Linux with musl libc and busybox

 .travis.yml                                   | 10 ++++-
 azure-pipelines.yml                           |  4 +-
 ci/install-docker-dependencies.sh             | 18 +++++++++
 ci/lib.sh                                     |  8 ++++
 ...n-linux32-build.sh => run-docker-build.sh} | 39 +++++++++++++------
 ci/{run-linux32-docker.sh => run-docker.sh}   | 28 ++++++++++---
 6 files changed, 86 insertions(+), 21 deletions(-)
 create mode 100755 ci/install-docker-dependencies.sh
 rename ci/{run-linux32-build.sh => run-docker-build.sh} (63%)
 rename ci/{run-linux32-docker.sh => run-docker.sh} (43%)

Range-diff against v3:
1:  2fdce60075 = 1:  2fdce60075 ci: make MAKEFLAGS available inside the Docker container in the Linux32 job
2:  b7b079f559 ! 2:  db574b3ff9 ci/lib-docker: preserve required environment variables
    @@ Commit message
     
         We're using "su -m" to preserve environment variables in the shell run
         by "su". But, that options will be ignored while "-l" (aka "--login") is
    -    specified.
    +    specified in util-linux and busybox's su.
    +
    +    In a later patch this script will be reused for checking Git for Linux
    +    with musl libc on Alpine Linux, Alpine Linux uses "su" from busybox.
     
         Since we don't have interest in all environment variables,
         pass only those necessary variables to the inner script.
3:  8c8cf3eb24 = 3:  a13715245f ci/linux32: parameterise command to switch arch
4:  22cc7960c3 = 4:  b5de868c1e ci: refactor docker runner script
5:  2e0d54f81e = 5:  c39451ffe5 ci/linux32: libify install-dependencies step
6:  b61ed50cf6 ! 6:  231affae83 travis: build and test on Linux with musl libc and busybox
    @@ .travis.yml: matrix:
            os: linux
            compiler:
     
    - ## azure-pipelines.yml ##
    -@@ azure-pipelines.yml: jobs:
    -       PathtoPublish: t/failed-test-artifacts
    -       ArtifactName: failed-test-artifacts
    - 
    -+- job: linux_musl
    -+  displayName: linux-musl
    -+  condition: succeeded()
    -+  pool:
    -+    vmImage: ubuntu-latest
    -+  steps:
    -+  - bash: |
    -+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
    -+
    -+       res=0
    -+       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=linux-musl bash -lxc ci/run-docker.sh || res=1
    -+
    -+       sudo chmod a+r t/out/TEST-*.xml
    -+       test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
    -+
    -+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
    -+       exit $res
    -+    displayName: 'jobname=linux-musl ci/run-docker.sh'
    -+    env:
    -+      GITFILESHAREPWD: $(gitfileshare.pwd)
    -+  - task: PublishTestResults@2
    -+    displayName: 'Publish Test Results **/TEST-*.xml'
    -+    inputs:
    -+      mergeTestResults: true
    -+      testRunTitle: 'musl'
    -+      platform: Linux
    -+      publishRunAttachments: false
    -+    condition: succeededOrFailed()
    -+  - task: PublishBuildArtifacts@1
    -+    displayName: 'Publish trash directories of failed tests'
    -+    condition: failed()
    -+    inputs:
    -+      PathtoPublish: t/failed-test-artifacts
    -+      ArtifactName: failed-test-artifacts
    -+
    - - job: static_analysis
    -   displayName: StaticAnalysis
    -   condition: succeeded()
    -
      ## ci/install-docker-dependencies.sh ##
     @@ ci/install-docker-dependencies.sh: Linux32)
      			libssl-dev libexpat-dev gettext python >/dev/null
-- 
2.26.0.334.g6536db25bb

