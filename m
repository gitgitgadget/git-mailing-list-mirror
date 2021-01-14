Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AF6C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 12:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD5923A55
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 12:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbhANMXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 07:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbhANMXG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 07:23:06 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3196EC061574
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 04:22:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 190so4360278wmz.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 04:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IIPK1QhBJVKfMs4crkEG7iYNeMssDEUo5bRhzJViWJY=;
        b=ZkYnwfdEv8GXv/kE6NywfCF/s5Ataqi0vMgcyD4ASL17kcOZnE1dVRwcNKtpXOUl5q
         hJSbcbEX2fsw0NFC0OMJa27eJpIKgqFlVLun7qY1yboOY39+aekuifnUtSH070MtRbQ1
         8bFk8G3VsnVdhPVl3/CpOAt6Fn05jrlwJdNunDbKDOK8RbCzXwxV5zNjg8bz4qqwA2QE
         LH+VNSiaaIyeYryjgcPu7iKy6xEW3X2LVE3VFwnW03OqWjYURY4D+pBKQtJzRH1t5ao1
         1v9jYN3d/xD8MSd8T+U7mD5WZHPsvRpDk30UsWsZ/B5+LYxywCw6+cfScV8Q59qg0dz0
         ZLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IIPK1QhBJVKfMs4crkEG7iYNeMssDEUo5bRhzJViWJY=;
        b=ugG1QBBXJKgb5Kk6f0l1az8oSe1WxatD9nBvKlY2gvaVM8uCdR2ax1rKtaL6M6zCmQ
         VWVSZelMNdQJ7B1OcNqUbf7pZzi2SmV5fCAx6THpL5zv/AwLVB4Fz7VGjbMDpIvpanWC
         u1Ue1HNFMQFhy+AkQBjfQe49BRYYFkqalgWiCGqNW/3KqWRXWWBvpt1i6UP7Op/CAeBm
         tg4cEvK6Zcb0Sam0jnzzZsLfLUKtgWPF7k3I1HgCnKprMzkuIozrk5Ow6oxGrbqDbOys
         2dyIHmH2YzjG4YbRLPEjdivSo4GhhFCj8o9Bgn5SXTulfPW4IRPycKGJhNGB7rPfOb2l
         1+Hg==
X-Gm-Message-State: AOAM533Cj1GZZycEMzFb+xkiHjSaIz9fCCWV5FRezna1aKp6/tPvDh41
        JMvPC4hIv/a/YfeyoJ6tDvv0V3dOyPM=
X-Google-Smtp-Source: ABdhPJyzUMPt30fpjXU3+Rx/6qkIOB4+HI6aBP5zyadYV5q3h60ar1WVqLkqg48hQhUYtBrEtEIi7w==
X-Received: by 2002:a7b:c259:: with SMTP id b25mr3830483wmj.40.1610626944463;
        Thu, 14 Jan 2021 04:22:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h83sm8563494wmf.9.2021.01.14.04.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 04:22:23 -0800 (PST)
Message-Id: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
References: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 14 Jan 2021 12:22:22 +0000
Subject: [PATCH v3] ls-files.c: add --dedup option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In order to provide users a better experience
when viewing information about files in the index
and the working tree, the `--dedup` option will suppress
some duplicate options under some conditions.

In a merge conflict, one item of "git ls-files" output may
appear multiple times. For example,now the file `a.c` has
a conflict,`a.c` will appear three times in the output of
"git ls-files".We can use "git ls-files --dedup" to output
`a.c` only one time.(unless `--stage` or `--unmerged` is
used to view all the detailed information in the index)

In addition, if you use both `--delete` and `--modify` in
the same time, The `--dedup` option can also suppress modified
entries output.

`--dedup` option relevant descriptions in
`Documentation/git-ls-files.txt`,
the test script in `t/t3012-ls-files-dedup.sh`
prove the correctness of the `--dedup` option.

