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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF02C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4059061209
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhGTKAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbhGTJ40 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98EEC0613F0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so1190293wmb.3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QwhwOsthjJJ1IU4SpZfdMl4dOFcRAB8QDVFJjogy7O8=;
        b=I8gjdpyG2UltVo1XmX+6VN8koJ6pJQ0lEfGu7fN9BweP3JsZX+fphI3Y3LdI1aaqCz
         Zpfn9pFQ/VTIun192hzd1I7PFpxCj4m4kPee/XcknynfTSa2B8SVERlB7Kfqa7KT2GEE
         rmojBTVr9pz78cIYtV+Dpa37Y1DgQCHP69JIWjfoi+uWyAShQ628Wyz7P4A4AGbK/U2W
         xbaTlnVPSb8P1R5rf4txJfL72amhxQ/dCzhVbkhBlobwedMsNig2wj1NHhhyamxTruFv
         gL4qNVlQx0+3Cle0q4KCfSKnzRT7KM0NBnVFx34Q7bj9MVDHRmhR67rD216ralvNfYic
         aqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QwhwOsthjJJ1IU4SpZfdMl4dOFcRAB8QDVFJjogy7O8=;
        b=anpLJqT/uL5lMepngm8zTOPaCvNBk6wEJ2vpMuuHZNs0Ialgn6t8zLx1SRGNwa54kw
         QY5wowEVS/OdoDSQ9noLZUWBnXUl9QgzqBcaqE3OiIgXi1v1jLrzKFpu0cTL5O7/pmoY
         XYI38UI2pmwb1IEv8Dj/p1Fsla3qSQfn9xAoNbxEQN9NHrVuin7p0Q0Nv9DWxg0iwZAC
         RwSIQzOW6cR979g6kI1NknmCHEXcUVetjbFfFS2jV6TJ66yBaDAePc3Q4aNADng5cMPl
         rRFgOAk2qko0sduKG5JBJmjGYMSBTJxpcBAhqbA4quvMiQOKy7lRH36xIAjCvLwZ4Ozn
         8h/Q==
X-Gm-Message-State: AOAM531VTyZXvTqaF8QHjbvW9+33DbDGJ8+SsqWKY4PAIyQvAl7tabZa
        GsIxA3t8BDjP8OAvLoxflRpDpwZqCDE=
X-Google-Smtp-Source: ABdhPJyyxjiVdinozrf5CXQJIeW27+UojL0ob2fETIquYpu9j8oCcHsmNNWDwWe/61NxB28OVciH7A==
X-Received: by 2002:a05:600c:2105:: with SMTP id u5mr30634589wml.18.1626777402363;
        Tue, 20 Jul 2021 03:36:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17sm23845659wrv.2.2021.07.20.03.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:42 -0700 (PDT)
Message-Id: <753554587f9bbe22e9f32a245b551ab1f38ea1bd.1626777394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:33 +0000
Subject: [PATCH v2 12/12] diff --color-moved: intern strings
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

Taking inspiration from xdl_classify_record() assign an id to each
addition and deletion such that lines that match for the current
--color-moved-ws mode share the same unique id. This reduces the
number of hash lookups a little (calculating the ids still involves
one hash lookup per line) but the main benefit is that when growing
blocks of potentially moved lines we can replace string comparisons
which involve chasing a pointer with a simple integer comparison.

On a large diff this commit reduces the time to run
   diff --color-moved
by 33% and
    diff --color-moved-ws=allow-indentation-change
by 26%. Compared to master the time to run
    diff --color-moved-ws=allow-indentation-change
is now reduced by 95% and the overhead compared to --no-color-moved is
reduced to 50%.

Compared to the previous commit the time to run
    git log --patch --color-moved
is increased slightly, but compared to master there is no change in
run time.

