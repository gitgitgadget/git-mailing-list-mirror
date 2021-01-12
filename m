Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B04C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7798E22E01
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405694AbhALItI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405688AbhALItI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:49:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C3DC0617A5
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a12so1545576wrv.8
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5uOXbBWanfZ4W7LK+y1W9oyHc5mduS3MgBnRr/g/w2U=;
        b=Yd2YTOtKeNDq+jwWqRHIYxh9VgbQt9ry2f+KbyWREJ2fZLBgga1KnCDv1nLMDtzCy2
         mgXbr8VtBTDbD9x9kN+ZcK/9plhxgC7Xp8MpV3NUx1XwC6D9paEO9wqmxUiO9T0W7ngz
         BwCEwWDz3fxp6A/EPd6NU2Z6AlEY2cVrGdtIMBQ34JISs1z6nduYNjJTTDUUwxfDmCEr
         tNE5wqcOZa4BBwAC2GX3FB+tiaPxevPWEM1onJDcmDSkzt7KBL0LyKDqFQ2X6XayaVN0
         7/FouCTxganVQ29WcRdgeMDfkZsxOkyjY6mNfFKjR0ECwwJGRFRtX63CDLvyn/8Kq8wc
         CAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5uOXbBWanfZ4W7LK+y1W9oyHc5mduS3MgBnRr/g/w2U=;
        b=huIySEgrAUeYHEbpx71jpD9gwDNCNabfbN305aHnbeMDuSLuuxPOpVddsR2v04BNNZ
         m25d6VQdVIWGiFf2W4LCV4y+seOdpoUn9tg5uFJAzNzl3OHORrN+b4rBFCUFkrolEk5x
         R8Yi8t9NZnQ0ivYSRz8DwcJcj+hzAuvLioLN4JWTpcCKoZ7GCSTpUS4KqzX6io6ZIJQ9
         4Sz+Hme7JG395k1pvw97DAfle1w1FQ2048Q16+a/dRjsGJq7dIqGVUtyUQ69Llu5e1XL
         mOUpjkfdCHEd2IJEPxWiyixrUPP5I0RhA+NQjhSU4G9qqgFlbh/howUTbAVsZDMi76Pd
         lfEg==
X-Gm-Message-State: AOAM530fJeNgHjM/Jq+XXcHx7GrWP4aBUDZV0+M0T1ycvY20QwpfKXlk
        WeLiRUmKm759Fvb1rh/gCC6ursF55gY=
X-Google-Smtp-Source: ABdhPJzg2TB5+yBVhA83rWI+RENfqqBN5afHqllrrfYvHzvJ4gRKePAegmhS/jGN4fC5Nlyx3BEQpQ==
X-Received: by 2002:adf:a495:: with SMTP id g21mr3230947wrb.198.1610441271752;
        Tue, 12 Jan 2021 00:47:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm3456161wrw.75.2021.01.12.00.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:51 -0800 (PST)
Message-Id: <82e38c68f4406cb5bbaea3b4102b33097e29ea67.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:39 +0000
Subject: [PATCH 08/11] t6301: do not expect the output of `for-each-ref` to be
 translated
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `test_i18ncmp` function is reserved for output that we expect to be
translated.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6301-for-each-ref-errors.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 809854fc0ce..0cf2a41c26c 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -20,7 +20,7 @@ test_expect_success 'Broken refs are reported correctly' '
 	test_when_finished "rm -f .git/$r" &&
 	echo "warning: ignoring broken ref $r" >broken-err &&
 	git for-each-ref >out 2>err &&
-	test_i18ncmp full-list out &&
+	test_cmp full-list out &&
 	test_i18ncmp broken-err err
 '
 
-- 
gitgitgadget

