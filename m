Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78946C2BB1D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F91220936
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGNg0A/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDJRSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:36 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:47084 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgDJRSg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:36 -0400
Received: by mail-pg1-f177.google.com with SMTP id k191so1214142pgc.13
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SHU+f0PNij2KkX/foPQZWZKtAVqUl5kprEG8nMqMe8=;
        b=XGNg0A/EcBQuR8IQ30ZAA7tlSo2KIhwWfRaRVkXnd0UPByRwXJr3UffOWBzpTW9aWV
         sqxuavebHPc2zxFy+0fAEi6KmL8gFM0MOijo6ryojrbk3XrPFButX5DAjcotljdk0JNU
         jbVF403DFONvHECJJQTImxsVbP4eXhbw4VlOt3r4tgTHTiFWfNqthB969RJpu9/3L1Jg
         aSO8XhpdQyQtplDAUekxtoGxfsA0fakdQv5rDIFrj7HbUyEo5963cn89Z0t9MBbNy8YE
         Qa7/1EXDqyrzmLxgcNDRgmwnAQ8FRD4EToeVuDjtD1akvmOvTbxC6b1A6S1fxofNc3NU
         km5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SHU+f0PNij2KkX/foPQZWZKtAVqUl5kprEG8nMqMe8=;
        b=fxyrHV4TPa6zDcUFOvjPhiiac56pp0ke0Xt+CJ61UA+RbRVN21sviDMqF8xowqdRRk
         /ZJctiQdTq1EP2vKdox4NR3j3eSTXisE8th4+qiLsogMoB1Ldla7WDt5QzcahRZwI1IE
         67tRUaOxoV8qzRp0mp6s9uoxdLOg9r+j0zqrRAqpsFppVVBvpxsN8Tw56WPR2r6UgHvj
         L39CHv0H6zFMXh866C8bHGxnNDPgS4RT0Cl8eamjm0Qbx6LUyq7NyP3EZzhikYiDdX1B
         CAFOmG7dPAal2XKqn8MzzkP37rvT9rB5pCmBu+NjYeGc2TYCm9+vTH4QuQNcTyKFCDq2
         aToA==
X-Gm-Message-State: AGi0PubGcUXuMrl6JlH2hwwzSG2xDr15TQAyZw5LOrRI/BUYlqcvj4Rj
        8/5NB75iN/dXKZrvXMdSM3ejm5de
X-Google-Smtp-Source: APiQypKXtn5rYtUguLXhNmwJRCpg2dzpmAnPk9z9eQOh9FdZVe2at3Yrv0GcQy4YVhi8vxt8gSH1Gw==
X-Received: by 2002:a63:5853:: with SMTP id i19mr5111261pgm.288.1586539113156;
        Fri, 10 Apr 2020 10:18:33 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:32 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 07/12] ci: configure GitHub Actions for CI/PR
Date:   Sat, 11 Apr 2020 00:18:09 +0700
Message-Id: <40fe4f7e2c34c6997a6824ef0dc6aad7a71a4434.1586538752.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586538752.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586538752.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds CI builds via GitHub Actions. While the underlying
technology is at least _very_ similar to that of Azure Pipelines, GitHub
Actions are much easier to set up than Azure Pipelines:

- no need to install a GitHub App,

- no need to set up an Azure DevOps account,

- all you need to do is push to your fork on GitHub.

Therefore, it makes a lot of sense for us to have a working GitHub
Actions setup.

While copy/editing `azure-pipelines.yml` into
`.github/workflows/main.yml`, we also use the opportunity to accelerate
the step that sets up a minimal subset of Git for Windows' SDK in the
Windows-build job:

- we now download a `.tar.xz` stored in Azure Blobs and extract it
  simultaneously by calling `curl` and piping the result to `tar`,

- decompressing via `xz`,

- all three utilities are installed together with Git for Windows

At the same time, we also make use of the matrix build feature, which
reduces the amount of repeated text by quite a bit.

Also, we do away with the parts that try to mount a file share on which
`prove` can store data between runs. It is just too complicated to set
up, and most times the tree changes anyway, so there is little return on
investment there.

