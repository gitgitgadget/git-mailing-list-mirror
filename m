Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542C7C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 04:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiAFEcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiAFEcU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 23:32:20 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD7C034004
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 20:32:16 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s15so1636977plg.12
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 20:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OEuJFjdW1Rt6Uc2F34/ejGd2s6uxeqOSYWbM3IR82QA=;
        b=GhWzjcCR0jY0RRFyHTn4GsgmOLZca7na3PVGB1vrzTULHVldrmDcfX62yBl30CujpA
         N/s3LBGZWZ4qF46lvvSg1WSdIt+TZS6tGgyZJ/lAldezhmmQMSlmA7PZFEXotj57uJGA
         yrLSeRXtWitzb+DMjHKbr0Rxp5yHJ9YA6CpyCZy8KDwWf5silWuNT2BkeclUwkILcuZj
         SQOGOUF4lq2SIAy+P1i8v7NGeAl/xDwibufx7GeAkfleXh80pSXnzcBDKofLEAw0GmYk
         pCqfLvJSWP+Xm5FgabtbPeg+Dk2orAa2y4N8HDVMJJrOhm0JE9jrncvxUJBujTo/pbKs
         xspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OEuJFjdW1Rt6Uc2F34/ejGd2s6uxeqOSYWbM3IR82QA=;
        b=vluUEtSa4VePdrsQGifyZvLCT5FxYg5MFzSQWL8qGH9k6HWsd9am4tr7ZtvUYZfzkn
         7fenl5niRslt1954EeacRq2tQ04ii2Aq+RZ74otph0z0WvCamwmul21CoNA3Xa+TVEKZ
         0b8OJvJC8/MjuWNsEGW5gVHGh14pJeE369XUSYDq4hdxhiuckxe1Bkx6ko2OaKUlR1rY
         ggYQUGo2qSI6mDMmtv5M+Cf7QOPBVYWrbrWvVT//6k0SQsPiyrnQ8K79xs2VesflOp3u
         BMKfh+KgGfPJdDAArs3aEjXltmbDMGCtCkvz2mSy9eGB5ZU64AFy7rnA7fu0E+hDWFgx
         Sosw==
X-Gm-Message-State: AOAM531RFB5g6yw8gTXaXvbN2ZGQTaluc6wSe+GM+kdDFALpOsR9/4TB
        lXAChCVUwDmgAB+o7p66z0Ok90HYJzzI6uNaRfo=
X-Google-Smtp-Source: ABdhPJxaELwwsgfzmMeAEHHITdl8dfSHEv0E7ML5DYvGuK1HYlBZs8fEDYcOvYOnmDlEv8jhnMBECw==
X-Received: by 2002:a17:90b:1c0d:: with SMTP id oc13mr7972695pjb.65.1641443535744;
        Wed, 05 Jan 2022 20:32:15 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id 13sm636491pfm.161.2022.01.05.20.32.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 20:32:15 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v9 8/9] ls-tree.c: introduce "--format" option
Date:   Thu,  6 Jan 2022 12:31:31 +0800
Message-Id: <7df58483a4f665f9f54b92a97a6b57704f1e7a0d.1641440700.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1794.g2ae0a9cb82
In-Reply-To: <cover.1641440700.git.dyroneteng@gmail.com>
References: <cover.1641440700.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt |  50 ++++++++++-
 builtin/ls-tree.c             | 158 ++++++++++++++++++++++++++++++----
 t/t3105-ls-tree-format.sh     |  55 ++++++++++++
 3 files changed, 243 insertions(+), 20 deletions(-)
 create mode 100755 t/t3105-ls-tree-format.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 729370f235..2ca8667c5b 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,9 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]]
-	    <tree-ish> [<path>...]
-
+	    [--name-only] [--name-status] [--object-only]
+	    [--full-name] [--full-tree] [--abbrev[=<n>]]
+	    [--format=<format>] <tree-ish> [<path>...]
 DESCRIPTION
 -----------
 Lists the contents of a given tree object, like what "/bin/ls -a" does
@@ -79,6 +79,16 @@ OPTIONS
 	Do not limit the listing to the current working directory.
 	Implies --full-name.
 
