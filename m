Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537AAC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbiCWJPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242945AbiCWJP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F0875637
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u22so1029793pfg.6
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aHDdzOh48ZBYUsTQBACBR/bI7aX+2OW+rhzYq8lmdoA=;
        b=fCLXV0tjqsKfXAhEfHcLHmMHxQelSWjW7SSjulgmljxg5aNhhIdUSNSFn5tLyLtnXl
         risEhfl7qdsZueS3DN+unGHhjnNMERPIHtF5rfCN6Zx3rbK+zgsO0JoqMQeTtNB3AwSm
         /Fe8f54HblYzodpXcT+e/uDIvLPz22egQxvSAAuaxGpdLIpHfHTmef4oEKEA9gcaYfFa
         acJnEItcmdGE7XIFyqkJzY/2kd2xHf8qDIzfKmQ2C7UkT1mE0Gxsz0ianYeNOot3/j+E
         XenGEiXHrc16VVyakA5nabcy+65YSiyXPb0c2hIFMk2KH4PHTwsdWNgjYNKCDEf1/yf1
         21KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aHDdzOh48ZBYUsTQBACBR/bI7aX+2OW+rhzYq8lmdoA=;
        b=s3YqpZ30yl9CdFki34ItiPqCmOn1F9+FbP9IOL1S+axeQEQuqbeY9i8QYe5aDOYtM6
         nS7h8uoBjw6WmdtnXrokFx8O10dqcAi+aPCGlFjwsIaJfiOM8vVz0N+UebciReepvg3n
         qtec8YAmP8NvoB4dy0cAXwPiBTsvaMLjpaLtsupfAWPEtHF+PRnItleYP6L82tB5bY6u
         Fom8XeeHLxqvsY1L60eX68O5Wi39+tP5nRNoL8uQkjE5+eASRkafzxdMQ+9ZH5sXYTnH
         lVoAYzeS+8Q+l5keo7NJO5jNu/nuriIalXO+KUWW2RQzG6Cif8GN9JALb9tyNFQQNSaA
         6zKQ==
X-Gm-Message-State: AOAM531IICrwcUK3TSOzM2mSbanMCgxyJ6FjRgvtdmh7scoNW5e3ILQW
        ZUQ2HyWhoc5jMI3MOfOG9/M=
X-Google-Smtp-Source: ABdhPJyJ2L3+7Z4AyLpYzUSJffMMt7W/TsvAe0Ifiy2Jw4dgrXaAOU4iuHIMqvEy+roggeUvgPGs8A==
X-Received: by 2002:a63:381:0:b0:385:f8e6:bea1 with SMTP id 123-20020a630381000000b00385f8e6bea1mr4439800pgd.120.1648026833987;
        Wed, 23 Mar 2022 02:13:53 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:53 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 12/15] ls-tree: introduce "--format" option
Date:   Wed, 23 Mar 2022 17:13:12 +0800
Message-Id: <8b21b204a5c4be137f47ecb3a07373d36d171019.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
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

In [1] there was a "GIT_TEST_LS_TREE_FORMAT_BACKEND" variable to
ensure that we had test coverage for passing tests that would
otherwise use show_tree() through show_tree_fmt(), and thus that the
formatting mechanism could handle all the same cases as the
non-formatting options.

Somewhere in subsequent re-rolls of that we seem to have drifted away
from what the goal of these tests should be. We're trying to ensure
correctness of show_tree_fmt(). We can't tell if we "hit [the]
fast-path" here, and instead of having an explicit test for that, we
can just add it to something our "test_ls_tree_format" tests for.

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
	[2] https://lore.kernel.org/git/cb717d08be87e3239117c6c667cb32caabaad33d.1646390152.git.dyroneteng@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt |  59 ++++++++++++-
 builtin/ls-tree.c             | 153 +++++++++++++++++++++++++++++++++-
 t/t3104-ls-tree-format.sh     |  67 +++++++++++++++
 3 files changed, 272 insertions(+), 7 deletions(-)
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
index edc8bf53a6..8a1bf2fa4d 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -23,6 +23,8 @@ static int ls_options;
 static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
