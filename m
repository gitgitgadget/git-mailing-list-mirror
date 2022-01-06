Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3BCC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 04:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiAFEcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiAFEcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 23:32:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D9AC0611FD
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 20:32:09 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so1919408pjw.2
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 20:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FAHfOr+S+QCtnoIUvVHsx8a0brl8zjbp5m6mnA39zpQ=;
        b=C7chPsOsiVPawgguOmwfYklvIzq9w12EEMZYQbXQKaCGs+mdQE+FXOvTicrj9BoN0b
         jT5EM/vf3SgjlEz1ljiwAWV7zi3woyAL5vonrVIFS/VNr6tm92TIKtB1ngXv9auvew2y
         g8+ale7h4wjQj609coCv5vF0PKHXtrY94K6Xbs8jAtqPCfi1lC7+9hPsYj4LZFVuIFNA
         bKJJTAl4n77lrSW39zTxytscXxvQFHjWJA5Cp3o+loFygsJ9fO+UYmjDeN03w2yXe60A
         H+FID2mPSP0C1z0AviHPSk1kaQtR58FgEgv3Y2FVFyAoDu13IDTyhIA7bv/qz4v2vUia
         o8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FAHfOr+S+QCtnoIUvVHsx8a0brl8zjbp5m6mnA39zpQ=;
        b=8DDFCc+fqvIL7Ew8Ozrmc2J9dgaZUaB121bnAQmX6+eCmamZ2kElrJPzS6ZQ4+yNhU
         sqX74qh75cxTTEusD+zjItwSaOFW4FlZn/zKxRDyIlghCsaACrqQyiogD+Mn32nKbW3g
         gckSplCtluKtkCS5gGbdPwx6sGrcgCj11QH7kNytIT5LukJlShiOWBLnatoQIiqZPK0d
         ssWjovEfXkWfR3fy/1ugmnBDJhyrcuw+GeJ5KCpt2eV0FD7t6PdhoZl5fv+zzvU9TCyo
         DYZVdWEirz0ieRSyfvvQOvf3CPJdwKuehDlmW0/MtO/kHvZKxAw92+nhp2+DoTDBRi3s
         XUSg==
X-Gm-Message-State: AOAM5323BF2IAVNqMmqatbB3AkYXZquDcrgzzplomTWVsyjnMr/D59Oi
        W5YjhOGUUNQaKFz/UTT6xck0S2u2eudItw/lAuk=
X-Google-Smtp-Source: ABdhPJxVAuvtV/J8rw4Ae45cVAfMnpf72y7Xt1iYut0bWGdO2n1SgrRrBGHx1cGlGKD/RI2FvEtmVw==
X-Received: by 2002:a17:90b:1206:: with SMTP id gl6mr7997585pjb.228.1641443528493;
        Wed, 05 Jan 2022 20:32:08 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id 13sm636491pfm.161.2022.01.05.20.32.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 20:32:08 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v9 6/9] ls-tree.c: support --object-only option for "git-ls-tree"
Date:   Thu,  6 Jan 2022 12:31:29 +0800
Message-Id: <e0274f079a7d381b9a936bfcd53bad64167c18b8.1641440700.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1794.g2ae0a9cb82
In-Reply-To: <cover.1641440700.git.dyroneteng@gmail.com>
References: <cover.1641440700.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
"--name-only" or "--long" , they are mutually exclusive (actually
"--name-only" and "--long" can be combined together before, this
commit by the way fix this bug).

A simple refactoring was done to the "show_tree" function, intead by
using bitwise operations to recognize the format for printing to
stdout. The reason for doing this is that we don't want to increase
the readability difficulty with the addition of "-object-only",
making this part of the logic easier to read and expand.

In terms of performance, there is no loss comparing to the
"master" (2ae0a9cb8298185a94e5998086f380a355dd8907), here are the
results of the performance tests in my environment based on linux
repository:

    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
    Time (mean ± σ):     105.8 ms ±   2.7 ms    [User: 85.7 ms, System: 20.0 ms]
    Range (min … max):   101.5 ms … 111.3 ms    28 runs

    $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD"
    Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD
    Time (mean ± σ):     105.0 ms ±   3.0 ms    [User: 83.7 ms, System: 21.2 ms]
    Range (min … max):    99.3 ms … 109.5 ms    27 runs

    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r -l HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r -l HEAD
    Time (mean ± σ):     337.4 ms ±  10.9 ms    [User: 308.3 ms, System: 29.0 ms]
    Range (min … max):   323.0 ms … 355.0 ms    10 runs

    $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD"
    Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD
    Time (mean ± σ):     337.6 ms ±   6.2 ms    [User: 309.4 ms, System: 28.1 ms]
    Range (min … max):   330.4 ms … 349.9 ms    10 runs

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt |   7 +-
 builtin/ls-tree.c             | 141 +++++++++++++++++++++++++---------
 t/t3104-ls-tree-oid.sh        |  51 ++++++++++++
 3 files changed, 160 insertions(+), 39 deletions(-)
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
index 7383dddf8c..6b5e3ab9dd 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -16,22 +16,60 @@
 
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
+static unsigned int shown_fields;
+#define FIELD_FILE_NAME 1
+#define FIELD_SIZE (1 << 1)
+#define FIELD_OBJECT_NAME (1 << 2)
+#define FIELD_TYPE (1 << 3)
+#define FIELD_MODE (1 << 4)
+#define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
+#define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
 
 static const  char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
 };
 
