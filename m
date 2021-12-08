Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF56C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 02:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhLHCMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhLHCMN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 21:12:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120D6C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 18:08:43 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q17so523634plr.11
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 18:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDxpljSakHftk47BBliQUzJop/ltjNOK9dmQ9Wu4sE4=;
        b=clSnv1mxbSloRw3swvFwfkJwHhoEYBvnNbN3P2m3YnE5RV1E6PUILw7opbkxS7RdHD
         LYfM7GF9BKaEB1BlioLUZBJjcV+ZFj6RKWxiiO3WwJf1pUyWDDHpdobAYXhIbiZqGS13
         dVHM0fQtyJjy1U5qK26U725CaX/2VpwyIHaWxQmsjlkYaMdKWFY9jOC21ZNVJYMJXdTr
         BFhI4AOHANLlvdky0bVpQn7IxXFyFKx+4KbceVWrI8Hc943omwYDGCptuGecs9wJTA3t
         yIVdTcR6kNKxRjvZGW56Hstj3kikaCPxCk/ITOVE2r1BYcSZyWEglzToYyeM1ijfb2P4
         TXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDxpljSakHftk47BBliQUzJop/ltjNOK9dmQ9Wu4sE4=;
        b=DHZqSRsnETd3TWjfEw/5GlRMhBa8s4p+8daA5h5yC7/3R3d10j46Vneyb6Ep/gLLAJ
         oLL5BRpCJQ70L6n1kff9nIRmIMCSoGrLpbCClMiDe5odFR6sxpKdf6naw//7TeN8eQAK
         rADFmWGNPv+t2zy1j7j58TQL3kkkSlun7fPgxVq7h/nNMlvSrPLf5RXRWEMOwKls9jM1
         mcCJhHBGTkQ/r0gtqvP5gLy9ktbHyUajmP9saqxpwEBR9vRC5UsalMAb0UnU49domvTt
         LN7eXSL59ods0uQckkbyJ6FoMZt496mD8pSWBPBkwZkm1ngFnl4NSvDbr/QHUMtSZ/Zm
         Yi/w==
X-Gm-Message-State: AOAM531Fl5vdqLJVESrk52kVCyatRJKKxTXS/DYsBaZzN14OR2AIaz0C
        xlTYRa5g13XTS1iujvRrz1bd9aK3ojApNKhejM8=
X-Google-Smtp-Source: ABdhPJyAXjrmRultIqdAQNaci7y1lD0esuhL31NVMK9z83xXCFQ6fZwVsf3fdLqBhvrcX9cwVVGPVw==
X-Received: by 2002:a17:90a:e7c4:: with SMTP id kb4mr3643922pjb.237.1638929322253;
        Tue, 07 Dec 2021 18:08:42 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id np1sm4280214pjb.22.2021.12.07.18.08.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 18:08:41 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, congdanhqx@gmail.com, gitster@pobox.com,
        peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v5 1/1] ls-tree.c: support `--object-only` option for "git-ls-tree"
Date:   Wed,  8 Dec 2021 10:08:31 +0800
Message-Id: <38d55a878c51104f0a5337481fdcd5c8818660ac.1638891420.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.gd2a07a0ec5.dirty
In-Reply-To: <cover.1638891420.git.dyroneteng@gmail.com>
References: <cover.1638891420.git.dyroneteng@gmail.com>
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
 builtin/ls-tree.c             | 125 ++++++++++++++++++++++++----------
 t/t3103-ls-tree-misc.sh       |   8 +++
 t/t3104-ls-tree-oid.sh        |  51 ++++++++++++++
 4 files changed, 154 insertions(+), 37 deletions(-)
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
index 3a442631c7..beaa8bf13b 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -16,21 +16,38 @@
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
-#define LS_TREE_ONLY 2
-#define LS_SHOW_TREES 4
-#define LS_NAME_ONLY 8
-#define LS_SHOW_SIZE 16
+#define LS_TREE_ONLY 1 << 1
+#define LS_SHOW_TREES 1 << 2
+#define LS_NAME_ONLY 1 << 3
+#define LS_SHOW_SIZE 1 << 4
+#define LS_OBJECT_ONLY 1 << 5
 static int abbrev;
 static int ls_options;
 static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
+static unsigned int shown_bits = 0;
+#define SHOW_DEFAULT 29 /* 11101 size is not shown to output by default */
+#define SHOW_MODE 1 << 4
+#define SHOW_TYPE 1 << 3
+#define SHOW_OBJECT_NAME 1 << 2
+#define SHOW_SIZE 1 << 1
+#define SHOW_FILE_NAME 1
 
 static const  char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
 };
 
+enum {
+	MODE_UNSPECIFIED = 0,
+	MODE_NAME_ONLY,
+	MODE_OBJECT_ONLY,
+	MODE_LONG
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
+	int follow = 0;
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
@@ -90,35 +108,67 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
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
+		printf("%06o",mode);
+		follow = 1;
+	}
+	if (shown_bits & SHOW_TYPE) {
+		printf("%s%s", follow == 1 ? " " : "", type);
+		follow = 1;
+	}
+	if (shown_bits & SHOW_OBJECT_NAME) {
+		printf("%s%s", follow == 1 ? " " : "",
+		       find_unique_abbrev(oid, abbrev));
+		if (!(shown_bits ^ SHOW_OBJECT_NAME))
+			printf("%c", line_termination);
+		follow = 1;
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
+		printf("%s%7s", follow == 1 ? " " : "", size_text);
+		follow = 1;
+	}
+	if (shown_bits & SHOW_FILE_NAME) {
+		if (follow)
+			printf("\t");
+		baselen = base->len;
+		strbuf_addstr(base, pathname);
+		write_name_quoted_relative(base->buf,
+					   chomp_prefix ? ls_tree_prefix : NULL,
+					   stdout, line_termination);
+		strbuf_setlen(base, baselen);
 	}
-	baselen = base->len;
-	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL,
-				   stdout, line_termination);
-	strbuf_setlen(base, baselen);
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
@@ -133,12 +183,14 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
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
@@ -169,6 +221,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
+	parse_shown_fields();
 	/*
 	 * show_recursive() rolls its own matching code and is
 	 * generally ignorant of 'struct pathspec'. The magic mask
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
2.33.1.10.gd2a07a0ec5.dirty

