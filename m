Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D74CC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 04:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhKWFBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 00:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhKWFB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 00:01:29 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40EEC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 20:58:21 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x131so18206347pfc.12
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 20:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mI/dH7/oPLYrGRBoVxbFJIiR1UGJx7JtfmRk4mw3M1k=;
        b=HIhucSxTvRIcb2UmMshNW7B6bNl5/wskpPsm2wxpMdxAwYuJWHuLXF09GjUSNB6IE1
         zvt3igMJvNQtZfiAoFX64oCHG49AUpbwmMlfxUH1OG7+Dhu0gYzf8vhHlONfzUcersVI
         fLTFVUIHAGj5Crbj15JzfnpCoY8BVBlHu2pyQCks+ZDYjEmk4L5RjojRSNvd9p0nKnE/
         QjTA+n0TZ7zAYNuG/tdYxwX2RwPBwfpp2X+6Ka8+fohsNwJLQcFREr6pml7HwswQC8Jy
         /QVGikbT/XzkR7afcJE3SB5lYC4DU92cgN+r3gnRWT38upYUXxFm93Yp3wJztVSdXAKE
         GvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mI/dH7/oPLYrGRBoVxbFJIiR1UGJx7JtfmRk4mw3M1k=;
        b=48x5pU7ctsWs/0GPjCZJPuBN8bTDNV/cG8ACQ7ohdzUYqVElioab2qGVupdzvIP7Na
         AkYnaZzBdinbK4TM4tZjwmna9RtRQgkKlgOpPjF4O6drtKwChUKOBic2f9LYlVN5HiPR
         igEzxy2YU2FUXE7j6rDrv2j9BHTrqXxgbXYsY/IgX637Mrr/o9wagYmkO1s2OO7xLkJg
         7FtIzrROhP/mTCYLN5NTdfa5vjtznxh8FIJ9XjPX+ML56I9koFhMl5kATPvRRo+43B07
         9uZ+iRKweoC8wlD/iKXvHx4lzW5uDMt+ggQTiXH0isACXALth73h1HEvAB7bYkc6Egs+
         vRog==
X-Gm-Message-State: AOAM5304+oz92GhZk65mFUkATlUXihfq9y52Hs1drLSiFZ85aapJfGlP
        mA6y7qnQq3QMo47bXc+gM6QURWCP+qXEHIASgHA=
X-Google-Smtp-Source: ABdhPJxsxdvKydlOs1Mh2B2pcYBiYV5Wueu/duU3J6st51dKJ0lzt3NIsp92yW2wW9McJ8EOMxC2WQ==
X-Received: by 2002:a63:1d0c:: with SMTP id d12mr1778233pgd.410.1637643501302;
        Mon, 22 Nov 2021 20:58:21 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id y18sm11765513pfa.142.2021.11.22.20.58.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Nov 2021 20:58:20 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, congdanhqx@gmail.com, gitster@pobox.com,
        peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v4 1/1] ls-tree.c: support `--oid-only` option for "git-ls-tree"
Date:   Tue, 23 Nov 2021 12:58:06 +0800
Message-Id: <63876dbeb7f880c0001649b49d5265b744c42765.1637642029.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g75523f744f.dirty
In-Reply-To: <cover.1637642029.git.dyroneteng@gmail.com>
References: <cover.1637642029.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes, we only want to get the objects from output of `ls-tree`
and commands like `sed` or `cut` is usually used to intercept the
origin output to achieve this purpose in practice.

This commit teach the "--oid-only" option to tell the command to
only show the object name, just like "--name-only" option tells the
command to only show the path component, for each entry. These two
options are mutually exclusive.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt | 18 ++++++++++++---
 builtin/ls-tree.c             | 30 +++++++++++++++++-------
 t/t3104-ls-tree-oid.sh        | 43 +++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 11 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index db02d6d79a..fd2a871ca5 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -9,8 +9,10 @@ git-ls-tree - List the contents of a tree object
 SYNOPSIS
 --------
 [verse]
-'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
+'git ls-tree' [-d] [-r] [-t] [-l] [-z] [-n] [-s] [-o]
+	    [--name-only | --oid-only]
+	    [--name-status | --oid-only]
+	    [--full-name] [--full-tree] [--abbrev[=<n>]]
 	    <tree-ish> [<path>...]
 
 DESCRIPTION
@@ -56,9 +58,19 @@ OPTIONS
 	\0 line termination on output and do not quote filenames.
 	See OUTPUT FORMAT below for more information.
 
+-n::
 --name-only::
---name-status::
 	List only filenames (instead of the "long" output), one per line.
+	Cannot be combined with `--oid-only`.
+
+-s::
+--name-status::
+	Consistent behavior with `--name-only`.
+
+-o::
+--oid-only::
+	List only names of the objects, one per line. Cannot be combined
+	with `--name-only` or `--name-status`.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c7..0c2153a5ad 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -18,19 +18,26 @@ static int line_termination = '\n';
 #define LS_RECURSIVE 1
 #define LS_TREE_ONLY 2
 #define LS_SHOW_TREES 4
-#define LS_NAME_ONLY 8
-#define LS_SHOW_SIZE 16
+#define LS_SHOW_SIZE 8
 static int abbrev;
 static int ls_options;
 static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
 
-static const  char * const ls_tree_usage[] = {
+static const char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
 };
 
+enum {
+	MODE_UNSPECIFIED = 0,
+	MODE_NAME_ONLY,
+	MODE_OID_ONLY
+};
+
+static int cmdmode = MODE_UNSPECIFIED;
+
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
 	int i;
@@ -90,7 +97,12 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
 
-	if (!(ls_options & LS_NAME_ONLY)) {
+	if (cmdmode == MODE_OID_ONLY) {
+		printf("%s\n", find_unique_abbrev(oid, abbrev));
+		return 0;
+	}
+
+	if (cmdmode == MODE_UNSPECIFIED) {
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
 			if (!strcmp(type, blob_type)) {
@@ -135,10 +147,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			    N_("terminate entries with NUL byte"), 0),
 		OPT_BIT('l', "long", &ls_options, N_("include object size"),
 			LS_SHOW_SIZE),
-		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
-		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
+		OPT_CMDMODE('n', "name-only", &cmdmode,
+			    N_("list only filenames"), MODE_NAME_ONLY),
+		OPT_CMDMODE('s', "name-status", &cmdmode,
+			    N_("list only filenames"), MODE_NAME_ONLY),
+		OPT_CMDMODE('o', "oid-only", &cmdmode,
+			    N_("list only oids"), MODE_OID_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
diff --git a/t/t3104-ls-tree-oid.sh b/t/t3104-ls-tree-oid.sh
new file mode 100755
index 0000000000..2d349f6e46
--- /dev/null
+++ b/t/t3104-ls-tree-oid.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='git ls-tree oids handling.'
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
+test_expect_success 'usage: --oid-only' '
+	git ls-tree --oid-only $tree >current &&
+	git ls-tree $tree >result &&
+	cut -f1 result | cut -d " " -f3 >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: --oid-only with -r' '
+	git ls-tree --oid-only -r $tree >current &&
+	git ls-tree -r $tree >result &&
+	cut -f1 result | cut -d " " -f3 >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: --oid-only with --abbrev' '
+	git ls-tree --oid-only --abbrev=6 $tree >current &&
+	git ls-tree --abbrev=6 $tree >result &&
+	cut -f1 result | cut -d " " -f3 >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: incompatible options: --name-only with --oid-only' '
+	test_expect_code 129 git ls-tree --oid-only --name-only
+'
+
+test_done
-- 
2.33.1.10.g75523f744f.dirty

