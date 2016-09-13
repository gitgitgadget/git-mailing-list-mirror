Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E38520985
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbcIMEqy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:54 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35302 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753462AbcIMEqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:50 -0400
Received: by mail-pa0-f49.google.com with SMTP id b2so57817337pat.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bwPm3OX1eTf5G6dp5cZfLDR6OS1iQPxEcWDsHtKdLz0=;
        b=Vp+CdF5V/nW5bd0f1/ikESBaQZTHA+9a5sXf8R5bGVVRMBa8xBK09RV7j0kuEBRr+g
         3ndROeJ3oT+rFY2/76oEevA184VLbNYa+NgOGlL7fKyO3RwLFpostcUZ/G44Sa/5+5AH
         xxDfDVepveL7uF8BGBk+1UC2vrLsgpgvuXtWTDZh4Xn/FsAqDNgsWw9GCYznpnZ3+NP2
         L0BxWPSg9kVbaB60nSqyQNwIP4ODuG40e8IsdboObpXe4Ksnkxj6JufXzRkIG12rf/ZU
         Vu9YH9mGy2nSFj2UVuXARQI2FiA4OKJiGn1NZh70zOrN2vti7bsjSO6YQpmtfUCR/mSX
         xjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bwPm3OX1eTf5G6dp5cZfLDR6OS1iQPxEcWDsHtKdLz0=;
        b=kg3e7Qlapjc/MDgZiW7JTCDt+Gxn6L4iGmN9MPIhW87kZfI9ytAMJc3HcjDo2IkKv2
         wc7h5uUbBlYDccHgfDYlwxhygTi0VVzjVohIkZ9xkTSxIEd2yIYoa2mcJBg+708hxN6r
         zonwCJa775PIIa5j4Vbt0QmSRvdZ37eMPchzIv/9JO65g4uXfp2WkQtuf9VEz7yBBWiI
         8BxQUIwBp40VIWMHSdCIBGtpHWdEC6xFLuTpsD8+n/0OTceYOiJfaoYNjBlpvn1O8z+k
         sWJ+eEsN9hK1nr1GohDZryuAV+s4/JbEe47DExutZP4yayn2J3m7hFqrXdew4xSCIWf4
         m+7A==
X-Gm-Message-State: AE9vXwMbwiOMH3rKp3VEVTLtVCZrI3UfSgI0TOlwRS58A1RVZAXjYBLmCy7VQ4gFj7b+SAZU
X-Received: by 10.66.255.42 with SMTP id an10mr40219757pad.57.1473742009032;
        Mon, 12 Sep 2016 21:46:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id bf3sm27850161pab.39.2016.09.12.21.46.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 17/17] diff.c: color moved lines differently
Date:   Mon, 12 Sep 2016 21:46:13 -0700
Message-Id: <20160913044613.1037-18-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
In-Reply-To: <20160913044613.1037-1-sbeller@google.com>
References: <20160913044613.1037-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there is a lot of code moved around such as in 11979b9 (2005-11-18,
"http.c: reorder to avoid compilation failure.") for example, the review
process is quite hard, as it is not mentally challenging. It is rather a
tedious process, that gets boring quickly. However you still need to read
through all of the code to make sure the moved lines are there as supposed.

