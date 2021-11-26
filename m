Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5827CC433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245667AbhKZWsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245140AbhKZWqS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDE5C061574
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 133so9308477wme.0
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HWe5NcpjtrjIBTpjrQ4s4xfc5ThxdoqkDAjKRfQagSY=;
        b=j80KQg+UroOUneyOSlHX0ukFxpaqNVA8YY03OazwdlWue/nhB4nxIlb2p+I2rTubGF
         4YR/jdrv5UxNzKP85eg6o0vI+zALKPKo9hol+JnKG+Nqa1M8D4T1rn4D5+ScmPCMIsu8
         Rm5xicdoFfRQ0fULznac5YN7dBDVnuEiDvwh9jc2uchXeN5kxSDDVkPWAnLkUmQEIk9X
         getKv7WyFaTTzG7gOGfmmNagAPj5zmQfe3V0OaLaEXHHi4MvgnTFZlOD8vcmqgzJT+Kl
         /CjgZN6hgXtc/d1NbKlpbsm0BxV/LVG51oOBD3Id7eya5HIQsKbLgTL6lzcdUke9eHw9
         wYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HWe5NcpjtrjIBTpjrQ4s4xfc5ThxdoqkDAjKRfQagSY=;
        b=GxIIQ4NLbQyv2soEVkagWT/M71JqSD377Wy+ajmDc6FUKCVHRBi1K9OPOg8FVeyOeR
         FFVvtzp34gn2FCYF5T+3djmz00X+67YLroXGMk5sLJNfVqdBSCqrMarjatX2hBQLAuzl
         uZm+AG1ElRJX0VLK5ETXz5hreY/6CpwW1qw2ArhhTJMC2kfI4oo1goYZu/PvMoSAMszO
         07nrrtSyVYym/SgQdkp8MVAwk7AcPaSsHlK6z2UYh0cfK/eO1ygvD4/mLogJFsLefetn
         TPc2vJyZOJ49k9E2G5pHqs9kToU/3r/HXhH8p18Jn4e4QbIAjz+POuboOVmykV6ANswU
         LjVw==
X-Gm-Message-State: AOAM531MLKYQIOmZ5a68PpmAIY1ttjFTZNgdeD1FBZGWUVWgX7OAF+gR
        E7EBTrqb7k4mhTSy4h7QhYPGkUWrIoA=
X-Google-Smtp-Source: ABdhPJxEQyreKEaAnGgRNww1NYVisJuoVXvorvV8sanCaGZnNt3hLXbgmdOMIUfk5ZhjoK702QOCrQ==
X-Received: by 2002:a05:600c:34c2:: with SMTP id d2mr19464053wmq.102.1637966464488;
        Fri, 26 Nov 2021 14:41:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r62sm7335724wmr.35.2021.11.26.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:03 -0800 (PST)
Message-Id: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:40:51 +0000
Subject: [PATCH v3 00/11] Avoid removing the current working directory, even if it becomes empty
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
 * split the final patch, which got the most comments into two, one for each
   function being modified; significantly extending the first of the two
   commit messages with a lot of history
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
 builtin/stash.c      |   5 +-
 cache.h              |   2 +
 common-main.c        |   4 +
 dir.c                |  15 ++-
 dir.h                |   9 +-
 sequencer.c          |   3 +
 setup.c              |  65 +++++++++++
 symlinks.c           |   8 +-
 t/t2501-cwd-empty.sh | 268 +++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c       |  30 ++++-
 unpack-trees.h       |   1 +
 13 files changed, 435 insertions(+), 22 deletions(-)
 create mode 100755 t/t2501-cwd-empty.sh


base-commit: 88d915a634b449147855041d44875322de2b286d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1140%2Fnewren%2Fcwd_removal-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1140/newren/cwd_removal-v3
Pull-Request: https://github.com/git/git/pull/1140

