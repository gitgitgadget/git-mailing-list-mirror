Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9131ECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 23:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiH2X3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 19:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiH2X3I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 19:29:08 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF904876A4
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 16:29:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f14so7288348qkm.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CYwbk3QoZfWtJBa32JM5RLzyASvy1XW8ZyJqOdkx03g=;
        b=n1vcehgHcNbsHC24ZgQd9RCIh3HbqUB2LJ5dXojBgM8LGom/FBSHgzEEeXvKDvQ6dl
         g8hnKnuEjKg1UFUO1gqXC6vA7b9xSNYXoqn4pqMY7g5EGLoY7kRI/MLt8dzQ+TdsO3/S
         F8AWzEEUmznphE5+6BQEaNfjPeaoCG4Zy07IZiwF7/7+wlB4dHhPI9vDae9KS4hYnhLb
         BQQlJGHsDTfRSJKjm343zIl6V+RiwCsHZly6CecwuPaDTLrgmyLdjmqCtJOKl6vgZlcB
         kLpiWKG7E/Gcex1FI1mZjRTGDYb+nuBZZMhuO73OewE1kPvQrWLQWfbN4xZH0iDTDbN6
         oCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CYwbk3QoZfWtJBa32JM5RLzyASvy1XW8ZyJqOdkx03g=;
        b=v7we1f/u682L+bz1C0AK+/elm075vZ9/04irwNZEsZZXdz+RA/ydrk3fU1Fl7gab+C
         YnkU8y8CW1xYygFCEOVgTLDmqPGOSEvfaivQIsgykUFzW2aCfmbNN2++OUdY1JTW3Q+t
         INu+0Ps2/Ne9Wglv46lgrJFQo/xM1fKp7IDaLv4ukOmBwifExMhNJMemtX2KUibJVQCi
         CdKjQXcA6bYd3Il3WBCq/oqYaLDNY7CxzVQIMm2TPsOXYj3JxJhcgHUENfBGPXwBzaq/
         NuxI/REAmNdd85+zdS1dDKxbYVUtdj8P2M34mD2n0YRgV5bqd583gUMYB+1ZW40BtY39
         QBCw==
X-Gm-Message-State: ACgBeo0japFeO051U4ofMiAvoXpctrHLwLJ23YAridg+oAiiKgPEHAn7
        +L7kVbx5uA6UBpgkLg/6G7XDR1i/UpkbXA==
X-Google-Smtp-Source: AA6agR5sfRMgOTGzF2ifyeAbsxGHrPZt2hCrYfPi/zkL73xloeyQ02csBKgEsFO8p5mOKL9VmR7Rgw==
X-Received: by 2002:ae9:f302:0:b0:6bc:c42:e80d with SMTP id p2-20020ae9f302000000b006bc0c42e80dmr10081230qkg.426.1661815743803;
        Mon, 29 Aug 2022 16:29:03 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id l7-20020a05620a28c700b006a793bde241sm6679802qkp.63.2022.08.29.16.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 16:29:03 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 1/2] builtin/grep.c: add --sparse option
Date:   Mon, 29 Aug 2022 16:28:42 -0700
Message-Id: <20220829232843.183711-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220829232843.183711-1-shaoxuan.yuan02@gmail.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220829232843.183711-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --sparse option to `git-grep`.

When the '--cached' option is used with the 'git grep' command, the
search is limited to the blobs found in the index, not in the worktree.
If the user has enabled sparse-checkout, this might present more results
than they would like, since the files outside of the sparse-checkout are
unlikely to be important to them.

