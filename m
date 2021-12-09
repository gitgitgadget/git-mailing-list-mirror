Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70439C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhLIKeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhLIKdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:53 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC52C0617A1
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso6182374wml.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+/NY0FSLLgoOM2WL1cJXCz+GAAkWsSqC7KSVILVwygw=;
        b=IZZi2DNwcoOaogFj0riIh8SiH1i5CR3Qi9v8Zzs6bl4dv9VsFY4bNfZUsSWnihL8C3
         mbptttCGU/8MKCPv5MhZzK6XYlReVpINzOX3V6GD/6onCrGyH59N2aywiXz/Jdfh2lRh
         TB6QtH5Q71F2X+ASgx692JchnX/R1FqxP9Koc9RZNPFdC18drY0Mt+QabT58wFXDT5+D
         AsU7ca32fo6in3W+PGj6O7PX6ZmNaDdZjU92rVPg92kP3XTnRqlrUhjKFCoxwlRbjTLE
         5XaZa94y7hYTSvCroXglGo+s31HtrTTwh6YdcG3c4IgAVFHAKvD/8MWYRZmo+NhTsH5s
         tAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+/NY0FSLLgoOM2WL1cJXCz+GAAkWsSqC7KSVILVwygw=;
        b=mKuZX+JAZFmluwl1rGD29ERKxM40vfp8DiFJSqKQqj8HMXrvjTQ8det8PC0Y981gVH
         fsyKPhAPfXwxDltJbV3El0nGHqcu1US8lLpndPsNz1BC9ZP57OeAq1vnFqCOQcxNGyvy
         jliuHlOuKePZzf35NEVRHwOqeEnY3Go6GDAUdFPEHpXTq0IP0aPlgZhFQNHBdXAyIdcv
         PFzVEM1eVSqkqVHP4vTnVEeLHrQ5d7BHBtIwgeHW3LkrSkQFBsQxpiH1JeyB9Tt2JGmX
         cMZ4NYJExQ1QJCHtt9NfjEtgNuxV6hd2wm+w3I7W7ue/QHM17MHpTO7mHZeM3ekjVZF4
         X3Sw==
X-Gm-Message-State: AOAM5334h//rJo/x67+2UrlPAmWeSwkhQxu6HqcgMUV35JvizQ6IQWpc
        26oEnTG6psywC5z73aY+qs517i9jhrk=
X-Google-Smtp-Source: ABdhPJzVRR885HEErq3/F2kaOwGLNWmlNnPOhHYPrxe2GA+YrVLdxOJ+LOCifOO9lMwb6sdepAaCnw==
X-Received: by 2002:a1c:447:: with SMTP id 68mr6119040wme.69.1639045818246;
        Thu, 09 Dec 2021 02:30:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm5334302wrm.93.2021.12.09.02.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:17 -0800 (PST)
Message-Id: <eeb633063b7c08aae0f8375bcf41466ad33bcec3.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:30:02 +0000
Subject: [PATCH v5 08/15] diff --color-moved-ws=allow-indentation-change:
 simplify and optimize
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

If we already have a block of potentially moved lines then as we move
down the diff we need to check if the next line of each potentially
moved line matches the current line of the diff. The implementation of
--color-moved-ws=allow-indentation-change was needlessly performing
this check on all the lines in the diff that matched the current line
rather than just the current line. To exacerbate the problem finding
all the other lines in the diff that match the current line involves a
fuzzy lookup so we were wasting even more time performing a second
comparison to filter out the non-matching lines. Fixing this reduces
time to run
  git diff --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
by 93% compared to master and simplifies the code.

Test                                                                  HEAD^              HEAD
---------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.35+0.03)   0.38(0.35+0.03)  +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.86 (0.80+0.06)   0.87(0.83+0.04)  +1.2%
4002.3: diff --color-moved-ws=allow-indentation-change large change  19.01(18.93+0.06)   0.97(0.92+0.04) -94.9%
4002.4: log --no-color-moved --no-color-moved-ws                      1.16 (1.06+0.09)   1.17(1.06+0.10)  +0.9%
4002.5: log --color-moved --no-color-moved-ws                         1.32 (1.25+0.07)   1.32(1.24+0.08)  +0.0%
4002.6: log --color-moved-ws=allow-indentation-change                 1.71 (1.64+0.06)   1.36(1.25+0.10) -20.5%

Test                                                                  master             HEAD
---------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.33+0.05)   0.38(0.35+0.03)  +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.80 (0.75+0.04)   0.87(0.83+0.04)  +8.7%
4002.3: diff --color-moved-ws=allow-indentation-change large change  14.20(14.15+0.05)   0.97(0.92+0.04) -93.2%
4002.4: log --no-color-moved --no-color-moved-ws                      1.15 (1.05+0.09)   1.17(1.06+0.10)  +1.7%
4002.5: log --color-moved --no-color-moved-ws                         1.30 (1.19+0.11)   1.32(1.24+0.08)  +1.5%
4002.6: log --color-moved-ws=allow-indentation-change                 1.70 (1.63+0.06)   1.36(1.25+0.10) -20.0%

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 70 +++++++++++++++++-----------------------------------------
 1 file changed, 20 insertions(+), 50 deletions(-)

