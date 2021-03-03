Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20551C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06B764E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhCDAWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbhCCL0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 06:26:22 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6BC061788
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 03:16:54 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p21so16091697pgl.12
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 03:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UG9ENt/vMJmaE423XvHhQoPqZEw2bKY/wAPVygX23Ic=;
        b=Pbp24rHMToK4gD7bjsPhzjh8ZynxxLEprnPFH/7DN8joIqm4BSyfut+1OEYkOBGlbu
         WUylnmd3ctxZ2YEZSZhLfdCWLrwCWibyQn4d/E3HzaNPsy4sGfGbDVH0vWige+jvwiHE
         xRIuTWAwcpnXK2ndc1x3X3ENHz0PKjCMLBE/FliMPtMFYgnivsCVv8y6oJXuOcTN4ive
         MGzUOrlAOIJo8ozc1VIVmLDHgn4mH/aJw4sSb+7zGH3ilV44nuO53RYy1vPxZTbSLd3O
         9YC2LTuk/6t9IQoqRQnjWnNCDoRonJ7dTIeEZdGYchUSTbve/4CVFXtlK7NljSZLr6c/
         vyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UG9ENt/vMJmaE423XvHhQoPqZEw2bKY/wAPVygX23Ic=;
        b=TEp4wsow3gJhWlfsPSBnE5iud+wnNQC6+ci0NI/QHah6r9Q0WUN2WNHOO9XkyzcuQ3
         0I/A7KaJazDu0LAft2aGmtTEhQJhFpTh3BVT8JwOU1w0J0TuRwjUqMJ1LPpawMQXSiPV
         hN2Dot2SRZb+fOF0e+203qf+n8NOL0hECfCehKlfV04c6YNop/mODoByx4rAYFQdPjgn
         XBF44cERqTY692JYKs1v9cTQniB9KbDp+r5SZJ9jh9Rvu7JFVTmblSTwcfD5vWScfIYX
         HswjVDkX6QKdQExD3mTltB9zPzem2XxJfUK7tr5B0dsAOOoRmQ1XrKt6Q6l1Z3s+F8Bx
         h5Vw==
X-Gm-Message-State: AOAM532viLF6c/ChgdbHSmlvd0QdGgI8aRlyfHny1FIMohPYoHUPO7MH
        e0HPlprpruaP1Uz0+iy2so2RJgEF5HI=
X-Google-Smtp-Source: ABdhPJyWeG9WIi5Dt4t6fp96yjELcdXOZX/INef8KwfSm2ARjTa0p/K/w8ZyKXZfj1sSXQ7VfsJUmQ==
X-Received: by 2002:a63:f648:: with SMTP id u8mr22024777pgj.270.1614770213369;
        Wed, 03 Mar 2021 03:16:53 -0800 (PST)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id d7sm13978175pfh.73.2021.03.03.03.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 03:16:52 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 0/2] stash show: learn --include-untracked and --only-untracked
Date:   Wed,  3 Mar 2021 03:16:41 -0800
Message-Id: <cover.1614770171.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.228.gb75b4e4ce2
In-Reply-To: <cover.1613459474.git.liu.denton@gmail.com>
References: <cover.1613459474.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A blindspot that I've noticed in git is that it's not possible to
properly view a stash entry that has untracked files via `git stash
show`. Teach `git stash show --include-untracked` which should do this.
In addition, this series also teaches `--only-untracked` and the
`stash.showIncludeUntracked` config option.

This series is based on 'dl/stash-cleanup'.

Changes since v3:

* Incorporate Junio's SQUASH??? commits

* Implement a custom unpack_trees() callback to detect the case where
  there are duplicate entries in worktree and untracked commits

Changes since v2:

* Base this series on top of 'dl/stash-cleanup'

* Attempt to replicate the read-tree code to merge the untracked tree

Changes since v1:

* Add a dash for <log-options> and <diff-options>

* Fix the misspelling of --include-untracked in a commit message

* Change the approach from concatenating diffs to using `git read-tree`

Denton Liu (2):
  stash show: teach --include-untracked and --only-untracked
  stash show: learn stash.showIncludeUntracked

 Documentation/config/stash.txt         |   5 ++
 Documentation/git-stash.txt            |  22 +++--
 builtin/stash.c                        |  62 +++++++++++++-
 contrib/completion/git-completion.bash |   2 +-
 t/t3905-stash-include-untracked.sh     | 108 +++++++++++++++++++++++++
 unpack-trees.c                         |  22 +++++
 unpack-trees.h                         |   2 +
 7 files changed, 214 insertions(+), 9 deletions(-)