Initial-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml | 212 +++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 .github/workflows/main.yml

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
new file mode 100644
index 0000000000..e1ac6d23b4
--- /dev/null
+++ b/.github/workflows/main.yml
@@ -0,0 +1,212 @@
+name: CI/PR
+
+on: [push, pull_request]
+
+env:
+  DEVELOPER: 1
+
+jobs:
+  windows-build:
+    runs-on: windows-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: download git-sdk-64-minimal
+      shell: bash
+      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+    - name: build
+      shell: powershell
+      env:
+        HOME: ${{runner.workspace}}
+        MSYSTEM: MINGW64
+        NO_PERL: 1
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+        printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
+
+          ci/make-test-artifacts.sh artifacts
+        "@
+    - name: upload build artifacts
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
+    - name: download git-sdk-64-minimal
+      shell: bash
+      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+    - name: download build artifacts
+      uses: actions/download-artifact@v1
+      with:
+        name: windows-artifacts
+        path: ${{github.workspace}}
+    - name: extract build artifacts
+      shell: bash
+      run: tar xf artifacts.tar.gz
+    - name: test
+      shell: powershell
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+          # Let Git ignore the SDK
+          printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
+
+          ci/run-test-slice.sh ${{matrix.nr}} 10
+        "@
+    - name: ci/print-test-failures.sh
+      if: failure()
+      shell: powershell
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc ci/print-test-failures.sh
+  vs-build:
+    env:
+      MSYSTEM: MINGW64
+      NO_PERL: 1
+      GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
+    runs-on: windows-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: download git-sdk-64-minimal
+      shell: bash
+      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+    - name: generate Visual Studio solution
+      shell: powershell
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+          make NDEBUG=1 DEVELOPER=1 vcxproj
+        "@
+        if (!$?) { exit(1) }
+    - name: download vcpkg artifacts
+      shell: powershell
+      run: |
+        $urlbase = "https://dev.azure.com/git/git/_apis/build/builds"
+        $id = ((Invoke-WebRequest -UseBasicParsing "${urlbase}?definitions=9&statusFilter=completed&resultFilter=succeeded&`$top=1").content | ConvertFrom-JSON).value[0].id
+        $downloadUrl = ((Invoke-WebRequest -UseBasicParsing "${urlbase}/$id/artifacts").content | ConvertFrom-JSON).value[0].resource.downloadUrl
+        (New-Object Net.WebClient).DownloadFile($downloadUrl, "compat.zip")
+        Expand-Archive compat.zip -DestinationPath . -Force
+        Remove-Item compat.zip
+    - name: add msbuild to PATH
+      uses: microsoft/setup-msbuild@v1.0.0
+    - name: MSBuild
+      run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
+    - name: bundle artifact tar
+      shell: powershell
+      env:
+        MSVC: 1
+        VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
+      run: |
+        & compat\vcbuild\vcpkg_copy_dlls.bat release
+        if (!$?) { exit(1) }
+        & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+          mkdir -p artifacts &&
+          eval \"`$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)\"
+        "@
+    - name: upload build artifacts
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
+    - name: download git-64-portable
+      shell: bash
+      run: a=git-64-portable && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+    - name: download build artifacts
+      uses: actions/download-artifact@v1
+      with:
+        name: vs-artifacts
+        path: ${{github.workspace}}
+    - name: extract build artifacts
+      shell: bash
+      run: tar xf artifacts.tar.gz
+    - name: test (parallel)
+      shell: powershell
+      env:
+        MSYSTEM: MINGW64
+        NO_SVN_TESTS: 1
+        GIT_TEST_SKIP_REBASE_P: 1
+      run: |
+        & git-64-portable\git-cmd.exe --command=usr\bin\bash.exe -lc @"
+          # Let Git ignore the SDK and the test-cache
+          printf '%s\n' /git-64-portable/ /test-cache/ >>.git/info/exclude
+
+          cd t &&
+          PATH=\"`$PWD/helper:`$PATH\" &&
+          test-tool.exe run-command testsuite --jobs=10 -V -x --write-junit-xml \
+                  `$(test-tool.exe path-utils slice-tests \
+                          ${{matrix.nr}} 10 t[0-9]*.sh)
+        "@
+  regular:
+    strategy:
+      matrix:
+        vector:
+          - jobname: linux-clang
+            cc: clang
+            pool: ubuntu-latest
+          - jobname: linux-gcc
+            cc: gcc
+            pool: ubuntu-latest
+          - jobname: osx-clang
+            cc: clang
+            pool: macos-latest
+          - jobname: osx-gcc
+            cc: gcc
+            pool: macos-latest
+          - jobname: GETTEXT_POISON
+            cc: gcc
+            pool: ubuntu-latest
+    env:
+      CC: ${{matrix.vector.cc}}
+      jobname: ${{matrix.vector.jobname}}
+    runs-on: ${{matrix.vector.pool}}
+    steps:
+    - uses: actions/checkout@v1
+    - run: ci/install-dependencies.sh
+    - run: ci/run-build-and-tests.sh
+    - run: ci/print-test-failures.sh
+      if: failure()
+  dockerized:
+    strategy:
+      matrix:
+        vector:
+        - jobname: linux-musl
+          image: alpine
+        - jobname: Linux32
+          image: daald/ubuntu32:xenial
+    env:
+      jobname: ${{matrix.vector.jobname}}
+    runs-on: ubuntu-latest
+    container: ${{matrix.vector.image}}
+    steps:
+    - uses: actions/checkout@v1
+    - run: ci/install-docker-dependencies.sh
+    - run: ci/run-build-and-tests.sh
+    - run: ci/print-test-failures.sh
+      if: failure()
+  static-analysis:
+    env:
+      jobname: StaticAnalysis
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - run: ci/install-dependencies.sh
+    - run: ci/run-static-analysis.sh
+  documentation:
+    env:
+      jobname: Documentation
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - run: ci/install-dependencies.sh
+    - run: ci/test-documentation.sh
-- 
2.26.0.334.g6536db25bb

