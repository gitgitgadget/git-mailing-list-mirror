Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1473C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7789A206BE
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCSvLr05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgFZQLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgFZQLt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 12:11:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAAEC03E97B
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g18so10074444wrm.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G/4UfuuAIJ/txPNVhX1/okycLGVp5+ufad6aEJ3fASw=;
        b=ZCSvLr052COHjEe7GMuCoXAOjTEdFWU/B/hIufhAX9izfrQg7U1odaxDIwUqmsgkIg
         r8SoHN2Iz8Pw5QCC5gaHnJwrFrGVp138jEN4A9wf6LDVr3Oqi0ydWsiwidSKdeVNq6/x
         YJoetrlvA/pLIiXwIaFzXTkZKnJHR2LGYPWtjPvR8WcIuE6Sn7cskYFmsyqeyCoUuhlj
         PyrKLG+hw4P4LK5BFMoNl+B+Gx1NMFrIt8XSjWuaO8q/ZRFruLCdGoMAcCkDsio0Fnvu
         jr5aAzFyg2KQkCwAL3163cl1Rfc82QOxBnYXbYmmgGEqT+j96KsAIH1Xz+fZUDxqSuRs
         5cyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G/4UfuuAIJ/txPNVhX1/okycLGVp5+ufad6aEJ3fASw=;
        b=YbBkf4a9PRrwS5f4VZ8LAsoFggphdyuyMoBEHMCbjHru3NItK+MKs6HY4FmErbUbm0
         l5khs+rFUA3rZXV9C9aeAPx4RGasAUOWwz8TtcXGmZevyMI9fLl6zu4H3/QHrpba3xuh
         pyZyueQrLHquqDPEfKPhZOgkZd9xdgMB9U1zN7tg2L23wCf9RyQjKCxYImclu9lrkwCl
         mhIbkD/NvpeUdrDBcWZQIhvqXKNGnWCqByq/m+teFGaPblMpzB0Nkoa/xfTfL/j6vspu
         /kfswRJ+7JuYO0g4GCmpQ7mv8T/dj4BvAzedm+1mjsYY96lpixARy0eSFjzmGyfI07A7
         FuXQ==
X-Gm-Message-State: AOAM530LQQgAq7O0GMduVNoO44llk3ipUMhUoEbzpZhV64UG0cEYhOV/
        OPxGic/c4LDfaJ0VP+RYyKadgkUO
X-Google-Smtp-Source: ABdhPJylCBTtSGwhPJ1rRCob6X/p4IaEkY4WxxZ/86RAey/EcTlruODi/d68otYCnWza90biU6I0tQ==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr4549608wrn.269.1593187907297;
        Fri, 26 Jun 2020 09:11:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm17018006wmj.39.2020.06.26.09.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 09:11:46 -0700 (PDT)
Message-Id: <3cdefab43ad54d5fb14a5cbd9a509ed85745aed9.1593187898.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
References: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
        <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 16:11:38 +0000
Subject: [PATCH v5 8/8] ci: modification of main.yml to use cmake for vs-build
 job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sibi Siddharthan <sibisiv.siddharthan@gmail.com>

Teach .github/workflows/main.yml to use CMake for VS builds.

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

In the configuration phase CMake looks for the required libraries for
building git (eg zlib,libiconv). So we extract the libraries before we
configure.

To check for ICONV_OMITS_BOM libiconv.dll needs to be in the working
directory of script or path. So we copy the dlls before we configure.

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 .github/workflows/main.yml | 39 +++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 84a5dcff7a..44e0fe5839 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -145,13 +145,6 @@ jobs:
         ## Unzip and remove the artifact
         unzip artifacts.zip
         rm artifacts.zip
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
@@ -163,6 +156,17 @@ jobs:
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
+      run: |
+        cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
+        -DIconv_LIBRARY=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows/lib/libiconv.lib -DIconv_INCLUDE_DIR=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows/include \
+        -DMSGFMT_EXE=`pwd`/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
     - name: MSBuild
       run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
     - name: bundle artifact tar
@@ -171,8 +175,6 @@ jobs:
         MSVC: 1
         VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
       run: |
-        & compat\vcbuild\vcpkg_copy_dlls.bat release
-        if (!$?) { exit(1) }
         & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
           mkdir -p artifacts &&
           eval \"`$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)\"
@@ -203,7 +205,7 @@ jobs:
     - name: extract build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz
-    - name: test (parallel)
+    - name: test
       shell: powershell
       env:
         MSYSTEM: MINGW64
@@ -214,12 +216,19 @@ jobs:
           # Let Git ignore the SDK and the test-cache
           printf '%s\n' /git-sdk-64-minimal/ /test-cache/ >>.git/info/exclude
 
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
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
-- 
gitgitgadget
