Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1314C001B0
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 16:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGOQHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOQHs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 12:07:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9276D2D51
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 09:07:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992acf67388so379454166b.1
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689437265; x=1692029265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk2KqKEW9sbhSYz7GpJZM4lmutNfIf4SmEpOAgqqBqs=;
        b=UgmT/UlkSsF5JEeJhOI3aUhwMiO9vgTXtNYlEe43Jsv8M1DRv2hx/hiR8y/oZoe4dl
         b0OpYNZqEkoWX0r0zQxABqdGpKvdznN9QwhvTpvdqdlukCF3E0UZmmwU7MitkDTpswfQ
         4BMlGd3ld7I6cWlIG3/z97q8PK3LXIykK8SNsz2Z+0z0jEuvdivW9WninV51qaypwJ1R
         2DWMMdONxjX5FOER/dc+QYy9t34IrwPRFINOdpDI4ot7EWnO/WXHSL2pra0sy0fKUkIt
         4JTM0BYUSxbywpSLeZ8KVz8VHUqcg8itHQSnZNH02Jo+LroYcPQP1gZNLkkFlTfIWO8R
         K5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689437265; x=1692029265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk2KqKEW9sbhSYz7GpJZM4lmutNfIf4SmEpOAgqqBqs=;
        b=P8C/R8yo59thyI7txH6Ed2U2F1XykdZ9FgZap60IyArKcmAc8F4m+w2+dJdQpOUOKe
         C4XhyH3s8fdtZp3BYA63l4Fm0TEQtbKJGcA+1cu+P6E/lheasZPIiloVBX1XU4eXK+Ud
         LUJzFVdeULKRBnwt578itb4LsORq3E6TczW8C1fNu4OERwPM6pf1Ktbzsq/y6qbextpz
         /gb1vpXaSrE6+pOCnwyuFmBMt1Lg988M6UxLIk8CyAuLQHEQN2ijSg5cqj0Pb/vz56S5
         hmwSPDluYbDgxhHCTMc3BJLyhs2Ko3o87c9pTOupkZ0KF/10TlzDSzG6eFFm8R3behfs
         hbrg==
X-Gm-Message-State: ABy/qLZucbsWzqJsde5NuJZWzMQztg9Y8iZagQKnW2UJIIlvBA1c3Q9t
        qn4+uvjn6KKuiysezDC7IfLgmMfibfM=
X-Google-Smtp-Source: APBJJlG+LJGWkNYrdmIkWLqSYwcQwR6b6cSzT2d4KJjrjFJR1/6JjzeMyuNkdOPLL3TZ+aUvEar1Tw==
X-Received: by 2002:a17:906:314c:b0:957:1df0:9cbf with SMTP id e12-20020a170906314c00b009571df09cbfmr5552247eje.19.1689437264679;
        Sat, 15 Jul 2023 09:07:44 -0700 (PDT)
Received: from localhost.localdomain (host-92-6-81-118.as13285.net. [92.6.81.118])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709063ac200b009944e955e19sm2266851ejd.30.2023.07.15.09.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:07:44 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2] pretty: add %(decorate[:<options>]) format
Date:   Sat, 15 Jul 2023 17:07:29 +0100
Message-ID: <20230715160730.4046-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230715103758.3862-1-andy.koppe@gmail.com>
References: <20230715103758.3862-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lists ref names in the same way as the %d decoration format, but
allows all the otherwise fixed strings printed around the ref names to
be customized, namely prefix, suffix, separator, the "tag:" annotation
and the arrow used to show where HEAD points.

Examples:
- %(decorate) is equivalent to %d.
- %(decorate:prefix=,suffix=) is equivalent to %D.
- %(decorate:prefix=,suffix=,separator= ,tag=,arrow=->) produces a
  space-separated list without wrapping, tag annotations or spaces
  around the arrow.
- %(decorate:prefix=[,suffix=],separator=%x2C,arrow=%x2C,tag=) produces
  a comma-separated list enclosed in square brackets where the arrow is
  replaced by a comma as well.

