Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27282023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934711AbdEWClF (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:05 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32986 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753404AbdEWClD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:03 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so99662875pfh.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JYu8MJ4AYyucri5Uc+65fIgf0/VBKOeFaVCzm3btlAI=;
        b=nkDq6ttuNFzSVYYBkkvUxP416GrxGU+x30O2lVUJnClAq+ygV9Mk3gGtyIsisTATXS
         a2XEuxeKxd11dMTMAXLkMMFCA2iPQQjtrz2bg5eYU7fq/Y8ROGh0oxCu084iuVYe8F0d
         mJZ8BCJ990Rht3q/Gko80ycH35XIflQdKzo698bssHXoUXk+/guZJgxLRCGSoA5KFz3o
         4ARE6GB0NDkDnOnsQjqWDfJ6P7jPvGYrTvTmyHIbab+iDgx+jxn2q5Uawke4lPfc0tIh
         62sPyYkrFeIhlmI5++bPIP5sWOuhfB6WcdiXSO+ds6q5kShkdxj5h6V0Dd96dsyeyGhV
         4Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JYu8MJ4AYyucri5Uc+65fIgf0/VBKOeFaVCzm3btlAI=;
        b=P0ddD+5Ec4qvEynTcky6nloddOju3PrsHLATjsnEpdE59oDgQy6zy+QlMuQWWqdvc4
         O9z1QMx7cEpGkWgJ/m7O+wETVrN6b+fSVW0wDu7PZ1qw3qq9PBhS3b6aMVOjJKESWa9R
         hNKcYM9buzkFayJt4RQVKPtN/vaGHQ+WNy6kG1bGLEy/vy8AdKOqmHn1KoHP2MnARYwr
         Yu+PB7t24OBGR2R0vfH+D4FPilptwsqDlEE+IucCo0uYfPvnLvjaSSxa4ut5nGIpFs1U
         XdFufwJxYf2XMsayYlrdhBQMAqNbv6qprRVwonM6ExZ5mGicfEoo7uWa9uzGeH9CmUbF
         nQHQ==
X-Gm-Message-State: AODbwcCWqXXV2Z79k65blcOn2/5/lg3kj8OKdbBHL55PCZPztdMqZ63s
        RrjMZOb+uRi5lqts
X-Received: by 10.98.69.193 with SMTP id n62mr29579244pfi.216.1495507262367;
        Mon, 22 May 2017 19:41:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id y22sm37601067pgc.13.2017.05.22.19.41.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 00/17] Diff machine: highlight moved lines.
Date:   Mon, 22 May 2017 19:40:31 -0700
Message-Id: <20170523024048.16879-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:
* interdiff to v3 (what is currently origin/sb/diff-color-move) below.
* renamed the "buffered_patch_line" to "diff_line". Originally I planned
  to not carry the "line" part as it can be a piece of a line as well.
  But for the intended functionality it is best to keep the name.
  If we'd want to add more functionality to say have a move detection
  for words as well, we'd rename the struct to have a better name then.
  For now diff_line is the best. (Thanks Jonathan Nieder!)
* tests to demonstrate it doesn't mess with --color-words as well as
  submodules. (Thanks Jonathan Tan!)
* added in the statics (Thanks Ramsay!)
* smaller scope for the hashmaps (Thanks Jonathan Tan!)
* some commit messages were updated, prior patch 4-7 is squashed into one
  (Thanks Jonathan Tan!)
* the tests added revealed an actual fault: now that the submodule process
  is not attached to a dupe of our stdout, it would stop coloring the
  output. We need to pass on use-color explicitly.
* updated the NEEDSWORK comment in the second last patch.

Thanks for bearing,
Stefan

v3:
* see interdiff below.
* fixing one invalid computation (Thanks Junio!)
* I reasoned more about submodule and word diffing, see the commit message
  of the last patch:
  
    A note on the options '--submodule=diff' and '--color-words/--word-diff':
    In the conversion to use emit_line in the prior patches both submodules
    as well as word diff output carefully chose to call emit_line with sign=0.
    All output with sign=0 is ignored for move detection purposes in this
    patch, such that no weird looking output will be generated for these
    cases. This leads to another thought: We could pass on '--color-moved' to
    submodules such that they color up moved lines for themselves. If we'd do
    so only line moves within a repository boundary are marked up.

* better name for emit_line outside of diff.[ch]

v2:
* emit_line now takes an argument that indicates if we want it
  to emit the line prefix as well. This should allow for a more faithful
  refactoring in the beginning. (Thanks Jonathan!)
