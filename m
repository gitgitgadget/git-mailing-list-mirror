Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0F1C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4F36121D
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbhITXij (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243072AbhITXgh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:36:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD38C0EDAF2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t8so32043697wrq.4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=1Fio1LuOPtd8nwwWcgpeo+DSutCmSdRJSZsobG0KOfQ=;
        b=jq6CQISNdfZwB1kKl3gP3N3/DF4975cY6XXwP3qiFa8+ns7EUNv3PSdfG8yWK59Yta
         8FZCm6ITgBIn7EdUYQpw0SP1ELD/ypJwuTFbCbxQ4B1l4FzfLeN8JKKNMGG+l89KGG7a
         M6EKMcXCvKepETzHjz6QGYTdfjLDpc/LMidsOuVe1RmQGmUUTRktrOpJaPZTTK3Bc0BC
         N9HPLmK4IQz0lDGUuB/lJ7MmkgoDGCnsK6w0tXDCOWSB//bR8LDu/aM9kPjoRatsmNWY
         XN0zMkOd8iwHNE3qUp50wLWBjRFCwOuyrdZc8uRog739dEd3qLICoF+ut9uTV0HaSxp/
         9ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=1Fio1LuOPtd8nwwWcgpeo+DSutCmSdRJSZsobG0KOfQ=;
        b=KhY+nYRzO6p7z6eTWhOYx12EZ73EKu7UlIJfh376czffC9VslD6pr0GvgGRjGgjx3j
         U+xLn+HQEeLKHrnGx6ucCObAyIJj51V7vJuunII1DmjM1OTi2W/CqxEEHRc5982M6Pzj
         8SjnF0aQEeTqsz5q6Rwb00KtNIGzIOYbWI6Xoh81LmwIZ1O4b1KzPlEC1o+UpU+nQ//0
         brIv23tbNa5/Mabi6DYQi5xSAeJBg8B/jRDY60nvM9OYGMCYU33QC1gkVM00ud2sn67u
         0mQ/hv8bEEc053b1M/+yrPonlMIHB2YYX0tMjhjZ/gT9SaBDZaLtiQn12Lfg7AyqZYWb
         ugjQ==
X-Gm-Message-State: AOAM533viNIKVRQi27F1yrDCA0pbN98bqmPESZyPd9MApr+Fuu7ZIypB
        lqAKDX9qZgvB6iPeCxcLjL8eORVUndk=
X-Google-Smtp-Source: ABdhPJxBt0JkZVg0YR7maYZ9IsjLwiayyIqNeNpcmcnXXGorCzAWS0gLCEu4oLhD5Vg4aGaRlBJwGg==
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr29321281wro.425.1632159939056;
        Mon, 20 Sep 2021 10:45:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2sm16821281wra.40.2021.09.20.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:38 -0700 (PDT)
Message-Id: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:23 +0000
Subject: [PATCH v3 00/14] Sparse-checkout: modify 'git add', 'git rm', and 'git add' behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
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


Updates in v3
=============

 * Fixed an incorrectly-squashed commit. Spread out some changes in a better
   way. For example, I don't add --sparse to tests before introducing the
   option.

 * Use a NULL struct strbuf pointer to indicate an uninitialized value
   instead of relying on an internal member.

 * Use grep over test_i18ngrep.

 * Fixed line wrapping for error messages.

 * Use strbuf_setlen() over modifying the len member manually.


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
 advice.c                                 |  11 +-
 builtin/add.c                            |  32 +++-
 builtin/mv.c                             |  52 +++++--
 builtin/rm.c                             |  10 +-
 dir.c                                    |  56 ++++++-
 pathspec.c                               |   5 +-
 t/t1091-sparse-checkout-builtin.sh       |   4 +-
 t/t1092-sparse-checkout-compatibility.sh |  75 +++++++--
 t/t3602-rm-sparse-checkout.sh            |  40 ++++-
 t/t3705-add-sparse-checkout.sh           |  68 +++++++-
 t/t7002-mv-sparse-checkout.sh            | 189 +++++++++++++++++++++++
 13 files changed, 505 insertions(+), 52 deletions(-)
 create mode 100755 t/t7002-mv-sparse-checkout.sh


base-commit: 516680ba7704c473bb21628aa19cabbd787df4db
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1018%2Fderrickstolee%2Fsparse-index%2Fadd-rm-mv-behavior-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1018/derrickstolee/sparse-index/add-rm-mv-behavior-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1018

Range-diff vs v2:

  1:  8aefce6254c !  1:  ea940f10a7c t3705: test that 'sparse_entry' is unstaged
     @@ Commit message
          correctly.
      
          We need to modify setup_sparse_entry to actually commit the sparse_entry
     -    file so it exists at HEAD but is not already staged in the index.
     +    file so it exists at HEAD and as an entry in the index, but its exact
     +    contents are not staged in the index.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ t/t3705-add-sparse-checkout.sh: setup_gitignore () {
       
      +test_sparse_entry_unstaged () {
      +	git status --porcelain >actual &&
     -+	! grep "^M  sparse_entry\$" actual
     ++	! grep "^[MDARCU][M ] sparse_entry\$" actual
      +}
      +
       test_expect_success 'setup' "
  2:  61c23dc59a6 !  2:  c7dedb41291 t1092: behavior for adding sparse files
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add, commit, chec
      +	run_on_sparse ../edit-contents folder1/a &&
      +	run_on_sparse ../edit-contents folder1/newfile &&
      +	test_sparse_match test_must_fail git add folder1/a &&
     -+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
      +	test_sparse_unstaged folder1/a &&
      +	test_sparse_match git add folder1/newfile
      +'
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'status/add: outsi
       
       	# Adding the path outside of the sparse-checkout cone should fail.
       	test_sparse_match test_must_fail git add folder1/a &&
     -+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
      +	test_sparse_unstaged folder1/a &&
       	test_sparse_match test_must_fail git add --refresh folder1/a &&
     -+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
      +	test_sparse_unstaged folder1/a &&
       
       	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
  3:  747b52e7bde =  3:  b1f6468f9cd dir: extract directory-matching logic
  4:  723de4e4258 !  4:  0252c7ee15c dir: select directories correctly
     @@ Commit message
          contained files. However, other commands will start matching individual
          files against pattern lists without that recursive approach.
      
     -    We modify path_matches_dir_pattern() to take a strbuf 'path_parent' that
     -    is used to store the parent directory of 'pathname' between multiple
     -    pattern matching tests. This is loaded lazily, only on the first pattern
     -    it finds that has the PATTERN_FLAG_MUSTBEDIR flag.
     +    We modify path_matches_dir_pattern() to take a strbuf pointer
     +    'path_parent' that is used to store the parent directory of 'pathname'
     +    between multiple pattern matching tests. This is loaded lazily, only on
     +    the first pattern it finds that has the PATTERN_FLAG_MUSTBEDIR flag.
      
          If we find that a path has a parent directory, we start by checking to
          see if that parent directory matches the pattern. If so, then we do not
     @@ Commit message
          the more general -- and slower -- full pattern set. Thus, this does not
          affect the sparse index.
      
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## dir.c ##
     @@ dir.c: int match_pathname(const char *pathname, int pathlen,
       
       static int path_matches_dir_pattern(const char *pathname,
       				    int pathlen,
     -+				    struct strbuf *path_parent,
     ++				    struct strbuf **path_parent,
       				    int *dtype,
       				    struct path_pattern *pattern,
       				    struct index_state *istate)
       {
     -+	/*
     -+	 * Use 'alloc' as an indicator that the string has not been
     -+	 * initialized, in case the parent is the root directory.
     -+	 */
     -+	if (!path_parent->alloc) {
     ++	if (!*path_parent) {
      +		char *slash;
     -+		strbuf_addstr(path_parent, pathname);
     -+		slash = find_last_dir_sep(path_parent->buf);
     ++		CALLOC_ARRAY(*path_parent, 1);
     ++		strbuf_add(*path_parent, pathname, pathlen);
     ++		slash = find_last_dir_sep((*path_parent)->buf);
      +
      +		if (slash)
     -+			*slash = '\0';
     ++			strbuf_setlen(*path_parent, slash - (*path_parent)->buf);
      +		else
     -+			strbuf_setlen(path_parent, 0);
     ++			strbuf_setlen(*path_parent, 0);
      +	}
      +
      +	/*
      +	 * If the parent directory matches the pattern, then we do not
      +	 * need to check for dtype.
      +	 */
     -+	if (path_parent->len &&
     -+	    match_pathname(path_parent->buf, path_parent->len,
     ++	if ((*path_parent)->len &&
     ++	    match_pathname((*path_parent)->buf, (*path_parent)->len,
      +			   pattern->base,
      +			   pattern->baselen ? pattern->baselen - 1 : 0,
      +			   pattern->pattern, pattern->nowildcardlen,
     @@ dir.c: static struct path_pattern *last_matching_pattern_from_list(const char *p
       {
       	struct path_pattern *res = NULL; /* undecided */
       	int i;
     -+	struct strbuf path_parent = STRBUF_INIT;
     ++	struct strbuf *path_parent = NULL;
       
       	if (!pl->nr)
       		return NULL;	/* undefined */
     @@ dir.c: static struct path_pattern *last_matching_pattern_from_list(const char *p
       			break;
       		}
       	}
     -+	strbuf_release(&path_parent);
     ++
     ++	if (path_parent) {
     ++		strbuf_release(path_parent);
     ++		free(path_parent);
     ++	}
     ++
       	return res;
       }
       
  5:  ed2472d33f1 =  5:  c6d17df5e5d dir: fix pattern matching on dirs
  6:  bac6cedfc8d !  6:  3dd1d6c228c add: fail when adding an untracked sparse file
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add, commit, chec
       
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add outside sparse cone' '
       	test_sparse_match test_must_fail git add folder1/a &&
     - 	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
       	test_sparse_unstaged folder1/a &&
      -	test_sparse_match git add folder1/newfile
      +	test_sparse_match test_must_fail git add folder1/newfile &&
     -+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
      +	test_sparse_unstaged folder1/newfile
       '
       
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'commit including
       	# folder1 is at HEAD, but outside the sparse cone
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'status/add: outside sparse cone' '
       	test_sparse_match test_must_fail git add --refresh folder1/a &&
     - 	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
       	test_sparse_unstaged folder1/a &&
      +	test_sparse_match test_must_fail git add folder1/new &&
     -+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
      +	test_sparse_unstaged folder1/new &&
       
      -	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
  7:  d4706e17cae !  7:  15039e031e5 add: skip tracked paths outside sparse-checkout cone
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with confli
      -	# warn that this is a problematic add.
      -	test_all_match git add folder1/a &&
      +	test_sparse_match test_must_fail git add folder1/a &&
     -+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
      +	test_sparse_unstaged folder1/a &&
     -+	test_all_match git add --sparse folder1/a &&
       	test_all_match git status --porcelain=v2 &&
       
       	# 3. Rename the file to another sparse filename and
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with confli
       	# existing index entry with the SKIP_WORKTREE bit cleared.
      -	test_all_match git add folder2 &&
      +	test_sparse_match test_must_fail git add folder2 &&
     -+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
      +	test_sparse_unstaged folder2/z &&
     -+	test_all_match git add --sparse folder2 &&
       	test_all_match git status --porcelain=v2 &&
       
       	test_all_match git merge --continue &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'cherry-pick/rebas
       		# warn that this is a problematic add.
      -		test_all_match git add folder1/a &&
      +		test_sparse_match test_must_fail git add folder1/a &&
     -+		test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
      +		test_sparse_unstaged folder1/a &&
       		test_all_match git status --porcelain=v2 &&
       
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'cherry-pick/rebas
       		run_on_all mv folder2/a folder2/z &&
      -		test_all_match git add folder2 &&
      +		test_sparse_match test_must_fail git add folder2 &&
     -+		test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     ++		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
      +		test_sparse_unstaged folder2/z &&
       		test_all_match git status --porcelain=v2 &&
       
  8:  944ae2cffa8 !  8:  6014ac8ab9e add: implement the --sparse option
     @@ Documentation/git-add.txt: in linkgit:gitglossary[7].
      +	Normally, `git add` refuses to update index entries whose paths do
      +	not fit within the sparse-checkout cone, since those files might
      +	be removed from the working tree without warning. See
     -+	linkgit:git-sparse-checkout[1] for more.
     ++	linkgit:git-sparse-checkout[1] for more details.
      +
       -i::
       --interactive::
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'commit including
       	# folder1 is at HEAD, but outside the sparse cone
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'status/add: outside sparse cone' '
       	test_sparse_match test_must_fail git add folder1/new &&
     - 	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
       	test_sparse_unstaged folder1/new &&
      +	test_sparse_match git add --sparse folder1/a &&
      +	test_sparse_match git add --sparse folder1/new &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge, cherry-pic
       
       	test_all_match git checkout -b merge-tip merge-left &&
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with conflict outside cone' '
     + 	test_sparse_match test_must_fail git add folder1/a &&
     + 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 	test_sparse_unstaged folder1/a &&
     ++	test_all_match git add --sparse folder1/a &&
     + 	test_all_match git status --porcelain=v2 &&
     + 
       	# 3. Rename the file to another sparse filename and
       	#    accept conflict markers as resolved content.
       	run_on_all mv folder2/a folder2/z &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with confli
      -	# outside of the sparse-checkout cone and does not match an
      -	# existing index entry with the SKIP_WORKTREE bit cleared.
       	test_sparse_match test_must_fail git add folder2 &&
     - 	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
       	test_sparse_unstaged folder2/z &&
     ++	test_all_match git add --sparse folder2 &&
     + 	test_all_match git status --porcelain=v2 &&
     + 
     + 	test_all_match git merge --continue &&
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with conflict outside cone' '
       	test_all_match git rev-parse HEAD^{tree}
       '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'merge with confli
       	for OPERATION in cherry-pick rebase
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
       		test_sparse_match test_must_fail git add folder1/a &&
     - 		test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
       		test_sparse_unstaged folder1/a &&
      +		test_all_match git add --sparse folder1/a &&
       		test_all_match git status --porcelain=v2 &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'cherry-pick/rebas
       		# 3. Rename the file to another sparse filename and
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
       		test_sparse_match test_must_fail git add folder2 &&
     - 		test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
     + 		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
       		test_sparse_unstaged folder2/z &&
      +		test_all_match git add --sparse folder2 &&
       		test_all_match git status --porcelain=v2 &&
  9:  7ace030c709 !  9:  2bd3448be5f add: update --chmod to skip sparse paths
     @@ builtin/add.c: static int chmod_pathspec(struct pathspec *pathspec, char flip, i
       		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
      
       ## t/t3705-add-sparse-checkout.sh ##
     -@@ t/t3705-add-sparse-checkout.sh: setup_gitignore () {
     - 
     - test_sparse_entry_unstaged () {
     - 	git status --porcelain >actual &&
     --	! grep "^M  sparse_entry\$" actual
     -+	! grep "^M[ M] sparse_entry\$" actual
     - }
     - 
     - test_expect_success 'setup' "
      @@ t/t3705-add-sparse-checkout.sh: test_expect_success 'git add fails outside of sparse-checkout definition' '
       	test_must_fail git add sparse_entry &&
       	test_sparse_entry_unstaged &&
 10:  f34be166097 = 10:  131beda1bc3 add: update --renormalize to skip sparse paths
 11:  fb3f86efa9b = 11:  837a9314893 rm: add --sparse option
 12:  de0c9d09ef7 = 12:  cc25ce17162 rm: skip sparse paths with missing SKIP_WORKTREE
 13:  e17a529332d = 13:  63a9cd80ade mv: refuse to move sparse paths
 14:  f2abc387822 ! 14:  79a3518dc15 advice: update message to suggest '--sparse'
     @@ advice.c: void advise_on_updating_sparse_paths(struct string_list *pathspec_list
      -	fprintf(stderr, _("The following pathspecs didn't match any"
      -			  " eligible path, but they do match index\n"
      -			  "entries outside the current sparse checkout:\n"));
     -+	fprintf(stderr, _("The following paths and/or pathspecs matched "
     -+			  "paths that exist outside of your\n"
     -+			  "sparse-checkout definition, so will not be "
     ++	fprintf(stderr, _("The following paths and/or pathspecs matched paths that exist\n"
     ++			  "outside of your sparse-checkout definition, so will not be\n"
      +			  "updated in the index:\n"));
       	for_each_string_list_item(item, pathspec_list)
       		fprintf(stderr, "%s\n", item->string);
       
       	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
      -			  _("Disable or modify the sparsity rules if you intend"
     -+			  _("Disable or modify the sparsity rules or"
     -+			    " use the --sparse option if you intend"
     - 			    " to update such entries."));
     +-			    " to update such entries."));
     ++			  _("If you intend to update such entries, try one of the following:\n"
     ++			    "* Use the --sparse option.\n"
     ++			    "* Disable or modify the sparsity rules."));
       }
       
     + void detach_advice(const char *new_name)
      
       ## t/t3602-rm-sparse-checkout.sh ##
      @@ t/t3602-rm-sparse-checkout.sh: test_expect_success 'setup' "
     @@ t/t3602-rm-sparse-checkout.sh: test_expect_success 'setup' "
       	cat >sparse_error_header <<-EOF &&
      -	The following pathspecs didn't match any eligible path, but they do match index
      -	entries outside the current sparse checkout:
     -+	The following paths and/or pathspecs matched paths that exist outside of your
     -+	sparse-checkout definition, so will not be updated in the index:
     ++	The following paths and/or pathspecs matched paths that exist
     ++	outside of your sparse-checkout definition, so will not be
     ++	updated in the index:
       	EOF
       
       	cat >sparse_hint <<-EOF &&
      -	hint: Disable or modify the sparsity rules if you intend to update such entries.
     -+	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
     ++	hint: If you intend to update such entries, try one of the following:
     ++	hint: * Use the --sparse option.
     ++	hint: * Disable or modify the sparsity rules.
       	hint: Disable this message with \"git config advice.updateSparsePath false\"
       	EOF
       
     @@ t/t3705-add-sparse-checkout.sh: test_sparse_entry_unstaged () {
       	cat >sparse_error_header <<-EOF &&
      -	The following pathspecs didn't match any eligible path, but they do match index
      -	entries outside the current sparse checkout:
     -+	The following paths and/or pathspecs matched paths that exist outside of your
     -+	sparse-checkout definition, so will not be updated in the index:
     ++	The following paths and/or pathspecs matched paths that exist
     ++	outside of your sparse-checkout definition, so will not be
     ++	updated in the index:
       	EOF
       
       	cat >sparse_hint <<-EOF &&
      -	hint: Disable or modify the sparsity rules if you intend to update such entries.
     -+	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
     ++	hint: If you intend to update such entries, try one of the following:
     ++	hint: * Use the --sparse option.
     ++	hint: * Disable or modify the sparsity rules.
       	hint: Disable this message with \"git config advice.updateSparsePath false\"
       	EOF
       
     @@ t/t7002-mv-sparse-checkout.sh: test_expect_success 'setup' "
       	cat >sparse_error_header <<-EOF &&
      -	The following pathspecs didn't match any eligible path, but they do match index
      -	entries outside the current sparse checkout:
     -+	The following paths and/or pathspecs matched paths that exist outside of your
     -+	sparse-checkout definition, so will not be updated in the index:
     ++	The following paths and/or pathspecs matched paths that exist
     ++	outside of your sparse-checkout definition, so will not be
     ++	updated in the index:
       	EOF
       
       	cat >sparse_hint <<-EOF
      -	hint: Disable or modify the sparsity rules if you intend to update such entries.
     -+	hint: Disable or modify the sparsity rules or use the --sparse option if you intend to update such entries.
     ++	hint: If you intend to update such entries, try one of the following:
     ++	hint: * Use the --sparse option.
     ++	hint: * Disable or modify the sparsity rules.
       	hint: Disable this message with \"git config advice.updateSparsePath false\"
       	EOF
       "

-- 
gitgitgadget