Add functions parse_decoration_option(), parse_decoration_options() and
free_decoration_options() to help implement the format. Test it in
t4205-log-pretty-formats.sh and document it in pretty-formats.txt.

Refactor format_decorations() to take a struct decoration_options
argument specifying those strings, whereby NULL entries select the
default. Avoid emitting color sequences for empty strings.

Wrap tag annotations in separate color sequences from tag names, because
otherwise tag names can end up uncolored when %w width formatting breaks
lines between annotation and name. Amend t4207-log-decoration-colors.sh
accordingly.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
Corrected mistakes in commit description.

 Documentation/pretty-formats.txt | 19 ++++++++-
 log-tree.c                       | 69 ++++++++++++++++++++------------
 log-tree.h                       | 17 ++++----
 pretty.c                         | 62 +++++++++++++++++++++++++++-
 t/t4205-log-pretty-formats.sh    | 21 ++++++++++
 t/t4207-log-decoration-colors.sh | 32 +++++++++------
 6 files changed, 171 insertions(+), 49 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 3b71334459..c08aba15af 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -222,7 +222,22 @@ The placeholders are:
 	linkgit:git-rev-list[1])
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
-'%(describe[:options])':: human-readable name, like
+'%(decorate[:<options>])':: ref names with custom decorations.
+			  The `decorate` string may be followed by a colon
+			  and zero or more comma-separated options.
+			  Option values may contain literal formatting codes.
+			  These must be used for commas (`%x2C`) and closing
+			  parentheses (`%x29`), due to their role in the option
+			  syntax.
++
+** 'prefix=<value>': Shown before the list of ref names.  Defaults to " (".
+** 'suffix=<value>': Shown after the list of ref names.  Defaults to ")".
+** 'separator=<value>': Shown between ref names.  Defaults to ", ".
+** 'arrow=<value>': Shown between HEAD and the branch it points to, if any.
+		    Defaults to " \-> ".
+** 'tag=<value>': Shown before tag names. Defaults to "tag: ".
+
+'%(describe[:<options>])':: human-readable name, like
 			  linkgit:git-describe[1]; empty string for
 			  undescribable commits.  The `describe` string
 			  may be followed by a colon and zero or more
