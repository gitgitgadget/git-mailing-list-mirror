Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C7FC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 08:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhKVIMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 03:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbhKVIMA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 03:12:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F33CC061714
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 00:08:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so14605052pjb.4
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 00:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5uXh/QpxuG1e6srCzE8+GtLhqPzjNxGjHXswpN7Iqc=;
        b=FQ0ACYJOt7faKjhGSa7k2IkJq4dxbzGGaeRKkzIsq9k4y/obUY+jF4VRMqcaBB/beO
         sL44ygLgf031hhuAswsEUNVDAZ7nbap3zP4qDhSx3DspX985S+nTUxc3OWcjkFS2S0fC
         E/M+W5qHuI1rKC+V3lhU3iL2G35oFZOsyVHXw2LL5QGzg4ULoOxHV78AojmlK4keX9QD
         8MJGulJOOPwJSWRRmhUW+6pQw7Fu6O6cRtCkMMDkG2ewxhEcdRsOjlblAw/U5jOJJZWG
         C0nieIsB89kUNWfugsFVHE3HdGPVyYJOGs6bMgvM3WMAHUV16WUVIQq2xd0mEd96pR7+
         Ey/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5uXh/QpxuG1e6srCzE8+GtLhqPzjNxGjHXswpN7Iqc=;
        b=CjDiBfaXDxH9uxOAYKqYNzHGoTBs8HHP0UJmAH9Ne0Pcu1LBewiZAIvr4t66xVLAh8
         CP6EjEVvq4BleFqw3s+mk1Tms+FpHKVxKUK0aD+nPS9WHz1ak/LVCvPXrpUhtm0RvgDu
         vkPwhrc8JNRc0myBTH+HguWuxEIuWusGXowKtdLJKhnYBo49Ayc6xebizzNV8mRIEUpT
         QGsYRnLfcCvC9wVIXv8NNhNlgVeVQI/8B7AErrr8SpnggSD3nIPms/4Xubm6BOSEAevJ
         48le+RD/R/R4nNBucodJSQqSaBnrYthH6BMjtzV1t0hefMpAiFQlWBy12jIMPulAAzpO
         iReg==
X-Gm-Message-State: AOAM532B2mn2l9fwWcUE7StfX1ggsE4PEb4TurO/liEVZNhNvl/3loX7
        B8lKDPL2rXO3/Pq5iG0otQf+TwoKwkmuEg0U
X-Google-Smtp-Source: ABdhPJzZlwJb1pea1n/MpiAhaiQPNBrUd1r6k6xro+t4D6f5ZB+daZ1REUKt16iipm0PB9gejWptNg==
X-Received: by 2002:a17:90b:4a83:: with SMTP id lp3mr29181295pjb.242.1637568533854;
        Mon, 22 Nov 2021 00:08:53 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id f185sm7512990pfg.39.2021.11.22.00.08.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Nov 2021 00:08:53 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, congdanhqx@gmail.com, gitster@pobox.com,
        peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v3 1/1] ls-tree.c: support `--oid-only` option for "git-ls-tree"
Date:   Mon, 22 Nov 2021 16:07:28 +0800
Message-Id: <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g438dd9044d.dirty
In-Reply-To: <cover.1637567328.git.dyroneteng@gmail.com>
References: <cover.1637567328.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes, we only want to get the objects from output of `ls-tree`
and commands like `sed` or `cut` is usually used to intercept the
origin output to achieve this purpose in practical.

This commit supply an option names `--oid-only` to let `git ls-tree`
only print out the OID of the object. `--oid-only` and `--name-only`
are mutually exclusive in use.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-ls-tree.txt |  8 +++++--
 builtin/ls-tree.c             | 27 ++++++++++++++++-------
 t/t3104-ls-tree-oid.sh        | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 10 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index db02d6d79a..bc711dc00a 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
+	    [--name-only] [--name-status] [--oid-only]
+	    [--full-name] [--full-tree] [--abbrev[=<n>]]
 	    <tree-ish> [<path>...]
 
 DESCRIPTION
@@ -59,7 +60,10 @@ OPTIONS
 --name-only::
 --name-status::
 	List only filenames (instead of the "long" output), one per line.
-
+	Cannot be used with `--oid-only` together.
+--oid-only::
+	List only OIDs of the objects, one per line. Cannot be used with
+	`--name-only` or `--name-status` together.
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show the shortest prefix that is at least '<n>'
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c7..1e4a82e669 100644
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
+	if (cmdmode == 2) {
+		printf("%s\n", find_unique_abbrev(oid, abbrev));
+		return 0;
+	}
+
+	if (cmdmode == 0) {
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
 			if (!strcmp(type, blob_type)) {
@@ -135,10 +147,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			    N_("terminate entries with NUL byte"), 0),
 		OPT_BIT('l', "long", &ls_options, N_("include object size"),
 			LS_SHOW_SIZE),
-		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
-		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
+		OPT_CMDMODE('n', "name-only", &cmdmode, N_("list only filenames"), MODE_NAME_ONLY),
+		OPT_CMDMODE('s', "name-status", &cmdmode, N_("list only filenames"), MODE_NAME_ONLY),
+		OPT_CMDMODE('o', "oid-only", &cmdmode, N_("list only oids"), MODE_OID_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
diff --git a/t/t3104-ls-tree-oid.sh b/t/t3104-ls-tree-oid.sh
new file mode 100755
index 0000000000..4c02cdd3c3
--- /dev/null
+++ b/t/t3104-ls-tree-oid.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='git ls-tree oids handling.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo 111 >1.txt &&
+	echo 222 >2.txt &&
+	mkdir -p path0/a/b/c &&
+	echo 333 >path0/a/b/c/3.txt &&
+	find *.txt path* \( -type f -o -type l \) -print |
+	xargs git update-index --add &&
+	tree=$(git write-tree) &&
+	echo $tree
+'
+
+test_expect_success 'usage: --oid-only' '
+	git ls-tree --oid-only $tree >current &&
+	git ls-tree $tree | awk "{print \$3}" >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: --oid-only with -r' '
+	git ls-tree --oid-only -r $tree >current &&
+	git ls-tree -r $tree | awk "{print \$3}" >expected &&
+	test_cmp current expected
+'
+
+test_expect_success 'usage: --oid-only with --abbrev' '
+	git ls-tree --oid-only --abbrev=6 $tree >current &&
+	git ls-tree --abbrev=6 $tree | awk "{print \$3}" > expected &&
+	test_cmp current expected
+'
+
+test_expect_failure 'usage: incompatible options: --name-only with --oid-only' '
+	test_incompatible_usage git ls-tree --oid-only --name-only
+'
+
+test_done
-- 
2.33.1.10.g438dd9044d.dirty

