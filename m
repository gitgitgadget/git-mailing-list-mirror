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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCD7C433E9
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10A664E68
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBRAIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhBRAIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:08:17 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEABFC061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id x16so4228564wmk.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk4f5Dl5Bn9KLacPnLIkqKgNA90gHQX7iHdNUmNWwEY=;
        b=efSxndHnjLaESwvVKRZvgGNJp6OP1K1MtVagaMVskWnHe8kvF9JkVsepFAe1ZvgiQH
         2xBpHKsGmYa8+Iu2nNOFQZian3d0uDKcW/NBban8ocoQ2RFuUuRF739jSzZwu6Qb1keH
         cNCCBHxjAEqxeDNxaFXk6FzBRTfoOYQaCScsouiivdXm3FUeS7EOrqVnhNGOy4hooBhe
         I0ry70qgxuxlppFWck5n4s2xdfgCu7MjaaDEGm+qzGGKr5nwSeJRGICrcqBnj79cSBX6
         mfhTcN6ViuEWWiR5U1lsrqQdFVJvmo53TdKEf11GqikDspPtBy7EBDruEsqLVn1Wuk4T
         axXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk4f5Dl5Bn9KLacPnLIkqKgNA90gHQX7iHdNUmNWwEY=;
        b=QbL3CzL/evWTB5AU6Dp4qP612aZ891bcoaWS9UBni8NlrLdfuacppaW+UL7QdQQsk1
         64FMV1DplD/HlkF7EbvQs/MQ+6Mkor3hOb63uAHU4mG5DWMTYprTZiXYrgxzrhrfhwQV
         vN10DK5XqX87rjWWIij2zfbdyCloXj73Q+FzF5J3Zi+fS7T6tBibpeZgAga/zDkDCquc
         emeC8mut6WM5T4IxGMI/Fzuhp9tXtM+Gn/ksFIhV1BRCw6gSZkpydv4F8JUCyLpWvpMG
         E3OgucIOl/YdJoZKCzTh6hS/uJFLXt4Vf3iVBmepff9KZmUaeHBva5phh7AyPPF4M5lX
         M1wA==
X-Gm-Message-State: AOAM532udjb6YiRUp+iWQN4I75ojd/2iVoMv8ImkOk7IdQyXEv0e3Vlu
        KZ4m6uW1JJoG4xCuIG2lSGcPSb0XadgPBA==
X-Google-Smtp-Source: ABdhPJzuGFQnzai2QLyFpxqRPbs0+XO7VZhS3ZDl1+8BaKCLgwhmpmg2Bqhvp6QDOqLA5L87Pv29Mg==
X-Received: by 2002:a05:600c:3589:: with SMTP id p9mr1114705wmq.18.1613606853219;
        Wed, 17 Feb 2021 16:07:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm6232795wrx.82.2021.02.17.16.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:07:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] grep/pcre2: drop needless assignment to NULL
Date:   Thu, 18 Feb 2021 01:07:20 +0100
Message-Id: <20210218000728.13995-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com>
References: <20210204210556.25242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a redundant assignment of pcre2_compile_context dating back to
my 94da9193a6e (grep: add support for PCRE v2, 2017-06-01).

In create_grep_pat() we xcalloc() the "grep_pat" struct, so there's no
need to NULL out individual members here.

I think this was probably something left over from an earlier
development version of mine.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/grep.c b/grep.c
index 816e23f17ef..f27c5de7f56 100644
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

