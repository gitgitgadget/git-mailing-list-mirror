Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138F9C433FE
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiCDKom (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbiCDKoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:44:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A071ACA3B
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:43 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 6so2648872pgg.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C70ic36NHxPV6e5bc72Q1nkZOd3DdFa0TW/RQvHo3P0=;
        b=Zt169LOT7SIgwGjrc8mPTxsr+ADfmfw6XCozT/rr+Id2lo+dbwKMspRSfRKdwOgy9d
         wG0XAXsXJI9UAOlUbt8XD/bw2mjRhbP4LXYpmNCLdbLbM8IE5dbiVeo8MhCUBqRycyVA
         FcX5vqQuNvoYbC9JBIOJiUcwJqFet9IeCBgzw2yCT0zV+jozby+IuE9wyAmfJhYSvhsz
         /8ZB5EfKOhxdhwsFvDGlwUln0csqUF+wDTeso9g7PyzTx1osxB3PmBQK3FcCkJpGC9Ym
         UbwH93jI5d7r3UqC1a8tt3IeUzbiao/kueF1SHs6972KvaoIlf6bl1z5d+y3sGEh8C0v
         B2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C70ic36NHxPV6e5bc72Q1nkZOd3DdFa0TW/RQvHo3P0=;
        b=iEyajsIp64c/PWu8pgyhD8+VhQ69PYIPs/DuJ2PSvTSNMdB4+lUY0N2Q1N++Lcivnw
         pGIxhPGk5EKNNE9HNi8a36pUJBs5YRODSh8SSTD6gUGWEURZdhSe9Ptz6Q7ydURaTWiF
         Cx8xdxuNq5+ehDclhviLPe7KtU4GvxeJvcrbBqeT/YW/9mLEyuAjUN0YVkG8d0HebHdK
         /Y6kkj8Aoqt0fxCkubuxFO1YixsgwI70DytgwIVx9FLVVY8n7DyC5cYI9Of72oFOAiMO
         eSyfUNg/RQMY82VmWe/yALWWbgmmHmY95sxI/5cEUG9NGF1cLQa7IUnNmH4s5x7RHHE7
         a/xA==
X-Gm-Message-State: AOAM533Dfprq4g/vxHUpzA8IzYMaQNHGvVSpX1gIYZFwONm/b8XkB/CJ
        IixzwGRdR2FbFF7roLwOgEY=
X-Google-Smtp-Source: ABdhPJxTYV2+pHUfYxJY/p08Egnn2mGuoOgyhL38EU+PoCpYW/ER2Y/2OhMkBRqQVehUQOJ9d5i95Q==
X-Received: by 2002:a05:6a00:889:b0:4e0:dcc3:5e06 with SMTP id q9-20020a056a00088900b004e0dcc35e06mr42517553pfj.29.1646390622495;
        Fri, 04 Mar 2022 02:43:42 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.43.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:42 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 11/12] ls-tree: introduce "--format" option
Date:   Fri,  4 Mar 2022 18:42:37 +0800
Message-Id: <cb717d08be87e3239117c6c667cb32caabaad33d.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add a --format option to ls-tree. It has an existing default output,
and then --long and --name-only options to emit the default output
along with the objectsize and, or to only emit object paths.

Rather than add --type-only, --object-only etc. we can just support a
--format using a strbuf_expand() similar to "for-each-ref
--format". We might still add such options in the future for
convenience.

The --format implementation is slower than the existing code, but this
change does not cause any performance regressions. We'll leave the
existing show_tree() unchanged, and only run show_tree_fmt() in if
a --format different than the hardcoded built-in ones corresponding to
the existing modes is provided.

I.e. something like the "--long" output would be much slower with
this, mainly due to how we need to allocate various things to do with
quote.c instead of spewing the output directly to stdout.

The new option of '--format' comes from Ævar Arnfjörð Bjarmasonn's
idea and suggestion, this commit makes modifications in terms of the
original discussion on community [1].

Here is the statistics about performance tests:

