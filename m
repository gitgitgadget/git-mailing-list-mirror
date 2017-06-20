Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DE4A1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbdFTCtY (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:49:24 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34317 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdFTCsw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:52 -0400
Received: by mail-pg0-f42.google.com with SMTP id e187so4231203pgc.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KjOuFLQvLKkq8O0iNnXcrA/o7Ayeh9FeKOXrjBjWP8o=;
        b=WrVKra5WAxdwuJQRrWUWN3llAX+FRa3UoyMsrD/0wRvbvpeWFVXDB3oTfy49H2VJpO
         frCYy4YG/pBn8Znnb4rb85O0aKap618TB7fi48e0BoeoJHJNAe65PHrIgpNcb6vNa09N
         KxmmccAGJ+6Sv60xthS6vPASsTS/MXOBuwn9RVNx5PBKsc5dOtpwE4mOxyrv48pVR6L0
         4XuMpEMBKzfd4DIlnAeagBJB3og9KWS3BiM1yj1UY6TT84a8jiGKbRBv/WfXei0Mv508
         2k7EipYgSnVdrXHb3dbippA3KZ6PX1rgrsEgz/S+AjUxonBDLQr4LoWFoZni2XrcZfEx
         H/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KjOuFLQvLKkq8O0iNnXcrA/o7Ayeh9FeKOXrjBjWP8o=;
        b=RJjMl+chIJ557qSzI8mJQsIWPxEZNJYj9LEwX2CmQfXre0Weyy/oHX0LWf3dKMyAhS
         8FZ58J5QgjjHLn7KeOt1D6rE9TPg8LtRY4e59WR/z82ExfuU5xoOVfYJyyx5V2TylXmj
         ezcKcCWdpppuiQCXI0I8AnDsj4+eQUUA/119JojNrKdiV3IzC5J5tg8Hv+I/LI2kBAhn
         4JeP5TCZKbmL9/MuFT6ITyKcawGyvkB+if03q1gW3nJVKTVznY6LWbc1HVUQkAx/lFwj
         BrKNrSI5GkQUNtELATBqYmatHOBr8sqeCNe2Sg5vZ8/Ge2UokGxVf+WYKeACo8Dt6x14
         Q4VA==
X-Gm-Message-State: AKS2vOzdRgiQDd059l4MBK8ntUnDhP/H8lhAvfVGJzXGBMOU/3CgEDm/
        LF9+KtKKe4/sIfAd
X-Received: by 10.84.149.102 with SMTP id b35mr33882367plh.289.1497926931546;
        Mon, 19 Jun 2017 19:48:51 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id y12sm7681813pgr.61.2017.06.19.19.48.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:50 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 22/26] diff.c: color moved lines differently
Date:   Mon, 19 Jun 2017 19:48:12 -0700
Message-Id: <20170620024816.20021-23-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a patch consists mostly of moving blocks of code around, it can
be quite tedious to ensure that the blocks are moved verbatim, and not
undesirably modified in the move. To that end, color blocks that are
moved within the same patch differently. For example (OM, del, add,
and NM are different colors):

    [OM]  -void sensitive_stuff(void)
    [OM]  -{
    [OM]  -        if (!is_authorized_user())
    [OM]  -                die("unauthorized");
    [OM]  -        sensitive_stuff(spanning,
    [OM]  -                        multiple,
    [OM]  -                        lines);
    [OM]  -}

           void another_function()
           {
    [del] -        printf("foo");
    [add] +        printf("bar");
           }

    [NM]  +void sensitive_stuff(void)
    [NM]  +{
    [NM]  +        if (!is_authorized_user())
    [NM]  +                die("unauthorized");
    [NM]  +        sensitive_stuff(spanning,
    [NM]  +                        multiple,
    [NM]  +                        lines);
    [NM]  +}

However adjacent blocks may be problematic. For example, in this
potentially malicious patch, the swapping of blocks can be spotted:

    [OM]  -void sensitive_stuff(void)
    [OM]  -{
    [OMA] -        if (!is_authorized_user())
    [OMA] -                die("unauthorized");
    [OM]  -        sensitive_stuff(spanning,
    [OM]  -                        multiple,
    [OM]  -                        lines);
    [OMA] -}

           void another_function()
           {
    [del] -        printf("foo");
    [add] +        printf("bar");
           }

    [NM]  +void sensitive_stuff(void)
    [NM]  +{
    [NMA] +        sensitive_stuff(spanning,
    [NMA] +                        multiple,
    [NMA] +                        lines);
    [NM]  +        if (!is_authorized_user())
    [NM]  +                die("unauthorized");
    [NMA] +}

