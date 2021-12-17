Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC94C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 06:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhLQG51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 01:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLQG50 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 01:57:26 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94214C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 22:57:26 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v19so1074404plo.7
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 22:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tqYR6tKz7RP74dTw99y7DM/KRJwOyYHjR+8D91Yf6PY=;
        b=VK/hk4YDUdJiSopOp2uz08UB3WeYqkr75fTUN25pJEdqthzoLcKgtj+w0SI2+Zw7QS
         GKQPRGd32u50ade2poaj0CgPn7jJ7dUIP0G0wLa6LQtvibbU2Ka0stwhVt78ZiW6QFvH
         wclryZL6IGyRnu6EidaO6ZRmNGWRQevijKH2ED1aJ9DS1UPgvI3OcUHiABTSzfmMxrQv
         PTCrCZxc4gZOanBopsRiCu+O9E57TJsINeXyASVNnTCxkkzS4AQh+rgFXp+kqsfss4cW
         YXp1EKV80Iea9FGeIxwKVqz+y5FRh8aZhAohLqX97aqjmyiVo0h8FPDGgmHcV+Sx/zR8
         zOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqYR6tKz7RP74dTw99y7DM/KRJwOyYHjR+8D91Yf6PY=;
        b=k6O2Z7Img3l8JzjVNdYju8R1Pdf8vhLIah3Qhw9JHjqC8SPWTgx8k+ddityi5HeFHo
         i9/kZUU6/D2hjWyk7N8G1fb7f/wl5EAQ/2a1ful0wG9/BQ5kykbNzGSZ5hL/p+ZirrPS
         wTZ4QkvENRWz1X5AzNgFtYJpR7r32O0rBTLXwBPDp1v1K2cbmVh7tDml2T9helQxRt9j
         2hXMZnSmdQSeTkvRIbf77phtUcR5zBTvRZ+zvzU44vrENxVPpMO3XJ74mlB3ryRSlNtj
         3SPKfmG+nagUBUzB/HaSRIR/gcHi90sJqGjJQZb23RIVyd6+qwUDwafuZcwjUUWqgXUv
         A/Og==
X-Gm-Message-State: AOAM531Lu7a4M3Bm0Pk3wNEcjsw3JdxbRklChURcQAV4kbCwt/5n21O7
        mWYw+LWD7B5HXUxKXnF0GG8=
X-Google-Smtp-Source: ABdhPJzVeudZ7ZpZ4TA0cWxKs6NmiRBeqjcNa7ZMlbF0OmxCnnDrQA5wO6PqbmMNL3+E7W5e8q5nNQ==
X-Received: by 2002:a17:90a:b013:: with SMTP id x19mr2222199pjq.126.1639724245980;
        Thu, 16 Dec 2021 22:57:25 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id b16sm7198952pgi.36.2021.12.16.22.57.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 22:57:25 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 1/1] ls-tree.c: support `--object-only` option for "git-ls-tree"
Date:   Fri, 17 Dec 2021 14:57:09 +0800
Message-Id: <2e449d1c792ff81da5f22c8bf65ed33c393d62f8.1639721750.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g5f17c1a2c1.dirty
In-Reply-To: <cover.1639721750.git.dyroneteng@gmail.com>
References: <cover.1639721750.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We usually pipe the output from `git ls-trees` to tools like
`sed` or `cut` when we only want to extract some fields.

When we want only the pathname component, we can pass
`--name-only` option to omit such a pipeline, but there are no
options for extracting other fields.

Teach the "--object-only" option to the command to only show the
object name. This option cannot be used together with
"--name-only" or "--long" (mutually exclusive).

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt |   7 +-
 builtin/ls-tree.c             | 131 ++++++++++++++++++++++++----------
 quote.c                       |   8 +--
 quote.h                       |  19 +++++
 t/t3103-ls-tree-misc.sh       |   8 +++
 t/t3104-ls-tree-oid.sh        |  51 +++++++++++++
 6 files changed, 183 insertions(+), 41 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index db02d6d79a..729370f235 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
+	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]]
 	    <tree-ish> [<path>...]
 
 DESCRIPTION
@@ -59,6 +59,11 @@ OPTIONS
 --name-only::
 --name-status::
 	List only filenames (instead of the "long" output), one per line.
+	Cannot be combined with `--object-only`.
+
+--object-only::
+	List only names of the objects, one per line. Cannot be combined
+	with `--name-only` or `--name-status`.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c7..e76c6e43e8 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -16,21 +16,38 @@
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
-#define LS_TREE_ONLY 2
-#define LS_SHOW_TREES 4
-#define LS_NAME_ONLY 8
-#define LS_SHOW_SIZE 16
+#define LS_TREE_ONLY (1 << 1)
+#define LS_SHOW_TREES (1 << 2)
+#define LS_NAME_ONLY (1 << 3)
+#define LS_SHOW_SIZE (1 << 4)
+#define LS_OBJECT_ONLY (1 << 5)
 static int abbrev;
 static int ls_options;
 static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