* fixed memleaks (Thanks Brandon!)
* "git -c color.moved=true log -p" works now! (Thanks Jeff)
* interdiff below, though it is large.
* less intrusive than v1 (Thanks Jonathan!)

v1:

For details on *why* see the commit message of the last commit.

The first five patches are slight refactorings to get into good
shape, the next patches are funneling all output through emit_line_*.

The second last patch introduces an option to buffer up all output
before printing, and then the last patch can color up moved lines
of code.

Any feedback welcome.

Thanks,
Stefan

Stefan Beller (17):
  diff: readability fix
  diff: move line ending check into emit_hunk_header
  diff.c: factor out diff_flush_patch_all_file_pairs
  diff: introduce more flexible emit function
  diff.c: convert fn_out_consume to use emit_line
  diff.c: convert builtin_diff to use emit_line_*
  diff.c: convert emit_rewrite_diff to use emit_line_*
  diff.c: convert emit_rewrite_lines to use emit_line_*
  submodule.c: convert show_submodule_summary to use emit_line_fmt
  diff.c: convert emit_binary_diff_body to use emit_line_*
  diff.c: convert show_stats to use emit_line_*
  diff.c: convert word diffing to use emit_line_*
  diff.c: convert diff_flush to use emit_line_*
  diff.c: convert diff_summary to use emit_line_*
  diff.c: emit_line includes whitespace highlighting
  diff: buffer all output if asked to
  diff.c: color moved lines differently

 Documentation/config.txt   |  14 +-
 diff.c                     | 858 +++++++++++++++++++++++++++++++++------------
 diff.h                     |  59 +++-
 submodule.c                |  89 ++---
 submodule.h                |   9 +-
 t/t4015-diff-whitespace.sh | 267 ++++++++++++++
 6 files changed, 1018 insertions(+), 278 deletions(-)

diff --git a/diff.c b/diff.c
index b977a5d95b..23e70d348e 100644
--- a/diff.c
+++ b/diff.c
@@ -373,11 +373,11 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 
 struct moved_entry {
 	struct hashmap_entry ent;
-	const struct buffered_patch_line *line;
+	const struct diff_line *line;
 	struct moved_entry *next_line;
 };
 