Range-diff vs v2:

  1:  38a120f5c03 !  1:  4b0044656b0 t2501: add various tests for removing the current working directory
     @@ Metadata
       ## Commit message ##
          t2501: add various tests for removing the current working directory
      
     -    Numerous commands will remove empty working directories, especially if
     -    they are in the way of placing needed files.  That is normally fine, but
     -    removing the current working directory can cause confusion for the user
     -    when they run subsequent commands.  For example, after one git process
     -    has removed the current working directory, git status/log/diff will all
     -    abort with the message:
     +    Numerous commands will remove directories left empty as a "convenience"
     +    after removing files within them.  That is normally fine, but removing
     +    the current working directory can be rather inconvenient since it can
     +    cause confusion for the user when they run subsequent commands.  For
     +    example, after one git process has removed the current working
     +    directory, git status/log/diff will all abort with the message:
      
              fatal: Unable to read current working directory: No such file or directory
      
     +    We also have code paths that, when a file needs to be placed where a
     +    directory is (due to e.g. checkout, merge, reset, whatever), will check
     +    if this is okay and error out if not.  These rules include:
     +      * all tracked files under that directory are intended to be removed by
     +        the operation
     +      * none of the tracked files under that directory have uncommitted
     +        modification
     +      * there are no untracked files under that directory
     +    However, if we end up remove the current working directory, we can cause
     +    user confusion when they run subsequent commands, so we would prefer if
     +    there was a fourth rule added to this list: avoid removing the current
     +    working directory.
     +
          Since there are several code paths that can result in the current
          working directory being removed, add several tests of various different
     -    codepaths that check for the behavior we would instead like to see.
     -    This include a number of new error messages that we will be adding in
     -    subsequent commits as we implement the desired checks.
     +    codepaths.  To make it clearer what the difference between the current
     +    behavior and the behavior at the end of the series, code both of them
     +    into the tests and have the appropriate behavior be selected by a flag.
     +    Subsequent commits will toggle the flag from current to desired
     +    behavior.
     +
     +    Also add a few tests suggested during the review of earlier rounds of
     +    this patch series.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ t/t2501-cwd-empty.sh (new)
      +
      +test_expect_success setup '
      +	test_commit init &&
     -+	mkdir subdir &&
     -+	test_commit subdir/file &&
      +
      +	git branch fd_conflict &&
      +
     @@ t/t2501-cwd-empty.sh (new)
      +	git tag reverted &&
      +
      +	git checkout fd_conflict &&
     -+	git rm subdir/file.t &&
     ++	mkdir dirORfile &&
     ++	test_commit dirORfile/foo &&
     ++
     ++	git rm -r dirORfile &&
      +	echo not-a-directory >dirORfile &&
      +	git add dirORfile &&
     -+	git commit -m dirORfile
     ++	git commit -m dirORfile &&
     ++
     ++	git switch -c df_conflict HEAD~1 &&
     ++	test_commit random_file &&
     ++
     ++	git switch -c undo_fd_conflict fd_conflict &&
     ++	git revert HEAD
      +'
      +
     -+test_expect_failure 'checkout does not clean cwd incidentally' '
     -+	git checkout foo/bar/baz &&
     ++test_incidental_dir_removal () {
     ++	works=$1 &&
     ++	shift &&
     ++
     ++	test_when_finished "git reset --hard" &&
     ++
     ++	git checkout foo/bar/baz^{commit} &&
      +	test_path_is_dir foo/bar &&
      +
      +	(
      +		cd foo &&
     -+		git checkout init &&
     -+		cd ..
     ++		"$@" &&
     ++
     ++		# Although we want pwd & git status to pass, test for existing
     ++		# rather than desired behavior.
     ++		if [[ $works == "success" ]]; then
     ++			pwd -P &&
     ++			git status --porcelain
     ++		else
     ++			! pwd -P &&
     ++			test_might_fail git status --porcelain
     ++		fi
      +	) &&
      +	test_path_is_missing foo/bar/baz &&
      +	test_path_is_missing foo/bar &&
     -+	test_path_is_dir foo
     -+'
      +
     -+test_expect_failure 'checkout fails if cwd needs to be removed' '
     -+	git checkout foo/bar/baz &&
     ++	# Although we want dir to be present, test for existing rather
     ++	# than desired behavior.
     ++	if [[ $works == "success" ]]; then
     ++		test_path_is_dir foo
     ++	else
     ++		test_path_is_missing foo
     ++	fi
     ++}
     ++
     ++test_required_dir_removal () {
     ++	works=$1 &&
     ++	shift &&
     ++
     ++	git checkout df_conflict^{commit} &&
      +	test_when_finished "git clean -fdx" &&
      +
     -+	mkdir dirORfile &&
      +	(
      +		cd dirORfile &&
      +
     -+		test_must_fail git checkout fd_conflict 2>../error &&
     -+		grep "Refusing to remove the current working directory" ../error
     ++		# We'd like for the command to fail (much as it would if there
     ++		# was an untracked file there), and for pwd & git status to
     ++		# succeed afterwards.  But test for existing rather than
     ++		# desired behavior.
     ++		if [[ $works == "success" ]]; then
     ++			test_must_fail "$@" 2>../error &&
     ++			grep "Refusing to remove.*current working directory" ../error &&
     ++			pwd -P &&
     ++			git status --porcelain
     ++		else
     ++			"$@" &&
     ++			! pwd -P &&
     ++			test_might_fail git status --porcelain
     ++		fi
      +	) &&
      +
     -+	test_path_is_dir dirORfile
     ++	# Although we want dirORfile to be present, test for existing rather
     ++	# than desired behavior.
     ++	if [[ $works == "success" ]]; then
     ++		test_path_is_dir dirORfile
     ++	else
     ++		test_path_is_file dirORfile
     ++	fi
     ++}
     ++
     ++test_expect_success 'checkout does not clean cwd incidentally' '
     ++	test_incidental_dir_removal failure git checkout init
      +'
      +
     -+test_expect_failure 'reset --hard does not clean cwd incidentally' '
     -+	git checkout foo/bar/baz &&
     -+	test_path_is_dir foo/bar &&
     ++test_expect_success 'checkout fails if cwd needs to be removed' '
     ++	test_required_dir_removal failure git checkout fd_conflict
     ++'
      +
     -+	(
     -+		cd foo &&
     -+		git reset --hard init &&
     -+		cd ..
     -+	) &&
     -+	test_path_is_missing foo/bar/baz &&
     -+	test_path_is_missing foo/bar &&
     -+	test_path_is_dir foo
     ++test_expect_success 'reset --hard does not clean cwd incidentally' '
     ++	test_incidental_dir_removal failure git reset --hard init
     ++'
     ++
     ++test_expect_success 'reset --hard fails if cwd needs to be removed' '
     ++	test_required_dir_removal failure git reset --hard fd_conflict
     ++'
     ++
     ++test_expect_success 'merge does not clean cwd incidentally' '
     ++	test_incidental_dir_removal failure git merge reverted
      +'
      +
     -+test_expect_failure 'reset --hard fails if cwd needs to be removed' '
     ++# This file uses some simple merges where
     ++#   Base: 'dirORfile/' exists
     ++#   Side1: random other file changed
     ++#   Side2: 'dirORfile/' removed, 'dirORfile' added
     ++# this should resolve cleanly, but merge-recursive throws merge conflicts
     ++# because it's dumb.  Add a special test for checking merge-recursive (and
     ++# merge-ort), then after this just hard require ort for all remaining tests.
     ++#
     ++test_expect_success 'merge fails if cwd needs to be removed; recursive friendly' '
      +	git checkout foo/bar/baz &&
      +	test_when_finished "git clean -fdx" &&
      +
     @@ t/t2501-cwd-empty.sh (new)
      +	(
      +		cd dirORfile &&
      +
     -+		test_must_fail git reset --hard fd_conflict 2>../error &&
     -+		grep "Refusing to remove.*the current working directory" ../error
     ++		# We would rather this failed, but we test for existing
     ++		# rather than desired behavior
     ++		git merge fd_conflict 2>../error
      +	) &&
      +
     -+	test_path_is_dir dirORfile
     ++	## Here is the behavior we would rather have:
     ++	#test_path_is_dir dirORfile &&
     ++	#grep "Refusing to remove the current working directory" error
     ++	## But instead we test for existing behavior
     ++	test_path_is_file dirORfile &&
     ++	test_must_be_empty error
      +'
      +
     -+test_expect_failure 'merge does not remove cwd incidentally' '
     -+	git checkout foo/bar/baz &&
     -+	test_when_finished "git clean -fdx" &&
     ++GIT_TEST_MERGE_ALGORITHM=ort
      +
     -+	(
     -+		cd subdir &&
     -+		git merge fd_conflict
     -+	) &&
     ++test_expect_success 'merge fails if cwd needs to be removed' '
     ++	test_required_dir_removal failure git merge fd_conflict
     ++'
      +
     -+	test_path_is_missing subdir/file.t &&
     -+	test_path_is_dir subdir
     ++test_expect_success 'cherry-pick does not clean cwd incidentally' '
     ++	test_incidental_dir_removal failure git cherry-pick reverted
      +'
      +
     -+test_expect_failure 'merge fails if cwd needs to be removed' '
     -+	git checkout foo/bar/baz &&
     -+	test_when_finished "git clean -fdx" &&
     ++test_expect_success 'cherry-pick fails if cwd needs to be removed' '
     ++	test_required_dir_removal failure git cherry-pick fd_conflict
     ++'
      +
     -+	mkdir dirORfile &&
     -+	(
     -+		cd dirORfile &&
     -+		test_must_fail git merge fd_conflict 2>../error &&
     -+		grep "Refusing to remove the current working directory" ../error
     -+	) &&
     ++test_expect_success 'rebase does not clean cwd incidentally' '
     ++	test_incidental_dir_removal failure git rebase reverted
     ++'
      +
     -+	test_path_is_dir dirORfile
     ++test_expect_success 'rebase fails if cwd needs to be removed' '
     ++	test_required_dir_removal failure git rebase fd_conflict
      +'
      +
     -+test_expect_failure 'cherry-pick does not remove cwd incidentally' '
     -+	git checkout foo/bar/baz &&
     -+	test_when_finished "git clean -fdx" &&
     ++test_expect_success 'revert does not clean cwd incidentally' '
     ++	test_incidental_dir_removal failure git revert HEAD
     ++'
      +
     -+	(
     -+		cd subdir &&
     -+		git cherry-pick fd_conflict
     -+	) &&
     ++test_expect_success 'revert fails if cwd needs to be removed' '
     ++	test_required_dir_removal failure git revert undo_fd_conflict
     ++'
      +
     -+	test_path_is_missing subdir/file.t &&
     -+	test_path_is_dir subdir
     ++test_expect_success 'rm does not clean cwd incidentally' '
     ++	test_incidental_dir_removal failure git rm bar/baz.t
      +'
      +
     -+test_expect_failure 'cherry-pick fails if cwd needs to be removed' '
     -+	git checkout foo/bar/baz &&
     -+	test_when_finished "git clean -fdx" &&
     ++test_expect_success 'apply does not remove cwd incidentally' '
     ++	git diff HEAD HEAD~1 >patch &&
     ++	test_incidental_dir_removal failure git apply ../patch
     ++'
      +
     -+	mkdir dirORfile &&
     -+	(
     -+		cd dirORfile &&
     -+		test_must_fail git cherry-pick fd_conflict 2>../error &&
     -+		grep "Refusing to remove the current working directory" ../error
     -+	) &&
     ++test_incidental_untracked_dir_removal () {
     ++	works=$1 &&
     ++	shift &&
      +
     -+	test_path_is_dir dirORfile
     -+'
     ++	test_when_finished "git reset --hard" &&
      +
     -+test_expect_failure 'rebase does not remove cwd incidentally' '
     -+	git checkout foo/bar/baz &&
     -+	test_when_finished "git clean -fdx" &&
     ++	git checkout foo/bar/baz^{commit} &&
     ++	mkdir -p untracked &&
     ++	mkdir empty
     ++	>untracked/random &&
      +
      +	(
     -+		cd subdir &&
     -+		git rebase foo/bar/baz fd_conflict
     ++		cd untracked &&
     ++		"$@" &&
     ++
     ++		# Although we want pwd & git status to pass, test for existing
     ++		# rather than desired behavior.
     ++		if [[ $works == "success" ]]; then
     ++			pwd -P &&
     ++			git status --porcelain
     ++		else
     ++			! pwd -P &&
     ++			test_might_fail git status --porcelain
     ++		fi
      +	) &&
     ++	test_path_is_missing empty &&
     ++	test_path_is_missing untracked/random &&
      +
     -+	test_path_is_missing subdir/file.t &&
     -+	test_path_is_dir subdir
     ++	# Although we want dir to be present, test for existing rather
     ++	# than desired behavior.
     ++	if [[ $works == "success" ]]; then
     ++		test_path_is_dir untracked
     ++	else
     ++		test_path_is_missing untracked
     ++	fi
     ++}
     ++
     ++test_expect_success 'clean does not remove cwd incidentally' '
     ++	test_incidental_untracked_dir_removal failure \
     ++		git -C .. clean -fd -e warnings . >warnings
      +'
      +
     -+test_expect_failure 'rebase fails if cwd needs to be removed' '
     -+	git checkout foo/bar/baz &&
     -+	test_when_finished "git clean -fdx" &&
     -+
     -+	mkdir dirORfile &&
     -+	(
     -+		cd dirORfile &&
     -+		test_must_fail git rebase foo/bar/baz fd_conflict 2>../error &&
     -+		grep "Refusing to remove the current working directory" ../error
     -+	) &&
     -+
     -+	test_path_is_dir dirORfile
     ++test_expect_success 'stash does not remove cwd incidentally' '
     ++	test_incidental_untracked_dir_removal failure \
     ++		git stash --include-untracked
      +'
      +
     -+test_expect_failure 'revert does not remove cwd incidentally' '
     -+	git checkout foo/bar/baz &&
     -+	test_when_finished "git clean -fdx" &&
     ++test_expect_success '`rm -rf dir` only removes a subset of dir' '
     ++	test_when_finished "rm -rf a/" &&
     ++
     ++	mkdir -p a/b/c &&
     ++	>a/b/c/untracked &&
     ++	>a/b/c/tracked &&
     ++	git add a/b/c/tracked &&
      +
      +	(
     -+		cd subdir &&
     -+		git revert subdir/file
     ++		cd a/b &&
     ++		git rm -rf ../b
      +	) &&
      +
     -+	test_path_is_missing subdir/file.t &&
     -+	test_path_is_dir subdir
     ++	test_path_is_dir a/b &&
     ++	test_path_is_missing a/b/c/tracked &&
     ++	test_path_is_file a/b/c/untracked
      +'
      +
     -+test_expect_failure 'revert fails if cwd needs to be removed' '
     -+	git checkout fd_conflict &&
     -+	git revert HEAD &&
     -+	test_when_finished "git clean -fdx" &&
     ++test_expect_success '`rm -rf dir` even with only tracked files will remove something else' '
     ++	test_when_finished "rm -rf a/" &&
     ++
     ++	mkdir -p a/b/c &&
     ++	>a/b/c/tracked &&
     ++	git add a/b/c/tracked &&
      +
     -+	mkdir dirORfile &&
      +	(
     -+		cd dirORfile &&
     -+		test_must_fail git revert HEAD 2>../error &&
     -+		grep "Refusing to remove the current working directory" ../error
     ++		cd a/b &&
     ++		git rm -rf ../b
      +	) &&
      +
     -+	test_path_is_dir dirORfile
     ++	test_path_is_missing a/b/c/tracked &&
     ++	## We would prefer if a/b was still present, though empty, since it
     ++	## was the current working directory
     ++	#test_path_is_dir a/b
     ++	## But the current behavior is that it not only deletes the directory
     ++	## a/b as requested, but also goes and deletes a
     ++	test_path_is_missing a
      +'
      +
     -+test_expect_failure 'rm does not remove cwd incidentally' '
     -+	test_when_finished "git reset --hard" &&
     -+	git checkout foo/bar/baz &&
     -+
     ++test_expect_success 'git version continues working from a deleted dir' '
     ++	mkdir tmp &&
      +	(
     -+		cd foo &&
     -+		git rm bar/baz.t
     -+	) &&
     -+
     -+	test_path_is_missing foo/bar/baz &&
     -+	test_path_is_missing foo/bar &&
     -+	test_path_is_dir foo
     ++		cd tmp &&
     ++		rm -rf ../tmp &&
     ++		git version
     ++	)
      +'
      +
     -+test_expect_failure 'apply does not remove cwd incidentally' '
     -+	test_when_finished "git reset --hard" &&
     -+	git checkout foo/bar/baz &&
     ++test_submodule_removal () {
     ++	path_status=$1 &&
     ++	shift &&
      +
     -+	(
     -+		cd subdir &&
     -+		git diff subdir/file init | git apply
     -+	) &&
     ++	test_status=
     ++	test $path_status = dir && test_status=test_must_fail
      +
     -+	test_path_is_missing subdir/file.t &&
     -+	test_path_is_dir subdir
     -+'
     ++	# Actually, while path_status == dir && test_status=test_must_fail
     ++	# reflect our desired behavior, current behavior is:
     ++	path_status=missing
     ++	test_status=
     ++
     ++	test_when_finished "git reset --hard HEAD~1" &&
     ++	test_when_finished "rm -rf .git/modules/my_submodule" &&
      +
     -+test_expect_failure 'clean does not remove cwd incidentally' '
      +	git checkout foo/bar/baz &&
     -+	test_when_finished "git clean -fdx" &&
      +
     -+	mkdir empty &&
     -+	mkdir untracked &&
     -+	>untracked/random &&
     ++	git init my_submodule &&
     ++	touch my_submodule/file &&
     ++	git -C my_submodule add file &&
     ++	git -C my_submodule commit -m "initial commit" &&
     ++	git submodule add ./my_submodule &&
     ++	git commit -m "Add the submodule" &&
     ++
      +	(
     -+		cd untracked &&
     -+		git clean -fd -e warnings :/ >../warnings &&
     -+		grep "Refusing to remove current working directory" ../warnings
     ++		cd my_submodule &&
     ++		$test_status "$@"
      +	) &&
      +
     -+	test_path_is_missing empty &&
     -+	test_path_is_missing untracked/random &&
     -+	test_path_is_dir untracked
     -+'
     ++	test_path_is_${path_status} my_submodule
     ++}
      +
     -+test_expect_failure 'stash does not remove cwd incidentally' '
     -+	git checkout foo/bar/baz &&
     -+	test_when_finished "git clean -fdx" &&
     ++test_expect_success 'rm -r with -C leaves submodule if cwd inside' '
     ++	test_submodule_removal dir git -C .. rm -r my_submodule/
     ++'
      +
     -+	mkdir untracked &&
     -+	>untracked/random &&
     -+	(
     -+		cd untracked &&
     -+		git stash --include-untracked &&
     -+		git status
     -+	) &&
     ++test_expect_success 'rm -r leaves submodule if cwd inside' '
     ++	test_submodule_removal dir \
     ++		git --git-dir=../.git --work-tree=.. rm -r ../my_submodule/
     ++'
      +
     -+	test_path_is_missing untracked/random &&
     -+	test_path_is_dir untracked
     ++test_expect_success 'rm -rf removes submodule even if cwd inside' '
     ++	test_submodule_removal missing \
     ++		git --git-dir=../.git --work-tree=.. rm -rf ../my_submodule/
      +'
      +
      +test_done
  2:  f6129a8ac9c !  2:  200ddece05d setup: introduce startup_info->original_cwd
     @@ cache.h: void overlay_tree_on_index(struct index_state *istate,
      +	const char *original_cwd;
       };
       extern struct startup_info *startup_info;
     ++extern const char *tmp_original_cwd;
       
     + /* merge.c */
     + struct commit_list;
      
     - ## git.c ##
     -@@ git.c: int cmd_main(int argc, const char **argv)
     + ## common-main.c ##
     +@@ common-main.c: static void restore_sigpipe_to_default(void)
     + int main(int argc, const char **argv)
     + {
     + 	int result;
     ++	struct strbuf tmp = STRBUF_INIT;
     + 
     + 	trace2_initialize_clock();
       
     - 	trace_command_performance(argv);
     +@@ common-main.c: int main(int argc, const char **argv)
     + 	trace2_cmd_start(argv);
     + 	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
       
     -+	startup_info->original_cwd = xgetcwd();
     ++	if (!strbuf_getcwd(&tmp))
     ++		tmp_original_cwd = strbuf_detach(&tmp, NULL);
      +
     - 	/*
     - 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
     - 	 *
     + 	result = cmd_main(argc, argv);
     + 
     + 	trace2_cmd_exit(result);
      
       ## setup.c ##
     +@@ setup.c: static int work_tree_config_is_bogus;
     + 
     + static struct startup_info the_startup_info;
     + struct startup_info *startup_info = &the_startup_info;
     ++const char *tmp_original_cwd;
     + 
     + /*
     +  * The input parameter must contain an absolute path, and it must already be
      @@ setup.c: void setup_work_tree(void)
       	initialized = 1;
       }
     @@ setup.c: void setup_work_tree(void)
      +	const char *worktree = NULL;
      +	int offset = -1;
      +
     -+	/*
     -+	 * startup_info->original_cwd wass set early on in cmd_main(), unless
     -+	 * we're an auxiliary tool like git-remote-http or test-tool.
     -+	 */
     -+	if (!startup_info->original_cwd)
     ++	if (!tmp_original_cwd)
      +		return;
      +
      +	/*
      +	 * startup_info->original_cwd points to the current working
      +	 * directory we inherited from our parent process, which is a
     -+	 * directory we want to avoid incidentally removing.
     ++	 * directory we want to avoid removing.
      +	 *
      +	 * For convience, we would like to have the path relative to the
      +	 * worktree instead of an absolute path.
     @@ setup.c: void setup_work_tree(void)
      +	 */
      +
      +	/* Normalize the directory */
     -+	strbuf_realpath(&tmp, startup_info->original_cwd, 1);
     -+	free((char*)startup_info->original_cwd);
     ++	strbuf_realpath(&tmp, tmp_original_cwd, 1);
     ++	free((char*)tmp_original_cwd);
     ++	tmp_original_cwd = NULL;
      +	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
      +
     -+	/* Find out if this is in the worktree */
     ++	/*
     ++	 * Get our worktree; we only protect the current working directory
     ++	 * if it's in the worktree.
     ++	 */
      +	worktree = get_git_work_tree();
     -+	if (worktree)
     -+		offset = dir_inside_of(startup_info->original_cwd, worktree);
     ++	if (!worktree)
     ++		goto no_prevention_needed;
     ++
     ++	offset = dir_inside_of(startup_info->original_cwd, worktree);
      +	if (offset >= 0) {
      +		/*
     ++		 * If startup_info->original_cwd == worktree, that is already
     ++		 * protected and we don't need original_cwd as a secondary
     ++		 * protection measure.
     ++		 */
     ++		if (!*(startup_info->original_cwd + offset))
     ++			goto no_prevention_needed;
     ++
     ++		/*
      +		 * original_cwd was inside worktree; precompose it just as
      +		 * we do prefix so that built up paths will match
      +		 */
     @@ setup.c: void setup_work_tree(void)
      +			precompose_string_if_needed(startup_info->original_cwd
      +						    + offset);
      +	}
     ++	return;
     ++
     ++no_prevention_needed:
     ++	free((char*)startup_info->original_cwd);
     ++	startup_info->original_cwd = NULL;
      +}
      +
       static int read_worktree_config(const char *var, const char *value, void *vdata)
  3:  e74975e83cc !  3:  68ae90546fe unpack-trees: refuse to remove startup_info->original_cwd
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t2501-cwd-empty.sh ##
     -@@ t/t2501-cwd-empty.sh: test_expect_failure 'checkout does not clean cwd incidentally' '
     - 	test_path_is_dir foo
     +@@ t/t2501-cwd-empty.sh: test_expect_success 'checkout does not clean cwd incidentally' '
       '
       
     --test_expect_failure 'checkout fails if cwd needs to be removed' '
     -+test_expect_success 'checkout fails if cwd needs to be removed' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     + test_expect_success 'checkout fails if cwd needs to be removed' '
     +-	test_required_dir_removal failure git checkout fd_conflict
     ++	test_required_dir_removal success git checkout fd_conflict
     + '
     + 
     + test_expect_success 'reset --hard does not clean cwd incidentally' '
     +@@ t/t2501-cwd-empty.sh: test_expect_success 'merge fails if cwd needs to be removed; recursive friendly'
     + 	(
     + 		cd dirORfile &&
     + 
     +-		# We would rather this failed, but we test for existing
     +-		# rather than desired behavior
     +-		git merge fd_conflict 2>../error
     ++		test_must_fail git merge fd_conflict 2>../error
     + 	) &&
       
     -@@ t/t2501-cwd-empty.sh: test_expect_failure 'merge does not remove cwd incidentally' '
     - 	test_path_is_dir subdir
     +-	## Here is the behavior we would rather have:
     +-	#test_path_is_dir dirORfile &&
     +-	#grep "Refusing to remove the current working directory" error
     +-	## But instead we test for existing behavior
     +-	test_path_is_file dirORfile &&
     +-	test_must_be_empty error
     ++	test_path_is_dir dirORfile &&
     ++	grep "Refusing to remove the current working directory" error
       '
       
     --test_expect_failure 'merge fails if cwd needs to be removed' '
     -+test_expect_success 'merge fails if cwd needs to be removed' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     + GIT_TEST_MERGE_ALGORITHM=ort
       
     -@@ t/t2501-cwd-empty.sh: test_expect_failure 'cherry-pick does not remove cwd incidentally' '
     - 	test_path_is_dir subdir
     + test_expect_success 'merge fails if cwd needs to be removed' '
     +-	test_required_dir_removal failure git merge fd_conflict
     ++	test_required_dir_removal success git merge fd_conflict
       '
       
     --test_expect_failure 'cherry-pick fails if cwd needs to be removed' '
     -+test_expect_success 'cherry-pick fails if cwd needs to be removed' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     + test_expect_success 'cherry-pick does not clean cwd incidentally' '
     +@@ t/t2501-cwd-empty.sh: test_expect_success 'cherry-pick does not clean cwd incidentally' '
     + '
       
     -@@ t/t2501-cwd-empty.sh: test_expect_failure 'rebase does not remove cwd incidentally' '
     - 	test_path_is_dir subdir
     + test_expect_success 'cherry-pick fails if cwd needs to be removed' '
     +-	test_required_dir_removal failure git cherry-pick fd_conflict
     ++	test_required_dir_removal success git cherry-pick fd_conflict
       '
       
     --test_expect_failure 'rebase fails if cwd needs to be removed' '
     -+test_expect_success 'rebase fails if cwd needs to be removed' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     + test_expect_success 'rebase does not clean cwd incidentally' '
     +@@ t/t2501-cwd-empty.sh: test_expect_success 'revert does not clean cwd incidentally' '
     + '
       
     -@@ t/t2501-cwd-empty.sh: test_expect_failure 'revert does not remove cwd incidentally' '
     - 	test_path_is_dir subdir
     + test_expect_success 'revert fails if cwd needs to be removed' '
     +-	test_required_dir_removal failure git revert undo_fd_conflict
     ++	test_required_dir_removal success git revert undo_fd_conflict
       '
       
     --test_expect_failure 'revert fails if cwd needs to be removed' '
     -+test_expect_success 'revert fails if cwd needs to be removed' '
     - 	git checkout fd_conflict &&
     - 	git revert HEAD &&
     - 	test_when_finished "git clean -fdx" &&
     + test_expect_success 'rm does not clean cwd incidentally' '
      
       ## unpack-trees.c ##
      @@ unpack-trees.c: static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
  4:  e06806e3a32 !  4:  1bb8905900c unpack-trees: add special cwd handling
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t2501-cwd-empty.sh ##
     -@@ t/t2501-cwd-empty.sh: test_expect_failure 'reset --hard does not clean cwd incidentally' '
     - 	test_path_is_dir foo
     +@@ t/t2501-cwd-empty.sh: test_expect_success 'reset --hard does not clean cwd incidentally' '
       '
       
     --test_expect_failure 'reset --hard fails if cwd needs to be removed' '
     -+test_expect_success 'reset --hard fails if cwd needs to be removed' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     + test_expect_success 'reset --hard fails if cwd needs to be removed' '
     +-	test_required_dir_removal failure git reset --hard fd_conflict
     ++	test_required_dir_removal success git reset --hard fd_conflict
     + '
       
     + test_expect_success 'merge does not clean cwd incidentally' '
      
       ## unpack-trees.c ##
      @@ unpack-trees.c: static int verify_absent_1(const struct cache_entry *ce,
  5:  46728f74ea1 !  5:  8a33d74e7cf symlinks: do not include startup_info->original_cwd in dir removal
     @@ symlinks.c: void schedule_dir_for_removal(const char *name, int len)
       				   &previous_slash);
      
       ## t/t2501-cwd-empty.sh ##
     -@@ t/t2501-cwd-empty.sh: test_expect_success setup '
     - 	git commit -m dirORfile
     - '
     +@@ t/t2501-cwd-empty.sh: test_required_dir_removal () {
     + }
       
     --test_expect_failure 'checkout does not clean cwd incidentally' '
     -+test_expect_success 'checkout does not clean cwd incidentally' '
     - 	git checkout foo/bar/baz &&
     - 	test_path_is_dir foo/bar &&
     + test_expect_success 'checkout does not clean cwd incidentally' '
     +-	test_incidental_dir_removal failure git checkout init
     ++	test_incidental_dir_removal success git checkout init
     + '
       
     + test_expect_success 'checkout fails if cwd needs to be removed' '
      @@ t/t2501-cwd-empty.sh: test_expect_success 'checkout fails if cwd needs to be removed' '
     - 	test_path_is_dir dirORfile
       '
       
     --test_expect_failure 'reset --hard does not clean cwd incidentally' '
     -+test_expect_success 'reset --hard does not clean cwd incidentally' '
     - 	git checkout foo/bar/baz &&
     - 	test_path_is_dir foo/bar &&
     + test_expect_success 'reset --hard does not clean cwd incidentally' '
     +-	test_incidental_dir_removal failure git reset --hard init
     ++	test_incidental_dir_removal success git reset --hard init
     + '
       
     + test_expect_success 'reset --hard fails if cwd needs to be removed' '
      @@ t/t2501-cwd-empty.sh: test_expect_success 'reset --hard fails if cwd needs to be removed' '
     - 	test_path_is_dir dirORfile
       '
       
     --test_expect_failure 'merge does not remove cwd incidentally' '
     -+test_expect_success 'merge does not remove cwd incidentally' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     + test_expect_success 'merge does not clean cwd incidentally' '
     +-	test_incidental_dir_removal failure git merge reverted
     ++	test_incidental_dir_removal success git merge reverted
     + '
       
     + # This file uses some simple merges where
      @@ t/t2501-cwd-empty.sh: test_expect_success 'merge fails if cwd needs to be removed' '
     - 	test_path_is_dir dirORfile
       '
       
     --test_expect_failure 'cherry-pick does not remove cwd incidentally' '
     -+test_expect_success 'cherry-pick does not remove cwd incidentally' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     - 
     -@@ t/t2501-cwd-empty.sh: test_expect_success 'cherry-pick fails if cwd needs to be removed' '
     - 	test_path_is_dir dirORfile
     + test_expect_success 'cherry-pick does not clean cwd incidentally' '
     +-	test_incidental_dir_removal failure git cherry-pick reverted
     ++	test_incidental_dir_removal success git cherry-pick reverted
       '
       
     --test_expect_failure 'rebase does not remove cwd incidentally' '
     -+test_expect_success 'rebase does not remove cwd incidentally' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     - 
     + test_expect_success 'cherry-pick fails if cwd needs to be removed' '
      @@ t/t2501-cwd-empty.sh: test_expect_success 'rebase fails if cwd needs to be removed' '
     - 	test_path_is_dir dirORfile
       '
       
     --test_expect_failure 'revert does not remove cwd incidentally' '
     -+test_expect_success 'revert does not remove cwd incidentally' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     + test_expect_success 'revert does not clean cwd incidentally' '
     +-	test_incidental_dir_removal failure git revert HEAD
     ++	test_incidental_dir_removal success git revert HEAD
     + '
       
     + test_expect_success 'revert fails if cwd needs to be removed' '
  6:  01ce9444dae !  6:  11e4ec881bb clean: do not attempt to remove startup_info->original_cwd
     @@ builtin/clean.c: static int remove_dirs(struct strbuf *path, const char *prefix,
      +		strbuf_realpath(&realpath, path->buf, 1);
      +
      +		/*
     -+		 * path and realpath are absolute; for comparison, we want
     -+		 * startup_info->original_cwd to be an absolute path too.  We
     -+		 * can use strbuf_realpath for this.  Also, if original_cwd
     -+		 * started out as the empty string, then it corresponded to
     -+		 * the top of the worktree, which is protected by other means
     -+		 * so we just leave it blank.
     ++		 * path and realpath are absolute; for comparison, we would
     ++		 * like to transform startup_info->original_cwd to an absolute
     ++		 * path too.
      +		 */
     -+		 if (*startup_info->original_cwd)
     ++		 if (startup_info->original_cwd)
      +			 strbuf_realpath(&real_ocwd,
      +					 startup_info->original_cwd, 1);
      +
     @@ builtin/clean.c: static int remove_dirs(struct strbuf *path, const char *prefix,
       	return ret;
      
       ## t/t2501-cwd-empty.sh ##
     -@@ t/t2501-cwd-empty.sh: test_expect_failure 'apply does not remove cwd incidentally' '
     - 	test_path_is_dir subdir
     - '
     +@@ t/t2501-cwd-empty.sh: test_incidental_untracked_dir_removal () {
     + }
       
     --test_expect_failure 'clean does not remove cwd incidentally' '
     -+test_expect_success 'clean does not remove cwd incidentally' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     + test_expect_success 'clean does not remove cwd incidentally' '
     +-	test_incidental_untracked_dir_removal failure \
     +-		git -C .. clean -fd -e warnings . >warnings
     ++	test_incidental_untracked_dir_removal success \
     ++		git -C .. clean -fd -e warnings . >warnings &&
     ++	grep "Refusing to remove current working directory" warnings
     + '
       
     + test_expect_success 'stash does not remove cwd incidentally' '
  -:  ----------- >  7:  39b1f3a225e rebase: do not attempt to remove startup_info->original_cwd
  7:  edec0894ca2 !  8:  0110462a19c stash: do not attempt to remove startup_info->original_cwd
     @@ Metadata
       ## Commit message ##
          stash: do not attempt to remove startup_info->original_cwd
      
     +    Since stash spawns a `clean` subprocess, make sure we run that from the
     +    startup_info->original_cwd directory, so that the `clean` processs knows
     +    to protect that directory.  Also, since the `clean` command might no
     +    longer run from the toplevel, pass the ':/' magic pathspec to ensure we
     +    still clean from the toplevel.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/stash.c ##
     @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char
       
       			cp.git_cmd = 1;
      +			if (startup_info->original_cwd &&
     -+			    *startup_info->original_cwd &&
      +			    !is_absolute_path(startup_info->original_cwd))
      +				cp.dir = startup_info->original_cwd;
       			strvec_pushl(&cp.args, "clean", "--force",
     @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char
      
       ## t/t2501-cwd-empty.sh ##
      @@ t/t2501-cwd-empty.sh: test_expect_success 'clean does not remove cwd incidentally' '
     - 	test_path_is_dir untracked
       '
       
     --test_expect_failure 'stash does not remove cwd incidentally' '
     -+test_expect_success 'stash does not remove cwd incidentally' '
     - 	git checkout foo/bar/baz &&
     - 	test_when_finished "git clean -fdx" &&
     + test_expect_success 'stash does not remove cwd incidentally' '
     +-	test_incidental_untracked_dir_removal failure \
     ++	test_incidental_untracked_dir_removal success \
     + 		git stash --include-untracked
     + '
       
  8:  1815f18592b !  9:  2c73a09a2e8 dir: avoid incidentally removing the original_cwd in remove_path()
     @@ dir.h: int get_sparse_checkout_patterns(struct pattern_list *pl);
      
       ## t/t2501-cwd-empty.sh ##
      @@ t/t2501-cwd-empty.sh: test_expect_success 'revert fails if cwd needs to be removed' '
     - 	test_path_is_dir dirORfile
       '
       
     --test_expect_failure 'rm does not remove cwd incidentally' '
     -+test_expect_success 'rm does not remove cwd incidentally' '
     - 	test_when_finished "git reset --hard" &&
     - 	git checkout foo/bar/baz &&
     + test_expect_success 'rm does not clean cwd incidentally' '
     +-	test_incidental_dir_removal failure git rm bar/baz.t
     ++	test_incidental_dir_removal success git rm bar/baz.t
     + '
       
     -@@ t/t2501-cwd-empty.sh: test_expect_failure 'rm does not remove cwd incidentally' '
     - 	test_path_is_dir foo
     + test_expect_success 'apply does not remove cwd incidentally' '
     + 	git diff HEAD HEAD~1 >patch &&
     +-	test_incidental_dir_removal failure git apply ../patch
     ++	test_incidental_dir_removal success git apply ../patch
       '
       
     --test_expect_failure 'apply does not remove cwd incidentally' '
     -+test_expect_success 'apply does not remove cwd incidentally' '
     - 	test_when_finished "git reset --hard" &&
     - 	git checkout foo/bar/baz &&
     + test_incidental_untracked_dir_removal () {
     +@@ t/t2501-cwd-empty.sh: test_expect_success '`rm -rf dir` even with only tracked files will remove somet
     + 	) &&
     + 
     + 	test_path_is_missing a/b/c/tracked &&
     +-	## We would prefer if a/b was still present, though empty, since it
     +-	## was the current working directory
     +-	#test_path_is_dir a/b
     +-	## But the current behavior is that it not only deletes the directory
     +-	## a/b as requested, but also goes and deletes a
     +-	test_path_is_missing a
     ++	test_path_is_missing a/b/c &&
     ++	test_path_is_dir a/b
     + '
       
     + test_expect_success 'git version continues working from a deleted dir' '
  9:  adaad7aeaac ! 10:  d4e50b4053d dir: new flag to remove_dir_recurse() to spare the original_cwd
     @@ dir.h: int get_sparse_checkout_patterns(struct pattern_list *pl);
        * of the above REMOVE_DIR_* constants. Return 0 on success.
      
       ## t/t2501-cwd-empty.sh ##
     -@@ t/t2501-cwd-empty.sh: test_expect_success 'stash does not remove cwd incidentally' '
     - 	test_path_is_dir untracked
     - '
     +@@ t/t2501-cwd-empty.sh: test_submodule_removal () {
     + 	test_status=
     + 	test $path_status = dir && test_status=test_must_fail
     + 
     +-	# Actually, while path_status == dir && test_status=test_must_fail
     +-	# reflect our desired behavior, current behavior is:
     +-	path_status=missing
     +-	test_status=
     +-
     + 	test_when_finished "git reset --hard HEAD~1" &&
     + 	test_when_finished "rm -rf .git/modules/my_submodule" &&
       
     -+test_expect_success 'rm -r leaves submodule if cwd inside' '
     -+	test_when_finished "git reset --hard HEAD~1" &&
     -+	test_when_finished "rm -rf .git/modules/my_submodule" &&
     -+
     -+	git checkout foo/bar/baz &&
     -+
     -+	git init my_submodule &&
     -+	touch my_submodule/file &&
     -+	git -C my_submodule add file &&
     -+	git -C my_submodule commit -m "initial commit" &&
     -+	git submodule add ./my_submodule &&
     -+	git commit -m "Add the submodule" &&
     -+
     -+	(
     -+		cd my_submodule &&
     -+		test_must_fail git --git-dir=../.git --work-tree=.. rm -r ../my_submodule/
     -+	) &&
     -+
     -+	test_path_is_dir my_submodule
     -+'
     -+
     -+test_expect_success 'rm -rf removes submodule even if cwd inside' '
     -+	test_when_finished "git reset --hard HEAD~1" &&
     -+	test_when_finished "rm -rf .git/modules/my_submodule" &&
     -+
     -+	git checkout foo/bar/baz &&
     -+
     -+	git init my_submodule &&
     -+	touch my_submodule/file &&
     -+	git -C my_submodule add file &&
     -+	git -C my_submodule commit -m "initial commit" &&
     -+	git submodule add ./my_submodule &&
     -+	git commit -m "Add the submodule" &&
     -+
     -+	(
     -+		cd my_submodule &&
     -+		git --git-dir=../.git --work-tree=.. rm -rf ../my_submodule/
     -+	) &&
     -+
     -+	test_path_is_missing my_submodule
     -+'
     -+
     - test_done
  -:  ----------- > 11:  7eb6281be4b t2501: simplify the tests since we can now assume desired behavior

-- 
gitgitgadget