Test                                                                  HEAD^             HEAD
--------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41(0.36+0.04)   0.41(0.37+0.03)  +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.83(0.79+0.03)   0.55(0.52+0.03) -33.7%
4002.3: diff --color-moved-ws=allow-indentation-change large change   0.81(0.77+0.04)   0.60(0.55+0.05) -25.9%
4002.4: log --no-color-moved --no-color-moved-ws                      1.30(1.20+0.09)   1.31(1.22+0.08)  +0.8%
4002.5: log --color-moved --no-color-moved-ws                         1.46(1.35+0.11)   1.47(1.30+0.16)  +0.7%
4002.6: log --color-moved-ws=allow-indentation-change                 1.46(1.38+0.07)   1.47(1.34+0.13)  +0.7%

Test                                                                  master            HEAD
--------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.40( 0.36+0.03)  0.41(0.37+0.03)  +2.5%
4002.2: diff --color-moved --no-color-moved-ws large change           0.82( 0.77+0.04)  0.55(0.52+0.03) -32.9%
4002.3: diff --color-moved-ws=allow-indentation-change large change  14.10(14.04+0.04)  0.60(0.55+0.05) -95.7%
4002.4: log --no-color-moved --no-color-moved-ws                      1.31( 1.21+0.09)  1.31(1.22+0.08)  +0.0%
4002.5: log --color-moved --no-color-moved-ws                         1.47( 1.37+0.09)  1.47(1.30+0.16)  +0.0%
4002.6: log --color-moved-ws=allow-indentation-change                 1.86( 1.76+0.10)  1.47(1.34+0.13) -21.0%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 171 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 95 insertions(+), 76 deletions(-)

diff --git a/diff.c b/diff.c
index 31a20a34240..2956c8f7103 100644
--- a/diff.c
+++ b/diff.c
@@ -18,6 +18,7 @@
 #include "submodule-config.h"
 #include "submodule.h"
 #include "hashmap.h"
+#include "mem-pool.h"
 #include "ll-merge.h"
 #include "string-list.h"
 #include "strvec.h"
@@ -772,6 +773,7 @@ struct emitted_diff_symbol {
 	int flags;
 	int indent_off;   /* Offset to first non-whitespace character */
 	int indent_width; /* The visual width of the indentation */
+	unsigned id;
 	enum diff_symbol s;
 };
 #define EMITTED_DIFF_SYMBOL_INIT {NULL}
@@ -797,9 +799,9 @@ static void append_emitted_diff_symbol(struct diff_options *o,
 }
 
 struct moved_entry {
-	struct hashmap_entry ent;
 	const struct emitted_diff_symbol *es;
 	struct moved_entry *next_line;
+	struct moved_entry *next_match;
 };
 
 struct moved_block {
@@ -866,24 +868,24 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 				 const struct emitted_diff_symbol *l,
 				 struct moved_block *pmb)
 {
-	int al = cur->es->len, bl = l->len;
-	const char *a = cur->es->line,
-		   *b = l->line;
-	int a_off = cur->es->indent_off,
-	    a_width = cur->es->indent_width,
-	    b_off = l->indent_off,
-	    b_width = l->indent_width;
+	int a_width = cur->es->indent_width, b_width = l->indent_width;
 	int delta;
 
-	/* If 'l' and 'cur' are both blank then they match. */
-	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE)
+	/* The text of each line must match */
+	if (cur->es->id != l->id)
+		return 1;
+
+	/*
+	 * If 'l' and 'cur' are both blank then we don't need to check the
+	 * indent. We only need to check cur as we know the strings match.
+	 * */
+	if (a_width == INDENT_BLANKLINE)
 		return 0;
 
 	/*
 	 * The indent changes of the block are known and stored in pmb->wsd;
 	 * however we need to check if the indent changes of the current line
-	 * match those of the current block and that the text of 'l' and 'cur'
-	 * after the indentation match.
+	 * match those of the current block.
 	 */
 	delta = b_width - a_width;
 
@@ -894,22 +896,26 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	if (pmb->wsd == INDENT_BLANKLINE)
 		pmb->wsd = delta;
 
-	return !(delta == pmb->wsd && al - a_off == bl - b_off &&
-		 !memcmp(a + a_off, b + b_off, al - a_off));
+	return delta != pmb->wsd;
 }
 
