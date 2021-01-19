Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27344C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE92E22CB1
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbhASGcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbhASGbc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 01:31:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4269C0613C1
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 22:30:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m4so18535134wrx.9
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 22:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jKQ5PzAJNmWCwCKL2is40P8yR4Yksrb6Fp1ldLEJbbI=;
        b=fdD0z/kC/Cd6Fj75ax6tuKOfL1aQ5vIJW0xsZE3ScJemM6NOwyL+HexkdkHVWvEAFR
         OlVyInvV5FzsdG7Uo+7f5Zx6l5tuOJuno6Dj5722aaT1rjtb5O5+0iPO9LU5oV1aVUPF
         DVDuHoImUQ/yKabPMhCytng00LY7ulInEHr8U7XVeqrxQIvLC7i3Z67LTcK4eF5hcYbT
         q4GPqK1m5P2mS7K6Z8TgUISeW1rLTJmnmpfTfX3lS+ct4Sit9VuEgVXmFcqPCd7Uy3WZ
         5N7maK0VUweI+j44cFyZoPL0hCnz0AcQFB+wGXoJgymeL/gwz58/DHyNzuAQDx68RPs+
         Uouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jKQ5PzAJNmWCwCKL2is40P8yR4Yksrb6Fp1ldLEJbbI=;
        b=MKrQJcn140YAji3nYNVvEJzNUQ6fSE+MMnBGtPF+a3C1xcd/lLvs9jp6cqn0DD+zRR
         BdrnQ8/KJTc3SVf2dOdW0rxxwp8FWI8AuJ+dMXzHdtk7qipK6o7hWyqmQCP9blw7q1lf
         79iNoNlGYspmAY7YmXHm2lCxh7iZ/cnArWCoGZtwV65cw9jiGMYekQjwoc/RUusL3dAN
         oj0M6v+Nw1Oov5Ip9TCX44rmwhjcl2pAcBbw8WK18UAMrr6vrgiEaquGkIxeje678gBl
         KErWef03l+TVAj6rQ3CXJawC24pn4TEM1KSH2xELlsJLdENxmC7bzY/b6MA5zKh1Uh4/
         Bk5w==
X-Gm-Message-State: AOAM530UT2QCWV+9UcUu+f767aV8STxl5r6ZzdwhQjkdoi5GBCslNezb
        EE+Vzk23RksqH58KjWDmNJUTTbhyKd0=
X-Google-Smtp-Source: ABdhPJzSemDUPCF4j538trDWRSQtq6/1AddLDnB2oB7/tOF2LmSayr1XykX4wpLtA0ceL72qTQshEw==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr2671700wrv.397.1611037850171;
        Mon, 18 Jan 2021 22:30:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm2870186wmj.39.2021.01.18.22.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 22:30:49 -0800 (PST)
Message-Id: <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 06:30:46 +0000
Subject: [PATCH v5 3/3] ls-files.c: add --deduplicate option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In order to provide users a better experience
when viewing information about files in the index
and the working tree, the `--deduplicate` option will suppress
some duplicate name under some conditions.

In a merge conflict, one file name of "git ls-files" output may
appear multiple times. For example,now there is an unmerged path
`a.c`,`a.c` will appear three times in the output of
"git ls-files".We can use "git ls-files --deduplicate" to output
`a.c` only one time.(unless `--stage` or `--unmerged` is
used to view all the detailed information in the index)

In addition, if you use both `--delete` and `--modify` at
the same time, The `--deduplicate` option
can also suppress file name output.

Additional instructions:
In order to display entries information,`deduplicate` suppresses
the output of duplicate file names, not the output of duplicate
entries information, so under the option of `-t`, `--stage`, `--unmerge`,
`--deduplicate` will have no effect.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-ls-files.txt |  5 +++
 builtin/ls-files.c             | 32 ++++++++++++++---
 t/t3012-ls-files-dedup.sh      | 66 ++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 5 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index cbcf5263dd0..d11c8ade402 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
 		(-[c|d|o|i|s|u|k|m])*
 		[--eol]
+		[--deduplicate]
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>]
@@ -81,6 +82,10 @@ OPTIONS
 	\0 line termination on output and do not quote filenames.
 	See OUTPUT below for more information.
 
+--deduplicate::
+	Suppress duplicate entries when there are unmerged paths in index
+	or `--deleted` and `--modified` are combined.
+
 -x <pattern>::
 --exclude=<pattern>::
 	Skip untracked files matching pattern.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1454ab1ae6f..709d727c574 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -35,6 +35,7 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
