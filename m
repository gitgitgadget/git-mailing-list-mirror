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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAFAC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DCE610CE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhILNYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhILNYs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E367AC061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so4686235wms.4
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TOzlI+t42vBKy2ynLf5miErvfbcqmgAVxkqUykJm7v8=;
        b=VL7QUdQXiviXp4CQUhhhVTps36za/VhJTHJVE2JfUoZhdH3UY4bV858dpcvUqFzMdQ
         qjY0fljEpdKepImIlrdKrise3k74JfhEgjhJ0c2S2SKQTe20su5rkghnFM+gfg3gqSte
         5y2qHIV2HyR5G1oMSX6c+ph48E3GJU6WajFO7R96S25RtK2naAK9Q3EvM/tcHNim00wU
         olAG2kZMpzuI9swOUN3r6eG7MPsMhaWPTFGHOzYCvAYWl1QN/ropo3Ss8aMiTLM16m+U
         jGMcV7tiF+KWo7o2kT40SOekhYXzTnjB9DGIhADWIsfdWBVRB9BrljkjOaXJfEvCX7VL
         Ny+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TOzlI+t42vBKy2ynLf5miErvfbcqmgAVxkqUykJm7v8=;
        b=yU3bzkbHUUsMZ9ZN1CjdEIKxXAhgCCkyWo51JDAhi6R5rGgiZc6jPNYC0sY8rsBHLZ
         PX5giUsHsTv4N0L01IeJOiJ3lUnHMTgpdl/P7rpd76kCbpjAm0iYqo1Ngqmb9qRh6l5N
         M93qVDjIzz+XHcirc7l4PSzCe3BPuRmFxo30RH9TUIJuDXNs/VR8mu6AGTlhUxUqq+Ao
         kfQK3HHnspDB+amobae4xV/M/0xJPRgq09iNu6ktq2tHgXZOG16E1/f4E4Wj9MCWbRt2
         UQCeA/DV4pwS0zDmR/NHVwXIkFXqe2sZW2/1JJ5kJvzlje27Vv82lAyM84tUe1+RuC28
         4MxQ==
X-Gm-Message-State: AOAM53399fWfN5oezF7fQ9GQcuepSXN58pMdWKhEWqRbx98XAo0fBkGA
        WCNl7vVqHONMv+lQZJwyiBzqfzsUcf4=
X-Google-Smtp-Source: ABdhPJyKFKJPTv4o0iU8a8fuwI4M5XTOMJqy56lEpQV8hRJAi5wx9YBxo94nkQNqQVFq4qjVxbgLsA==
X-Received: by 2002:a1c:1dcd:: with SMTP id d196mr6503291wmd.9.1631453012100;
        Sun, 12 Sep 2021 06:23:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm4418306wrr.69.2021.09.12.06.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:31 -0700 (PDT)
Message-Id: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:16 +0000
Subject: [PATCH v2 00/14] Sparse-checkout: modify 'git add', 'git rm', and 'git add' behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/mergies-with-sparse-index.

As requested, this series looks to update the behavior of git add, git rm,
and git mv when they attempt to modify paths outside of the sparse-checkout
cone. In particular, this care is expanded to not just cache entries with
the SKIP_WORKTREE bit, but also paths that do not match the sparse-checkout
definition.

This means that commands that worked before this series can now fail. In
particular, if 'git merge' results in a conflict outside of the
sparse-checkout cone, then 'git add ' will now fail.

In order to allow users to circumvent these protections, a new '--sparse'
option is added that ignores the sparse-checkout patterns and the
SKIP_WORKTREE bit. The message for advice.updateSparsePath is adjusted to
assist with discovery of this option.

There is a subtle issue with git mv in that it does not check the index
until it discovers a directory and then uses the index to find the contained
entries. This means that in non-cone-mode patterns, a pattern such as
"sub/dir" will not match the path "sub" and this can cause an issue.

In order to allow for checking arbitrary paths against the sparse-checkout
patterns, some changes to the underlying pattern matching code is required.
It turns out that there are some bugs in the methods as advertised, but
these bugs were never discovered because of the way methods like
unpack_trees() will check a directory for a pattern match before checking
its contained paths. Our new "check patterns on-demand" approach pokes holes
in that approach, specifically with patterns that match entire directories.


Updates in v2
=============

 * I got no complaints about these restrictions, so this is now a full
   series, not RFC.

 * Thanks to Matheus, several holes are filled with extra testing and
   bugfixes.

 * New patches add --chmod and --renormalize improvements. These are added
   after the --sparse option to make them be one change each.

Thanks, -Stolee