+static const char *format;
+
 struct show_tree_data {
 	unsigned mode;
 	enum object_type type;
@@ -37,10 +39,77 @@ static const  char * const ls_tree_usage[] = {
 };
 
 static enum ls_tree_cmdmode {
-	MODE_LONG = 1,
+	MODE_DEFAULT = 0,
+	MODE_LONG,
 	MODE_NAME_ONLY,
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
 static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
@@ -71,6 +140,38 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
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
@@ -145,11 +246,33 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	return recurse;
 }
 
+struct ls_tree_cmdmode_to_fmt {
+	enum ls_tree_cmdmode mode;
+	const char *const fmt;
+};
+
+static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
+	{
+		.mode = MODE_DEFAULT,
+		.fmt = "%(objectmode) %(objecttype) %(objectname)%x09%(path)",
+	},
+	{
+		.mode = MODE_LONG,
+		.fmt = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)",
+	},
+	{
+		.mode = MODE_NAME_ONLY, /* And MODE_NAME_STATUS */
+		.fmt = "%(path)",
+	},
+	{ 0 },
+};
+
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree = 0;
+	read_tree_fn_t fn = show_tree;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -170,6 +293,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "full-tree", &full_tree,
 			 N_("list entire tree; not just current directory "
 			    "(implies --full-name)")),
+		OPT_STRING_F(0, "format", &format, N_("format"),
+					 N_("format to use for the output"),
+					 PARSE_OPT_NONEG),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
@@ -190,6 +316,10 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |= LS_SHOW_TREES;
 
+	if (format && cmdmode)
+		usage_msg_opt(
+			_("--format can't be combined with other format-altering options"),
+			ls_tree_usage, ls_tree_options);
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
 	if (get_oid(argv[0], &oid))
@@ -211,6 +341,23 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
-	return !!read_tree(the_repository, tree,
-			   &pathspec, show_tree, NULL);
+	/*
+	 * The generic show_tree_fmt() is slower than show_tree(), so
+	 * take the fast path if possible.
+	 */
+	if (format) {
+		struct ls_tree_cmdmode_to_fmt *m2f;
+
+		fn = show_tree_fmt;
+		for (m2f = ls_tree_cmdmode_format; m2f->fmt; m2f++) {
+			if (strcmp(format, m2f->fmt))
+				continue;
+
+			cmdmode = m2f->mode;
+			fn = show_tree;
+			break;
+		}
+	}
+
+	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
 }
diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
new file mode 100755
index 0000000000..7f1eb699d3
--- /dev/null
+++ b/t/t3104-ls-tree-format.sh
@@ -0,0 +1,67 @@
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
+
+	test_expect_success "ls-tree '--format=<$format>' is like options '$opts $fmtopts'" '
+		git ls-tree $opts -r HEAD >expect &&
+		git ls-tree --format="$format" -r $fmtopts HEAD >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "ls-tree '--format=<$format>' on optimized v.s. non-optimized path" '
+		git ls-tree --format="$format" -r $fmtopts HEAD >expect &&
+		git ls-tree --format="> $format" -r $fmtopts HEAD >actual.raw &&
+		sed "s/^> //" >actual <actual.raw &&
+		test_cmp expect actual
+	'
+}
+
+test_ls_tree_format \
+	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
+	""
+
+test_ls_tree_format \
+	"%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)" \
+	"--long"
+
+test_ls_tree_format \
+	"%(path)" \
+	"--name-only"
+
+test_ls_tree_format \
+	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
+	"-t" \
+	"-t"
+
+test_ls_tree_format \
+	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
+	"--full-name" \
+	"--full-name"
+
+test_ls_tree_format \
+	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
+	"--full-tree" \
+	"--full-tree"
+
+test_done
-- 
2.34.1.404.g92931a4a2c.dirty

