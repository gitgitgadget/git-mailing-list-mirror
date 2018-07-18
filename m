Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D831F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeGRULp (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:45 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:55733 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbeGRULp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:45 -0400
Received: by mail-it0-f74.google.com with SMTP id e21-v6so3407550itc.5
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=y9zTxIcArdZsrMHv4lX8i7pMiLkfPfjq8XzPLwLbJp0=;
        b=n7KU48oftpOzJhOzae/djTzXST4DeeVWYAUvF4ATc62fLHRw0kh6nn2WwxaWRZSI07
         i+D8Mz+t9U/AIixPxaWcF7KmQXZI6M1jBjOYGnkn2ho+e0oUFO6G7WfcRo17kt9MlbJ8
         4kbIrBmm2MwWAfI1N9LeYtQAPkK0D3yuGD4l3d1JJ1Nntb7l5jUw5Dh3gV25a72Yt10A
         amvW2EI+MmYZazUNPi3XtFy6BkM6afFts9OSUItY0SMEBoWeqaOxok97ykmvIUHmd+Lp
         yuDxsjdJe7uTzu5zMQUXAt+d5S0qy9FlJ8g1B4K4GQB52jlIbS80GrBF5uHkX93ih7mI
         2lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=y9zTxIcArdZsrMHv4lX8i7pMiLkfPfjq8XzPLwLbJp0=;
        b=oecY/ghP6R/yHlPzFDBatbCjkLQGsMT9WT0D0gyudXak7a/1BjQCsskMOVkSAuvz/K
         TpziZEqwL1rzDW3G9DIZYGO6olQNoBDRv04EP8XjU3rN0RZGUWFDZPPgHXpU0mHHT157
         5TuLEc3KAGglPH98c4s6C8iFwkXYR8ZQqXJRvP2q4hSms4gWcHL5kUQ/Hasnz1UeBzSZ
         +ppN/n0wy7MOrOc6xrbRfjfmYVLs8EGLnLu26T2Uv4gXkMwDNa7F6RQuy4EWb6b/EH+R
         YVHoZMi63wJCn/0vfWgl/9ADbw/IkznN6vBr1j9IAeuaJHC+LWEzaCnlEG+q9UBxfBJ+
         X3PQ==
X-Gm-Message-State: AOUpUlG3luoSq/0FbXbAJhdeF07m6+l4tqEQ8uVpPFet4ywDCkRtgZj5
        Tuy0V2gaNJPT0E59NGyVF3lPiY6xrbYkXLhgb/Y6vK9VkZ1zZEqKsqbIpPt/X2wkxpwjXpPQePi
        aRgMavKIoDP17HsgnHt2kXnE77JyjhfddFuGFoD0Pb8GvBkgkGVuKHqFL8lh2
X-Google-Smtp-Source: AA+uWPyGuvpr1qndW3jqw0DqGP64j2jY3af64FQew2HB3Vg0w5UdGqaC7wDPYlB0bP/11dMYUjh1uY3R6dLR
MIME-Version: 1.0
X-Received: by 2002:a6b:d10f:: with SMTP id l15-v6mr1301962iob.104.1531942344564;
 Wed, 18 Jul 2018 12:32:24 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:55 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com>
Message-Id: <20180718193156.47365-10-sbeller@google.com>
References: <20180718193156.47365-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 09/10] diff.c: add white space mode to move detection that
 allows indent changes
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option of --color-moved has proven to be useful as observed on the
mailing list. However when refactoring sometimes the indentation changes,
for example when partitioning a functions into smaller helper functions
the code usually mostly moved around except for a decrease in indentation.

To just review the moved code ignoring the change in indentation, a mode
to ignore spaces in the move detection as implemented in a previous patch
would be enough.  However the whole move coloring as motivated in commit
2e2d5ac (diff.c: color moved lines differently, 2017-06-30), brought
up the notion of the reviewer being able to trust the move of a "block".

As there are languages such as python, which depend on proper relative
indentation for the control flow of the program, ignoring any white space
change in a block would not uphold the promises of 2e2d5ac that allows
reviewers to pay less attention to the inside of a block, as inside
the reviewer wants to assume the same program flow.

This new mode of white space ignorance will take this into account and will
only allow the same white space changes per line in each block. This patch
even allows only for the same change at the beginning of the lines.

As this is a white space mode, it is made exclusive to other white space
modes in the move detection.

