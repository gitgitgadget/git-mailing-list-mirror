Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201A7C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhLIKeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbhLIKdz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71755C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a18so8845347wrn.6
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PvZWtTB+saRNvbTicS6KSTgR/AzyDN0INgP6F8z97h4=;
        b=SEB/DiHrirc+e7c7hrV3yqiHDmR3ufTsWgfhfDzUADwr8VEnSNd+4u6vI5KOb76Ciq
         3JDCuVz9AYAMoBtgJRHHWPWJIxcmUpBGxYfSmQ7a/BbBBEffr3MRVm9PB2UQIcF6k3Y1
         U110676/2QHe80bOTwuvHt8P26qspgZ7A+uA9jdM9EqirFecXEcl5Bcwmq6uKedX4EWb
         QaqTPFacAc8xgsm7cvX5EMrlQ8FZSA1mhoy7JA1jZfuvQS/X8w6OvYPTAUc55P42ql+b
         Q26qiYzDDGObo1W9Sk0lkhyjegL0WE3CFM2aqVqHRTPMEKoosUdM4o9ZsfV6bpM4l21/
         wsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PvZWtTB+saRNvbTicS6KSTgR/AzyDN0INgP6F8z97h4=;
        b=QF56s+fYJbPWddI9Qp+03DEFqVWcquIA8opdHHMNtw0OicPKJbD+vzNMevWr3xzBNo
         emPqmrsDS13f4Wia9ufJwz0XMU3uyS8Bwo37fa46wRv99cmLmZJ8qUKs6UcCrK2yJZ5e
         FlYqiA1KrYybAbnA2Ltn8HNr18ferhjV4I4Rjs2GH2IA9QFbi4KbXQwEdso07Lpd7e+q
         87mp0jLAy4qSSOOvYfmQSnTMZy0ZdonB6lM2DneOaObrdDd0GIAmha4fnJaGJFsfswNV
         as0gUtsytzlJrAe5yVywlbEufkZny3HmtZyE/cIGo7rnDHaGo+hKDZr8F2f3xRXyG7LN
         RooA==
X-Gm-Message-State: AOAM531BKJX2DgbNn3x8THOD+KjARBRp72mEyhilbKLBDPsXM2CsR5se
        IziCBeB+nYq//3aseiR3+UgT0uc0TXQ=
X-Google-Smtp-Source: ABdhPJz0OeEY4dcJAePa7r3GuL/jTXM1TU6wrAd4YTcmyXg07qBsFMfRLxAjDa9rnUZup3z6zFP3hw==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr5205329wrj.554.1639045820854;
        Thu, 09 Dec 2021 02:30:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1sm5175640wrz.92.2021.12.09.02.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:20 -0800 (PST)
Message-Id: <6199a01454710f23bb96be9c73564365b77b40e5.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:30:05 +0000
Subject: [PATCH v5 11/15] diff --color-moved: shrink potential moved blocks as
 we go
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

Rather than setting `match` to NULL and then looping over the list of
potential matched blocks for a second time to remove blocks with no
matches just filter out the blocks with no matches as we go.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 44 ++++++++------------------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/diff.c b/diff.c
index 51f092e724e..626fd47aa0e 100644
--- a/diff.c
+++ b/diff.c
@@ -996,12 +996,12 @@ static void add_lines_to_move_detection(struct diff_options *o,
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
@@ -1015,38 +1015,12 @@ static void pmb_advance_or_null(struct diff_options *o,
 			match = cur &&
 				xdiff_compare_lines(cur->es->line, cur->es->len,
 						    l->line, l->len, flags);
-		if (match)
-			pmb[i].match = cur;
-		else
-			moved_block_clear(&pmb[i]);
-	}
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
+		if (match) {
+			pmb[j] = pmb[i];
+			pmb[j++].match = cur;
 		}
 	}
-
-	/* Remember the number of running sets */
-	return rp + 1;
+	*pmb_nr = j;
 }
 
 static void fill_potential_moved_blocks(struct diff_options *o,
@@ -1181,9 +1155,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			continue;
 		}
 
-		pmb_advance_or_null(o, l, pmb, pmb_nr);
-
-		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
+		pmb_advance_or_null(o, l, pmb, &pmb_nr);
 
 		if (pmb_nr == 0) {
 			int contiguous = adjust_last_block(o, n, block_length);
-- 
gitgitgadget

