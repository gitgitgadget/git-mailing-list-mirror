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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD466C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D2261283
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhFNNHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhFNNG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:06:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A21C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:04:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l2so14516735wrw.6
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d0ZRf0yV2pYUnC+xy6L0k5B18+nFxkuXYdpzbS0ZhZs=;
        b=veD7GyDVj7O0sVSq3Ls/IrTx4LQEeN8qxciBBz6FScF//hFUR6zSY6eMyJTG0BbsOr
         POPFSaYGl+W4j1ImP2R0CAYiY5xlcsJzI5dUYU0GY9uk0RABTU0hDFv4SLHsNW6hZzpn
         03uG7S2Aftpu0kIctt75OjtcrC42gwj5zI0l+8xHd3zx0PoOGguNnpt7nCefHDRH5099
         AypzFCZCdku8Ka3pnXYUTVTrXUd80/81LLT4ogcFgZ3+TFDCxstfJfszqcV8E9xa/eB7
         BmDnPZLuDwFmHN6h8YkV6dEayytk60w7O/9tFpKUdpmGxWQLC/5Elkb1kWDKxMXFafqu
         xpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d0ZRf0yV2pYUnC+xy6L0k5B18+nFxkuXYdpzbS0ZhZs=;
        b=tdFckSNM83prPne+HHlgx4N2O+nygPm1vxUjp92Qp+gOtAjIXLT8rS5KRMyxqLV/+/
         en9HbccYcbn2dkEWdJhKoRUeNeUh8GbjNeKHqD+n3VZa0fDYyK9MzxyNXAut6fRSpckQ
         r2s7CRU9geIXMrPLBHDPtcUvBQnn/E17juZTAdrgF9g8RWcN3a7Z+vwC2q+mnX2HjeLM
         PaK8h8XqF8m8cxg3Z1giu9bXsSKZD34EVHXERxjQz5YRpCD9u7L4Rg9pRIWT2O6jdNqx
         1zj/X6oYFTRFQKqpiHAN6IEpXvjnR6p2xey0bgQ2GLuvR1YKOV7q6SRBETPQ0BdRmugW
         0V8g==
X-Gm-Message-State: AOAM530D93QARHB2SBJB9f1rJFNUmO8u/DHMGCHIHDSEOw39d2gZtwOa
        tVyZynFT35bE4MH/HrmMRYgnN6y0LaY=
X-Google-Smtp-Source: ABdhPJwIdynJ+ML8Q3xYkjkkZMOmG23TlrgSyGT6MJgwqfEBdMPjKY9eohTRX7J6ALVurj9/tz1eAA==
X-Received: by 2002:adf:b650:: with SMTP id i16mr18801886wre.205.1623675894446;
        Mon, 14 Jun 2021 06:04:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm16325470wrt.86.2021.06.14.06.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:04:54 -0700 (PDT)
Message-Id: <9390e9a66ebf3c2ccd2b47958134dee8c3c9c553.1623675889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.git.1623675888.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 13:04:45 +0000
Subject: [PATCH 07/10] diff --color-moved: shrink potential moved blocks as we
 go
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rather than setting `match` to NULL and then looping over the list of
potential matched blocks for a second time to remove blocks with no
matches just filter out the blocks with no matches as we go.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 42 ++++++------------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/diff.c b/diff.c
index de6522a3a860..f60cce654c14 100644
--- a/diff.c
+++ b/diff.c
@@ -997,12 +997,12 @@ static void add_lines_to_move_detection(struct diff_options *o,
 static void pmb_advance_or_null(struct diff_options *o,
 				struct emitted_diff_symbol *l,
 				struct moved_block *pmb,
-				int pmb_nr)
+				int *pmb_nr)
 {
-	int i;
+	int i, j;
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
-	for (i = 0; i < pmb_nr; i++) {
+	for (i = 0, j = 0; i < *pmb_nr; i++) {
 		int match;
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
@@ -1017,37 +1017,9 @@ static void pmb_advance_or_null(struct diff_options *o,
 				xdiff_compare_lines(cur->es->line, cur->es->len,
 						    l->line, l->len, flags);
 		if (match)
-			pmb[i].match = cur;
-		else
-			moved_block_clear(&pmb[i]);
+			pmb[j++].match = cur;
 	}
-}
-
-static int shrink_potential_moved_blocks(struct moved_block *pmb,
-					 int pmb_nr)
-{
-	int lp, rp;
-
-	/* Shrink the set of potential block to the remaining running */
-	for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
-		while (lp < pmb_nr && pmb[lp].match)
-			lp++;
-		/* lp points at the first NULL now */
-
-		while (rp > -1 && !pmb[rp].match)
-			rp--;
-		/* rp points at the last non-NULL */
-
-		if (lp < pmb_nr && rp > -1 && lp < rp) {
-			pmb[lp] = pmb[rp];
-			memset(&pmb[rp], 0, sizeof(pmb[rp]));
-			rp--;
-			lp++;
-		}
-	}
-
-	/* Remember the number of running sets */
-	return rp + 1;
+	*pmb_nr = j;
 }
 
 /*
@@ -1140,9 +1112,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			continue;
 		}
 
-		pmb_advance_or_null(o, l, pmb, pmb_nr);
-
-		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
+		pmb_advance_or_null(o, l, pmb, &pmb_nr);
 
 		if (pmb_nr == 0) {
 			/*
-- 
gitgitgadget

