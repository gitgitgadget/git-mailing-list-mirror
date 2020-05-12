Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5F6C2D0FB
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C7B206B9
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhIPN1PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgELQvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgELQvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:51:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1BBC061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so22565655wmj.3
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S/BoZwLwjeJa1zmOnvNR/jiUEVrNHFPIbwPD6ZVhlVU=;
        b=PhIPN1PVpjTsybU33KrWYtFZZpJX33rkAXZlGEShSCE6fFtrXl8NiY2p/6C/v+AAbB
         9f8NCavx9/1VADJ+KfzeBTPQlIGWrIZSL4dcZvTFxipfhKFd2yQGRLFUGnYIjKKtkgLD
         Gp4ai+f7p2LyjXmV2ZUZ2Tnr2nyxX0yRMX3NauKE2Q1DbFJ7YBJkP7q/yFhlz+683jeR
         DnwQV4aQxM9a8y8Z39tIiGGc9iMfqmQ4sF4ywlU1xoSLpUzwo9a2uj6srcIJMWu0ZFQJ
         Cj+AOAhKIr0z/KXIoJZgGCazEQY7YGQiXwFJpbSWIN/Ua+4RvVeUVTwYoFZWZMx39aq0
         JjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S/BoZwLwjeJa1zmOnvNR/jiUEVrNHFPIbwPD6ZVhlVU=;
        b=TVVVbiGljHiw/Hr+JSsQkg/ohCLreUiCYEYCh94sg0qGvjTyqOtUTaQhozrOFxoTrd
         HkbWZIPBo8utwVuzjMwH7igVFVzQ0kJ5OoM2f0CJX1V0fCXlOxB9qyrTcbgX52VR+sLQ
         PWaav3f/vZ4cthTwtuMICi9hzP9d6BTEzvDuMShTsWE5r2nkyb4etsFdpKi9C3Si+YF0
         wUWEjSQaJzNEHAUUVHr9akigUk1YzxnX+RZS89s90JPcRYnmte1dQED5oGiJRdbPSZzX
         1jd0eXxFD/OMIwMDKBXCRbrC29/uXUSHpncxcS+W2hFoIWmmGRbRLVZskDqlspwCi5Cg
         2nyg==
X-Gm-Message-State: AOAM533knirMe+MfeYa6rNo5VFOWTzhExFuqp41kcowRgXbYECNdVRwT
        qGhPxiUnOAA7RrMNJrIe+wjqLdoL
X-Google-Smtp-Source: ABdhPJx2+Km57dn6y5oIk8GrPQ1WM/6rKQqvD/S9x3l0LmLtHQ5eAUwKetEnUrbwmAa+ptkpT3DHqw==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr5137401wmj.76.1589302265288;
        Tue, 12 May 2020 09:51:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm9721613wrr.42.2020.05.12.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:51:04 -0700 (PDT)
Message-Id: <fa1b8032906c6042a0e5851f803ec0427922a1a5.1589302255.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:50:54 +0000
Subject: [PATCH v2 11/11] ci: modification of main.yml to use cmake for
 vs-build job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>

This patch modifies .github/workflows/main.yml to use CMake for
Visual Studio builds.

Modified the vs-test step to match windows-test step. This speeds
up the vs-test. Calling git-cmd from powershell and then calling git-bash
to perform the tests slows things down(factor of about 6). So git-bash
is directly called from powershell to perform the tests using prove.

NOTE: Since GitHub keeps the same directory for each job
(with respect to path) absolute paths are used in the bin-wrapper
scripts.

GitHub has switched to CMake 3.17.1 which changed the behaviour of
FindCURL module. An extra definition (-DCURL_NO_CURL_CMAKE=ON) has been
added to revert to the old behaviour.

Edit(Explanation for the reordering of build steps):
In the configuration phase CMake looks for the required libraries for
building git (eg zlib,libiconv). So we extract the libraries before we
configure.

Changes:
The CMake script has been relocated to contib/buildsystems, so point
to the CMakeLists.txt in the invocation commands.

The generation command now uses the absolute paths for the generation
step.

To check for ICONV_OMITS_BOM libiconv.dll needs to be in the working
directory of script or path. So we copy the dlls before we configure.

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 .github/workflows/main.yml | 46 +++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fd4df939b50..7a65cc0764f 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -80,13 +80,6 @@ jobs:
     - name: download git-sdk-64-minimal
       shell: bash
       run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
-    - name: generate Visual Studio solution
-      shell: powershell
-      run: |
-        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-          make NDEBUG=1 DEVELOPER=1 vcxproj
-        "@
-        if (!$?) { exit(1) }
     - name: download vcpkg artifacts
       shell: powershell
       run: |
@@ -98,6 +91,14 @@ jobs:
         Remove-Item compat.zip
     - name: add msbuild to PATH
       uses: microsoft/setup-msbuild@v1.0.0
+    - name: copy dlls to root
+      shell: powershell
+      run: |
+        & compat\vcbuild\vcpkg_copy_dlls.bat release
+        if (!$?) { exit(1) }
+    - name: generate Visual Studio solution
+      shell: bash
+      run: cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows -DMSGFMT_EXE=`pwd`/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
     - name: MSBuild
       run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
     - name: bundle artifact tar
@@ -106,8 +107,6 @@ jobs:
         MSVC: 1
         VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
       run: |
-        & compat\vcbuild\vcpkg_copy_dlls.bat release
-        if (!$?) { exit(1) }
         & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
           mkdir -p artifacts &&
           eval \"`$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)\"
@@ -125,9 +124,9 @@ jobs:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
     - uses: actions/checkout@v1
-    - name: download git-64-portable
+    - name: download git-sdk-64-minimal
       shell: bash
-      run: a=git-64-portable && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
     - name: download build artifacts
       uses: actions/download-artifact@v1
       with:
@@ -136,23 +135,30 @@ jobs:
     - name: extract build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz
-    - name: test (parallel)
+    - name: test
       shell: powershell
       env:
         MSYSTEM: MINGW64
         NO_SVN_TESTS: 1
         GIT_TEST_SKIP_REBASE_P: 1
       run: |
-        & git-64-portable\git-cmd.exe --command=usr\bin\bash.exe -lc @"
-          # Let Git ignore the SDK and the test-cache
-          printf '%s\n' /git-64-portable/ /test-cache/ >>.git/info/exclude
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+          # Let Git ignore the SDK
+          printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
 
-          cd t &&
-          PATH=\"`$PWD/helper:`$PATH\" &&
-          test-tool.exe run-command testsuite --jobs=10 -V -x --write-junit-xml \
-                  `$(test-tool.exe path-utils slice-tests \
-                          ${{matrix.nr}} 10 t[0-9]*.sh)
+          ci/run-test-slice.sh ${{matrix.nr}} 10
         "@
+    - name: ci/print-test-failures.sh
+      if: failure()
+      shell: powershell
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc ci/print-test-failures.sh
+    - name: Upload failed tests' directories
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      uses: actions/upload-artifact@v1
+      with:
+        name: failed-tests-windows
+        path: ${{env.FAILED_TEST_ARTIFACTS}}
   regular:
     strategy:
       matrix:
-- 
gitgitgadget
