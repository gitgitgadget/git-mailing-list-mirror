Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4631C2BA16
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B0D20730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuD3H/ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDHEGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39476 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgDHEF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:05:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id g32so2749324pgb.6
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOdSDlJmJgfjGkkg9NvP+fRLE2T09Z5wzak9T3a+wWI=;
        b=iuD3H/ovOauYNj/dWr/DbbJDn1Mn/XaEu6Ve4pad1V0poP1wLj6oOx+0+tqL11he2R
         bRQ5W1l2KW55phVQjgOUh8Stu9ZQHT8bLKJQr1S36KJ8NbS6RmU9A/fpk/A0d2R6wfM2
         rYD/vH/2eszDmEOtKQgB3Atu4uLY9f+/kB9rMa3x4NrYoPnqBpVpI3YQB0Y1G98bg1sX
         /I7mKvooV5SbW41TVfOMxk6lh+UzqfKJ1K5pHjQ9B1PUnqHz2G0a7DlzdcMW2fGIa6Xl
         H5meatP0aLwkwoLfcsHvWcxG4IFuQ3Le8iYz9aupndY8pn89NkItxxycq1eyNnnl4tkK
         N8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOdSDlJmJgfjGkkg9NvP+fRLE2T09Z5wzak9T3a+wWI=;
        b=kXfcDFSYF5z83kQ5vGcJQmbEdW8/OJuDnqEzgx6UnHsXQjJFY14AWJHS+8Vb03RY0m
         /MjQ3W7o5mXhpMLpQdKbgxnx8dluQyEyHzZ4MrOpAJGgx4vZs2aM/SmBvExCMX+SwZeG
         91MtDHPRLJnPImWZFXMpSmxVYCgpls9MvRFSFoVQVFtVfMPxEIu0Sx6VHSa32wEEReTl
         79i2ZLvadUjbs6bFF8j9vTb69whPPaECU88G4preKgpbanTE1zrd7DjDX/yg+mAUuXNT
         I150hTZqpPCWhbem7fSfoLM2JP9MlogPsGnXXzLXQ3957YJ2bWvnxvmiMM4OEdxbH7/Q
         I6kg==
X-Gm-Message-State: AGi0PuaBSAAB3GIYMcrzdn1mTnjmjHoMHhkNgAC3/GvN52f5dMGDjO0G
        VL/pJF26Bd6+eBE3kwXEca4hs0QpxRs=
X-Google-Smtp-Source: APiQypJMPBhc5zXqc4wQyqrE9BqXPAEgiQzGIEkhR0oktipJvjNDbYa4Oo9cXv1nBws8v1M7gKdNKg==
X-Received: by 2002:a63:8048:: with SMTP id j69mr5302542pgd.410.1586318758199;
        Tue, 07 Apr 2020 21:05:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:05:57 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 00/12] ci: replace our Azure Pipeline by GitHub Actions
Date:   Wed,  8 Apr 2020 11:05:31 +0700
Message-Id: <cover.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our Azure Pipeline has served us well over the course of the past year or
so, steadily catching issues before the respective patches hit the next
branch.

