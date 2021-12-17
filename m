Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A42C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhLQNag (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhLQNaf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:30:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1889C061401
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j18so4110830wrd.2
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViM4QhPLr2b1n4LwhUSus/b6K5vp7qR689p+iJWA1ZQ=;
        b=D7H6LDomuMW9ybbjHtNBln5x4Tl+AV661ErnXGYG8+xtcQ+403Vl7ilnLYADHj9idV
         6v6Rs9kYgYbLIpH7c+6HiluMvXCuwbZaorAg580EA0LOMthWVBayYAEd607EFvNCv7Et
         vaWUTrBlnA90MUHPrX3sfezJ9arbHyI0GgRtDq+1utByHzaM+/pRjqauZL75p+8dM1JN
         nhsnO4AXSSN3Z9B63efFhtzs4ZHc++SXQPlOUct8QOoZ+q+7Yr279dXmP94QCvEajDqq
         kNelkpONCLbKuost7zLPW5Zumjr1zaC5OiUSbGnl0p4dWtQAH/Bzrgx4BaSFZvG57mxY
         +LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViM4QhPLr2b1n4LwhUSus/b6K5vp7qR689p+iJWA1ZQ=;
        b=pnDGwQIiv3IeqV2wspWU/ivY0mM2qzCrd/qd7daOnb59wISUDpN26LaxkJBRJbcm4k
         6+qmOZlogjyq05RYGk39g4oYJSHZ8WFHWkIr6d7rdOTrOYgX9C+c+9N/MWcHA/5BBjYb
         /OmLAFPjZIO86Pu6g6gdlvhWJobWX0jyGOv9XObjR5QJMyvpYu7kGMOu3q2AoyE+FZrs
         TLJHKaiyJTCfGWY+C/T1QGgDSnejP2TvQ3bjZiAzFYqgKMCikwLwMAdXfQj3jq67P6sj
         GicR7XJN/Y5uNfkoYfmSy+++SKIJOt4c4zWy03a8iSOf1usL83hbuVgBO28DKPDwiIa5
         MOlA==
X-Gm-Message-State: AOAM533Gnr40Uxk6AXCW0ujP896eK34iTwR7kMdxmf+Vi78wO1c+3nlZ
        aH+TvUi5ymxM4uWxtyPGJkySm7Zs10Omgg==
X-Google-Smtp-Source: ABdhPJzY+CUAn7tpJR7AOTwkhYFIbcFKxYtJrpPy2xMxdo1Yx4Ed+eVa9BkGJQ79HxW0IpapRW8hbw==
X-Received: by 2002:adf:f112:: with SMTP id r18mr2704015wro.655.1639747831825;
        Fri, 17 Dec 2021 05:30:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm11953993wmb.38.2021.12.17.05.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:30:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 6/7] ls-tree: add a --format=<fmt> option
Date:   Fri, 17 Dec 2021 14:30:22 +0100
Message-Id: <RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
References: <cover.1639721750.git.dyroneteng@gmail.com> <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
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
existing show_tree() unchanged, and only run show_tree_format() in if
a --format different than the hardcoded built-in ones corresponding to
the existing modes is provided.

