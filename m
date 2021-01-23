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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4347C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C2322B2D
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 10:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbhAWKU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 05:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbhAWKUy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 05:20:54 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41F4C06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 02:20:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c128so6483665wme.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 02:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aKxEmYSCtUKyiHswrzeTg5WVh/2A0Le4Vwe10ciokig=;
        b=fwF55BrOt0GwqqCKZcVjReZBMIwCc6LAs8HESxXoUolqEAB1tsV66tXZhc0ZIrMP6l
         7iBWdKLvfkmPjBWjPfUdPRCCdg9lUpKYKTtBjJvFcbfjBWVtFI7xvKQEoTALOEM9P9CP
         dRrkQKqEwGu0WHMlMIaFwc0USIv/QfP0ub3fTH/BsQDzXBCuJ2uiDaA1JfMbub5Pv1G1
         pNxzdRSCqfQOJ7RoDF7E0JEs9QHt8qSyEvoJYrMKyYzw+/uBXdT9LymybmqN56ICqKSd
         39JdRJ7Z7NRPirJAZDpJV0BnLNJ8HAIjyQ9oTRYKyQAxzd7uzN7O5g9y6AY6oPpI+n7R
         zACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aKxEmYSCtUKyiHswrzeTg5WVh/2A0Le4Vwe10ciokig=;
        b=jlQGoJ3OKiXMjFdJduX2tAw6M+dTgYp1pcoTYSiB7iNMV6erVHfEnGBvx9/ayNVGld
         mHvHLOoF9lmFQ94mPOQnDImd0tEH0CoGiaalmXMMSesUjvc8s2ftfKOw+BexZsXz8u/E
         FKrxKCz/bW2/D0scUTWmBSOowRbNMHY9XZ5StLsnpUAw+vvYeRRg2bJbbt2B1w0T2NU4
         1OLTRrwV4PUs1j7Xnqa4bggxa048d/rTf2O69LZJPvTHU3OVwy87giLs0am+UBHLLuEe
         W1PqT6GXaTvNXA89RHrFBECjLBHoawk6NOcesbnMn4Knv6IROnVWILoibCocQAugDV1+
         03eQ==
X-Gm-Message-State: AOAM533a6NHXlCDxizc8e/2gZvgQxbP4nI8c77JDkymA2D6Jog+Yn6Hw
        5/n6ooDEVxKTHteEgqmxWBOaJtUdOfQ=
X-Google-Smtp-Source: ABdhPJxNW0HzWeAuiFkInElQ47KdUw6zdToSxEM0FPu5boGWaXNT2hDDn5bajrYsfbbPel2/ZQlMpQ==
X-Received: by 2002:a1c:4487:: with SMTP id r129mr7514206wma.57.1611397212171;
        Sat, 23 Jan 2021 02:20:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z130sm14203089wmb.33.2021.01.23.02.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 02:20:11 -0800 (PST)
Message-Id: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
References: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 10:20:07 +0000
Subject: [PATCH v6 0/3] builtin/ls-files.c:add git ls-file --dedup option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
 builtin/ls-files.c             | 85 ++++++++++++++++++++--------------
 t/t3012-ls-files-dedup.sh      | 66 ++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 35 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh


base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-832%2Fadlternative%2Fls-files-dedup-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-832/adlternative/ls-files-dedup-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/832