-static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
-			   const struct hashmap_entry *eptr,
-			   const struct hashmap_entry *entry_or_key,
-			   const void *keydata)
+struct interned_diff_symbol {
+	struct hashmap_entry ent;
+	struct emitted_diff_symbol *es;
+};
+
+static int interned_diff_symbol_cmp(const void *hashmap_cmp_fn_data,
+				    const struct hashmap_entry *eptr,
+				    const struct hashmap_entry *entry_or_key,
+				    const void *keydata)
 {
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
 	const struct emitted_diff_symbol *a, *b;
 	unsigned flags = diffopt->color_moved_ws_handling
 			 & XDF_WHITESPACE_FLAGS;
 
-	a = container_of(eptr, const struct moved_entry, ent)->es;
-	b = container_of(entry_or_key, const struct moved_entry, ent)->es;
+	a = container_of(eptr, const struct interned_diff_symbol, ent)->es;
+	b = container_of(entry_or_key, const struct interned_diff_symbol, ent)->es;
 
 	return !xdiff_compare_lines(a->line + a->indent_off,
 				    a->len - a->indent_off,
@@ -917,55 +923,81 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 				    b->len - b->indent_off, flags);
 }
 
-static struct moved_entry *prepare_entry(struct diff_options *o,
-					 int line_no)
+static void prepare_entry(struct diff_options *o, struct emitted_diff_symbol *l,
+			  struct interned_diff_symbol *s)
 {
-	struct moved_entry *ret = xmalloc(sizeof(*ret));
-	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 	unsigned int hash = xdiff_hash_string(l->line + l->indent_off,
 					      l->len - l->indent_off, flags);
 
-	hashmap_entry_init(&ret->ent, hash);
-	ret->es = l;
-	ret->next_line = NULL;
-
-	return ret;
+	hashmap_entry_init(&s->ent, hash);
+	s->es = l;
 }
 
