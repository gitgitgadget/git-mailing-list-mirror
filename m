Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B139CC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbjALJUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbjALJTi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:19:38 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2576652772
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:52 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so12352158pgh.4
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1qlnOeqEVaiMKSbmI5sjDPgEr5m39gVYOb9vyTkwAY=;
        b=aBW40ZsqzgdI+YNdH1NL3J6P/tHa9/yJd1o8Hvzuu2rmWavxKrxc5XSiAcMIpP807o
         GpPhe5yWfBVUqW98fLHtdxArDqHjnt0fbIt80f2WHkozugG/2JQRkKx/7XLLL/clZ2LR
         qHhCmI3l5qV50jbsiwK943pbXidxkaf1TQ0TXJFLVNlw8bawqEv/4JuT92h6WeagibK7
         vFWPue9IG4MQQtjHRnS3kvtrz08GES5bib6F6q8DA7fh9a/ZRiCT/usNppgoP2o5VIYL
         M1XXkwsmcWYCwrDLFP8lKvwxr8/3L1/u0K5I+iO5lbsfuTZahARKy9nfuP/q51GluW0C
         RQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1qlnOeqEVaiMKSbmI5sjDPgEr5m39gVYOb9vyTkwAY=;
        b=JI5F38st5NzLufAulTxZaQdyqfVUZAQtQYNyCRtD+P0DySatRXVqgu6VKjljg7RqZK
         /pIoBx9OW9FEqJN2mGRvQ4aPD2FGRIIjUAj141ekC14sXw9B+JETAD4LtLNVJ8SNq98c
         GFneWbTDRBMpOqzsUWIBpQyLWP05koAwag0mBARi4Nck/OEilBpbfHTxhu6SQlGR9Jfr
         jmsIY8BDiPCY/WZslDp+n8I96WOvr+gIg3NG6ph3x3ewKAGJY6TxCn79LSAI8MKeMjiW
         iPl62ywjfFtrEl2xbf5KGP6lYN5kkRht5tKjqsGRQnmjb6Ho0LF5/UomRpnwbxZr5VTR
         PwWg==
X-Gm-Message-State: AFqh2kqqvmqaKzzeqLxxtQ8vXEEuFrkFEABR0H0Z8OR9LA/mkvVHtRV7
        3uzwg97e41COMh7mg19W6fPoedPkh6NsHwlb
X-Google-Smtp-Source: AMrXdXs2ZxiJTLrbiT/h+iL0hq1lxbEqJAfeF/UU5AVfv1Q0PRWXpVfNLC77qQdgUrS2BOxM+sqeKQ==
X-Received: by 2002:a62:1d0f:0:b0:581:b3b3:7717 with SMTP id d15-20020a621d0f000000b00581b3b37717mr46866737pfd.26.1673514711226;
        Thu, 12 Jan 2023 01:11:51 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id d126-20020a623684000000b0058426d9db66sm11257069pfa.218.2023.01.12.01.11.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:11:50 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dyroneteng@gmail.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 2/6] ls-tree: use a "struct options"
Date:   Thu, 12 Jan 2023 17:11:31 +0800
Message-Id: <20230112091135.20050-3-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.98.g174eaa53973.dirty
In-Reply-To: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
References: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

As a first step towards being able to turn this code into an API some
day let's change the "static" options in builtin/ls-tree.c into a
"struct ls_tree_options" that can be constructed dynamically without
the help of parse_options().

Because we're now using non-static variables for this we'll need to
clear_pathspec() at the end of cmd_ls_tree(), least various tests
start failing under SANITIZE=leak. The memory leak was already there
before, now it's just being brought to the surface.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 203 ++++++++++++++++++++++++++--------------------
 1 file changed, 116 insertions(+), 87 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index cbb6782f9a5..54f7b604cb7 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -14,37 +14,11 @@
 #include "parse-options.h"
 #include "pathspec.h"
 
-static int line_termination = '\n';
-#define LS_RECURSIVE 1
-#define LS_TREE_ONLY (1 << 1)
-#define LS_SHOW_TREES (1 << 2)
-static int abbrev;
-static int ls_options;
-static struct pathspec pathspec;
-static int chomp_prefix;
-static const char *ls_tree_prefix;
-static const char *format;
-struct show_tree_data {
-	unsigned mode;
-	enum object_type type;
-	const struct object_id *oid;
-	const char *pathname;
-	struct strbuf *base;
-};
-
 static const  char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
 };
 
