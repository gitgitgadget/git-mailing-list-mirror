Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C26201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbdF3Ux7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:59 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35800 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdF3Uxs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:48 -0400
Received: by mail-pg0-f52.google.com with SMTP id j186so68681216pge.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/GIll5TTq1BhagkYrlKgoQ1BKCXHuzfrrL/v2Yma6E=;
        b=F7AAy5MOvsYhlo8fTf3k75s1HIP310gct8qNic64v9bJ1/lk0amMbH/9rOK/1U6KgI
         IabV+cP4NEf2yiBEu2kVImgZK4S1GXa35ijyC8sOOkawmSOQga7wTmwQ4EyhDH/YEezX
         PmKiC9lOSp6cGoTG8BcVNwYGpLXHxBNYhriIFH7z16/BjUvU+z8+BY0PrF9zOvMn7gYf
         0pzHnoNM6xmQ2J1OKFviRzBZEsZHP81Yb7t0/MUz1W5C0s56Ip7PjxKd+qb8Tvnua/PV
         1UnkOW2nWBygHnD2/CjYnWOX3s3uAoOSyNOMIRyiB6Ma9RN2bL0IXn9nMbpI4WwZWJtC
         wDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/GIll5TTq1BhagkYrlKgoQ1BKCXHuzfrrL/v2Yma6E=;
        b=jMtPheKfRiv8R5KeBLP7Ddvm01LvNy5vJt51aMOKmkCpfdlLPSGSexRpL7ripoRlkV
         soTqhDw11+d1XmrCAVBlPEo8Bp/TLI0/gdjm88UhWiEDLBvNQCwTmbrH6Wvdn9EhsLbe
         yiYyWtep4pwyttxD18B6zilAodLTlcWO/ySVqwzoFOtHfGAuvLscTog6cxZ9T7Py7ppq
         QbqqENT+v/zSSgRBRcwiEj1uo9nYFzdxivY46X2SXkBiyIX+VO7ki/4AdtUFDrNcJFGb
         hMNmNw8a/4LZ6/1i7qd/NOsxo5826aOP6ec8kQAuc+ZXQMx/5v9eAL+CY9O7ZEP6zyvN
         8d8A==
X-Gm-Message-State: AKS2vOzKXzodcb1sqbmk0ygzaw3EOr0EVLy8fsncPZTXauWmUQlg0ge+
        WEK2y02FNViY1giC
X-Received: by 10.84.129.67 with SMTP id 61mr26555684plb.229.1498856022465;
        Fri, 30 Jun 2017 13:53:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id y185sm16812951pgb.9.2017.06.30.13.53.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 22/25] diff.c: color moved lines differently
Date:   Fri, 30 Jun 2017 13:53:07 -0700
Message-Id: <20170630205310.7380-23-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
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

It is useful to have moved lines colored, but there are annoying corner
cases, such as a single line moved, that is very common. For example
in a typical patch of C code, we have closing braces that end statement
blocks or functions.

While it is technically true that these lines are moved as they show up
elsewhere, it is harmful for the review as the reviewers attention is
drawn to such a minor side annoyance.

For now let's have a simple solution of hardcoding the number of
moved lines to be at least 3 before coloring them. Note, that the
length is applied across all blocks to find the 'lonely' blocks
that pollute new code, but do not interfere with a permutated
block where each permutation has less lines than 3.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c                     | 344 +++++++++++++++++++++++++++++++++++++++++++--
 diff.h                     |  12 +-
 t/t4015-diff-whitespace.sh | 261 ++++++++++++++++++++++++++++++++++
 3 files changed, 602 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 31720abf8f..084ecc5678 100644
--- a/diff.c
+++ b/diff.c
@@ -16,6 +16,7 @@
 #include "userdiff.h"
 #include "submodule-config.h"
 #include "submodule.h"
+#include "hashmap.h"
 #include "ll-merge.h"
 #include "string-list.h"
 #include "argv-array.h"