This patch brings some challenges, related to the detection of blocks.
We need a wide net to catch the possible moved lines, but then need to
narrow down to check if the blocks are still intact. Consider this
example (ignoring block sizes):

 - A
 - B
 - C
 +    A
 +    B
 +    C

At the beginning of a block when checking if there is a counterpart
for A, we have to ignore all space changes. However at the following
lines we have to check if the indent change stayed the same.

Checking if the indentation change did stay the same, is done by computing
the indentation change by the difference in line length, and then assume
the change is only in the beginning of the longer line, the common tail
is the same. That is why the test contains lines like:

 - <TAB> A
 ...
 + A <TAB>
 ...

As the first line starting a block is caught using a compare function that
ignores white spaces unlike the rest of the block, where the white space
delta is taken into account for the comparison, we also have to think about
the following situation:

 - A
 - B
 -   A
 -   B
 +    A
 +    B
 +      A
 +      B

When checking if the first A (both in the + and - lines) is a start of
a block, we have to check all 'A' and record all the white space deltas
such that we can find the example above to be just one block that is
indented.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |   5 ++
 diff.c                         | 158 ++++++++++++++++++++++++++++++++-
 diff.h                         |   3 +
 t/t4015-diff-whitespace.sh     |  88 ++++++++++++++++++
 4 files changed, 252 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 80e29e39854..143acd9417e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -307,6 +307,11 @@ ignore-space-change::
 ignore-all-space::
 	Ignore whitespace when comparing lines. This ignores differences
 	even if one line has whitespace where the other line has none.
+allow-indentation-change::
+	Initially ignore any white spaces in the move detection, then
+	group the moved code blocks only into a block if the change in
+	whitespace is the same per line. This is incompatible with the
+	other modes.
 --
 
 --word-diff[=<mode>]::
diff --git a/diff.c b/diff.c
index 4963819e530..7810a4733f8 100644
--- a/diff.c
+++ b/diff.c
@@ -302,12 +302,18 @@ static int parse_color_moved_ws(const char *arg)
 			ret |= XDF_IGNORE_WHITESPACE_AT_EOL;
 		else if (!strcmp(sb.buf, "ignore-all-space"))
 			ret |= XDF_IGNORE_WHITESPACE;
+		else if (!strcmp(sb.buf, "allow-indentation-change"))
+			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
 		else
 			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
 
 		strbuf_release(&sb);
 	}
 
+	if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
+	    (ret & XDF_WHITESPACE_FLAGS))
+		die(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));
+
 	string_list_clear(&l, 0);
 
 	return ret;
@@ -737,7 +743,91 @@ struct moved_entry {
 	struct hashmap_entry ent;
 	const struct emitted_diff_symbol *es;
 	struct moved_entry *next_line;
+	struct ws_delta *wsd;
+};
+
+/**
+ * The struct ws_delta holds white space differences between moved lines, i.e.
+ * between '+' and '-' lines that have been detected to be a move.
+ * The string contains the difference in leading white spaces, before the
+ * rest of the line is compared using the white space config for move
+ * coloring. The current_longer indicates if the first string in the
+ * comparision is longer than the second.
+ */
+struct ws_delta {
+	char *string;
+	unsigned int current_longer : 1;
 };
+#define WS_DELTA_INIT { NULL, 0 }
+
+static int compute_ws_delta(const struct emitted_diff_symbol *a,
+			     const struct emitted_diff_symbol *b,
+			     struct ws_delta *out)
+{
+	const struct emitted_diff_symbol *longer =  a->len > b->len ? a : b;
+	const struct emitted_diff_symbol *shorter = a->len > b->len ? b : a;
+	int d = longer->len - shorter->len;
+
+	out->string = xmemdupz(longer->line, d);
+	out->current_longer = (a == longer);
+
+	return !strncmp(longer->line + d, shorter->line, shorter->len);
+}
+
+static int cmp_in_block_with_wsd(const struct diff_options *o,
+				 const struct moved_entry *cur,
+				 const struct moved_entry *match,
+				 struct moved_entry *pmb,
+				 int n)
+{
+	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
+	int al = cur->es->len, cl = l->len;
+	const char *a = cur->es->line,
+		   *b = match->es->line,
+		   *c = l->line;
+
+	int wslen;
+
+	/*
+	 * We need to check if 'cur' is equal to 'match'.
+	 * As those are from the same (+/-) side, we do not need to adjust for
+	 * indent changes. However these were found using fuzzy matching
+	 * so we do have to check if they are equal.
+	 */
+	if (strcmp(a, b))
+		return 1;
+
+	if (!pmb->wsd)
+		/*
+		 * No white space delta was carried forward? This can happen
+		 * when we exit early in this function and do not carry
+		 * forward ws.
+		 */
+		return 1;
+
+	/*
+	 * The indent changes of the block are known and carried forward in
+	 * pmb->wsd; however we need to check if the indent changes of the
+	 * current line are still the same as before.
+	 *
+	 * To do so we need to compare 'l' to 'cur', adjusting the
+	 * one of them for the white spaces, depending which was longer.
+	 */
+
+	wslen = strlen(pmb->wsd->string);
+	if (pmb->wsd->current_longer) {
+		c += wslen;
+		cl -= wslen;
+	} else {
+		a += wslen;
+		al -= wslen;
+	}
+
+	if (strcmp(a, c))
+		return 1;
+
+	return 0;
+}
 
 static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 			   const void *entry,
