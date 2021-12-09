Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7ADC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhLIKd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbhLIKdt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE0DC061353
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a9so8825779wrr.8
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I1OjuyEdvS7pDHXy+edm6Y3GA0g7nFkP4MZfeMkkBBA=;
        b=m+RkgsLQhTOMxZVHi6sQyIT5+DfmrpCF0WeXlFh9vrbs2ndZWrJdZzHT6E/5ta06MY
         syrOrVXDybsyeh+jCbM+lmXqDWB9KiD9Vi5lOK3rlCAfydejC10lM7Wp8IG1MQXpgXHB
         AtitPN6G/H04anTSe2T4R7Hk0p2aNO+nWoFeT7pJfdTyLxOxojJs3J3bKJgwbtK24LYl
         BBoNLsOTnWM6lnpoJChsrv0a1n42JwvjLZy8O5MoVlwTBLfCQ7RtfYOzoqAWGKwObB5P
         vbvalZVxkuSwtyZ4FM0ad9oVhJn3zNE1OhmXyj2IPJPPIBl7iyhIsG7lIiXLPfXIhREc
         6OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I1OjuyEdvS7pDHXy+edm6Y3GA0g7nFkP4MZfeMkkBBA=;
        b=sAMtDHvhRtFOtqf9gJbB4uSLmC+LjzGYT43HnSgk31tvx7TXoEUVFTHmYWJrbaXfI1
         a6nzV0RsPo4hGKLBgDaJ4McVQKuEl42kUrdYIKpvJXV9Bxrqs/f0Q5270ku3uqHmvl77
         0T8h1eqjfLmxVIEVfW3p++T0Ki3rV/4DfwdjMqCoX09atbds1j8Y+567iyFcl3CjJbZ5
         9bDnS+igNeynmMveFcsLxLJRGrvdIhX9keyIgcbxy+4LcbpWmCVQP0d3FHYghStkZlzv
         z1I3CbRl18/w6m+TfAd4y6N/QdW6Faa0Ig3VmxPI7hEwMu/zu1L+diOCNDCSmJRp1JKW
         pCdw==
X-Gm-Message-State: AOAM530/sFKZpskV7Nf7umhqcvGRIK2Aj7DVBEPFmVDXjL+bzgNL6Kei
        yG1zT8ne2fs97ao1134w67/CnR7hiLE=
X-Google-Smtp-Source: ABdhPJygZVnVGSj55ysFQ8wRC6c3V06J51sGzou7ckZWRAhLITpEAQqBytiwJevjyigy1qbYoE1mUA==
X-Received: by 2002:a5d:4889:: with SMTP id g9mr5439933wrq.455.1639045814009;
        Thu, 09 Dec 2021 02:30:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s24sm4832817wmj.26.2021.12.09.02.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:13 -0800 (PST)
Message-Id: <99e38ba9de9bcd7b767908ec218937ae8c2ccf36.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:29:57 +0000
Subject: [PATCH v5 03/15] diff --color-moved: factor out function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This code is quite heavily indented and having it in its own function
simplifies an upcoming change.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index bd8e4ec9757..09af94e018c 100644
--- a/diff.c
+++ b/diff.c
@@ -1098,6 +1098,38 @@ static int shrink_potential_moved_blocks(struct moved_block *pmb,
 	return rp + 1;
 }
 
+static void fill_potential_moved_blocks(struct diff_options *o,
+					struct hashmap *hm,
+					struct moved_entry *match,
+					struct emitted_diff_symbol *l,
+					struct moved_block **pmb_p,
+					int *pmb_alloc_p, int *pmb_nr_p)
+
+{
+	struct moved_block *pmb = *pmb_p;
+	int pmb_alloc = *pmb_alloc_p, pmb_nr = *pmb_nr_p;
+
+	/*
+	 * The current line is the start of a new block.
+	 * Setup the set of potential blocks.
+	 */
+	hashmap_for_each_entry_from(hm, match, ent) {
+		ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
+		if (o->color_moved_ws_handling &
+		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
+			if (compute_ws_delta(l, match->es, &(pmb[pmb_nr]).wsd))
+				pmb[pmb_nr++].match = match;
+		} else {
+			pmb[pmb_nr].wsd = 0;
+			pmb[pmb_nr++].match = match;
+		}
+	}
+
+	*pmb_p = pmb;
+	*pmb_alloc_p = pmb_alloc;
+	*pmb_nr_p = pmb_nr;
+}
+
 /*
  * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
  *
@@ -1198,23 +1230,8 @@ static void mark_color_as_moved(struct diff_options *o,
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
 		if (pmb_nr == 0) {
-			/*
-			 * The current line is the start of a new block.
-			 * Setup the set of potential blocks.
-			 */
-			hashmap_for_each_entry_from(hm, match, ent) {
-				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
-				if (o->color_moved_ws_handling &
-				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
-					if (compute_ws_delta(l, match->es,
-							     &pmb[pmb_nr].wsd))
-						pmb[pmb_nr++].match = match;
-				} else {
-					pmb[pmb_nr].wsd = 0;
-					pmb[pmb_nr++].match = match;
-				}
-			}
-
+			fill_potential_moved_blocks(
+				o, hm, match, l, &pmb, &pmb_alloc, &pmb_nr);
 			if (adjust_last_block(o, n, block_length) &&
 			    pmb_nr && last_symbol != l->s)
 				flipped_block = (flipped_block + 1) % 2;
-- 
gitgitgadget