+static int skipping_duplicates;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -301,6 +302,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 {
 	int i;
 	struct strbuf fullname = STRBUF_INIT;
+	const struct cache_entry *last_shown_ce;
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
@@ -314,6 +316,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 	}
 	if (! (show_cached || show_stage || show_deleted || show_modified))
 		return;
+	last_shown_ce = NULL;
 	for (i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
 		struct stat st;
@@ -321,30 +324,46 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 
 		construct_fullname(&fullname, repo, ce);
 
+		if (skipping_duplicates && last_shown_ce &&
+			!strcmp(last_shown_ce->name,ce->name))
+				continue;
 		if ((dir->flags & DIR_SHOW_IGNORED) &&
 			!ce_excluded(dir, repo->index, fullname.buf, ce))
 			continue;
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
 		if (show_cached || show_stage) {
+			if (skipping_duplicates && last_shown_ce &&
+				!strcmp(last_shown_ce->name,ce->name))
+					continue;
 			if (!show_unmerged || ce_stage(ce))
 				show_ce(repo, dir, ce, fullname.buf,
 					ce_stage(ce) ? tag_unmerged :
 					(ce_skip_worktree(ce) ? tag_skip_worktree :
 						tag_cached));
+			if (show_cached && skipping_duplicates)
+				last_shown_ce = ce;
 		}
 		if (ce_skip_worktree(ce))
 			continue;
+		if (skipping_duplicates && last_shown_ce &&
+			!strcmp(last_shown_ce->name,ce->name))
+				continue;
 		err = lstat(fullname.buf, &st);
 		if (err) {
-			if (errno != ENOENT && errno != ENOTDIR)
-				error_errno("cannot lstat '%s'", fullname.buf);
-			if (show_deleted)
+			if (skipping_duplicates && show_deleted && show_modified)
 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified)
-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			else {
+				if (errno != ENOENT && errno != ENOTDIR)
+					error_errno("cannot lstat '%s'", fullname.buf);
+				if (show_deleted)
+					show_ce(repo, dir, ce, fullname.buf, tag_removed);
+				if (show_modified)
+					show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			}
 		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
 			show_ce(repo, dir, ce, fullname.buf, tag_modified);
+		last_shown_ce = ce;
 	}
 
 	strbuf_release(&fullname);
@@ -571,6 +590,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
+		OPT_BOOL(0,"deduplicate",&skipping_duplicates,N_("suppress duplicate entries")),
 		OPT_END()
 	};
 
@@ -610,6 +630,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		 * you also show the stage information.
 		 */
 		show_stage = 1;
+	if (show_tag || show_stage)
+		skipping_duplicates = 0;
 	if (dir.exclude_per_dir)
 		exc_given = 1;
 
diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
new file mode 100755
index 00000000000..2682b1f43a6
--- /dev/null
+++ b/t/t3012-ls-files-dedup.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description='git ls-files --deduplicate test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	>a.txt &&
+	>b.txt &&
+	>delete.txt &&
+	git add a.txt b.txt delete.txt &&
+	git commit -m base &&
+	echo a >a.txt &&
+	echo b >b.txt &&
+	echo delete >delete.txt &&
+	git add a.txt b.txt delete.txt &&
+	git commit -m tip &&
+	git tag tip &&
+	git reset --hard HEAD^ &&
+	echo change >a.txt &&
+	git commit -a -m side &&
+	git tag side
+'
+
+test_expect_success 'git ls-files --deduplicate to show unique unmerged path' '
+	test_must_fail git merge tip &&
+	git ls-files --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	a.txt
+	b.txt
+	delete.txt
+	EOF
+	test_cmp expect actual &&
+	git merge --abort
+'
+
+test_expect_success 'git ls-files -d -m --deduplicate with different display options' '
+	git reset --hard side &&
+	test_must_fail git merge tip &&
+	rm delete.txt &&
+	git ls-files -d -m --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	a.txt
+	delete.txt
+	EOF
+	test_cmp expect actual &&
+	git ls-files -d -m -t --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	C a.txt
+	C a.txt
+	C a.txt
+	R delete.txt
+	C delete.txt
+	EOF
+	test_cmp expect actual &&
+	git ls-files -d -m -c --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	a.txt
+	b.txt
+	delete.txt
+	EOF
+	test_cmp expect actual &&
+	git merge --abort
+'
+
+test_done
-- 
gitgitgadget