-static void get_ws_cleaned_string(const struct buffered_patch_line *l,
+static void get_ws_cleaned_string(const struct diff_line *l,
 				  struct strbuf *out)
 {
 	int i;
@@ -388,8 +388,8 @@ static void get_ws_cleaned_string(const struct buffered_patch_line *l,
 	}
 }
 
-static int buffered_patch_line_cmp_no_ws(const struct buffered_patch_line *a,
-					 const struct buffered_patch_line *b,
+static int diff_line_cmp_no_ws(const struct diff_line *a,
+					 const struct diff_line *b,
 					 const void *keydata)
 {
 	int ret;
@@ -405,8 +405,8 @@ static int buffered_patch_line_cmp_no_ws(const struct buffered_patch_line *a,
 	return ret;
 }
 
-static int buffered_patch_line_cmp(const struct buffered_patch_line *a,
-				   const struct buffered_patch_line *b,
+static int diff_line_cmp(const struct diff_line *a,
+				   const struct diff_line *b,
 				   const void *keydata)
 {
 	return a->len != b->len || strncmp(a->line, b->line, a->len);
@@ -416,17 +416,17 @@ static int moved_entry_cmp(const struct moved_entry *a,
 			   const struct moved_entry *b,
 			   const void *keydata)
 {
-	return buffered_patch_line_cmp(a->line, b->line, keydata);
+	return diff_line_cmp(a->line, b->line, keydata);
 }
 
 static int moved_entry_cmp_no_ws(const struct moved_entry *a,
 				 const struct moved_entry *b,
 				 const void *keydata)
 {
-	return buffered_patch_line_cmp_no_ws(a->line, b->line, keydata);
+	return diff_line_cmp_no_ws(a->line, b->line, keydata);
 }
 
-static unsigned get_line_hash(struct buffered_patch_line *line, unsigned ignore_ws)
+static unsigned get_line_hash(struct diff_line *line, unsigned ignore_ws)
 {
 	static struct strbuf sb = STRBUF_INIT;
 
@@ -444,7 +444,7 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 {
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
-	struct buffered_patch_line *l = &o->line_buffer[line_no];
+	struct diff_line *l = &o->line_buffer[line_no];
 
 	ret->ent.hash = get_line_hash(l, ignore_ws);
 	ret->line = l;
@@ -615,7 +615,9 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void add_lines_to_move_detection(struct diff_options *o)
+static void add_lines_to_move_detection(struct diff_options *o,
+					struct hashmap *add_lines,
+					struct hashmap *del_lines)
 {
 	struct moved_entry *prev_line = NULL;
 
@@ -628,11 +630,11 @@ static void add_lines_to_move_detection(struct diff_options *o)
 		switch (o->line_buffer[n].sign) {
 		case '+':
 			sign = '+';
-			hm = o->added_lines;
+			hm = add_lines;
 			break;
 		case '-':
 			sign = '-';
-			hm = o->deleted_lines;
+			hm = del_lines;
 			break;
 		case ' ':
 		default:
@@ -650,29 +652,31 @@ static void add_lines_to_move_detection(struct diff_options *o)
 	}
 }
 
-static void mark_color_as_moved(struct diff_options *o)
+static void mark_color_as_moved(struct diff_options *o,
+				struct hashmap *add_lines,
+				struct hashmap *del_lines)
 {
 	struct moved_entry **pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
-	int alt_flag = 0;
+	int use_alt_color = 0;
 	int n;
 
 	for (n = 0; n < o->line_buffer_nr; n++) {
 		struct hashmap *hm = NULL;
 		struct moved_entry *key;
 		struct moved_entry *match = NULL;
-		struct buffered_patch_line *l = &o->line_buffer[n];
+		struct diff_line *l = &o->line_buffer[n];
 		int i, lp, rp;
 
 		switch (l->sign) {
 		case '+':
-			hm = o->deleted_lines;
+			hm = del_lines;
 			break;
 		case '-':
-			hm = o->added_lines;
+			hm = add_lines;
 			break;
 		default:
-			alt_flag = 0; /* reset to standard, no-alt move color */
+			use_alt_color = 0;
 			pmb_nr = 0; /* no running sets */
 			continue;
 		}
@@ -690,7 +694,7 @@ static void mark_color_as_moved(struct diff_options *o)
 			struct moved_entry *pnext = (p && p->next_line) ?
 					p->next_line : NULL;
 			if (pnext &&
-			    !buffered_patch_line_cmp(pnext->line, l, o)) {
+			    !diff_line_cmp(pnext->line, l, o)) {
 				pmb[i] = p->next_line;
 			} else {
 				pmb[i] = NULL;
@@ -720,7 +724,7 @@ static void mark_color_as_moved(struct diff_options *o)
 			pmb_nr = rp + 1;
 		} else {
 			/* Toggle color */
-			alt_flag = (alt_flag + 1) % 2;
+			use_alt_color = (use_alt_color + 1) % 2;
 
 			/* Build up a new set */
 			pmb_nr = 0;
@@ -732,10 +736,12 @@ static void mark_color_as_moved(struct diff_options *o)
 
 		switch (l->sign) {
 		case '+':
-			l->set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED + alt_flag);
+			l->set = diff_get_color_opt(o,
+				DIFF_FILE_NEW_MOVED + use_alt_color);
 			break;
 		case '-':
-			l->set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED + alt_flag);
+			l->set = diff_get_color_opt(o,
+				DIFF_FILE_OLD_MOVED + use_alt_color);
 			break;
 		default:
 			die("BUG: we should have continued earlier?");
@@ -744,8 +750,8 @@ static void mark_color_as_moved(struct diff_options *o)
 	free(pmb);
 }
 
-static void emit_buffered_patch_line(struct diff_options *o,
-				     struct buffered_patch_line *e)
+static void emit_diff_line(struct diff_options *o,
+				     struct diff_line *e)
 {
 	const char *ws;
 	int has_trailing_newline, has_trailing_carriage_return;
@@ -756,7 +762,7 @@ static void emit_buffered_patch_line(struct diff_options *o,
 		fputs(diff_line_prefix(o), file);
 
 	switch (e->state) {
-	case BPL_EMIT_LINE_WS:
+	case DIFF_LINE_WS:
 		ws = diff_get_color(o->use_color, DIFF_WHITESPACE);
 		if (e->set)
 			fputs(e->set, file);
@@ -767,7 +773,7 @@ static void emit_buffered_patch_line(struct diff_options *o,
 		ws_check_emit(e->line, e->len, o->ws_rule,
 			      file, e->set, e->reset, ws);
 		return;
-	case BPL_EMIT_LINE_ASIS:
+	case DIFF_LINE_ASIS:
 		has_trailing_newline = (len > 0 && e->line[len-1] == '\n');
 		if (has_trailing_newline)
 			len--;
@@ -789,46 +795,46 @@ static void emit_buffered_patch_line(struct diff_options *o,
 		if (has_trailing_newline)
 			fputc('\n', file);
 		return;
-	case BPL_HANDOVER:
-		o->ws_rule = whitespace_rule(e->line); /*read from file, stored in line?*/
+	case DIFF_LINE_RELOAD_WS_RULE:
+		o->ws_rule = whitespace_rule(e->line);
 		return;
 	default:
 		die("BUG: malformatted buffered patch line: '%d'", e->state);
 	}
 }
 
-static void append_buffered_patch_line(struct diff_options *o,
-				       struct buffered_patch_line *e)
+static void append_diff_line(struct diff_options *o,
+				       struct diff_line *e)
 {
-	struct buffered_patch_line *f;
+	struct diff_line *f;
 	ALLOC_GROW(o->line_buffer,
 		   o->line_buffer_nr + 1,
 		   o->line_buffer_alloc);
 	f = &o->line_buffer[o->line_buffer_nr++];
 
-	memcpy(f, e, sizeof(struct buffered_patch_line));
+	memcpy(f, e, sizeof(struct diff_line));
 	f->line = e->line ? xmemdupz(e->line, e->len) : NULL;
 }
 
-void emit_line(struct diff_options *o,
-	       const char *set, const char *reset,
-	       int add_line_prefix, int markup_ws,
-	       int sign, const char *line, int len)
+static void emit_line(struct diff_options *o,
+		      const char *set, const char *reset,
+		      int add_line_prefix, int markup_ws,
+		      int sign, const char *line, int len)
 {
-	struct buffered_patch_line e = {set, reset, line,
+	struct diff_line e = {set, reset, line,
 		len, sign, add_line_prefix,
-		markup_ws ? BPL_EMIT_LINE_WS : BPL_EMIT_LINE_ASIS};
+		markup_ws ? DIFF_LINE_WS : DIFF_LINE_ASIS};
 
 	if (o->use_buffer)
-		append_buffered_patch_line(o, &e);
+		append_diff_line(o, &e);
 	else
-		emit_buffered_patch_line(o, &e);
+		emit_diff_line(o, &e);
 }
 
-void emit_line_fmt(struct diff_options *o,
-		   const char *set, const char *reset,
-		   int add_line_prefix,
-		   const char *fmt, ...)
+static void emit_line_fmt(struct diff_options *o,
+			  const char *set, const char *reset,
+			  int add_line_prefix,
+			  const char *fmt, ...)
 {
 	struct strbuf sb = STRBUF_INIT;
 	va_list ap;
@@ -1435,7 +1441,7 @@ static void diff_words_flush(struct emit_callback *ecbdata)
 	if (ecbdata->diff_words->opt->line_buffer_nr) {
 		int i;
 		for (i = 0; i < ecbdata->diff_words->opt->line_buffer_nr; i++)
-			append_buffered_patch_line(ecbdata->opt,
+			append_diff_line(ecbdata->opt,
 				&ecbdata->diff_words->opt->line_buffer[i]);
 
 		for (i = 0; i < ecbdata->diff_words->opt->line_buffer_nr; i++)
@@ -1862,8 +1868,8 @@ static void fill_print_name(struct diffstat_file *file)
 	file->print_name = pname;
 }
 
-void print_stat_summary_0(struct diff_options *options, int files,
-			  int insertions, int deletions)
+static void print_stat_summary_0(struct diff_options *options, int files,
+				 int insertions, int deletions)
 {
 	struct strbuf sb = STRBUF_INIT;
 
@@ -2857,11 +2863,11 @@ static void builtin_diff(const char *name_a,
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
 		if (o->use_buffer) {
-			struct buffered_patch_line e = BUFFERED_PATCH_LINE_INIT;
-			e.state = BPL_HANDOVER;
+			struct diff_line e = diff_line_INIT;
+			e.state = DIFF_LINE_RELOAD_WS_RULE;
 			e.line = name_b;
 			e.len = strlen(name_b);
-			append_buffered_patch_line(o, &e);
+			append_diff_line(o, &e);
 		}
 		if (xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
 				  &xpp, &xecfg))
@@ -5094,18 +5100,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
-	if (o->color_moved) {
-		unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
+	if (o->color_moved)
 		o->use_buffer = 1;
-		o->deleted_lines = xmallocz(sizeof(*o->deleted_lines));
-		o->added_lines = xmallocz(sizeof(*o->added_lines));
-		hashmap_init(o->deleted_lines, ignore_ws ?
-			(hashmap_cmp_fn)moved_entry_cmp_no_ws :
-			(hashmap_cmp_fn)moved_entry_cmp, 0);
-		hashmap_init(o->added_lines, ignore_ws ?
-			(hashmap_cmp_fn)moved_entry_cmp_no_ws :
-			(hashmap_cmp_fn)moved_entry_cmp, 0);
-	}
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -5115,12 +5111,25 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 
 	if (o->use_buffer) {
 		if (o->color_moved) {
-			add_lines_to_move_detection(o);
-			mark_color_as_moved(o);
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
 		}
 
 		for (i = 0; i < o->line_buffer_nr; i++)
-			emit_buffered_patch_line(o, &o->line_buffer[i]);
+			emit_diff_line(o, &o->line_buffer[i]);
 
 		for (i = 0; i < o->line_buffer_nr; i++)
 			free((void *)o->line_buffer[i].line);
diff --git a/diff.h b/diff.h
index 2d86e3a012..445259ebf7 100644
--- a/diff.h
+++ b/diff.h
@@ -123,11 +123,12 @@ enum diff_submodule_format {
  * into the pre/post image file. This pointer could be a union with the
  * line pointer. By storing an offset into the file instead of the literal line,
  * we can decrease the memory footprint for the buffered output. At first we
- * may want to only have indirection for the content lines, but we could
- * also have an enum (based on sign?) that stores prefabricated lines, e.g.
- * the similarity score line or hunk/file headers.
+ * may want to only have indirection for the content lines, but we could also
+ * enhance the state for emitting prefabricated lines, e.g. the similarity
+ * score line or hunk/file headers would only need to store a number or path
+ * and then the output can be constructed later on depending on state.
  */
-struct buffered_patch_line {
+struct diff_line {
 	const char *set;
 	const char *reset;
 	const char *line;
@@ -140,16 +141,16 @@ struct buffered_patch_line {
 		 * ws_check_emit which will output "line", marked up
 		 * according to ws_rule.
 		 */
-		BPL_EMIT_LINE_WS,
+		DIFF_LINE_WS,
 
 		/* Emits [lineprefix][set][sign] line [reset] */
-		BPL_EMIT_LINE_ASIS,
+		DIFF_LINE_ASIS,
 
 		/* Reloads the ws_rule; line contains the file name */
-		BPL_HANDOVER
+		DIFF_LINE_RELOAD_WS_RULE
 	} state;
 };
-#define BUFFERED_PATCH_LINE_INIT {NULL, NULL, NULL, 0, 0, 0}
+#define diff_line_INIT {NULL, NULL, NULL, 0, 0, 0}
 
 struct diff_options {
 	const char *orderfile;
@@ -226,14 +227,13 @@ struct diff_options {
 	unsigned ws_rule;
 	int use_buffer;
 
-	struct buffered_patch_line *line_buffer;
+	struct diff_line *line_buffer;
 	int line_buffer_nr, line_buffer_alloc;
 
 	int color_moved;
-	struct hashmap *deleted_lines;
-	struct hashmap *added_lines;
 };
 
+/* Emit [line_prefix] [set] line [reset] */
 void diff_emit_line(struct diff_options *o, const char *set, const char *reset,
 		    const char *line, int len);
 
diff --git a/submodule.c b/submodule.c
index 19c63197fb..428c996c97 100644
--- a/submodule.c
+++ b/submodule.c
@@ -550,6 +550,8 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 
 	/* TODO: other options may need to be passed here. */
 	argv_array_push(&cp.args, "diff");
+	if (o->use_color)
+		argv_array_push(&cp.args, "--color=always");
 	argv_array_pushf(&cp.args, "--line-prefix=%s", diff_line_prefix(o));
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 232d9ad55e..0e92bf94bf 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1124,7 +1124,7 @@ test_expect_success 'detect moved code, inside file' '
 	test_cmp expected actual
 '
 
-test_expect_success 'detect permutations inside moved code, ' '
+test_expect_success 'detect permutations inside moved code' '
 	# reusing the move example from last test:
 	cat <<-\EOF >main.c &&
 		#include<stdio.h>
@@ -1201,4 +1201,42 @@ test_expect_success 'detect permutations inside moved code, ' '
 	test_cmp expected actual
 '
 
+test_expect_success 'move detection does not mess up colored words' '
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


