Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB07C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48786023E
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhFWP0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhFWP0j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 11:26:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4EC061756
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so1611794wmb.3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m8btpHLgA3Rf/OV25hUuFbeaBFtQVFpk0jGKkNpZmeA=;
        b=bhOxuskLvmSEnpYg/9kVxcDP7A9UzVrNSsa02zn/wUMK3WbcVXxLoEU0Ld7ZowjLeL
         Ss+WyFv+vRH/qTesIp1mlAitHHYVGQXunPphBem9QEDIRoHG9z/0pnv9wJhTLr9Mtejg
         0v+mfF1lYtoarGOIlQeWoeAv2mOenifq22/uSpbK3zbyVAxG0kT4oDNUSHNjjdXJmtaF
         3zB2CiB1P1DCDOBFbd+NkRfQaU3oRj3OnHdBHosXfK1gjWme8GyqMalSRz3Ccxc87M0G
         k0QcJGChVbQQO7rdACUILrwMuO0wvqunEh1lBoY88q4Cov36mk/3q7KDZ+ZgAs6NHDT8
         0mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m8btpHLgA3Rf/OV25hUuFbeaBFtQVFpk0jGKkNpZmeA=;
        b=JnHy56MXvwHnirSE+XU2zkMpqhcWt+oUmIDbXWrR3Ya6aSC9fmYXHBRaLgMgtyMjfk
         /iLdDFnWFJvxDiEPXsftN1u/FFzd4fTcLFxgFOrnHgejmrKnj5iYS+95Nxlj/XUGTivy
         qOb9xMoRaehAd3ExHusEdcnYeXrw8e31x4c5MZlR7nWk2SO5x/dYMrZ6OSQh8sBylQLr
         wYjyi77L7Ub9Op44BjVS/CohTYfjGjHgVgbzxBOEg/jV6QDLgLM0TBVS4rjclbuLRSnm
         JZRT59V5U8bWrjV33Q6MzsPSP2EkJDbLkEjG64U671dKfeb62J+I0+rT+k9Kusy03rrq
         DJSQ==
X-Gm-Message-State: AOAM533+AW3NEZaiHrymKs+JBxFR+8s3m5R9NEvd4F30qmicAlIXZ1V9
        YdlnhqoRPpSxBce6gstlIvd5K/1/t8U=
X-Google-Smtp-Source: ABdhPJxBfL+Y3UpkBVpU1pvupIdYs8f/ODwdj/GbcUz8Jz9GxdEX7C5L++V+hsW78/NBC2pVQI+kYw==
X-Received: by 2002:a05:600c:2051:: with SMTP id p17mr271046wmg.35.1624461859219;
        Wed, 23 Jun 2021 08:24:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2sm360956wrt.29.2021.06.23.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:24:18 -0700 (PDT)
Message-Id: <8da66c425a13557bd83ec1cddfcf86587da2a8f0.1624461857.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.1624461857.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Jun 2021 15:24:11 +0000
Subject: [PATCH 1/6] ci: use the new GitHub Action to download
 git-sdk-64-minimal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In our continuous builds, Windows is the odd cookie that requires a
complete development environment to be downloaded because there is no
suitable one installed by default on Windows.

Side note: technically, there _is_ a development environment present in
GitHub Actions' build agents: MSYS2. But it differs from Git for
Windows' SDK in subtle points, unfortunately enough so to prevent Git's
test suite from running without failures.

Traditionally, we support downloading this environment (which we
nicknamed `git-sdk-64-minimal`) via a PowerShell scriptlet that accesses
the build artifacts of a dedicated Azure Pipeline (which packages a tiny
subset of the full Git for Windows SDK, containing just enough to build
Git and run its test suite).

This PowerShell script is unfortunately not very robust and sometimes
fails due to network issues.

Of course, we could add code to detect that situation, wait a little,
try again, if it fails again wait a little longer, lather, rinse and
repeat.

Instead of doing all of this in Git's own `.github/workflows/`, though,
let's offload this logic to the new GitHub Action at
https://github.com/marketplace/actions/setup-git-for-windows-sdk

This Action not only downloads and extracts git-sdk-64-minimal _outside_
the worktree (making it no longer necessary to meddle with
`.gitignore` or `.git/info/exclude`), it also adds the `bash.exe` to the
`PATH` and sets the environment variable `MSYSTEM` (an implementation
detail that Git's workflow should never have needed to know about).

This allows us to convert all those funny PowerShell tasks that wanted
to call git-sdk-64-minimal's `bash.exe`: they all are now regular `bash`
scriptlets.

This finally lets us get rid of the funny quoting and escaping where we
had to pay attention not only to quote and escape the Bash scriptlets
properly, but also to add a second level of escaping (with backslashes
for double quotes and backticks for dollar signs) to stop PowerShell
from doing unintended things.

Further, this Action uses a fast caching strategy native to GitHub
Actions that should accelerate the download across CI runs:
git-sdk-64-minimal is usually updated once per 24h, and needs to be
cached only once within that period. Caching it (unfortunately only on
a per-branch basis) speeds up the download step, and makes it much more
robust at the same time by virtue of accessing a cache location that is
closer in the network topology.

With this we can drop the home-rolled caching where we try to accelerate
the test phase by uploading git-sdk-64-minimal as a workflow artifact
after using it to build Git, and then download it as workflow artifact
in the test phase.

Even better: the `vs-test` job no longer needs to depend on the
`windows-build` job. The only reason it depended on it was to ensure
that the `git-sdk-64-minimal` workflow artifact was available.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 103 +++++++------------------------------
 1 file changed, 19 insertions(+), 84 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 73856bafc9..c62766e7b1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -82,43 +82,18 @@ jobs:
     runs-on: windows-latest
     steps:
     - uses: actions/checkout@v1
-    - name: download git-sdk-64-minimal
-      shell: bash
-      run: |
-        ## Get artifact
-        urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
-        id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
-          jq -r ".value[] | .id")
-        download_url="$(curl "$urlbase/$id/artifacts" |
-          jq -r '.value[] | select(.name == "git-sdk-64-minimal").resource.downloadUrl')"
-        curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max-time 240 \
-          -o artifacts.zip "$download_url"
-
-        ## Unzip and remove the artifact
-        unzip artifacts.zip
-        rm artifacts.zip
+    - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: build
-      shell: powershell
+      shell: bash
       env:
         HOME: ${{runner.workspace}}
