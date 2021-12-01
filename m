Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C6C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 06:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346956AbhLAGoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 01:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhLAGoS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19093C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:40:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c4so49778580wrd.9
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=peeThdyUxK1CNCGZA0scKpVha/WiqnCASK4bBn7Qk/w=;
        b=FKwKTC5zvv540OdNea4h6hVM12DXX3B2Acf/HZ8ynAWlH4jLIKieT89zZzKAM0TQQd
         IMhXLMJEKzOMKwyMTgyvA7achbzV84UG03ayMx4c9/hCltstcdhqExz0cTKxS40fVL6m
         hs9d2ltgqPPfl0xi13D6SiF/lIbA2mHwEnFibsoiUSegIku6R6MSd9gAeZhMCrVoyNum
         Zd4jVFyDF7fYY/1QGH4IotAWqh007zrJv/UGoDZraD4IZFfo6eIqWb6fmHeaEhAGY5JI
         K77oojZ5Mi2vwYU4i/awI2pFtx5pXeYAn2BRWoz29+LelV5XoRnggpMhBM2tQD+AytaP
         MHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=peeThdyUxK1CNCGZA0scKpVha/WiqnCASK4bBn7Qk/w=;
        b=B17E9yoAyhrfQ8pmJd2tHhBpAiZKJPXk6C9GHLfJwatsIsN0p2kGRZj3+k6DjsSy3e
         8VD5XZr+MCFFljHF4knE/TmThRthYx4ChozzDEfXpkR52Rf9b88K0Ih4F70iTqJ/9TpZ
         nu4m945JJnzf2qy22qmkxyBGgyxe9m9QOIZRw9tC7cxUJvFADVW/aMydmAJEtnbjjXNb
         ucb7u7Dpm5UaEGRpoV98/AAqnSaHlVGobUfzQ0HGud2pAQPBGq5gXdAOeqm2Bt+r11Uo
         8sgG4ffXL+gYmXW/l5zD7TNTfvcKjXGeH58dnv7JH04+E8ojM2wAtRNHe8JS4+I9I5oB
         ssmg==
X-Gm-Message-State: AOAM532tXwzerPwCvMr1MRbScrco52N9nIW+EJSKGU1S1DH0PKanPrUl
        VAc/s24m5gBpowk0qQwlZ3kvIn5XlU4=
X-Google-Smtp-Source: ABdhPJz6gTGwJf92wVCAZ7Gv3LDsgktMwTN4CHsvSMYPttXRYAO2lyHV24Ic9o0MVtys8pmfJrXNlg==
X-Received: by 2002:a5d:4c4e:: with SMTP id n14mr4328122wrt.514.1638340856337;
        Tue, 30 Nov 2021 22:40:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm18392017wrt.66.2021.11.30.22.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:40:55 -0800 (PST)
Message-Id: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 06:40:43 +0000
Subject: [PATCH v5 00/11] Avoid removing the current working directory, even if it becomes empty
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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

Changes since v4:

 * actually fix bashism

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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1140%2Fnewren%2Fcwd_removal-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1140/newren/cwd_removal-v5
Pull-Request: https://github.com/git/git/pull/1140

