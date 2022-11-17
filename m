Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52199C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 11:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiKQLbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 06:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbiKQLa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 06:30:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0504B98E
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:46 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r18so1672827pgr.12
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CqloFlxJgXjbKhG0by4EOHXWGlnl7aJpTlCORFLAF8=;
        b=QtUu9ZUkfrorgxJUqww+GV/O2OO7403L0Afp1ECDVeAgMMoFcvr9Es355whG0+T5tF
         kjkY5Htw1mqeGqFAf0Hs8rQFHpImpWPYOiLuzvL6wPKpBbVPmJ+jK4KKrclWkXkgBJvd
         7mJ2LWhg4d/4dopoyy9BB7J3J81dwUl6eeCdMQKv8oTfT0P85y6Fj/qcWJTRKfNrr3Qx
         KOZ3aA1YI7KaPxCetR61wrdy4HDg61WvyHw5qrnSZeFjmnRN2biPw+EwnEnpmelDo69/
         KWxdfcRP68+JTN8dl4Q8gRoldL+RRfSLCL4KMtDEMmJg6Ir50RaSwP0LP9AFpvdAmnmN
         wwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CqloFlxJgXjbKhG0by4EOHXWGlnl7aJpTlCORFLAF8=;
        b=ZvmXq9v5K4/sIlpLaoeqpjFrB1XPX8hddi6CkR6DZE/4rWNojRtpqZMM3Rm2yk9k5Z
         vuPqDoKoC6l5zCJx5UCHJLE4KjYofWwzU2ruyYTRtYnYV5YDxJ+9FnanTs/ettQ3NAiS
         D26SHedHV2yMDT92PNE1m+8fo78bPjWII1rVnQOsL5IaZ1prVjDy9HqqIDc+J8prssX2
         FajCat4FpPOsMFzm84DNWf2INwTss6HTvwpzcOF25Q/6Iv1gUAWuhRDWxiw3pTeYpZjc
         uV9/LdIYAR/p3/zTGnChIZdT5yS3aA5tAuJtIeNUD3Q/V+zYvmtrn5YPkbFnCw9jc5iR
         Dzmw==
X-Gm-Message-State: ANoB5pni6zOKHtz35BSi1o/yBs3uCtuYxQI53MS6KypRqmzR7kRKiS5H
        iJ6rKJx7cTcHKTrhyfnA1nTUQBFZWOUT6A==
X-Google-Smtp-Source: AA0mqf52s/1mHHEJ6+3Q/p9yzryi3kfMgj/YGq/uclZSeQUp8cvkD7V8OTNKZKA98FADzac8/lkcWw==
X-Received: by 2002:a63:5850:0:b0:46e:f67c:c0a7 with SMTP id i16-20020a635850000000b0046ef67cc0a7mr1599879pgm.464.1668684646017;
        Thu, 17 Nov 2022 03:30:46 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b00186c5e8b1d0sm1056117pln.149.2022.11.17.03.30.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:30:45 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 6/6] ls-tree: introduce '--pattern' option
Date:   Thu, 17 Nov 2022 19:30:23 +0800
Message-Id: <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.426.g770fc8806cb.dirty
In-Reply-To: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

The "--pattern" option uses regular expressions to match each
entry, then filter the output of "ls-tree" .

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt |  7 ++-
 builtin/ls-tree.c             | 82 +++++++++++++++++++++++------------
 t/t3106-ls-tree-pattern.sh    | 70 ++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 28 deletions(-)
 create mode 100755 t/t3106-ls-tree-pattern.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 0240adb8eec..39346409f2f 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>]
+	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>] [--pattern=<pattern>]
 	    <tree-ish> [<path>...]
 
 DESCRIPTION
@@ -93,6 +93,11 @@ OPTIONS
 	format-altering options, including `--long`, `--name-only`
 	and `--object-only`.
 