this patch fixed:
https://github.com/gitgitgadget/git/issues/198
Thanks.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    builtin/ls-files.c:add git ls-file --dedup option
    
    I am reading the source code of git ls-files and learned that git ls
    -files may have duplicate entries when conflict occurs in a branch merge
    or when different options are used at the same time. Users may fell
    confuse when they see these duplicate entries.
    
    As Junio C Hamano said ,it have odd behaviour.
    
    Therefore, we can provide an additional option to git ls-files to delete
    those repeated information.
    
    This fixes https://github.com/gitgitgadget/git/issues/198
    
    Thanks!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-832%2Fadlternative%2Fls-files-dedup-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-832/adlternative/ls-files-dedup-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/832

Range-diff vs v2:

 1:  0261e5d245e < -:  ----------- builtin/ls-files.c:add git ls-file --dedup option
 2:  a09a5098aa6 ! 1:  5ce52c8b7a4 builtin:ls-files.c:add git ls-file --dedup option
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    builtin:ls-files.c:add git ls-file --dedup option
     +    ls-files.c: add --dedup option
      
     -    This commit standardizes the code format.
     -    For git ls-file --dedup option added
     -    relevant descriptions in Documentation/git-ls-files.txt
     -    and wrote t/t3012-ls-files-dedup.sh test script
     -    to prove the correctness of--dedup option.
     +    In order to provide users a better experience
     +    when viewing information about files in the index
     +    and the working tree, the `--dedup` option will suppress
     +    some duplicate options under some conditions.
      
     -    this patch fixed: https://github.com/gitgitgadget/git/issues/198
     +    In a merge conflict, one item of "git ls-files" output may
     +    appear multiple times. For example,now the file `a.c` has
     +    a conflict,`a.c` will appear three times in the output of
     +    "git ls-files".We can use "git ls-files --dedup" to output
     +    `a.c` only one time.(unless `--stage` or `--unmerged` is
     +    used to view all the detailed information in the index)
     +
     +    In addition, if you use both `--delete` and `--modify` in
     +    the same time, The `--dedup` option can also suppress modified
     +    entries output.
     +
     +    `--dedup` option relevant descriptions in
     +    `Documentation/git-ls-files.txt`,
     +    the test script in `t/t3012-ls-files-dedup.sh`
     +    prove the correctness of the `--dedup` option.
     +
     +    this patch fixed:
     +    https://github.com/gitgitgadget/git/issues/198
          Thanks.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     @@ Documentation/git-ls-files.txt: OPTIONS
       	See OUTPUT below for more information.
       
      +--dedup::
     -+	Suppress duplicates entries when conflicts happen or
     -+	specify -d -m at the same time.
     ++	Suppress duplicate entries when conflict happen or `--deleted`
     ++	and `--modified` are combined.
     ++
       -x <pattern>::
       --exclude=<pattern>::
       	Skip untracked files matching pattern.
      
       ## builtin/ls-files.c ##
     +@@ builtin/ls-files.c: static int line_terminator = '\n';
     + static int debug_mode;
     + static int show_eol;
     + static int recurse_submodules;
     ++static int delete_dup;
     + 
     + static const char *prefix;
     + static int max_prefix_len;
      @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
       {
       	int i;
       	struct strbuf fullname = STRBUF_INIT;
     --	const struct cache_entry *last_stage=NULL;
      +	const struct cache_entry *last_stage = NULL;
       
       	/* For cached/deleted files we don't need to even do the readdir */
       	if (show_others || show_killed) {
      @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     - 	if (show_cached || show_stage) {
       		for (i = 0; i < repo->index->cache_nr; i++) {
       			const struct cache_entry *ce = repo->index->cache[i];
     --			if(show_cached && delete_dup){
     -+
     + 
      +			if (show_cached && delete_dup) {
     - 				switch (ce_stage(ce)) {
     - 				case 0:
     - 				default:
     -@@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     - 					if (last_stage &&
     - 					!strcmp(last_stage->name, ce->name))
     - 						continue;
     --					last_stage=ce;
     ++				switch (ce_stage(ce)) {
     ++				case 0:
     ++				default:
     ++					break;
     ++				case 1:
     ++				case 2:
     ++				case 3:
     ++					if (last_stage &&
     ++					!strcmp(last_stage->name, ce->name))
     ++						continue;
      +					last_stage = ce;
     - 				}
     - 			}
     ++				}
     ++			}
       			construct_fullname(&fullname, repo, ce);
     + 
     + 			if ((dir->flags & DIR_SHOW_IGNORED) &&
      @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     - 			const struct cache_entry *ce = repo->index->cache[i];
       			struct stat st;
       			int err;
     --			if(delete_dup){
     -+
     + 
      +			if (delete_dup) {
     - 				switch (ce_stage(ce)) {
     - 				case 0:
     - 				default:
     -@@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     - 					if (last_stage &&
     - 					!strcmp(last_stage->name, ce->name))
     - 						continue;
     --					last_stage=ce;
     ++				switch (ce_stage(ce)) {
     ++				case 0:
     ++				default:
     ++					break;
     ++				case 1:
     ++				case 2:
     ++				case 3:
     ++					if (last_stage &&
     ++					!strcmp(last_stage->name, ce->name))
     ++						continue;
      +					last_stage = ce;
     - 				}
     - 			}
     ++				}
     ++			}
       			construct_fullname(&fullname, repo, ce);
     + 
     + 			if ((dir->flags & DIR_SHOW_IGNORED) &&
      @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
       			if (ce_skip_worktree(ce))
       				continue;
       			err = lstat(fullname.buf, &st);
     --			if(delete_dup && show_deleted && show_modified && err)
     +-			if (show_deleted && err)
      +			if (delete_dup && show_deleted && show_modified && err)
       				show_ce(repo, dir, ce, fullname.buf, tag_removed);
     --			else{
     --				if (show_deleted && err)/* you can't find it,so it's actually removed at all! */
     +-			if (show_modified && ie_modified(repo->index, ce, &st, 0))
     +-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
      +			else {
      +				if (show_deleted && err)
     - 					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     - 				if (show_modified && ie_modified(repo->index, ce, &st, 0))
     - 					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     ++					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     ++				if (show_modified && ie_modified(repo->index, ce, &st, 0))
     ++					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     ++			}
     + 		}
     + 	}
     + 
      @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
       			N_("pretend that paths removed since <tree-ish> are still present")),
       		OPT__ABBREV(&abbrev),
       		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
     --		OPT_BOOL(0, "dedup", &delete_dup, N_("delete duplicate entry in index")),
      +		OPT_BOOL(0, "dedup", &delete_dup, N_("suppress duplicate entries")),
       		OPT_END()
       	};
     @@ t/t3012-ls-files-dedup.sh (new)
      +
      +. ./test-lib.sh
      +
     -+test_expect_success 'master branch setup and write expect1 expect2 and commit' '
     -+	touch a.txt &&
     -+	touch b.txt &&
     -+	touch delete.txt &&
     -+	cat <<-EOF >expect1 &&
     ++test_expect_success 'setup' '
     ++	> a.txt &&
     ++	> b.txt &&
     ++	> delete.txt &&
     ++	cat >expect1<<-\EOF &&
      +	M a.txt
      +	H b.txt
      +	H delete.txt
      +	H expect1
      +	H expect2
      +	EOF
     -+	cat <<-EOF >expect2 &&
     ++	cat >expect2<<-EOF &&
      +	C a.txt
      +	R delete.txt
      +	EOF
      +	git add a.txt b.txt delete.txt expect1 expect2 &&
     -+	git commit -m master:1
     -+'
     -+
     -+test_expect_success 'main commit again' '
     ++	git commit -m master:1 &&
      +	echo a>a.txt &&
      +	echo b>b.txt &&
     -+	echo delete>delete.txt &&
     ++	echo delete >delete.txt &&
      +	git add a.txt b.txt delete.txt &&
     -+	git commit -m master:2
     -+'
     -+
     -+test_expect_success 'dev commit' '
     ++	git commit -m master:2 &&
      +	git checkout HEAD~ &&
      +	git switch -c dev &&
     -+	echo change>a.txt &&
     ++	echo change >a.txt &&
      +	git add a.txt &&
     -+	git commit -m dev:1
     -+'
     -+
     -+test_expect_success 'dev merge master' '
     ++	git commit -m dev:1 &&
      +	test_must_fail git merge master &&
      +	git ls-files -t --dedup >actual1 &&
      +	test_cmp expect1 actual1 &&


 Documentation/git-ls-files.txt |  5 ++++
 builtin/ls-files.c             | 41 ++++++++++++++++++++++++--
 t/t3012-ls-files-dedup.sh      | 54 ++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 3 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index cbcf5263dd0..0f8dbeeea20 100644
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
@@ -81,6 +82,10 @@ OPTIONS
 	\0 line termination on output and do not quote filenames.
 	See OUTPUT below for more information.
 
+--dedup::
+	Suppress duplicate entries when conflict happen or `--deleted`
+	and `--modified` are combined.
+
 -x <pattern>::
 --exclude=<pattern>::
 	Skip untracked files matching pattern.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c8eae899b82..bc4eded19ab 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -35,6 +35,7 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
+static int delete_dup;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -301,6 +302,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 {
 	int i;
 	struct strbuf fullname = STRBUF_INIT;
+	const struct cache_entry *last_stage = NULL;
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
@@ -316,6 +318,20 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 		for (i = 0; i < repo->index->cache_nr; i++) {
 			const struct cache_entry *ce = repo->index->cache[i];
 
+			if (show_cached && delete_dup) {
+				switch (ce_stage(ce)) {
+				case 0:
+				default:
+					break;
+				case 1:
+				case 2:
+				case 3:
+					if (last_stage &&
+					!strcmp(last_stage->name, ce->name))
+						continue;
+					last_stage = ce;
+				}
+			}
 			construct_fullname(&fullname, repo, ce);
 
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
@@ -337,6 +353,20 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			struct stat st;
 			int err;
 
+			if (delete_dup) {
+				switch (ce_stage(ce)) {
+				case 0:
+				default:
+					break;
+				case 1:
+				case 2:
+				case 3:
+					if (last_stage &&
+					!strcmp(last_stage->name, ce->name))
+						continue;
+					last_stage = ce;
+				}
+			}
 			construct_fullname(&fullname, repo, ce);
 
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
@@ -347,10 +377,14 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			if (ce_skip_worktree(ce))
 				continue;
 			err = lstat(fullname.buf, &st);
-			if (show_deleted && err)
+			if (delete_dup && show_deleted && show_modified && err)
 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified && ie_modified(repo->index, ce, &st, 0))
-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			else {
+				if (show_deleted && err)
+					show_ce(repo, dir, ce, fullname.buf, tag_removed);
+				if (show_modified && ie_modified(repo->index, ce, &st, 0))
+					show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			}
 		}
 	}
 
@@ -578,6 +612,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
+		OPT_BOOL(0, "dedup", &delete_dup, N_("suppress duplicate entries")),
 		OPT_END()
 	};
 
diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
new file mode 100755
index 00000000000..aec7d364235
--- /dev/null
+++ b/t/t3012-ls-files-dedup.sh
@@ -0,0 +1,54 @@
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
+test_expect_success 'setup' '
+	> a.txt &&
+	> b.txt &&
+	> delete.txt &&
+	cat >expect1<<-\EOF &&
+	M a.txt
+	H b.txt
+	H delete.txt
+	H expect1
+	H expect2
+	EOF
+	cat >expect2<<-EOF &&
+	C a.txt
+	R delete.txt
+	EOF
+	git add a.txt b.txt delete.txt expect1 expect2 &&
+	git commit -m master:1 &&
+	echo a>a.txt &&
+	echo b>b.txt &&
+	echo delete >delete.txt &&
+	git add a.txt b.txt delete.txt &&
+	git commit -m master:2 &&
+	git checkout HEAD~ &&
+	git switch -c dev &&
+	echo change >a.txt &&
+	git add a.txt &&
+	git commit -m dev:1 &&
+	test_must_fail git merge master &&
+	git ls-files -t --dedup >actual1 &&
+	test_cmp expect1 actual1 &&
+	rm delete.txt &&
+	git ls-files -d -m -t --dedup >actual2 &&
+	test_cmp expect2 actual2
+'
+
+test_done

base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
-- 
gitgitgadget