+--format=<format>::
+	A string that interpolates `%(fieldname)` from the result
+	being shown. It also interpolates `%%` to `%`, and
+	`%xx` where `xx`are hex digits interpolates to character
+	with hex code `xx`; for example `%00` interpolates to
+	`\0` (NUL), `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
+	When specified, `--format` cannot be combined with other
+	format-altering options, including `--long`, `--name-only`
+	and `--object-only`.
+
 [<path>...]::
 	When paths are given, show them (note that this isn't really raw
 	pathnames, but rather a list of patterns to match).  Otherwise
@@ -87,6 +97,9 @@ OPTIONS
 
 Output Format
 -------------
+
+Default format:
+
         <mode> SP <type> SP <object> TAB <file>
 
 This output format is compatible with what `--index-info --stdin` of
@@ -105,6 +118,37 @@ quoted as explained for the configuration variable `core.quotePath`
 (see linkgit:git-config[1]).  Using `-z` the filename is output
 verbatim and the line is terminated by a NUL byte.
 
+Customized format:
+
+It's support to print customized format by `%(fieldname)` with `--format` option.
+For example, if you want to only print the <object> and <file> fields with a
+JSON style, executing with a specific "--format" like
+
+        git ls-tree --format='{"object":"%(object)", "file":"%(file)"}' <tree-ish>
+
+The output format changes to:
+
+        {"object":"<object>", "file":"<file>"}
+
+FIELD NAMES
+-----------
+
+Various values from structured fields can be used to interpolate
+into the resulting output. For each outputing line, the following
+names can be used:
+
+mode::
+	The mode of the object.
+type::
+	The type of the object (`blob` or `tree`).
+object::
+	The name of the object.
+size[:padded]::
+	The size of the object ("-" if it's a tree).
+	It also supports a padded format of size with "%(size:padded)".
+file::
+	The filename of the object.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 12beb02423..d0ba7c4365 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -57,6 +57,12 @@ enum {
 
 static int cmdmode = MODE_UNSPECIFIED;
 
+static const char *format;
+static const char *default_format = "%(mode) %(type) %(object)%x09%(file)";
+static const char *long_format = "%(mode) %(type) %(object) %(size:padded)%x09%(file)";
+static const char *name_only_format = "%(file)";
+static const char *object_only_format = "%(object)";
+
 static int parse_shown_fields(void)
 {
 	if (cmdmode == MODE_NAME_ONLY) {
@@ -76,6 +82,72 @@ static int parse_shown_fields(void)
 	return 1;
 }
 
+static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
+			      const enum object_type type, unsigned int padded)
+{
+	if (type == OBJ_BLOB) {
+		unsigned long size;
+		if (oid_object_info(the_repository, oid, &size) < 0)
+			die(_("could not get object info about '%s'"),
+			    oid_to_hex(oid));
+		if (padded)
+			strbuf_addf(line, "%7" PRIuMAX, (uintmax_t)size);
+		else
+			strbuf_addf(line, "%" PRIuMAX, (uintmax_t)size);
+	} else if (padded) {
+		strbuf_addf(line, "%7s", "-");
+	} else {
+		strbuf_addstr(line, "-");
+	}
+}
+
+static size_t expand_show_tree(struct strbuf *line, const char *start,
+			       void *context)
+{
+	struct show_tree_data *data = context;
+	const char *end;
+	const char *p;
+	unsigned int errlen;
+	size_t len = strbuf_expand_literal_cb(line, start, NULL);
+
+	if (len)
+		return len;
+	if (*start != '(')
+		die(_("bad ls-tree format: as '%s'"), start);
+
+	end = strchr(start + 1, ')');
+	if (!end)
+		die(_("bad ls-tree format: element '%s' does not end in ')'"), start);
+
+	len = end - start + 1;
+	if (skip_prefix(start, "(mode)", &p)) {
+		strbuf_addf(line, "%06o", data->mode);
+	} else if (skip_prefix(start, "(type)", &p)) {
+		strbuf_addstr(line, type_name(data->type));
+	} else if (skip_prefix(start, "(size:padded)", &p)) {
+		expand_objectsize(line, data->oid, data->type, 1);
+	} else if (skip_prefix(start, "(size)", &p)) {
+		expand_objectsize(line, data->oid, data->type, 0);
+	} else if (skip_prefix(start, "(object)", &p)) {
+		strbuf_add_unique_abbrev(line, data->oid, abbrev);
+	} else if (skip_prefix(start, "(file)", &p)) {
+		const char *name = data->base->buf;
+		const char *prefix = chomp_prefix ? ls_tree_prefix : NULL;
+		struct strbuf quoted = STRBUF_INIT;
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(data->base, data->pathname);
+		name = relative_path(data->base->buf, prefix, &sb);
+		quote_c_style(name, &quoted, NULL, 0);
+		strbuf_addbuf(line, &quoted);
+		strbuf_release(&sb);
+		strbuf_release(&quoted);
+	} else {
+		errlen = (unsigned long)len;
+		die(_("bad ls-tree format: %%%.*s"), errlen, start);
+	}
+	return len;
+}
+
 static int show_recursive(const char *base, size_t baselen,
 			  const char *pathname)
 {
@@ -107,6 +179,52 @@ static int show_recursive(const char *base, size_t baselen,
 	return 0;
 }
 
+static void init_recursive(struct strbuf *base, const char *pathname,
+				int *recursive)
+{
+	if (show_recursive(base->buf, base->len, pathname))
+		*recursive = READ_TREE_RECURSIVE;
+}
+
+static void init_type(unsigned mode, enum object_type *type)
+{
+	if (S_ISGITLINK(mode))
+		*type = OBJ_COMMIT;
+	else if (S_ISDIR(mode))
+		*type = OBJ_TREE;
+}
+
+static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
+			 const char *pathname, unsigned mode, void *context)
+{
+	size_t baselen;
+	int recursive = 0;
+	struct strbuf line = STRBUF_INIT;
+	struct show_tree_data data = {
+		.mode = mode,
+		.type = OBJ_BLOB,
+		.oid = oid,
+		.pathname = pathname,
+		.base = base,
+	};
+
+	init_type(mode, &data.type);
+	init_recursive(base, pathname, &recursive);
+
+	if (data.type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
+		return recursive;
+	if (data.type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
+		return !READ_TREE_RECURSIVE;
+
+	baselen = base->len;
+	strbuf_expand(&line, format, expand_show_tree, &data);
+	strbuf_addch(&line, line_termination);
+	fwrite(line.buf, line.len, 1, stdout);
+	strbuf_release(&line);
+	strbuf_setlen(base, baselen);
+	return recursive;
+}
+
 static int show_default(struct show_tree_data *data)
 {
 	size_t baselen = data->base->len;
@@ -138,21 +256,6 @@ static int show_default(struct show_tree_data *data)
 	return 1;
 }
 
-static void init_type(unsigned mode, enum object_type *type)
-{
-	if (S_ISGITLINK(mode))
-		*type = OBJ_COMMIT;
-	else if (S_ISDIR(mode))
-		*type = OBJ_TREE;
-}
-
-static void init_recursive(struct strbuf *base, const char *pathname,
-				int *recursive)
-{
-	if (show_recursive(base->buf, base->len, pathname))
-		*recursive = READ_TREE_RECURSIVE;
-}
-
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
@@ -200,6 +303,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree = 0;
+	read_tree_fn_t fn = show_tree;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -222,6 +326,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "full-tree", &full_tree,
 			 N_("list entire tree; not just current directory "
 			    "(implies --full-name)")),
+		OPT_STRING_F(0, "format", &format, N_("format"),
+			     N_("format to use for the output"),
+			     PARSE_OPT_NONEG),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
@@ -242,6 +349,10 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |= LS_SHOW_TREES;
 
+	if (format && cmdmode)
+		usage_msg_opt(
+			_("--format can't be combined with other format-altering options"),
+			ls_tree_usage, ls_tree_options);
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
 	if (get_oid(argv[0], &oid))
@@ -265,6 +376,19 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
-	return !!read_tree(the_repository, tree,
-			   &pathspec, show_tree, NULL);
+
+	/*
+	 * The generic show_tree_fmt() is slower than show_tree(), so
+	 * take the fast path if possible.
+	 */
+	if (format &&
+	    (!strcmp(format, default_format) ||
+	     !strcmp(format, long_format) ||
+	     !strcmp(format, name_only_format) ||
+	     !strcmp(format, object_only_format)))
+		fn = show_tree;
+	else if (format)
+		fn = show_tree_fmt;
+
+	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
 }
diff --git a/t/t3105-ls-tree-format.sh b/t/t3105-ls-tree-format.sh
new file mode 100755
index 0000000000..92b4d240e8
--- /dev/null
+++ b/t/t3105-ls-tree-format.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='ls-tree --format'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'ls-tree --format usage' '
+	test_expect_code 129 git ls-tree --format=fmt -l &&
+	test_expect_code 129 git ls-tree --format=fmt --name-only &&
+	test_expect_code 129 git ls-tree --format=fmt --name-status &&
+	test_expect_code 129 git ls-tree --format=fmt --object-only
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
+	shift 2 &&
+	git ls-tree $opts -r HEAD >expect.raw &&
+	sed "s/^/> /" >expect <expect.raw &&
+	git ls-tree --format="> $format" -r HEAD >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'ls-tree --format=<default-like>' '
+	test_ls_tree_format \
+		"%(mode) %(type) %(object)%x09%(file)" \
+		""
+'
+
+test_expect_success 'ls-tree --format=<long-like>' '
+	test_ls_tree_format \
+		"%(mode) %(type) %(object) %(size:padded)%x09%(file)" \
+		"--long"
+'
+
+test_expect_success 'ls-tree --format=<name-only-like>' '
+	test_ls_tree_format \
+		"%(file)" \
+		"--name-only"
+'
+
+test_expect_success 'ls-tree --format=<object-only-like>' '
+	test_ls_tree_format \
+		"%(object)" \
+		"--object-only"
+'
+
+test_done
-- 
2.33.0.rc1.1794.g2ae0a9cb82

