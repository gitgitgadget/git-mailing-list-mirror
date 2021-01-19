Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73CDC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2C9230FA
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbhASGcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbhASGb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 01:31:29 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EBAC061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 22:30:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i63so15450521wma.4
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 22:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cKs3/HrPXJqar23H0oIjWPkxy89S2BbFb9+cHwKzRSU=;
        b=JC1753nO0BdznXC2Ztup9agKTSIu/6PnVry2AeG/U06j/wO92EQNccoJZQjfhiZP7t
         gqEsFj4y5fbykRixjt4gOLtnDkIqmP5/bY6ejFgL17Zn8iH2I29cR931w9SqKa/dm6nN
         DzEI/j+BcAM/E4h4Ar4xqEZcASrI9qERx5NKCt5TL12loR56gfCZZhxUXJb9ivdS/oae
         6eBIAWYTJPMYwsBoOzZkTQbkBSKIp/TlX2f7DRmb57nyzOkuqwmX10TySZAVp7Jgy0sb
         hdnH5QegScHSPhaK6Ko8YXtu9B2kChPWGGK4ghfn/CStkTFL4b6GVIZyQ230JB17LWjQ
         ou+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cKs3/HrPXJqar23H0oIjWPkxy89S2BbFb9+cHwKzRSU=;
        b=ea1urCCXWOt+RWp+XqROIH8EZ77xeI10Fq9sDf09IF+xJ12n6+TM/xBdBMY86dCYgn
         5agZEOJ9BSdUN0mls6xzXMNZPAJHGw8DqMhxr1xttlVGCp30V+NOEeenUgee6rSbmYFx
         gviebPmOMUfczBbOA1xeM/qb3PDGeGqLLhenKTmjJn0/fcv15Cdni9meh9lhPhC/GM/D
         L9l5spRsm1FOptyiedoit2JlzNF11aEmoUoq7ctcV8JP+Y2XlpGGZKOuY3h3q1WKuvUt
         ZQgiOlf4iw03Bnxju1bjse1sdmv/PpaRFa+Uq0oPRDMp3gkmrmtJGIyaZMQvLZrOdXSv
         AAsQ==
X-Gm-Message-State: AOAM530atCZ5L5ByyLjOgr18BGGA/CBXrRd3TfWKV/42N1YNX3EVnM5m
        4UruhchX0g/KDFTurcNFMd8cUqxTpck=
X-Google-Smtp-Source: ABdhPJxNiR0K+/MrM0OHvSpGqLrvfzOjPS80/Fc2NFvNGM3L5pUnXKPhc96GGs2fHpesks8UchX7xA==
X-Received: by 2002:a7b:cb4f:: with SMTP id v15mr2450393wmj.123.1611037847355;
        Mon, 18 Jan 2021 22:30:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm2790126wmi.23.2021.01.18.22.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 22:30:46 -0800 (PST)
Message-Id: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 06:30:43 +0000
Subject: [PATCH v5 0/3] builtin/ls-files.c:add git ls-file --dedup option
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
  ls-files.c: add --deduplicate option

 Documentation/git-ls-files.txt |  5 ++
 builtin/ls-files.c             | 83 ++++++++++++++++++++--------------
 t/t3012-ls-files-dedup.sh      | 66 +++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 34 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh


base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-832%2Fadlternative%2Fls-files-dedup-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-832/adlternative/ls-files-dedup-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/832