"Slower" here can bee seen via the the following "hyperfine"
command. This uses GIT_TEST_LS_TREE_FORMAT_BACKEND=<bool> to force the
use of the new backend:

    $ hyperfine -L env false,true -L f "-r,-r -l,-r --name-only,-r --format='%(objectname)'" 'GIT_TEST_LS_TREE_FORMAT_BACKEND={env} ./git -C ~/g/linux ls-tree {f} HEAD' -r 10
    Benchmark 1: GIT_TEST_LS_TREE_FORMAT_BACKEND=false ./git -C ~/g/linux ls-tree -r HEAD
      Time (mean ± σ):      86.1 ms ±   0.6 ms    [User: 65.2 ms, System: 20.9 ms]
      Range (min … max):    85.2 ms …  87.5 ms    10 runs

    Benchmark 2: GIT_TEST_LS_TREE_FORMAT_BACKEND=true ./git -C ~/g/linux ls-tree -r HEAD
      Time (mean ± σ):     122.5 ms ±   0.6 ms    [User: 101.3 ms, System: 21.1 ms]
      Range (min … max):   121.8 ms … 123.4 ms    10 runs

    Benchmark 3: GIT_TEST_LS_TREE_FORMAT_BACKEND=false ./git -C ~/g/linux ls-tree -r -l HEAD
      Time (mean ± σ):     277.7 ms ±   1.3 ms    [User: 234.6 ms, System: 43.0 ms]
      Range (min … max):   275.9 ms … 279.7 ms    10 runs

    Benchmark 4: GIT_TEST_LS_TREE_FORMAT_BACKEND=true ./git -C ~/g/linux ls-tree -r -l HEAD
      Time (mean ± σ):     332.8 ms ±   2.6 ms    [User: 282.0 ms, System: 50.7 ms]
      Range (min … max):   329.6 ms … 338.2 ms    10 runs

    Benchmark 5: GIT_TEST_LS_TREE_FORMAT_BACKEND=false ./git -C ~/g/linux ls-tree -r --name-only HEAD
      Time (mean ± σ):      71.8 ms ±   0.4 ms    [User: 54.1 ms, System: 17.6 ms]
      Range (min … max):    71.2 ms …  72.5 ms    10 runs

    Benchmark 6: GIT_TEST_LS_TREE_FORMAT_BACKEND=true ./git -C ~/g/linux ls-tree -r --name-only HEAD
      Time (mean ± σ):      86.6 ms ±   0.5 ms    [User: 65.7 ms, System: 20.7 ms]
      Range (min … max):    85.9 ms …  87.4 ms    10 runs

    Benchmark 7: GIT_TEST_LS_TREE_FORMAT_BACKEND=false ./git -C ~/g/linux ls-tree -r --format='%(objectname)' HEAD
      Time (mean ± σ):      85.8 ms ±   0.6 ms    [User: 66.2 ms, System: 19.5 ms]
      Range (min … max):    85.0 ms …  86.9 ms    10 runs

    Benchmark 8: GIT_TEST_LS_TREE_FORMAT_BACKEND=true ./git -C ~/g/linux ls-tree -r --format='%(objectname)' HEAD
      Time (mean ± σ):      85.3 ms ±   0.2 ms    [User: 66.6 ms, System: 18.7 ms]
      Range (min … max):    85.0 ms …  85.7 ms    10 runs

    Summary
      'GIT_TEST_LS_TREE_FORMAT_BACKEND=false ./git -C ~/g/linux ls-tree -r --name-only HEAD' ran
        1.19 ± 0.01 times faster than 'GIT_TEST_LS_TREE_FORMAT_BACKEND=true ./git -C ~/g/linux ls-tree -r --format='%(objectname)' HEAD'
        1.19 ± 0.01 times faster than 'GIT_TEST_LS_TREE_FORMAT_BACKEND=false ./git -C ~/g/linux ls-tree -r --format='%(objectname)' HEAD'
        1.20 ± 0.01 times faster than 'GIT_TEST_LS_TREE_FORMAT_BACKEND=false ./git -C ~/g/linux ls-tree -r HEAD'
        1.21 ± 0.01 times faster than 'GIT_TEST_LS_TREE_FORMAT_BACKEND=true ./git -C ~/g/linux ls-tree -r --name-only HEAD'
        1.71 ± 0.01 times faster than 'GIT_TEST_LS_TREE_FORMAT_BACKEND=true ./git -C ~/g/linux ls-tree -r HEAD'
        3.87 ± 0.03 times faster than 'GIT_TEST_LS_TREE_FORMAT_BACKEND=false ./git -C ~/g/linux ls-tree -r -l HEAD'
        4.64 ± 0.05 times faster than 'GIT_TEST_LS_TREE_FORMAT_BACKEND=true ./git -C ~/g/linux ls-tree -r -l HEAD'

I.e. something like the "--long" output would be much slower with
this, mainly due to how we need to allocate various things to do with
quote.c instead of spewing the output directly to stdout.