+--pattern=<pattern>::
+    The <pattern> is a string of regular expression format used to
+    match each entry. Unmatched entries will be filtered and not
+    dump to the output.
+
 [<path>...]::
 	When paths are given, show them (note that this isn't really raw
 	pathnames, but rather a list of patterns to match).  Otherwise
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 03dd3fbcb26..576fc9ad16f 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -13,6 +13,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "pathspec.h"
+#include <stdio.h>
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
@@ -25,6 +26,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 static const char *format;
 static const char *pattern;
+static regex_t *regex;
 struct show_tree_data {
 	unsigned mode;
 	enum object_type type;
@@ -47,29 +49,29 @@ static enum ls_tree_cmdmode {
 	MODE_OBJECT_ONLY,
 } cmdmode;
 
-__attribute__((unused))
 static int match_pattern(const char *line)
 {
 	int ret = 0;
-	regex_t r;
 	regmatch_t m[1];
 	char errbuf[64];
 
-	ret = regcomp(&r, pattern, 0);
-	if (ret) {
-		regerror(ret, &r, errbuf, sizeof(errbuf));
-		die("failed regcomp() for pattern '%s' (%s)", pattern, errbuf);
+	if (!regex) {
+		regex = xmalloc(sizeof(*regex));
+		ret = regcomp(regex, pattern, 0);
+		if (ret) {
+			regerror(ret, regex, errbuf, sizeof(errbuf));
+			die("failed regcomp() for pattern '%s' (%s)", pattern, errbuf);
+		}
 	}
-	ret = regexec(&r, line, 1, m, 0);
+
+	ret = regexec(regex, line, 1, m, 0);
 	if (ret) {
 		if (ret == REG_NOMATCH)
-			goto cleanup;
-		regerror(ret, &r, errbuf, sizeof(errbuf));
+			return ret;
+		regerror(ret, regex, errbuf, sizeof(errbuf));
 		die("failed regexec() for subject '%s' (%s)", line, errbuf);
 	}
 
-cleanup:
-	regfree(&r);
 	return ret;
 }
 
@@ -194,8 +196,12 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 
 	baselen = base->len;
 	strbuf_expand(&sb, format, expand_show_tree, &data);
-	strbuf_addch(&sb, line_termination);
-	fwrite(sb.buf, sb.len, 1, stdout);
+
+	if (!pattern || !match_pattern(sb.buf)) {
+		strbuf_addch(&sb, line_termination);
+		fwrite(sb.buf, sb.len, 1, stdout);
+	}
+
 	strbuf_release(&sb);
 	strbuf_setlen(base, baselen);
 	return recurse;
@@ -232,19 +238,33 @@ static int show_tree_common(struct show_tree_data *data, int *recurse,
 static void show_tree_common_default_long(struct show_tree_data *data)
 {
 	int base_len = data->base->len;
+	struct strbuf sb = STRBUF_INIT;
+	int sb_len = 0;
 
 	if (data->size_text)
-		printf("%06o %s %s %7s\t", data->mode, type_name(data->type),
-		       find_unique_abbrev(data->oid, abbrev), data->size_text);
+		strbuf_addf(&sb, "%06o %s %s %7s\t", data->mode,
+			    type_name(data->type),
+			    find_unique_abbrev(data->oid, abbrev),
+			    data->size_text);
 	else
-		printf("%06o %s %s\t", data->mode, type_name(data->type),
-		       find_unique_abbrev(data->oid, abbrev));
+		strbuf_addf(&sb, "%06o %s %s\t", data->mode,
+			    type_name(data->type),
+			    find_unique_abbrev(data->oid, abbrev));
 
 	strbuf_addstr(data->base, data->pathname);
-	write_name_quoted_relative(data->base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
-				   line_termination);
+	sb_len = sb.len;
+	strbuf_addbuf(&sb, data->base);
+
+	if (!pattern || !match_pattern(sb.buf)) {
+		strbuf_setlen(&sb, sb_len);
+		printf("%s", sb.buf);
+		write_name_quoted_relative(data->base->buf,
+					   chomp_prefix ? ls_tree_prefix : NULL,
+					   stdout, line_termination);
+	}
 	strbuf_setlen(data->base, base_len);
+
+	strbuf_release(&sb);
 }
 
 static int show_tree_default(const struct object_id *oid, struct strbuf *base,
@@ -306,9 +326,11 @@ static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 		return early;
 
 	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL,
-				   stdout, line_termination);
+	if (!pattern || !match_pattern(base->buf)) {
+		write_name_quoted_relative(base->buf,
+					   chomp_prefix ? ls_tree_prefix : NULL,
+					   stdout, line_termination);
+	}
 	strbuf_setlen(base, baselen);
 	return recurse;
 }
@@ -320,12 +342,14 @@ static int show_tree_object(const struct object_id *oid, struct strbuf *base,
 	int early;
 	int recurse;
 	struct show_tree_data data = { 0 };
+	const char *oid_text = find_unique_abbrev(oid, abbrev);
 
 	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
 	if (early >= 0)
 		return early;
 
-	printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
+	if (!pattern || !match_pattern(oid_text))
+		printf("%s%c", oid_text, line_termination);
 	return recurse;
 }
 
@@ -391,8 +415,10 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			 N_("list entire tree; not just current directory "
 			    "(implies --full-name)")),
 		OPT_STRING_F(0, "format", &format, N_("format"),
-					 N_("format to use for the output"),
-					 PARSE_OPT_NONEG),
+			     N_("format to use for the output"),
+			     PARSE_OPT_NONEG),
+		OPT_STRING(0, "pattern", &pattern, "pattern",
+			   "pattern to use to match the output"),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
@@ -430,10 +456,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		usage_with_options(ls_tree_usage, ls_tree_options);
 	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