@@ -750,6 +840,16 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 	unsigned flags = diffopt->color_moved_ws_handling
 			 & XDF_WHITESPACE_FLAGS;
 
+	if (diffopt->color_moved_ws_handling &
+	    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+		/*
+		 * As there is not specific white space config given,
+		 * we'd need to check for a new block, so ignore all
+		 * white space. The setup of the white space
+		 * configuration for the next block is done else where
+		 */
+		flags |= XDF_IGNORE_WHITESPACE;
+
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
 				    flags);
@@ -765,6 +865,7 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 	ret->ent.hash = xdiff_hash_string(l->line, l->len, flags);
 	ret->es = l;
 	ret->next_line = NULL;
+	ret->wsd = NULL;
 
 	return ret;
 }
@@ -820,6 +921,37 @@ static void pmb_advance_or_null(struct diff_options *o,
 	}
 }
 
+static void pmb_advance_or_null_multi_match(struct diff_options *o,
+					    struct moved_entry *match,
+					    struct hashmap *hm,
+					    struct moved_entry **pmb,
+					    int pmb_nr, int n)
+{
+	int i;
+	char *got_match = xcalloc(1, pmb_nr);
+
+	for (; match; match = hashmap_get_next(hm, match)) {
+		for (i = 0; i < pmb_nr; i++) {
+			struct moved_entry *prev = pmb[i];
+			struct moved_entry *cur = (prev && prev->next_line) ?
+					prev->next_line : NULL;
+			if (!cur)
+				continue;
+			if (!cmp_in_block_with_wsd(o, cur, match, pmb[i], n))
+				got_match[i] |= 1;
+		}
+	}
+
+	for (i = 0; i < pmb_nr; i++) {
+		if (got_match[i]) {
+			/* Carry the white space delta forward */
+			pmb[i]->next_line->wsd = pmb[i]->wsd;
+			pmb[i] = pmb[i]->next_line;
+		} else
+			pmb[i] = NULL;
+	}
+}
+
 static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 					 int pmb_nr)
 {
@@ -837,6 +969,10 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 
 		if (lp < pmb_nr && rp > -1 && lp < rp) {
 			pmb[lp] = pmb[rp];
+			if (pmb[rp]->wsd) {
+				free(pmb[rp]->wsd->string);
+				FREE_AND_NULL(pmb[rp]->wsd);
+			}
 			pmb[rp] = NULL;
 			rp--;
 			lp++;
@@ -924,7 +1060,11 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (o->color_moved == COLOR_MOVED_PLAIN)
 			continue;
 
-		pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
+		if (o->color_moved_ws_handling &
+		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+			pmb_advance_or_null_multi_match(o, match, hm, pmb, pmb_nr, n);
+		else
+			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
 
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
@@ -935,7 +1075,17 @@ static void mark_color_as_moved(struct diff_options *o,
 			 */
 			for (; match; match = hashmap_get_next(hm, match)) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
-				pmb[pmb_nr++] = match;
+				if (o->color_moved_ws_handling &
+				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
+					struct ws_delta *wsd = xmalloc(sizeof(*match->wsd));
+					if (compute_ws_delta(l, match->es, wsd)) {
+						match->wsd = wsd;
+						pmb[pmb_nr++] = match;
+					} else
+						free(wsd);
+				} else {
+					pmb[pmb_nr++] = match;
+				}
 			}
 
 			flipped_block = (flipped_block + 1) % 2;
@@ -5583,6 +5733,10 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 		if (o->color_moved) {
 			struct hashmap add_lines, del_lines;
 
+			if (o->color_moved_ws_handling &
+			    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+				o->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
+
 			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
 			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
diff --git a/diff.h b/diff.h
index de5dc680051..5e6bcf09260 100644
--- a/diff.h
+++ b/diff.h
@@ -214,6 +214,9 @@ struct diff_options {
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
+
+	/* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
+	#define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
 	int color_moved_ws_handling;
 };
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 000c3a2b7de..41facf7abf9 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1814,4 +1814,92 @@ test_expect_success 'only move detection ignores white spaces' '
 	test_cmp expected actual
 '
 
+test_expect_success 'compare whitespace delta across moved blocks' '
+
+	git reset --hard &&
+	q_to_tab <<-\EOF >text.txt &&
+	QIndented
+	QText across
+	Qsome lines
+	QBut! <- this stands out
+	QAdjusting with
+	QQdifferent starting
+	Qwhite spaces
+	QAnother outlier
+	QQQIndented
+	QQQText across
+	QQQfive lines
+	QQQthat has similar lines
+	QQQto previous blocks, but with different indent
+	QQQYetQAnotherQoutlierQ
+	EOF
+
+	git add text.txt &&
+	git commit -m "add text.txt" &&
+
+	q_to_tab <<-\EOF >text.txt &&
+	QQIndented
+	QQText across
+	QQsome lines
+	QQQBut! <- this stands out
+	Adjusting with
+	Qdifferent starting
+	white spaces
+	AnotherQoutlier
+	QQIndented
+	QQText across
+	QQfive lines
+	QQthat has similar lines
+	QQto previous blocks, but with different indent
+	QQYetQAnotherQoutlier
+	EOF
+
+	git diff --color --color-moved --color-moved-ws=allow-indentation-change >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
+
+	q_to_tab <<-\EOF >expected &&
+		<BOLD>diff --git a/text.txt b/text.txt<RESET>
+		<BOLD>--- a/text.txt<RESET>
+		<BOLD>+++ b/text.txt<RESET>
+		<CYAN>@@ -1,14 +1,14 @@<RESET>
+		<BOLD;MAGENTA>-QIndented<RESET>
+		<BOLD;MAGENTA>-QText across<RESET>
+		<BOLD;MAGENTA>-Qsome lines<RESET>
+		<RED>-QBut! <- this stands out<RESET>
+		<BOLD;MAGENTA>-QAdjusting with<RESET>
+		<BOLD;MAGENTA>-QQdifferent starting<RESET>
+		<BOLD;MAGENTA>-Qwhite spaces<RESET>
+		<RED>-QAnother outlier<RESET>
+		<BOLD;MAGENTA>-QQQIndented<RESET>
+		<BOLD;MAGENTA>-QQQText across<RESET>
+		<BOLD;MAGENTA>-QQQfive lines<RESET>
+		<BOLD;MAGENTA>-QQQthat has similar lines<RESET>
+		<BOLD;MAGENTA>-QQQto previous blocks, but with different indent<RESET>
+		<RED>-QQQYetQAnotherQoutlierQ<RESET>
+		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Indented<RESET>
+		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Text across<RESET>
+		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>some lines<RESET>
+		<GREEN>+<RESET>QQQ<GREEN>But! <- this stands out<RESET>
+		<BOLD;CYAN>+<RESET><BOLD;CYAN>Adjusting with<RESET>
+		<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>different starting<RESET>
+		<BOLD;CYAN>+<RESET><BOLD;CYAN>white spaces<RESET>
+		<GREEN>+<RESET><GREEN>AnotherQoutlier<RESET>
+		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Indented<RESET>
+		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Text across<RESET>
+		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>five lines<RESET>
+		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>that has similar lines<RESET>
+		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>to previous blocks, but with different indent<RESET>
+		<GREEN>+<RESET>QQ<GREEN>YetQAnotherQoutlier<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
+test_expect_success 'compare whitespace delta incompatible with other space options' '
+	test_must_fail git diff \
+		--color-moved-ws=allow-indentation-change,ignore-all-space \
+		2>err &&
+	test_i18ngrep allow-indentation-change err
+'
+
 test_done
-- 
2.18.0.233.g985f88cf7e-goog

