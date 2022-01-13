Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96947C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiAMDmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiAMDmp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:42:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9CC06118C
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:42 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id hv15so8854802pjb.5
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RK2c8uYaNoTYvZDHcz4Uhf5/ur9geWCxA6BtH6iBEkA=;
        b=CoAtzA5k2QBEaRx/Lp5nia/owIlIZaAi1Mqmumq65IQGWFrOtoJBdORR6xwleNUpbj
         xpdIg5akQPItLagPQMuZ4t1usDemthouj/NB0Mtxk+97cp75xlKrTX7L/O3rCK7ihDKP
         V0vmy/Vc3mKIqeHxL3P1VvChW03AjcVVua78tmO2J1Zpczc2RvwJoSlkI9S7Ig83W3Kl
         I5wtNaEPYb26hEQlt5S8MRdt6h5xMy/1Lo4gFziErPGDTBd1FkVT2EYkzUpUNU5YbxJj
         vbLFzdkrZM+lEMFz9JQFHIRO8odnmZSqbhenQm/aZfiarj1klbMfhEYDOmuBc2rK8DzC
         yvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RK2c8uYaNoTYvZDHcz4Uhf5/ur9geWCxA6BtH6iBEkA=;
        b=5P8cSiRqyU3J4LCJFneilzMWBG3ArYSzLNWangCxny4iBDJY93O3z5n1kBLhSpDRM5
         q8VlWA/ou0fg2qRbz5jwJF5FeOgdiDC8kmt+lTnoamptMwItqauh9ixe7creIRcTXfzE
         ohnmv2CeIEZh+V1vF4hguDG7Lq1oFNjj00th/K8kH9dygaAORenrb4tGNFD9PdTSVaYI
         q+zk0BHpKGW5EwTUoVZ30BF/Hztmsprkxc2XNKa6Sbu3/Ff6j7DNNUGc4NzxjAsjZbmH
         lmxG3bh7OHy8RTo2Y8cc0X4FcP5Mn+1UBqmxJFYUXih3pNXKz7/AUZgyTv0ot5cK1WCv
         w2fA==
X-Gm-Message-State: AOAM533Q0u/+GgP6d4imFkqEz1jGMewnKaPEzbR4f4YqXLo5hKQATpF0
        sAeU2jmee7JQ0z4P0MNhjWw=
X-Google-Smtp-Source: ABdhPJzgKig8nr+Elmc/69LaQY+7aomcQPwgpnGbkYmWu80bCg+b9I2w4fXRYd8QOE3v3g+UTGWilw==
X-Received: by 2002:a17:902:ced2:b0:14a:699e:3ab3 with SMTP id d18-20020a170902ced200b0014a699e3ab3mr2611412plg.0.1642045362360;
        Wed, 12 Jan 2022 19:42:42 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.48])
        by smtp.gmail.com with ESMTPSA id c20sm879436pgk.75.2022.01.12.19.42.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 19:42:41 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com
Subject: [PATCH v10 9/9] ls-tree.c: introduce "--format" option
Date:   Thu, 13 Jan 2022 11:42:12 +0800
Message-Id: <db058bf670c5668fc5b95baf83667cc282cb739b.1641978175.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82.dirty
In-Reply-To: <cover.1641978175.git.dyroneteng@gmail.com>
References: <cover.1641978175.git.dyroneteng@gmail.com>
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
 Documentation/git-ls-tree.txt |  51 +++++++++++++-
 builtin/ls-tree.c             | 129 +++++++++++++++++++++++++++++++++-
 t/t3105-ls-tree-format.sh     |  55 +++++++++++++++
 3 files changed, 230 insertions(+), 5 deletions(-)
 create mode 100755 t/t3105-ls-tree-format.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 729370f235..ebdde6eae3 100644
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
@@ -87,6 +97,9 @@ OPTIONS
 
 Output Format
 -------------
+
+Default format:
+
         <mode> SP <type> SP <object> TAB <file>
 
 This output format is compatible with what `--index-info --stdin` of
@@ -105,6 +118,38 @@ quoted as explained for the configuration variable `core.quotePath`
 (see linkgit:git-config[1]).  Using `-z` the filename is output
 verbatim and the line is terminated by a NUL byte.
 
+Customized format:
+
+It is possible to print in a custom format by using the `--format` option,
+which is able to interpolate different fields using a `%(fieldname)` notation.
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
index 56cc166adb..e048a68ee0 100644
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
@@ -116,6 +188,38 @@ static enum object_type get_type(unsigned int mode)
 	        : OBJ_BLOB);
 }
 
+static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
+			 const char *pathname, unsigned mode, void *context)
+{
+	size_t baselen;
+	int recurse = 0;
+	struct strbuf line = STRBUF_INIT;
+	enum object_type type = get_type(mode);
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
+	strbuf_expand(&line, format, expand_show_tree, &data);
+	strbuf_addch(&line, line_termination);
+	fwrite(line.buf, line.len, 1, stdout);
+	strbuf_release(&line);
+	strbuf_setlen(base, baselen);
+	return recurse;
+}
+
 static int show_default(struct show_tree_data *data)
 {
 	size_t baselen = data->base->len;
@@ -195,6 +299,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree = 0;
+	read_tree_fn_t fn = show_tree;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -217,6 +322,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "full-tree", &full_tree,
 			 N_("list entire tree; not just current directory "
 			    "(implies --full-name)")),
+		OPT_STRING_F(0, "format", &format, N_("format"),
+			     N_("format to use for the output"),
+			     PARSE_OPT_NONEG),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
@@ -237,6 +345,10 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |= LS_SHOW_TREES;
 
+	if (format && cmdmode)
+		usage_msg_opt(
+			_("--format can't be combined with other format-altering options"),
+			ls_tree_usage, ls_tree_options);
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
 	if (get_oid(argv[0], &oid))
@@ -260,6 +372,19 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
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
index 0000000000..ea0f51d866
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
+	test_expect_code 129 git ls-tree --format=fmt -l HEAD &&
+	test_expect_code 129 git ls-tree --format=fmt --name-only HEAD &&
+	test_expect_code 129 git ls-tree --format=fmt --name-status HEAD &&
+	test_expect_code 129 git ls-tree --format=fmt --object-only HEAD
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
2.34.1.390.g2ae0a9cb82.dirty