Derrick Stolee (14):
  t3705: test that 'sparse_entry' is unstaged
  t1092: behavior for adding sparse files
  dir: extract directory-matching logic
  dir: select directories correctly
  dir: fix pattern matching on dirs
  add: fail when adding an untracked sparse file
  add: skip tracked paths outside sparse-checkout cone
  add: implement the --sparse option
  add: update --chmod to skip sparse paths
  add: update --renormalize to skip sparse paths
  rm: add --sparse option
  rm: skip sparse paths with missing SKIP_WORKTREE
  mv: refuse to move sparse paths
  advice: update message to suggest '--sparse'

 Documentation/git-add.txt                |   9 +-
 Documentation/git-rm.txt                 |   6 +
 advice.c                                 |  10 +-
 builtin/add.c                            |  32 +++-
 builtin/mv.c                             |  52 +++++--
 builtin/rm.c                             |  10 +-
 dir.c                                    |  54 ++++++-
 pathspec.c                               |   5 +-
 t/t1091-sparse-checkout-builtin.sh       |   4 +-
 t/t1092-sparse-checkout-compatibility.sh |  75 +++++++--
 t/t3602-rm-sparse-checkout.sh            |  37 ++++-
 t/t3705-add-sparse-checkout.sh           |  65 +++++++-
 t/t7002-mv-sparse-checkout.sh            | 186 +++++++++++++++++++++++
 13 files changed, 494 insertions(+), 51 deletions(-)
 create mode 100755 t/t7002-mv-sparse-checkout.sh


base-commit: 516680ba7704c473bb21628aa19cabbd787df4db
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1018%2Fderrickstolee%2Fsparse-index%2Fadd-rm-mv-behavior-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1018/derrickstolee/sparse-index/add-rm-mv-behavior-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1018