Range-diff vs v4:

 1:  f4d9af8a312 ! 1:  ec9464f6094 ls_files.c: bugfix for --deleted and --modified
     @@ Commit message
          This situation may occur in the original code: lstat() failed
          but we use `&st` to feed ie_modified() later.
      
     -    It's buggy!
     -
          Therefore, we can directly execute show_ce without the judgment of
          ie_modified() when lstat() has failed.
      
     @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_s
      -				show_ce(repo, dir, ce, fullname.buf, tag_removed);
      -			if (show_modified && ie_modified(repo->index, ce, &st, 0))
      +			if (err) {
     -+					if (show_deleted)
     -+						show_ce(repo, dir, ce, fullname.buf, tag_removed);
     -+					if (show_modified)
     -+						show_ce(repo, dir, ce, fullname.buf, tag_modified);
     -+			}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
     ++				if (errno != ENOENT && errno != ENOTDIR)
     ++				    error_errno("cannot lstat '%s'", fullname.buf);
     ++				if (show_deleted)
     ++					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     ++				if (show_modified)
     ++					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     ++			} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
       				show_ce(repo, dir, ce, fullname.buf, tag_modified);
       		}
       	}
 2:  50efd9b45b1 ! 2:  802ff802be8 ls_files.c: consolidate two for loops into one
     @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_s
      -	if (show_cached || show_stage) {
      -		for (i = 0; i < repo->index->cache_nr; i++) {
      -			const struct cache_entry *ce = repo->index->cache[i];
     --
     ++	if (! (show_cached || show_stage || show_deleted || show_modified))
     ++		return;
     ++	for (i = 0; i < repo->index->cache_nr; i++) {
     ++		const struct cache_entry *ce = repo->index->cache[i];
     ++		struct stat st;
     ++		int err;
     + 
      -			construct_fullname(&fullname, repo, ce);
     --
     ++		construct_fullname(&fullname, repo, ce);
     + 
      -			if ((dir->flags & DIR_SHOW_IGNORED) &&
      -			    !ce_excluded(dir, repo->index, fullname.buf, ce))
      -				continue;
     @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_s
      -				ce_stage(ce) ? tag_unmerged :
      -				(ce_skip_worktree(ce) ? tag_skip_worktree :
      -				 tag_cached));
     --		}
     ++		if ((dir->flags & DIR_SHOW_IGNORED) &&
     ++			!ce_excluded(dir, repo->index, fullname.buf, ce))
     ++			continue;
     ++		if (ce->ce_flags & CE_UPDATE)
     ++			continue;
     ++		if (show_cached || show_stage) {
     ++			if (!show_unmerged || ce_stage(ce))
     ++				show_ce(repo, dir, ce, fullname.buf,
     ++					ce_stage(ce) ? tag_unmerged :
     ++					(ce_skip_worktree(ce) ? tag_skip_worktree :
     ++						tag_cached));
     + 		}
      -	}
      -	if (show_deleted || show_modified) {
      -		for (i = 0; i < repo->index->cache_nr; i++) {
      -			const struct cache_entry *ce = repo->index->cache[i];
      -			struct stat st;
      -			int err;
     -+	if (! (show_cached || show_stage || show_deleted || show_modified))
     -+		return;
     -+	for (i = 0; i < repo->index->cache_nr; i++) {
     -+		const struct cache_entry *ce = repo->index->cache[i];
     -+		struct stat st;
     -+		int err;
     - 
     +-
      -			construct_fullname(&fullname, repo, ce);
     -+		construct_fullname(&fullname, repo, ce);
     - 
     +-
      -			if ((dir->flags & DIR_SHOW_IGNORED) &&
      -			    !ce_excluded(dir, repo->index, fullname.buf, ce))
      -				continue;
     @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_s
      -				continue;
      -			err = lstat(fullname.buf, &st);
      -			if (err) {
     --					if (show_deleted)
     --						show_ce(repo, dir, ce, fullname.buf, tag_removed);
     --					if (show_modified)
     --						show_ce(repo, dir, ce, fullname.buf, tag_modified);
     --			}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
     --				show_ce(repo, dir, ce, fullname.buf, tag_modified);
     -+		if ((dir->flags & DIR_SHOW_IGNORED) &&
     -+			!ce_excluded(dir, repo->index, fullname.buf, ce))
     -+			continue;
     -+		if (ce->ce_flags & CE_UPDATE)
     -+			continue;
     -+		if (show_cached || show_stage) {
     -+			if (!show_unmerged || ce_stage(ce))
     -+				show_ce(repo, dir, ce, fullname.buf,
     -+					ce_stage(ce) ? tag_unmerged :
     -+					(ce_skip_worktree(ce) ? tag_skip_worktree :
     -+						tag_cached));
     - 		}
     +-				if (errno != ENOENT && errno != ENOTDIR)
     +-				    error_errno("cannot lstat '%s'", fullname.buf);
     +-				if (show_deleted)
     +-					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     +-				if (show_modified)
     +-					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     +-			} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
      +		if (ce_skip_worktree(ce))
      +			continue;
      +		err = lstat(fullname.buf, &st);
      +		if (err) {
     -+				if (show_deleted)
     -+					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     -+				if (show_modified)
     -+					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     -+		}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
     ++			if (errno != ENOENT && errno != ENOTDIR)
     ++				error_errno("cannot lstat '%s'", fullname.buf);
     ++			if (show_deleted)
     ++				show_ce(repo, dir, ce, fullname.buf, tag_removed);
     ++			if (show_modified)
     + 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
     +-		}
     ++		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
      +			show_ce(repo, dir, ce, fullname.buf, tag_modified);
       	}
       
 3:  0c7830d07db ! 3:  e9c53186706 ls-files: add --deduplicate option
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    ls-files: add --deduplicate option
     +    ls-files.c: add --deduplicate option
      
          In order to provide users a better experience
          when viewing information about files in the index
     @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_s
       		if (ce->ce_flags & CE_UPDATE)
       			continue;
       		if (show_cached || show_stage) {
     -+			if (show_cached && skipping_duplicates && last_shown_ce &&
     ++			if (skipping_duplicates && last_shown_ce &&
      +				!strcmp(last_shown_ce->name,ce->name))
      +					continue;
       			if (!show_unmerged || ce_stage(ce))
     @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_s
       					ce_stage(ce) ? tag_unmerged :
       					(ce_skip_worktree(ce) ? tag_skip_worktree :
       						tag_cached));
     -+			if(show_cached && skipping_duplicates)
     ++			if (show_cached && skipping_duplicates)
      +				last_shown_ce = ce;
       		}
       		if (ce_skip_worktree(ce))
       			continue;
     -+		if (skipping_duplicates && last_shown_ce && !strcmp(last_shown_ce->name,ce->name))
     -+			continue;
     ++		if (skipping_duplicates && last_shown_ce &&
     ++			!strcmp(last_shown_ce->name,ce->name))
     ++				continue;
       		err = lstat(fullname.buf, &st);
       		if (err) {
     +-			if (errno != ENOENT && errno != ENOTDIR)
     +-				error_errno("cannot lstat '%s'", fullname.buf);
     +-			if (show_deleted)
      +			if (skipping_duplicates && show_deleted && show_modified)
     -+				show_ce(repo, dir, ce, fullname.buf, tag_removed);
     + 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
     +-			if (show_modified)
     +-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
      +			else {
     - 				if (show_deleted)
     - 					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     - 				if (show_modified)
     - 					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     --		}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
     ++				if (errno != ENOENT && errno != ENOTDIR)
     ++					error_errno("cannot lstat '%s'", fullname.buf);
     ++				if (show_deleted)
     ++					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     ++				if (show_modified)
     ++					show_ce(repo, dir, ce, fullname.buf, tag_modified);
      +			}
     -+		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
     + 		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
       			show_ce(repo, dir, ce, fullname.buf, tag_modified);
      +		last_shown_ce = ce;
       	}
     @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cm
       	};
       
      @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
     - 		tag_skip_worktree = "S ";
     - 		tag_resolve_undo = "U ";
     - 	}
     -+	if (show_tag && skipping_duplicates)
     + 		 * you also show the stage information.
     + 		 */
     + 		show_stage = 1;
     ++	if (show_tag || show_stage)
      +		skipping_duplicates = 0;
     - 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_SHOW_IGNORED) || show_killed)
     - 		require_work_tree = 1;
     - 	if (show_unmerged)
     + 	if (dir.exclude_per_dir)
     + 		exc_given = 1;
     + 
      
       ## t/t3012-ls-files-dedup.sh (new) ##
      @@
     @@ t/t3012-ls-files-dedup.sh (new)
      +	>b.txt &&
      +	>delete.txt &&
      +	git add a.txt b.txt delete.txt &&
     -+	git commit -m master:1 &&
     ++	git commit -m base &&
      +	echo a >a.txt &&
      +	echo b >b.txt &&
      +	echo delete >delete.txt &&
      +	git add a.txt b.txt delete.txt &&
     -+	git commit -m master:2 &&
     -+	git checkout HEAD~ &&
     -+	git switch -c dev &&
     -+	test_when_finished "git switch master" &&
     ++	git commit -m tip &&
     ++	git tag tip &&
     ++	git reset --hard HEAD^ &&
      +	echo change >a.txt &&
     -+	git add a.txt &&
     -+	git commit -m dev:1 &&
     -+	test_must_fail git merge master &&
     ++	git commit -a -m side &&
     ++	git tag side
     ++'
     ++
     ++test_expect_success 'git ls-files --deduplicate to show unique unmerged path' '
     ++	test_must_fail git merge tip &&
      +	git ls-files --deduplicate >actual &&
      +	cat >expect <<-\EOF &&
      +	a.txt
     @@ t/t3012-ls-files-dedup.sh (new)
      +	delete.txt
      +	EOF
      +	test_cmp expect actual &&
     ++	git merge --abort
     ++'
     ++
     ++test_expect_success 'git ls-files -d -m --deduplicate with different display options' '
     ++	git reset --hard side &&
     ++	test_must_fail git merge tip &&
      +	rm delete.txt &&
      +	git ls-files -d -m --deduplicate >actual &&
      +	cat >expect <<-\EOF &&
     @@ t/t3012-ls-files-dedup.sh (new)
      +	delete.txt
      +	EOF
      +	test_cmp expect actual &&
     -+	git ls-files -d -m -t  --deduplicate >actual &&
     ++	git ls-files -d -m -t --deduplicate >actual &&
      +	cat >expect <<-\EOF &&
      +	C a.txt
      +	C a.txt
     @@ t/t3012-ls-files-dedup.sh (new)
      +	C delete.txt
      +	EOF
      +	test_cmp expect actual &&
     -+	git ls-files -d -m -c  --deduplicate >actual &&
     ++	git ls-files -d -m -c --deduplicate >actual &&
      +	cat >expect <<-\EOF &&
      +	a.txt
      +	b.txt
     @@ t/t3012-ls-files-dedup.sh (new)
      +	test_cmp expect actual &&
      +	git merge --abort
      +'
     ++
      +test_done

-- 
gitgitgadget