But even a --format='%(objectname)' is fast with the new backend, so
this is viable as a replacement for adding new formats, and we'll pay
for this added complexity as a one-off, and not again every time a new
format needs to be added. See [1] for an example of what it would
otherwise take to add an --object-name flag.

1. https://lore.kernel.org/git/2e449d1c792ff81da5f22c8bf65ed33c393d62f8.1639721750.git.dyroneteng@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c         | 167 +++++++++++++++++++++++++++++++++++++-
 t/t3105-ls-tree-format.sh |  49 +++++++++++
 2 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100755 t/t3105-ls-tree-format.sh

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index df8312408da..efd85cab088 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -26,11 +26,34 @@ static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
 
+/*
+ * The format equivalents that show_tree() is prepared to handle.
+ */
+static const char *ls_tree_format_d = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
+static const char *ls_tree_format_l = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
+static const char *ls_tree_format_n = "%(path)";
+
 static const  char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
 };
 
+struct read_tree_ls_tree_data {
+	const char *format;
+	struct strbuf sb_scratch;
+	struct strbuf sb_tmp;
+};
+
+struct expand_ls_tree_data {
+	unsigned mode;
+	enum object_type type;
+	const struct object_id *oid;
+	const char *pathname;
+	const char *basebuf;
+	struct strbuf *sb_scratch;
+	struct strbuf *sb_tmp;
+};
+
 static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
@@ -61,6 +84,76 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
+static void expand_objectsize(struct strbuf *sb,
+			      const struct object_id *oid,
+			      const enum object_type type,
+			      unsigned int padded)
+{
+	if (type == OBJ_BLOB) {
+		unsigned long size;
+		if (oid_object_info(the_repository, oid, &size) < 0)
+			die(_("could not get object info about '%s'"), oid_to_hex(oid));
+		if (padded)
+			strbuf_addf(sb, "%7"PRIuMAX, (uintmax_t)size);
+		else
+			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)size);
+	} else if (padded) {
+		strbuf_addf(sb, "%7s", "-");
+	} else {
+		strbuf_addstr(sb, "-");
+	}
+}
+
+static size_t expand_show_tree(struct strbuf *sb,
+			       const char *start,
+			       void *context)
+{
+	struct expand_ls_tree_data *data = context;
+	const char *end;
+	const char *p;
+	size_t len;
+
+	len = strbuf_expand_literal_cb(sb, start, NULL);
+	if (len)
+		return len;
+
+	if (*start != '(')
+		die(_("bad format as of '%s'"), start);
+	end = strchr(start + 1, ')');
+	if (!end)
+		die(_("ls-tree format element '%s' does not end in ')'"),
+		    start);
+	len = end - start + 1;
+
+	if (skip_prefix(start, "(objectmode)", &p)) {
+		strbuf_addf(sb, "%06o", data->mode);
+	} else if (skip_prefix(start, "(objecttype)", &p)) {
+		strbuf_addstr(sb, type_name(data->type));
+	} else if (skip_prefix(start, "(objectsize:padded)", &p)) {
+		expand_objectsize(sb, data->oid, data->type, 1);
+	} else if (skip_prefix(start, "(objectsize)", &p)) {
+		expand_objectsize(sb, data->oid, data->type, 0);
+	} else if (skip_prefix(start, "(objectname)", &p)) {
+		strbuf_addstr(sb, find_unique_abbrev(data->oid, abbrev));
+	} else if (skip_prefix(start, "(path)", &p)) {
+		const char *name = data->basebuf;
+		const char *prefix = chomp_prefix ? ls_tree_prefix : NULL;
+
+		if (prefix)
+			name = relative_path(name, prefix, data->sb_scratch);
+		quote_c_style(name, data->sb_tmp, NULL, 0);
+		strbuf_add(sb, data->sb_tmp->buf, data->sb_tmp->len);
+
+		strbuf_reset(data->sb_tmp);
+		/* The relative_path() function resets "scratch" */
+	} else {
+		unsigned int errlen = (unsigned long)len;
+		die(_("bad ls-tree format specifiec %%%.*s"), errlen, start);
+	}
+
+	return len;
+}
+
 static int show_tree_init(enum object_type *type, struct strbuf *base,
 			  const char *pathname, unsigned mode, int *retval)
 {
@@ -79,6 +172,38 @@ static int show_tree_init(enum object_type *type, struct strbuf *base,
 	return 0;
 }
 
+static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
+			 const char *pathname, unsigned mode, void *context)
+{
+	struct read_tree_ls_tree_data *data = context;
+	struct expand_ls_tree_data my_data = {
+		.mode = mode,
+		.type = OBJ_BLOB,
+		.oid = oid,
+		.pathname = pathname,
+		.sb_scratch = &data->sb_scratch,
+		.sb_tmp = &data->sb_tmp,
+	};
+	struct strbuf sb = STRBUF_INIT;
+	int retval = 0;
+	size_t baselen;
+
+	if (show_tree_init(&my_data.type, base, pathname, mode, &retval))
+		return retval;
+
+	baselen = base->len;
+	strbuf_addstr(base, pathname);
+	strbuf_reset(&sb);
+	my_data.basebuf = base->buf;
+
+	strbuf_expand(&sb, data->format, expand_show_tree, &my_data);
+	strbuf_addch(&sb, line_termination);
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_setlen(base, baselen);
+
+	return retval;
+}
+
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
@@ -125,6 +250,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree = 0;
+	const char *implicit_format = NULL;
+	const char *format = NULL;
+	struct read_tree_ls_tree_data read_tree_cb_data = {
+		.sb_scratch = STRBUF_INIT,
+		.sb_tmp = STRBUF_INIT,
+	};
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -145,9 +276,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "full-tree", &full_tree,
 			 N_("list entire tree; not just current directory "
 			    "(implies --full-name)")),