diff --git a/diff.c b/diff.c
index 9aff167be27..78a486021ab 100644
--- a/diff.c
+++ b/diff.c
@@ -879,37 +879,21 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 	return 1;
 }
 
-static int cmp_in_block_with_wsd(const struct diff_options *o,
-				 const struct moved_entry *cur,
-				 const struct moved_entry *match,
-				 struct moved_block *pmb,
-				 int n)
-{
-	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-	int al = cur->es->len, bl = match->es->len, cl = l->len;
+static int cmp_in_block_with_wsd(const struct moved_entry *cur,
+				 const struct emitted_diff_symbol *l,
+				 struct moved_block *pmb)
+{
+	int al = cur->es->len, bl = l->len;
 	const char *a = cur->es->line,
-		   *b = match->es->line,
-		   *c = l->line;
+		   *b = l->line;
 	int a_off = cur->es->indent_off,
 	    a_width = cur->es->indent_width,
-	    c_off = l->indent_off,
-	    c_width = l->indent_width;
+	    b_off = l->indent_off,
+	    b_width = l->indent_width;
 	int delta;
 
-	/*
-	 * We need to check if 'cur' is equal to 'match'.  As those
-	 * are from the same (+/-) side, we do not need to adjust for
-	 * indent changes. However these were found using fuzzy
-	 * matching so we do have to check if they are equal. Here we
-	 * just check the lengths. We delay calling memcmp() to check
-	 * the contents until later as if the length comparison for a
-	 * and c fails we can avoid the call all together.
-	 */
-	if (al != bl)
-		return 1;
-
 	/* If 'l' and 'cur' are both blank then they match. */
-	if (a_width == INDENT_BLANKLINE && c_width == INDENT_BLANKLINE)
+	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE)
 		return 0;
 
 	/*
@@ -918,7 +902,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	 * match those of the current block and that the text of 'l' and 'cur'
 	 * after the indentation match.
 	 */
-	delta = c_width - a_width;
+	delta = b_width - a_width;
 
 	/*
 	 * If the previous lines of this block were all blank then set its
@@ -927,9 +911,8 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	if (pmb->wsd == INDENT_BLANKLINE)
 		pmb->wsd = delta;
 
-	return !(delta == pmb->wsd && al - a_off == cl - c_off &&
-		 !memcmp(a, b, al) && !
-		 memcmp(a + a_off, c + c_off, al - a_off));
+	return !(delta == pmb->wsd && al - a_off == bl - b_off &&
+		 !memcmp(a + a_off, b + b_off, al - a_off));
 }
 
 static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
@@ -1030,36 +1013,23 @@ static void pmb_advance_or_null(struct diff_options *o,
 }
 
 static void pmb_advance_or_null_multi_match(struct diff_options *o,
-					    struct moved_entry *match,
-					    struct hashmap *hm,
+					    struct emitted_diff_symbol *l,
 					    struct moved_block *pmb,
-					    int pmb_nr, int n)
+					    int pmb_nr)
 {
 	int i;
-	char *got_match = xcalloc(1, pmb_nr);
-
-	hashmap_for_each_entry_from(hm, match, ent) {
-		for (i = 0; i < pmb_nr; i++) {
-			struct moved_entry *prev = pmb[i].match;
-			struct moved_entry *cur = (prev && prev->next_line) ?
-					prev->next_line : NULL;
-			if (!cur)
-				continue;
-			if (!cmp_in_block_with_wsd(o, cur, match, &pmb[i], n))
-				got_match[i] |= 1;
-		}
-	}
 
 	for (i = 0; i < pmb_nr; i++) {
-		if (got_match[i]) {
+		struct moved_entry *prev = pmb[i].match;
+		struct moved_entry *cur = (prev && prev->next_line) ?
+			prev->next_line : NULL;
+		if (cur && !cmp_in_block_with_wsd(cur, l, &pmb[i])) {
 			/* Advance to the next line */
-			pmb[i].match = pmb[i].match->next_line;
+			pmb[i].match = cur;
 		} else {
 			moved_block_clear(&pmb[i]);
 		}
 	}
-
-	free(got_match);
 }
 
 static int shrink_potential_moved_blocks(struct moved_block *pmb,
@@ -1223,7 +1193,7 @@ static void mark_color_as_moved(struct diff_options *o,
 
 		if (o->color_moved_ws_handling &
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-			pmb_advance_or_null_multi_match(o, match, hm, pmb, pmb_nr, n);
+			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
 		else
 			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
 
-- 
gitgitgadget

