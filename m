Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E34C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353219AbiETT3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiETT3P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:29:15 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C85818C046
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:29:14 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g3so8004768qtb.7
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrBMz4RZ2oezsI933oNT4bhX9BcBSIjVfvtDzmtdEwk=;
        b=d0bWujZL+QgqLL9uD0c33H270tanmR4zOCJ8CY5FVmsHAKvYdoktDJli73X8IB6TPS
         AD73cCc298jf6lM23v3ft7YqpvtM5jUkAgSy/Fv5N6GaHOTU1p3cBU3FWVB5fRCFs8aH
         PGY/aPl2rNf9PHCTHu1iSIHB63fviH1IXI7IXylCXRcSkxbyiJxsVQrVE2WDm5G089FQ
         bhrkAstDpZirVCQm+PxxuXpevWgSTKIGDB/+3b66Vgjg+kc4EiE2zJWjoNC5ArABgVRw
         uJMHs59sxJyBgc6tLMv8Kof6LSwPxMmUxv1E1vAo+O8FdHSUdEwRLbZGj2m6LkIpcE/4
         Nc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrBMz4RZ2oezsI933oNT4bhX9BcBSIjVfvtDzmtdEwk=;
        b=6R9lNoX010Ejq2+fL0+qavttlegkijweUJsgnkwQXT2NxrwOY8/xZ6AnimC0tNMmP6
         +GzFK2ww2Nis6wJPEvduUeQZdxDd7ROHtCp6IfN2XjXJ74gj2usiGyik6w9jN5RjfEAP
         zJ6Rio5YjioEx7cRar0mz+cLMvjNiViI41UqnyWD0Dp9i/uqzoIxCU35+6GCLOW1k+5G
         uflPIjgJAN7ZBZVpKra9yuRKRYirZc8lggeqMLNToRXsIH53LRGM+BLQBZCbIjywPQZk
         eLyFoAY7FRMVS+UMOEsLGBCdwTEPd3VcaIVKpMIMqu4wovA7+jyQdvt89fp9pYYcwSyE
         XDxA==
X-Gm-Message-State: AOAM531HKiKv/xQD+UAaLELs/OGgCY5OQCsuUjsK077r/CeAG4O6n7N5
        Rtb34SJR0frEsey7De6C0PR+6muH3LsDdQ==
X-Google-Smtp-Source: ABdhPJw1cRUOpiKwkT/vWsh47/aJfyu/6DL/gRfI4CAQBePX9lbhU4i/EFA2Y+TgLA/ygg57emgHRA==
X-Received: by 2002:a05:622a:1907:b0:2f9:2a8e:a54d with SMTP id w7-20020a05622a190700b002f92a8ea54dmr908849qtc.527.1653074952916;
        Fri, 20 May 2022 12:29:12 -0700 (PDT)
Received: from localhost.localdomain ([108.29.205.134])
        by smtp.gmail.com with ESMTPSA id v19-20020ae9e313000000b006a059f1d8b8sm142379qkf.124.2022.05.20.12.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:29:12 -0700 (PDT)
From:   Goss Geppert <gg.oss.dev@gmail.com>
X-Google-Original-From: Goss Geppert <ggossdev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v3 0/3] dir: traverse into repository
Date:   Fri, 20 May 2022 19:28:37 +0000
Message-Id: <20220520192840.8942-1-ggossdev@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505203234.21586-1-ggossdev@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your feedback so far. This revision includes a number of changes:

* I realized that using option `--git-dir` (or environment variable `GIT_DIR`)
  when the working directory is outside the repository can also cause the
  directory traversal to fail to enter `the_repository`.  I've added test cases
  and updated comments / messages to reflect this.
* I noticed that `real_pathdup` can fail even for valid paths (and return NULL)
  if e.g. the path contains too many nested symlinks (currently 32).  We'll now
  `die_on_error`.
* I no longer reset the string buffer holding the `dirname` and just reuse it.
  While the prior call to `is_nonbare_repository_dir` does not treat its
  argument as const, the function does reset the argument to its effective
  input state.  The `strbuf_addstr` and `strbuf_complete` have also been
  removed.