Change the default behavior of 'git grep' to focus on the files within
the sparse-checkout definition. To enable the previous behavior, add a
'--sparse' option to 'git grep' that triggers the old behavior that
inspects paths outside of the sparse-checkout definition when paired
with the '--cached' option.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Suggested-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 Documentation/git-grep.txt      |  5 ++++-
 builtin/grep.c                  | 10 +++++++++-
 t/t7817-grep-sparse-checkout.sh | 34 +++++++++++++++++++++++++++------
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 58d944bd57..bdd3d5b8a6 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -28,7 +28,7 @@ SYNOPSIS
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [--recurse-submodules] [--parent-basename <basename>]
-	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
+	   [ [--[no-]exclude-standard] [--cached [--sparse] | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -45,6 +45,9 @@ OPTIONS
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the index file.
 
+--sparse::
+	Use with --cached. Search outside of sparse-checkout definition.
+
 --no-index::
 	Search files in the current directory that is not managed by Git.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index e6bcdf860c..12abd832fa 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -96,6 +96,8 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
+static int grep_sparse = 0;
+
 static void add_work(struct grep_opt *opt, struct grep_source *gs)
 {
 	if (opt->binary != GREP_BINARY_TEXT)
@@ -525,7 +527,11 @@ static int grep_cache(struct grep_opt *opt,
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
-		if (!cached && ce_skip_worktree(ce))
+		/*
+		 * Skip entries with SKIP_WORKTREE unless both --sparse and
+		 * --cached are given.
+		 */
+		if (!(grep_sparse && cached) && ce_skip_worktree(ce))
 			continue;
 
 		strbuf_setlen(&name, name_base_len);
@@ -963,6 +969,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_INTEGER('m', "max-count", &opt.max_count,
 			N_("maximum number of results per file")),
+		OPT_BOOL(0, "sparse", &grep_sparse,
+			 N_("search the contents of files outside the sparse-checkout definition")),
 		OPT_END()
 	};
 	grep_prefix = prefix;
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
index eb59564565..a9879cc980 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -118,13 +118,19 @@ test_expect_success 'grep searches unmerged file despite not matching sparsity p
 	test_cmp expect actual
 '
 
-test_expect_success 'grep --cached searches entries with the SKIP_WORKTREE bit' '
+test_expect_success 'grep --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
+	cat >expect <<-EOF &&
+	a:text
+	EOF
+	git grep --cached "text" >actual &&
+	test_cmp expect actual &&
+
 	cat >expect <<-EOF &&
 	a:text
 	b:text
 	dir/c:text
 	EOF
-	git grep --cached "text" >actual &&
+	git grep --cached --sparse "text" >actual &&
 	test_cmp expect actual
 '
 
@@ -143,7 +149,15 @@ test_expect_success 'grep --recurse-submodules honors sparse checkout in submodu
 	test_cmp expect actual
 '
 
-test_expect_success 'grep --recurse-submodules --cached searches entries with the SKIP_WORKTREE bit' '
+test_expect_success 'grep --recurse-submodules --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
+	cat >expect <<-EOF &&
+	a:text
+	sub/B/b:text
+	sub2/a:text
+	EOF
+	git grep --recurse-submodules --cached "text" >actual &&
+	test_cmp expect actual &&
+
 	cat >expect <<-EOF &&
 	a:text
 	b:text
@@ -152,7 +166,7 @@ test_expect_success 'grep --recurse-submodules --cached searches entries with th
 	sub/B/b:text
 	sub2/a:text
 	EOF
-	git grep --recurse-submodules --cached "text" >actual &&
+	git grep --recurse-submodules --cached --sparse "text" >actual &&
 	test_cmp expect actual
 '
 
@@ -166,7 +180,15 @@ test_expect_success 'working tree grep does not search the index with CE_VALID a
 	test_cmp expect actual
 '
 
-test_expect_success 'grep --cached searches index entries with both CE_VALID and SKIP_WORKTREE' '
+test_expect_success 'grep --cached and --sparse searches index entries with both CE_VALID and SKIP_WORKTREE' '
+	cat >expect <<-EOF &&
+	a:text
+	EOF
+	test_when_finished "git update-index --no-assume-unchanged b" &&
+	git update-index --assume-unchanged b &&
+	git grep --cached text >actual &&
+	test_cmp expect actual &&
+
 	cat >expect <<-EOF &&
 	a:text
 	b:text
@@ -174,7 +196,7 @@ test_expect_success 'grep --cached searches index entries with both CE_VALID and
 	EOF
 	test_when_finished "git update-index --no-assume-unchanged b" &&
 	git update-index --assume-unchanged b &&
-	git grep --cached text >actual &&
+	git grep --cached --sparse text >actual &&
 	test_cmp expect actual
 '
 
-- 
2.37.0

