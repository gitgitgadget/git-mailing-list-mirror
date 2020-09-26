Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EADBC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD9123772
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paQKYGVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgIZVdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgIZVc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:32:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDDBC0613D5
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so7632939wrx.7
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LbzZ7rratphdzpKCzScQ0H87PZ4mOGWV8pJbumS/i3M=;
        b=paQKYGVfwIPVzLIfByIZ9soDpg/GbFfWgjnvYHTmR3DB/8GAGaXAE0QrO4VUbxkv71
         FUAznD+s+LVCuXBN52lY1pKro1Lqsq3qhGdk+kWI+TRMDryiUq0RG0oFR17SnOG/hBSr
         sNjy8NHrWcj4qr4lp3tfuAvYa5gWTCAWJGG+JRGfOrWCDvrEoNUvWhSulzip4d0TinaE
         jjBy3b7kFu1IgQSwCrMN/PUKP0hEXn9JCXSvTcsfdHZdOr2/f7x0nE/+Kw31zzq1r1Ca
         pEFdKmjqiLqGGm3Fwyl8709qe89ORvSWaEUt5ubgZ++Nu7ISmwEvHFDNQJmwdNFSgMB/
         EUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LbzZ7rratphdzpKCzScQ0H87PZ4mOGWV8pJbumS/i3M=;
        b=buPmlIdCoBdkxwnemkqAdKbsADo8XA0jiz7VwwcDWmM/OlEE9HsOxR+WjWlziReIRj
         a0WIIs+HGY6ouCBqN1CsxTfyvVDMx/raf6J7bdi6hZadMk3qXW6991JE8Mz7EUxgh1SH
         czF34YroH81pjkB715bNrIG8j4iU2ZUn33Trg6uYRiuH0S0UFzKpP5VzWMUrD4UUL/E8
         VVXLCDnfSxS2aLPZDMJbg5dOLlzMR5D3C6cVMgl87JNJKn5m+6Hz9qHnNaEAmefGrGF8
         DDBV+0sHAyRqGLjmmO+F4jbsxGCJD18RdRdeS0bO4UXxTTUxYizpLOw7G/TIw0j2HCQw
         RLAQ==
X-Gm-Message-State: AOAM533S6T/cPXH/IpGLSTwTQjqZ6W+Vtw0bNNmUvFvws07p1omrEwl5
        f9M1zSQK46hp5lzW8i/6eX+sQL4Ro9o=
X-Google-Smtp-Source: ABdhPJzbib0XKS46oDYOwlz8549EbWMkI6NYHI3FvC5lbJyuxKOPVm42CeYCt6oWPlYC0agnvoh7bQ==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr11708036wrl.419.1601155974631;
        Sat, 26 Sep 2020 14:32:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm3772305wmi.37.2020.09.26.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:32:54 -0700 (PDT)
Message-Id: <8b3500a07c67d07e0928e8d6638d618ab118e1eb.1601155970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:32:44 +0000
Subject: [PATCH v2 05/10] cmake: quote the path accurately when editing
 `test-lib.sh`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By default, the build directory will be called something like
`contrib/buildsystems/out/build/x64-Debug (default)` (note the space and
the parentheses). We need to make sure that such a path is quoted
properly when editing the assignment of the `GIT_BUILD_DIR` variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index acb197fba5..e66ae137c2 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -952,7 +952,7 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
 		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
 		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
-		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY\\\"/../${BUILD_DIR_RELATIVE}\" content \"\${content}\")\n"
+		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
 		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
 	#misc copies
 	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
-- 
gitgitgadget

