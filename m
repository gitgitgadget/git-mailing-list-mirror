Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69091C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjAQRNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjAQRMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:12:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C037045238
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:41 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y19so12433379edc.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/mRFhO0OP7MX0zd7H897jix2OcNvcOLPx1m+KhKGN0=;
        b=bMv9gDhTjGD5mP5Vrdr1mug/2ST/Kgp+81b5nmUXUNRwTGs9Pd7JqCDBR6AxAmaFul
         RbdJ2eP5BBLDkEwOoUxhnJ2eLKcrKQra5fV0mfyHjK60YkkxfjJ/ZTFoSWHMmQ7SjZ8u
         8I++gWsCBqYgv5q10wh/BweGDYbTL0GLo3XnyZG8JKLodU8kUvaKsEG/wmMy1FYL/WAH
         3Fu6tHBBWGZdX7HZ+qVW8aJ2cVfKI2wWH1enDmTDUc3AeffcpXSBudh2pJLwgb0w+y5l
         umMvREApiKTAHIvtahTy4+KH/0QpCvU5go9/iER4jQXc3HkUGrW2h8v63alfxtm67Roo
         SWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/mRFhO0OP7MX0zd7H897jix2OcNvcOLPx1m+KhKGN0=;
        b=Y4wVeUizzli8VkOaKQkq3S6tCE3X5KiRWHO8EgGiBRseYvfpqszuq8bx2I4ptIUeVD
         A1At6+IWaihyvAYf2+7/uOzu1BKYpOdub/u/ZSo2Om+E7dT8CP6XZtOQDD9shrzNYj7U
         AB/L+GX5KlYkJq67MSz+i8n79Lwfwnh5DjszPofSVpp/QFyFN5exyJix/EHbhknohGFz
         myTeH4WNEAEy8ztKV+whTOTxAlB+6oyh9fiJDD+3Urz/i9qWRmCeUA+9GvSTL+vwksx4
         ITmVJx/vGl5z3ytbVu2PwitNDEsMOraXGF8Cm24wloyrYZt4kfpV+e0In+tE3ekWL4qg
         IHvg==
X-Gm-Message-State: AFqh2kr2C7PxhTuyAiJSqkfUhHKPvFEkTa4bxg3PB9ilZ3i8CvnURR5P
        E9f1BPzJRbmEwflZXADvx1icbLW+QTwPag==
X-Google-Smtp-Source: AMrXdXvvxfgSrg6j+WcawFlVxB5aaPUiAFJvTyAgLXxTJnSeqfIJFf52ujb5qMj+ATARP+OKdScwrw==
X-Received: by 2002:a05:6402:1f11:b0:496:9d0f:3081 with SMTP id b17-20020a0564021f1100b004969d0f3081mr4139578edb.3.1673975500077;
        Tue, 17 Jan 2023 09:11:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 17/19] grep API: plug memory leaks by freeing "header_list"
Date:   Tue, 17 Jan 2023 18:11:22 +0100
Message-Id: <patch-v4-17.19-8ff63d9095c-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "header_list" struct member was added in [1] it wasn't made
to free the list using loop added for the adjacent "pattern_list"
member, see [2] for when we started freeing it.

This makes e.g. this command leak-free when run on git.git:

	./git -P log -1 --color=always --author=A origin/master

1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
   not union, 2010-01-17)
2. b48fb5b6a95 (grep: free expressions and patterns when done.,
   2006-09-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index a4450df4559..c908535e0d8 100644
--- a/grep.c
+++ b/grep.c
@@ -795,6 +795,7 @@ static void free_grep_pat(struct grep_pat *pattern)
 void free_grep_patterns(struct grep_opt *opt)
 {
 	free_grep_pat(opt->pattern_list);
+	free_grep_pat(opt->header_list);
 
 	if (opt->pattern_expression)
 		free_pattern_expr(opt->pattern_expression);
-- 
2.39.0.1225.g30a3d88132d