+static unsigned int shown_bits;
+#define SHOW_FILE_NAME 1
+#define SHOW_SIZE (1 << 1)
+#define SHOW_OBJECT_NAME (1 << 2)
+#define SHOW_TYPE (1 << 3)
+#define SHOW_MODE (1 << 4)
+#define SHOW_DEFAULT 29 /* 11101 size is not shown to output by default */
 
 static const  char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
 };
 
+enum {
+	MODE_UNSPECIFIED = 0,
+	MODE_NAME_ONLY,
+	MODE_OBJECT_ONLY,
+	MODE_LONG,
+};
+
+static int cmdmode = MODE_UNSPECIFIED;
+
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
 	int i;
@@ -66,6 +83,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int retval = 0;
 	int baselen;
+	int interspace = 0;
 	const char *type = blob_type;
 
 	if (S_ISGITLINK(mode)) {
@@ -74,8 +92,8 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		 *
 		 * Something similar to this incomplete example:
 		 *
-		if (show_subprojects(base, baselen, pathname))
-			retval = READ_TREE_RECURSIVE;
+		 * if (show_subprojects(base, baselen, pathname))
+		 *	retval = READ_TREE_RECURSIVE;
 		 *
 		 */
 		type = commit_type;
@@ -90,35 +108,73 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
 
-	if (!(ls_options & LS_NAME_ONLY)) {
-		if (ls_options & LS_SHOW_SIZE) {
-			char size_text[24];
-			if (!strcmp(type, blob_type)) {
-				unsigned long size;
-				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
-					xsnprintf(size_text, sizeof(size_text),
-						  "BAD");
-				else
-					xsnprintf(size_text, sizeof(size_text),
-						  "%"PRIuMAX, (uintmax_t)size);
-			} else
-				xsnprintf(size_text, sizeof(size_text), "-");
-			printf("%06o %s %s %7s\t", mode, type,
-			       find_unique_abbrev(oid, abbrev),
-			       size_text);
+	if (shown_bits & SHOW_MODE) {
+		printf("%06o", mode);
+		interspace = 1;
+	}
+	if (shown_bits & SHOW_TYPE) {
+		printf("%s%s", interspace ? " " : "", type);
+		interspace = 1;
+	}
+	if (shown_bits & SHOW_OBJECT_NAME) {
+		printf("%s%s", interspace ? " " : "",
+		       find_unique_abbrev(oid, abbrev));
+		if (!(shown_bits ^ SHOW_OBJECT_NAME))
+			goto LINE_FINISH;
+		interspace = 1;
+	}
+	if (shown_bits & SHOW_SIZE) {
+		char size_text[24];
+		if (!strcmp(type, blob_type)) {
+			unsigned long size;
+			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
+				xsnprintf(size_text, sizeof(size_text), "BAD");
+			else
+				xsnprintf(size_text, sizeof(size_text),
+					  "%"PRIuMAX, (uintmax_t)size);
 		} else
-			printf("%06o %s %s\t", mode, type,
-			       find_unique_abbrev(oid, abbrev));
+			xsnprintf(size_text, sizeof(size_text), "-");
+		printf("%s%7s", interspace ? " " : "", size_text);
+		interspace = 1;
+	}
+	if (shown_bits & SHOW_FILE_NAME) {
+		if (interspace)
+			printf("\t");
+		baselen = base->len;
+		strbuf_addstr(base, pathname);
+		write_name_quoted_relative(base->buf,
+					   chomp_prefix ? ls_tree_prefix : NULL,
+					   stdout,
+					   line_termination
+					   ? CQ_NO_TERMINATOR_C_QUOTED
+					   : CQ_NO_TERMINATOR_AS_IS);
+		strbuf_setlen(base, baselen);
 	}
-	baselen = base->len;
-	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL,
-				   stdout, line_termination);
-	strbuf_setlen(base, baselen);
+
+LINE_FINISH:
+	putchar(line_termination);
 	return retval;
 }
 
+static int parse_shown_fields(void)
+{
+	if (cmdmode == MODE_NAME_ONLY) {
+		shown_bits = SHOW_FILE_NAME;
+		return 0;
+	}
+	if (cmdmode == MODE_OBJECT_ONLY) {
+		shown_bits = SHOW_OBJECT_NAME;
+		return 0;
+	}
+	if (!ls_options || (ls_options & LS_RECURSIVE)
+	    || (ls_options & LS_SHOW_TREES)
+	    || (ls_options & LS_TREE_ONLY))
+		shown_bits = SHOW_DEFAULT;
+	if (cmdmode == MODE_LONG)
+		shown_bits = SHOW_DEFAULT | SHOW_SIZE;
+	return 1;
+}
+
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	struct object_id oid;
@@ -133,12 +189,14 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_SHOW_TREES),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("terminate entries with NUL byte"), 0),
-		OPT_BIT('l', "long", &ls_options, N_("include object size"),
-			LS_SHOW_SIZE),
-		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
-		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
+		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
+			    MODE_LONG),
+		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
+			    MODE_NAME_ONLY),
+		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
+			    MODE_NAME_ONLY),
+		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
+			    MODE_OBJECT_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
@@ -169,6 +227,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
+	parse_shown_fields();
 	/*
 	 * show_recursive() rolls its own matching code and is
 	 * generally ignorant of 'struct pathspec'. The magic mask
diff --git a/quote.c b/quote.c
index 8a3a5e39eb..9f9da49fa2 100644
--- a/quote.c
+++ b/quote.c
@@ -340,12 +340,12 @@ void quote_two_c_style(struct strbuf *sb, const char *prefix, const char *path,
 
 void write_name_quoted(const char *name, FILE *fp, int terminator)
 {
-	if (terminator) {
+	if (0 < terminator || terminator == CQ_NO_TERMINATOR_C_QUOTED)
 		quote_c_style(name, NULL, fp, 0);
-	} else {
+	else
 		fputs(name, fp);
-	}
-	fputc(terminator, fp);
+	if (0 <= terminator)
+		fputc(terminator, fp);
 }
 
 void write_name_quoted_relative(const char *name, const char *prefix,
diff --git a/quote.h b/quote.h
index 049d8dd0b3..ec3f862545 100644
--- a/quote.h
+++ b/quote.h
@@ -84,8 +84,27 @@ int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 #define CQUOTE_NODQ 01
 size_t quote_c_style(const char *name, struct strbuf *, FILE *, unsigned);
 void quote_two_c_style(struct strbuf *, const char *, const char *, unsigned);
+/*
+ * Write a name, typically a filename, followed by a terminator that
+ * separates it from what comes next.
+ * When terminator is NUL, the name is given as-is.  Otherwise, the
+ * name is c-quoted, suitable for text output.  HT and LF are typical
+ * values used for the terminator, but other positive values are possible.
+ *
+ * In addition to non-negative values two special values in terminator
+ * are possible.
+ *
+ * -1: show the name c-quoted, without adding any terminator.
+ * -2: show the name as-is, without adding any terminator.
+ */
+#define CQ_NO_TERMINATOR_C_QUOTED	(-1)
+#define CQ_NO_TERMINATOR_AS_IS		(-2)
 
 void write_name_quoted(const char *name, FILE *, int terminator);