There is a GitHub-native CI system now, though, called "GitHub Actions"
[https://github.com/features/actions] which is essentially on par with Azure
Pipelines as far as our needs are concerned, and it brings a couple of
advantages:

 * It is substantially easier to set up than Azure Pipelines: all you need
   is to add the YAML-based build definition, push to your fork on GitHub,
   and that's it.
 * The syntax is a bit easier to read than Azure Pipelines'.
 * We get more concurrent jobs (Azure Pipelines is limited to 10 concurrent
   jobs).

With this change, users also no longer need to open a PR at
https://github.com/git/git or at https://github.com/gitgitgadget/git just to
get the benefit of a CI build.

Sample run on top of dd/ci-musl-libc with dd/test-with-busybox merged:
https://github.com/sgn/git/actions/runs/73179413

Sample run when this series applied into git-for-windows
https://github.com/git-for-windows/git/runs/568625109

Change from v3:
- Use build matrix
- All dependencies are install by scripts
- stop repeating environment variables
- build failure's artifacts will be uploaded


Johannes Schindelin (9):
  ci/lib: if CI type is unknown, show the environment variables
  ci/lib: allow running in GitHub Actions
  ci: fix the `jobname` of the `GETTEXT_POISON` job
  ci: run gem with sudo to install asciidoctor
  README: add a build badge for the GitHub Actions runs
  ci: retire the Azure Pipelines definition
  tests: when run in Bash, annotate test failures with file name/line
    number
  ci: add a problem matcher for GitHub Actions
  ci: let GitHub Actions upload failed tests' directories

Đoàn Trần Công Danh (3):
  ci/lib: set TERM environment variable if not exist
  ci: explicit install all required packages
  ci: configure GitHub Actions for CI/PR

 .github/workflows/main.yml  | 230 +++++++++++++++
 .travis.yml                 |   2 +-
 README.md                   |   2 +-
 azure-pipelines.yml         | 558 ------------------------------------
 ci/git-problem-matcher.json |  16 ++
 ci/install-dependencies.sh  |  16 +-
 ci/lib.sh                   |  31 +-
 ci/print-test-failures.sh   |   7 +
 t/test-lib.sh               |  14 +-
 9 files changed, 310 insertions(+), 566 deletions(-)
 create mode 100644 .github/workflows/main.yml
 delete mode 100644 azure-pipelines.yml
 create mode 100644 ci/git-problem-matcher.json

Range-diff against v3:
 1:  3f9f1c6335 =  1:  2219bf3db9 ci/lib: if CI type is unknown, show the environment variables
 2:  7a4f646bc1 =  2:  2818799a4b ci/lib: allow running in GitHub Actions
 3:  9a03c0844c =  3:  b88586c2c5 ci/lib: set TERM environment variable if not exist
 4:  7308199e24 <  -:  ---------- ci: configure GitHub Actions for CI/PR
 -:  ---------- >  4:  1df60e677c ci: fix the `jobname` of the `GETTEXT_POISON` job
 -:  ---------- >  5:  4f80724641 ci: explicit install all required packages
 -:  ---------- >  6:  795ec656c6 ci: run gem with sudo to install asciidoctor
 -:  ---------- >  7:  ec0aa20119 ci: configure GitHub Actions for CI/PR
 5:  365ba5e831 =  8:  46f2b6bce6 README: add a build badge for the GitHub Actions runs
 6:  53094612d3 !  9:  92f2623dc7 ci: retire the Azure Pipelines definition
    @@ Commit message
         Pipelines would be redundant, and a waste of energy.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    -    [Danh: fix apply conflicts]
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## README.md ##
    @@ azure-pipelines.yml (deleted)
     -      PathtoPublish: t/failed-test-artifacts
     -      ArtifactName: failed-test-artifacts
     -
    --- job: linux_musl
    --  displayName: linux-musl
    --  condition: succeeded()
    --  pool:
    --    vmImage: ubuntu-latest
    --  steps:
    --  - bash: |
    --       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
    --
    --       res=0
    --       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=linux-musl bash -lxc ci/run-docker.sh || res=1
    --
    --       sudo chmod a+r t/out/TEST-*.xml
    --       test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
    --
    --       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
    --       exit $res
    --    displayName: 'jobname=linux-musl ci/run-docker.sh'
    --    env:
    --      GITFILESHAREPWD: $(gitfileshare.pwd)
    --  - task: PublishTestResults@2
    --    displayName: 'Publish Test Results **/TEST-*.xml'
    --    inputs:
    --      mergeTestResults: true
    --      testRunTitle: 'musl'
    --      platform: Linux
    --      publishRunAttachments: false
    --    condition: succeededOrFailed()
    --  - task: PublishBuildArtifacts@1
    --    displayName: 'Publish trash directories of failed tests'
    --    condition: failed()
    --    inputs:
    --      PathtoPublish: t/failed-test-artifacts
    --      ArtifactName: failed-test-artifacts
    --
     -- job: static_analysis
     -  displayName: StaticAnalysis
     -  condition: succeeded()
 -:  ---------- > 10:  f688fa50d3 tests: when run in Bash, annotate test failures with file name/line number
 -:  ---------- > 11:  715d1f732f ci: add a problem matcher for GitHub Actions
 -:  ---------- > 12:  0908d5ab9b ci: let GitHub Actions upload failed tests' directories
-- 
2.26.0.334.g6536db25bb

