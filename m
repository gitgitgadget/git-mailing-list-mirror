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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D66FC636C9
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AB661003
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhGTJ6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbhGTJ4D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B491FC0613E8
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l7so25438663wrv.7
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vHfyFYpM90A53Br3+lLul75GLpxjAtbZbo0mXWfuLsQ=;
        b=K9nDy1DoSFxPa+o41wXOHygPnHm4g/YOudc74S1EKM0d/YX3aME8Viwy9slHteTuDs
         HOqOsjIm+OUv49J66FKD3srAGN79eEZ3PbZWkwe+kom8Vpfq+y9TGg5C7I9OqiwrazFM
         YbSZSv7s+1BsAyVY9wh4yujCy2BU3Rke4ra1UwFdW6qi2lDaJTA6Dm3NmI+56lUp2NLD
         fcHLQ06Dealq8FR98Q1DL5EJbKbm8G6aZvl6mPhgmX6rG5+kgFZy6x559VHQGpvmlBWs
         o3YwENBDugRu6rBqBGAJUmiky/GytlRhXutxhV4GOkeHWgVRCpKhhfY8SFoS4OBhw53Y
         FK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vHfyFYpM90A53Br3+lLul75GLpxjAtbZbo0mXWfuLsQ=;
        b=sPbt3aj9gRgkg9km1I19PMP1TBbl4QgKRBgVfxmCS//Zfrz2BXvpW1s2s/QYKzNFHI
         kIBrWbG1pk/eJc3aytQDfUQvEof95bZ7f0WK0OBW4Yt1z2ABMLfTpOHMvEJG3xVjdWWL
         N+6eVVS4zjwqq0D+mnNE+kch+zx8yI3h3CBi2T5Tqn4kOy/8clUKV8NA/JNPmTDjJJln
         ypjW74bZk5bcZiU6SMaeDArWXtP2xV9nivQ/taEHvNV+wXEsfGlfoEYGFvEsbKNSQVQo
         DgpxCPQ7F0+8qHTiA4jtM8hOlJO/9jGbqpfd4Y6IclYLwe/8cDqD0cba45SgVl/0c3N0
         la2Q==
X-Gm-Message-State: AOAM530el2mWcoIxOTd+yVuelrLdNnA4YucuBbGYAIU2ZcQROX/0EsOL
        Wztk4PuxL4lri4FWvmZCdWrP0a1g5DI=
X-Google-Smtp-Source: ABdhPJw6/7+1aTVUzp21KibgYUxr7Z2JUFuhjaRhj/4OdSJrcKAfpZnBpE5pk91Bnh/J2uxSbXnq0w==
X-Received: by 2002:adf:e0c4:: with SMTP id m4mr35011996wri.312.1626777398234;
        Tue, 20 Jul 2021 03:36:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm1348729wrc.6.2021.07.20.03.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:37 -0700 (PDT)
Message-Id: <6b7a8aed4ec005b12e041846ba6c4251a2490554.1626777394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:26 +0000
Subject: [PATCH v2 05/12] diff --color-moved-ws=allow-indentation-change:
 simplify and optimize
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
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
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41( 0.38+0.03)   0.41(0.37+0.04)  +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.83( 0.79+0.04)   0.82(0.79+0.02)  -1.2%
4002.3: diff --color-moved-ws=allow-indentation-change large change  13.68(13.59+0.07)   0.92(0.89+0.03) -93.3%
4002.4: log --no-color-moved --no-color-moved-ws                      1.31( 1.22+0.08)   1.31(1.21+0.10)  +0.0%
4002.5: log --color-moved --no-color-moved-ws                         1.47( 1.40+0.07)   1.47(1.36+0.10)  +0.0%
4002.6: log --color-moved-ws=allow-indentation-change                 1.87( 1.77+0.09)   1.50(1.41+0.09) -19.8%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 65 ++++++++++++++++------------------------------------------
 1 file changed, 18 insertions(+), 47 deletions(-)

diff --git a/diff.c b/diff.c
index 77c893b266a..55384449170 100644
--- a/diff.c
+++ b/diff.c
@@ -881,35 +881,20 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 
 static int cmp_in_block_with_wsd(const struct diff_options *o,
 				 const struct moved_entry *cur,
-				 const struct moved_entry *match,
-				 struct moved_block *pmb,
-				 int n)
+				 const struct emitted_diff_symbol *l,
+				 struct moved_block *pmb)
 {
-	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-	int al = cur->es->len, bl = match->es->len, cl = l->len;
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
@@ -918,7 +903,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	 * match those of the current block and that the text of 'l' and 'cur'
 	 * after the indentation match.
 	 */
-	delta = c_width - a_width;
+	delta = b_width - a_width;
 
 	/*
 	 * If the previous lines of this block were all blank then set its
@@ -927,9 +912,8 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	if (pmb->wsd == INDENT_BLANKLINE)
 		pmb->wsd = delta;
 
-	return !(delta == pmb->wsd && al - a_off == cl - c_off &&
-		 !memcmp(a, b, al) && !
-		 memcmp(a + a_off, c + c_off, al - a_off));
+	return !(delta == pmb->wsd && al - a_off == bl - b_off &&
+		 !memcmp(a + a_off, b + b_off, al - a_off));
 }
 
 static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
@@ -1030,36 +1014,23 @@ static void pmb_advance_or_null(struct diff_options *o,
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
+		if (cur && !cmp_in_block_with_wsd(o, cur, l, &pmb[i])) {
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
@@ -1181,7 +1152,7 @@ static void mark_color_as_moved(struct diff_options *o,
 
 		if (o->color_moved_ws_handling &
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-			pmb_advance_or_null_multi_match(o, match, hm, pmb, pmb_nr, n);
+			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
 		else
 			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
 
-- 
gitgitgadget