-        MSYSTEM: MINGW64
         NO_PERL: 1
-      run: |
-        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-        printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
-
-          ci/make-test-artifacts.sh artifacts
-        "@
+      run: ci/make-test-artifacts.sh artifacts
     - name: upload build artifacts
       uses: actions/upload-artifact@v1
       with:
         name: windows-artifacts
         path: artifacts
-    - name: upload git-sdk-64-minimal
-      uses: actions/upload-artifact@v1
-      with:
-        name: git-sdk-64-minimal
-        path: git-sdk-64-minimal
   windows-test:
     runs-on: windows-latest
     needs: [windows-build]
@@ -136,25 +111,14 @@ jobs:
     - name: extract build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz
-    - name: download git-sdk-64-minimal
-      uses: actions/download-artifact@v1
-      with:
-        name: git-sdk-64-minimal
-        path: ${{github.workspace}}/git-sdk-64-minimal/
+    - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: test
-      shell: powershell
-      run: |
-        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-          # Let Git ignore the SDK
-          printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
-
-          ci/run-test-slice.sh ${{matrix.nr}} 10
-        "@
+      shell: bash
+      run: ci/run-test-slice.sh ${{matrix.nr}} 10
     - name: ci/print-test-failures.sh
       if: failure()
-      shell: powershell
-      run: |
-        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc ci/print-test-failures.sh
+      shell: bash
+      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v1
@@ -165,27 +129,12 @@ jobs:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
-      MSYSTEM: MINGW64
       NO_PERL: 1
       GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
     runs-on: windows-latest
     steps:
     - uses: actions/checkout@v1
-    - name: download git-sdk-64-minimal
-      shell: bash
-      run: |
-        ## Get artifact
-        urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
-        id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
-          jq -r ".value[] | .id")
-        download_url="$(curl "$urlbase/$id/artifacts" |
-          jq -r '.value[] | select(.name == "git-sdk-64-minimal").resource.downloadUrl')"
-        curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max-time 240 \
-          -o artifacts.zip "$download_url"
-
-        ## Unzip and remove the artifact
-        unzip artifacts.zip
-        rm artifacts.zip
+    - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: initialize vcpkg
       uses: actions/checkout@v2
       with:
@@ -211,19 +160,17 @@ jobs:
       shell: bash
       run: |
         cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
-        -DMSGFMT_EXE=`pwd`/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
+        -DMSGFMT_EXE=C:/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
     - name: MSBuild
       run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
     - name: bundle artifact tar
-      shell: powershell
+      shell: bash
       env:
         MSVC: 1
         VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
       run: |
-        & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-          mkdir -p artifacts &&
-          eval \"`$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)\"
-        "@
+        mkdir -p artifacts &&
+        eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)"
     - name: upload build artifacts
       uses: actions/upload-artifact@v1
       with:
@@ -231,18 +178,14 @@ jobs:
         path: artifacts
   vs-test:
     runs-on: windows-latest
-    needs: [vs-build, windows-build]
+    needs: vs-build
     strategy:
       fail-fast: false
       matrix:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
     - uses: actions/checkout@v1
-    - name: download git-sdk-64-minimal
-      uses: actions/download-artifact@v1
-      with:
-        name: git-sdk-64-minimal
-        path: ${{github.workspace}}/git-sdk-64-minimal/
+    - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download build artifacts
       uses: actions/download-artifact@v1
       with:
@@ -252,23 +195,15 @@ jobs:
       shell: bash
       run: tar xf artifacts.tar.gz
     - name: test
-      shell: powershell
+      shell: bash
       env:
-        MSYSTEM: MINGW64
         NO_SVN_TESTS: 1
         GIT_TEST_SKIP_REBASE_P: 1
-      run: |
-        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-          # Let Git ignore the SDK and the test-cache
-          printf '%s\n' /git-sdk-64-minimal/ /test-cache/ >>.git/info/exclude
-
-          ci/run-test-slice.sh ${{matrix.nr}} 10
-        "@
+      run: ci/run-test-slice.sh ${{matrix.nr}} 10
     - name: ci/print-test-failures.sh
       if: failure()
-      shell: powershell
-      run: |
-        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc ci/print-test-failures.sh
+      shell: bash
+      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v1
-- 
gitgitgadget