+/*
+ * Similar to the above, but the name is first made relative to the prefix
+ * before being shown.
+ */
 void write_name_quoted_relative(const char *name, const char *prefix,
 				FILE *fp, int terminator);
 
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 14520913af..75e38b0a51 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -22,4 +22,12 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	test_must_fail git ls-tree -r HEAD
 '
 
+test_expect_success 'usage: incompatible options: --name-status with --long' '
+	test_expect_code 129 git ls-tree --long --name-status
+'
+
+test_expect_success 'usage: incompatible options: --name-only with --long' '
+	test_expect_code 129 git ls-tree --long --name-only
+'
+
 test_done
diff --git a/t/t3104-ls-tree-oid.sh b/t/t3104-ls-tree-oid.sh
new file mode 100755
index 0000000000..81304e7b13
--- /dev/null
+++ b/t/t3104-ls-tree-oid.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='git ls-tree objects handling.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+	mkdir -p C &&
+	test_commit C/D.txt &&
+	find *.txt path* \( -type f -o -type l \) -print |
+	xargs git update-index --add &&
+	tree=$(git write-tree) &&
+	echo $tree
+'
+
+test_expect_success 'usage: --object-only' '
+	git ls-tree --object-only $tree >current &&
+	git ls-tree $tree >result &&
+	cut -f1 result | cut -d " " -f3 >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: --object-only with -r' '
+	git ls-tree --object-only -r $tree >current &&
+	git ls-tree -r $tree >result &&
+	cut -f1 result | cut -d " " -f3 >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: --object-only with --abbrev' '
+	git ls-tree --object-only --abbrev=6 $tree >current &&
+	git ls-tree --abbrev=6 $tree >result &&
+	cut -f1 result | cut -d " " -f3 >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: incompatible options: --name-only with --object-only' '
+	test_expect_code 129 git ls-tree --object-only --name-only
+'
+
+test_expect_success 'usage: incompatible options: --name-status with --object-only' '
+	test_expect_code 129 git ls-tree --object-only --name-status
+'
+
+test_expect_success 'usage: incompatible options: --long with --object-only' '
+	test_expect_code 129 git ls-tree --object-only --long
+'
+
+test_done
-- 
2.33.1.10.g5f17c1a2c1.dirty

