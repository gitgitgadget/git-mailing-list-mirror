Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EC1C43381
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8364264F87
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhBCD3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBCD3B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AFBC061786
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u14so704509wri.3
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nb2aFZd97c/wh37Gd4ijmsU13GYAH3g2f72fzvQUjWA=;
        b=mv2KubqOjpoo48K3jFMSeZ1xdNA5HY1NhjC1pMYKBaIXVybuDRWGbsltUQAONd2PN/
         xtovtc04PKhojHp9Q813v2Lt0ceRKRPXl6KQ//QpQ0y/srDwB6ktyeWzJLptaIFsRQP1
         v9jZTOwk9B8ZWTv7IwwqIcnwgD1mCGLPp4IgRP2fjhFXZPimPJ8GTwgldaK+XP2ta5af
         H/ur0HJEKYWx7CKxu94Kxt5WAiQT1ER3vyhtT0HkIqrW184oSMB1b8hr6qDpQiC6Z1/U
         qedeqt2HkvrAABYavw8I7uYw5l36bLHhMBVHOncl8g5xqv2s5afzRE9HwBQc6nySkhTC
         YVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nb2aFZd97c/wh37Gd4ijmsU13GYAH3g2f72fzvQUjWA=;
        b=QZpMReACFsOSpHnaksrwnSAcQC8ZhrxXjzLgAma3wjLyPqw0X6gk5CuqRsIcvuDSXS
         wmL5ZVD8rNmOhPie3NOlOQrftOcTfT8VLfzuXYQIxdnYxY6jzr4mnsAp5KcYXdzTk4NR
         XdyopnXE53Se+oTjc2R6xDCo+FdntRkRHTkki2PLaHDRxT3XiZVKrGZYk64XJ/1lWj/8
         djKZ0Tp8iNwz1+ktniMwNmLXLdYYKXJkcbUhchaqB8cneUEF8/kyaCZdi7Ii0Pu9+Dtj
         fLTfYqK7R3t9B97CODlPz024+tOwe5QrDxxZc41YA938vgAg2rg2AYwIjwqLGBt/HBwh
         Qyuw==
X-Gm-Message-State: AOAM530DYOrrS+0Sgtte6OwZqNBDt27gwA5Eyy3zDEyx2vZ/GXmKca50
        O3JTANi81CK6IT9zmmGenvJCsyn38TiLqw==
X-Google-Smtp-Source: ABdhPJwnM/PnbLcPB5WSdQtvqAwCNpfH+FR+UVaMta9xnAmFp23plRITHM/2/ZXPtmMeR6KmrTwMXQ==
X-Received: by 2002:adf:e511:: with SMTP id j17mr1059024wrm.17.1612322899430;
        Tue, 02 Feb 2021 19:28:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/25] grep/pcre2: drop needless assignment to NULL
Date:   Wed,  3 Feb 2021 04:27:49 +0100
Message-Id: <20210203032811.14979-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a redundant assignment of pcre2_compile_context dating back to
my 94da9193a6e (grep: add support for PCRE v2, 2017-06-01). In
create_grep_pat() we xcalloc() the "grep_pat" struct, so there's no
need to NULL out individual members here.

I think this was probably something left over from an earlier
development version of mine.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/grep.c b/grep.c
index 816e23f17e..f27c5de7f5 100644
--- a/grep.c
+++ b/grep.c
@@ -373,8 +373,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int patinforet;
 	size_t jitsizearg;
 
-	p->pcre2_compile_context = NULL;
-
 	/* pcre2_global_context is initialized in append_grep_pattern */
 	if (opt->ignore_case) {
 		if (!opt->ignore_locale && has_non_ascii(p->pattern)) {
-- 
2.30.0.284.gd98b1dd5eaa7