+	if (pattern && !strlen(pattern))
+		die("Not a valid pattern, the value is empty");
 
 	/*
 	 * show_recursive() rolls its own matching code and is
-	 * generally ignorant of 'struct pathspec'. The magic mask
+	 * generally ignorant f 'struct pathspec'. The magic mask
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
diff --git a/t/t3106-ls-tree-pattern.sh b/t/t3106-ls-tree-pattern.sh
new file mode 100755
index 00000000000..e4a81c8c47e
--- /dev/null
+++ b/t/t3106-ls-tree-pattern.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='ls-tree pattern'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-t3100.sh
+
+test_expect_success 'setup' '
+	setup_basic_ls_tree_data
+'
+
+test_expect_success 'ls-tree pattern usage' '
+	test_expect_code 129 git ls-tree --pattern HEAD &&
+	test_expect_code 128 git ls-tree --pattern "" HEAD >err 2>&1 &&
+	grep "Not a valid pattern, the value is empty" err
+'
+
+test_expect_success 'combine with "--object-only"' '
+	cat > expect <<-EOF &&
+		6da7993
+	EOF
+
+	git ls-tree --object-only --abbrev=7 --pattern "6da7993" HEAD > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'combine with "--name-only"' '
+	cat > expect <<-EOF &&
+		.gitmodules
+		top-file.t
+	EOF
+
+	git ls-tree --name-only --pattern "\." HEAD > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'combine with "--long"' '
+	cat > expect <<-EOF &&
+		100644 blob 6da7993      61	.gitmodules
+		100644 blob 02dad95       9	top-file.t
+	EOF
+	git ls-tree --long --abbrev=7 --pattern "blob" HEAD > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'combine with "--format"' '
+	# Change the output format by replacing space separators with asterisks.
+	format="%(objectmode)*%(objecttype)*%(objectname)%x09%(path)" &&
+	pattern="100644\*blob" &&
+
+	cat > expect <<-EOF &&
+		100644*blob*6da7993	.gitmodules
+		100644*blob*02dad95	top-file.t
+	EOF
+
+	git ls-tree --abbrev=7 --format "$format" --pattern "$pattern" HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default output format (only with "--pattern" option)' '
+	cat > expect <<-EOF &&
+		100644 blob 6da7993ca1a3435f63c598464f77bdc6dae15aa5	.gitmodules
+		100644 blob 02dad956d9274a70f7fafe45a5ffa2e123acd9a8	top-file.t
+	EOF
+	git ls-tree --pattern "blob" HEAD > actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.38.1.426.g770fc8806cb.dirty

