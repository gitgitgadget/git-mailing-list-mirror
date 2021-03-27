Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A2BC433E0
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A896196B
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhC0XHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 19:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhC0XGc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 19:06:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DDC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 16:06:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g25so4771272wmh.0
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=opsNyEE4aI9Bz5Q1Rt42EQ/sekQvuO0cfEjnauxiO0E=;
        b=jEzPix3t9UuibClfYrzrrfef0DVujA/Rfmc8NJQLlr+ixPxB6dWkWnbV9y2QVn3Lzl
         snwpioB+shuzzsjjQZF2IrljEWTBRw19aoTvQyptT+n7wcr+1Hy7TXhTyBksnWsWRDk1
         cdgjo6qVrsX/nIY8TcrIeokmf1jnxYL70Di60IYglPk3GVLSLyO1/SK0dI7DtsuOtAJt
         CR6Ffzqe5j+ZbmELZjvb2S0uQtzsBfeR1xrRDRsLiSBMQ5F6X12jXIBc8gzGYAVMeRVY
         j0LkyRNlmibjsfzKtB1c8jeSBeGqhgJmtwCVi+t+o5p2hdS7o+yOjhIWEPBGpqRuyAfA
         oaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=opsNyEE4aI9Bz5Q1Rt42EQ/sekQvuO0cfEjnauxiO0E=;
        b=SXEqYMLJCCUTewYUfY4I9jX+v0t8Ws0pfUOyxLEzjAhDvDc2kdKbAs6rsAhXGeFZgy
         lOxwA1v3K9aqHnKvzIi/4q+2YQR5VGyRh0N/jgPTkTnGwKUSRmQVz/71m1FPnYGxs35N
         hwtNxjUJujgB8KTPwltF+ea7Rr9z9NZXn1Ez6PG1OCgpz+sFQIDdQRjwtYmSjv40Sjsi
         BcLs29zoKiGDW4XLeDFrbUIlYVliw0rf1jQF+mTT/lLhp5sSZpttzu5n5Zg+hbpSzBNX
         bHvMLH7BqF3Qp0LsNXwibOz6HCvzyFsd1W+IgikRoHaZT7TbkUTp+2JpQkIuoZ/Ete7E
         1reA==
X-Gm-Message-State: AOAM532fFA2Yr9/NcVefMb/Q251QHYYqe7yBO/XUhOVyJKUObVYG9jAt
        JOr3DXDKekI0G5aaTBCGjNVtuxFksyU=
X-Google-Smtp-Source: ABdhPJyQeZ2xiJoLN8DsCRtOn2Vcu/zFT899yruwi8KNRia1SVtutjFstckTiixPvBJ+gCcey/vOVw==
X-Received: by 2002:a7b:c931:: with SMTP id h17mr18937948wml.4.1616886390727;
        Sat, 27 Mar 2021 16:06:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm21327268wrp.22.2021.03.27.16.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 16:06:29 -0700 (PDT)
Message-Id: <4b183c7def5839ddf679605ff74f7f3280d957d0.1616886386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.887.git.1616886386.gitgitgadget@gmail.com>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com>
From:   "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Mar 2021 23:06:25 +0000
Subject: [PATCH 4/4] cmake(install): include vcpkg dlls
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

Our CMake configuration generates not only build definitions, but also
install definitions: After building Git using `msbuild git.sln`, the
built artifacts can be installed via `msbuild INSTALL.vcxproj`.

To specify _where_ the files should be installed, the
`-DCMAKE_INSTALL_PREFIX=<path>` option can be used when running CMake.

However, this process would really only install the files that were just
built. On Windows, we need more than that: We also need the `.dll` files
of the dependencies (such as libcurl). The `vcpkg` ecosystem, which we
use to obtain those dependencies, can be asked to install said `.dll`
files really easily, so let's do that.

This requires more than just the built `vcpkg` artifacts in the CI build
definition; We now clone the `vcpkg` repository so that the relevant
CMake scripts are available, in particular the ones related to defining
the toolchain.

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml          | 5 +++++
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index f6885e88ee6b..c13afe2bf058 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -186,6 +186,11 @@ jobs:
         ## Unzip and remove the artifact
         unzip artifacts.zip
         rm artifacts.zip
+    - name: initialize vcpkg
+      uses: actions/checkout@v2
+      with:
+        repository: 'microsoft/vcpkg'
+        path: 'compat/vcbuild/vcpkg'
     - name: download vcpkg artifacts
       shell: powershell
       run: |
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a166be0eb1b8..98b2507f222e 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -58,6 +58,10 @@ if(WIN32)
 
 	# In the vcpkg edition, we need this to be able to link to libcurl
 	set(CURL_NO_CURL_CMAKE ON)
+
+	# Copy the necessary vcpkg DLLs (like iconv) to the install dir
+	set(X_VCPKG_APPLOCAL_DEPS_INSTALL ON)
+	set(CMAKE_TOOLCHAIN_FILE ${VCPKG_DIR}/scripts/buildsystems/vcpkg.cmake CACHE STRING "Vcpkg toolchain file")
 endif()
 
 find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin")
-- 
gitgitgadget
