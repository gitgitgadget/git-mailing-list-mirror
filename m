Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9666EC2D0F3
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610632078C
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxQJmV+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbgDBNRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:17:37 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:32799 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbgDBNRg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:17:36 -0400
Received: by mail-pg1-f177.google.com with SMTP id d17so1841602pgo.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2VPZYCTLMuCN+BaIlTWax7boDhXN+VhhyNq7tQQATs=;
        b=KxQJmV+AbP8GkfJfNDXxkVpLi+lcQTFMx8aM+6X08gttVuBteVu5zK3agv6QfxZXAT
         JM2v42jBCCUadvX7LcmoaZ+/dcb7DfAcqQfWAbFsFhyzCl64Q9RttW4MgQ5YMd5mIId7
         OC1jLy6ijj96zGfQeXA/axV7JHlM1pIOQmC+SjDFnP1PbNl9KHUZ4rTUDoutGyINbSq1
         p5se2TJen/QnEDi88sLM52q+xjJi9R1bGC4eZk5itBIU0PopUMxi5t/06HDhhO41l44M
         Cq/QddCDOXl3t/fWK8KoAWJ1f0IAxHIZT04t1ZAJ8KggYInFRRPkZTWXm7IT6hwLVlNq
         F5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2VPZYCTLMuCN+BaIlTWax7boDhXN+VhhyNq7tQQATs=;
        b=IS597jbCKV6nbAEU47OPFSXRiejnhymTKMp9ZKilihvtf6P4y9/90oVgR0koerEyt1
         B0eljJ7w+Tu9cGFmUgO7J0Itgud3xpTHqaLVJzDuGv7ltINilc3+Y8a9quvz8nbJ4bLk
         fUx7tgE+VhW2+IdAO07uGHNlPHwRiFm3aIxfwSmq41nG2bAsofp+yBQks6QZQD29GNaO
         aiTjMxQCwIARIUSqEBGmiolrQAJAqhmHrt01SnF5n3mDY5SYEht5OgnhyHXGBtcLosa+
         qhlx1IIuMnJk+i/6nZs0lev/g8Mp4F6rUin7tH94FF4CxyKntvmKbQd1y6WPRIMQn/F9
         pQDQ==
X-Gm-Message-State: AGi0PuagluwkxUaNEB7lYdF5P69MYfcwsxbsK6ZmSeWjNAztuZCtVzH6
        F+47DQYO+ris5Ly+I0CXWQ6aE8rH
X-Google-Smtp-Source: APiQypLWERI2pRZyGAnHRl52L8wYkJb5VVOogZRy2B+Haqvt5FxQvxMhrpYXIpTxXIfsA6O7NL1uKg==
X-Received: by 2002:a63:ef04:: with SMTP id u4mr3298714pgh.292.1585833452512;
        Thu, 02 Apr 2020 06:17:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id g18sm3350711pgh.42.2020.04.02.06.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:17:32 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 4/6] ci: configure GitHub Actions for CI/PR
Date:   Thu,  2 Apr 2020 20:16:58 +0700
Message-Id: <7308199e244bdfca77370c6607630ab530e00ede.1585832999.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585832999.git.congdanhqx@gmail.com>
References: <cover.1585756350.git.congdanhqx@gmail.com> <cover.1585832999.git.congdanhqx@gmail.com>
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

While translate-and-modify `azure-pipelines.yml` into
`.github/workflows/main.yml`, we also use the opportunity to accelerate
the step that sets up a minimal subset of Git for Windows' SDK in the
Windows-build job:
- we now download a `.tar.xz` stored in Azure Blobs and extract it
simultaneously (by calling `curl` and piping the result to `tar`,
- decompressing via `xz`,
- all three utilities are installed together with Git for Windows

Also, we do away with the parts that try to mount a file share on which
`prove` can store data between runs. It is just too complicated to set
up, so it's little return on investment there.

Based-on-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml | 314 +++++++++++++++++++++++++++++++++++++
 1 file changed, 314 insertions(+)
 create mode 100644 .github/workflows/main.yml

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
new file mode 100644
index 0000000000..084550bf53
--- /dev/null
+++ b/.github/workflows/main.yml
@@ -0,0 +1,314 @@
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
+    - name: extract artifact
+      shell: powershell
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+          test -f artifacts.tar.gz || {
+            echo No test artifacts found\; skipping >&2
+            exit 0
+          }
+          tar xf artifacts.tar.gz
+        "@
+        if (!$?) { exit(1) }
+    - name: Test
+      shell: powershell
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+          # Let Git ignore the SDK
+          printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
+
+          ci/run-test-slice.sh ${{matrix.nr}} 10
+        "@
+        if (!$?) { exit(1) }
+    - name: ci/print-test-failures.sh
+      if: failure()
+      shell: powershell
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc ci/print-test-failures.sh
+        exit(1)
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
+      run: ci/run-build-and-tests.sh
+    - name: ci/print-test-failures.sh
+      if: failure()
+      env:
+        CC: clang
+      run: |
+        ci/print-test-failures.sh
+        exit 1
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
+      run: ci/run-build-and-tests.sh
+    - name: ci/print-test-failures.sh
+      if: failure()
+      run: |
+        ci/print-test-failures.sh
+        exit 1
+  osx-clang:
+    runs-on: macos-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      env:
+        CC: clang
+      run: ci/install-dependencies.sh
+    - name: ci/run-build-and-test.sh
+      env:
+        CC: clang
+      run: ci/run-build-and-tests.sh
+    - name: ci/print-test-failures.sh
+      if: failure()
+      env:
+        CC: clang
+      run: |
+        ci/print-test-failures.sh
+        exit 1
+  osx-gcc:
+    runs-on: macos-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      run: ci/install-dependencies.sh
+    - name: ci/run-build-and-tests.sh
+      run: ci/run-build-and-tests.sh
+    - name: ci/print-test-failures.sh
+      if: failure()
+      run: |
+        ci/print-test-failures.sh
+        exit 1
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
+      run: ci/run-build-and-tests.sh
+    - name: ci/print-test-failures.sh
+      if: failure()
+      env:
+        jobname: GETTEXT_POISON
+      run: |
+        ci/print-test-failures.sh
+        exit 1
+  linux-musl:
+    runs-on: ubuntu-latest
+    container: alpine
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      env:
+        jobname: linux-musl
+      run: ci/install-docker-dependencies.sh
+    - name: ci/run-build-and-tests.sh
+      env:
+        jobname: linux-musl
+      run: ci/run-build-and-tests.sh
+    - name: ci/print-test-failures.sh
+      if: failure()
+      run: ci/print-test-failures.sh
+  linux32:
+    runs-on: ubuntu-latest
+    container: daald/ubuntu32:xenial
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      env:
+        jobname: Linux32
+      run: ci/install-docker-dependencies.sh
+    - name: ci/run-build-and-tests.sh
+      env:
+        jobname: Linux32
+      run: ci/run-build-and-tests.sh
+    - name: ci/print-test-failures.sh
+      if: failure()
+      run: ci/print-test-failures.sh
+  static-analysis:
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: install dependencies
+      env:
+        jobname: StaticAnalysis
+      run: ci/install-dependencies.sh
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
+        sudo apt-get install -y asciidoc xmlto asciidoctor docbook-xsl-ns libcurl4-openssl-dev
+    - name: ci/test-documentation.sh
+      env:
+        ALREADY_HAVE_ASCIIDOCTOR: yes.
+        jobname: Documentation
+      run: ci/test-documentation.sh
-- 
2.26.0.334.g6536db25bb