If the moved code is larger, it is easier to hide some permutation in the
code, which is why some alternative coloring is needed.

This patch implements the first mode:
* basic alternating 'Zebra' mode
  This conveys all information needed to the user.  Defer customization to
  later patches.

First I implemented an alternative design, which would try to fingerprint
a line by its neighbors to detect if we are in a block or at the boundary.
This idea iss error prone as it inspected each line and its neighboring
lines to determine if the line was (a) moved and (b) if was deep inside
a hunk by having matching neighboring lines. This is unreliable as the
we can construct hunks which have equal neighbors that just exceed the
number of lines inspected. (Think of 'AXYZBXYZCXYZD..' with each letter
as a line, that is permutated to AXYZCXYZBXYZD..').

Instead this provides a dynamic programming greedy algorithm that finds
the largest moved hunk and then has several modes on highlighting bounds.

A note on the options '--submodule=diff' and '--color-words/--word-diff':
In the conversion to use emit_line in the prior patches both submodules
as well as word diff output carefully chose to call emit_line with sign=0.
All output with sign=0 is ignored for move detection purposes in this
patch, such that no weird looking output will be generated for these
cases. This leads to another thought: We could pass on '--color-moved' to
submodules such that they color up moved lines for themselves. If we'd do
so only line moves within a repository boundary are marked up.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c                     | 304 ++++++++++++++++++++++++++++++++++++++++++---
 diff.h                     |  10 +-
 t/t4015-diff-whitespace.sh | 196 +++++++++++++++++++++++++++++
 3 files changed, 495 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 35b5924ff2..20c1f9b99f 100644
--- a/diff.c
+++ b/diff.c
@@ -15,6 +15,7 @@
 #include "userdiff.h"
 #include "submodule-config.h"
 #include "submodule.h"
+#include "hashmap.h"
 #include "ll-merge.h"
 #include "string-list.h"
 #include "argv-array.h"
@@ -31,6 +32,7 @@ static int diff_indent_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
+static int diff_color_moved_default;
 static int diff_context_default = 3;
 static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
@@ -55,6 +57,10 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
+	GIT_COLOR_MAGENTA,	/* OLD_MOVED */
+	GIT_COLOR_BLUE,		/* OLD_MOVED ALTERNATIVE */
+	GIT_COLOR_CYAN,		/* NEW_MOVED */
+	GIT_COLOR_YELLOW,	/* NEW_MOVED ALTERNATIVE */
 };
 
 static NORETURN void die_want_option(const char *option_name)
@@ -80,6 +86,14 @@ static int parse_diff_color_slot(const char *var)
 		return DIFF_WHITESPACE;
 	if (!strcasecmp(var, "func"))
 		return DIFF_FUNCINFO;
+	if (!strcasecmp(var, "oldmoved"))
+		return DIFF_FILE_OLD_MOVED;
+	if (!strcasecmp(var, "oldmovedalternative"))
+		return DIFF_FILE_OLD_MOVED_ALT;
+	if (!strcasecmp(var, "newmoved"))
+		return DIFF_FILE_NEW_MOVED;
+	if (!strcasecmp(var, "newmovedalternative"))
+		return DIFF_FILE_NEW_MOVED_ALT;
 	return -1;
 }
 
@@ -228,12 +242,29 @@ int git_diff_heuristic_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static int parse_color_moved(const char *arg)
+{
+	if (!strcmp(arg, "no"))
+		return COLOR_MOVED_NO;
+	else if (!strcmp(arg, "zebra"))
+		return COLOR_MOVED_ZEBRA;
+	else
+		return -1;
+}
+
 int git_diff_ui_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.colormoved")) {
