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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC4AC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F6861209
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhGTKAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbhGTJ4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8174CC0613DE
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w13so11996902wmc.3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AE6Zyj9DjecfFGQtzrMFU916Wi+MtRfwgs9nFeFm3Vc=;
        b=Va20QI/+R6+E3QqJhDkcO49PJhUCZbybvJKRGqv700SqD+TGlAzaTTaFvrxWxeaUlb
         AOkW+5l5OZzVIKoO1GhQsO1fPWy+FyBXUd21TLE100jxtted3d520MKLbCda1L1sWy4y
         eunBIEbrQgxs9NKhOAnC++CeRKRz0d7obdNs5MLGoz27UcXonHRDDesAbgJilQlIR8E+
         CXSvzEpyoVpcZ1IbDfKVZroe/QNBuDe9f7ivMNHsvGu+6yJXIQwqFBpIki0thagYJgXz
         BNhd5jikJlXTH+ICFbkSwNRpypBqulCXhPadEazw6QamgqhHVnT6WL/RGjfG1qr8TXxF
         sOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AE6Zyj9DjecfFGQtzrMFU916Wi+MtRfwgs9nFeFm3Vc=;
        b=mkLnKEsrNQKYJpqFTgysVElgZtnwTl28Ohc5udsfMbDpbk5bgLvzEt2u4OVtBibp0V
         HAq/pgJJtJuHo3i8V1UMcq/YotmP9P+p2qFsjvgsl718v3jzgD/dbIkSdLSnT0cCFc5X
         0uOPRXoOAgf+8c9igu5Sj5W627pcFHK1xSLn6XAh5HAu/0y/Be2YUufAue7rG10YMFMn
         CAxK7wY+WNNRucxTevZ1EzRMi7OGcWwE3uc0kScief0aafW687Zy7uJjOua5zjCxIhkE
         N03V44IeiH1JhVFIXoVaO4qgjSbGSLZRIygIp4Moo9MBYq3fBRKvMMLjLLFG8zDi9vHm
         20iA==
X-Gm-Message-State: AOAM531H8FTRXhq1p12ZbndA+sEeQBG6K5v2KERwsOweXnrc3KUlzYcr
        4wlTLNIh19enW5NrAQMrnqgf0/o6/Rc=
X-Google-Smtp-Source: ABdhPJx8jL5OEXALW2xDERICouV21EeUTsmxgmiEo49Fj4y7nBzXzGYpWdQEVm3saoyDPjk7A0F1XQ==
X-Received: by 2002:a05:600c:35d1:: with SMTP id r17mr6729831wmq.98.1626777401202;
        Tue, 20 Jul 2021 03:36:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23sm18355145wms.4.2021.07.20.03.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:40 -0700 (PDT)
Message-Id: <dd365ad115ffcf3ce5b4b14864ac3ff0ac292214.1626777394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:31 +0000
Subject: [PATCH v2 10/12] diff --color-moved-ws=allow-indentation-change:
 improve hash lookups
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

As libxdiff does not have a whitespace flag to ignore the indentation
the code for --color-moved-ws=allow-indentation-change uses
XDF_IGNORE_WHITESPACE and then filters out any hash lookups where
there are non-indentation changes. This filtering is inefficient as
we have to perform another string comparison.

By using the offset data that we have already computed to skip the
indentation we can avoid using XDF_IGNORE_WHITESPACE and safely remove
the extra checks which improves the performance by 11% and paves the
way for the elimination of string comparisons in the next commit.

This change slightly increases the run time of other --color-moved
modes. This could be avoided by using different comparison functions
for the different modes but after the next two commits there is no
measurable benefit in doing so.

