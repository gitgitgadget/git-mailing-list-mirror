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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816FBC43331
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5339922D58
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405709AbhALItQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405699AbhALItO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:49:14 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F7FC0617A9
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g25so1314932wmh.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=icji/igcsvhiwJIIPQNHaIgzkWyPjYmr92cDv4xCqO8=;
        b=pzCa3rzzXtdJz2wILAag/IfspOdnYdzSaXLZKsHLNcTlGYjomrFzuU7Ca//PiuNiLC
         Zppmy9vHuRXRDr3xW0Oghr7w7/YFIQin2MLHf1BTGKRPlQxa2VDTgGVrBnNAwd9TTclZ
         MgKkdZCccpuMe0czZ+vpezBTfKaDLR1lJ6XTD/MeWV52JtU0u5cKdF7SK3Hr3EMnZIJ0
         Z1iIP/Q55gg9EVQteTidIYc96g8M+ToihbJQzJamhylUCQQ3/Kvb5k2rG9Gv6bC+LUG2
         BdTjAHPvz5p5vAm6JPMIspqkRLbDNLfZliaACkDaKFl9yh5CmU0Tu/KmNFuXZ3RfLKA4
         pCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=icji/igcsvhiwJIIPQNHaIgzkWyPjYmr92cDv4xCqO8=;
        b=pJpudSHw2+BPJyMKwUYQ5y6SWAeHmTz5WUM6hb7FWx3gftTYskLKAcIaZ+PboXWnCq
         ec9D7eFTntkcTNixhQhGtR8dXl7jm/glTmdcyOXlJuuBAmfaFbi5Ru4k9ruWk2mAin/c
         TOuFVNgla6ST5DF4kLQidc4xp6cytsb8qnv5YVqnu9XkCcCVZE9jkPcYldX8ovIXshMB
         G0e91mB3lBgWyXvIt5SUCT3lZMds3SmWqT9HlxOHMiCLiJJ/Vu5yP11z7YydwGpLamAa
         Zk3dgODC8I3LS3MLRFYwUCmxuQUKwhUtrWGBt7WGDQX5W+Vfhthp1my9nQNiJpl7EWnL
         spEQ==
X-Gm-Message-State: AOAM533zUFtrHipBF5iHKsS7Gpn6WY6MCVQrfI6181oI4g0kmJN+h1ZJ
        ZWvd0wPpg1qhP86KZiezYjiG/YpcXLE=
X-Google-Smtp-Source: ABdhPJwDoE/CCDuf5D40+4NjR2apoi9XQCXq3ks3cictXPjes/sRiP90/TazxjXoxNp9tWe6xxY6Eg==
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr2476012wmf.149.1610441274134;
        Tue, 12 Jan 2021 00:47:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm3817332wrh.78.2021.01.12.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:53 -0800 (PST)
Message-Id: <e1e9d5c27377cad3009e325bc353271aac31c770.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:42 +0000
Subject: [PATCH 11/11] test-tool i18n: do not complain about empty messages
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

They might, or might not be 'translated'. Let's not assume that they
aren't marked with `_()` for translation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-i18n.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-i18n.c b/t/helper/test-i18n.c
index 8a16df6b40f..82efc66f1f5 100644
--- a/t/helper/test-i18n.c
+++ b/t/helper/test-i18n.c
@@ -52,7 +52,7 @@ static void unrot13_strbuf(struct strbuf *buf)
 {
 	size_t len = unrot13(buf->buf);
 
-	if (len == buf->len)
+	if (len && len == buf->len)
 		die("not ROT13'ed:\n%s", buf->buf);
 	buf->len = len;
 }
-- 
gitgitgadget
