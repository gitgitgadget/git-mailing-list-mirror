Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84259C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B24720719
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTds+CPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgDBNRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:17:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43614 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbgDBNRY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:17:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id g20so1815877pgk.10
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LrSpQY4bl0w7ZvTT+cAkYdOkLioAS141mlfgxzh3VwU=;
        b=CTds+CPKzNWWEhylEbDiC0ecHTRq2Wz8g1Nx7fO/iYhnAhcKXn7wRo0v8puxoXcSu6
         N3MWJph2W+AaJHXkmc7bMraKvsjiq+BdWaJyJ9uRfbEGnWwVTRxxIbEjDWsB9IacsgqT
         Fdy0Yn/nibQ8vuA4lS+T/1nfd54ATRTs7Xrzpy8x7+k8LkjtvJ4MecwdbGcxrhjUPPt/
         l12rDjJeCBj6f2yZ+O0wwhZjIkpMXzUlHKKWTxOX8tF3gkplOHxgzL8WISzT3F7yVkTK
         OxYnsieOI2OfwhQXdEvrNBMNe2xNeqOOS6knP8ux3THskzfR8f3OW8Ne58K2kOUWN3xO
         PlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrSpQY4bl0w7ZvTT+cAkYdOkLioAS141mlfgxzh3VwU=;
        b=Jp9Vsxw1/m/F20N2FVXCKg7M3pohby3rjuY++QFhdQKXps49p2IGbTj6JkTczdoUVo
         yStAshTe9isWYXfZNj0sP3Vlnm3Pd3G2DjQey4N0N2S+AdI+q94YBzNnKeDeii9oGghi
         Vg1Te3n2aqjcTv+gbxFqmnfQ7ay4bR1y4U/bfB8nvWyg9dQ52yrvyGmKqPDsc6w7W9oc
         GpBdAs3g1o5mNzboahZZVTeOMCt9wURARQZR2tIGJMwLa1VUSv382WauFEiJV1Z2CZry
         /FKN6i7pV5IhmcJk8zF7F1nhVipna3QwV3Rf7GZoXSH5IgayYwTulKyr1o2+MLH8DpNE
         E6+A==
X-Gm-Message-State: AGi0Pua0rOSXq8iAS11syHTHa5YVdlvmyQ56yISXLuGhqg2mKh/Y1qcB
        2TIoSQjMgL2YJ8QTh15om4DX5ZUQ
X-Google-Smtp-Source: APiQypLw92yH0tNJqSnlC7N1iZxy0haZbN/jh/7sdlngrF+UhVDwCptQyTwwV4U4L5U4yJ2a3iqdVQ==
X-Received: by 2002:a63:2a97:: with SMTP id q145mr3266402pgq.22.1585833441192;
        Thu, 02 Apr 2020 06:17:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id g18sm3350711pgh.42.2020.04.02.06.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:17:20 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 0/6] ci: replace our Azure Pipeline by GitHub Actions
Date:   Thu,  2 Apr 2020 20:16:54 +0700
Message-Id: <cover.1585832999.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585756350.git.congdanhqx@gmail.com>
References: <cover.1585756350.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on work started by Dscho,
I started to work with this series since there're merge conflicts
with my series at dd/ci-musl-lib, and Dscho said he was busy for a while.

Changes from v3:
* Base on v3 of dd/ci-musl-libc (submited)
* linux32 and linux-musl jobs' structure is the same with linux-gcc and
  linux-clang, they will be run inside container instead of vm:
  + they will install dependencies in separate step by common script
  + they will run ci/run-build-and-tests
* StaticAnalysis job will use ci/install-dependencies to install

Changes in v2 frome Dscho's version:
* Based on dd/ci-musl-libc
* Move artifact extraction out of Test phase of windows-test
* Move ci/print-test-failures.sh out of build-and-test phase
* set TERM environment variable if not exist
* add linux-musl job
* v1 doesn't report failure on linux32, fixed
* run linux32 directly inside container
* install development file of curl in documentation job because "curl-config"
  will be called in pu's Makefile
  + Other approach could be call make CURL_CONFIG=: in test-documentation.sh