@@ -32,6 +33,7 @@ static int diff_indent_heuristic = 1;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
+static int diff_color_moved_default;
 static int diff_context_default = 3;
 static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
@@ -56,6 +58,10 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
+	GIT_COLOR_MAGENTA,	/* OLD_MOVED */
+	GIT_COLOR_BLUE,		/* OLD_MOVED ALTERNATIVE */
+	GIT_COLOR_CYAN,		/* NEW_MOVED */
+	GIT_COLOR_YELLOW,	/* NEW_MOVED ALTERNATIVE */
 };
 
 static NORETURN void die_want_option(const char *option_name)
@@ -81,6 +87,14 @@ static int parse_diff_color_slot(const char *var)
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
 
@@ -229,12 +243,40 @@ int git_diff_heuristic_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static int parse_color_moved(const char *arg)
+{
+	switch (git_parse_maybe_bool(arg)) {
+	case 0:
+		return COLOR_MOVED_NO;
+	case 1:
+		return COLOR_MOVED_DEFAULT;
+	default:
+		break;
+	}
+
+	if (!strcmp(arg, "no"))
+		return COLOR_MOVED_NO;
+	else if (!strcmp(arg, "zebra"))
+		return COLOR_MOVED_ZEBRA;
+	else if (!strcmp(arg, "default"))
+		return COLOR_MOVED_DEFAULT;
+	else
+		return error(_("color moved setting must be one of 'no', 'default', 'zebra'"));
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
@@ -602,7 +644,9 @@ enum diff_symbol {
  * 13-15 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
  * 16 is marking if the line is blank at EOF
  */
-#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF (1<<16)
+#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<16)
+#define DIFF_SYMBOL_MOVED_LINE			(1<<17)
+#define DIFF_SYMBOL_MOVED_LINE_ALT		(1<<18)
 #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
 
 /*
@@ -645,6 +689,243 @@ static void append_emitted_diff_symbol(struct diff_options *o,
 	f->line = e->line ? xmemdupz(e->line, e->len) : NULL;
 }
 
+struct moved_entry {
+	struct hashmap_entry ent;
+	const struct emitted_diff_symbol *es;
+	struct moved_entry *next_line;
+};
+
+static int next_byte(const char **cp, const char **endp,
+		     const struct diff_options *diffopt)
+{
+	int retval;
+
+	if (*cp > *endp)
+		return -1;
+
+	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_CHANGE)) {
+		while (*cp < *endp && isspace(**cp))
+			(*cp)++;
+		/*
+		 * After skipping a couple of whitespaces, we still have to
+		 * account for one space.
+		 */
+		return (int)' ';
+	}
+
+	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {
+		while (*cp < *endp && isspace(**cp))
+			(*cp)++;
+		/* return the first non-ws character via the usual below */
+	}
+
+	retval = (unsigned char)(**cp);
+	(*cp)++;
+	return retval;
+}
+
+static int moved_entry_cmp(const struct diff_options *diffopt,
+			   const struct moved_entry *a,
+			   const struct moved_entry *b,
+			   const void *keydata)
+{
+	const char *ap = a->es->line, *ae = a->es->line + a->es->len;
+	const char *bp = b->es->line, *be = b->es->line + b->es->len;
+
+	if (!(diffopt->xdl_opts & XDF_WHITESPACE_FLAGS))
+		return a->es->len != b->es->len  || memcmp(ap, bp, a->es->len);
+
+	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_AT_EOL)) {
+		while (ae > ap && isspace(*ae))
+			ae--;
+		while (be > bp && isspace(*be))
+			be--;
+	}
+
+	while (1) {
+		int ca, cb;
+		ca = next_byte(&ap, &ae, diffopt);
+		cb = next_byte(&bp, &be, diffopt);
+		if (ca != cb)
+			return 1;
+		if (ca < 0)
+			return 0;
+	}
+}
+
+static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_options *o)
+{
+	if (o->xdl_opts & XDF_WHITESPACE_FLAGS) {
+		static struct strbuf sb = STRBUF_INIT;
+		const char *ap = es->line, *ae = es->line + es->len;
+		int c;
+
+		strbuf_reset(&sb);
+		while (ae > ap && isspace(*ae))
+			ae--;
+		while ((c = next_byte(&ap, &ae, o)) > 0)
+			strbuf_addch(&sb, c);
+
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
+	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
+
+	ret->ent.hash = get_string_hash(l, o);
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
+static int shrink_potential_moved_blocks(struct moved_entry **pmb,
+					 int pmb_nr)
+{
+	int lp, rp;
+
+	/* Shrink the set of potential block to the remaining running */
+	for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
+		while (lp < pmb_nr && pmb[lp])
+			lp++;
+		/* lp points at the first NULL now */
+
+		while (rp > -1 && !pmb[rp])
+			rp--;
+		/* rp points at the last non-NULL */
+
+		if (lp < pmb_nr && rp > -1 && lp < rp) {
+			pmb[lp] = pmb[rp];
+			pmb[rp] = NULL;
+			rp--;
+			lp++;
+		}
+	}
+
+	/* Remember the number of running sets */
+	return rp + 1;
+}
+
+/* Find blocks of moved code, delegate actual coloring decision to helper */
+static void mark_color_as_moved(struct diff_options *o,
+				struct hashmap *add_lines,
+				struct hashmap *del_lines)
+{
+	struct moved_entry **pmb = NULL; /* potentially moved blocks */
+	int pmb_nr = 0, pmb_alloc = 0;
+	int n, flipped_block = 1, block_length = 0;
+
+
+	for (n = 0; n < o->emitted_symbols->nr; n++) {
+		struct hashmap *hm = NULL;
+		struct moved_entry *key;
+		struct moved_entry *match = NULL;
+		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
+		int i;
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
+			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH) {
+				for (i = 0; i < block_length + 1; i++) {
+					l = &o->emitted_symbols->buf[n - i];
+					l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
+				}
+			}
+			pmb_nr = 0;
+			block_length = 0;
+			continue;
+		}
+
+		l->flags |= DIFF_SYMBOL_MOVED_LINE;
+		block_length++;
+
+		/* Check any potential block runs, advance each or nullify */
+		for (i = 0; i < pmb_nr; i++) {
+			struct moved_entry *p = pmb[i];
+			struct moved_entry *pnext = (p && p->next_line) ?
+					p->next_line : NULL;
+			if (pnext && !hm->cmpfn(o, pnext, match, NULL)) {
+				pmb[i] = p->next_line;
+			} else {
+				pmb[i] = NULL;
+			}
+		}
+
+		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
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
+			l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
+	}
+
+	free(pmb);
+}
 
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set, const char *reset,
@@ -720,14 +1001,24 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
-		set = diff_get_color_opt(o, DIFF_FILE_NEW);
+		if (flags & DIFF_SYMBOL_MOVED_LINE_ALT)
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
+		if (flags & DIFF_SYMBOL_MOVED_LINE_ALT)
+			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_ALT);
+		else if (flags & DIFF_SYMBOL_MOVED_LINE)
+			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED);
+		else
+			set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		emit_line_ws_markup(o, set, reset, line, len, '-',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
@@ -3740,6 +4031,8 @@ void diff_setup(struct diff_options *options)
 		options->a_prefix = "a/";
 		options->b_prefix = "b/";
 	}