-static enum ls_tree_cmdmode {
-	MODE_DEFAULT = 0,
-	MODE_LONG,
-	MODE_NAME_ONLY,
-	MODE_NAME_STATUS,
-	MODE_OBJECT_ONLY,
-} cmdmode;
-
 static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 			      const enum object_type type, unsigned int padded)
 {
@@ -64,10 +38,39 @@ static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 	}
 }
 
+struct ls_tree_options {
+	int line_termination;
+	int abbrev;
+	enum ls_tree_path_options {
+		LS_RECURSIVE = 1 << 0,
+		LS_TREE_ONLY = 1 << 1,
+		LS_SHOW_TREES = 1 << 2,
+	} ls_options;
+	struct pathspec pathspec;
+	int chomp_prefix;
+	const char *ls_tree_prefix;
+	const char *format;
+};
+
+struct show_tree_data {
+	unsigned mode;
+	enum object_type type;
+	const struct object_id *oid;
+	const char *pathname;
+	struct strbuf *base;
+};
+
+struct show_tree_data_cb {
+	struct ls_tree_options *options;
+	struct show_tree_data *data;
+};
+
 static size_t expand_show_tree(struct strbuf *sb, const char *start,
 			       void *context)
 {
-	struct show_tree_data *data = context;
+	struct show_tree_data_cb *wrapper = context;
+	struct ls_tree_options *options = wrapper->options;
+	struct show_tree_data *data = wrapper->data;
 	const char *end;
 	const char *p;
 	unsigned int errlen;
@@ -92,10 +95,10 @@ static size_t expand_show_tree(struct strbuf *sb, const char *start,
 	} else if (skip_prefix(start, "(objectsize)", &p)) {
 		expand_objectsize(sb, data->oid, data->type, 0);
 	} else if (skip_prefix(start, "(objectname)", &p)) {
-		strbuf_add_unique_abbrev(sb, data->oid, abbrev);
+		strbuf_add_unique_abbrev(sb, data->oid, options->abbrev);
 	} else if (skip_prefix(start, "(path)", &p)) {
 		const char *name = data->base->buf;
-		const char *prefix = chomp_prefix ? ls_tree_prefix : NULL;
+		const char *prefix = options->chomp_prefix ? options->ls_tree_prefix : NULL;
 		struct strbuf quoted = STRBUF_INIT;
 		struct strbuf sbuf = STRBUF_INIT;
 		strbuf_addstr(data->base, data->pathname);
@@ -111,18 +114,19 @@ static size_t expand_show_tree(struct strbuf *sb, const char *start,
 	return len;
 }
 
-static int show_recursive(const char *base, size_t baselen, const char *pathname)
+static int show_recursive(struct ls_tree_options *options, const char *base,
+			  size_t baselen, const char *pathname)
 {
 	int i;
 
-	if (ls_options & LS_RECURSIVE)
+	if (options->ls_options & LS_RECURSIVE)
 		return 1;
 
-	if (!pathspec.nr)
+	if (!options->pathspec.nr)
 		return 0;
 
-	for (i = 0; i < pathspec.nr; i++) {
-		const char *spec = pathspec.items[i].match;
+	for (i = 0; i < options->pathspec.nr; i++) {
+		const char *spec = options->pathspec.items[i].match;
 		size_t len, speclen;
 
 		if (strncmp(base, spec, baselen))
@@ -142,13 +146,13 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 }
 
 static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
-			 const char *pathname, unsigned mode, void *context UNUSED)
+			 const char *pathname, unsigned mode, void *context)
 {
+	struct ls_tree_options *options = context;
 	size_t baselen;
 	int recurse = 0;
 	struct strbuf sb = STRBUF_INIT;
 	enum object_type type = object_type(mode);
-
 	struct show_tree_data data = {
 		.mode = mode,
 		.type = type,
@@ -156,81 +160,89 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 		.pathname = pathname,
 		.base = base,
 	};
+	struct show_tree_data_cb cb_data = {
+		.data = &data,
+		.options = options,
+	};
 
-	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
+	if (type == OBJ_TREE && show_recursive(options, base->buf, base->len, pathname))
 		recurse = READ_TREE_RECURSIVE;
-	if (type == OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
+	if (type == OBJ_TREE && recurse && !(options->ls_options & LS_SHOW_TREES))
 		return recurse;
-	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
+	if (type == OBJ_BLOB && (options->ls_options & LS_TREE_ONLY))
 		return 0;
 
 	baselen = base->len;
-	strbuf_expand(&sb, format, expand_show_tree, &data);
-	strbuf_addch(&sb, line_termination);
+	strbuf_expand(&sb, options->format, expand_show_tree, &cb_data);
+	strbuf_addch(&sb, options->line_termination);
 	fwrite(sb.buf, sb.len, 1, stdout);
 	strbuf_release(&sb);
 	strbuf_setlen(base, baselen);
 	return recurse;
 }
 
-static int show_tree_common(int *recurse, struct strbuf *base,
-			    const char *pathname, enum object_type type)
+static int show_tree_common(struct ls_tree_options *options, int *recurse,
+			    struct strbuf *base, const char *pathname,
+			    enum object_type type)
 {
 	int ret = -1;
 	*recurse = 0;
 
 	if (type == OBJ_BLOB) {
-		if (ls_options & LS_TREE_ONLY)
+		if (options->ls_options & LS_TREE_ONLY)
 			ret = 0;
 	} else if (type == OBJ_TREE &&
-		   show_recursive(base->buf, base->len, pathname)) {
+		   show_recursive(options, base->buf, base->len, pathname)) {
 		*recurse = READ_TREE_RECURSIVE;
-		if (!(ls_options & LS_SHOW_TREES))
+		if (!(options->ls_options & LS_SHOW_TREES))
 			ret = *recurse;
 	}
 
 	return ret;
 }
 
-static void show_tree_common_default_long(struct strbuf *base,
+static void show_tree_common_default_long(struct ls_tree_options *options,
+					  struct strbuf *base,
 					  const char *pathname,
 					  const size_t baselen)
 {
 	strbuf_addstr(base, pathname);
 	write_name_quoted_relative(base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
-				   line_termination);
+				   options->chomp_prefix ? options->ls_tree_prefix : NULL, stdout,
+				   options->line_termination);
 	strbuf_setlen(base, baselen);
 }
 
 static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 			     const char *pathname, unsigned mode,
-			     void *context UNUSED)
+			     void *context)
 {
+	struct ls_tree_options *options = context;
 	int early;
 	int recurse;
 	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&recurse, base, pathname, type);
+	early = show_tree_common(options, &recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
 	printf("%06o %s %s\t", mode, type_name(object_type(mode)),
-	       find_unique_abbrev(oid, abbrev));
-	show_tree_common_default_long(base, pathname, base->len);
+	       find_unique_abbrev(oid, options->abbrev));
+	show_tree_common_default_long(options, base, pathname, base->len);
 	return recurse;
 }
 
 static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 			  const char *pathname, unsigned mode,
