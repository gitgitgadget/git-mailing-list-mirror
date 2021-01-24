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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDC6C43381
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC72D22C9F
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbhAXKzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 05:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbhAXKzN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 05:55:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73A7C061756
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:54:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v15so9353471wrx.4
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M/0mF3GJ/1thOc+OSAkq3zbwHYXXe4X21U17XOHJvdE=;
        b=myrLsMKOk9oSMs2qGYvfpf4rxiOoeY5yxeIdpzjFzg+41kEsVsEf938cdnFLSKUiBV
         OWoxwl0JEHLzsliUnU/3vGJNZINahGemli813m8crF+fLyJi5b5P4ml3wZEGE5X0O6PR
         qzNM55395HJkNLOoCDlm3qGnROF7bI5preR/azVZ8f8kWEJH3u9EqeWcUFQ1q6RnkepS
         le+KReY0kM5qaavGI8+HxErAmJJBHukLBO5pJ6mN+qG2eZztLGx2IznFur8+bvMYzd89
         6KMXOyN8UW14nMQAGkNyIbmr/yupPiT+/3oa3jqO078LxkdL7SFQVGRf7+obDI31ntEb
         /l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M/0mF3GJ/1thOc+OSAkq3zbwHYXXe4X21U17XOHJvdE=;
        b=UJfZX/bCmgvX3pFBE6C5s+RKH/kwgvWv38lyJRbP3U4qiksnDp+HSzgBrB7wEvbvQT
         SEIjPclkiJoF03HS8uyNLn804qZyPlAD+rBRUlKRnfDvtsN8aJ20YUwbPDOrEm2dqA14
         BxcHXeoDhoN37IUeyqNx4GkKDLeK3+OFeFL/MFGL+v6mXOYbBtTcReKakucw5QKHz+JF
         nJh2kojHu9ZIC1Yi6GgGCyzGPXsCHJ+XNiMGu248f93rrtj5kZBb6c0Y5Xhnlu1Zlq+n
         ecHiCT3i8igtpbCBH5cyVnIYQ2dh9ukUeK/+QS6Gs0uw4P/dFvVExShf0SLsqqvQn59f
         m9zA==
X-Gm-Message-State: AOAM532wodlRhNumUt28Ye2vavnvin22kwFmdVBZPGeb1NupbmOQqmKR
        LE6w+9D/HXFrAQZHRmoTvh90JDi+x7Q=
X-Google-Smtp-Source: ABdhPJzA7ikFDeZymsYHXwoSVvjo0ZW61r2fEb8PSFjr6hbzOZrHxq0h+6nLUneLdIqSkRyJ4uogWg==
X-Received: by 2002:a05:6000:1374:: with SMTP id q20mr1795887wrz.44.1611485671248;
        Sun, 24 Jan 2021 02:54:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm18579343wru.33.2021.01.24.02.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 02:54:30 -0800 (PST)
Message-Id: <384f77a4c188456854bd86335e9bdc8018097a5f.1611485667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v7.git.1611485667.gitgitgadget@gmail.com>
References: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
        <pull.832.v7.git.1611485667.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Jan 2021 10:54:27 +0000
Subject: [PATCH v7 3/3] ls-files.c: add --deduplicate option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

During a merge conflict, the name of a file may appear multiple
times in "git ls-files" output, once for each stage.  If you use
both `--delete` and `--modify` at the same time, the output may
mention a deleted file twice.

When none of the '-t', '-u', or '-s' options is in use, these
duplicate entries do not add much value to the output.

Introduce a new '--deduplicate' option to suppress them.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
[jc: extended doc and rewritten commit log]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-files.txt |  8 +++++
 builtin/ls-files.c             | 30 +++++++++++++---
 t/t3012-ls-files-dedup.sh      | 66 ++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 4 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index cbcf5263dd0..60449a69b69 100644
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
@@ -81,6 +82,13 @@ OPTIONS
 	\0 line termination on output and do not quote filenames.
 	See OUTPUT below for more information.
 
+--deduplicate::
+	When only filenames are shown, suppress duplicates that may
+	come from having multiple stages during a merge, or giving
+	`--deleted` and `--modified` option at the same time.
+	When any of the `-t`, `--unmerged`, or `--stage` option is
+	in use, this option has no effect.
+
 -x <pattern>::
 --exclude=<pattern>::
 	Skip untracked files matching pattern.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 966c0ab0296..fb9cf50d764 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -35,6 +35,7 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
+static int skipping_duplicates;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -326,12 +327,14 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			continue;
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
-		if (show_cached || show_stage) {
-			if (!show_unmerged || ce_stage(ce))
+		if ((show_cached || show_stage) &&
+			(!show_unmerged || ce_stage(ce))) {
 				show_ce(repo, dir, ce, fullname.buf,
 					ce_stage(ce) ? tag_unmerged :
 					(ce_skip_worktree(ce) ? tag_skip_worktree :
 						tag_cached));
+			if (skipping_duplicates)
+				goto skip_to_next_name;
 		}
 		if (!show_deleted && !show_modified)
 			continue;
@@ -340,11 +343,27 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 		stat_err = lstat(fullname.buf, &st);
 		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
 			error_errno("cannot lstat '%s'", fullname.buf);
-		if (stat_err && show_deleted)
+		if (stat_err && show_deleted) {
 			show_ce(repo, dir, ce, fullname.buf, tag_removed);
+			if (skipping_duplicates)
+				goto skip_to_next_name;
+		}
 		if (show_modified &&
-			(stat_err || ie_modified(repo->index, ce, &st, 0)))
+			(stat_err || ie_modified(repo->index, ce, &st, 0))) {
 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			if (skipping_duplicates)
+				goto skip_to_next_name;
+		}
+		continue;
+skip_to_next_name:
+		{
+			int j;
+			struct cache_entry **cache = repo->index->cache;
+			for (j = i + 1; j < repo->index->cache_nr; j++)
+				if (strcmp(ce->name, cache[j]->name))
+					break;
+			i = j - 1; /* compensate for outer for loop */
+		}
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
