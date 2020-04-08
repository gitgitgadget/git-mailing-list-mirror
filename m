Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5D5C2BA2B
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B091D20747
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTVVcE1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgDHEGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:11 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34097 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgDHEGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:11 -0400
Received: by mail-pl1-f173.google.com with SMTP id a23so2066570plm.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SHU+f0PNij2KkX/foPQZWZKtAVqUl5kprEG8nMqMe8=;
        b=RTVVcE1/P+cnQpAARUnOow2PsBGzA4t9QbfP7rNcCvRgtbQW0cGELTxQvyypmzNHkN
         cMEiriKhO2pUmvZlREtEJGBfsI/58AQAjcYTW5jPGpqk/xwibBc5xr3MbktsALqrk58k
         sTuStMFO4ifASKjORnpUFNSCMlZ6e/J6VyRE7+B9+9DlRjJ678DIJENyC44e11YbF3ZI
         pkyzqmCygagsFOMFEeJ/QMG58VA7c4Nt9/sNLBdnLN66mWFP9xIydjU5e0UPdFmhBzwd
         c2+X2ISZYyo3QrkoMmdXeLbtR+5uTES6Uf65jKiX1pWgfiMYjmki1TwYdPK6cYd0v7+o
         u9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SHU+f0PNij2KkX/foPQZWZKtAVqUl5kprEG8nMqMe8=;
        b=fKMLp95gcmozxTphNstBCvEgo9oJKvMhrkbjArfDpETUmJtXu9q/eTkc+d9I/YLRvp
         FoQ/askyyOfVEe2FKG9+wvTHp4jbYBhUisdsGZiqSH2IQt9ZlI+zvAX9w7RIvL/iHNdy
         rfmG3PpvD5lFcbDGhv4ETUC/tlvZU6dGOrYePh/E+x+qR1vn7O4cGwtzr3BWLEL4esJ4
         PrgcZBLRXjpMWcFjHHPESLHq1JbtNuFxrVWbg5fNQlrQUcAVBXFE+YQgO91REOFvBeRc
         lhPYR4TC/vEWhJb3khAE1qS9NkUQhjPqz1V//8LNm54/P96QA7Z7/W+X7xqkjin0W4SX
         g/9A==
X-Gm-Message-State: AGi0Puabe+2LU7th7oVveGhkD0mz/GlieBzo1lJq6Lgnm3I+re3VS7Pw
        g2Egxc/AP1nY4UTfEHQkN0gKOFshbpk=
X-Google-Smtp-Source: APiQypJM3eHmCUQoaYn2a+eRP4m4FhQ0ONsdivi+ipGH+uEgCurMMMZwBHE81ebtzmhETJrxl7OBiw==
X-Received: by 2002:a17:90b:3656:: with SMTP id nh22mr2974335pjb.71.1586318769616;
        Tue, 07 Apr 2020 21:06:09 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:09 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 07/12] ci: configure GitHub Actions for CI/PR
Date:   Wed,  8 Apr 2020 11:05:38 +0700
Message-Id: <ec0aa201195358ef9312011350b1a1c365fd1cad.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
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