-			  void *context UNUSED)
+			  void *context)
 {
+	struct ls_tree_options *options = context;
 	int early;
 	int recurse;
 	char size_text[24];
 	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&recurse, base, pathname, type);
+	early = show_tree_common(options, &recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
@@ -246,48 +258,58 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 	}
 
 	printf("%06o %s %s %7s\t", mode, type_name(type),
-	       find_unique_abbrev(oid, abbrev), size_text);
-	show_tree_common_default_long(base, pathname, base->len);
+	       find_unique_abbrev(oid, options->abbrev), size_text);
+	show_tree_common_default_long(options, base, pathname, base->len);
 	return recurse;
 }
 
 static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 			       const char *pathname, unsigned mode,
-			       void *context UNUSED)
+			       void *context)
 {
+	struct ls_tree_options *options = context;
 	int early;
 	int recurse;
 	const size_t baselen = base->len;
 	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&recurse, base, pathname, type);
+	early = show_tree_common(options, &recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
 	strbuf_addstr(base, pathname);
 	write_name_quoted_relative(base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL,
-				   stdout, line_termination);
+				   options->chomp_prefix ? options->ls_tree_prefix : NULL,
+				   stdout, options->line_termination);
 	strbuf_setlen(base, baselen);
 	return recurse;
 }
 
 static int show_tree_object(const struct object_id *oid, struct strbuf *base,
 			    const char *pathname, unsigned mode,
-			    void *context UNUSED)
+			    void *context)
 {
+	struct ls_tree_options *options = context;
 	int early;
 	int recurse;
 	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&recurse, base, pathname, type);
+	early = show_tree_common(options, &recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
-	printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
+	printf("%s%c", find_unique_abbrev(oid, options->abbrev), options->line_termination);
 	return recurse;
 }
 