+		int cm = parse_color_moved(value);
+		if (cm < 0)
+			return -1;
+		diff_color_moved_default = cm;
+		return 0;
+	}
 	if (!strcmp(var, "diff.context")) {
 		diff_context_default = git_config_int(var, value);
 		if (diff_context_default < 0)
@@ -600,7 +631,9 @@ enum diff_symbol {
  * 13-15 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
  * 16 is marking if the line is blank at EOF
  */
-#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF (1<<16)
+#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<16)
+#define DIFF_SYMBOL_MOVED_LINE			(1<<17)
+#define DIFF_SYMBOL_MOVED_LINE_ZEBRA		(1<<18)
 #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
 
 /*
@@ -643,6 +676,213 @@ static void append_emitted_diff_symbol(struct diff_options *o,
 	f->line = e->line ? xmemdupz(e->line, e->len) : NULL;
 }
 
+struct moved_entry {
+	struct hashmap_entry ent;
+	const struct emitted_diff_symbol *es;
+	struct moved_entry *next_line;
+};
+
+static void get_ws_cleaned_string(const struct emitted_diff_symbol *l,
+				  struct strbuf *out)
+{
+	int i;
+	for (i = 0; i < l->len; i++) {
+		if (isspace(l->line[i]))
+			continue;
+		strbuf_addch(out, l->line[i]);
+	}
+}
+
+static int emitted_symbol_cmp_no_ws(const struct emitted_diff_symbol *a,
+				    const struct emitted_diff_symbol *b,
+				    const void *keydata)
+{
+	int ret;
+	struct strbuf sba = STRBUF_INIT;
+	struct strbuf sbb = STRBUF_INIT;
+
+	get_ws_cleaned_string(a, &sba);
+	get_ws_cleaned_string(b, &sbb);
+	ret = sba.len != sbb.len || strncmp(sba.buf, sbb.buf, sba.len);
+
+	strbuf_release(&sba);
+	strbuf_release(&sbb);
+	return ret;
+}
+
+static int emitted_symbol_cmp(const struct emitted_diff_symbol *a,
+			      const struct emitted_diff_symbol *b,
+			      const void *keydata)
+{
+	return a->len != b->len || strncmp(a->line, b->line, a->len);
+}
+
+static int moved_entry_cmp(const struct moved_entry *a,
+			   const struct moved_entry *b,
+			   const void *keydata)
+{
+	return emitted_symbol_cmp(a->es, b->es, keydata);
+}
+
+static int moved_entry_cmp_no_ws(const struct moved_entry *a,
+				 const struct moved_entry *b,
+				 const void *keydata)
+{
+	return emitted_symbol_cmp_no_ws(a->es, b->es, keydata);
+}
+
+static unsigned get_string_hash(struct emitted_diff_symbol *es, unsigned ignore_ws)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	if (ignore_ws) {
+		strbuf_reset(&sb);
+		get_ws_cleaned_string(es, &sb);
+		return memhash(sb.buf, sb.len);
+	} else {
+		return memhash(es->line, es->len);
+	}
+}
+
+static struct moved_entry *prepare_entry(struct diff_options *o,
+					 int line_no)
+{
+	struct moved_entry *ret = xmalloc(sizeof(*ret));
+	unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
+	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
+
+	ret->ent.hash = get_string_hash(l, ignore_ws);
+	ret->es = l;
+	ret->next_line = NULL;
+
+	return ret;
+}
+
+static void add_lines_to_move_detection(struct diff_options *o,
+					struct hashmap *add_lines,
+					struct hashmap *del_lines)
+{
+	struct moved_entry *prev_line = NULL;
+
+	int n;
+	for (n = 0; n < o->emitted_symbols->nr; n++) {
+		struct hashmap *hm;
+		struct moved_entry *key;
+
+		switch (o->emitted_symbols->buf[n].s) {
+		case DIFF_SYMBOL_PLUS:
+			hm = add_lines;
+			break;
+		case DIFF_SYMBOL_MINUS:
+			hm = del_lines;
+			break;
+		default:
+			prev_line = NULL;
+			continue;
+		}
+
+		key = prepare_entry(o, n);
+		if (prev_line && prev_line->es->s == o->emitted_symbols->buf[n].s)
+			prev_line->next_line = key;
+
+		hashmap_add(hm, key);
+		prev_line = key;
+	}
+}
+
+/* Find blocks of moved code, delegate actual coloring decision to helper */
+static void mark_color_as_moved(struct diff_options *o,
+				struct hashmap *add_lines,
+				struct hashmap *del_lines)
+{
+	struct moved_entry **pmb = NULL; /* potentially moved blocks */
+	int pmb_nr = 0, pmb_alloc = 0;
+	int n, flipped_block = 1;
+
+	for (n = 0; n < o->emitted_symbols->nr; n++) {
+		struct hashmap *hm = NULL;
+		struct moved_entry *key;
+		struct moved_entry *match = NULL;
+		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
+		int i, lp, rp;
+
+		switch (l->s) {
+		case DIFF_SYMBOL_PLUS:
+			hm = del_lines;
+			key = prepare_entry(o, n);
+			match = hashmap_get(hm, key, o);
+			free(key);
+			break;
+		case DIFF_SYMBOL_MINUS:
+			hm = add_lines;
+			key = prepare_entry(o, n);
+			match = hashmap_get(hm, key, o);
+			free(key);
+			break;
+		default:
+			flipped_block = 1;
+		}
+
+		if (!match) {
+			pmb_nr = 0;
+			continue;
+		}
+
+		l->flags |= DIFF_SYMBOL_MOVED_LINE;
+
+		/* Check any potential block runs, advance each or nullify */
+		for (i = 0; i < pmb_nr; i++) {
+			struct moved_entry *p = pmb[i];
+			struct moved_entry *pnext = (p && p->next_line) ?
+					p->next_line : NULL;
+			if (pnext &&
+			    !emitted_symbol_cmp(pnext->es, l, o)) {
+				pmb[i] = p->next_line;
+			} else {
+				pmb[i] = NULL;
+			}
+		}
+
+		/* Shrink the set of potential block to the remaining running */
+		for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
+			while (lp < pmb_nr && pmb[lp])
+				lp++;
+			/* lp points at the first NULL now */
+
+			while (rp > -1 && !pmb[rp])
+				rp--;
+			/* rp points at the last non-NULL */
+
+			if (lp < pmb_nr && rp > -1 && lp < rp) {
+				pmb[lp] = pmb[rp];
+				pmb[rp] = NULL;
+				rp--;
+				lp++;
+			}
+		}
+
+		/* Remember the number of running sets */
+		pmb_nr = rp + 1;
+
+		if (pmb_nr == 0) {
+			/*
+			 * The current line is the start of a new block.
+			 * Setup the set of potential blocks.
+			 */
+			for (; match; match = hashmap_get_next(hm, match)) {
+				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
+				pmb[pmb_nr++] = match;
+			}
+
+			flipped_block = (flipped_block + 1) % 2;
+		}
+
+		if (flipped_block)
+			l->flags |= DIFF_SYMBOL_MOVED_LINE_ZEBRA;
+	}
+
+	free(pmb);
+}
 
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set, const char *reset,
@@ -715,14 +955,24 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		emit_line(o, context, reset, line, len);
 		break;
 	case DIFF_SYMBOL_PLUS:
-		set = diff_get_color_opt(o, DIFF_FILE_NEW);
+		if (flags & DIFF_SYMBOL_MOVED_LINE_ZEBRA)
+			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED_ALT);
+		else if (flags & DIFF_SYMBOL_MOVED_LINE)
+			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED);
+		else
+			set = diff_get_color_opt(o, DIFF_FILE_NEW);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		emit_line_ws_markup(o, set, reset, line, len, '+',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
 	case DIFF_SYMBOL_MINUS:
-		set = diff_get_color_opt(o, DIFF_FILE_OLD);
+		if (flags & DIFF_SYMBOL_MOVED_LINE_ZEBRA)
+			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_ALT);
+		else if (flags & DIFF_SYMBOL_MOVED_LINE)
+			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED);
+		else
+			set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		emit_line_ws_markup(o, set, reset, line, len, '-',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
@@ -3750,6 +4000,8 @@ void diff_setup(struct diff_options *options)
 		options->a_prefix = "a/";
 		options->b_prefix = "b/";
 	}
