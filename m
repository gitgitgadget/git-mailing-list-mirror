Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD6C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 14:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5A622B3A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 14:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgLDOXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgLDOXE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 09:23:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E44FC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 06:22:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s8so5483948wrw.10
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 06:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1i47ruy+214HLTI/BHP0VhA+HMqph9dxLp8/Oa1ugNw=;
        b=MTehysGBChkNK3NL8vDc3kjW06U6YOWvCeIw4jhjo7HxgZlynacI8gE+n9ry2GsNmX
         Ap4tWVmAL7n/cFJFYpKU23pR0qmqvWmfX/Vabx87dKdI/OMgzW61OyqUgrvmHKASJdHy
         YwobEqika/uy6v691hYS550rMJI5NZZvAdfJtQuvDnTCIH+d849cc9kVvGvqoQzMLYak
         h5T7UimOpoeWuwEPSFffK5/ZxQwbNMIrydkj6v38CUhKfLScfrLChxOtMq/EhWVroCmj
         nQHXBZ1JSmjLg04TYgR/SLBDgA3xffUYxypcoskGt3wkmajJt9w7rkoSuvylVuHI0nG/
         QUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1i47ruy+214HLTI/BHP0VhA+HMqph9dxLp8/Oa1ugNw=;
        b=O/xhmLf0KBbPsoNxgfKlmY/Bew6whrK1IjEg9sHkgIfzOtSbO2kGzUTlDeh3gErPbL
         rgFIcfufJd9Xw3IPYGCdrUZBTM0DC03xRpVumvHD6X2H57ya0uRbpH9rsUkAvyTyIazi
         4eu+UunpHg/en5OFSHDpPvBJvx6n8XP+FvoRLyg5pAzlPU8BzSPWu/5ccf4zrPDsu5BY
         Br5kJvYY6PYuZS7/EAA5HbU/HHPlRpJ37HuApO9O7LC7IOWfRB6RDoZ/M32pVBWS21RT
         unT1SqVIWxFgWGNVqy/IZof8Tnn5ni7e2ShPZcOg3s6Z8RA7cbamtbKcANZOG4V2Kxzr
         Yxng==
X-Gm-Message-State: AOAM531OGc+Z6Wgfh+wCKDx05rADD+VCYi+M2GGgD5+YxIeIL4K+YE0T
        Pk4Q/0gUFl0mMI8dAfH7wlkokarHO7A=
X-Google-Smtp-Source: ABdhPJwcKJ3b9s8LHOaKdq2NYUyxIVQfKocc60SetGZLZabjcYigknHqKTGPHY41Nt5/OlVHSbeoEA==
X-Received: by 2002:adf:fb90:: with SMTP id a16mr5325260wrr.192.1607091742922;
        Fri, 04 Dec 2020 06:22:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm3769396wra.91.2020.12.04.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:22:22 -0800 (PST)
Message-Id: <pull.805.git.1607091741254.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 14:22:20 +0000
Subject: [PATCH] ci(vs-build): stop passing the iconv library location
 explicitly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dennis Ameling <dennis@dennisameling.com>

Something changed in `vcpkg` (which we use in our Visual C++ build to
provide the dependencies such as libcurl) and our `vs-build` job started
failing in CI. The reason is that we had a work-around in place to help
CMake find iconv, and this work-around is neither needed nor does it
work anymore.

For the full discussion with the vcpkg project, see this comment:
https://github.com/microsoft/vcpkg/issues/14780#issuecomment-735368280

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: fix the vs-build job so that CI builds pass again
    
    This was noticed first in a Git for Windows PR.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-805%2Fdscho%2Fvs-build-and-libiconv-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-805/dscho/vs-build-and-libiconv-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/805

 .github/workflows/main.yml      | 1 -
 compat/vcbuild/scripts/clink.pl | 2 +-
 contrib/buildsystems/engine.pl  | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index a940997f1b..f1f0d1fe35 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -201,7 +201,6 @@ jobs:
       shell: bash
       run: |
         cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
-        -DIconv_LIBRARY=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows/lib/libiconv.lib -DIconv_INCLUDE_DIR=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows/include \
         -DMSGFMT_EXE=`pwd`/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
     - name: MSBuild
       run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index df167d1e1a..3bd824154b 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -45,7 +45,7 @@
 		push(@args, "zlib.lib");
 	    }
 	} elsif ("$arg" eq "-liconv") {
-		push(@args, "libiconv.lib");
+		push(@args, "iconv.lib");
 	} elsif ("$arg" eq "-lcrypto") {
 		push(@args, "libcrypto.lib");
 	} elsif ("$arg" eq "-lssl") {
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 2ff9620459..ed6c45988a 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -351,7 +351,7 @@ sub handleLinkLine
         } elsif ("$part" eq "-lexpat") {
             push(@libs, "libexpat.lib");
         } elsif ("$part" eq "-liconv") {
-            push(@libs, "libiconv.lib");
+            push(@libs, "iconv.lib");
         } elsif ($part =~ /^[-\/]/) {
             push(@lflags, $part);
         } elsif ($part =~ /\.(a|lib)$/) {

base-commit: 898f80736c75878acc02dc55672317fcc0e0a5a6
-- 
gitgitgadget