Range-diff against v3:
1:  85b81f2f06 ! 1:  af3757135b stash show: teach --include-untracked and --only-untracked
    @@ Commit message
         third-parent if it exists, are shown in addition to the paths that have
         modifications between the stash base and the working tree in the stash.
     
    -    One limitation of this is that it would be possible to manually craft a
    -    stash entry where duplicate untracked files in the stash entry will mask
    -    tracked files. This seems like an instance of "Doctor, it hurts when I
    -    do this! So don't do that!" so this can be written off.
    +    It is possible to manually craft a malformed stash entry where duplicate
    +    untracked files in the stash entry will mask tracked files. We detect
    +    and error out in that case via a custom unpack_trees() callback:
    +    stash_worktree_untracked_merge().
     
         Also, teach stash the --only-untracked option which only shows the
         untracked files of a stash entry. This is similar to `git show stash^3`
         but it is nice to provide a convenient abstraction for it so that users
         do not have to think about the underlying implementation.
     
    -
    - ## Notes ##
    -    I am not familiar with the read-tree code so this attempt at replicating
    -    the read-tree code may in diff_include_untracked() may be incorrect
    -    (particularly the use of the_index?).
    -
    -    Also, I could not figure out how to make unpack_trees() error out in the
    -    case where untracked tree entry contains duplicate entries with the
    -    worktree entry.
    -
      ## Documentation/git-stash.txt ##
     @@ Documentation/git-stash.txt: SYNOPSIS
      --------
    @@ builtin/stash.c: static int git_stash_config(const char *var, const char *value,
     +	unpack_tree_opt.head_idx = -1;
     +	unpack_tree_opt.src_index = &the_index;
     +	unpack_tree_opt.dst_index = &the_index;
    -+	unpack_tree_opt.fn = twoway_merge;
    ++	unpack_tree_opt.merge = 1;
    ++	unpack_tree_opt.fn = stash_worktree_untracked_merge;
     +
     +	if (unpack_trees(ARRAY_SIZE(tree_desc), tree_desc, &unpack_tree_opt))
     +		die(_("failed to unpack trees"));
    @@ t/t3905-stash-include-untracked.sh: test_expect_success 'stash -u with globs' '
     +	>untracked &&
     +	>tracked &&
     +	git add tracked &&
    ++	empty_blob_oid=$(git rev-parse --short :tracked) &&
     +	git stash -u &&
     +
     +	cat >expect <<-EOF &&
    @@ t/t3905-stash-include-untracked.sh: test_expect_success 'stash -u with globs' '
     +	cat >expect <<-EOF &&
     +	diff --git a/tracked b/tracked
     +	new file mode 100644
    -+	index 0000000..e69de29
    ++	index 0000000..$empty_blob_oid
     +	diff --git a/untracked b/untracked
     +	new file mode 100644
    -+	index 0000000..e69de29
    ++	index 0000000..$empty_blob_oid
     +	EOF
     +	git stash show -p --include-untracked >actual &&
     +	test_cmp expect actual &&
    @@ t/t3905-stash-include-untracked.sh: test_expect_success 'stash -u with globs' '
     +	>untracked &&
     +	>tracked &&
     +	git add tracked &&
    ++	empty_blob_oid=$(git rev-parse --short :tracked) &&
     +	git stash -u &&
     +
     +	cat >expect <<-EOF &&
    @@ t/t3905-stash-include-untracked.sh: test_expect_success 'stash -u with globs' '
     +	cat >expect <<-EOF &&
     +	diff --git a/untracked b/untracked
     +	new file mode 100644
    -+	index 0000000..e69de29
    ++	index 0000000..$empty_blob_oid
     +	EOF
     +	git stash show -p --only-untracked >actual &&
     +	test_cmp expect actual &&
    @@ t/t3905-stash-include-untracked.sh: test_expect_success 'stash -u with globs' '
     +	git stash show --include-untracked --no-include-untracked >actual &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'stash show --include-untracked errors on duplicate files' '
    ++	git reset --hard &&
    ++	git clean -xf &&
    ++	>tracked &&
    ++	git add tracked &&
    ++	tree=$(git write-tree) &&
    ++	i_commit=$(git commit-tree -p HEAD -m "index on any-branch" "$tree") &&
    ++	test_when_finished "rm -f untracked_index" &&
    ++	u_commit=$(
    ++		GIT_INDEX_FILE="untracked_index" &&
    ++		export GIT_INDEX_FILE &&
    ++		git update-index --add tracked &&
    ++		u_tree=$(git write-tree) &&
    ++		git commit-tree -m "untracked files on any-branch" "$u_tree"
    ++	) &&
    ++	w_commit=$(git commit-tree -p HEAD -p "$i_commit" -p "$u_commit" -m "WIP on any-branch" "$tree") &&
    ++	test_must_fail git stash show --include-untracked "$w_commit" 2>err &&
    ++	test_i18ngrep "worktree and untracked commit have duplicate entries: tracked" err
    ++'
     +
      test_done
    +
    + ## unpack-trees.c ##
    +@@ unpack-trees.c: int oneway_merge(const struct cache_entry * const *src,
    + 	}
    + 	return merged_entry(a, old, o);
    + }
    ++
    ++/*
    ++ * Merge worktree and untracked entries in a stash entry.
    ++ *
    ++ * Ignore all index entries. Collapse remaining trees but make sure that they
    ++ * don't have any conflicting files.
    ++ */
    ++int stash_worktree_untracked_merge(const struct cache_entry * const *src,
    ++				   struct unpack_trees_options *o)
    ++{
    ++	const struct cache_entry *worktree = src[1];
    ++	const struct cache_entry *untracked = src[2];
    ++
    ++	if (o->merge_size != 2)
    ++		BUG("invalid merge_size: %d", o->merge_size);
    ++
    ++	if (worktree && untracked)
    ++		return error(_("worktree and untracked commit have duplicate entries: %s"),
    ++			     super_prefixed(worktree->name));
    ++
    ++	return merged_entry(worktree ? worktree : untracked, NULL, o);
    ++}
    +
    + ## unpack-trees.h ##
    +@@ unpack-trees.h: int bind_merge(const struct cache_entry * const *src,
    + 	       struct unpack_trees_options *o);
    + int oneway_merge(const struct cache_entry * const *src,
    + 		 struct unpack_trees_options *o);
    ++int stash_worktree_untracked_merge(const struct cache_entry * const *src,
    ++				   struct unpack_trees_options *o);
    + 
    + #endif
2:  d19d07ec27 = 2:  3480086f1d stash show: learn stash.showIncludeUntracked
-- 
2.31.0.rc1.228.gb75b4e4ce2

