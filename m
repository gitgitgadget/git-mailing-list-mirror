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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B295C433E6
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2FA22D75
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbhAQEDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 23:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbhAQEDC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 23:03:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558C9C061575
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 20:02:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d26so13187278wrb.12
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 20:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6o4Oz/RkQvQ79EakYxJyr7MZFX/3a+ZB/tpEJIVrm9A=;
        b=UOY+vp9XXiv5FhrAp9y+DvRyd1BzZnwufBVNSFkQ/VpPM4n47ZgD72L/CCSXF2i8AX
         LW51mPskQ3v6zGYyA08pj/BZwdZkClEH2RQvy8c5iPmyrn2RfCxhOC9b/w6oo9fwKnwu
         5HjinM/NV68b5nbWUPxapOnrTUEB91XU4Y3TfyxmhKDNCuGbdFu5fD7CcNyHTH4BQm40
         FJTCdFRW/h3ID0dXwzj6AGr10E59F/ULdittzY6DaNThU3VD4wpwJ+iPZ1vkC6NAKvlR
         RraCROkDTjSnBJEMVFCXwQJX5g6dHwdss2HW6Lx74hVjevEvbDx09gJG7DxDXpWRrY9y
         CtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6o4Oz/RkQvQ79EakYxJyr7MZFX/3a+ZB/tpEJIVrm9A=;
        b=T5cdWEcF4BhtW6GAlnmQVHr8mrc0Tjc9zvGdKcx07Lv1qe+VP54ZYSBL42F7NVvMVI
         vMX7RsZHC3XByR4hFJfA0HATZiryF0zrer5dTxQXFPZpMP3PhZmL8pW0OL1zfFajStWO
         MsDTIwzqBEUaUA2YX9sI8EEEK3yexm+/o8AG6B991T60qpskZNkUQ7WqEukuvffD1kSg
         oR11IcEJEkHYVLbHveCMSG/LYFePwaMbkSXQ8RhpX7HhcsX5RJcG3QOFZqw7EMVn6OXh
         rQeHP7dZ35mawKdTt1BE4u5WLLhNH7HBz5WXvorD1qfw8T2A/9fkDeShQSAECcriu140
         u5kg==
X-Gm-Message-State: AOAM531xtEHGY/XWVqVPj0z0QfeF1URBo8x8ztQSUUb3FB86rsEbH5mc
        SZwLkIHYeLDShbdpzzi6Hrvu55xlqu8=
X-Google-Smtp-Source: ABdhPJwuGkzJFof5sd9Zcuf0iqd9/1YKRPKo26xo4ROnDTfyf2kN8ZxIwfCUTlJU0cSvbikM2r1MOA==
X-Received: by 2002:adf:902a:: with SMTP id h39mr19967013wrh.147.1610856139879;
        Sat, 16 Jan 2021 20:02:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm21629120wrh.78.2021.01.16.20.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 20:02:19 -0800 (PST)
Message-Id: <0c7830d07db0aa1ec055b97de52bd873d05e3ab1.1610856136.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
References: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
        <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Jan 2021 04:02:16 +0000
Subject: [PATCH v4 3/3] ls-files: add --deduplicate option
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
 builtin/ls-files.c             | 23 +++++++++++++-
 t/t3012-ls-files-dedup.sh      | 57 ++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
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
index 49c242128d7..390d7ef6b44 100644
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
@@ -321,28 +324,43 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 
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
+			if (show_cached && skipping_duplicates && last_shown_ce &&
+				!strcmp(last_shown_ce->name,ce->name))
+					continue;
 			if (!show_unmerged || ce_stage(ce))
 				show_ce(repo, dir, ce, fullname.buf,
 					ce_stage(ce) ? tag_unmerged :
 					(ce_skip_worktree(ce) ? tag_skip_worktree :
 						tag_cached));
+			if(show_cached && skipping_duplicates)
+				last_shown_ce = ce;
 		}
 		if (ce_skip_worktree(ce))
 			continue;
+		if (skipping_duplicates && last_shown_ce && !strcmp(last_shown_ce->name,ce->name))
+			continue;
 		err = lstat(fullname.buf, &st);
 		if (err) {
+			if (skipping_duplicates && show_deleted && show_modified)
+				show_ce(repo, dir, ce, fullname.buf, tag_removed);
+			else {
 				if (show_deleted)
 					show_ce(repo, dir, ce, fullname.buf, tag_removed);
 				if (show_modified)
 					show_ce(repo, dir, ce, fullname.buf, tag_modified);
-		}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
+			}
+		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
 			show_ce(repo, dir, ce, fullname.buf, tag_modified);
+		last_shown_ce = ce;
 	}
 
 	strbuf_release(&fullname);
@@ -569,6 +587,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
+		OPT_BOOL(0,"deduplicate",&skipping_duplicates,N_("suppress duplicate entries")),
 		OPT_END()
 	};
 
@@ -600,6 +619,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		tag_skip_worktree = "S ";
 		tag_resolve_undo = "U ";
 	}
+	if (show_tag && skipping_duplicates)
+		skipping_duplicates = 0;
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_SHOW_IGNORED) || show_killed)
 		require_work_tree = 1;
 	if (show_unmerged)
diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
new file mode 100755
index 00000000000..75877255c2c
--- /dev/null
+++ b/t/t3012-ls-files-dedup.sh
@@ -0,0 +1,57 @@
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
+	git commit -m master:1 &&
+	echo a >a.txt &&
+	echo b >b.txt &&
+	echo delete >delete.txt &&
+	git add a.txt b.txt delete.txt &&
+	git commit -m master:2 &&
+	git checkout HEAD~ &&
+	git switch -c dev &&
+	test_when_finished "git switch master" &&
+	echo change >a.txt &&
+	git add a.txt &&
+	git commit -m dev:1 &&
+	test_must_fail git merge master &&
+	git ls-files --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	a.txt
+	b.txt
+	delete.txt
+	EOF
+	test_cmp expect actual &&
+	rm delete.txt &&
+	git ls-files -d -m --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	a.txt
+	delete.txt
+	EOF
+	test_cmp expect actual &&
+	git ls-files -d -m -t  --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	C a.txt
+	C a.txt
+	C a.txt
+	R delete.txt
+	C delete.txt
+	EOF
+	test_cmp expect actual &&
+	git ls-files -d -m -c  --deduplicate >actual &&
+	cat >expect <<-\EOF &&
+	a.txt
+	b.txt
+	delete.txt
+	EOF
+	test_cmp expect actual &&
+	git merge --abort
+'
+test_done
-- 
gitgitgadget