1. Default format (hitten the builtin formats):

    "git ls-tree <tree-ish>" vs "--format='%(mode) %(type) %(object)%x09%(file)'"

    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
    Time (mean ± σ):     105.2 ms ±   3.3 ms    [User: 84.3 ms, System: 20.8 ms]
    Range (min … max):    99.2 ms … 113.2 ms    28 runs

    $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='%(mode) %(type) %(object)%x09%(file)'  HEAD"
    Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='%(mode) %(type) %(object)%x09%(file)'  HEAD
    Time (mean ± σ):     106.4 ms ±   2.7 ms    [User: 86.1 ms, System: 20.2 ms]
    Range (min … max):   100.2 ms … 110.5 ms    29 runs

2. Default format includes object size (hitten the builtin formats):

    "git ls-tree -l <tree-ish>" vs "--format='%(mode) %(type) %(object) %(size:padded)%x09%(file)'"

    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r -l HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r -l HEAD
    Time (mean ± σ):     335.1 ms ±   6.5 ms    [User: 304.6 ms, System: 30.4 ms]
    Range (min … max):   327.5 ms … 348.4 ms    10 runs

    $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='%(mode) %(type) %(object) %(size:padded)%x09%(file)'  HEAD"
    Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='%(mode) %(type) %(object) %(size:padded)%x09%(file)'  HEAD
    Time (mean ± σ):     337.2 ms ±   8.2 ms    [User: 309.2 ms, System: 27.9 ms]
    Range (min … max):   328.8 ms … 349.4 ms    10 runs

Links:
	[1] https://public-inbox.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt |  59 ++++++++++++++--
 builtin/ls-tree.c             | 129 +++++++++++++++++++++++++++++++++-
 t/t3104-ls-tree-format.sh     |  81 +++++++++++++++++++++
 3 files changed, 262 insertions(+), 7 deletions(-)
 create mode 100755 t/t3104-ls-tree-format.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index db02d6d79a..db29a9efb5 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
+	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>]
 	    <tree-ish> [<path>...]
 
 DESCRIPTION
@@ -74,6 +74,16 @@ OPTIONS
 	Do not limit the listing to the current working directory.
 	Implies --full-name.
 