Sample run without busybox fix:
https://github.com/sgn/git/actions/runs/69030441

Merged into old pu:
https://github.com/sgn/git/actions/runs/69048780

Johannes Schindelin (4):
  ci/lib: if CI type is unknown, show the environment variables
  ci/lib: allow running in GitHub Actions
  README: add a build badge for the GitHub Actions runs
  ci: retire the Azure Pipelines definition

Đoàn Trần Công Danh (2):
  ci/lib: set TERM environment variable if not exist
  ci: configure GitHub Actions for CI/PR

 .github/workflows/main.yml | 314 ++++++++++++++++++++
 README.md                  |   2 +-
 azure-pipelines.yml        | 593 -------------------------------------
 ci/lib.sh                  |  24 +-
 4 files changed, 338 insertions(+), 595 deletions(-)
 create mode 100644 .github/workflows/main.yml
 delete mode 100644 azure-pipelines.yml

Range-diff against v2:
1:  4cc17cfe43 = 1:  3f9f1c6335 ci/lib: if CI type is unknown, show the environment variables
2:  e7e52d5d4c = 2:  7a4f646bc1 ci/lib: allow running in GitHub Actions
3:  043f6be3ee = 3:  9a03c0844c ci/lib: set TERM environment variable if not exist
4:  834b0f73b0 ! 4:  7308199e24 ci: configure GitHub Actions for CI/PR
    @@ .github/workflows/main.yml (new)
     +    container: alpine
     +    steps:
     +    - uses: actions/checkout@v1
    -+    - name: install additional dependencies
    -+      run: apk add --update ncurses perl-utils
    -+    - name: prepare /usr/src/git
    -+      run: |
    -+        mkdir -p /usr/src &&
    -+        rm -rf /usr/src/git &&
    -+        ln -sf $(pwd) /usr/src/git
    -+    - name: ci/run-alpine-build.sh
    -+      run: ci/run-alpine-build.sh $(id -u)
    ++    - name: install dependencies
    ++      env:
    ++        jobname: linux-musl
    ++      run: ci/install-docker-dependencies.sh
    ++    - name: ci/run-build-and-tests.sh
    ++      env:
    ++        jobname: linux-musl
    ++      run: ci/run-build-and-tests.sh
     +    - name: ci/print-test-failures.sh
     +      if: failure()
     +      run: ci/print-test-failures.sh
    @@ .github/workflows/main.yml (new)
     +    container: daald/ubuntu32:xenial
     +    steps:
     +    - uses: actions/checkout@v1
    -+    - name: prepare /usr/src/git
    -+      run:
    -+        mkdir -p /usr/src &&
    -+        rm -rf /usr/src/git &&
    -+        ln -sf $(pwd) /usr/src/git
    -+    - name: ci/run-linux32-build.sh
    -+      run: ci/run-linux32-build.sh $(id -u)
    ++    - name: install dependencies
    ++      env:
    ++        jobname: Linux32
    ++      run: ci/install-docker-dependencies.sh
    ++    - name: ci/run-build-and-tests.sh
    ++      env:
    ++        jobname: Linux32
    ++      run: ci/run-build-and-tests.sh
     +    - name: ci/print-test-failures.sh
     +      if: failure()
     +      run: ci/print-test-failures.sh
    @@ .github/workflows/main.yml (new)
     +    steps:
     +    - uses: actions/checkout@v1
     +    - name: install dependencies
    -+      run: |
    -+        sudo apt-get update &&
    -+        sudo apt-get install -y coccinelle libcurl4-openssl-dev libssl-dev libexpat-dev gettext
    ++      env:
    ++        jobname: StaticAnalysis
    ++      run: ci/install-dependencies.sh
     +    - name: ci/run-static-analysis.sh
     +      env:
     +        jobname: StaticAnalysis
5:  0d14645c32 = 5:  365ba5e831 README: add a build badge for the GitHub Actions runs
6:  87abc123b0 = 6:  53094612d3 ci: retire the Azure Pipelines definition
-- 
2.26.0.334.g6536db25bb