-static void add_lines_to_move_detection(struct diff_options *o,
-					struct hashmap *add_lines,
-					struct hashmap *del_lines)
+struct moved_entry_list {
+	struct moved_entry *add, *del;
+};
+
+static struct moved_entry_list *add_lines_to_move_detection(struct diff_options *o,
+							    struct mem_pool *entry_mem_pool)
 {
 	struct moved_entry *prev_line = NULL;
-
+	struct mem_pool interned_pool;
+	struct hashmap interned_map;
+	struct moved_entry_list *entry_list = NULL;
+	size_t entry_list_alloc = 0;
+	unsigned id = 0;
 	int n;
+
+	hashmap_init(&interned_map, interned_diff_symbol_cmp, o, 8096);
+	mem_pool_init(&interned_pool, 1024 * 1024);
+
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
-		struct hashmap *hm;
-		struct moved_entry *key;
+		struct interned_diff_symbol key;
+		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
+		struct interned_diff_symbol *s;
+		struct moved_entry *entry;
 
-		switch (o->emitted_symbols->buf[n].s) {
-		case DIFF_SYMBOL_PLUS:
-			hm = add_lines;
-			break;
-		case DIFF_SYMBOL_MINUS:
-			hm = del_lines;
-			break;
-		default:
+		if (l->s != DIFF_SYMBOL_PLUS && l->s != DIFF_SYMBOL_MINUS) {
 			prev_line = NULL;
 			continue;
 		}
 
 		if (o->color_moved_ws_handling &
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-			fill_es_indent_data(&o->emitted_symbols->buf[n]);
-		key = prepare_entry(o, n);
-		if (prev_line && prev_line->es->s == o->emitted_symbols->buf[n].s)
-			prev_line->next_line = key;
+			fill_es_indent_data(l);
 
-		hashmap_add(hm, &key->ent);
-		prev_line = key;
+		prepare_entry(o, l, &key);
+		s = hashmap_get_entry(&interned_map, &key, ent, &key.ent);
+		if (s) {
+			l->id = s->es->id;
+		} else {
+			l->id = id;
+			ALLOC_GROW_BY(entry_list, id, 1, entry_list_alloc);
+			hashmap_add(&interned_map,
+				    memcpy(mem_pool_alloc(&interned_pool,
+							  sizeof(key)),
+					   &key, sizeof(key)));
+		}
+		entry = mem_pool_alloc(entry_mem_pool, sizeof(*entry));
+		entry->es = l;
+		entry->next_line = NULL;
+		if (prev_line && prev_line->es->s == l->s)
+			prev_line->next_line = entry;
+		prev_line = entry;
+		if (l->s == DIFF_SYMBOL_PLUS) {
+			entry->next_match = entry_list[l->id].add;
+			entry_list[l->id].add = entry;
+		} else {
+			entry->next_match = entry_list[l->id].del;
+			entry_list[l->id].del = entry;
+		}
 	}
+
+	hashmap_clear(&interned_map);
+	mem_pool_discard(&interned_pool, 0);
+
+	return entry_list;
 }
 
 static void pmb_advance_or_null(struct diff_options *o,
@@ -974,7 +1006,6 @@ static void pmb_advance_or_null(struct diff_options *o,
 				int *pmb_nr)
 {
 	int i, j;
-	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
 	for (i = 0, j = 0; i < *pmb_nr; i++) {
 		int match;
@@ -987,9 +1018,8 @@ static void pmb_advance_or_null(struct diff_options *o,
 			match = cur &&
 				!cmp_in_block_with_wsd(o, cur, l, &pmb[i]);
 		else
-			match = cur &&
-				xdiff_compare_lines(cur->es->line, cur->es->len,
-						    l->line, l->len, flags);
+			match = cur && cur->es->id == l->id;
+
 		if (match)
 			pmb[j++].match = cur;
 	}
@@ -1034,8 +1064,7 @@ static int adjust_last_block(struct diff_options *o, int n, int block_length)
 
 /* Find blocks of moved code, delegate actual coloring decision to helper */
 static void mark_color_as_moved(struct diff_options *o,
-				struct hashmap *add_lines,
-				struct hashmap *del_lines)
+				struct moved_entry_list *entry_list)
 {
 	struct moved_block *pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
@@ -1044,23 +1073,15 @@ static void mark_color_as_moved(struct diff_options *o,
 
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
-		struct hashmap *hm = NULL;
-		struct moved_entry *key;
 		struct moved_entry *match = NULL;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
 
 		switch (l->s) {
 		case DIFF_SYMBOL_PLUS:
-			hm = del_lines;
-			key = prepare_entry(o, n);
-			match = hashmap_get_entry(hm, key, ent, NULL);
-			free(key);
+			match = entry_list[l->id].del;
 			break;
 		case DIFF_SYMBOL_MINUS:
-			hm = add_lines;
-			key = prepare_entry(o, n);
-			match = hashmap_get_entry(hm, key, ent, NULL);
-			free(key);
+			match = entry_list[l->id].add;
 			break;
 		default:
 			flipped_block = 0;
@@ -1089,7 +1110,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			 * The current line is the start of a new block.
 			 * Setup the set of potential blocks.
 			 */
-			hashmap_for_each_entry_from(hm, match, ent) {
+			for (; match; match = match->next_match) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				if (o->color_moved_ws_handling &
 				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
@@ -6216,20 +6237,18 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 
 	if (o->emitted_symbols) {
 		if (o->color_moved) {
-			struct hashmap add_lines, del_lines;
-
-			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
-			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
+			struct mem_pool entry_pool;
+			struct moved_entry_list *entry_list;
 
-			add_lines_to_move_detection(o, &add_lines, &del_lines);
-			mark_color_as_moved(o, &add_lines, &del_lines);
+			mem_pool_init(&entry_pool, 1024 * 1024);
+			entry_list = add_lines_to_move_detection(o,
+								 &entry_pool);
+			mark_color_as_moved(o, entry_list);
 			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
 				dim_moved_lines(o);
 
-			hashmap_clear_and_free(&add_lines, struct moved_entry,
-						ent);
-			hashmap_clear_and_free(&del_lines, struct moved_entry,
-						ent);
+			mem_pool_discard(&entry_pool, 0);
+			free(entry_list);
 		}
 
 		for (i = 0; i < esm.nr; i++)
-- 
gitgitgadget