+--format=<format>::
+	A string that interpolates `%(fieldname)` from the result
+	being shown. It also interpolates `%%` to `%`, and
+	`%xx` where `xx` are hex digits interpolates to character
+	with hex code `xx`; for example `%00` interpolates to
+	`\0` (NUL), `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
+	When specified, `--format` cannot be combined with other
+	format-altering options, including `--long`, `--name-only`
+	and `--object-only`.
+
 [<path>...]::
 	When paths are given, show them (note that this isn't really raw
 	pathnames, but rather a list of patterns to match).  Otherwise
@@ -82,16 +92,29 @@ OPTIONS
 
 Output Format
 -------------
-        <mode> SP <type> SP <object> TAB <file>
+
+The output format of `ls-tree` is determined by either the `--format`
+option, or other format-altering options such as `--name-only` etc.
+(see `--format` above).
+
+The use of certain `--format` directives is equivalent to using those
+options, but invoking the full formatting machinery can be slower than
+using an appropriate formatting option.
+
+In cases where the `--format` would exactly map to an existing option
+`ls-tree` will use the appropriate faster path. Thus the default format
+is equivalent to:
+
+        %(objectmode) %(objecttype) %(objectname)%x09%(path)
 
 This output format is compatible with what `--index-info --stdin` of
 'git update-index' expects.
 
 When the `-l` option is used, format changes to
 
-        <mode> SP <type> SP <object> SP <object size> TAB <file>
+        %(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)
 
-Object size identified by <object> is given in bytes, and right-justified
+Object size identified by <objectname> is given in bytes, and right-justified
 with minimum width of 7 characters.  Object size is given only for blobs
 (file) entries; for other entries `-` character is used in place of size.
 
@@ -100,6 +123,34 @@ quoted as explained for the configuration variable `core.quotePath`
 (see linkgit:git-config[1]).  Using `-z` the filename is output
 verbatim and the line is terminated by a NUL byte.
 
+Customized format:
+
+It is possible to print in a custom format by using the `--format` option,
+which is able to interpolate different fields using a `%(fieldname)` notation.
+For example, if you only care about the "objectname" and "path" fields, you
+can execute with a specific "--format" like
+
+        git ls-tree --format='%(objectname) %(path)' <tree-ish>
+
+FIELD NAMES
+-----------
+
+Various values from structured fields can be used to interpolate
+into the resulting output. For each outputing line, the following
+names can be used:
+
+objectmode::
+	The mode of the object.
+objecttype::
+	The type of the object (`blob` or `tree`).
+objectname::
+	The name of the object.
+objectsize[:padded]::
+	The size of the object ("-" if it's a tree).
+	It also supports a padded format of size with "%(size:padded)".
+path::
+	The pathname of the object.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 04aefc6106..a46fa73bb3 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -32,7 +32,10 @@ static const char *ls_tree_prefix;
 #define FIELD_MODE (1 << 4)
 #define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
 #define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
-
+static const char *format;
+static const char *default_format = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
+static const char *long_format = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
+static const char *name_only_format = "%(path)";
 struct show_tree_data {
 	unsigned mode;
 	enum object_type type;
@@ -53,6 +56,72 @@ static enum mutx_option {
 	MODE_LONG,
 } cmdmode;
 
+static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
+			      const enum object_type type, unsigned int padded)
+{
+	if (type == OBJ_BLOB) {
+		unsigned long size;
+		if (oid_object_info(the_repository, oid, &size) < 0)
+			die(_("could not get object info about '%s'"),
+			    oid_to_hex(oid));
+		if (padded)
+			strbuf_addf(line, "%7"PRIuMAX, (uintmax_t)size);
+		else
+			strbuf_addf(line, "%"PRIuMAX, (uintmax_t)size);
+	} else if (padded) {
+		strbuf_addf(line, "%7s", "-");
+	} else {
+		strbuf_addstr(line, "-");
+	}
+}
+
+static size_t expand_show_tree(struct strbuf *sb, const char *start,
+			       void *context)
+{
+	struct show_tree_data *data = context;
+	const char *end;
+	const char *p;
+	unsigned int errlen;
+	size_t len = strbuf_expand_literal_cb(sb, start, NULL);
+
+	if (len)
+		return len;
+	if (*start != '(')
+		die(_("bad ls-tree format: element '%s' does not start with '('"), start);
+
+	end = strchr(start + 1, ')');
+	if (!end)
+		die(_("bad ls-tree format: element '%s' does not end in ')'"), start);
+
+	len = end - start + 1;
+	if (skip_prefix(start, "(objectmode)", &p)) {
+		strbuf_addf(sb, "%06o", data->mode);
+	} else if (skip_prefix(start, "(objecttype)", &p)) {
+		strbuf_addstr(sb, type_name(data->type));
+	} else if (skip_prefix(start, "(objectsize:padded)", &p)) {
+		expand_objectsize(sb, data->oid, data->type, 1);
+	} else if (skip_prefix(start, "(objectsize)", &p)) {
+		expand_objectsize(sb, data->oid, data->type, 0);
+	} else if (skip_prefix(start, "(objectname)", &p)) {
+		strbuf_add_unique_abbrev(sb, data->oid, abbrev);
+	} else if (skip_prefix(start, "(path)", &p)) {
+		const char *name = data->base->buf;
+		const char *prefix = chomp_prefix ? ls_tree_prefix : NULL;
+		struct strbuf quoted = STRBUF_INIT;
+		struct strbuf sbuf = STRBUF_INIT;
+		strbuf_addstr(data->base, data->pathname);
+		name = relative_path(data->base->buf, prefix, &sbuf);
+		quote_c_style(name, &quoted, NULL, 0);
+		strbuf_addbuf(sb, &quoted);
+		strbuf_release(&sbuf);
+		strbuf_release(&quoted);
+	} else {
+		errlen = (unsigned long)len;
+		die(_("bad ls-tree format: %%%.*s"), errlen, start);
+	}
+	return len;
+}
+
 static int parse_shown_fields(unsigned int *shown_fields)
 {
 	if (cmdmode == MODE_NAME_ONLY) {
@@ -99,6 +168,38 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
+static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
+			 const char *pathname, unsigned mode, void *context)
+{
+	size_t baselen;
+	int recurse = 0;
+	struct strbuf sb = STRBUF_INIT;
+	enum object_type type = object_type(mode);
+
+	struct show_tree_data data = {
+		.mode = mode,
+		.type = type,
+		.oid = oid,
+		.pathname = pathname,
+		.base = base,
+	};
+
+	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
+		recurse = READ_TREE_RECURSIVE;
+	if (type == OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
+		return recurse;
+	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
+		return 0;
+
+	baselen = base->len;
+	strbuf_expand(&sb, format, expand_show_tree, &data);
+	strbuf_addch(&sb, line_termination);
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+	strbuf_setlen(base, baselen);
+	return recurse;
+}
+
 static int show_default(struct show_tree_data *data)
 {
 	size_t baselen = data->base->len;
@@ -178,6 +279,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct tree *tree;
 	int i, full_tree = 0;
 	unsigned int shown_fields = 0;
+	read_tree_fn_t fn = show_tree;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -198,6 +300,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "full-tree", &full_tree,
 			 N_("list entire tree; not just current directory "
 			    "(implies --full-name)")),
+		OPT_STRING_F(0, "format", &format, N_("format"),
+					 N_("format to use for the output"),
+					 PARSE_OPT_NONEG),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
@@ -218,6 +323,10 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |= LS_SHOW_TREES;
 
+	if (format && cmdmode)
+		usage_msg_opt(
+			_("--format can't be combined with other format-altering options"),
+			ls_tree_usage, ls_tree_options);
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
 	if (get_oid(argv[0], &oid))
@@ -242,6 +351,20 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 
 	parse_shown_fields(&shown_fields);
 
-	return !!read_tree(the_repository, tree, &pathspec, show_tree,
-			   &shown_fields);
+	/*
+	 * The generic show_tree_fmt() is slower than show_tree(), so
+	 * take the fast path if possible.
+	 */
+	if (format && (!strcmp(format, default_format))) {
+		fn = show_tree;
+	} else if (format && (!strcmp(format, long_format))) {
+		shown_fields = shown_fields | FIELD_SIZE;
+		fn = show_tree;
+	} else if (format && (!strcmp(format, name_only_format))) {
+		shown_fields = FIELD_PATH_NAME;
+		fn = show_tree;
+	} else if (format)
+		fn = show_tree_fmt;
+
+	return !!read_tree(the_repository, tree, &pathspec, fn, &shown_fields);
 }
diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
new file mode 100755
index 0000000000..e08c83dc47
--- /dev/null
+++ b/t/t3104-ls-tree-format.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='ls-tree --format'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'ls-tree --format usage' '
+	test_expect_code 129 git ls-tree --format=fmt -l HEAD &&
+	test_expect_code 129 git ls-tree --format=fmt --name-only HEAD &&
+	test_expect_code 129 git ls-tree --format=fmt --name-status HEAD
+'
+
+test_expect_success 'setup' '
+	mkdir dir &&
+	test_commit dir/sub-file &&
+	test_commit top-file
+'
+
+test_ls_tree_format () {
+	format=$1 &&
+	opts=$2 &&
+	fmtopts=$3 &&
+	shift 2 &&
+	git ls-tree $opts -r HEAD >expect.raw &&
+	sed "s/^/> /" >expect <expect.raw &&
+	git ls-tree --format="> $format" -r $fmtopts HEAD >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'ls-tree --format=<default-like>' '
+	test_ls_tree_format \
+		"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
+		""
+'
+
+test_expect_success 'ls-tree --format=<long-like>' '
+	test_ls_tree_format \
+		"%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)" \
+		"--long"
+'
+
+test_expect_success 'ls-tree --format=<name-only-like>' '
+	test_ls_tree_format \
+		"%(path)" \
+		"--name-only"
+'
+
+test_expect_success 'ls-tree combine --format=<default-like> and -t' '
+	test_ls_tree_format \
+	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
+	"-t" \
+	"-t"
+'
+
+test_expect_success 'ls-tree combine --format=<default-like> and --full-name' '
+	test_ls_tree_format \
+	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
+	"--full-name" \
+	"--full-name"
+'
+
+test_expect_success 'ls-tree combine --format=<default-like> and --full-tree' '
+	test_ls_tree_format \
+	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
+	"--full-tree" \
+	"--full-tree"
+'
+
+test_expect_success 'ls-tree hit fast-path with --format=<default-like>' '
+	git ls-tree -r HEAD >expect &&
+	git ls-tree --format="%(objectmode) %(objecttype) %(objectname)%x09%(path)" -r HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-tree hit fast-path with --format=<name-only-like>' '
+	git ls-tree -r --name-only HEAD >expect &&
+	git ls-tree --format="%(path)" -r HEAD >actual &&
+	test_cmp expect actual
+'
+test_done
-- 
2.34.1.402.gef0f5bd184

