Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13156C55194
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8ED2075A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhxHYeT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgDXEBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726186AbgDXEBq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 00:01:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E527CC09B046
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:01:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h2so8887932wmb.4
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hUzfO3+mKKc1GNueD9ZsRjqZRZ2E75O7/QivoujaVVc=;
        b=UhxHYeT56mQfpVY0Nbhay0NJtLwFFaPpDeu/1W26TGw4VVg+7jxx7rpETFs41XXiQR
         4UfGWBw3ST5rqYKV8KW5PUUzEWUgz8gOOFvI/Slo5m76EbaIt8AtpWTXwVgQJFWQc8Sa
         IbLgApsk8yiyL7+KxtoLOS1vQzUgtFnd2UUr0YOFVzecwKDrV8yxFSSBJ6KVSvby6bLN
         U6GN5u40t+6Nhl/Tyn5h21hIXLQ8Jlg3dRn+ysrPnZh8yO/2gxrqfVVtKtm+hVsQKsri
         mVSJaU+TtaP9Su9Dro0zmAdfWfuPHVyaIT1SaPxpqAFlVSGBzrSZZQrGQATClm4bmEXI
         UzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hUzfO3+mKKc1GNueD9ZsRjqZRZ2E75O7/QivoujaVVc=;
        b=M/BSFOQB2FEtLtn3OFbLIC/veS7se6jS2K6ncm4QnTUPfROH4N1bLLrBhG00gWXDiC
         LAA2atcSAoVCRstuaT8wIsu/FJctgC8yFho29SKvZ9fLIbz7VdewX98Adl9Z31d/EVod
         uDsxrvvKddmAg5B4p8ECqZ+O6tPlsw57v4aeCv3Jbwml20XWnqRzwPfTeMYh6t/YPS9z
         e/mhh5Y8QI3z+KRq+Jazm3++EIaikLG/KOIcFMyaCFoXnUQl14Utagy3YKYPtJqgMK/R
         mz2PAnr5ygUyc3EDVsa2t4lnNh6BpKbiD2KpmpjM+ykpjuPO7y4Li7mpn4i5db+mOH23
         M+xw==
X-Gm-Message-State: AGi0PubNoq9Iyl2DoD4exAmzQOOOLfAMHljlH0MSmjC434C9SYck4Ioj
        GBaQqOelrJITEUE38WcJ+nAX5cYj
X-Google-Smtp-Source: APiQypKjkcAvjDe5Rr5RSnp3dRqDlq2ZZjVi+J2yY6u8H3k/xPBFAa9nozhmQ8uJ1Fz47lmTaSYDYQ==
X-Received: by 2002:a05:600c:c8:: with SMTP id u8mr7933121wmm.142.1587700904505;
        Thu, 23 Apr 2020 21:01:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm982698wmi.48.2020.04.23.21.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 21:01:44 -0700 (PDT)
Message-Id: <f0294be3f1151526fe002a55fb79015bd35606b2.1587700897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.git.1587700897.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 04:01:37 +0000
Subject: [PATCH 8/8] ci: modification of main.yml to use cmake for vs-build
 job
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

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 .github/workflows/main.yml | 43 ++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fd4df939b50..94f9a385225 100644
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
@@ -98,6 +91,13 @@ jobs:
         Remove-Item compat.zip
     - name: add msbuild to PATH
       uses: microsoft/setup-msbuild@v1.0.0
+    - name: generate Visual Studio solution
+      shell: powershell
+      run: |
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+          cmake . -DCMAKE_PREFIX_PATH=./compat/vcbuild/vcpkg/installed/x64-windows -DMSGFMT_EXE=./git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
+        "@
+        if (!$?) { exit(1) }
     - name: MSBuild
       run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
     - name: bundle artifact tar
@@ -125,9 +125,9 @@ jobs:
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
@@ -136,23 +136,30 @@ jobs:
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
