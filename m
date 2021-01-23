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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE30CC43381
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD38E22CB9
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 10:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbhAWKVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 05:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbhAWKU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 05:20:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59301C061788
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 02:20:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d16so6757578wro.11
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 02:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vEVENNNpbmySzxgjx7egSqd+3wSZ8cqTS1wYFXizouI=;
        b=Ap7xSqHV+zQa5iKN/Jkc338Ir9+ELRzW11aMuksTGX2bL5wIXFcgPZIKmkHAPB8UPu
         tBTbk8qL8GKsHMJGgxYtHI8NdxRbVCtul0/JsIXNRC5+ar2C1NC0ssQBNHheAp6LrDFj
         yK7VeTr1KuRkYX7PGMdvxeQM/2jll5Utgmk2/2cMPTeYM2zDKn7kMLMznJmxs6hLkw4S
         wuDrPPJiq48qUwFxrY0IcC4OiKoQbo/wtlgb4rKRsUkOVVrCNRFm5npOxP1MsxBUgiwH
         IcTK1T1gD1rM+kfY1IxVRy3AILl4o9uqgnNmcIdpp0axpdisab26+onfTAgdnJhZXpvZ
         Z5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vEVENNNpbmySzxgjx7egSqd+3wSZ8cqTS1wYFXizouI=;
        b=svzHhNzptMI4QyMzEJrn7WHraAcNK8ESwZnDBeGHZJYgAImTo5/I9yszKMIpFO1HV4
         Mam2Zh3uimcJBF6EOGovXIGJggd/UM4zpAURxRQuZ4grHDeA9eOTDlIYGC4nXHUpwLTs
         DnYocQmwOGDtAje81qydwbrm4ZCncDlq2TeyN0kV0RHkxlNzvw8PYZncmxLywsnHXr9p
         H0EXMYSjlR8yPKkpeeTcWmPFQVvia6edcXAyNkDVARh+GaaEV2d5lzI1CieRvkFhWtqW
         VUdkqeIlLUHaMRMfHL1s3ARq29mIaSOKx4cF1btesA6QVtuho+ESKusq7/b6N4Tly/Bc
         YjvQ==
X-Gm-Message-State: AOAM530EQ/4HU9VugxJbDEk7UrC6jmuyMeWc00x5zr3n86trojxFHj+4
        kPavJonPTRV4QLSarwdGrD2uL/bki4c=
X-Google-Smtp-Source: ABdhPJwNNp3epElKLyCW8sqSsbW/2+cKykkYqjrcvZKlDftjNqhRxEsZulHIDTUsapqanEI9lpKUyg==
X-Received: by 2002:a05:6000:1374:: with SMTP id q20mr8286475wrz.44.1611397214928;
        Sat, 23 Jan 2021 02:20:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm15766469wrw.61.2021.01.23.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 02:20:14 -0800 (PST)
Message-Id: <07b603fd97c0e2d7a70407da552c3c0658a84731.1611397210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
References: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 10:20:10 +0000
Subject: [PATCH v6 3/3] ls-files.c: add --deduplicate option
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
 builtin/ls-files.c             | 30 +++++++++++++---
 t/t3012-ls-files-dedup.sh      | 66 ++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 4 deletions(-)
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