Range-diff vs v1:

  -:  ----------- >  1:  8aefce6254c t3705: test that 'sparse_entry' is unstaged
  1:  69ca54877b4 !  2:  61c23dc59a6 t1092: behavior for adding sparse files
     @@ Commit message
      
          Add some tests to demonstrate the current behavior around adding files
          outside of the sparse-checkout cone. Currently, untracked files are
     -    handled differently from tracked files. A futuer change will make these
     +    handled differently from tracked files. A future change will make these
          cases be handled the same way.
      
     +    Further expand checking that a failed 'git add' does not stage changes
     +    to the index.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_sparse_match () {
     + 	test_cmp sparse-checkout-err sparse-index-err
     + }
     + 
     ++test_sparse_unstaged () {
     ++	file=$1 &&
     ++	for repo in sparse-checkout sparse-index
     ++	do
     ++		git -C $repo status --porcelain >$repo-out &&
     ++		! grep "^A  $file\$" $repo-out &&
     ++		! grep "^M  $file\$" $repo-out || return 1
     ++	done
     ++}
     ++
     + test_expect_success 'sparse-index contents' '
     + 	init_repos &&
     + 
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add, commit, checkout' '
       	test_all_match git checkout -
       '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add, commit, chec
      +	run_on_sparse ../edit-contents folder1/a &&
      +	run_on_sparse ../edit-contents folder1/newfile &&
      +	test_sparse_match test_must_fail git add folder1/a &&
     ++	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	test_sparse_unstaged folder1/a &&
      +	test_sparse_match git add folder1/newfile
      +'
      +
       test_expect_success 'commit including unstaged changes' '
       	init_repos &&
       
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'status/add: outside sparse cone' '
     + 
     + 	# Adding the path outside of the sparse-checkout cone should fail.
     + 	test_sparse_match test_must_fail git add folder1/a &&
     ++	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	test_sparse_unstaged folder1/a &&
     + 	test_sparse_match test_must_fail git add --refresh folder1/a &&
     ++	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	test_sparse_unstaged folder1/a &&
     + 
     + 	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
     + 	test_sparse_match git add folder1/new &&
  2:  8cca5bcf405 =  3:  747b52e7bde dir: extract directory-matching logic
  3:  d47c7a1cf2a =  4:  723de4e4258 dir: select directories correctly
  4:  58e7df44982 =  5:  ed2472d33f1 dir: fix pattern matching on dirs
  5:  e80fcfa932c !  6:  bac6cedfc8d add: fail when adding an untracked sparse file
     @@ Commit message
          want to avoid modifying the index outside of the sparse-checkout cone.
      
          Add a check within add_files() for these files and write the advice
     -    about files outside of the sprase-checkout cone.
     +    about files outside of the sparse-checkout cone.
      
          This behavior change modifies some existing tests within t1092. These
          tests intended to document how a user could interact with the existing
     @@ builtin/add.c: static void check_embedded_repo(const char *path)
       static int add_files(struct dir_struct *dir, int flags)
       {
       	int i, exit_status = 0;
     -+	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
     ++	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
       
       	if (dir->ignored_nr) {
       		fprintf(stderr, _(ignore_error));
     @@ builtin/add.c: static int add_files(struct dir_struct *dir, int flags)
       
       	for (i = 0; i < dir->nr; i++) {
      +		if (!path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
     -+			string_list_append(&only_match_skip_worktree,
     ++			string_list_append(&matched_sparse_paths,
      +					   dir->entries[i]->name);
      +			continue;
      +		}
     @@ builtin/add.c: static int add_files(struct dir_struct *dir, int flags)
       		}
       	}
      +
     -+	if (only_match_skip_worktree.nr) {
     -+		advise_on_updating_sparse_paths(&only_match_skip_worktree);
     ++	if (matched_sparse_paths.nr) {
     ++		advise_on_updating_sparse_paths(&matched_sparse_paths);
      +		exit_status = 1;
      +	}
      +
     -+	string_list_clear(&only_match_skip_worktree, 0);
     ++	string_list_clear(&matched_sparse_paths, 0);
      +
       	return exit_status;
       }
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add, commit, chec
       	init_repos &&
       
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add outside sparse cone' '
     - 	run_on_sparse ../edit-contents folder1/a &&
     - 	run_on_sparse ../edit-contents folder1/newfile &&
       	test_sparse_match test_must_fail git add folder1/a &&
     + 	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 	test_sparse_unstaged folder1/a &&
      -	test_sparse_match git add folder1/newfile
     -+	test_sparse_match test_must_fail git add folder1/newfile
     ++	test_sparse_match test_must_fail git add folder1/newfile &&
     ++	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	test_sparse_unstaged folder1/newfile
       '
       
       test_expect_success 'commit including unstaged changes' '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'commit including
       
       	# folder1 is at HEAD, but outside the sparse cone
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'status/add: outside sparse cone' '
     - 	# Adding the path outside of the sparse-checkout cone should fail.
     - 	test_sparse_match test_must_fail git add folder1/a &&
       	test_sparse_match test_must_fail git add --refresh folder1/a &&
     + 	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 	test_sparse_unstaged folder1/a &&
      +	test_sparse_match test_must_fail git add folder1/new &&
     ++	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	test_sparse_unstaged folder1/new &&
       
      -	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
      -	test_sparse_match git add folder1/new &&
  6:  eeba97ad492 <  -:  ----------- add: skip paths that are outside sparse-checkout cone
  8:  f1764f9ed18 !  7:  d4706e17cae add: prevent adding sparse conflict files
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    add: prevent adding sparse conflict files
     +    add: skip tracked paths outside sparse-checkout cone
      
     -    When a merge results in a conflict outside of the sparse-checkout cone,
     -    the conflicted file is written to the working tree and the index entry
     -    loses the SKIP_WORKTREE bit. This allows users to add the file to the
     -    index without realizing that the file might leave the working tree in a
     -    later Git command.
     +    When 'git add' adds a tracked file that is outside of the
     +    sparse-checkout cone, it checks the SKIP_WORKTREE bit to see if the file
     +    exists outside of the sparse-checkout cone. This is usually correct,
     +    except in the case of a merge conflict outside of the cone.
      
     -    Block this behavior, but keep in mind that the user can override the
     -    failure using the '--sparse' option.
     +    Modify add_pathspec_matched_against_index() to be more careful about
     +    paths by checking the sparse-checkout patterns in addition to the
     +    SKIP_WORKTREE bit. This causes 'git add' to no longer allow files
     +    outside of the cone that removed the SKIP_WORKTREE bit due to a merge
     +    conflict.
     +
     +    With only this change, users will only be able to add the file after
     +    adding the file to the sparse-checkout cone. A later change will allow
     +    users to force adding even though the file is outside of the
     +    sparse-checkout cone.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + ## builtin/add.c ##
     +@@ builtin/add.c: static void update_callback(struct diff_queue_struct *q,
     + 	for (i = 0; i < q->nr; i++) {
     + 		struct diff_filepair *p = q->queue[i];
     + 		const char *path = p->one->path;
     ++
     ++		if (!path_in_sparse_checkout(path, &the_index))
     ++			continue;
     ++
     + 		switch (fix_unmerged_status(p, data)) {
     + 		default:
     + 			die(_("unexpected diff status %c"), p->status);
     +
       ## pathspec.c ##
     +@@ pathspec.c: void add_pathspec_matches_against_index(const struct pathspec *pathspec,
     + 		return;
     + 	for (i = 0; i < istate->cache_nr; i++) {
     + 		const struct cache_entry *ce = istate->cache[i];
     +-		if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
     ++		if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
     ++		    (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
     + 			continue;
     + 		ce_path_match(istate, ce, pathspec, seen);
     + 	}
      @@ pathspec.c: char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
       
       	for (i = 0; i < istate->cache_nr; i++) {
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'sparse-checkout reapply
       	test_must_be_empty err &&
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
     -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge with conflict outside cone' '
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with conflict outside cone' '
       	test_all_match git status --porcelain=v2 &&
       
       	# 2. Add the file with conflict markers
      -	# NEEDSWORK: Even though the merge conflict removed the
      -	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
     --	# warn that this is a problematic add when --sparse is not set.
     +-	# warn that this is a problematic add.
     +-	test_all_match git add folder1/a &&
      +	test_sparse_match test_must_fail git add folder1/a &&
      +	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     - 	test_all_match git add --sparse folder1/a &&
     ++	test_sparse_unstaged folder1/a &&
     ++	test_all_match git add --sparse folder1/a &&
       	test_all_match git status --porcelain=v2 &&
       
     -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge with conflict outside cone' '
     - 	#    accept conflict markers as resolved content.
     - 	run_on_all mv folder2/a folder2/z &&
     - 	test_sparse_match test_must_fail git add folder2 &&
     + 	# 3. Rename the file to another sparse filename and
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with conflict outside cone' '
     + 	# NEEDSWORK: This mode now fails, because folder2/z is
     + 	# outside of the sparse-checkout cone and does not match an
     + 	# existing index entry with the SKIP_WORKTREE bit cleared.
     +-	test_all_match git add folder2 &&
     ++	test_sparse_match test_must_fail git add folder2 &&
      +	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     - 	test_all_match git add --sparse folder2 &&
     ++	test_sparse_unstaged folder2/z &&
     ++	test_all_match git add --sparse folder2 &&
       	test_all_match git status --porcelain=v2 &&
       
     + 	test_all_match git merge --continue &&
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
     + 		# NEEDSWORK: Even though the merge conflict removed the
     + 		# SKIP_WORKTREE bit from the index entry for folder1/a, we should
     + 		# warn that this is a problematic add.
     +-		test_all_match git add folder1/a &&
     ++		test_sparse_match test_must_fail git add folder1/a &&
     ++		test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++		test_sparse_unstaged folder1/a &&
     + 		test_all_match git status --porcelain=v2 &&
     + 
     + 		# 3. Rename the file to another sparse filename and
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
     + 		# outside of the sparse-checkout cone and does not match an
     + 		# existing index entry with the SKIP_WORKTREE bit cleared.
     + 		run_on_all mv folder2/a folder2/z &&
     +-		test_all_match git add folder2 &&
     ++		test_sparse_match test_must_fail git add folder2 &&
     ++		test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++		test_sparse_unstaged folder2/z &&
     + 		test_all_match git status --porcelain=v2 &&
     + 
     + 		test_all_match git $OPERATION --continue &&
     +
     + ## t/t3705-add-sparse-checkout.sh ##
     +@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'do not warn when pathspec matches dense entries' '
     + 	git ls-files --error-unmatch dense_entry
     + '
     + 
     ++test_expect_success 'git add fails outside of sparse-checkout definition' '
     ++	test_when_finished git sparse-checkout disable &&
     ++	test_commit a &&
     ++	git sparse-checkout init &&
     ++	git sparse-checkout set a &&
     ++	echo >>sparse_entry &&
     ++
     ++	git update-index --no-skip-worktree sparse_entry &&
     ++	test_must_fail git add sparse_entry &&
     ++	test_sparse_entry_unstaged
     ++'
     ++
     + test_expect_success 'add obeys advice.updateSparsePath' '
     + 	setup_sparse_entry &&
     + 	test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
  7:  6edadbc2000 !  8:  944ae2cffa8 add: implement the --sparse option
     @@ builtin/add.c: static int chmod_pathspec(struct pathspec *pathspec, char flip, i
       			continue;
       
       		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
     +@@ builtin/add.c: static void update_callback(struct diff_queue_struct *q,
     + 		struct diff_filepair *p = q->queue[i];
     + 		const char *path = p->one->path;
     + 
     +-		if (!path_in_sparse_checkout(path, &the_index))
     ++		if (!include_sparse && !path_in_sparse_checkout(path, &the_index))
     + 			continue;
     + 
     + 		switch (fix_unmerged_status(p, data)) {
      @@ builtin/add.c: static struct option builtin_add_options[] = {
       	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
       	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
     @@ builtin/add.c: static int add_files(struct dir_struct *dir, int flags)
      -		if (!path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
      +		if (!include_sparse &&
      +		    !path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
     - 			string_list_append(&only_match_skip_worktree,
     + 			string_list_append(&matched_sparse_paths,
       					   dir->entries[i]->name);
       			continue;
      @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'commit including
       
       	# folder1 is at HEAD, but outside the sparse cone
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'status/add: outside sparse cone' '
     - 	test_sparse_match test_must_fail git add folder1/a &&
     - 	test_sparse_match test_must_fail git add --refresh folder1/a &&
       	test_sparse_match test_must_fail git add folder1/new &&
     + 	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 	test_sparse_unstaged folder1/new &&
      +	test_sparse_match git add --sparse folder1/a &&
      +	test_sparse_match git add --sparse folder1/new &&
       
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge, cherry-pic
       
       	test_all_match git checkout -b merge-tip merge-left &&
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with conflict outside cone' '
     - 	# 2. Add the file with conflict markers
     - 	# NEEDSWORK: Even though the merge conflict removed the
     - 	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
     --	# warn that this is a problematic add.
     --	test_sparse_match test_must_fail git add folder1/a &&
     -+	# warn that this is a problematic add when --sparse is not set.
     -+	test_all_match git add --sparse folder1/a &&
     - 	test_all_match git status --porcelain=v2 &&
     - 
       	# 3. Rename the file to another sparse filename and
       	#    accept conflict markers as resolved content.
       	run_on_all mv folder2/a folder2/z &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with confli
      -	# outside of the sparse-checkout cone and does not match an
      -	# existing index entry with the SKIP_WORKTREE bit cleared.
       	test_sparse_match test_must_fail git add folder2 &&
     -+	test_all_match git add --sparse folder2 &&
     - 	test_all_match git status --porcelain=v2 &&
     + 	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 	test_sparse_unstaged folder2/z &&
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with conflict outside cone' '
     + 	test_all_match git rev-parse HEAD^{tree}
     + '
     + 
     +-test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
     ++test_expect_success 'cherry-pick/rebase with conflict outside cone' '
     + 	init_repos &&
       
     - 	test_all_match git merge --continue &&
     + 	for OPERATION in cherry-pick rebase
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
     + 		test_sparse_match test_must_fail git add folder1/a &&
     + 		test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 		test_sparse_unstaged folder1/a &&
     ++		test_all_match git add --sparse folder1/a &&
     + 		test_all_match git status --porcelain=v2 &&
     + 
     + 		# 3. Rename the file to another sparse filename and
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
     + 		test_sparse_match test_must_fail git add folder2 &&
     + 		test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 		test_sparse_unstaged folder2/z &&
     ++		test_all_match git add --sparse folder2 &&
     + 		test_all_match git status --porcelain=v2 &&
     + 
     + 		test_all_match git $OPERATION --continue &&
      
       ## t/t3705-add-sparse-checkout.sh ##
     +@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add fails outside of sparse-checkout definition' '
     + 
     + 	git update-index --no-skip-worktree sparse_entry &&
     + 	test_must_fail git add sparse_entry &&
     +-	test_sparse_entry_unstaged
     ++	test_sparse_entry_unstaged &&
     ++
     ++	# Avoid munging CRLFs to avoid an error message
     ++	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
     ++	test_must_be_empty stderr &&
     ++	test-tool read-cache --table >actual &&
     ++	grep "^100644 blob.*sparse_entry\$" actual
     + '
     + 
     + test_expect_success 'add obeys advice.updateSparsePath' '
      @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'add obeys advice.updateSparsePath' '
       
       '
     @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'add obeys advice.updateSpar
      +	git sparse-checkout set a &&
      +	echo modified >sparse_entry &&
      +	test_must_fail git add sparse_entry &&
     ++	test_sparse_entry_unchanged &&
      +	git add --sparse sparse_entry 2>stderr &&
      +	test_must_be_empty stderr
      +'
  -:  ----------- >  9:  7ace030c709 add: update --chmod to skip sparse paths
  -:  ----------- > 10:  f34be166097 add: update --renormalize to skip sparse paths
  9:  6c9c986ff43 ! 11:  fb3f86efa9b rm: add --sparse option
     @@ Metadata
       ## Commit message ##
          rm: add --sparse option
      
     +    As we did previously in 'git add', add a '--sparse' option to 'git rm'
     +    that allows modifying paths outside of the sparse-checkout definition.
     +    The existing checks in 'git rm' are restricted to tracked files that
     +    have the SKIP_WORKTREE bit in the current index. Future changes will
     +    cause 'git rm' to reject removing paths outside of the sparse-checkout
     +    definition, even if they are untracked or do not have the SKIP_WORKTREE
     +    bit.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-rm.txt ##
     @@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
       				die(_("pathspec '%s' did not match any files"), original);
      
       ## t/t3602-rm-sparse-checkout.sh ##
     -@@ t/t3602-rm-sparse-checkout.sh: done
     - 
     - test_expect_success 'recursive rm does not remove sparse entries' '
     - 	git reset --hard &&
     --	git sparse-checkout set sub/dir &&
     -+	git sparse-checkout set sub/dir/ &&
     - 	git rm -r sub &&
     - 	git status --porcelain -uno >actual &&
     - 	echo "D  sub/dir/e" >expected &&
     +@@ t/t3602-rm-sparse-checkout.sh: test_expect_success 'recursive rm does not remove sparse entries' '
       	test_cmp expected actual
       '
       
 10:  5153accded4 ! 12:  de0c9d09ef7 rm: skip sparse paths with missing SKIP_WORKTREE
     @@ Commit message
          if the '--sparse' option is specified, allowing users who accept the
          risks to continue with the removal.
      
     +    This also removes a confusing behavior where a user asks for a directory
     +    to be removed, but only the entries that are within the sparse-checkout
     +    definition are removed. Now, 'git rm <dir>' will fail without '--sparse'
     +    and will succeed in removing all contained paths with '--sparse'.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/rm.c ##
     @@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
       			continue;
      
       ## t/t3602-rm-sparse-checkout.sh ##
     +@@ t/t3602-rm-sparse-checkout.sh: done
     + test_expect_success 'recursive rm does not remove sparse entries' '
     + 	git reset --hard &&
     + 	git sparse-checkout set sub/dir &&
     +-	git rm -r sub &&
     ++	test_must_fail git rm -r sub &&
     ++	git rm --sparse -r sub &&
     + 	git status --porcelain -uno >actual &&
     +-	echo "D  sub/dir/e" >expected &&
     ++	cat >expected <<-\EOF &&
     ++	D  sub/d
     ++	D  sub/dir/e
     ++	EOF
     + 	test_cmp expected actual
     + '
     + 
      @@ t/t3602-rm-sparse-checkout.sh: test_expect_success 'do not warn about sparse entries with --ignore-unmatch' '
       	git ls-files --error-unmatch b
       '
 11:  d31c6411806 ! 13:  e17a529332d mv: refuse to move sparse paths
     @@ Commit message
          mechanism for seeing if a path is sparse or not. Be sure to skip
          returning a failure if '-k' is specified.
      
     +    To ensure that the advice around sparse paths is the only reason a move
     +    failed, be sure to check this as the very last thing before inserting
     +    into the src_for_dst list.
     +
     +    The tests cover a variety of cases such as whether the target is tracked
     +    or untracked, and whether the source or destination are in or outside of
     +    the sparse-checkout definition.
     +
     +    Helped-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/mv.c ##
     -@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
     +@@ builtin/mv.c: static int index_range_of_same_dir(const char *src, int length,
     + int cmd_mv(int argc, const char **argv, const char *prefix)
     + {
     + 	int i, flags, gitmodules_modified = 0;
     +-	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
     ++	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
     + 	struct option builtin_mv_options[] = {
     + 		OPT__VERBOSE(&verbose, N_("be verbose")),
     + 		OPT__DRY_RUN(&show_only, N_("dry run")),
     + 		OPT__FORCE(&force, N_("force move/rename even if target exists"),
     + 			   PARSE_OPT_NOCOMPLETE),
     + 		OPT_BOOL('k', NULL, &ignore_errors, N_("skip move/rename errors")),
     ++		OPT_BOOL(0, "sparse", &ignore_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
     + 		OPT_END(),
     + 	};
     + 	const char **source, **destination, **dest_path, **submodule_gitfile;
     +-	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
     ++	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
     + 	struct stat st;
       	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
       	struct lock_file lock_file = LOCK_INIT;
       	struct cache_entry *ce;
     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
       		if (show_only)
       			printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
       
     -+		if (!path_in_sparse_checkout(src, &the_index)) {
     -+			string_list_append(&only_match_skip_worktree, src);
     -+			skip_sparse = 1;
     -+		}
     -+		if (!path_in_sparse_checkout(dst, &the_index)) {
     -+			string_list_append(&only_match_skip_worktree, dst);
     -+			skip_sparse = 1;
     -+		}
     -+		if (skip_sparse)
     -+			continue;
     -+
       		length = strlen(src);
     - 		if (lstat(src, &st) < 0)
     - 			bad = _("bad source");
     +-		if (lstat(src, &st) < 0)
     +-			bad = _("bad source");
     +-		else if (!strncmp(src, dst, length) &&
     ++		if (lstat(src, &st) < 0) {
     ++			/* only error if existence is expected. */
     ++			if (modes[i] != SPARSE)
     ++				bad = _("bad source");
     ++		} else if (!strncmp(src, dst, length) &&
     + 				(dst[length] == 0 || dst[length] == '/')) {
     + 			bad = _("can not move directory into itself");
     + 		} else if ((src_is_dir = S_ISDIR(st.st_mode))
     +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
     + 				dst_len = strlen(dst);
     + 
     + 				for (j = 0; j < last - first; j++) {
     +-					const char *path = active_cache[first + j]->name;
     ++					const struct cache_entry *ce = active_cache[first + j];
     ++					const char *path = ce->name;
     + 					source[argc + j] = path;
     + 					destination[argc + j] =
     + 						prefix_path(dst, dst_len, path + length + 1);
     +-					modes[argc + j] = INDEX;
     ++					modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
     + 					submodule_gitfile[argc + j] = NULL;
     + 				}
     + 				argc += last - first;
     +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
     + 			bad = _("multiple sources for the same target");
     + 		else if (is_dir_sep(dst[strlen(dst) - 1]))
     + 			bad = _("destination directory does not exist");
     +-		else
     ++		else {
     ++			/*
     ++			 * We check if the paths are in the sparse-checkout
     ++			 * definition as a very final check, since that
     ++			 * allows us to point the user to the --sparse
     ++			 * option as a way to have a successful run.
     ++			 */
     ++			if (!ignore_sparse &&
     ++			    !path_in_sparse_checkout(src, &the_index)) {
     ++				string_list_append(&only_match_skip_worktree, src);
     ++				skip_sparse = 1;
     ++			}
     ++			if (!ignore_sparse &&
     ++			    !path_in_sparse_checkout(dst, &the_index)) {
     ++				string_list_append(&only_match_skip_worktree, dst);
     ++				skip_sparse = 1;
     ++			}
     ++
     ++			if (skip_sparse)
     ++				goto remove_entry;
     ++
     + 			string_list_insert(&src_for_dst, dst);
     ++		}
     + 
     + 		if (!bad)
     + 			continue;
     + 		if (!ignore_errors)
     + 			die(_("%s, source=%s, destination=%s"),
     + 			     bad, src, dst);
     ++remove_entry:
     + 		if (--argc > 0) {
     + 			int n = argc - i;
     + 			memmove(source + i, source + i + 1,
      @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
       		}
       	}
     @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
       	for (i = 0; i < argc; i++) {
       		const char *src = source[i], *dst = destination[i];
       		enum update_mode mode = modes[i];
     +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
     + 			printf(_("Renaming %s to %s\n"), src, dst);
     + 		if (show_only)
     + 			continue;
     +-		if (mode != INDEX && rename(src, dst) < 0) {
     ++		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
     + 			if (ignore_errors)
     + 				continue;
     + 			die_errno(_("renaming '%s' failed"), src);
      
       ## t/t7002-mv-sparse-checkout.sh (new) ##
      @@
     @@ t/t7002-mv-sparse-checkout.sh (new)
      +"
      +
      +test_expect_success 'mv refuses to move sparse-to-sparse' '
     -+	rm -f e &&
     ++	test_when_finished rm -f e &&
      +	git reset --hard &&
      +	git sparse-checkout set a &&
      +	touch b &&
     @@ t/t7002-mv-sparse-checkout.sh (new)
      +	echo b >>expect &&
      +	echo e >>expect &&
      +	cat sparse_hint >>expect &&
     -+	test_cmp expect stderr
     ++	test_cmp expect stderr &&
     ++	git mv --sparse b e 2>stderr &&
     ++	test_must_be_empty stderr
      +'
      +
      +test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
     -+	rm -f e &&
     ++	test_when_finished rm -f b c e &&
      +	git reset --hard &&
      +	git sparse-checkout set a &&
     ++
     ++	# tracked-to-untracked
      +	touch b &&
      +	git mv -k b e 2>stderr &&
     ++	test_path_exists b &&
     ++	test_path_is_missing e &&
      +	cat sparse_error_header >expect &&
      +	echo b >>expect &&
      +	echo e >>expect &&
      +	cat sparse_hint >>expect &&
     -+	test_cmp expect stderr
     ++	test_cmp expect stderr &&
     ++
     ++	git mv --sparse b e 2>stderr &&
     ++	test_must_be_empty stderr &&
     ++	test_path_is_missing b &&
     ++	test_path_exists e &&
     ++
     ++	# tracked-to-tracked
     ++	git reset --hard &&
     ++	touch b &&
     ++	git mv -k b c 2>stderr &&
     ++	test_path_exists b &&
     ++	test_path_is_missing c &&
     ++	cat sparse_error_header >expect &&
     ++	echo b >>expect &&
     ++	echo c >>expect &&
     ++	cat sparse_hint >>expect &&
     ++	test_cmp expect stderr &&
     ++
     ++	git mv --sparse b c 2>stderr &&
     ++	test_must_be_empty stderr &&
     ++	test_path_is_missing b &&
     ++	test_path_exists c
      +'
      +
      +test_expect_success 'mv refuses to move non-sparse-to-sparse' '
     -+	rm -f e &&
     ++	test_when_finished rm -f b c e &&
      +	git reset --hard &&
      +	git sparse-checkout set a &&
     ++
     ++	# tracked-to-untracked
      +	test_must_fail git mv a e 2>stderr &&
     ++	test_path_exists a &&
     ++	test_path_is_missing e &&
      +	cat sparse_error_header >expect &&
      +	echo e >>expect &&
      +	cat sparse_hint >>expect &&
     -+	test_cmp expect stderr
     ++	test_cmp expect stderr &&
     ++	git mv --sparse a e 2>stderr &&
     ++	test_must_be_empty stderr &&
     ++	test_path_is_missing a &&
     ++	test_path_exists e &&
     ++
     ++	# tracked-to-tracked
     ++	rm e &&
     ++	git reset --hard &&
     ++	test_must_fail git mv a c 2>stderr &&
     ++	test_path_exists a &&
     ++	test_path_is_missing c &&
     ++	cat sparse_error_header >expect &&
     ++	echo c >>expect &&
     ++	cat sparse_hint >>expect &&
     ++	test_cmp expect stderr &&
     ++	git mv --sparse a c 2>stderr &&
     ++	test_must_be_empty stderr &&
     ++	test_path_is_missing a &&
     ++	test_path_exists c
      +'
      +
      +test_expect_success 'mv refuses to move sparse-to-non-sparse' '
     -+	rm -f e &&
     ++	test_when_finished rm -f b c e &&
      +	git reset --hard &&
      +	git sparse-checkout set a e &&
     ++
     ++	# tracked-to-untracked
      +	touch b &&
      +	test_must_fail git mv b e 2>stderr &&
      +	cat sparse_error_header >expect &&
      +	echo b >>expect &&
      +	cat sparse_hint >>expect &&
     -+	test_cmp expect stderr
     ++	test_cmp expect stderr &&
     ++	git mv --sparse b e 2>stderr &&
     ++	test_must_be_empty stderr
      +'
      +
      +test_expect_success 'recursive mv refuses to move (possible) sparse' '
     -+	rm -f e &&
     ++	test_when_finished rm -rf b c e sub2 &&
      +	git reset --hard &&
      +	# Without cone mode, "sub" and "sub2" do not match
      +	git sparse-checkout set sub/dir sub2/dir &&
     ++
     ++	# Add contained contents to ensure we avoid non-existence errors
     ++	mkdir sub/dir2 &&
     ++	touch sub/d sub/dir2/e &&
     ++
      +	test_must_fail git mv sub sub2 2>stderr &&
      +	cat sparse_error_header >expect &&
     -+	echo sub >>expect &&
     -+	echo sub2 >>expect &&
     ++	cat >>expect <<-\EOF &&
     ++	sub/d
     ++	sub2/d
     ++	sub/dir/e
     ++	sub2/dir/e
     ++	sub/dir2/e
     ++	sub2/dir2/e
     ++	EOF
      +	cat sparse_hint >>expect &&
     -+	test_cmp expect stderr
     ++	test_cmp expect stderr &&
     ++	git mv --sparse sub sub2 2>stderr &&
     ++	test_must_be_empty stderr &&
     ++	git commit -m "moved sub to sub2" &&
     ++	git rev-parse HEAD~1:sub >expect &&
     ++	git rev-parse HEAD:sub2 >actual &&
     ++	test_cmp expect actual &&
     ++	git reset --hard HEAD~1
      +'
      +
      +test_expect_success 'recursive mv refuses to move sparse' '
     @@ t/t7002-mv-sparse-checkout.sh (new)
      +	# Use cone mode so "sub/" matches the sparse-checkout patterns
      +	git sparse-checkout init --cone &&
      +	git sparse-checkout set sub/dir sub2/dir &&
     ++
     ++	# Add contained contents to ensure we avoid non-existence errors
     ++	mkdir sub/dir2 &&
     ++	touch sub/dir2/e &&
     ++
      +	test_must_fail git mv sub sub2 2>stderr &&
      +	cat sparse_error_header >expect &&
     -+	echo sub/dir2/e >>expect &&
     -+	echo sub2/dir2/e >>expect &&
     ++	cat >>expect <<-\EOF &&
     ++	sub/dir2/e
     ++	sub2/dir2/e
     ++	EOF
      +	cat sparse_hint >>expect &&
     -+	test_cmp expect stderr
     ++	test_cmp expect stderr &&
     ++	git mv --sparse sub sub2 2>stderr &&
     ++	test_must_be_empty stderr &&
     ++	git commit -m "moved sub to sub2" &&
     ++	git rev-parse HEAD~1:sub >expect &&
     ++	git rev-parse HEAD:sub2 >actual &&
     ++	test_cmp expect actual &&
     ++	git reset --hard HEAD~1
      +'
      +
      +test_done
 12:  f6c0d4e3a06 <  -:  ----------- mv: add '--sparse' option to ignore sparse-checkout
 13:  7749a69a38f ! 14:  f2abc387822 advice: update message to suggest '--sparse'
     @@ Commit message
          To improve the discoverability of this new functionality, add a message
          to advice.updateSparsePath that mentions the existence of the option.
      
     +    The previous set of changes also modified the purpose of this message to
     +    include possibly a list of paths instead of only a list of pathspecs.
     +    Make the warning message more clear about this new behavior.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## advice.c ##
      @@ advice.c: void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
     + 	if (!pathspec_list->nr)
     + 		return;
     + 
     +-	fprintf(stderr, _("The following pathspecs didn't match any"
     +-			  " eligible path, but they do match index\n"
     +-			  "entries outside the current sparse checkout:\n"));
     ++	fprintf(stderr, _("The following paths and/or pathspecs matched "
     ++			  "paths that exist outside of your\n"
     ++			  "sparse-checkout definition, so will not be "
     ++			  "updated in the index:\n"));
     + 	for_each_string_list_item(item, pathspec_list)
       		fprintf(stderr, "%s\n", item->string);
       
       	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
     @@ advice.c: void advise_on_updating_sparse_paths(struct string_list *pathspec_list
      
       ## t/t3602-rm-sparse-checkout.sh ##
      @@ t/t3602-rm-sparse-checkout.sh: test_expect_success 'setup' "
     + 	git commit -m files &&
     + 
     + 	cat >sparse_error_header <<-EOF &&
     +-	The following pathspecs didn't match any eligible path, but they do match index
     +-	entries outside the current sparse checkout:
     ++	The following paths and/or pathspecs matched paths that exist outside of your
     ++	sparse-checkout definition, so will not be updated in the index:
       	EOF
       
       	cat >sparse_hint <<-EOF &&
     @@ t/t3602-rm-sparse-checkout.sh: test_expect_success 'setup' "
       
      
       ## t/t3705-add-sparse-checkout.sh ##
     -@@ t/t3705-add-sparse-checkout.sh: test_expect_success 'setup' "
     +@@ t/t3705-add-sparse-checkout.sh: test_sparse_entry_unstaged () {
     + 
     + test_expect_success 'setup' "
     + 	cat >sparse_error_header <<-EOF &&
     +-	The following pathspecs didn't match any eligible path, but they do match index
     +-	entries outside the current sparse checkout:
     ++	The following paths and/or pathspecs matched paths that exist outside of your
     ++	sparse-checkout definition, so will not be updated in the index:
       	EOF
       
       	cat >sparse_hint <<-EOF &&
     @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'setup' "
      
       ## t/t7002-mv-sparse-checkout.sh ##
      @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'setup' "
     + 	git commit -m files &&
     + 
     + 	cat >sparse_error_header <<-EOF &&
     +-	The following pathspecs didn't match any eligible path, but they do match index
     +-	entries outside the current sparse checkout:
     ++	The following paths and/or pathspecs matched paths that exist outside of your
     ++	sparse-checkout definition, so will not be updated in the index:
       	EOF
       
       	cat >sparse_hint <<-EOF

-- 
gitgitgadget