* I added a separate commit to cache the `real_gitdir` value.  On my mystery
  machine, the call to `real_pathdup`, instrumented with trace2, takes an
  anecdotal 40 usecs for a somewhat lengthy path [1].  This compares to around
  10 usecs for an empty trace2 region.  I can remove the commit if you don't
  think the performance savings are worth the clutter.

Let me know if you have further comments or suggestions.

[1]: path with one symlink: './repo/link/a/b/././././..//////c/d/./xyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxyxy/././../e/../f/../g/../h/../././///../../..'

Goss Geppert (3):
  dir: traverse into repository
  dir: cache git_dir's realpath
  dir: minor refactoring / clean-up

 dir.c                          |  90 ++++++++---
 t/t2205-add-worktree-config.sh | 274 +++++++++++++++++++++++++++++++++
 2 files changed, 341 insertions(+), 23 deletions(-)
 create mode 100755 t/t2205-add-worktree-config.sh

Range-diff against v2:
1:  26e6a878cd ! 1:  391fd4d8cf dir: consider worktree config in path recursion
    @@ Metadata
     Author: Goss Geppert <ggossdev@gmail.com>
     
      ## Commit message ##
    -    dir: consider worktree config in path recursion
    +    dir: traverse into repository
     
         Since 8d92fb2927 (dir: replace exponential algorithm with a linear one,
    -    2020-04-01) the following no longer works:
    +    2020-04-01) traversing into a repository's directory tree when the
    +    traversal began outside the repository's standard location has failed
    +    because the encountered repository was identified as a nested foreign
    +    repository.
     
    -        1) Initialize a repository.
    -        2) Set the `core.worktree` location to a parent directory of the
    -           default worktree.
    -        3) Add a file located in the default worktree location to the index
    -           (i.e. anywhere in the immediate parent directory of the gitdir).
    +    Prior to this commit, the failure to traverse into a repository's
    +    default worktree location was observable from a user's perspective under
    +    either of the following conditions (there may be others):
    +
    +        1) Set the `core.worktree` location to a parent directory of the
    +           default worktree; or
    +        2) Use the `--git_dir` option while the working directory is outside
    +           the repository's default worktree location
    +
    +    Under either of these conditions, symptoms of the failure to traverse
    +    into the repository's default worktree location include the inability to
    +    add files to the index or get a list of untracked files via ls-files.
     
         This commit adds a check to determine whether a nested repository that
         is encountered in recursing a path is actually `the_repository`.  If so,
    -    simply treat the directory as if it doesn't contain a nested repository.
    +    we simply treat the directory as if it doesn't contain a nested
    +    repository.
     
    -    Prior to this commit, the `add` operation was silently ignored.
    +    The commit includes test-cases to reduce the likelihood of future
    +    regressions.
     
         Signed-off-by: Goss Geppert <ggossdev@gmail.com>
     
    @@ dir.c: static enum path_treatment treat_directory(struct dir_struct *dir,
     +		 * Determine if `dirname` is a nested repo by confirming that:
     +		 * 1) we are in a nonbare repository, and
     +		 * 2) `dirname` is not an immediate parent of `the_repository->gitdir`,
    -+		 *    which could occur if the `worktree` location was manually
    -+		 *    configured by the user; see t2205 testcases 1a-1d for examples
    -+		 *    where this matters
    ++		 *    which could occur if the git_dir or worktree location was
    ++		 *    manually configured by the user; see t2205 testcases 1-3 for
    ++		 *    examples where this matters
     +		 */
      		struct strbuf sb = STRBUF_INIT;
      		strbuf_addstr(&sb, dirname);
    @@ dir.c: static enum path_treatment treat_directory(struct dir_struct *dir,
     +
     +		if (nested_repo) {
     +			char *real_dirname, *real_gitdir;
    -+			strbuf_reset(&sb);
    -+			strbuf_addstr(&sb, dirname);
    -+			strbuf_complete(&sb, '/');
     +			strbuf_addstr(&sb, ".git");
    -+			real_dirname = real_pathdup(sb.buf, 0);
    -+			real_gitdir = real_pathdup(the_repository->gitdir, 0);
    ++			real_dirname = real_pathdup(sb.buf, 1);
    ++			real_gitdir = real_pathdup(the_repository->gitdir, 1);
     +
     +			nested_repo = !!strcmp(real_dirname, real_gitdir);
     +			free(real_gitdir);
    @@ t/t2205-add-worktree-config.sh (new)
     @@
     +#!/bin/sh
     +
    -+test_description='directory traversal respects worktree config
    ++test_description='directory traversal respects user config
    ++
    ++This test verifies the traversal of the directory tree when the traversal begins
    ++outside the repository.  Two instances for which this can occur are tested:
     +
    -+This test configures the repository`s worktree to be two levels above the
    -+`.git` directory and checks whether we are able to add to the index those files
    -+that are in either (1) the manually configured worktree directory or (2) the
    -+standard worktree location with respect to the `.git` directory (i.e. ensuring
    -+that the encountered `.git` directory is not treated as belonging to a foreign
    -+nested repository)'
    ++	1) The user manually sets the worktree.  For this instance, the test sets
    ++	   the worktree two levels above the `.git` directory and checks whether we
    ++	   are able to add to the index those files that are in either (1) the
    ++	   manually configured worktree directory or (2) the standard worktree
    ++	   location with respect to the `.git` directory (i.e. ensuring that the
    ++	   encountered `.git` directory is not treated as belonging to a foreign
    ++	   nested repository).
    ++	2) The user manually sets the `git_dir` while the working directory is
    ++	   outside the repository.  The test checks that files inside the
    ++	   repository can be added to the index.
    ++	'
     +
     +. ./test-lib.sh
     +
    -+test_expect_success '1a: setup' '
    -+	test_create_repo test1 &&
    -+	git --git-dir="test1/.git" config core.worktree "$(pwd)" &&
    ++test_expect_success '1a: setup--config worktree' '
    ++	mkdir test1 &&
    ++	(
    ++	cd test1 &&
    ++	test_create_repo repo &&
    ++	git --git-dir="repo/.git" config core.worktree "$(pwd)" &&
     +
     +	mkdir -p outside-tracked outside-untracked &&
    -+	mkdir -p test1/inside-tracked test1/inside-untracked &&
    ++	mkdir -p repo/inside-tracked repo/inside-untracked &&
     +	>file-tracked &&
     +	>file-untracked &&
     +	>outside-tracked/file &&
     +	>outside-untracked/file &&
    -+	>test1/file-tracked &&
    -+	>test1/file-untracked &&
    -+	>test1/inside-tracked/file &&
    -+	>test1/inside-untracked/file &&
    ++	>repo/file-tracked &&
    ++	>repo/file-untracked &&
    ++	>repo/inside-tracked/file &&
    ++	>repo/inside-untracked/file &&
     +
     +	cat >expect-tracked-unsorted <<-EOF &&
     +	../file-tracked
    @@ t/t2205-add-worktree-config.sh (new)
     +	inside-untracked/file
     +	EOF
     +
    ++	cat >expect-all-dir-unsorted <<-EOF &&
    ++	../file-untracked
    ++	../file-tracked
    ++	../outside-untracked/
    ++	../outside-tracked/
    ++	./
    ++	EOF
    ++
     +	cat expect-tracked-unsorted expect-untracked-unsorted >expect-all-unsorted &&
     +
     +	cat >.gitignore <<-EOF
    @@ t/t2205-add-worktree-config.sh (new)
     +	actual-*
     +	expect-*
     +	EOF
    ++	)
     +'
     +
     +test_expect_success '1b: pre-add all' '
    ++	(
    ++	cd test1 &&
     +	local parent_dir="$(pwd)" &&
     +	(
    -+		cd test1 &&
    ++		cd repo &&
     +		git ls-files -o --exclude-standard "$parent_dir" >../actual-all-unsorted
     +	) &&
     +	sort actual-all-unsorted >actual-all &&
     +	sort expect-all-unsorted >expect-all &&
     +	test_cmp expect-all actual-all
    ++	)
     +'
     +
    -+test_expect_success '1c: post-add tracked' '
    ++test_expect_success '1c: pre-add dir all' '
    ++	(
    ++	cd test1 &&
     +	local parent_dir="$(pwd)" &&
     +	(
    -+		cd test1 &&
    ++		cd repo &&
    ++		git ls-files -o --directory --exclude-standard "$parent_dir" >../actual-all-dir-unsorted
    ++	) &&
    ++	sort actual-all-dir-unsorted >actual-all &&
    ++	sort expect-all-dir-unsorted >expect-all &&
    ++	test_cmp expect-all actual-all
    ++	)
    ++'
    ++
    ++test_expect_success '1d: post-add tracked' '
    ++	(
    ++	cd test1 &&
    ++	local parent_dir="$(pwd)" &&
    ++	(
    ++		cd repo &&
     +		git add file-tracked &&
     +		git add inside-tracked &&
     +		git add ../outside-tracked &&
    @@ t/t2205-add-worktree-config.sh (new)
     +	sort actual-tracked-unsorted >actual-tracked &&
     +	sort expect-tracked-unsorted >expect-tracked &&
     +	test_cmp expect-tracked actual-tracked
    ++	)
     +'
     +
    -+test_expect_success '1d: post-add untracked' '
    ++test_expect_success '1e: post-add untracked' '
    ++	(
    ++	cd test1 &&
     +	local parent_dir="$(pwd)" &&
     +	(
    -+		cd test1 &&
    ++		cd repo &&
     +		git ls-files -o --exclude-standard "$parent_dir" >../actual-untracked-unsorted
     +	) &&
     +	sort actual-untracked-unsorted >actual-untracked &&
     +	sort expect-untracked-unsorted >expect-untracked &&
     +	test_cmp expect-untracked actual-untracked
    ++	)
    ++'
    ++
    ++test_expect_success '2a: setup--set git-dir' '
    ++	mkdir test2 &&
    ++	(
    ++	cd test2 &&
    ++	test_create_repo repo &&
    ++	# create two foreign repositories that should remain untracked
    ++	test_create_repo repo-outside &&
    ++	test_create_repo repo/repo-inside &&
    ++
    ++	mkdir -p repo/inside-tracked repo/inside-untracked &&
    ++	>repo/file-tracked &&
    ++	>repo/file-untracked &&
    ++	>repo/inside-tracked/file &&
    ++	>repo/inside-untracked/file &&
    ++	>repo-outside/file &&
    ++	>repo/repo-inside/file &&
    ++
    ++	cat >expect-tracked-unsorted <<-EOF &&
    ++	repo/file-tracked
    ++	repo/inside-tracked/file
    ++	EOF
    ++
    ++	cat >expect-untracked-unsorted <<-EOF &&
    ++	repo/file-untracked
    ++	repo/inside-untracked/file
    ++	repo/repo-inside/
    ++	repo-outside/
    ++	EOF
    ++
    ++	cat >expect-all-dir-unsorted <<-EOF &&
    ++	repo/
    ++	repo-outside/
    ++	EOF
    ++
    ++	cat expect-tracked-unsorted expect-untracked-unsorted >expect-all-unsorted &&
    ++
    ++	cat >.gitignore <<-EOF
    ++	.gitignore
    ++	actual-*
    ++	expect-*
    ++	EOF
    ++	)
    ++'
    ++
    ++test_expect_success '2b: pre-add all' '
    ++	(
    ++	cd test2 &&
    ++	git --git-dir=repo/.git ls-files -o --exclude-standard >actual-all-unsorted &&
    ++	sort actual-all-unsorted >actual-all &&
    ++	sort expect-all-unsorted >expect-all &&
    ++	test_cmp expect-all actual-all
    ++	)
    ++'
    ++
    ++test_expect_success '2c: pre-add dir all' '
    ++	(
    ++	cd test2 &&
    ++	git --git-dir=repo/.git ls-files -o --directory --exclude-standard >actual-all-dir-unsorted &&
    ++	sort actual-all-dir-unsorted >actual-all &&
    ++	sort expect-all-dir-unsorted >expect-all &&
    ++	test_cmp expect-all actual-all
    ++	)
    ++'
    ++
    ++test_expect_success '2d: post-add tracked' '
    ++	(
    ++	cd test2 &&
    ++	git --git-dir=repo/.git add repo/file-tracked &&
    ++	git --git-dir=repo/.git add repo/inside-tracked &&
    ++	git --git-dir=repo/.git ls-files >actual-tracked-unsorted &&
    ++	sort actual-tracked-unsorted >actual-tracked &&
    ++	sort expect-tracked-unsorted >expect-tracked &&
    ++	test_cmp expect-tracked actual-tracked
    ++	)
    ++'
    ++
    ++test_expect_success '2e: post-add untracked' '
    ++	(
    ++	cd test2 &&
    ++	git --git-dir=repo/.git ls-files -o --exclude-standard >actual-untracked-unsorted &&
    ++	sort actual-untracked-unsorted >actual-untracked &&
    ++	sort expect-untracked-unsorted >expect-untracked &&
    ++	test_cmp expect-untracked actual-untracked
    ++	)
    ++'
    ++
    ++test_expect_success '3a: setup--add repo dir' '
    ++	mkdir test3 &&
    ++	(
    ++	cd test3 &&
    ++	test_create_repo repo &&
    ++
    ++	mkdir -p repo/inside-tracked repo/inside-ignored &&
    ++	>repo/file-tracked &&
    ++	>repo/file-ignored &&
    ++	>repo/inside-tracked/file &&
    ++	>repo/inside-ignored/file &&
    ++
    ++	cat >.gitignore <<-EOF &&
    ++	.gitignore
    ++	actual-*
    ++	expect-*
    ++	*ignored
    ++	EOF
    ++
    ++	cat >expect-tracked-unsorted <<-EOF &&
    ++	repo/file-tracked
    ++	repo/inside-tracked/file
    ++	EOF
    ++
    ++	cat >expect-ignored-unsorted <<-EOF
    ++	repo/file-ignored
    ++	repo/inside-ignored/
    ++	.gitignore
    ++	actual-ignored-unsorted
    ++	expect-ignored-unsorted
    ++	expect-tracked-unsorted
    ++	EOF
    ++	)
    ++'
    ++
    ++test_expect_success '3b: ignored' '
    ++	(
    ++	cd test3 &&
    ++	git --git-dir=repo/.git ls-files -io --directory --exclude-standard >actual-ignored-unsorted &&
    ++	sort actual-ignored-unsorted >actual-ignored &&
    ++	sort expect-ignored-unsorted >expect-ignored &&
    ++	test_cmp expect-ignored actual-ignored
    ++	)
    ++'
    ++
    ++test_expect_success '3c: add repo' '
    ++	(
    ++	cd test3 &&
    ++	git --git-dir=repo/.git add repo &&
    ++	git --git-dir=repo/.git ls-files >actual-tracked-unsorted &&
    ++	sort actual-tracked-unsorted >actual-tracked &&
    ++	sort expect-tracked-unsorted >expect-tracked &&
    ++	test_cmp expect-tracked actual-tracked
    ++	)
     +'
     +
     +test_done
-:  ---------- > 2:  16e87a0345 dir: cache git_dir's realpath
2:  2e0a178c78 ! 3:  6de7932731 dir: minor refactoring / clean-up
    @@ Metadata
      ## Commit message ##
         dir: minor refactoring / clean-up
     
    -    Improve readability.
    +    Narrow the scope of the `nested_repo` variable and conditional return
    +    statement to the block where the variable is set.
     
         Signed-off-by: Goss Geppert <ggossdev@gmail.com>
     
    @@ dir.c: static enum path_treatment treat_directory(struct dir_struct *dir,
      	/* The "len-1" is to strip the final '/' */
      	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
     @@ dir.c: static enum path_treatment treat_directory(struct dir_struct *dir,
    - 		 *    configured by the user; see t2205 testcases 1a-1d for examples
    - 		 *    where this matters
    + 		 *    manually configured by the user; see t2205 testcases 1-3 for
    + 		 *    examples where this matters
      		 */
     +		int nested_repo;
      		struct strbuf sb = STRBUF_INIT;
-- 
2.36.0

