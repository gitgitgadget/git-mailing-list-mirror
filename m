Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90C3C2D0F0
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AACB20848
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW0l5rny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgCaMso (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:48:44 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:43855 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbgCaMsm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 08:48:42 -0400
Received: by mail-ed1-f48.google.com with SMTP id bd14so24896243edb.10
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FTVK0QpZ0ksBZRoFKFADzS7qf3fXAoNTOCDwmRfMF8Y=;
        b=gW0l5rny8uznyBHuTnXRBxOVi4piVTrOcQVn4K4VxjxkgFeGsIDpjhRaB9NtaEgKFa
         Mm+rwAQxEnGFUd6Bho/GmZnRXbFmFb97zKUbWG8DN3lH100rNsWOw3dsTZGGhaCReDZ6
         DslkaW5PRJbLblnLn8YMPUImju6zkyPvv4I99583XBWmz7IDTDcktrJDZGEBsVZT83zi
         UMrEHaF0pYn3vwZEDg6fqCkbWThAw1qjjXYwh0vPfqP8wfW9K9NQyZLcLYtMtziu1c57
         YXPMcmGuSEzoVkcB5HmYf3DSVHFpO1KP0GjRnhUEmprDBs0aXs0hAveje3cLL0/GNuD0
         quYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FTVK0QpZ0ksBZRoFKFADzS7qf3fXAoNTOCDwmRfMF8Y=;
        b=Lvl0ROJ1sSmBW6eNBts/l88bnRrzIH+NYLpKpjHWcw2ynib3FIEerJ1mvHQ3DYyZjB
         tdDjPBai+sLDrEOsCZZ3IuLDWn+oYGh00g7mxWGb1HJiEThpzYTLN/A3CI0axe4kxTcr
         jLvdydSv0eEMQFHuvVjxi2XiBZwIymn+HKDI50Ft6+NRkkiHHvUGd6n3lBd9OEAES8OC
         gTOjmSKGFpxySdOcVPnAbJYX0jIfToFw4paULxggt9Pt23lly5rs6OOm228uwaHiYqSO
         goYmOhAIeyTYmVxC1XS/3gTQ1K+5dlqj/i8mGch8Y6dseoBy2rjIRRZelg2xeBpP35bo
         kE4Q==
X-Gm-Message-State: ANhLgQ3+85MN76dAHLQ3REHqDEIUXBl31AvKM/joGzKY0+XQFOQKMBue
        GQKItGdINluXS/XBe4N9YXFfN95q
X-Google-Smtp-Source: ADFU+vsH2JmsT850e/5wuuy1xf6WflrqyOG+bt3Bvd4nMaXejcuffe1ZyJmqpa18KWGHX+CrKJQu/w==
X-Received: by 2002:a17:906:3443:: with SMTP id d3mr3760854ejb.18.1585658916560;
        Tue, 31 Mar 2020 05:48:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p34sm2305328edb.63.2020.03.31.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:48:36 -0700 (PDT)
Message-Id: <36621bdd31a53046450f73ed197585469b1a1b96.1585658913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Mar 2020 12:48:31 +0000
Subject: [PATCH 3/5] ci: configure GitHub Actions for CI/PR
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch adds CI builds via GitHub Actions. While the underlying
technology is at least _very_ similar to that of Azure Pipelines, GitHub
Actions are much easier to set up than Azure Pipelines: no need to
install a GitHub App, no need to set up an Azure DevOps account, all you
need to do is push to your fork on GitHub.

Therefore, it makes a lot of sense for us to have a working GitHub
Actions setup.

While transmogrifying `azure-pipelines.yml` into
`.github/workflows/main.yml`, we also use the opportunity to accelerate
the step that sets up a minimal subset of Git for Windows' SDK in the
Windows-build job: we now download a `.tar.xz` stored in Azure Blobs and
extract it simultaneously (by calling `curl` and piping the result to
`tar`, decompressing via `xz`, all three utilities being available by
grace of using Git for Windows' Bash that is installed on the build
agents). This accelerates that step from ~1m50s to ~7s.

Also, we do away with the parts that try to mount a file share on which
`prove` can store data between runs. It is just too complicated to set
up, so it's little return on investment there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 271 +++++++++++++++++++++++++++++++++++++
 1 file changed, 271 insertions(+)
 create mode 100644 .github/workflows/main.yml

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
new file mode 100644
index 00000000000..14025c8a7eb
--- /dev/null
+++ b/.github/workflows/main.yml
@@ -0,0 +1,271 @@
+name: CI/PR
+
+on: [push, pull_request]
+
+jobs:
+  windows-build:
+    runs-on: windows-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: Download git-sdk-64-minimal
+      shell: bash
+      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+    - name: Build
+      shell: powershell
+      env:
+        HOME: ${{runner.workspace}}
+        MSYSTEM: MINGW64
+        DEVELOPER: 1
+        NO_PERL: 1
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+        printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
+
+          ci/make-test-artifacts.sh artifacts
+        "@
+        if (!$?) { exit(1) }
+    - name: Upload build artifacts
+      uses: actions/upload-artifact@v1
+      with:
+        name: windows-artifacts
+        path: artifacts
+  windows-test:
+    runs-on: windows-latest
+    needs: [windows-build]
+    strategy:
+      matrix:
+        nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
+    steps:
+    - uses: actions/checkout@v1
+    - name: Download git-sdk-64-minimal
+      shell: bash
+      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+    - name: Download build artifacts
+      uses: actions/download-artifact@v1
+      with:
+        name: windows-artifacts
+        path: ${{github.workspace}}
+    - name: Test
+      shell: powershell
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+          test -f artifacts.tar.gz || {
+            echo No test artifacts found\; skipping >&2
+            exit 0
+          }
+          tar xf artifacts.tar.gz || exit 1
+
+          # Let Git ignore the SDK
+          printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
+
+          ci/run-test-slice.sh ${{matrix.nr}} 10 || {
+            ci/print-test-failures.sh
+            exit 1
+          }
+        "@
+        if (!$?) { exit(1) }
+  vs-build:
+    runs-on: windows-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: Download git-sdk-64-minimal
+      shell: bash
+      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+    - name: Generate Visual Studio Solution
+      shell: powershell
+      env:
+        MSYSTEM: MINGW64
+        DEVELOPER: 1
+        NO_PERL: 1
+        GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+          make NDEBUG=1 DEVELOPER=1 vcxproj
+        "@
+        if (!$?) { exit(1) }
+    - name: Download vcpkg artifacts
+      shell: powershell
+      run: |
+        $urlbase = "https://dev.azure.com/git/git/_apis/build/builds"
+        $id = ((Invoke-WebRequest -UseBasicParsing "${urlbase}?definitions=9&statusFilter=completed&resultFilter=succeeded&`$top=1").content | ConvertFrom-JSON).value[0].id
+        $downloadUrl = ((Invoke-WebRequest -UseBasicParsing "${urlbase}/$id/artifacts").content | ConvertFrom-JSON).value[0].resource.downloadUrl
+        (New-Object Net.WebClient).DownloadFile($downloadUrl, "compat.zip")
+        Expand-Archive compat.zip -DestinationPath . -Force
+        Remove-Item compat.zip
+    - name: Add msbuild to PATH
+      uses: microsoft/setup-msbuild@v1.0.0
+    - name: MSBuild
+      run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
+    - name: Bundle artifact tar
+      shell: powershell
+      env:
+        MSYSTEM: MINGW64
+        DEVELOPER: 1
+        NO_PERL: 1
+        MSVC: 1
+        VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
+      run: |
+        & compat\vcbuild\vcpkg_copy_dlls.bat release
+        if (!$?) { exit(1) }
+        & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+          mkdir -p artifacts &&
+          eval \"`$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)\"
+        "@
+        if (!$?) { exit(1) }
+    - name: Upload build artifacts
+      uses: actions/upload-artifact@v1
+      with:
+        name: vs-artifacts
+        path: artifacts
+  vs-test:
+    runs-on: windows-latest
+    needs: [vs-build]
+    strategy:
+      matrix:
+        nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
+    steps:
+    - uses: actions/checkout@v1
+    - name: Download git-64-portable
+      shell: bash
+      run: a=git-64-portable && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+    - name: Download build artifacts
+      uses: actions/download-artifact@v1
+      with:
+        name: vs-artifacts
+        path: ${{github.workspace}}
+    - name: Test (parallel)
+      shell: powershell
+      env:
+        MSYSTEM: MINGW64
+        NO_SVN_TESTS: 1
+        GIT_TEST_SKIP_REBASE_P: 1
+      run: |
+        & git-64-portable\git-cmd.exe --command=usr\bin\bash.exe -lc @"
+          test -f artifacts.tar.gz || {
+            echo No test artifacts found\; skipping >&2
+            exit 0
+          }
+          tar xf artifacts.tar.gz || exit 1
+
+          # Let Git ignore the SDK and the test-cache
+          printf '%s\n' /git-64-portable/ /test-cache/ >>.git/info/exclude
+
+          cd t &&
+          PATH=\"`$PWD/helper:`$PATH\" &&
+          test-tool.exe run-command testsuite --jobs=10 -V -x --write-junit-xml \
+                  `$(test-tool.exe path-utils slice-tests \
+                          ${{matrix.nr}} 10 t[0-9]*.sh)
+        "@
+        if (!$?) { exit(1) }
+  linux-clang:
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      env:
+        CC: clang
+      run: |
+        sudo apt-get update &&
+        sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin &&
+        ci/install-dependencies.sh
+    - name: ci/run-build-and-test.sh
+      env:
+        CC: clang
+      run: |
+        ci/run-build-and-tests.sh || {
+          ci/print-test-failures.sh
+          exit 1
+        }
+  linux-gcc:
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      run: |
+        sudo add-apt-repository ppa:ubuntu-toolchain-r/test &&
+        sudo apt-get update &&
+        sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2 language-pack-is git-svn gcc-8 &&
+        ci/install-dependencies.sh
+    - name: ci/run-build-and-tests.sh
+      run: |
+        ci/run-build-and-tests.sh || {
+          ci/print-test-failures.sh
+          exit 1
+        }
+  osx-clang:
+    runs-on: macos-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      env:
+        CC: clang
+      run: ci/install-dependencies.sh
+    - name: ci/run-build-and-tests.sh
+      env:
+        CC: clang
+      run: |
+        ci/run-build-and-tests.sh || {
+          ci/print-test-failures.sh
+          exit 1
+        }
+  osx-gcc:
+    runs-on: macos-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      run: ci/install-dependencies.sh
+    - name: ci/run-build-and-tests.sh
+      run: |
+        ci/run-build-and-tests.sh || {
+          ci/print-test-failures.sh
+          exit 1
+        }
+  GETTEXT_POISON:
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      run: |
+        sudo apt-get update &&
+        sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev
+    - name: ci/run-build-and-tests.sh
+      env:
+        jobname: GETTEXT_POISON
+      run: |
+        ci/run-build-and-tests.sh || {
+          ci/print-test-failures.sh
+          exit 1
+        }
+  linux32:
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: ci/run-linux32-docker.sh
+      run: |
+        res=0
+        sudo GITHUB_ACTIONS="$GITHUB_ACTIONS" RUNNER_OS="$RUNNER_OS" GITHUB_REF="$GITHUB_REF" GITHUB_SHA="$GITHUB_SHA" GITHUB_REPOSITORY="$GITHUB_REPOSITORY" GITHUB_RUN_ID="$GITHUB_RUN_ID" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
+  static-analysis:
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      run: |
+        sudo apt-get update &&
+        sudo apt-get install -y coccinelle libcurl4-openssl-dev libssl-dev libexpat-dev gettext
+    - name: ci/run-static-analysis.sh
+      env:
+        jobname: StaticAnalysis
+      run: ci/run-static-analysis.sh
+  documentation:
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      run: |
+        sudo apt-get update &&
+        sudo apt-get install -y asciidoc xmlto asciidoctor docbook-xsl-ns
+    - name: ci/test-documentation.sh
+      env:
+        ALREADY_HAVE_ASCIIDOCTOR: yes.
+        jobname: Documentation
+      run: ci/test-documentation.sh
-- 
gitgitgadget

