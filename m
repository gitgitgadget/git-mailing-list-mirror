Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47924C4332B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281D323998
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbhAHOh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbhAHOh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 09:37:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D50C06129D
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 06:36:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a12so9200199wrv.8
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=APpCjt2Pe2F6i548+qNzvY3SI/W9CyLbFQAsontzePg=;
        b=TAokXOv+RizKUNfRwhxkQaA466uFIu6U6L806JdLB8FcMIE7/4/Gl1jfnPwsWtRZIv
         TsDbkIM3Ju3o/qKGOOfIXMiQmnVjx6kypkrUbqJsx+YX0hRngVBC0U/8Qzgp3SVYbExn
         LiIQHcZyjednb16AjMrkcNtTmAyaSzNZkW9j6tQpiFlh67Z5o3xsZIEBflgmML1nh5Tq
         rMhKCm0888KlDHc2cYntk+81ioNg2f5pXcprHIDdiA7eqibb8njvQLey+aKXztEzlEIQ
         75jc5c4OaP3dd/NNQqAzxYm0YCBOKdzyrg8ALmxvi7EGTnkWVedYL3IKm0BKH2kuVr3O
         Xq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=APpCjt2Pe2F6i548+qNzvY3SI/W9CyLbFQAsontzePg=;
        b=ePL+SPT8qJD7Bhw29UQJh5/XiNcgy8rRW7NHwVBWcAh7/kgjW+evciB87kPJUSJab1
         GZUduN2eCm1cehKZNnjhwTlgW+nKyF2pkIeXKZVwJXY5rA7ZWDfiG855QszxEj3itRxh
         IVnPLxt6cmFHKU+uGsWNdIE5t4jkLWEFDXW3pc7zZCqD6+kIMo3gAFjpHsnmk2mSeYfn
         PlgZXOYIcn3rge1D+QDHbwQzLM5DwOpn+pY8okCNbH9zXF209hk7N8b2BZl0/ekkx4tK
         +bqTM5/Wm48f6V9XoqDPtpZRcd66fgJbbg0iIanGDuFr2isGuy752JYKhy0kQh7ZXTaT
         r+EA==
X-Gm-Message-State: AOAM530eI0FvVl0sBVclAkEtKj8d/1uXYmk+YQkeE2G0WulA6OVxcLlD
        x2ijs/bBxeabjJYrEE//FvRLDOV7Pow=
X-Google-Smtp-Source: ABdhPJwo50YM07Y80xOUTQJdK8JTkvMR8ugTMEqSKXvSZG/VLnm662MN+6+Z7ajM/aWJ7WeK+GquFw==
X-Received: by 2002:a5d:40ce:: with SMTP id b14mr3902451wrq.350.1610116603231;
        Fri, 08 Jan 2021 06:36:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm12014197wmd.47.2021.01.08.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:36:42 -0800 (PST)
Message-Id: <a09a5098aa66ea0ed89fe0fcde3f016b4a65814d.1610116600.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
References: <pull.832.git.1609923182451.gitgitgadget@gmail.com>
        <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 14:36:39 +0000
Subject: [PATCH v2 2/2] builtin:ls-files.c:add git ls-file --dedup option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

This commit standardizes the code format.
For git ls-file --dedup option added
relevant descriptions in Documentation/git-ls-files.txt
and wrote t/t3012-ls-files-dedup.sh test script
to prove the correctness of--dedup option.

this patch fixed: https://github.com/gitgitgadget/git/issues/198
Thanks.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-ls-files.txt |  4 +++
 builtin/ls-files.c             | 20 ++++++-----
 t/t3012-ls-files-dedup.sh      | 63 ++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 9 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index cbcf5263dd0..41a9c5a8b27 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
 		(-[c|d|o|i|s|u|k|m])*
 		[--eol]
+		[--dedup]
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>]
@@ -81,6 +82,9 @@ OPTIONS
 	\0 line termination on output and do not quote filenames.
 	See OUTPUT below for more information.
 
