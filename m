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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D1C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC7A22D75
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbhAQEDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 23:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbhAQEDA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 23:03:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843AFC061573
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 20:02:19 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k10so10652703wmi.3
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 20:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FAtAsVJcowxoEPvby7LAoB4PRbr0O6RQ++Quza87BcA=;
        b=h6L9h/I7Xt/QmPmESRMBeHoUc5/O6PiZZjI9qsZCzvDmcXE4C4zp8ZrCW+0aGoVuv6
         v8P+GkH5Nf4Te/LzlKkX+vCpZuiboPiMh8brJaRH22Rb2Y379eCcfWcUFscWk90NiNG6
         kviy1iLOa1OIjO8mVpnFKihGuHBHGKVrocTgEThLpt6nmSE3SsWh/VYf9CFfFaz3xlPl
         HX6qYgmIOWxiU6uOS5fICyaSJW/OPCLsRi69RJy1mc+TwMQFKXIP7+4BzNBMpYf8PDK5
         df+VqrCZ3doTv6mEFKCC/26gNnDOsc0gjkNFg1ETqumiM1bc/QEWi5Ym5U55q8BMeOoN
         Rivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FAtAsVJcowxoEPvby7LAoB4PRbr0O6RQ++Quza87BcA=;
        b=lfxhpSXPBMNA7n6Rez5cu9Vdr6e8gqzExjW+dASUSbe/mfWYiy+wo6tcnbzHuCM+Kk
         jC5fsxD+zZR2MUvSkTB5VYcQPbG1CMCpNG3ml/T2Zxupk2QEoyU1Ug9HGhPZDp6rjySM
         NBmSLlJaulbeVMrTm6Pzdf+oGIQCZ1voUFCDulYWYKWGGI/Z5i55JMqytClBr+Qcfw4h
         YDI+Wn263tsnuvRl1HMAWysOMP64RfkAKVHYb8REGEGKG/PmrSB4yvLRkvSxieaTwKol
         WTTvITcbPIwbRboOwRJph1CNJGHwEjMXS55R6uaG3QZ1hwhostP6SzwgsowKaXkfpBhB
         cVLw==
X-Gm-Message-State: AOAM530mnYjtMaxuMYuXTGkdOnFYr3rfZn659JF/LkX6rFI8RfjV3loM
        UrUC2ThXhmK6ubpKxa+tCOURD3JCnaM=
X-Google-Smtp-Source: ABdhPJw8m/ibxKQ1X9ON3PtT4Sru/KkVZ2+eWXXdsUEucKuIz3zNLBy5eZECzYJXIyXKMbWQSPtlkA==
X-Received: by 2002:a7b:ce02:: with SMTP id m2mr14740945wmc.111.1610856137646;
        Sat, 16 Jan 2021 20:02:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm21798688wrn.83.2021.01.16.20.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 20:02:17 -0800 (PST)
Message-Id: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
References: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 17 Jan 2021 04:02:13 +0000
Subject: [PATCH v4 0/3] builtin/ls-files.c:add git ls-file --dedup option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am reading the source code of git ls-files and learned that git ls-files
may have duplicate files name when there are unmerged path in a branch merge
or when different options are used at the same time. Users may fell confuse
when they see these duplicate file names.

As Junio C Hamano said ,it have odd behaviour.

Therefore, we can provide an additional option to git ls-files to delete
those repeated information.

This fixes https://github.com/gitgitgadget/git/issues/198

Thanks!

ZheNing Hu (3):
  ls_files.c: bugfix for --deleted and --modified
  ls_files.c: consolidate two for loops into one
  ls-files: add --deduplicate option

 Documentation/git-ls-files.txt |  5 +++
 builtin/ls-files.c             | 82 +++++++++++++++++++---------------
 t/t3012-ls-files-dedup.sh      | 57 +++++++++++++++++++++++
 3 files changed, 109 insertions(+), 35 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh


base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-832%2Fadlternative%2Fls-files-dedup-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-832/adlternative/ls-files-dedup-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/832

Range-diff vs v3:

 -:  ----------- > 1:  f4d9af8a312 ls_files.c: bugfix for --deleted and --modified
 -:  ----------- > 2:  50efd9b45b1 ls_files.c: consolidate two for loops into one
 1:  5ce52c8b7a4 ! 3:  0c7830d07db ls-files.c: add --dedup option
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    ls-files.c: add --dedup option
     +    ls-files: add --deduplicate option
      
          In order to provide users a better experience
          when viewing information about files in the index
     -    and the working tree, the `--dedup` option will suppress
     -    some duplicate options under some conditions.
     +    and the working tree, the `--deduplicate` option will suppress
     +    some duplicate name under some conditions.
      
     -    In a merge conflict, one item of "git ls-files" output may
     -    appear multiple times. For example,now the file `a.c` has
     -    a conflict,`a.c` will appear three times in the output of
     -    "git ls-files".We can use "git ls-files --dedup" to output
     +    In a merge conflict, one file name of "git ls-files" output may
     +    appear multiple times. For example,now there is an unmerged path
     +    `a.c`,`a.c` will appear three times in the output of
     +    "git ls-files".We can use "git ls-files --deduplicate" to output
          `a.c` only one time.(unless `--stage` or `--unmerged` is
          used to view all the detailed information in the index)
      
     -    In addition, if you use both `--delete` and `--modify` in
     -    the same time, The `--dedup` option can also suppress modified
     -    entries output.
     +    In addition, if you use both `--delete` and `--modify` at
     +    the same time, The `--deduplicate` option
     +    can also suppress file name output.
      
     -    `--dedup` option relevant descriptions in
     -    `Documentation/git-ls-files.txt`,
     -    the test script in `t/t3012-ls-files-dedup.sh`
     -    prove the correctness of the `--dedup` option.
     -
     -    this patch fixed:
     -    https://github.com/gitgitgadget/git/issues/198
     -    Thanks.
     +    Additional instructions:
     +    In order to display entries information,`deduplicate` suppresses
     +    the output of duplicate file names, not the output of duplicate
     +    entries information, so under the option of `-t`, `--stage`, `--unmerge`,
     +    `--deduplicate` will have no effect.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-ls-files.txt: SYNOPSIS
       		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
       		(-[c|d|o|i|s|u|k|m])*
       		[--eol]
     -+		[--dedup]
     ++		[--deduplicate]
       		[-x <pattern>|--exclude=<pattern>]
       		[-X <file>|--exclude-from=<file>]
       		[--exclude-per-directory=<file>]
     @@ Documentation/git-ls-files.txt: OPTIONS
       	\0 line termination on output and do not quote filenames.
       	See OUTPUT below for more information.
       
     -+--dedup::
     -+	Suppress duplicate entries when conflict happen or `--deleted`
     -+	and `--modified` are combined.
     ++--deduplicate::
     ++	Suppress duplicate entries when there are unmerged paths in index
     ++	or `--deleted` and `--modified` are combined.
      +
       -x <pattern>::
       --exclude=<pattern>::
     @@ builtin/ls-files.c: static int line_terminator = '\n';
       static int debug_mode;
       static int show_eol;
       static int recurse_submodules;
     -+static int delete_dup;
     ++static int skipping_duplicates;
       
       static const char *prefix;
       static int max_prefix_len;
     @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_s
       {
       	int i;
       	struct strbuf fullname = STRBUF_INIT;
     -+	const struct cache_entry *last_stage = NULL;
     ++	const struct cache_entry *last_shown_ce;
       
       	/* For cached/deleted files we don't need to even do the readdir */
       	if (show_others || show_killed) {
      @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     - 		for (i = 0; i < repo->index->cache_nr; i++) {
     - 			const struct cache_entry *ce = repo->index->cache[i];
     - 
     -+			if (show_cached && delete_dup) {
     -+				switch (ce_stage(ce)) {
     -+				case 0:
     -+				default:
     -+					break;
     -+				case 1:
     -+				case 2:
     -+				case 3:
     -+					if (last_stage &&
     -+					!strcmp(last_stage->name, ce->name))
     -+						continue;
     -+					last_stage = ce;
     -+				}
     -+			}
     - 			construct_fullname(&fullname, repo, ce);
     - 
     - 			if ((dir->flags & DIR_SHOW_IGNORED) &&
     + 	}
     + 	if (! (show_cached || show_stage || show_deleted || show_modified))
     + 		return;
     ++	last_shown_ce = NULL;
     + 	for (i = 0; i < repo->index->cache_nr; i++) {
     + 		const struct cache_entry *ce = repo->index->cache[i];
     + 		struct stat st;
      @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     - 			struct stat st;
     - 			int err;
       
     -+			if (delete_dup) {
     -+				switch (ce_stage(ce)) {
     -+				case 0:
     -+				default:
     -+					break;
     -+				case 1:
     -+				case 2:
     -+				case 3:
     -+					if (last_stage &&
     -+					!strcmp(last_stage->name, ce->name))
     -+						continue;
     -+					last_stage = ce;
     -+				}
     -+			}
     - 			construct_fullname(&fullname, repo, ce);
     + 		construct_fullname(&fullname, repo, ce);
       
     - 			if ((dir->flags & DIR_SHOW_IGNORED) &&
     -@@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     - 			if (ce_skip_worktree(ce))
     - 				continue;
     - 			err = lstat(fullname.buf, &st);
     --			if (show_deleted && err)
     -+			if (delete_dup && show_deleted && show_modified && err)
     - 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
     --			if (show_modified && ie_modified(repo->index, ce, &st, 0))
     --				show_ce(repo, dir, ce, fullname.buf, tag_modified);
     ++		if (skipping_duplicates && last_shown_ce &&
     ++			!strcmp(last_shown_ce->name,ce->name))
     ++				continue;
     + 		if ((dir->flags & DIR_SHOW_IGNORED) &&
     + 			!ce_excluded(dir, repo->index, fullname.buf, ce))
     + 			continue;
     + 		if (ce->ce_flags & CE_UPDATE)
     + 			continue;
     + 		if (show_cached || show_stage) {
     ++			if (show_cached && skipping_duplicates && last_shown_ce &&
     ++				!strcmp(last_shown_ce->name,ce->name))
     ++					continue;
     + 			if (!show_unmerged || ce_stage(ce))
     + 				show_ce(repo, dir, ce, fullname.buf,
     + 					ce_stage(ce) ? tag_unmerged :
     + 					(ce_skip_worktree(ce) ? tag_skip_worktree :
     + 						tag_cached));
     ++			if(show_cached && skipping_duplicates)
     ++				last_shown_ce = ce;
     + 		}
     + 		if (ce_skip_worktree(ce))
     + 			continue;
     ++		if (skipping_duplicates && last_shown_ce && !strcmp(last_shown_ce->name,ce->name))
     ++			continue;
     + 		err = lstat(fullname.buf, &st);
     + 		if (err) {
     ++			if (skipping_duplicates && show_deleted && show_modified)
     ++				show_ce(repo, dir, ce, fullname.buf, tag_removed);
      +			else {
     -+				if (show_deleted && err)
     -+					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     -+				if (show_modified && ie_modified(repo->index, ce, &st, 0))
     -+					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     + 				if (show_deleted)
     + 					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     + 				if (show_modified)
     + 					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     +-		}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
      +			}
     - 		}
     ++		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
     + 			show_ce(repo, dir, ce, fullname.buf, tag_modified);
     ++		last_shown_ce = ce;
       	}
       
     + 	strbuf_release(&fullname);
      @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
       			N_("pretend that paths removed since <tree-ish> are still present")),
       		OPT__ABBREV(&abbrev),
       		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
     -+		OPT_BOOL(0, "dedup", &delete_dup, N_("suppress duplicate entries")),
     ++		OPT_BOOL(0,"deduplicate",&skipping_duplicates,N_("suppress duplicate entries")),
       		OPT_END()
       	};
       
     +@@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
     + 		tag_skip_worktree = "S ";
     + 		tag_resolve_undo = "U ";
     + 	}
     ++	if (show_tag && skipping_duplicates)
     ++		skipping_duplicates = 0;
     + 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_SHOW_IGNORED) || show_killed)
     + 		require_work_tree = 1;
     + 	if (show_unmerged)
      
       ## t/t3012-ls-files-dedup.sh (new) ##
      @@
      +#!/bin/sh
      +
     -+test_description='git ls-files --dedup test.
     -+
     -+This test prepares the following in the cache:
     -+
     -+    a.txt       - a file(base)
     -+    a.txt	- a file(master)
     -+    a.txt       - a file(dev)
     -+    b.txt       - a file
     -+    delete.txt  - a file
     -+    expect1	- a file
     -+    expect2	- a file
     -+
     -+'
     ++test_description='git ls-files --deduplicate test'
      +
      +. ./test-lib.sh
      +
      +test_expect_success 'setup' '
     -+	> a.txt &&
     -+	> b.txt &&
     -+	> delete.txt &&
     -+	cat >expect1<<-\EOF &&
     -+	M a.txt
     -+	H b.txt
     -+	H delete.txt
     -+	H expect1
     -+	H expect2
     -+	EOF
     -+	cat >expect2<<-EOF &&
     -+	C a.txt
     -+	R delete.txt
     -+	EOF
     -+	git add a.txt b.txt delete.txt expect1 expect2 &&
     ++	>a.txt &&
     ++	>b.txt &&
     ++	>delete.txt &&
     ++	git add a.txt b.txt delete.txt &&
      +	git commit -m master:1 &&
     -+	echo a>a.txt &&
     -+	echo b>b.txt &&
     ++	echo a >a.txt &&
     ++	echo b >b.txt &&
      +	echo delete >delete.txt &&
      +	git add a.txt b.txt delete.txt &&
      +	git commit -m master:2 &&
      +	git checkout HEAD~ &&
      +	git switch -c dev &&
     ++	test_when_finished "git switch master" &&
      +	echo change >a.txt &&
      +	git add a.txt &&
      +	git commit -m dev:1 &&
      +	test_must_fail git merge master &&
     -+	git ls-files -t --dedup >actual1 &&
     -+	test_cmp expect1 actual1 &&
     ++	git ls-files --deduplicate >actual &&
     ++	cat >expect <<-\EOF &&
     ++	a.txt
     ++	b.txt
     ++	delete.txt
     ++	EOF
     ++	test_cmp expect actual &&
      +	rm delete.txt &&
     -+	git ls-files -d -m -t --dedup >actual2 &&
     -+	test_cmp expect2 actual2
     ++	git ls-files -d -m --deduplicate >actual &&
     ++	cat >expect <<-\EOF &&
     ++	a.txt
     ++	delete.txt
     ++	EOF
     ++	test_cmp expect actual &&
     ++	git ls-files -d -m -t  --deduplicate >actual &&
     ++	cat >expect <<-\EOF &&
     ++	C a.txt
     ++	C a.txt
     ++	C a.txt
     ++	R delete.txt
     ++	C delete.txt
     ++	EOF
     ++	test_cmp expect actual &&
     ++	git ls-files -d -m -c  --deduplicate >actual &&
     ++	cat >expect <<-\EOF &&
     ++	a.txt
     ++	b.txt
     ++	delete.txt
     ++	EOF
     ++	test_cmp expect actual &&
     ++	git merge --abort
      +'
     -+
      +test_done

-- 
gitgitgadget
