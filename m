Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690DCC433E4
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43523206E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5FELzcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgE2Nkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 09:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgE2Nkf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 09:40:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10531C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s8so3608921wrt.9
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q4da44yjdlZozL7OMNYEtxv5zwhjbS7UQRvm5bz6X7Q=;
        b=X5FELzcLgE/JRvhZq3y7q0t2bCXbkodhvU0PKLU6DVwB+A7IIS7aJXk5bPy+3li+QR
         RsNo0lfQdIZszmN12MLE9ABDZHB3v60xBQcl2FSwy4lczRpNe0naxcvLiRSJUojxRlNB
         0Izp8/OgKwjPOp3N3mUPPxGsG582ky8dL2C4jdqCOTmULQ1KCuGENt6hx8POKWOzQ49/
         8Fjzw8Z3Y1SdNQwH9J7aBaD2GuCjp++tsWS/Io3yzB/OsMqG0hRM7pJo+MpBKNMeYcr+
         ubI5jXBPLEOjVSLpHiDsKYoPldF8V+a55nw1OOxuk1zvbrDO80+PRmxJ8DV51s0bqmg5
         ic2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q4da44yjdlZozL7OMNYEtxv5zwhjbS7UQRvm5bz6X7Q=;
        b=FoKWHvzlq+cwro247qOpMK3PrbpnnLljWOkKMU4s8wfk2FmBypncqOQ9gfrbMp0sk5
         6efBJqJcAzptuuuktG/tUPz588CYypbDskSLLlqypSdDYwxna/KW2FkFUzlRvdHfbqdW
         gVUjZObSNgTM1evGIElPTwgZ8KUVluB1V8FDaqtVleTnLIMSG25X7srnLXNNSHW7pX1a
         EeceLUO3YNUl7ajIfUZzjc16bk/5OP7q2HWdunLlwwdtoLbs8IleNx+qSJSaffhVTsJT
         0xFeLy0ar/ej/Pz/QhU6lQcWecccidVQ4D22nPldi29DoYAKIqALCdOkABWLaU1WmOSq
         dreA==
X-Gm-Message-State: AOAM531St7VrPiWyEGDTccei5hD5rYpEzYGOpVslgSSf4svJFKG/F2Zf
        JrEbXhtQFVL+KVKkxa6/63CcHfRB
X-Google-Smtp-Source: ABdhPJxhW+kAxmiNxdDqQ1JYKe7hp5Gxyfh0gpff4c/kEsZf2tzmNVQr4E1XlgmlmP3a7napCl3HZw==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr8650278wrs.123.1590759633625;
        Fri, 29 May 2020 06:40:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v28sm10065241wra.77.2020.05.29.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:40:32 -0700 (PDT)
Message-Id: <bb329d16ce0999e198addf83d56f75762c830e1f.1590759624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 May 2020 13:40:24 +0000
Subject: [PATCH v3 8/8] ci: modification of main.yml to use cmake for vs-build
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

Edit(Explanation for the reordering of build steps):
In the configuration phase CMake looks for the required libraries for
building git (eg zlib,libiconv). So we extract the libraries before we
configure.

To check for ICONV_OMITS_BOM libiconv.dll needs to be in the working
directory of script or path. So we copy the dlls before we configure.

Signed-off-by: Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
---
 .github/workflows/main.yml | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 84a5dcff7a0..f0f0af720e4 100644
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
@@ -163,6 +156,14 @@ jobs:
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
@@ -171,8 +172,6 @@ jobs:
         MSVC: 1
         VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
       run: |
-        & compat\vcbuild\vcpkg_copy_dlls.bat release
-        if (!$?) { exit(1) }
         & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
           mkdir -p artifacts &&
           eval \"`$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)\"
@@ -203,7 +202,7 @@ jobs:
     - name: extract build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz
-    - name: test (parallel)
+    - name: test
       shell: powershell
       env:
         MSYSTEM: MINGW64
@@ -214,12 +213,19 @@ jobs:
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
@@ -302,4 +308,4 @@ jobs:
     steps:
     - uses: actions/checkout@v1
     - run: ci/install-dependencies.sh
-    - run: ci/test-documentation.sh
+    - run: ci/test-documentation.sh
\ No newline at end of file
-- 
gitgitgadget