@@ -281,7 +296,7 @@ endif::git-rev-list[]
 '%gE':: reflog identity email (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%gs':: reflog subject
-'%(trailers[:options])':: display the trailers of the body as
+'%(trailers[:<options>])':: display the trailers of the body as
 			  interpreted by
 			  linkgit:git-interpret-trailers[1]. The
 			  `trailers` string may be followed by a colon
diff --git a/log-tree.c b/log-tree.c
index f4b22a60cc..4b46884ef6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -301,27 +301,34 @@ static void show_name(struct strbuf *sb, const struct name_decoration *decoratio
 
 /*
  * The caller makes sure there is no funny color before calling.
- * format_decorations_extended makes sure the same after return.
+ * format_decorations ensures the same after return.
  */
-void format_decorations_extended(struct strbuf *sb,
+void format_decorations(struct strbuf *sb,
 			const struct commit *commit,
 			int use_color,
-			const char *prefix,
-			const char *separator,
-			const char *suffix)
+			const struct decoration_options *opts)
 {
-	const struct name_decoration *decoration;
-	const struct name_decoration *current_and_HEAD;
-	const char *color_commit =
-		diff_get_color(use_color, DIFF_COMMIT);
-	const char *color_reset =
-		decorate_get_color(use_color, DECORATION_NONE);
+	const char *color_commit, *color_reset;
+	const char *prefix, *suffix, *separator, *arrow, *tag;
+
+	const struct name_decoration *current_and_HEAD;
+	const struct name_decoration *decoration =
+		get_name_decoration(&commit->object);
 
-	decoration = get_name_decoration(&commit->object);
 	if (!decoration)
 		return;
 
+	color_commit = diff_get_color(use_color, DIFF_COMMIT);
+	color_reset = decorate_get_color(use_color, DECORATION_NONE);
+
+	prefix = (opts && opts->prefix) ? opts->prefix : " (";
+	suffix = (opts && opts->suffix) ? opts->suffix : ")";
+	separator = (opts && opts->separator) ? opts->separator : ", ";
+	arrow = (opts && opts->arrow) ? opts->arrow : " -> ";
+	tag = (opts && opts->tag) ? opts->tag : "tag: ";
+
 	current_and_HEAD = current_pointed_by_HEAD(decoration);
+
 	while (decoration) {
 		/*
 		 * When both current and HEAD are there, only
@@ -329,20 +336,29 @@ void format_decorations_extended(struct strbuf *sb,
 		 * appeared, skipping the entry for current.
 		 */
 		if (decoration != current_and_HEAD) {
-			strbuf_addstr(sb, color_commit);
-			strbuf_addstr(sb, prefix);
-			strbuf_addstr(sb, color_reset);
-			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
-			if (decoration->type == DECORATION_REF_TAG)
-				strbuf_addstr(sb, "tag: ");
+			const char *color =
+				decorate_get_color(use_color, decoration->type);
 
+			if (*prefix) {
+				strbuf_addstr(sb, color_commit);
+				strbuf_addstr(sb, prefix);
+				strbuf_addstr(sb, color_reset);
+			}
+
+			if (*tag && decoration->type == DECORATION_REF_TAG) {
+				strbuf_addstr(sb, color);
+				strbuf_addstr(sb, tag);
+				strbuf_addstr(sb, color_reset);
+			}
+			strbuf_addstr(sb, color);
 			show_name(sb, decoration);
 
-			if (current_and_HEAD &&
+			if (*arrow && current_and_HEAD &&
 			    decoration->type == DECORATION_REF_HEAD) {
-				strbuf_addstr(sb, " -> ");
+				strbuf_addstr(sb, arrow);
 				strbuf_addstr(sb, color_reset);
-				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
+				strbuf_addstr(sb, decorate_get_color(
+					use_color, current_and_HEAD->type));
 				show_name(sb, current_and_HEAD);
 			}
 			strbuf_addstr(sb, color_reset);
@@ -351,9 +367,12 @@ void format_decorations_extended(struct strbuf *sb,
 		}
 		decoration = decoration->next;
 	}
-	strbuf_addstr(sb, color_commit);
-	strbuf_addstr(sb, suffix);
-	strbuf_addstr(sb, color_reset);
+
+	if (*suffix) {
+		strbuf_addstr(sb, color_commit);
+		strbuf_addstr(sb, suffix);
+		strbuf_addstr(sb, color_reset);
+	}
 }
 
 void show_decorations(struct rev_info *opt, struct commit *commit)
@@ -368,7 +387,7 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 	}
 	if (!opt->show_decorations)
 		return;
-	format_decorations(&sb, commit, opt->diffopt.use_color);
+	format_decorations(&sb, commit, opt->diffopt.use_color, NULL);
 	fputs(sb.buf, opt->diffopt.file);
 	strbuf_release(&sb);
 }
diff --git a/log-tree.h b/log-tree.h
index e7e4641cf8..39ab06a3ca 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,17 +13,20 @@ struct decoration_filter {
 	struct string_list *exclude_ref_config_pattern;
 };
 
+struct decoration_options {
+	char *prefix;
+	char *suffix;
+	char *separator;
+	char *arrow;
+	char *tag;
+};
+
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 void show_log(struct rev_info *opt);
-void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
-			     int use_color,
-			     const char *prefix,
-			     const char *separator,
-			     const char *suffix);
-#define format_decorations(strbuf, commit, color) \
-			     format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")
+void format_decorations(struct strbuf *sb, const struct commit *commit,
+			int use_color, const struct decoration_options *opts);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
diff --git a/pretty.c b/pretty.c
index 0bb938021b..a59b7f0dbc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1373,6 +1373,46 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 	return arg - start;
 }
 