Test                                                                  HEAD^             HEAD
--------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41(0.38+0.03)   0.41(0.36+0.04) +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.82(0.76+0.05)   0.84(0.79+0.04) +2.4%
4002.3: diff --color-moved-ws=allow-indentation-change large change   0.91(0.88+0.03)   0.81(0.74+0.06) -11.0%
4002.4: log --no-color-moved --no-color-moved-ws                      1.32(1.21+0.10)   1.31(1.19+0.11) -0.8%
4002.5: log --color-moved --no-color-moved-ws                         1.47(1.37+0.10)   1.47(1.36+0.11) +0.0%
4002.6: log --color-moved-ws=allow-indentation-change                 1.51(1.42+0.09)   1.48(1.37+0.10) -2.0%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 66 +++++++++++++++++-----------------------------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/diff.c b/diff.c
index 4b5776a5a0a..f899083d028 100644
--- a/diff.c
+++ b/diff.c
@@ -850,28 +850,15 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
 }
 
 static int compute_ws_delta(const struct emitted_diff_symbol *a,
-			    const struct emitted_diff_symbol *b,
-			    int *out)
-{
-	int a_len = a->len,
-	    b_len = b->len,
-	    a_off = a->indent_off,
-	    a_width = a->indent_width,
-	    b_off = b->indent_off,
+			    const struct emitted_diff_symbol *b)
+{
+	int a_width = a->indent_width,
 	    b_width = b->indent_width;
 
-	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE) {
-		*out = INDENT_BLANKLINE;
-		return 1;
-	}
-
-	if (a_len - a_off != b_len - b_off ||
-	    memcmp(a->line + a_off, b->line + b_off, a_len - a_off))
-		return 0;
-
-	*out = a_width - b_width;
+	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE)
+		return INDENT_BLANKLINE;
 
-	return 1;
+	return a_width - b_width;
 }
 
 static int cmp_in_block_with_wsd(const struct diff_options *o,
@@ -917,26 +904,17 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 			   const void *keydata)
 {
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
-	const struct moved_entry *a, *b;
+	const struct emitted_diff_symbol *a, *b;
 	unsigned flags = diffopt->color_moved_ws_handling
 			 & XDF_WHITESPACE_FLAGS;
 
-	a = container_of(eptr, const struct moved_entry, ent);
-	b = container_of(entry_or_key, const struct moved_entry, ent);
-
-	if (diffopt->color_moved_ws_handling &
-	    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-		/*
-		 * As there is not specific white space config given,
-		 * we'd need to check for a new block, so ignore all
-		 * white space. The setup of the white space
-		 * configuration for the next block is done else where
-		 */
-		flags |= XDF_IGNORE_WHITESPACE;
+	a = container_of(eptr, const struct moved_entry, ent)->es;
+	b = container_of(entry_or_key, const struct moved_entry, ent)->es;
 
-	return !xdiff_compare_lines(a->es->line, a->es->len,
-				    b->es->line, b->es->len,
-				    flags);
+	return !xdiff_compare_lines(a->line + a->indent_off,
+				    a->len - a->indent_off,
+				    b->line + b->indent_off,
+				    b->len - b->indent_off, flags);
 }
 
 static struct moved_entry *prepare_entry(struct diff_options *o,
@@ -945,7 +923,8 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
-	unsigned int hash = xdiff_hash_string(l->line, l->len, flags);
+	unsigned int hash = xdiff_hash_string(l->line + l->indent_off,
+					      l->len - l->indent_off, flags);
 
 	hashmap_entry_init(&ret->ent, hash);
 	ret->es = l;
@@ -1113,14 +1092,11 @@ static void mark_color_as_moved(struct diff_options *o,
 			hashmap_for_each_entry_from(hm, match, ent) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				if (o->color_moved_ws_handling &
-				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
-					if (compute_ws_delta(l, match->es,
-							     &pmb[pmb_nr].wsd))
-						pmb[pmb_nr++].match = match;
-				} else {
+				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+					pmb[pmb_nr].wsd = compute_ws_delta(l, match->es);
+				else
 					pmb[pmb_nr].wsd = 0;
-					pmb[pmb_nr++].match = match;
-				}
+				pmb[pmb_nr++].match = match;
 			}
 
 			if (adjust_last_block(o, n, block_length) &&
@@ -6240,10 +6216,6 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 		if (o->color_moved) {
 			struct hashmap add_lines, del_lines;
 
-			if (o->color_moved_ws_handling &
-			    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-				o->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
-
 			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
 			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
-- 
gitgitgadget