While it is trivial to color up a patch like the following

    $ git show -p
    commit 95b1fc60907fb9224bd785111ccd16e7e0aec4d1
    Author: Stefan Beller <sbeller@google.com>
    Date:   Mon Sep 12 20:02:46 2016 -0700

    move secure_foo from test.c to file2.c

    diff --git a/file2.c b/file2.c
    index 9163a0f..8e66dc0 100644
    --- a/file2.c
    +++ b/file2.c
    @@ -3,13 +3,6 @@ void *xmemdupz(const void *data, size_t len)
            return memcpy(xmallocz(len), data, len);
     }

    -int secure_foo(struct user *u)
    -{
    -       if (!u->is_allowed_foo)
    -               return;
    -       foo(u);
    -}
    -
     char *xstrndup(const char *str, size_t len)
     {
            char *p = memchr(str, '\0', len);
    diff --git a/test.c b/test.c
    index a95e6fe..81eb0eb 100644
    --- a/test.c
    +++ b/test.c
    @@ -18,6 +18,13 @@ ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
            return total;
     }

    +int secure_foo(struct user *u)
    +{
    +       if (!u->is_allowed_foo)
    +               return;
    +       foo(u);
    +}
    +
     int xdup(int fd)
     {
            int ret = dup(fd);

as in this patch all lines that add or remove lines
should be colored in the new color that indicates moved
lines.

However the intention of this patch is to aid reviewers
to spotting permutations in the moved code. So consider the
following malicious move:

    diff --git a/file2.c b/file2.c
    index 9163a0f..8e66dc0 100644
    --- a/file2.c
    +++ b/file2.c
    @@ -3,13 +3,6 @@ void *xmemdupz(const void *data, size_t len)
            return memcpy(xmallocz(len), data, len);
     }

    -int secure_foo(struct user *u)
    -{
    -       if (!u->is_allowed_foo)
    -               return;
    -       foo(u);
    -}
    -
     char *xstrndup(const char *str, size_t len)
     {
            char *p = memchr(str, '\0', len);
    diff --git a/test.c b/test.c
    index a95e6fe..a679c40 100644
    --- a/test.c
    +++ b/test.c
    @@ -18,6 +18,13 @@ ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
            return total;
     }

    +int secure_foo(struct user *u)
    +{
    +       foo(u);
    +       if (!u->is_allowed_foo)
    +               return;
    +}
    +
     int xdup(int fd)
     {
            int ret = dup(fd);

If the moved code is larger, it is easier to hide some permutation in the
code, which is why we would not want to color all lines as "moved" in this
case. So additionally to coloring lines differently that are added and
removed in the same diff, we need to tweak the algorithm a bit more.

As the reviewers attention should be brought to the places, where the
difference is introduced to the moved code, we will not color a moved
line if the previous line is a different moved line, i.e. in the code
above the line `foo()` is still colored as a regular added line, because
the line before the call to `foo` changed from `return` to `{`. The line
with the condition is also not colored as moved but as a new addition.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt               |  12 +-
 Documentation/diff-options.txt         |   7 +
 contrib/completion/git-completion.bash |   2 +
 diff.c                                 | 171 ++++++++++++++++++++----
 diff.h                                 |  10 +-
 t/t4015-diff-whitespace.sh             | 229 +++++++++++++++++++++++++++++++++
 6 files changed, 402 insertions(+), 29 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb679..e0c7b91 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -974,14 +974,22 @@ This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
 
+color.moved::
+	A boolean value, whether a diff should color moved lines
+	differently. The moved lines are searched for in the diff only.
+	Duplicated lines from somewhere in the project that are not
+	part of the diff are not colored as moved.
+	Defaults to true.
+
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
 	of `context` (context text - `plain` is a historical synonym),
 	`meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
-	`new` (added lines), `commit` (commit headers), or `whitespace`
-	(highlighting whitespace errors).
+	`new` (added lines), `commit` (commit headers), `whitespace`
+	(highlighting whitespace errors), `movedFrom` (removed lines that
+	reappear), `movedTo` (added lines that were removed elsewhere).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 705a873..13b6a2a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -234,6 +234,13 @@ ifdef::git-diff[]
 endif::git-diff[]
 	It is the same as `--color=never`.
 
+--[no-]color-moved::
+	Show moved blocks in a different color.
+ifdef::git-diff[]
+	It can be changed by the `diff.ui` and `color.diff`
+	configuration settings.
+endif::git-diff[]
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9c8f738..85032dd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2115,6 +2115,8 @@ _git_config ()
 		color.diff.old
 		color.diff.plain
 		color.diff.whitespace
+		color.diff.movedFrom
+		color.diff.movedTo
 		color.grep
 		color.grep.context
 		color.grep.filename
diff --git a/diff.c b/diff.c
index e240e89..f41cdcf 100644
--- a/diff.c
+++ b/diff.c
@@ -30,6 +30,7 @@ static int diff_compaction_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
+static int diff_color_moved_default;
 static int diff_context_default = 3;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
@@ -52,6 +53,8 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
+	GIT_COLOR_BLUE,		/* MOVED FROM */
+	GIT_COLOR_MAGENTA,	/* MOVED TO */
 };
 
 static int parse_diff_color_slot(const char *var)
@@ -72,6 +75,10 @@ static int parse_diff_color_slot(const char *var)
 		return DIFF_WHITESPACE;
 	if (!strcasecmp(var, "func"))
 		return DIFF_FUNCINFO;
+	if (!strcasecmp(var, "movedfrom"))
+		return DIFF_FILE_MOVED_FROM;
+	if (!strcasecmp(var, "movedto"))
+		return DIFF_FILE_MOVED_TO;
 	return -1;
 }
 
@@ -180,6 +187,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "color.moved")) {
+		diff_color_moved_default = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.context")) {
 		diff_context_default = git_config_int(var, value);
 		if (diff_context_default < 0)
@@ -287,6 +298,41 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+struct moved_entry {
+	struct hashmap_entry ent;
+	char *line;
+	int hash_prev;
+};
+
+static int moved_entry_cmp(const struct moved_entry *a,
+			   const struct moved_entry *b,
+			   const void *unused)
+{
+	return strcmp(a->line, b->line) &&
+	       a->hash_prev == b->hash_prev;
+}
+
+static struct moved_entry *prepare_entry(const char *line,
+					 unsigned long len,
+					 int ws_rule,
+					 int hash_prev)
+{
+	int i;
+	struct strbuf sb = STRBUF_INIT;
+	struct moved_entry *ret = xmalloc(sizeof(*ret));
+
+	for (i = 0; i < len; i++) {
+		if (ws_rule && isspace(line[i]))
+			continue;
+		strbuf_addch(&sb, line[i]);
+	}
+
+	ret->ent.hash = memhash(sb.buf, sb.len);
+	ret->line = xmemdupz(line, len);
+	ret->hash_prev = hash_prev;
+	return ret;
+}
+
 static char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
@@ -449,12 +495,49 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
+static int should_color_as_moved(struct diff_options *o,
+				 struct line_emission *e,
+				 struct moved_entry *keydata,
+				 struct hashmap *lookup)
+{
+	struct moved_entry *me;
+
+	if (!o->color_moved)
+		return 0;
+	if (e->first != '+' && e->first != '-')
+		return 0;
+
+	me = hashmap_get(lookup, keydata, keydata);
+
+	if (!me)
+		return 0;
+
+	if (me->hash_prev == 0 || o->hash_prev == 0)
+		return 1;
+
+	return (me->hash_prev == o->hash_prev);
+}
+
 static void emit_line_emission(struct diff_options *o, struct line_emission *e)
 {
 	FILE *file = o->file;
 
 	fputs(diff_line_prefix(o), file);
 
+	if (o->color_moved && (e->first == '+' || e->first == '-')) {
+		struct moved_entry *keydata;
+		keydata = prepare_entry(e->line, e->len,
+					DIFF_XDL_TST(o, IGNORE_WHITESPACE), 0);
+		if (e->first == '-' &&
+		    should_color_as_moved(o, e, keydata, o->added_lines))
+			e->set = diff_get_color_opt(o, DIFF_FILE_MOVED_FROM);
+		if (e->first == '+' &&
+		    should_color_as_moved(o, e, keydata, o->deleted_lines))
+			e->set = diff_get_color_opt(o, DIFF_FILE_MOVED_TO);
+
+		o->hash_prev = keydata->ent.hash;
+	}
+
 	if (e->len || e->first) {
 		if (e->set)
 			fputs(e->set, file);
@@ -568,67 +651,95 @@ static void emit_line_checked(const char *reset,
 			      unsigned ws_error_highlight,
 			      char sign)
 {
+	int i;
+	struct line_emission *e;
 	const char *set = diff_get_color(ecbdata->color_diff, color);
 	const char *ws = NULL;
+	struct diff_options *o = ecbdata->opt;
 
-	if (ecbdata->opt->ws_error_highlight & ws_error_highlight) {
+	if (o->ws_error_highlight & ws_error_highlight) {
 		ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
 		if (!*ws)
 			ws = NULL;
 	}
 
 	if (!ws)
-		emit_line_0(ecbdata->opt, set, reset, sign, line, len);
+		emit_line_0(o, set, reset, sign, line, len);
 	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
+		emit_line_0(o, ws, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		if (ecbdata->opt->use_buffer) {
-			struct line_emission e;
-			e.line = line;
-			e.len = len;
-			e.ws_rule = ecbdata->ws_rule;
-			e.set = set;
-			e.reset = reset;
-			e.ws = ws;
-			e.whitespace_check = 1;
-			e.first = sign;
-			append_line_emission_to_buffer(ecbdata->opt, &e);
+		if (o->use_buffer) {
+			emit_line_0(o, set, reset, sign, line, len);
+			i = o->line_buffer_nr - 1;
+			e = &o->line_buffer[i];
+			e->whitespace_check = 1;
+			e->ws_rule = ecbdata->ws_rule;
+			e->ws = ws;
 		} else {
-			emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
+			emit_line_0(o, set, reset, sign, "", 0);
 			ws_check_emit(line, len, ecbdata->ws_rule,
-				      ecbdata->opt->file, set, reset, ws);
+				      o->file, set, reset, ws);
 		}
 	}
+	if (o->color_moved) {
+		i = o->line_buffer_nr - 1;
+		e = &o->line_buffer[i];
+	}
 }
 
 static void emit_add_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
+	struct diff_options *o = ecbdata->opt;
 	ecbdata->lno_in_postimage++;
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_FILE_NEW, WSEH_NEW, '+');
+	if (o->color_moved) {
+		struct line_emission *l = &o->line_buffer[o->line_buffer_nr - 1];
+		struct moved_entry *keydata = prepare_entry(l->line, l->len,
+					DIFF_XDL_TST(o, IGNORE_WHITESPACE),
+					o->hash_prev);
+		l = &o->line_buffer[o->line_buffer_nr - 2];
+		if (l->first == '+')
+			keydata->hash_prev = o->hash_prev;
+		hashmap_add(o->added_lines, keydata);
+		o->hash_prev = keydata->ent.hash;
+	}
 }
 
 static void emit_del_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
+	struct diff_options *o = ecbdata->opt;
 	ecbdata->lno_in_preimage++;
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_FILE_OLD, WSEH_OLD, '-');
+	if (o->color_moved) {
+		struct line_emission *l = &o->line_buffer[o->line_buffer_nr - 1];
+		struct moved_entry *keydata = prepare_entry(l->line, l->len,
+					DIFF_XDL_TST(o, IGNORE_WHITESPACE), 0);
+		l = &o->line_buffer[o->line_buffer_nr - 2];
+		if (l->first == '-')
+			keydata->hash_prev = o->hash_prev;
+		hashmap_add(o->deleted_lines, keydata);
+		o->hash_prev = keydata->ent.hash;
+	}
 }
 
 static void emit_context_line(const char *reset,
 			      struct emit_callback *ecbdata,
 			      const char *line, int len)
 {
+	struct diff_options *o = ecbdata->opt;
 	ecbdata->lno_in_postimage++;
 	ecbdata->lno_in_preimage++;
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_CONTEXT, WSEH_CONTEXT, ' ');
+	o->hash_prev = 0;
 }
 
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -3389,6 +3500,7 @@ void diff_setup(struct diff_options *options)
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
 	options->use_color = diff_use_color_default;
+	options->color_moved = diff_color_moved_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
 	if (diff_compaction_heuristic)
@@ -3511,6 +3623,9 @@ void diff_setup_done(struct diff_options *options)
 
 	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
 		die(_("--follow requires exactly one pathspec"));
+
+	if (!options->use_color || external_diff())
+		options->color_moved = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -3961,6 +4076,10 @@ int diff_opt_parse(struct diff_options *options,
 	}
 	else if (!strcmp(arg, "--no-color"))
 		options->use_color = 0;
+	else if (!strcmp(arg, "--color-moved"))
+		options->color_moved = 1;
+	else if (!strcmp(arg, "--no-color-moved"))
+		options->color_moved = 0;
 	else if (!strcmp(arg, "--color-words")) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
@@ -4728,16 +4847,15 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	/*
-	 * TODO:
-	 * For testing purposes we want to make sure the diff machinery
-	 * works with the buffer. If there is anything emitted outside the
-	 * emit_line_emission, then the order is screwed up and the tests
-	 * will fail.
-	 *
-	 * We'll unset this flag in a later patch.
-	 */
-	o->use_buffer = 1;
+
+	if (o->color_moved) {
+		o->use_buffer = 1;
+		o->deleted_lines = xmallocz(sizeof(*o->deleted_lines));
+		o->added_lines = xmallocz(sizeof(*o->added_lines));
+		hashmap_init(o->deleted_lines, (hashmap_cmp_fn)moved_entry_cmp, 0);
+		hashmap_init(o->added_lines, (hashmap_cmp_fn)moved_entry_cmp, 0);
+	}
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
@@ -4827,6 +4945,7 @@ void diff_flush(struct diff_options *options)
 		if (!options->file)
 			die_errno("Could not open /dev/null");
 		options->close_file = 1;
+		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
diff --git a/diff.h b/diff.h
index 4df6aa5..8c3f8f7 100644
--- a/diff.h
+++ b/diff.h
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "pathspec.h"
 #include "object.h"
+#include "hashmap.h"
 
 struct rev_info;
 struct diff_options;
@@ -193,9 +194,14 @@ struct diff_options {
 
 	int diff_path_counter;
 
+	int color_moved;
 	int use_buffer;
 	struct line_emission *line_buffer;
 	int line_buffer_nr, line_buffer_alloc;
+
+	struct hashmap *deleted_lines;
+	struct hashmap *added_lines;
+	int hash_prev;
 };
 
 void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
@@ -210,7 +216,9 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
-	DIFF_FUNCINFO = 8
+	DIFF_FUNCINFO = 8,
+	DIFF_FILE_MOVED_TO = 9,
+	DIFF_FILE_MOVED_FROM = 10
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 2434157..2e3d7c9 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -934,4 +934,233 @@ test_expect_success 'the same with --ws-error-highlight' '
 	test_cmp expected current
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
+	git diff HEAD --color-moved --no-renames | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/main.c b/main.c<RESET>
+	<BOLD>new file mode 100644<RESET>
+	<BOLD>index 0000000..a986c57<RESET>
+	<BOLD>--- /dev/null<RESET>
+	<BOLD>+++ b/main.c<RESET>
+	<CYAN>@@ -0,0 +1,5 @@<RESET>
+	<BLUE>+<RESET><BLUE>#include<stdio.h><RESET>
+	<BLUE>+<RESET><BLUE>main()<RESET>
+	<BLUE>+<RESET><BLUE>{<RESET>
+	<BLUE>+<RESET><BLUE>printf("Hello World");<RESET>
+	<BLUE>+<RESET><BLUE>}<RESET>
+	<BOLD>diff --git a/test.c b/test.c<RESET>
+	<BOLD>deleted file mode 100644<RESET>
+	<BOLD>index a986c57..0000000<RESET>
+	<BOLD>--- a/test.c<RESET>
+	<BOLD>+++ /dev/null<RESET>
+	<CYAN>@@ -1,5 +0,0 @@<RESET>
+	<MAGENTA>-#include<stdio.h><RESET>
+	<MAGENTA>-main()<RESET>
+	<MAGENTA>-{<RESET>
+	<MAGENTA>-printf("Hello World");<RESET>
+	<MAGENTA>-}<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
+test_expect_success 'detect moved code, inside file' '
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
+			if (!u->is_allowed_foo)
+				return;
+			foo(u);
+		}
+
+		int another_function()
+		{
+			bar();
+		}
+	EOF
+	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/main.c b/main.c<RESET>
+	<BOLD>index 27a619c..7cf9336 100644<RESET>
+	<BOLD>--- a/main.c<RESET>
+	<BOLD>+++ b/main.c<RESET>
+	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
+	 printf("World\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<MAGENTA>-int secure_foo(struct user *u)<RESET>
+	<MAGENTA>-{<RESET>
+	<MAGENTA>-if (!u->is_allowed_foo)<RESET>
+	<MAGENTA>-return;<RESET>
+	<MAGENTA>-foo(u);<RESET>
+	<MAGENTA>-}<RESET>
+	<MAGENTA>-<RESET>
+	 int main()<RESET>
+	 {<RESET>
+	 foo();<RESET>
+	<BOLD>diff --git a/test.c b/test.c<RESET>
+	<BOLD>index 1dc1d85..e34eb69 100644<RESET>
+	<BOLD>--- a/test.c<RESET>
+	<BOLD>+++ b/test.c<RESET>
+	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
+	 printf("Hello World, but different\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<BLUE>+<RESET><BLUE>int secure_foo(struct user *u)<RESET>
+	<BLUE>+<RESET><BLUE>{<RESET>
+	<BLUE>+<RESET><BLUE>if (!u->is_allowed_foo)<RESET>
+	<BLUE>+<RESET><BLUE>return;<RESET>
+	<BLUE>+<RESET><BLUE>foo(u);<RESET>
+	<BLUE>+<RESET><BLUE>}<RESET>
+	<BLUE>+<RESET>
+	 int another_function()<RESET>
+	 {<RESET>
+	 bar();<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
+test_expect_success 'detect permutations inside moved code, ' '
+	# reusing the move example from last test:
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
+	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/main.c b/main.c<RESET>
+	<BOLD>index 27a619c..7cf9336 100644<RESET>
+	<BOLD>--- a/main.c<RESET>
+	<BOLD>+++ b/main.c<RESET>
+	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
+	 printf("World\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<MAGENTA>-int secure_foo(struct user *u)<RESET>
+	<MAGENTA>-{<RESET>
+	<RED>-if (!u->is_allowed_foo)<RESET>
+	<MAGENTA>-return;<RESET>
+	<RED>-foo(u);<RESET>
+	<RED>-}<RESET>
+	<MAGENTA>-<RESET>
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
+	<BLUE>+<RESET><BLUE>int secure_foo(struct user *u)<RESET>
+	<BLUE>+<RESET><BLUE>{<RESET>
+	<GREEN>+<RESET><GREEN>foo(u);<RESET>
+	<GREEN>+<RESET><GREEN>if (!u->is_allowed_foo)<RESET>
+	<BLUE>+<RESET><BLUE>return;<RESET>
+	<GREEN>+<RESET><GREEN>}<RESET>
+	<BLUE>+<RESET>
+	 int another_function()<RESET>
+	 {<RESET>
+	 bar();<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
-- 
2.10.0.21.g1da280f.dirty

