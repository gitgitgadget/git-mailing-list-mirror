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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6CFC43333
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5C122E00
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405734AbhALItc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405626AbhALIse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:48:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605DC06179F
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m4so194522wrx.9
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IWJCE3aEwPiWjDl6RkegeJ9uHFGUBjRTKjSijMhrrw0=;
        b=aofkLL7hH5wpdMLtgr6hFZG93ZREpKUg/tIPDBXDOyl7boZ1JWWNlG8PymnzmaWZvT
         bmFR+wacW0eVHhGaDhi1i7yECI4GumWHLGqR45U6DvvMcM57EfRHO0vCtahTd3XsqX5i
         P+PN1TKB5gNsCDLtYNShImY0a6fD2fsT7yJbLPUy9yq2pCargZ++N5Jf8C8O396M587+
         zwX9UDYhRmf7VSzshsfpiOYL6xRJy6TlcLR3H0MZEmpyIf7tTvUoZaqoK71rQi/vMFyP
         ZA9wFeb5IDElqWA3CYoTCrnRnkdHrNaGvDrc2iMQVftDmVbifhm7+wNGRwruyIE+u0dL
         tvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IWJCE3aEwPiWjDl6RkegeJ9uHFGUBjRTKjSijMhrrw0=;
        b=U6usAv2WIRZKcL6z4t1whhdOE6b88e8qTemheBJIyaJgGaRctleVJZPkGBQnYWdTlp
         xB4gy88w/o8+Cpv5gxAtm9eKiTwD59mGTH3NUP62qEeZSny3IvscGKxwTn+iH5UvJcyi
         2Mz/D7iBSteEhFG+w30mV9S22tT9aiiWMLM2OAukl2o5G9Mq3M05wABCfQ/yldlZQl7B
         u44MB0+OJ0jKzx92urCNCBXnMUL9unb1jbMJMtGBUjyGK4M0UqttjLtAop+V+2IY1uNT
         ZZ58U1MmGkyediBr+tA+9fZZvGYhQCP5K9cIpuBG/Q7F7C0JM0Wfjux2gUu8koK9rgu7
         0e3w==
X-Gm-Message-State: AOAM530UbuZhtFWwgOH88nYsMfbJx9gPuawvSpRQDAXWcTai2B8GxT8K
        LfsP8bmJrIMRH0O4dlDs1wgIPZZTKzg=
X-Google-Smtp-Source: ABdhPJxyZWwzXYhgQ63fc8CJ27BKhJUUHH1eg0eA6Izp2Wo5BbxqYO1iypfFs2Q7bplUDGvYjsb5PQ==
X-Received: by 2002:a5d:6cd4:: with SMTP id c20mr3073563wrc.57.1610441268537;
        Tue, 12 Jan 2021 00:47:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm3552852wrt.31.2021.01.12.00.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:48 -0800 (PST)
Message-Id: <8f2c08474a75793c24af7d4ae44d73d2b23920bc.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:35 +0000
Subject: [PATCH 04/11] sha1dc: mark forgotten message for translation
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1dc_git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1dc_git.c b/sha1dc_git.c
index 5c300e812e0..fecf5da1483 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -18,7 +18,7 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
 {
 	if (!SHA1DCFinal(hash, ctx))
 		return;
-	die("SHA-1 appears to be part of a collision attack: %s",
+	die(_("SHA-1 appears to be part of a collision attack: %s"),
 	    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
 }
 
-- 
gitgitgadget