+
+	options->color_moved = diff_color_moved_default;
 }
 
 void diff_setup_done(struct diff_options *options)
@@ -3859,6 +4111,9 @@ void diff_setup_done(struct diff_options *options)
 
 	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
 		die(_("--follow requires exactly one pathspec"));
+
+	if (!options->use_color || external_diff())
+		options->color_moved = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -4283,7 +4538,16 @@ int diff_opt_parse(struct diff_options *options,
 	}
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
-	else if (!strcmp(arg, "--color-words")) {
+	else if (!strcmp(arg, "--color-moved"))
+		options->color_moved = COLOR_MOVED_ZEBRA;
+	else if (!strcmp(arg, "--no-color-moved"))
+		options->color_moved = COLOR_MOVED_NO;
+	else if (skip_prefix(arg, "--color-moved=", &arg)) {
+		int cm = parse_color_moved(arg);
+		if (cm < 0)
+			die("bad --color-moved argument: %s", arg);
+		options->color_moved = cm;
+	} else if (!strcmp(arg, "--color-words")) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
 	}
@@ -5094,16 +5358,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	int i;
 	static struct emitted_diff_symbols esm = EMITTED_DIFF_SYMBOLS_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	/*
-	 * For testing purposes we want to make sure the diff machinery
-	 * works completely with the buffer. If there is anything emitted
-	 * outside the emit_string, then the order is screwed
-	 * up and the tests will fail.
-	 *
-	 * TODO (later in this series):
-	 * We'll unset this pointer in a later patch.
-	 */
-	o->emitted_symbols = &esm;
+
+	if (o->color_moved)
+		o->emitted_symbols = &esm;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -5112,6 +5369,24 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	}
 
 	if (o->emitted_symbols) {
+		if (o->color_moved) {
+			struct hashmap add_lines, del_lines;
+			unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
+
+			hashmap_init(&del_lines, ignore_ws ?
+				(hashmap_cmp_fn)moved_entry_cmp_no_ws :
+				(hashmap_cmp_fn)moved_entry_cmp, 0);
+			hashmap_init(&add_lines, ignore_ws ?
+				(hashmap_cmp_fn)moved_entry_cmp_no_ws :
+				(hashmap_cmp_fn)moved_entry_cmp, 0);
+
+			add_lines_to_move_detection(o, &add_lines, &del_lines);
+			mark_color_as_moved(o, &add_lines, &del_lines);
+
+			hashmap_free(&add_lines, 0);
+			hashmap_free(&del_lines, 0);
+		}
+
 		for (i = 0; i < esm.nr; i++)
 			emit_diff_symbol_from_struct(o, &esm.buf[i]);
 
@@ -5195,6 +5470,7 @@ void diff_flush(struct diff_options *options)
 		if (!options->file)
 			die_errno("Could not open /dev/null");
 		options->close_file = 1;
+		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
diff --git a/diff.h b/diff.h
index 65fc9dbb4b..7726ad255c 100644
--- a/diff.h
+++ b/diff.h
@@ -188,6 +188,10 @@ struct diff_options {
 	int diff_path_counter;
 
 	struct emitted_diff_symbols *emitted_symbols;
+	enum {
+		COLOR_MOVED_NO = 0,
+		COLOR_MOVED_ZEBRA = 2,
+	} color_moved;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
@@ -208,7 +212,11 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
-	DIFF_FUNCINFO = 8
+	DIFF_FUNCINFO = 8,
+	DIFF_FILE_OLD_MOVED = 9,
+	DIFF_FILE_OLD_MOVED_ALT = 10,
+	DIFF_FILE_NEW_MOVED = 11,
+	DIFF_FILE_NEW_MOVED_ALT = 12
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 289806d0c7..4a03766f1f 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -972,4 +972,200 @@ test_expect_success 'option overrides diff.wsErrorHighlight' '
 
 '
 
+test_expect_success 'detect moved code, complete file' '
+	git reset --hard &&
+	cat <<-\EOF >test.c &&
+	#include<stdio.h>
+	main()
+	{
+	printf("Hello World");
+	}
+	EOF
+	git add test.c &&
+	git commit -m "add main function" &&
+	git mv test.c main.c &&
+	test_config color.diff.oldMoved "normal red" &&
+	test_config color.diff.newMoved "normal green" &&
+	git diff HEAD --color-moved --no-renames | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/main.c b/main.c<RESET>
+	<BOLD>new file mode 100644<RESET>
+	<BOLD>index 0000000..a986c57<RESET>
+	<BOLD>--- /dev/null<RESET>
+	<BOLD>+++ b/main.c<RESET>
+	<CYAN>@@ -0,0 +1,5 @@<RESET>
+	<BGREEN>+<RESET><BGREEN>#include<stdio.h><RESET>
+	<BGREEN>+<RESET><BGREEN>main()<RESET>
+	<BGREEN>+<RESET><BGREEN>{<RESET>
+	<BGREEN>+<RESET><BGREEN>printf("Hello World");<RESET>
+	<BGREEN>+<RESET><BGREEN>}<RESET>
+	<BOLD>diff --git a/test.c b/test.c<RESET>
+	<BOLD>deleted file mode 100644<RESET>
+	<BOLD>index a986c57..0000000<RESET>
+	<BOLD>--- a/test.c<RESET>
+	<BOLD>+++ /dev/null<RESET>
+	<CYAN>@@ -1,5 +0,0 @@<RESET>
+	<BRED>-#include<stdio.h><RESET>
+	<BRED>-main()<RESET>
+	<BRED>-{<RESET>
+	<BRED>-printf("Hello World");<RESET>
+	<BRED>-}<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
+test_expect_success 'detect malicious moved code, inside file' '
+	test_config color.diff.oldMoved "normal red" &&
+	test_config color.diff.newMoved "normal green" &&
+	test_config color.diff.oldMovedAlternative "blue" &&
+	test_config color.diff.newMovedAlternative "yellow" &&
+	git reset --hard &&
+	cat <<-\EOF >main.c &&
+		#include<stdio.h>
+		int stuff()
+		{
+			printf("Hello ");
+			printf("World\n");
+		}
+
+		int secure_foo(struct user *u)
+		{
+			if (!u->is_allowed_foo)
+				return;
+			foo(u);
+		}
+
+		int main()
+		{
+			foo();
+		}
+	EOF
+	cat <<-\EOF >test.c &&
+		#include<stdio.h>
+		int bar()
+		{
+			printf("Hello World, but different\n");
+		}
+
+		int another_function()
+		{
+			bar();
+		}
+	EOF
+	git add main.c test.c &&
+	git commit -m "add main and test file" &&
+	cat <<-\EOF >main.c &&
+		#include<stdio.h>
+		int stuff()
+		{
+			printf("Hello ");
+			printf("World\n");
+		}
+
+		int main()
+		{
+			foo();
+		}
+	EOF
+	cat <<-\EOF >test.c &&
+		#include<stdio.h>
+		int bar()
+		{
+			printf("Hello World, but different\n");
+		}
+
+		int secure_foo(struct user *u)
+		{
+			foo(u);
+			if (!u->is_allowed_foo)
+				return;
+		}
+
+		int another_function()
+		{
+			bar();
+		}
+	EOF
+	git diff HEAD --no-renames --color-moved=zebra| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/main.c b/main.c<RESET>
+	<BOLD>index 27a619c..7cf9336 100644<RESET>
+	<BOLD>--- a/main.c<RESET>
+	<BOLD>+++ b/main.c<RESET>
+	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
+	 printf("World\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<BRED>-int secure_foo(struct user *u)<RESET>
+	<BRED>-{<RESET>
+	<BLUE>-if (!u->is_allowed_foo)<RESET>
+	<BLUE>-return;<RESET>
+	<BRED>-foo(u);<RESET>
+	<BLUE>-}<RESET>
+	<BLUE>-<RESET>
+	 int main()<RESET>
+	 {<RESET>
+	 foo();<RESET>
+	<BOLD>diff --git a/test.c b/test.c<RESET>
+	<BOLD>index 1dc1d85..2bedec9 100644<RESET>
+	<BOLD>--- a/test.c<RESET>
+	<BOLD>+++ b/test.c<RESET>
+	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
+	 printf("Hello World, but different\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
+	<BGREEN>+<RESET><BGREEN>{<RESET>
+	<YELLOW>+<RESET><YELLOW>foo(u);<RESET>
+	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
+	<BGREEN>+<RESET><BGREEN>return;<RESET>
+	<YELLOW>+<RESET><YELLOW>}<RESET>
+	<YELLOW>+<RESET>
+	 int another_function()<RESET>
+	 {<RESET>
+	 bar();<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
+test_expect_success 'no effect from --color-moved with --word-diff' '
+	cat <<-\EOF >text.txt &&
+	Lorem Ipsum is simply dummy text of the printing and typesetting industry.
+	EOF
+	git add text.txt &&
+	git commit -a -m "clean state" &&
+	cat <<-\EOF >text.txt &&
+	simply Lorem Ipsum dummy is text of the typesetting and printing industry.
+	EOF
+	git diff --color-moved --word-diff >actual &&
+	git diff --word-diff >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'move detection with submodules' '
+	test_create_repo bananas &&
+	echo ripe >bananas/recipe &&
+	git -C bananas add recipe &&
+	test_commit fruit &&
+	test_commit -C bananas recipe &&
+	git submodule add ./bananas &&
+	git add bananas &&
+	git commit -a -m "bananas are like a heavy library?" &&
+	echo foul >bananas/recipe &&
+	echo ripe >fruit.t &&
+
+	git diff --submodule=diff --color-moved >actual &&
+
+	# no move detection as the moved line is across repository boundaries.
+	test_decode_color <actual >decoded_actual &&
+	! grep BGREEN decoded_actual &&
+	! grep BRED decoded_actual &&
+
+	# nor did we mess with it another way
+	git diff --submodule=diff | test_decode_color >expect &&
+	test_cmp expect decoded_actual
+'
+
 test_done
-- 
2.12.2.575.gb14f27f917

