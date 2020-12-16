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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1CCC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B5E2342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbgLPSwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbgLPSwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:06 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC19C0619DA
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:57 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id l11so51012381lfg.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4Gz7gcuIvcWK4ds8gEkioHLwrVtDhE1lPXZR3XduPc=;
        b=igJH56adhUVzxp1AZo1XzL9cPmANj4kDR1JmG8Z1dK3yr7Esu0QU8/pW9lLu+STOzw
         aHU1Izl2J4knsVZn9K1dpa4gvVO5U2z/1QV543CAeNmNeZWwGuKVgb1covu1g+iGujuy
         AnGTTClPM4+pLAFr8Op2kwCQR/ScaGJu4rzCq1rsCdQJk5NE1205wU9ej+FXK1XaBbXj
         YzzEfr749GJ4f/RRTxyXabLAqv1i2PdeT45Eu5g6Olchz5HcNSMSPps0leVlTUADyX7N
         cFK8YsKNc7N+7nW6mfcDSNEOW0WjXs36IANh+SQN/jDwoniMfrPEtdK7ZiVKsYsC5Oct
         BU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4Gz7gcuIvcWK4ds8gEkioHLwrVtDhE1lPXZR3XduPc=;
        b=pwy97keNicRQVQVH1dfy8l2mkEtDvxIlVpsQ51bx+Db/mfhKzUOzLJotOhL7U793NE
         PSaxXpPsDhEDp5Mmyb/tkn3tpLHh3uv4ZaRVZs9apyFwCShcuSYQUXVHeUEE9V5PF7ki
         unYjvhSUWkng3y2MQPHZ2IcHQn+I9+dt4hMMtTWIIAk2Ug08MGCvn6dlbbVTIxBpFgEL
         qkiPJ9lsOx2eJeF6LvPlgXy74Q6I1VmazhEgG79BUL1kaOzGjui+KipnfwRU1q6xfHUw
         wWsbZBHGE4DMyoomzAXFRWZ+9rwZdLCrQt0XGVIIw/dfwS1r3fJzmX1DP0ib442hIrhu
         h7Uw==
X-Gm-Message-State: AOAM530nq1xSeqh6lgtONo0aL7VGF1eQzgyguuuhxqCdh6lpE2Gi5/BG
        QsOZM3st/FhYnvM6/65crrs=
X-Google-Smtp-Source: ABdhPJzyK8WDpWR7XFg0VEbJvBUKDuF2JgUfV9XPymUsTvSuLrwMHyJ1KpiGYr7CscbOXBYYvPAmeQ==
X-Received: by 2002:a2e:91d9:: with SMTP id u25mr14432955ljg.79.1608144655400;
        Wed, 16 Dec 2020 10:50:55 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:54 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 27/33] diff-merges: add old mnemonic counterparts to --diff-merges
Date:   Wed, 16 Dec 2020 21:49:23 +0300
Message-Id: <20201216184929.3924-28-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds --diff-merges={m|c|cc} values that match mnemonics of old
options, for those who are used to them.

Note that, say, --diff-meres=cc behaves differently than --cc, as the
latter implies -p and therefore enables diffs for all the commits,
while the former enables output of diffs for merge commits only.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index ffe20d8daa4a..9492cd2b871d 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -59,11 +59,14 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 	if (0) ;
 	else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
 		set_first_parent(revs);
-	else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
+	else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate") ||
+		 !strcmp(optarg, "m"))
 		set_separate(revs);
-	else if (!strcmp(optarg, "comb")  || !strcmp(optarg, "combined"))
+	else if (!strcmp(optarg, "comb")  || !strcmp(optarg, "combined") ||
+		 !strcmp(optarg, "c"))
 		set_combined(revs);
-	else if (!strcmp(optarg, "dense") || !strcmp(optarg, "dense-combined"))
+	else if (!strcmp(optarg, "dense") || !strcmp(optarg, "dense-combined") ||
+		 !strcmp(optarg, "cc"))
 		set_dense_combined(revs);
 	else
 		die(_("unknown value for --diff-merges: %s"), optarg);
-- 
2.25.1

