Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F42C433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE94E23A68
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 17:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbhAVR1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 12:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbhAVPqr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 10:46:47 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3189BC0613D6
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 07:46:07 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id md11so3938464pjb.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 07:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBGVM9eZzF2e2HX5rJNNNDobuio75JvWA/pvLW/sZlY=;
        b=cKkEx7MftMyjQrYFUgQkx0HwxJKKB3saUueJWqWzuJFy509sU7FXtSkxxzJ2AMAkwq
         VGzwGrScPkIM00e/KaW1xTtNExQjQHoAKA8ptUomtHfupYKS0fYoUpFmawLGjzi9qZRQ
         s+946jyy6CGHczMU3O5kmpm2YBTa28YvRP6989ScpIJuw9gy1W1R4XowT3Z3Gr9+C7ue
         VwiQ4lXw9A2+ABIL6JtAFT5/2voEuPAiqp2Qv1JE3mFpTOVyIaak0zDg5NCppau2Jzjh
         ND/5UcSfr1jT5IR5e6GnGW7a6jW+A2gPhVF7uQvg4BwRsKHHFX9o+/IL7e5Wro/nXqym
         s9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBGVM9eZzF2e2HX5rJNNNDobuio75JvWA/pvLW/sZlY=;
        b=WOPNckcwhJyIwMOtarnrgbjG711144Igdp7vNjGhcfAIE5Q4Hn6J3ZILhNwXrCQVFB
         ge3o8P3Z0Wi0BSRPUuciiZESA6KvmN8NcvzFHPYzRA4fdfYUq5qR/WKTazWWqH85a9By
         o8BFAFeTu/+l1Tk8D4gijz1uQj1/8CuVZ/lijUyVLlNpaw7gtoBSXHOdqJ/7hI1I0TBk
         BxmZua63sdtXGx71iRdvdOEC1maQmypZTM4DprAUnk+9ERGxVwE4snxRS6w6eazuT+iB
         gr22xxQJLgv5IAK3u3WdYg1+IyNf4JtrqXOGWSypEiQPPawGSg5s15muucFjLG09+87z
         IxXA==
X-Gm-Message-State: AOAM533bX2rxGdePYDmZRKzsKP6dP/aTcxRoEtFoCLxSXcWCpPxmnbe8
        URLcLnPHJU+UFsWV1g6hWXVWp7ipt88ayv+u
X-Google-Smtp-Source: ABdhPJyclCPLtOeppXMN6m+vv5x+FwqQcIfsS5rkfY1wCjTwaCAYh1EoPXJQ7rf+uVwyjIcDAL+FmQ==
X-Received: by 2002:a17:90a:578a:: with SMTP id g10mr1123776pji.74.1611330366444;
        Fri, 22 Jan 2021 07:46:06 -0800 (PST)
Received: from localhost.localdomain ([45.152.112.90])
        by smtp.gmail.com with ESMTPSA id c17sm8587585pfi.88.2021.01.22.07.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 07:46:05 -0800 (PST)
From:   ZheNing Hu <adlternative@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>
Subject: [PATCH v6] ls-files.c: add --deduplicate option
Date:   Fri, 22 Jan 2021 23:46:40 +0800
Message-Id: <20210122154640.3791035-1-adlternative@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
References: <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-files.txt |  5 +++
 builtin/ls-files.c             | 46 +++++++++++++++++-------
 t/t3012-ls-files-dedup.sh      | 66 ++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 12 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0a3b5265b3..a05f063d3d 100644
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
@@ -80,6 +81,10 @@ OPTIONS
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
index 1454ab1ae6..e67dc1ff45 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -35,6 +35,7 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
+static int skipping_duplicates;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -317,7 +318,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 	for (i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
 		struct stat st;
-		int err;
+		int stat_err;
 
 		construct_fullname(&fullname, repo, ce);
 
@@ -326,25 +327,43 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
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
+			if (show_cached && skipping_duplicates)
+				goto skip_to_next_name;
 		}
+		if (!show_deleted && !show_modified)
+			continue;
 		if (ce_skip_worktree(ce))
 			continue;
-		err = lstat(fullname.buf, &st);
-		if (err) {
-			if (errno != ENOENT && errno != ENOTDIR)
-				error_errno("cannot lstat '%s'", fullname.buf);
-			if (show_deleted)
-				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified)
+		stat_err = lstat(fullname.buf, &st);
+		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
+			error_errno("cannot lstat '%s'", fullname.buf);
+		if (stat_err && show_deleted) {
+			show_ce(repo, dir, ce, fullname.buf, tag_removed);
+			if (skipping_duplicates)
+				goto skip_to_next_name;
+		}
+		if (show_modified &&
+			(stat_err || ie_modified(repo->index, ce, &st, 0))) {
 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
-		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
-			show_ce(repo, dir, ce, fullname.buf, tag_modified);
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
index 0000000000..2682b1f43a
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
2.30.0