Range-diff vs v5:

 1:  ec9464f6094 ! 1:  fbc38ce9075 ls_files.c: bugfix for --deleted and --modified
     @@ Commit message
      
       ## builtin/ls-files.c ##
      @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     + 		for (i = 0; i < repo->index->cache_nr; i++) {
     + 			const struct cache_entry *ce = repo->index->cache[i];
     + 			struct stat st;
     +-			int err;
     ++			int stat_err;
     + 
     + 			construct_fullname(&fullname, repo, ce);
     + 
     +@@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     + 				continue;
       			if (ce_skip_worktree(ce))
       				continue;
     - 			err = lstat(fullname.buf, &st);
     +-			err = lstat(fullname.buf, &st);
      -			if (show_deleted && err)
     --				show_ce(repo, dir, ce, fullname.buf, tag_removed);
     ++			stat_err = lstat(fullname.buf, &st);
     ++			if (stat_err && (errno != ENOENT && errno != ENOTDIR))
     ++				error_errno("cannot lstat '%s'", fullname.buf);
     ++			if (stat_err && show_deleted)
     + 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
      -			if (show_modified && ie_modified(repo->index, ce, &st, 0))
     -+			if (err) {
     -+				if (errno != ENOENT && errno != ENOTDIR)
     -+				    error_errno("cannot lstat '%s'", fullname.buf);
     -+				if (show_deleted)
     -+					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     -+				if (show_modified)
     +-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
     ++			if (show_modified &&
     ++				(stat_err || ie_modified(repo->index, ce, &st, 0)))
      +					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     -+			} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
     - 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
       		}
       	}
     + 
 2:  802ff802be8 ! 2:  3997d390883 ls_files.c: consolidate two for loops into one
     @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_s
      -	if (show_cached || show_stage) {
      -		for (i = 0; i < repo->index->cache_nr; i++) {
      -			const struct cache_entry *ce = repo->index->cache[i];
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
      -				ce_stage(ce) ? tag_unmerged :
      -				(ce_skip_worktree(ce) ? tag_skip_worktree :
      -				 tag_cached));
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
     +-		}
      -	}
      -	if (show_deleted || show_modified) {
      -		for (i = 0; i < repo->index->cache_nr; i++) {
      -			const struct cache_entry *ce = repo->index->cache[i];
      -			struct stat st;
     --			int err;
     --
     +-			int stat_err;
     ++	if (! (show_cached || show_stage || show_deleted || show_modified))
     ++		return;
     ++	for (i = 0; i < repo->index->cache_nr; i++) {
     ++		const struct cache_entry *ce = repo->index->cache[i];
     ++		struct stat st;
     ++		int stat_err;
     + 
      -			construct_fullname(&fullname, repo, ce);
     --
     ++		construct_fullname(&fullname, repo, ce);
     + 
      -			if ((dir->flags & DIR_SHOW_IGNORED) &&
      -			    !ce_excluded(dir, repo->index, fullname.buf, ce))
      -				continue;
     @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_s
      -				continue;
      -			if (ce_skip_worktree(ce))
      -				continue;
     --			err = lstat(fullname.buf, &st);
     --			if (err) {
     --				if (errno != ENOENT && errno != ENOTDIR)
     --				    error_errno("cannot lstat '%s'", fullname.buf);
     --				if (show_deleted)
     --					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     --				if (show_modified)
     +-			stat_err = lstat(fullname.buf, &st);
     +-			if (stat_err && (errno != ENOENT && errno != ENOTDIR))
     +-				error_errno("cannot lstat '%s'", fullname.buf);
     +-			if (stat_err && show_deleted)
     +-				show_ce(repo, dir, ce, fullname.buf, tag_removed);
     +-			if (show_modified &&
     +-				(stat_err || ie_modified(repo->index, ce, &st, 0)))
      -					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     --			} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
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
     ++		if (!show_deleted && !show_modified)
     ++			continue;
      +		if (ce_skip_worktree(ce))
      +			continue;
     -+		err = lstat(fullname.buf, &st);
     -+		if (err) {
     -+			if (errno != ENOENT && errno != ENOTDIR)
     -+				error_errno("cannot lstat '%s'", fullname.buf);
     -+			if (show_deleted)
     -+				show_ce(repo, dir, ce, fullname.buf, tag_removed);
     -+			if (show_modified)
     - 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
     --		}
     -+		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
     -+			show_ce(repo, dir, ce, fullname.buf, tag_modified);
     ++		stat_err = lstat(fullname.buf, &st);
     ++		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
     ++			error_errno("cannot lstat '%s'", fullname.buf);
     ++		if (stat_err && show_deleted)
     ++			show_ce(repo, dir, ce, fullname.buf, tag_removed);
     ++		if (show_modified &&
     ++			(stat_err || ie_modified(repo->index, ce, &st, 0)))
     ++				show_ce(repo, dir, ce, fullname.buf, tag_modified);
       	}
       
       	strbuf_release(&fullname);
 3:  e9c53186706 ! 3:  07b603fd97c ls-files.c: add --deduplicate option
     @@ builtin/ls-files.c: static int line_terminator = '\n';
       static const char *prefix;
       static int max_prefix_len;
      @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     - {
     - 	int i;
     - 	struct strbuf fullname = STRBUF_INIT;
     -+	const struct cache_entry *last_shown_ce;
     - 
     - 	/* For cached/deleted files we don't need to even do the readdir */
     - 	if (show_others || show_killed) {
     -@@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     - 	}
     - 	if (! (show_cached || show_stage || show_deleted || show_modified))
     - 		return;
     -+	last_shown_ce = NULL;
     - 	for (i = 0; i < repo->index->cache_nr; i++) {
     - 		const struct cache_entry *ce = repo->index->cache[i];
     - 		struct stat st;
     -@@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     - 
     - 		construct_fullname(&fullname, repo, ce);
     - 
     -+		if (skipping_duplicates && last_shown_ce &&
     -+			!strcmp(last_shown_ce->name,ce->name))
     -+				continue;
     - 		if ((dir->flags & DIR_SHOW_IGNORED) &&
     - 			!ce_excluded(dir, repo->index, fullname.buf, ce))
       			continue;
       		if (ce->ce_flags & CE_UPDATE)
       			continue;
     - 		if (show_cached || show_stage) {
     -+			if (skipping_duplicates && last_shown_ce &&
     -+				!strcmp(last_shown_ce->name,ce->name))
     -+					continue;
     - 			if (!show_unmerged || ce_stage(ce))
     +-		if (show_cached || show_stage) {
     +-			if (!show_unmerged || ce_stage(ce))
     ++		if ((show_cached || show_stage) &&
     ++			(!show_unmerged || ce_stage(ce))) {
       				show_ce(repo, dir, ce, fullname.buf,
       					ce_stage(ce) ? tag_unmerged :
       					(ce_skip_worktree(ce) ? tag_skip_worktree :
       						tag_cached));
     -+			if (show_cached && skipping_duplicates)
     -+				last_shown_ce = ce;
     ++			if (skipping_duplicates)
     ++				goto skip_to_next_name;
       		}
     - 		if (ce_skip_worktree(ce))
     + 		if (!show_deleted && !show_modified)
       			continue;
     -+		if (skipping_duplicates && last_shown_ce &&
     -+			!strcmp(last_shown_ce->name,ce->name))
     -+				continue;
     - 		err = lstat(fullname.buf, &st);
     - 		if (err) {
     --			if (errno != ENOENT && errno != ENOTDIR)
     --				error_errno("cannot lstat '%s'", fullname.buf);
     --			if (show_deleted)
     -+			if (skipping_duplicates && show_deleted && show_modified)
     - 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
     --			if (show_modified)
     --				show_ce(repo, dir, ce, fullname.buf, tag_modified);
     -+			else {
     -+				if (errno != ENOENT && errno != ENOTDIR)
     -+					error_errno("cannot lstat '%s'", fullname.buf);
     -+				if (show_deleted)
     -+					show_ce(repo, dir, ce, fullname.buf, tag_removed);
     -+				if (show_modified)
     -+					show_ce(repo, dir, ce, fullname.buf, tag_modified);
     -+			}
     - 		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
     - 			show_ce(repo, dir, ce, fullname.buf, tag_modified);
     -+		last_shown_ce = ce;
     +@@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     + 		stat_err = lstat(fullname.buf, &st);
     + 		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
     + 			error_errno("cannot lstat '%s'", fullname.buf);
     +-		if (stat_err && show_deleted)
     ++		if (stat_err && show_deleted) {
     + 			show_ce(repo, dir, ce, fullname.buf, tag_removed);
     ++			if (skipping_duplicates)
     ++				goto skip_to_next_name;
     ++		}
     + 		if (show_modified &&
     +-			(stat_err || ie_modified(repo->index, ce, &st, 0)))
     ++			(stat_err || ie_modified(repo->index, ce, &st, 0))) {
     + 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
     ++			if (skipping_duplicates)
     ++				goto skip_to_next_name;
     ++		}
     ++		continue;
     ++skip_to_next_name:
     ++		{
     ++			int j;
     ++			struct cache_entry **cache = repo->index->cache;
     ++			for (j = i + 1; j < repo->index->cache_nr; j++)
     ++				if (strcmp(ce->name, cache[j]->name))
     ++					break;
     ++			i = j - 1; /* compensate for outer for loop */
     ++		}
       	}
       
       	strbuf_release(&fullname);

-- 
gitgitgadget