Range-diff vs v4:

  1:  a45b3f08802 !  1:  7c72e888d2e t2501: add various tests for removing the current working directory
     @@ t/t2501-cwd-empty.sh (new)
      +
      +		# Although we want pwd & git status to pass, test for existing
      +		# rather than desired behavior.
     -+		if test "$works" == "success"
     ++		if test "$works" = "success"
      +		then
      +			test-tool getcwd &&
      +			git status --porcelain
     @@ t/t2501-cwd-empty.sh (new)
      +
      +	# Although we want dir to be present, test for existing rather
      +	# than desired behavior.
     -+	if test "$works" == "success"
     ++	if test "$works" = "success"
      +	then
      +		test_path_is_dir foo
      +	else
     @@ t/t2501-cwd-empty.sh (new)
      +		# was an untracked file there), and for the index and worktree
      +		# to be left clean with pwd and git status working afterwards.
      +		# But test for existing rather than desired behavior.
     -+		if test "$works" == "success"
     ++		if test "$works" = "success"
      +		then
      +			test_must_fail "$@" 2>../error &&
      +			grep "Refusing to remove.*current working directory" ../error &&
     @@ t/t2501-cwd-empty.sh (new)
      +
      +	# Although we want dirORfile to be present, test for existing rather
      +	# than desired behavior.
     -+	if test "$works" == "success"
     ++	if test "$works" = "success"
      +	then
      +		test_path_is_dir dirORfile
      +	else
     @@ t/t2501-cwd-empty.sh (new)
      +
      +		# Although we want pwd & git status to pass, test for existing
      +		# rather than desired behavior.
     -+		if test "$works" == "success"
     ++		if test "$works" = "success"
      +		then
      +			test-tool getcwd &&
      +			git status --porcelain
     @@ t/t2501-cwd-empty.sh (new)
      +
      +	# Although we want dir to be present, test for existing rather
      +	# than desired behavior.
     -+	if test "$works" == "success"
     ++	if test "$works" = "success"
      +	then
      +		test_path_is_dir untracked
      +	else
     @@ t/t2501-cwd-empty.sh (new)
      +	test_status=
      +	test "$path_status" = dir && test_status=test_must_fail
      +
     -+	# Actually, while path_status == dir && test_status=test_must_fail
     ++	# Actually, while path_status=dir && test_status=test_must_fail
      +	# reflect our desired behavior, current behavior is:
      +	path_status=missing
      +	test_status=
  2:  ca9f632bd11 =  2:  37f333b2024 setup: introduce startup_info->original_cwd
  3:  41a82eff41e =  3:  b611c73bd15 unpack-trees: refuse to remove startup_info->original_cwd
  4:  2e2ea02f97b =  4:  706415a4547 unpack-trees: add special cwd handling
  5:  f444a541da4 =  5:  66ef6b4d943 symlinks: do not include startup_info->original_cwd in dir removal
  6:  1990e36bb41 =  6:  54d059c683e clean: do not attempt to remove startup_info->original_cwd
  7:  1035ee7f9ce =  7:  f8efb7446c3 rebase: do not attempt to remove startup_info->original_cwd
  8:  a2be40a22d1 =  8:  2855ed45112 stash: do not attempt to remove startup_info->original_cwd
  9:  834031be9e0 =  9:  23dfc3e399d dir: avoid incidentally removing the original_cwd in remove_path()
 10:  d5750fcb6d5 ! 10:  fe47c0f0c17 dir: new flag to remove_dir_recurse() to spare the original_cwd
     @@ t/t2501-cwd-empty.sh: test_submodule_removal () {
       	test_status=
       	test "$path_status" = dir && test_status=test_must_fail
       
     --	# Actually, while path_status == dir && test_status=test_must_fail
     +-	# Actually, while path_status=dir && test_status=test_must_fail
      -	# reflect our desired behavior, current behavior is:
      -	path_status=missing
      -	test_status=
 11:  21ff99a767c ! 11:  431dd651a7e t2501: simplify the tests since we can now assume desired behavior
     @@ t/t2501-cwd-empty.sh: test_incidental_dir_removal () {
       
      -		# Although we want pwd & git status to pass, test for existing
      -		# rather than desired behavior.
     --		if test "$works" == "success"
     +-		if test "$works" = "success"
      -		then
      -			test-tool getcwd &&
      -			git status --porcelain
     @@ t/t2501-cwd-empty.sh: test_incidental_dir_removal () {
       
      -	# Although we want dir to be present, test for existing rather
      -	# than desired behavior.
     --	if test "$works" == "success"
     +-	if test "$works" = "success"
      -	then
      -		test_path_is_dir foo
      -	else
     @@ t/t2501-cwd-empty.sh: test_incidental_dir_removal () {
      -		# was an untracked file there), and for the index and worktree
      -		# to be left clean with pwd and git status working afterwards.
      -		# But test for existing rather than desired behavior.
     --		if test "$works" == "success"
     +-		if test "$works" = "success"
      -		then
      -			test_must_fail "$@" 2>../error &&
      -			grep "Refusing to remove.*current working directory" ../error &&
     @@ t/t2501-cwd-empty.sh: test_incidental_dir_removal () {
       
      -	# Although we want dirORfile to be present, test for existing rather
      -	# than desired behavior.
     --	if test "$works" == "success"
     +-	if test "$works" = "success"
      -	then
      -		test_path_is_dir dirORfile
      -	else
     @@ t/t2501-cwd-empty.sh: test_incidental_untracked_dir_removal () {
       
      -		# Although we want pwd & git status to pass, test for existing
      -		# rather than desired behavior.
     --		if test "$works" == "success"
     +-		if test "$works" = "success"
      -		then
      -			test-tool getcwd &&
      -			git status --porcelain
     @@ t/t2501-cwd-empty.sh: test_incidental_untracked_dir_removal () {
       
      -	# Although we want dir to be present, test for existing rather
      -	# than desired behavior.
     --	if test "$works" == "success"
     +-	if test "$works" = "success"
      -	then
      -		test_path_is_dir untracked
      -	else

-- 
gitgitgadget