+		OPT_STRING_F(0 , "format", &format, N_("format"),
+			     N_("format to use for the output"), PARSE_OPT_NONEG),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
+	read_tree_fn_t fn = show_tree;
 
 	git_config(git_default_config, NULL);
 	ls_tree_prefix = prefix;
@@ -164,6 +298,18 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |= LS_SHOW_TREES;
+	if (ls_options & LS_NAME_ONLY)
+		implicit_format = ls_tree_format_n;
+	if (ls_options & LS_SHOW_SIZE)
+		implicit_format = ls_tree_format_l;
+
+	if (format && implicit_format)
+		usage_msg_opt(_("providing --format cannot be combined with other format-altering options"),
+			      ls_tree_usage, ls_tree_options);
+	if (implicit_format)
+		format = implicit_format;
+	if (!format)
+		format = ls_tree_format_d;
 
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
@@ -186,6 +332,25 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
+
+	/*
+	 * The generic show_tree_fmt() is slower than show_tree(), so
+	 * take the fast path if possible.
+	 */
+	if (format && (!strcmp(format, ls_tree_format_d) ||
+		       !strcmp(format, ls_tree_format_l) ||
+		       !strcmp(format, ls_tree_format_n)))
+		fn = show_tree;
+	else if (format)
+		fn = show_tree_fmt;
+	/*
+	 * Allow forcing the show_tree_fmt(), to test that it can
+	 * handle the test suite.
+	 */
+	if (git_env_bool("GIT_TEST_LS_TREE_FORMAT_BACKEND", 0))
+		fn = show_tree_fmt;
+
+	read_tree_cb_data.format = format;
 	return !!read_tree(the_repository, tree,
-			   &pathspec, show_tree, NULL);
+			   &pathspec, fn, &read_tree_cb_data);
 }
diff --git a/t/t3105-ls-tree-format.sh b/t/t3105-ls-tree-format.sh
new file mode 100755
index 00000000000..79817260ce8
--- /dev/null
+++ b/t/t3105-ls-tree-format.sh
@@ -0,0 +1,49 @@
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
+	test_expect_code 129 git ls-tree --format=fmt --name-status
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
+
+'
+
+test_done
-- 
2.34.1.1119.g7a3fc8778ee