+
+static int parse_decoration_option(const char **arg,
+				   const char *name,
+				   char **opt)
+{
+	const char *argval;
+	size_t arglen;
+
+	if (match_placeholder_arg_value(*arg, name, arg, &argval, &arglen)) {
+		char *val = xstrndup(argval, arglen);
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_expand(&sb, val, strbuf_expand_literal_cb, NULL);
+		free(val);
+		*opt = strbuf_detach(&sb, NULL);
+		return 1;
+	}
+	return 0;
+}
+
+static void parse_decoration_options(const char **arg,
+				     struct decoration_options *opts)
+{
+	while (parse_decoration_option(arg, "prefix", &opts->prefix) ||
+	       parse_decoration_option(arg, "suffix", &opts->suffix) ||
+	       parse_decoration_option(arg, "separator", &opts->separator) ||
+	       parse_decoration_option(arg, "arrow", &opts->arrow) ||
+	       parse_decoration_option(arg, "tag", &opts->tag))
+		;
+}
+
+static void free_decoration_options(const struct decoration_options *opts)
+{
+	free(opts->prefix);
+	free(opts->suffix);
+	free(opts->separator);
+	free(opts->arrow);
+	free(opts->tag);
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1526,10 +1566,11 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decorations(sb, commit, c->auto_color);
+		format_decorations(sb, commit, c->auto_color, NULL);
 		return 1;
 	case 'D':
-		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
+		format_decorations(sb, commit, c->auto_color,
+				   &(struct decoration_options){"", ""});
 		return 1;
 	case 'S':		/* tag/branch like --source */
 		if (!(c->pretty_ctx->rev && c->pretty_ctx->rev->sources))
@@ -1627,6 +1668,23 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 2;
 	}
 
+	if (skip_prefix(placeholder, "(decorate", &arg)) {
+		struct decoration_options opts = { NULL };
+		size_t ret = 0;
+
+		if (*arg == ':') {
+			arg++;
+			parse_decoration_options(&arg, &opts);
+		}
+		if (*arg == ')') {
+			format_decorations(sb, commit, c->auto_color, &opts);
+			ret = arg - placeholder + 1;
+		}
+
+		free_decoration_options(&opts);
+		return ret;
+	}
+
 	/* For the rest we have to parse the commit header. */
 	if (!c->commit_header_parsed) {
 		msg = c->message =
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 4cf8a77667..5ea937648a 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -576,6 +576,27 @@ test_expect_success 'clean log decoration' '
 	test_cmp expected actual1
 '
 
+test_expect_success 'pretty format %decorate' '
+	git checkout -b foo &&
+	git commit --allow-empty -m "new commit" &&
+	git tag bar &&
+	git branch qux &&
+	echo " (HEAD -> foo, tag: bar, qux)" >expect1 &&
+	git log --format="%(decorate)" -1 >actual1 &&
+	test_cmp expect1 actual1 &&
+	echo "HEAD -> foo, tag: bar, qux" >expect2 &&
+	git log --format="%(decorate:prefix=,suffix=)" -1 >actual2 &&
+	test_cmp expect2 actual2 &&
+	echo "HEAD->foo bar qux" >expect3 &&
+	git log --format="%(decorate:prefix=,suffix=,separator= ,arrow=->,tag=)" \
+		-1 >actual3 &&
+	test_cmp expect3 actual3 &&
+	echo "[HEAD,foo,bar,qux]" >expect4 &&
+	git log --format="%(decorate:prefix=[,suffix=],separator=%x2C,arrow=%x2C,tag=)" \
+		-1 >actual4 &&
+	test_cmp expect4 actual4
+'
+
 cat >trailers <<EOF
 Signed-off-by: A U Thor <author@example.com>
 Acked-by: A U Thor <author@example.com>
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index ded33a82e2..3a4eedc494 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -55,13 +55,15 @@ test_expect_success 'commit decorations colored correctly' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_commit}, \
 ${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset} \
-On main: Changes to A.t
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_stash}refs/stash${c_reset}${c_commit})${c_reset} On main: Changes to A.t
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
@@ -78,10 +80,12 @@ test_expect_success 'test coloring with replace-objects' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
@@ -102,11 +106,13 @@ test_expect_success 'test coloring with grafted commit' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
-- 
2.41.0