+
+	options->color_moved = diff_color_moved_default;
 }
 
 void diff_setup_done(struct diff_options *options)
@@ -3849,6 +4142,9 @@ void diff_setup_done(struct diff_options *options)
 
 	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
 		die(_("--follow requires exactly one pathspec"));
+
+	if (!options->use_color || external_diff())
+		options->color_moved = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -4273,7 +4569,19 @@ int diff_opt_parse(struct diff_options *options,
 	}
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
-	else if (!strcmp(arg, "--color-words")) {
+	else if (!strcmp(arg, "--color-moved")) {
+		if (diff_color_moved_default)
+			options->color_moved = diff_color_moved_default;
+		if (options->color_moved == COLOR_MOVED_NO)
+			options->color_moved = COLOR_MOVED_DEFAULT;
+	} else if (!strcmp(arg, "--no-color-moved"))
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
@@ -5086,16 +5394,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	if (WSEH_NEW & WS_RULE_MASK)
 		die("BUG: WS rules bit mask overlaps with diff symbol flags");
 
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
+	if (o->color_moved)
+		o->emitted_symbols = &esm;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -5104,6 +5404,21 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	}
 
 	if (o->emitted_symbols) {
+		if (o->color_moved) {
+			struct hashmap add_lines, del_lines;
+
+			hashmap_init(&del_lines,
+				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
+			hashmap_init(&add_lines,
+				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
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
 
@@ -5185,6 +5500,7 @@ void diff_flush(struct diff_options *options)
 			fclose(options->file);
 		options->file = xfopen("/dev/null", "w");
 		options->close_file = 1;
+		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
diff --git a/diff.h b/diff.h
index 4a3b9bde40..3196802673 100644
--- a/diff.h
+++ b/diff.h
@@ -188,6 +188,12 @@ struct diff_options {
 	int diff_path_counter;
 
 	struct emitted_diff_symbols *emitted_symbols;
+	enum {
+		COLOR_MOVED_NO = 0,
+		COLOR_MOVED_ZEBRA = 2,
+	} color_moved;
+	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
+	#define COLOR_MOVED_MIN_BLOCK_LENGTH 3
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
@@ -208,7 +214,11 @@ enum color_diff {
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
index 289806d0c7..29704ae14e 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -972,4 +972,265 @@ test_expect_success 'option overrides diff.wsErrorHighlight' '
 
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
+test_expect_success 'move detection ignoring whitespace ' '
+	git reset --hard &&
+	cat <<\EOF >lines.txt &&
+line 1
+line 2
+line 3
+line 4
+line 5
+line 6
+line 7
+EOF
+	git add lines.txt &&
+	git commit -m "add poetry" &&
+	cat <<\EOF >lines.txt &&
+	line 5
+	line 6
+	line 7
+line 1
+line 2
+line 3
+line 4
+EOF
+	test_config color.diff.oldMoved "magenta" &&
+	test_config color.diff.newMoved "cyan" &&
+	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>index 734156d..eb89ead 100644<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,7 +1,7 @@<RESET>
+	<GREEN>+<RESET>	<GREEN>line 5<RESET>
+	<GREEN>+<RESET>	<GREEN>line 6<RESET>
+	<GREEN>+<RESET>	<GREEN>line 7<RESET>
+	 line 1<RESET>
+	 line 2<RESET>
+	 line 3<RESET>
+	 line 4<RESET>
+	<RED>-line 5<RESET>
+	<RED>-line 6<RESET>
+	<RED>-line 7<RESET>
+	EOF
+	test_cmp expected actual &&
+
+	git diff HEAD --no-renames -w --color-moved| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>index 734156d..eb89ead 100644<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,7 +1,7 @@<RESET>
+	<CYAN>+<RESET>	<CYAN>line 5<RESET>
+	<CYAN>+<RESET>	<CYAN>line 6<RESET>
+	<CYAN>+<RESET>	<CYAN>line 7<RESET>
+	 line 1<RESET>
+	 line 2<RESET>
+	 line 3<RESET>
+	 line 4<RESET>
+	<MAGENTA>-line 5<RESET>
+	<MAGENTA>-line 6<RESET>
+	<MAGENTA>-line 7<RESET>
+	EOF
+	test_cmp expected actual
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
2.13.0.31.g9b732c453e

