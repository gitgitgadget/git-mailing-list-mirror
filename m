Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37E0C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbhK2XNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A2C07E5EF
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:17 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l16so40069405wrp.11
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q19L1OhqS0MpwvGIghUt5V8UdbdNe7C3txmiG0gRqjQ=;
        b=ktiaX1Q+hTFu836AIdlyAHOUg7R88p66LpyzSX3d4o2M+mQvJ8FO1QM7/qf7wBiCkS
         XjfmhJxyNrv881ELPB28B34gsubLLhEh8mZdoDhWrG1WFNQyuAQl34vevzsUfdQg71Nv
         fuhD0qUpOd3IAEw7Lbw51O/gx1Pbx4pCV1Sp8sd5lVUPSHyIAzei7P6lc00QxKQ5d/pB
         XXzxp9mGBgWQQcZz03Ionq7XgntN9Z5IK/32c1yK5MR/nCIFgMDRZnb1qjrBlQAKzNyQ
         mQ5LkmuCae/K0ygUvD1JuFAkXNhmt2/qYGE3GEOyQ98li/mPavogpRenn9t+QF2VGKmN
         uHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q19L1OhqS0MpwvGIghUt5V8UdbdNe7C3txmiG0gRqjQ=;
        b=ckQKkMiBtJ6oXC8kjzsBnetew1ea2ju8G6JO0GlKl20RxLtidrdBqSOhXmtdZAIKBz
         GFDtJ59sX69qyqc7+vsl7/0lldFX1myxhM4Qu+xxF3gnhtSnYFl4KuZQmYMKpkfR0pbl
         85wUE3P6+9TbaBFSEy3q3I75ZSYq37kP7D8pMs2c1bOOP9z82nnnL4miaF6bv6LogvJX
         /YnC5gtMgk87qPxJebvDahrKY32/xjh+SNkbyMmQL9nhE1sjxe21IyUmtZLcU7bha6Co
         YlZxvct34sHcTgCgdgU9Zbv8YVb4dY4+Y66e2fbAcriZ1VVD0fsjQglBKQrZgYGSPvn+
         yHVg==
X-Gm-Message-State: AOAM532PRLfGdbBQ7dlN0/7H82ClTMFkJ6Q4CbIOa7ggY/7WQHf7OHKv
        JVCKdCTyEfuCVSxOWi4SDvWFCkn/GWM=
X-Google-Smtp-Source: ABdhPJwHq2V6FnRiCtuTxhRYE/vy6PQnWmDgeBrrH7uSUGjGlGr3//R8A2sJHixyttWA3bc/dC5qyg==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr33244359wrx.524.1638225435391;
        Mon, 29 Nov 2021 14:37:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm14608199wrw.55.2021.11.29.14.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:14 -0800 (PST)