+enum ls_tree_cmdmode {
+	MODE_DEFAULT = 0,
+	MODE_LONG,
+	MODE_NAME_ONLY,
+	MODE_NAME_STATUS,
+	MODE_OBJECT_ONLY,
+};
+
 struct ls_tree_cmdmode_to_fmt {
 	enum ls_tree_cmdmode mode;
 	const char *const fmt;
@@ -327,14 +349,18 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct tree *tree;
 	int i, full_tree = 0;
 	read_tree_fn_t fn = NULL;
+	enum ls_tree_cmdmode cmdmode = MODE_DEFAULT;
+	struct ls_tree_options options = {
+		.line_termination = '\n',
+	};
 	const struct option ls_tree_options[] = {
-		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
+		OPT_BIT('d', NULL, &options.ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
-		OPT_BIT('r', NULL, &ls_options, N_("recurse into subtrees"),
+		OPT_BIT('r', NULL, &options.ls_options, N_("recurse into subtrees"),
 			LS_RECURSIVE),
-		OPT_BIT('t', NULL, &ls_options, N_("show trees when recursing"),
+		OPT_BIT('t', NULL, &options.ls_options, N_("show trees when recursing"),
 			LS_SHOW_TREES),
-		OPT_SET_INT('z', NULL, &line_termination,
+		OPT_SET_INT('z', NULL, &options.line_termination,
 			    N_("terminate entries with NUL byte"), 0),
 		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
 			    MODE_LONG),
@@ -344,29 +370,30 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			    MODE_NAME_STATUS),
 		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
 			    MODE_OBJECT_ONLY),
-		OPT_SET_INT(0, "full-name", &chomp_prefix,
+		OPT_SET_INT(0, "full-name", &options.chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
 			 N_("list entire tree; not just current directory "
 			    "(implies --full-name)")),
-		OPT_STRING_F(0, "format", &format, N_("format"),
+		OPT_STRING_F(0, "format", &options.format, N_("format"),
 					 N_("format to use for the output"),
 					 PARSE_OPT_NONEG),
-		OPT__ABBREV(&abbrev),
+		OPT__ABBREV(&options.abbrev),
 		OPT_END()
 	};
 	struct ls_tree_cmdmode_to_fmt *m2f = ls_tree_cmdmode_format;
+	int ret;
 
 	git_config(git_default_config, NULL);
-	ls_tree_prefix = prefix;
+	options.ls_tree_prefix = prefix;
 	if (prefix)
-		chomp_prefix = strlen(prefix);
+		options.chomp_prefix = strlen(prefix);
 
 	argc = parse_options(argc, argv, prefix, ls_tree_options,
 			     ls_tree_usage, 0);
 	if (full_tree) {
-		ls_tree_prefix = prefix = NULL;
-		chomp_prefix = 0;
+		options.ls_tree_prefix = prefix = NULL;
+		options.chomp_prefix = 0;
 	}
 	/*
 	 * We wanted to detect conflicts between --name-only and
@@ -378,10 +405,10 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 
 	/* -d -r should imply -t, but -d by itself should not have to. */
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
-	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
-		ls_options |= LS_SHOW_TREES;
+	    ((LS_TREE_ONLY|LS_RECURSIVE) & options.ls_options))
+		options.ls_options |= LS_SHOW_TREES;
 
-	if (format && cmdmode)
+	if (options.format && cmdmode)
 		usage_msg_opt(
 			_("--format can't be combined with other format-altering options"),
 			ls_tree_usage, ls_tree_options);
@@ -396,13 +423,13 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
-				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
+	parse_pathspec(&options.pathspec, PATHSPEC_ALL_MAGIC &
+		       ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
-	for (i = 0; i < pathspec.nr; i++)
-		pathspec.items[i].nowildcard_len = pathspec.items[i].len;
-	pathspec.has_wildcard = 0;
+	for (i = 0; i < options.pathspec.nr; i++)
+		options.pathspec.items[i].nowildcard_len = options.pathspec.items[i].len;
+	options.pathspec.has_wildcard = 0;
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
@@ -412,11 +439,11 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 */
 	while (m2f) {
 		if (!m2f->fmt) {
-			fn = format ? show_tree_fmt : show_tree_default;
-		} else if (format && !strcmp(format, m2f->fmt)) {
+			fn = options.format ? show_tree_fmt : show_tree_default;
+		} else if (options.format && !strcmp(options.format, m2f->fmt)) {
 			cmdmode = m2f->mode;
 			fn = m2f->fn;
-		} else if (!format && cmdmode == m2f->mode) {
+		} else if (!options.format && cmdmode == m2f->mode) {
 			fn = m2f->fn;
 		} else {
 			m2f++;
@@ -425,5 +452,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
+	ret = !!read_tree(the_repository, tree, &options.pathspec, fn, &options);
+	clear_pathspec(&options.pathspec);
+	return ret;
 }
-- 
2.39.0.98.g174eaa53973.dirty

