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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CD4C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3430761CAF
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhF2CH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhF2CHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28213C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j1so23661747wrn.9
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M5y7V+S57JkqDlEiYCsuFlFYkP2WRg1BWKCFbReDZCs=;
        b=k+HKXs+h7vm7e0UJ1cMIgZgsorbZRuEoTy1kmbREGfEwlS2/uxwlPmTRKR8H8WWCCA
         Eb7Ebm3F2Gyi9eUyqEUeo135Z935ReSdAKVGaJiEhU6u30MJ1wsFAhe1iNyMsdpSdJMN
         pmDvqG5x0/nTvuYfQd0Kiz37Fl1olGem9Dyx2bek3wT5cXSZWPPlcp4mbfXxLpQkrHSt
         5vUkNuaUfvzU0WK2OEJvxxddSOdd2IXzP9+gAKdx/tAth5jcYO7GSOtiRYrn9JF4baqv
         VHjjYf4K4DNP7IUGftYIkaiOtEiw9YqdKovL187TR0Nu8T/udpTu9KhwhsEpwsXuS2Ly
         g2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M5y7V+S57JkqDlEiYCsuFlFYkP2WRg1BWKCFbReDZCs=;
        b=sPNUzw5Zpu/axV67crwOP0hc5ylKEGn01er1jf8UDKkq5uetqBG06o9TK4wKuSn8X0
         GufBBk7KAfZYi7dIXPr/GLpD2/OasTgBDb7jce9yVw5XLAK7Tc1UQvS/sLz1nPqdU6LZ
         zyCfMt2wvlHFu0nIc5vQoexvOCUZtZCST4hIMTCv/1qJIettcV9+F6ndwL12MaWSxA54
         jqFT8filOnhRfroWDqdi0XgzktGg/KwhwMjZzs9a2U+f36zsyyXRK26hNskxLjCjnCiA
         2Rm38RV9er+cmNt/1WRGt50+eduk+b5uwRxD4Ii3b9wsdi0YvSleyZaYiSmi1Lf6gugl
         DQIQ==
X-Gm-Message-State: AOAM53356Fo2WsgnbspqcilnCfylUufpw4epm6h4hOAvS3tHyFc00/TD
        iykhTkTMj8cNDr4uj7XZr8suGIC/ehY=
X-Google-Smtp-Source: ABdhPJzgnGyvtHIkBA0nUdGKoIrNnjeO3REHiluobhMIWeXXJXHlqgecYaEd3LPsdNszmzKqp91Djw==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr30507417wrw.104.1624932296775;
        Mon, 28 Jun 2021 19:04:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 12sm1092784wmj.12.2021.06.28.19.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:04:56 -0700 (PDT)
Message-Id: <d965669c76663ebe6b172c4046c9c517ba9102f0.1624932293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:40 +0000
Subject: [PATCH v7 03/16] t1092: replace incorrect 'echo' with 'cat'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This fixes the test data shape to be as expected, allowing rename
detection to work properly now that the 'larger-content' file actually
has meaningful lines.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ba2fd94adaf..ebbba044f77 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -40,7 +40,7 @@ test_expect_success 'setup' '
 		done &&
 
 		git checkout -b rename-base base &&
-		echo >folder1/larger-content <<-\EOF &&
+		cat >folder1/larger-content <<-\EOF &&
 		matching
 		lines
 		help
-- 
gitgitgadget

