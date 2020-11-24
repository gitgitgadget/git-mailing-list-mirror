Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91D1C56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B2720789
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGGFHGyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgKXVE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgKXVE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:04:56 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFB1C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:04:54 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id j205so52802lfj.6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bolLlYRXMxjTbk3CPu0rFIyvty01ZUVyeRrvsybispc=;
        b=OGGFHGyNENsBQMgQOHTlloJV2LCFPPNxgz0GRv2Bjlb342W0cuPBUGrjbHzjjID7Aj
         VCzCiFSZM8d7wFqg6ZFB7Cfv019w2kQMzsUchn12Sbtv9udkP2QJSJO4WQ61WU4s4Sms
         9eBxkjlWJOZaJDajth3lz/W39UiF/uG403r3nfmFxOsHEvF9mY8+Ow8ZbPGRINsT79hz
         LrPauN/KnlFrx/KsWmhs2HyFOZsAdtuI/O+GG6pYyhH2xQirKKjDrYPlOK8Pjde+Sm4i
         LhBsPlVcm52UVnn4ztmfLytoU9QIFAKm72XGBSL/I/BsyXV0th2oLGfdz/FxoDh6hunC
         BLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bolLlYRXMxjTbk3CPu0rFIyvty01ZUVyeRrvsybispc=;
        b=KyBsgZNFNHaBQYKZ1wXgoHQuYVyoFYmO76m3BMjugLCoArbfVvs/GopL7sk9Y4Pixm
         une7dV7C7NB2zYN1aa0AaqV+c0q0yWCZq3c10B5WZbuFUZbwC9p/T74kVuURhzTA4Akg
         A0yiodyWnjkTGwi3EkRtT0PC7EyPu6pwoIskW6qi0GwurgAcVk0c+egAghNwDuT5qPbZ
         ZuuS8HKf79rClfiu9Jrrt1rH0BXbBklNmzFMClvnlTCL6zK0fo076kNdxNAsQYK7xQ3m
         CjRamKxZ6jrvWdo2m2Mwdxh7SHQDgof4aKHSrz7TQFNYstogzTDWaiW2hVPrr2g31t66
         2dLQ==
X-Gm-Message-State: AOAM530EDO27QugCf/+b7hVLLC+wNfQEJb2TY4Qo6zYNP7fvbmUuCLXg
        FTtya1JKT00ERQDvi86/5X3OJEpTp6OY7g==
X-Google-Smtp-Source: ABdhPJwhzbRZU0MRb2fpe99tkzBxi37OgoXqb4rmgd5dV90RZRSd7Jn74H5TYccCOHSGbviEwfjPOA==
X-Received: by 2002:a19:505:: with SMTP id 5mr8935lff.578.1606251892369;
        Tue, 24 Nov 2020 13:04:52 -0800 (PST)
Received: from localhost.localdomain (h-79-136-116-123.NA.cust.bahnhof.se. [79.136.116.123])
        by smtp.gmail.com with ESMTPSA id z20sm22911ljm.138.2020.11.24.13.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:04:51 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 3/4] grep: copy struct in one fell swoop
Date:   Tue, 24 Nov 2020 22:04:15 +0100
Message-Id: <359355fb4eff6d99cb1baad9b72ff96e7dcda51d.1606251358.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1606251357.git.martin.agren@gmail.com>
References: <cover.1605972564.git.martin.agren@gmail.com> <cover.1606251357.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a `struct grep_opt` with our defaults which we then copy into
the caller's struct. Rather than zeroing the target struct and copying
each element one by one, just copy everything at once. This leaves the
code simpler and more maintainable.

We don't have any ownership issues with what we're copying now and can
just greedily copy the whole thing. If and when we do need to handle
such elements (`char *`?), we must and can handle it appropriately. This
commit doesn't really change that.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 grep.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/grep.c b/grep.c
index 8f2009ec9f..7d740452cd 100644
--- a/grep.c
+++ b/grep.c
@@ -66,11 +66,6 @@ static const char *color_grep_slots[] = {
 	[GREP_COLOR_SEP]	    = "separator",
 };
 
-static void color_set(char *dst, const char *color_bytes)
-{
-	xsnprintf(dst, COLOR_MAXLEN, "%s", color_bytes);
-}
-
 static int parse_pattern_type_arg(const char *opt, const char *arg)
 {
 	if (!strcmp(arg, "default"))
@@ -157,9 +152,6 @@ int grep_config(const char *var, const char *value, void *cb)
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
-	struct grep_opt *def = &grep_defaults;
-	int i;
-
 #if defined(USE_LIBPCRE2)
 	if (!pcre2_global_context)
 		pcre2_global_context = pcre2_general_context_create(
@@ -171,26 +163,13 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 	pcre_free = free;
 #endif
 
-	memset(opt, 0, sizeof(*opt));
+	*opt = grep_defaults;
+
 	opt->repo = repo;
 	opt->prefix = prefix;
 	opt->prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
 	opt->pattern_tail = &opt->pattern_list;
 	opt->header_tail = &opt->header_list;
-
-	opt->only_matching = def->only_matching;
-	opt->color = def->color;
-	opt->extended_regexp_option = def->extended_regexp_option;
-	opt->pattern_type_option = def->pattern_type_option;
-	opt->linenum = def->linenum;
-	opt->columnnum = def->columnnum;
-	opt->max_depth = def->max_depth;
-	opt->pathname = def->pathname;
-	opt->relative = def->relative;
-	opt->output = def->output;
-
-	for (i = 0; i < NR_GREP_COLORS; i++)
-		color_set(opt->colors[i], def->colors[i]);
 }
 
 void grep_destroy(void)
-- 
2.29.2.454.gaff20da3a2

