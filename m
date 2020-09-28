Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04E5C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6188B2100A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcHsyYTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgI1VJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgI1VJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A264C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x23so2486959wmi.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qn/TZyUJ7bX+EzhR76rXOL+D7+sWwMfvqSis+eDb0S8=;
        b=gcHsyYTT+rCMK0vAzEQL3NUgorokPjPoyvzt93zhAI0Y+Rqhiiv2LJbP36J6vQUWVp
         rWCm94giM1aMbYr2MXhcJDABt9TbIijx7GQhT2bTStixMz42JboRI6R6jG8/25Na3vLz
         jMyNqqq7GZtAaetwqpyGwyIt4J+QjeqVXhLKWpvaB5F44H+zeAV/I62QYLGqdNVGwGfU
         EO63G3It+dfWmPV2F3I2VnBqEV962wbkML6FuogyqdvcG+b7JfSG2TPQkgByefQZOf82
         j+NJjFQE22Ki2I9HgQkSW0XAUe5EtE/f+5zYhedWKEcnz+m1GJ/LYhqVUE/G9nPa+BYc
         yOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qn/TZyUJ7bX+EzhR76rXOL+D7+sWwMfvqSis+eDb0S8=;
        b=DIFcRAdyZWXKYO5BvpxmjHY3U203iT8sEV2MZKD02kzHmDktdhoZHBcDU9sKSJkJSi
         RswYj7XNYy6Y7dHuR5h4ouChAWnTD8EEhmSyqYbATnMojssjwvgPdGoNVNB4XW90oRQ6
         Zw7B1NBYIL/DT45TFzhTSKMfpuqygou3RogAiOJ1OOzfg5Eg8HmWsH56/PXz7TI0caUB
         YZ80oM+LNz9LX3ZQyRSHzmYkxmPLRckvGzla2JdaQr6smZIyVwRtUoK0DGCO/4IW6F3V
         Df93N9iGN/fLjSLPrA3IDYAKBmsZrYIYRwDpZKbHJZAOzdam/9qNwnVg60dguH+4LX77
         HhMQ==
X-Gm-Message-State: AOAM530ehOR0mtnUWNDz78+jxs8qcQ0a6NUTTTagmozy2aWdTjNmmBtn
        JB/8A0GIVVBrQaT3E+p23eneoTU6atU=
X-Google-Smtp-Source: ABdhPJwMkvIFGrh1pjs1V56wRVnxF05YKcVsCxA1XYBCAQvR8YSshI1+xNYrwJuKfoA2RDjM1O1lxw==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr1088773wmi.28.1601327364736;
        Mon, 28 Sep 2020 14:09:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q13sm3108715wra.93.2020.09.28.14.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:24 -0700 (PDT)
Message-Id: <8380aa55ab53aeb552de5eaf4bdae92bba71c958.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:10 +0000
Subject: [PATCH v3 05/11] cmake: quote the path accurately when editing
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
index 683cf38263..1999db0c6b 100644
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