-static int show_recursive(const char *base, size_t baselen, const char *pathname)
+enum {
+	MODE_UNSPECIFIED = 0,
+	MODE_NAME_ONLY,
+	MODE_OBJECT_ONLY,
+	MODE_LONG,
+};
+
+static int cmdmode = MODE_UNSPECIFIED;
+
+static int parse_shown_fields(void)
+{
+	if (cmdmode == MODE_NAME_ONLY) {
+		shown_fields = FIELD_FILE_NAME;
+		return 0;
+	}
+	if (cmdmode == MODE_OBJECT_ONLY) {
+		shown_fields = FIELD_OBJECT_NAME;
+		return 0;
+	}
+	if (!ls_options || (ls_options & LS_RECURSIVE)
+	    || (ls_options & LS_SHOW_TREES)
+	    || (ls_options & LS_TREE_ONLY))
+		shown_fields = FIELD_DEFAULT;
+	if (cmdmode == MODE_LONG)
+		shown_fields = FIELD_LONG_DEFAULT;
+	return 1;
+}
+
+static int show_recursive(const char *base, size_t baselen,
+			  const char *pathname)
 {
 	int i;
 
@@ -61,6 +99,39 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
+static int show_default(const struct object_id *oid, enum object_type type,
+			const char *pathname, unsigned mode,
+			struct strbuf *base)
+{
+	size_t baselen = base->len;
+
+	if (shown_fields & FIELD_SIZE) {
+		char size_text[24];
+		if (type == OBJ_BLOB) {
+			unsigned long size;
+			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
+				xsnprintf(size_text, sizeof(size_text), "BAD");
+			else
+				xsnprintf(size_text, sizeof(size_text),
+					  "%" PRIuMAX, (uintmax_t)size);
+		} else {
+			xsnprintf(size_text, sizeof(size_text), "-");
+		}
+		printf("%06o %s %s %7s\t", mode, type_name(type),
+		find_unique_abbrev(oid, abbrev), size_text);
+	} else {
+		printf("%06o %s %s\t", mode, type_name(type),
+		find_unique_abbrev(oid, abbrev));
+	}
+	baselen = base->len;
+	strbuf_addstr(base, pathname);
+	write_name_quoted_relative(base->buf,
+				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
+				   line_termination);
+	strbuf_setlen(base, baselen);
+	return 1;
+}
+
 static void init_type(unsigned mode, enum object_type *type)
 {
 	if (S_ISGITLINK(mode))
@@ -91,34 +162,24 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
 		return !READ_TREE_RECURSIVE;
 
-	if (!(ls_options & LS_NAME_ONLY)) {
-		if (ls_options & LS_SHOW_SIZE) {
-			char size_text[24];
-			if (type == OBJ_BLOB) {
-				unsigned long size;
-				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
-					xsnprintf(size_text, sizeof(size_text),
-						  "BAD");
-				else
-					xsnprintf(size_text, sizeof(size_text),
-						  "%"PRIuMAX, (uintmax_t)size);
-			} else {
-				xsnprintf(size_text, sizeof(size_text), "-");
-			}
-			printf("%06o %s %s %7s\t", mode, type_name(type),
-			       find_unique_abbrev(oid, abbrev),
-			       size_text);
-		} else {
-			printf("%06o %s %s\t", mode, type_name(type),
-			       find_unique_abbrev(oid, abbrev));
-		}
+	if (shown_fields == FIELD_OBJECT_NAME) {
+		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
+		return recursive;
 	}
-	baselen = base->len;
-	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL,
-				   stdout, line_termination);
-	strbuf_setlen(base, baselen);
+
+	if (shown_fields == FIELD_FILE_NAME) {
+		baselen = base->len;
+		strbuf_addstr(base, pathname);
+		write_name_quoted_relative(base->buf,
+					   chomp_prefix ? ls_tree_prefix : NULL,
+					   stdout, line_termination);
+		strbuf_setlen(base, baselen);
+		return recursive;
+	}
+
+	if (shown_fields >= FIELD_DEFAULT)
+		show_default(oid, type, pathname, mode, base);
+
 	return recursive;
 }
 
@@ -136,12 +197,14 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
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
@@ -172,6 +235,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
+	parse_shown_fields();
+
 	/*
 	 * show_recursive() rolls its own matching code and is
 	 * generally ignorant of 'struct pathspec'. The magic mask
diff --git a/t/t3104-ls-tree-oid.sh b/t/t3104-ls-tree-oid.sh
new file mode 100755
index 0000000000..6ce62bd769
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
+	test_expect_code 129 git ls-tree --object-only --name-only $tree
+'
+
+test_expect_success 'usage: incompatible options: --name-status with --object-only' '
+	test_expect_code 129 git ls-tree --object-only --name-status $tree
+'
+
+test_expect_success 'usage: incompatible options: --long with --object-only' '
+	test_expect_code 129 git ls-tree --object-only --long $tree
+'
+
+test_done
-- 
2.33.0.rc1.1794.g2ae0a9cb82