+--dedup::
+	Suppress duplicates entries when conflicts happen or
+	specify -d -m at the same time.
 -x <pattern>::
 --exclude=<pattern>::
 	Skip untracked files matching pattern.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 66a7e251a46..bc4eded19ab 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -302,7 +302,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 {
 	int i;
 	struct strbuf fullname = STRBUF_INIT;
-	const struct cache_entry *last_stage=NULL;
+	const struct cache_entry *last_stage = NULL;
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
@@ -317,7 +317,8 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 	if (show_cached || show_stage) {
 		for (i = 0; i < repo->index->cache_nr; i++) {
 			const struct cache_entry *ce = repo->index->cache[i];
-			if(show_cached && delete_dup){
+
+			if (show_cached && delete_dup) {
 				switch (ce_stage(ce)) {
 				case 0:
 				default:
@@ -328,7 +329,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 					if (last_stage &&
 					!strcmp(last_stage->name, ce->name))
 						continue;
-					last_stage=ce;
+					last_stage = ce;
 				}
 			}
 			construct_fullname(&fullname, repo, ce);
@@ -351,7 +352,8 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			const struct cache_entry *ce = repo->index->cache[i];
 			struct stat st;
 			int err;
-			if(delete_dup){
+
+			if (delete_dup) {
 				switch (ce_stage(ce)) {
 				case 0:
 				default:
@@ -362,7 +364,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 					if (last_stage &&
 					!strcmp(last_stage->name, ce->name))
 						continue;
-					last_stage=ce;
+					last_stage = ce;
 				}
 			}
 			construct_fullname(&fullname, repo, ce);
@@ -375,10 +377,10 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			if (ce_skip_worktree(ce))
 				continue;
 			err = lstat(fullname.buf, &st);
-			if(delete_dup && show_deleted && show_modified && err)
+			if (delete_dup && show_deleted && show_modified && err)
 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			else{
-				if (show_deleted && err)/* you can't find it,so it's actually removed at all! */
+			else {
+				if (show_deleted && err)
 					show_ce(repo, dir, ce, fullname.buf, tag_removed);
 				if (show_modified && ie_modified(repo->index, ce, &st, 0))
 					show_ce(repo, dir, ce, fullname.buf, tag_modified);
@@ -610,7 +612,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
-		OPT_BOOL(0, "dedup", &delete_dup, N_("delete duplicate entry in index")),
+		OPT_BOOL(0, "dedup", &delete_dup, N_("suppress duplicate entries")),
 		OPT_END()
 	};
 
diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
new file mode 100755
index 00000000000..00c7f65cfc1
--- /dev/null
+++ b/t/t3012-ls-files-dedup.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='git ls-files --dedup test.
+
+This test prepares the following in the cache:
+
+    a.txt       - a file(base)
+    a.txt	- a file(master)
+    a.txt       - a file(dev)
+    b.txt       - a file
+    delete.txt  - a file
+    expect1	- a file
+    expect2	- a file
+
+'
+
+. ./test-lib.sh
+
+test_expect_success 'master branch setup and write expect1 expect2 and commit' '
+	touch a.txt &&
+	touch b.txt &&
+	touch delete.txt &&
+	cat <<-EOF >expect1 &&
+	M a.txt
+	H b.txt
+	H delete.txt
+	H expect1
+	H expect2
+	EOF
+	cat <<-EOF >expect2 &&
+	C a.txt
+	R delete.txt
+	EOF
+	git add a.txt b.txt delete.txt expect1 expect2 &&
+	git commit -m master:1
+'
+
+test_expect_success 'main commit again' '
+	echo a>a.txt &&
+	echo b>b.txt &&
+	echo delete>delete.txt &&
+	git add a.txt b.txt delete.txt &&
+	git commit -m master:2
+'
+
+test_expect_success 'dev commit' '
+	git checkout HEAD~ &&
+	git switch -c dev &&
+	echo change>a.txt &&
+	git add a.txt &&
+	git commit -m dev:1
+'
+
+test_expect_success 'dev merge master' '
+	test_must_fail git merge master &&
+	git ls-files -t --dedup >actual1 &&
+	test_cmp expect1 actual1 &&
+	rm delete.txt &&
+	git ls-files -d -m -t --dedup >actual2 &&
+	test_cmp expect2 actual2
+'
+
+test_done
-- 
gitgitgadget
