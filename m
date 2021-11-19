Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8FCC433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2382A61875
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhKSMNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhKSMNI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:13:08 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DD2C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:10:07 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v23so7779546pjr.5
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5bLY2uw6VKhRR0IVR0W5x6oy2shnP1pG10lhwD497o=;
        b=awGCKtehdpJhfSdB1lUfZDmKk4Dux7Y7CxXeovQmCNERfUdYoFBp7GwUwcL41Caj9r
         VmTQn471YQ4EXeX04LyXXvRc/9eLGdo0qV/1SabAKCX+zm8ChxLHjq8c6CLjXuFnVv1w
         CMDRjZLM4n4xCFmOZJufFj/3ABJAEtX0Lc2Q0YflKFgl5c6MzRBad2paL89EJozC6bgO
         EI8x4vbTx0vkhVnq1tD5axiDGPrmVGPp1qwbEDKkkvRC+bl4RCBkBuQNTsu+vkWaG1oO
         pICbd4Kw189sdW5gRKZdknbyXZJ5ZKm7zT0gOnt7x4jF94dqoydVtbx5+CTL7PT98jO8
         DoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5bLY2uw6VKhRR0IVR0W5x6oy2shnP1pG10lhwD497o=;
        b=qqLr7D6aELYbqGGcF/5R1+lVRvyQPuSzQfOzXfDsgc7e1C28X5Ce0uJJ5aFnrdqLnV
         rQlpjnAmRauMatQiFBI+5e3xayL+3+x8NCt9PQKa2XXjUBWNOTv3sHV236ugX/AFFpFT
         USEs5nPaAWAoa1MhQU0lsJCLcYAk6ZE4RP8zaXiLpaTM6WjgJSWDTZ2+EBfjfMvJgTkH
         0XbjXjoGBorhMm7PivMPS46YHs4bM4jWBSLA/UacZGAWJM0TYF6fv3FM2MSQi/ctEHP4
         zTb9aH9YxjTPpzCMpbbh2m61aHX659MUCD/NIcUUKw98v3O//CvYr6EEbl7f3vkrMBdp
         7OuA==
X-Gm-Message-State: AOAM533kvzOZKvJXku67uUrKEjGdiemuEH1XzQMsetPWlSv5zTc+6HSX
        6cmFCkPOrCNLi/l6LwiOapRZZqSxAuMPzLFQ
X-Google-Smtp-Source: ABdhPJzXqJxPmScvxVWIxCMukrnRLwfRNw5CbU/u0HvfBcXac35iLj4riCE8zZ5zv1inBcFyGK6CJQ==
X-Received: by 2002:a17:903:2283:b0:141:f858:f9af with SMTP id b3-20020a170903228300b00141f858f9afmr76635896plh.80.1637323806399;
        Fri, 19 Nov 2021 04:10:06 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id oj11sm11875381pjb.46.2021.11.19.04.10.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 04:10:06 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        congdanhqx@gmail.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v2 1/1] ls-tree.c: support `--oid-only` option for "git-ls-tree"
Date:   Fri, 19 Nov 2021 20:09:27 +0800
Message-Id: <8b68568d6cbe379d40c61c48bf446eaa88221df5.1637321601.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g8b68568d6c
In-Reply-To: <cover.1637321601.git.dyroneteng@gmail.com>
References: <cover.1637321601.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Jeff King <peff@peff.net>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Reviewed-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
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
2.33.1.10.g1f74a882e4

