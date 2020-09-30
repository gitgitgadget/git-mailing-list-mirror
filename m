Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA98C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8311620759
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It+jM2cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbgI3P0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgI3P0b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:26:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CB8C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so2267813wrm.9
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mG1q8NYUTU7tMmbucRUbK3iRETU2aTi6t7uRcRPBRYQ=;
        b=It+jM2cpwlK8wVkcm4C1rXDGQVIjWgaHZ+eGK2MHf+aQLS4WQKUtbyqCAN1cFGwVoJ
         WZrWLfDSHkDH46eyHgnT7vVt/TU3CE84jlAU8o6MhE44xSj53GMsaHoqqlb+8dKf4+eM
         m1e/ivY9ORIeBGuzzzxjZK5/qWvvxGu0sjEYT5QeYVNyJnfcSPNbBPOF63XtoO5+WiSZ
         2Cj1Oj/GGt6St50dpdxac3HjBqrrLL6AQdgTQ91zAmNpfljEaduv/WzZQsviQpYoGMa4
         qC3n2i4d9L6SBGovgIrMnrtgDOnlLsn9xMm8YovdB/lCy3uO53rWSdzbe+RqTG9vic1o
         mixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mG1q8NYUTU7tMmbucRUbK3iRETU2aTi6t7uRcRPBRYQ=;
        b=I4SW3qW42kfeJhY+0HugXYEO7exy4LN4iHL6rHt5/iNa+x3mMghqVAJ9hfqT3PApYQ
         WGje97xT+3XGt+1e57sxPt2tYNzutdJF8q2ZSZdqHD9ftIEGBuLPiGwwo7L2ZNrRAiW4
         XrNAZW2lvSkvrU/DLe7Avn4OS6Ih3vkafQPG8qQWPjV0Vb0fU3Oy+DaVyCYHvsOtjGIU
         aogivAKM+fwRU0yq91h9LL5xHv+chDjABxqVEGlH1RCmplyIpn6VbxKbX/Kp78QVIehr
         gFHXPQrLiearrqJtPN/eBAt9SGhY9J+E65hspn2B31flmFRb+1BZrx/TxfBiUgMnKl+P
         Kzwg==
X-Gm-Message-State: AOAM5304UdQB7lURsFOx3wxxYoYfZO5ttE4YAfjp9QsDe/kMliPWpzXq
        ccg8Y6rWlGor4G6joRvmJSWsMP9m0wY=
X-Google-Smtp-Source: ABdhPJzkcgN68L+Hx6Jgb9rpwKI8hPobh8gmV64JnQnlaBVnpqtqVP7omd9iZFs4LllrnyXg4tiNVA==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr3808030wrs.107.1601479590209;
        Wed, 30 Sep 2020 08:26:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm3324222wmj.28.2020.09.30.08.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:26:29 -0700 (PDT)
Message-Id: <cfedb1673ad1408c58eccddb365af5a0ab0ad93c.1601479585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:26:19 +0000
Subject: [PATCH v4 05/10] cmake: quote the path accurately when editing
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
        =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
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
index 02241dcc77..3bb74337e1 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -949,7 +949,7 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
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