Message-Id: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:03 +0000
Subject: [PATCH v4 00/11] Avoid removing the current working directory, even if it becomes empty
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Traditionally, if folks run git commands such as checkout or rebase from a
subdirectory, that git command could remove their current working directory
and result in subsequent git and non-git commands either getting confused or
printing messages that confuse the user (e.g. "fatal: Unable to read current
working directory: No such file or directory"). Many commands either
silently avoid removing directories that are not empty (i.e. those that have
untracked or modified files in them)[1], or show an error and abort,
depending on which is more appropriate for the command in question. With
this series, we augment the reasons to avoid removing directories to include
not just has-untracked-or-modified-files, but also to avoid removing the
original_cwd as well.

Peff and Junio provided some good pros/cons, if it helps:

 * Pros: Peff (original suggester of the idea)[2], and Junio[3]
 * Cons: Peff [2, again -- see the "P.S."], and Junio[4]

[1] well, with a few exceptions; see
https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/YS8eEtwQvF7TaLCb@coredump.intra.peff.net/
[3] https://lore.kernel.org/git/xmqqo86elyht.fsf@gitster.g/ [4]
https://lore.kernel.org/git/xmqqo8691gr8.fsf@gitster.g/

Changes since v3:

 * fixed one codepath from v2 so that the series really is only about the
   working tree
 * used test-tool getcwd instead of pwd -P as suggested by Ævar for some
   less common platforms
 * fixed bashism
 * check for clean index/worktree after verifying that expected-to-abort
   codepaths do abort, to make it clearer that we expect an early abort
 * remove a leftover (and confusing) is_absolute_dir() check in sequencer
   and stash from an earlier round of the series

Changes since v2:

 * the series is now only about the working tree. So if the original cwd is
   outside the worktree (or we're in a bare repo), then the new code is a
   no-op.
 * fixed ugly early die() possibility (uses strbuf_getcwd() instead of
   xgetcwd())
 * modified the initial tests to show both expected and desired behavior.
   subsequent patches fix the tests. One new patch added at the end which
   simplifies the tests to only check for desired behavior.
 * NULLify startup_info->original_cwd when it matches the toplevel worktree;
   that is already protected and we don't need secondary protection for it.
   This simplified some other codepaths so we don't have to check for
   startup_info->original_cwd == "".
 * clarified some commit messages

Changes since v1:

 * clarified multiple commit messages
 * renamed the_cwd to startup_info->original_cwd to make it clearer that
   it's our parent process'es cwd that really matters, which we inherited at
   program startup. Also pulls it out of the global namespace.
 * Normalize the path for startup_info->original_cwd, and ensure that it's
   actually the original cwd even if -C is passed to git.
 * small code cleanups suggested by René and Ævar
 * split the final patch (which got the most comments) into two -- one for
   each function being modified. Also, add a bunch more history to the first
   of the two resulting commit messages
 * no longer has a content conflict with so/stash-staged
 * add another value for the flags parameter that remove_dir_recursively()
   takes so that it can opt into either the old or the new behavior. Use
   that for the one special corner case I could find where it matters, and
   add a few tests around it to highlight the utility of the flag.

Elijah Newren (11):
  t2501: add various tests for removing the current working directory
  setup: introduce startup_info->original_cwd
  unpack-trees: refuse to remove startup_info->original_cwd
  unpack-trees: add special cwd handling
  symlinks: do not include startup_info->original_cwd in dir removal
  clean: do not attempt to remove startup_info->original_cwd
  rebase: do not attempt to remove startup_info->original_cwd
  stash: do not attempt to remove startup_info->original_cwd
  dir: avoid incidentally removing the original_cwd in remove_path()
  dir: new flag to remove_dir_recurse() to spare the original_cwd
  t2501: simplify the tests since we can now assume desired behavior

 builtin/clean.c      |  44 +++++--
 builtin/rm.c         |   3 +-
 builtin/stash.c      |   4 +-
 cache.h              |   2 +
 common-main.c        |   4 +
 dir.c                |  15 ++-
 dir.h                |   9 +-
 sequencer.c          |   2 +
 setup.c              |  65 ++++++++++
 symlinks.c           |   8 +-
 t/t2501-cwd-empty.sh | 277 +++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c       |  30 ++++-
 unpack-trees.h       |   1 +
 13 files changed, 442 insertions(+), 22 deletions(-)
 create mode 100755 t/t2501-cwd-empty.sh


base-commit: 88d915a634b449147855041d44875322de2b286d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1140%2Fnewren%2Fcwd_removal-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1140/newren/cwd_removal-v4
Pull-Request: https://github.com/git/git/pull/1140

Range-diff vs v3:

  1:  4b0044656b0 !  1:  a45b3f08802 t2501: add various tests for removing the current working directory
     @@ t/t2501-cwd-empty.sh (new)
      +
      +		# Although we want pwd & git status to pass, test for existing
      +		# rather than desired behavior.
     -+		if [[ $works == "success" ]]; then
     -+			pwd -P &&
     ++		if test "$works" == "success"
     ++		then
     ++			test-tool getcwd &&
      +			git status --porcelain
      +		else
     -+			! pwd -P &&
     ++			! test-tool getcwd &&
      +			test_might_fail git status --porcelain
      +		fi
      +	) &&
     @@ t/t2501-cwd-empty.sh (new)
      +
      +	# Although we want dir to be present, test for existing rather
      +	# than desired behavior.
     -+	if [[ $works == "success" ]]; then
     ++	if test "$works" == "success"
     ++	then
      +		test_path_is_dir foo
      +	else
      +		test_path_is_missing foo
     @@ t/t2501-cwd-empty.sh (new)
      +		cd dirORfile &&
      +
      +		# We'd like for the command to fail (much as it would if there
     -+		# was an untracked file there), and for pwd & git status to
     -+		# succeed afterwards.  But test for existing rather than
     -+		# desired behavior.
     -+		if [[ $works == "success" ]]; then
     ++		# was an untracked file there), and for the index and worktree
     ++		# to be left clean with pwd and git status working afterwards.
     ++		# But test for existing rather than desired behavior.
     ++		if test "$works" == "success"
     ++		then
      +			test_must_fail "$@" 2>../error &&
      +			grep "Refusing to remove.*current working directory" ../error &&
     -+			pwd -P &&
     ++
     ++			git diff --exit-code HEAD &&
     ++
     ++			test-tool getcwd &&
      +			git status --porcelain
      +		else
      +			"$@" &&
     -+			! pwd -P &&
     ++			! test-tool getcwd &&
      +			test_might_fail git status --porcelain
      +		fi
      +	) &&
      +
      +	# Although we want dirORfile to be present, test for existing rather
      +	# than desired behavior.
     -+	if [[ $works == "success" ]]; then
     ++	if test "$works" == "success"
     ++	then
      +		test_path_is_dir dirORfile
      +	else
      +		test_path_is_file dirORfile
     @@ t/t2501-cwd-empty.sh (new)
      +
      +		# Although we want pwd & git status to pass, test for existing
      +		# rather than desired behavior.
     -+		if [[ $works == "success" ]]; then
     -+			pwd -P &&
     ++		if test "$works" == "success"
     ++		then
     ++			test-tool getcwd &&
      +			git status --porcelain
      +		else
     -+			! pwd -P &&
     ++			! test-tool getcwd &&
      +			test_might_fail git status --porcelain
      +		fi
      +	) &&
     @@ t/t2501-cwd-empty.sh (new)
      +
      +	# Although we want dir to be present, test for existing rather
      +	# than desired behavior.
     -+	if [[ $works == "success" ]]; then
     ++	if test "$works" == "success"
     ++	then
      +		test_path_is_dir untracked
      +	else
      +		test_path_is_missing untracked
     @@ t/t2501-cwd-empty.sh (new)
      +	shift &&
      +
      +	test_status=
     -+	test $path_status = dir && test_status=test_must_fail
     ++	test "$path_status" = dir && test_status=test_must_fail
      +
      +	# Actually, while path_status == dir && test_status=test_must_fail
      +	# reflect our desired behavior, current behavior is:
  2:  200ddece05d !  2:  ca9f632bd11 setup: introduce startup_info->original_cwd
     @@ setup.c: void setup_work_tree(void)
      +		startup_info->original_cwd = \
      +			precompose_string_if_needed(startup_info->original_cwd
      +						    + offset);
     ++		return;
      +	}
     -+	return;
      +
      +no_prevention_needed:
      +	free((char*)startup_info->original_cwd);
  3:  68ae90546fe =  3:  41a82eff41e unpack-trees: refuse to remove startup_info->original_cwd
  4:  1bb8905900c =  4:  2e2ea02f97b unpack-trees: add special cwd handling
  5:  8a33d74e7cf =  5:  f444a541da4 symlinks: do not include startup_info->original_cwd in dir removal
  6:  11e4ec881bb =  6:  1990e36bb41 clean: do not attempt to remove startup_info->original_cwd
  7:  39b1f3a225e !  7:  1035ee7f9ce rebase: do not attempt to remove startup_info->original_cwd
     @@ sequencer.c: static int run_git_checkout(struct repository *r, struct replay_opt
       
       	cmd.git_cmd = 1;
       
     -+	if (startup_info->original_cwd &&
     -+	    !is_absolute_path(startup_info->original_cwd))
     ++	if (startup_info->original_cwd)
      +		cmd.dir = startup_info->original_cwd;
       	strvec_push(&cmd.args, "checkout");
       	strvec_push(&cmd.args, commit);
  8:  0110462a19c !  8:  a2be40a22d1 stash: do not attempt to remove startup_info->original_cwd
     @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char
       			struct child_process cp = CHILD_PROCESS_INIT;
       
       			cp.git_cmd = 1;
     -+			if (startup_info->original_cwd &&
     -+			    !is_absolute_path(startup_info->original_cwd))
     ++			if (startup_info->original_cwd)
      +				cp.dir = startup_info->original_cwd;
       			strvec_pushl(&cp.args, "clean", "--force",
      -				     "--quiet", "-d", NULL);
  9:  2c73a09a2e8 =  9:  834031be9e0 dir: avoid incidentally removing the original_cwd in remove_path()
 10:  d4e50b4053d ! 10:  d5750fcb6d5 dir: new flag to remove_dir_recurse() to spare the original_cwd
     @@ dir.h: int get_sparse_checkout_patterns(struct pattern_list *pl);
       ## t/t2501-cwd-empty.sh ##
      @@ t/t2501-cwd-empty.sh: test_submodule_removal () {
       	test_status=
     - 	test $path_status = dir && test_status=test_must_fail
     + 	test "$path_status" = dir && test_status=test_must_fail
       
      -	# Actually, while path_status == dir && test_status=test_must_fail
      -	# reflect our desired behavior, current behavior is:
 11:  7eb6281be4b ! 11:  21ff99a767c t2501: simplify the tests since we can now assume desired behavior
     @@ t/t2501-cwd-empty.sh: test_incidental_dir_removal () {
       
      -		# Although we want pwd & git status to pass, test for existing
      -		# rather than desired behavior.
     --		if [[ $works == "success" ]]; then
     --			pwd -P &&
     +-		if test "$works" == "success"
     +-		then
     +-			test-tool getcwd &&
      -			git status --porcelain
      -		else
     --			! pwd -P &&
     +-			! test-tool getcwd &&
      -			test_might_fail git status --porcelain
      -		fi
     -+		pwd -P &&
     ++		# Make sure foo still exists, and commands needing it work
     ++		test-tool getcwd &&
      +		git status --porcelain
       	) &&
       	test_path_is_missing foo/bar/baz &&
     @@ t/t2501-cwd-empty.sh: test_incidental_dir_removal () {
       
      -	# Although we want dir to be present, test for existing rather
      -	# than desired behavior.
     --	if [[ $works == "success" ]]; then
     +-	if test "$works" == "success"
     +-	then
      -		test_path_is_dir foo
      -	else
      -		test_path_is_missing foo
     @@ t/t2501-cwd-empty.sh: test_incidental_dir_removal () {
       		cd dirORfile &&
       
      -		# We'd like for the command to fail (much as it would if there
     --		# was an untracked file there), and for pwd & git status to
     --		# succeed afterwards.  But test for existing rather than
     --		# desired behavior.
     --		if [[ $works == "success" ]]; then
     +-		# was an untracked file there), and for the index and worktree
     +-		# to be left clean with pwd and git status working afterwards.
     +-		# But test for existing rather than desired behavior.
     +-		if test "$works" == "success"
     +-		then
      -			test_must_fail "$@" 2>../error &&
      -			grep "Refusing to remove.*current working directory" ../error &&
     --			pwd -P &&
     +-
     +-			git diff --exit-code HEAD &&
     +-
     +-			test-tool getcwd &&
      -			git status --porcelain
      -		else
      -			"$@" &&
     --			! pwd -P &&
     +-			! test-tool getcwd &&
      -			test_might_fail git status --porcelain
      -		fi
     ++		# Ensure command refuses to run
      +		test_must_fail "$@" 2>../error &&
      +		grep "Refusing to remove.*current working directory" ../error &&
     -+		pwd -P &&
     ++
     ++		# ...and that the index and working tree are left clean
     ++		git diff --exit-code HEAD &&
     ++
     ++		# Ensure that getcwd and git status do not error out (which
     ++		# they might if the current working directory had been removed)
     ++		test-tool getcwd &&
      +		git status --porcelain
       	) &&
       
      -	# Although we want dirORfile to be present, test for existing rather
      -	# than desired behavior.
     --	if [[ $works == "success" ]]; then
     +-	if test "$works" == "success"
     +-	then
      -		test_path_is_dir dirORfile
      -	else
      -		test_path_is_file dirORfile
     @@ t/t2501-cwd-empty.sh: test_incidental_untracked_dir_removal () {
       
      -		# Although we want pwd & git status to pass, test for existing
      -		# rather than desired behavior.
     --		if [[ $works == "success" ]]; then
     --			pwd -P &&
     +-		if test "$works" == "success"
     +-		then
     +-			test-tool getcwd &&
      -			git status --porcelain
      -		else
     --			! pwd -P &&
     +-			! test-tool getcwd &&
      -			test_might_fail git status --porcelain
      -		fi
     -+		pwd -P &&
     ++		# Make sure untracked still exists, and commands needing it work
     ++		test-tool getcwd &&
      +		git status --porcelain
       	) &&
       	test_path_is_missing empty &&
     @@ t/t2501-cwd-empty.sh: test_incidental_untracked_dir_removal () {
       
      -	# Although we want dir to be present, test for existing rather
      -	# than desired behavior.
     --	if [[ $works == "success" ]]; then
     +-	if test "$works" == "success"
     +-	then
      -		test_path_is_dir untracked
      -	else
      -		test_path_is_missing untracked

-- 
gitgitgadget
