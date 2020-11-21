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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D474C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 18:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2139922202
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 18:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJiVQXkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgKUSbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 13:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgKUSbp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 13:31:45 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969E1C0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 10:31:44 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id p12so13539614ljc.9
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zPufgRiT/vUmgycWyCMOs29nBjPPWDV3tYC75/7HQA=;
        b=YJiVQXkHvZ8jy8kEPNpGtNF8beFmSq51InsIImxICIoen5ooXaEri+E8GLQe53aHpU
         edEq76Tejb6XlvSvFu4dNoalZ1G/qVDUAIEgYyVGmQTwP2J/XVI5LHf0UVIBi7m2EMvX
         RNClEtcnv7bEV9Stl3cnAqVFZvVVN69sNV544RIJ4VQeGQwJY/TqnY3Wp8QV2yJS+avP
         wH8LBHOaC2GZ2hpxWsYIwzdPn5wXWm80DN/qMGAq1E88EPieUnBQ8Ym2zA9SmkV+W25D
         Yo6Arns+GzmMMc1nPEX0aGKcJ7vM4Da42ZZWpf4SWiNe2MPqwnj2+CFvi13pfmB8ALrM
         aswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zPufgRiT/vUmgycWyCMOs29nBjPPWDV3tYC75/7HQA=;
        b=bpeig6oWcA7eqAnvOkh/nTTo2b0rLuCs10hIX0LBkfHaIwPharFmT/HJVhsXmbwmcr
         htgFgeVXRd0RXrCMl0YEcqGiOVtCh9c63COIChCw/6kS4tQjMyBEzemFiwpb9zfy1+ue
         8czelJwpKP41yuPWU287Oag0+x39Eg6lQt/Xm7KRKWGeyv2HgYv2TALbDmcKj9wYOqYY
         tJ9971gbmXbyxyExKp4Cudjw9N8F2VIO3DTqsDG33fG4bS+hup+wyasXbNMulapHVjTf
         09BAIZtrX3l6rUJOjWdXSCRt24KISRDqju9Mp0/o2gsOAyJf00+BlQJ+XGrr/0bKiVRy
         1ygg==
X-Gm-Message-State: AOAM530KE1GXb2TyrRkdvb81ZwhbqvdZr0yFlIESa5Er+Atn1y5zOjsb
        82l3Kb/D5qp7v42qhV/Jnmk+SV3V/PVLPw==
X-Google-Smtp-Source: ABdhPJxXWUm7oDhtRKGNTCXNr086TtdFR1fP3QMtM35laoUCIQJJUiYXwcsSnEHtZ8fU38RkAJynJg==
X-Received: by 2002:a2e:8846:: with SMTP id z6mr10370695ljj.311.1605983502768;
        Sat, 21 Nov 2020 10:31:42 -0800 (PST)
Received: from localhost.localdomain (h-79-136-100-70.NA.cust.bahnhof.se. [79.136.100.70])
        by smtp.gmail.com with ESMTPSA id m7sm786531lfj.113.2020.11.21.10.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 10:31:42 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 3/4] grep: simplify color setup
Date:   Sat, 21 Nov 2020 19:31:09 +0100
Message-Id: <d6e43bc540bc682bb46d54e579a7101d0d2c462d.1605972564.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1605972564.git.martin.agren@gmail.com>
References: <cover.1605972564.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit left us with only one user of the one-line wrapper
`color_set()`. We could inline it, but note how we're `xsnprintf()`-ing
all the entries in one array into another array of the same type. We
might as well just `memcpy()` everything into place.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Cc-ing Peff, who initially introduced this helper. After having inlined
 the function into the for loop, it seemed better to just copy the whole
 array. Happy to hear arguments against.

 Come to think of it, I suppose we could copy the whole struct and not
 just the color array. Hmmm...

 grep.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/grep.c b/grep.c
index 8f2009ec9f..9597cec67e 100644
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
@@ -158,7 +153,6 @@ int grep_config(const char *var, const char *value, void *cb)
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
 	struct grep_opt *def = &grep_defaults;
-	int i;
 
 #if defined(USE_LIBPCRE2)
 	if (!pcre2_global_context)
@@ -189,8 +183,7 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 	opt->relative = def->relative;
 	opt->output = def->output;
 
-	for (i = 0; i < NR_GREP_COLORS; i++)
-		color_set(opt->colors[i], def->colors[i]);
+	memcpy(opt->colors, def->colors, sizeof(def->colors));
 }
 
 void grep_destroy(void)
-- 
2.29.2.454.gaff20da3a2

