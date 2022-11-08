Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CECFC43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiKHSR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiKHSR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:17:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5339D271E
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:17:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a67so23747049edf.12
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3wqDjIIE8Q8SrxMGLQQ+/3pVvnhzxLHerSHxNhcXno=;
        b=R9c6RVpMPE57N1Z1fi+R8nkQRm/fRNTmh5p9swpoZusxntZFbY2rojYDd6N1L/hl3x
         WVLuMyeGqfi8ixvQbPdmsE4QXYNfTBhEgMIshgqBo0PqPESlZ6BdPZaUr2pzNkpeuwQJ
         JAjYS3lbANNLrnjXBzvfKJsd8UIUu/jGIvAwbMzXIffziNDIOjkBgMbL+fsTDHBhESBq
         Pr4WEhDi0mOFuhtAobsSuicvC2zlUhLpdpGJ2W6ktdc9Os40S7ww13zS9+TnSN+8M+b3
         pDIbCO/94Gdk87zUyvCzXFqT34xMzA2i5RQMqyglFvgS+gDGhYpVObs7UPVl+Ivru/Xj
         +n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3wqDjIIE8Q8SrxMGLQQ+/3pVvnhzxLHerSHxNhcXno=;
        b=wUUCRrNelERpolnss72y+Wy+X8I4cqghynD8dBNx3muii2MxWhWRInSG+ZlaapRisV
         7/KfJNkH5hJ/WrO/yGmBXma6SS1Bm5hcFsP3Nw/sJrCuJ5oKZ8lPcGdSeB81hZPunOBl
         Fzx1m1M7KW5FyHI5X6G8zO5vgZL5qcdEvaIv+S7w3BydgcNTw2dxfntt32a9Rzuv6EH6
         ldiVon1oVEGqQJUetIF5bjng+xhp9JDjZ24sD22iOZY/RahdnPiHLcjmr/qW41Ssr61m
         kK5NHATkk12agggUW05Gtsx1Iu3tOkm+nEbvP1KampdUi4WLeNN/Z61xxAsa9rOZp3R0
         ltnQ==
X-Gm-Message-State: ANoB5pkBwjbawWx/rWZvWYqqGFc8WpN6Vxq+NH/KZ37+GIiE88T8EPkk
        ep+JMaqe2zGlaQLg9O38xtHsP6xUHzuCrw==
X-Google-Smtp-Source: AA0mqf7ziGnBbgo0HUL/RjzAgRd1TLQRF4llLOaW2ATB0U5XlhkzORaFyyrnsqVsz+bM/TP+T2UngA==
X-Received: by 2002:a05:6402:370c:b0:453:9fab:1b53 with SMTP id ek12-20020a056402370c00b004539fab1b53mr22529954edb.28.1667931473047;
        Tue, 08 Nov 2022 10:17:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:17:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/15] leak fixes: use existing constructors & other trivia
Date:   Tue,  8 Nov 2022 19:17:36 +0100
Message-Id: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a bag of simple leak fixes, mostly one-line additions where we
use existing destructors. See [1] for v1.

Changes since v1:

 * Rebased on pw/rebase-no-reflog-action, per [2].
 * It'll merge just fine without pw/rebase-no-reflog-action, but some
   of the tests marked as leak-free will still leak then. So, in
   practice they can be staged independently, as long as
   pw/rebase-no-reflog-action is merged down first.
 * The 10/15 here has an updated explanation about why we were leaking
   that value. see also[3].

As noted in my [4] some of the rebase/sequencer leaks addressed here
should have a more thorough fix to address the root cause of some of
them, which is also something pw/rebase-no-reflog-action is running
into (and why it's introducing a new leak, while fixing another one).

But per [4] I think the right thing to do is to merge both that topic
& this down first, and then we can follow-up with those fixes (which I
have staged locally already). Getting the extra leak coverage this
series & pw/rebase-no-reflog-action bring us will help in the
meantime.

1. https://lore.kernel.org/git/cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com/
2. https://lore.kernel.org/git/8eec228d-d392-523d-2415-149b946f642e@dunelm.org.uk/
3. https://lore.kernel.org/git/221108.86zgd1qxac.gmgdl@evledraar.gmail.com/
4. https://lore.kernel.org/git/221108.864jv9sc9r.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (15):
  tests: mark tests as passing with SANITIZE=leak
  {reset,merge}: call discard_index() before returning
  commit: discard partial cache before (re-)reading it
  read-cache.c: clear and free "sparse_checkout_patterns"
  dir.c: free "ident" and "exclude_per_dir" in "struct untracked_cache"
  built-ins & libs & helpers: add/move destructors, fix leaks
  unpack-file: fix ancient leak in create_temp_file()
  revision API: call graph_clear() in release_revisions()
  ls-files: fix a --with-tree memory leak
  sequencer.c: fix "opts->strategy" leak in read_strategy_opts()
  connected.c: free the "struct packed_git"
  rebase: don't leak on "--abort"
  cherry-pick: free "struct replay_opts" members
  revert: fix parse_options_concat() leak
  built-ins: use free() not UNLEAK() if trivial, rm dead code

 builtin/add.c                            |  2 +-
 builtin/bugreport.c                      |  9 +++--
 builtin/checkout.c                       |  2 ++
 builtin/commit.c                         | 13 +++++---
 builtin/config.c                         | 42 +++++++++++-------------
 builtin/diff.c                           |  2 +-
 builtin/ls-files.c                       |  1 +
 builtin/merge.c                          |  1 +
 builtin/rebase.c                         |  4 +++
 builtin/repack.c                         |  2 +-
 builtin/reset.c                          |  2 ++
 builtin/rev-parse.c                      |  1 +
 builtin/revert.c                         |  4 +++
 builtin/stash.c                          |  2 ++
 builtin/unpack-file.c                    |  1 +
 builtin/worktree.c                       |  7 ++--
 connected.c                              |  6 +++-
 dir.c                                    | 10 ++++--
 dir.h                                    |  1 +
 read-cache.c                             |  5 +++
 ref-filter.c                             |  1 +
 revision.c                               |  1 +
 sequencer.c                              |  1 +
 t/helper/test-fake-ssh.c                 |  1 +
 t/t0068-for-each-repo.sh                 |  1 +
 t/t0070-fundamental.sh                   |  1 +
 t/t1011-read-tree-sparse-checkout.sh     |  1 +
 t/t1022-read-tree-partial-clone.sh       |  2 +-
 t/t1404-update-ref-errors.sh             |  2 ++
 t/t1409-avoid-packing-refs.sh            |  1 +
 t/t1413-reflog-detach.sh                 |  1 +
 t/t1501-work-tree.sh                     |  2 ++
 t/t2012-checkout-last.sh                 |  1 +
 t/t2018-checkout-branch.sh               |  1 +
 t/t2025-checkout-no-overlay.sh           |  1 +
 t/t3009-ls-files-others-nonsubmodule.sh  |  1 +
 t/t3010-ls-files-killed-modified.sh      |  2 ++
 t/t3050-subprojects-fetch.sh             |  1 +
 t/t3060-ls-files-with-tree.sh            |  2 ++
 t/t3409-rebase-environ.sh                |  1 +
 t/t3413-rebase-hook.sh                   |  1 +
 t/t3428-rebase-signoff.sh                |  1 +
 t/t3429-rebase-edit-todo.sh              |  1 +
 t/t3433-rebase-across-mode-change.sh     |  1 +
 t/t4015-diff-whitespace.sh               |  4 +--
 t/t4045-diff-relative.sh                 |  2 ++
 t/t4052-stat-output.sh                   |  1 +
 t/t4053-diff-no-index.sh                 |  1 +
 t/t4067-diff-partial-clone.sh            |  1 +
 t/t4111-apply-subdir.sh                  |  1 +
 t/t4135-apply-weird-filenames.sh         |  1 +
 t/t4213-log-tabexpand.sh                 |  1 +
 t/t5544-pack-objects-hook.sh             |  2 ++
 t/t5554-noop-fetch-negotiator.sh         |  2 ++
 t/t5610-clone-detached.sh                |  1 +
 t/t5611-clone-config.sh                  |  1 +
 t/t5614-clone-submodules-shallow.sh      |  1 +
 t/t5617-clone-submodules-remote.sh       |  1 +
 t/t5618-alternate-refs.sh                |  2 ++
 t/t6060-merge-index.sh                   |  2 ++
 t/t6301-for-each-ref-errors.sh           |  1 +
 t/t6401-merge-criss-cross.sh             |  2 ++
 t/t6406-merge-attr.sh                    |  1 +
 t/t6407-merge-binary.sh                  |  1 +
 t/t6415-merge-dir-to-symlink.sh          |  1 +
 t/t6435-merge-sparse.sh                  |  1 +
 t/t7103-reset-bare.sh                    |  2 +-
 t/t7504-commit-msg-hook.sh               |  1 +
 t/t7517-per-repo-email.sh                |  1 +
 t/t7520-ignored-hook-warning.sh          |  1 +
 t/t7605-merge-resolve.sh                 |  1 +
 t/t7614-merge-signoff.sh                 |  1 +
 t/t9003-help-autocorrect.sh              |  2 ++
 t/t9115-git-svn-dcommit-funky-renames.sh |  1 -
 t/t9146-git-svn-empty-dirs.sh            |  1 -
 t/t9148-git-svn-propset.sh               |  1 -
 t/t9160-git-svn-preserve-empty-dirs.sh   |  1 -
 77 files changed, 142 insertions(+), 48 deletions(-)

Range-diff against v1:
 1:  7fe724599a7 !  1:  58a02e6bb4e tests: mark tests as passing with SANITIZE=leak
    @@ Commit message
           66eede4a37c (prepare_repo_settings(): plug leak of config values,
           2022-09-08)
     
    +    - t2012-checkout-last.sh, t7504-commit-msg-hook.sh,
    +      t91{15,46,60}-git-svn-*.sh: The in-flight "pw/rebase-no-reflog-action"
    +      series, upon which this is based:
    +      https://lore.kernel.org/git/pull.1405.git.1667575142.gitgitgadget@gmail.com/
    +
         Let's mark all of these as passing with
         "TEST_PASSES_SANITIZE_LEAK=true", to have it regression tested,
         including as part of the "linux-leaks" CI job.
    @@ t/t1022-read-tree-partial-clone.sh
      
      test_expect_success 'read-tree in partial clone prefetches in one batch' '
     
    + ## t/t2012-checkout-last.sh ##
    +@@ t/t2012-checkout-last.sh: test_description='checkout can switch to last branch and merge base'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup' '
    +
      ## t/t4015-diff-whitespace.sh ##
     @@ t/t4015-diff-whitespace.sh: test_expect_success 'no effect on diff from --color-moved with --word-diff' '
      	test_cmp expect actual
    @@ t/t7103-reset-bare.sh: test_expect_success '"mixed" reset is not allowed in bare
      	git reset --soft HEAD^ &&
      	git show --pretty=format:%s >out &&
      	echo one >expect &&
    +
    + ## t/t7504-commit-msg-hook.sh ##
    +@@ t/t7504-commit-msg-hook.sh: test_description='commit-msg hook'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'with no hook' '
    +
    + ## t/t9115-git-svn-dcommit-funky-renames.sh ##
    +@@
    + 
    + test_description='git svn dcommit can commit renames of files with ugly names'
    + 
    +-TEST_FAILS_SANITIZE_LEAK=true
    + . ./lib-git-svn.sh
    + 
    + test_expect_success 'load repository with strange names' '
    +
    + ## t/t9146-git-svn-empty-dirs.sh ##
    +@@
    + 
    + test_description='git svn creates empty directories'
    + 
    +-TEST_FAILS_SANITIZE_LEAK=true
    + . ./lib-git-svn.sh
    + 
    + test_expect_success 'initialize repo' '
    +
    + ## t/t9160-git-svn-preserve-empty-dirs.sh ##
    +@@ t/t9160-git-svn-preserve-empty-dirs.sh: This test uses git to clone a Subversion repository that contains empty
    + directories, and checks that corresponding directories are created in the
    + local Git repository with placeholder files.'
    + 
    +-TEST_FAILS_SANITIZE_LEAK=true
    + . ./lib-git-svn.sh
    + 
    + GIT_REPO=git-svn-repo
 2:  819fde89a24 =  2:  e9962ad790e {reset,merge}: call discard_index() before returning
 3:  c1003454939 =  3:  8e76a29cce7 commit: discard partial cache before (re-)reading it
 4:  68a390619b9 =  4:  24cefde07f0 read-cache.c: clear and free "sparse_checkout_patterns"
 5:  29123e62391 =  5:  f4fc08a9bc8 dir.c: free "ident" and "exclude_per_dir" in "struct untracked_cache"
 6:  009c41d2e91 !  6:  698a335b1a3 built-ins & libs & helpers: add/move destructors, fix leaks
    @@ builtin/checkout.c: static void die_if_some_operation_in_progress(void)
     
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 	strbuf_release(&buf);
      	strbuf_release(&revisions);
    + 	free(options.reflog_action);
      	free(options.head_name);
     +	strvec_clear(&options.git_am_opts);
      	free(options.gpg_sign_opt);
    @@ t/helper/test-fake-ssh.c: int cmd_main(int argc, const char **argv)
      		fprintf(f, "%s%s", i > 0 ? " " : "", i > 0 ? argv[i] : "ssh:");
      	fprintf(f, "\n");
     
    + ## t/t3409-rebase-environ.sh ##
    +@@
    + 
    + test_description='git rebase interactive environment'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup' '
    +
      ## t/t3428-rebase-signoff.sh ##
     @@ t/t3428-rebase-signoff.sh: test_description='git rebase --signoff
      This test runs git rebase --signoff and make sure that it works.
    @@ t/t3428-rebase-signoff.sh: test_description='git rebase --signoff
      . ./test-lib.sh
      
      # A simple file to commit
    +
    + ## t/t3433-rebase-across-mode-change.sh ##
    +@@
    + 
    + test_description='git rebase across mode change'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup' '
 7:  38e7c863dd8 =  7:  a2cc6f10d0d unpack-file: fix ancient leak in create_temp_file()
 8:  2944aaa3ddc !  8:  45aa6e24c66 revision API: call graph_clear() in release_revisions()
    @@ revision.c: void release_revisions(struct rev_info *revs)
      	diff_free(&revs->pruning);
      	reflog_walk_info_release(revs->reflog_info);
     
    + ## t/t3413-rebase-hook.sh ##
    +@@ t/t3413-rebase-hook.sh: test_description='git rebase with its hook(s)'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success setup '
    +
      ## t/t4052-stat-output.sh ##
     @@ t/t4052-stat-output.sh: test_description='test --stat output of various commands'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 9:  d592439760e =  9:  46809d9be80 ls-files: fix a --with-tree memory leak
10:  9c70bfa334e ! 10:  243ab74120b sequencer.c: fix "opts->strategy" leak in read_strategy_opts()
    @@ Commit message
     
         When "read_strategy_opts()" is called we may have populated the
         "opts->strategy" before, so we'll need to free() it to avoid leaking
    -    memory. Along with the preceding commit this change various
    -    rebase-related tests pass.
    +    memory.
    +
    +    We populate it before because we cal get_replay_opts() from within
    +    "rebase.c" with an already populated "opts", which we then copy. Then
    +    if we're doing a "rebase -i" the sequencer API itself will promptly
    +    clobber our alloc'd version of it with its own.
    +
    +    If this code is changed to do, instead of the added free() here a:
    +
    +            if (opts->strategy)
    +                    opts->strategy = xstrdup("another leak");
    +
    +    We get a couple of stacktraces from -fsanitize=leak showing how we
    +    ended up clobbering the already allocated value, i.e.:
    +
    +            Direct leak of 6 byte(s) in 1 object(s) allocated from:
    +                #0 0x7f2e8cd45545 in __interceptor_malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:75
    +                #1 0x7f2e8cb0fcaa in __GI___strdup string/strdup.c:42
    +                #2 0x6c4778 in xstrdup wrapper.c:39
    +                #3 0x66bcb8 in read_strategy_opts sequencer.c:2902
    +                #4 0x66bf7b in read_populate_opts sequencer.c:2969
    +                #5 0x6723f9 in sequencer_continue sequencer.c:5063
    +                #6 0x4a4f74 in run_sequencer_rebase builtin/rebase.c:348
    +                #7 0x4a64c8 in run_specific_rebase builtin/rebase.c:753
    +                #8 0x4a9b8b in cmd_rebase builtin/rebase.c:1824
    +                #9 0x407a32 in run_builtin git.c:466
    +                #10 0x407e0a in handle_builtin git.c:721
    +                #11 0x40803d in run_argv git.c:788
    +                #12 0x40850f in cmd_main git.c:923
    +                #13 0x4eee79 in main common-main.c:57
    +                #14 0x7f2e8ca9f209 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    +                #15 0x7f2e8ca9f2bb in __libc_start_main_impl ../csu/libc-start.c:389
    +                #16 0x405fd0 in _start (git+0x405fd0)
    +
    +            Direct leak of 4 byte(s) in 1 object(s) allocated from:
    +                #0 0x7f2e8cd45545 in __interceptor_malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:75
    +                #1 0x7f2e8cb0fcaa in __GI___strdup string/strdup.c:42
    +                #2 0x6c4778 in xstrdup wrapper.c:39
    +                #3 0x4a3c31 in xstrdup_or_null git-compat-util.h:1169
    +                #4 0x4a447a in get_replay_opts builtin/rebase.c:163
    +                #5 0x4a4f5b in run_sequencer_rebase builtin/rebase.c:346
    +                #6 0x4a64c8 in run_specific_rebase builtin/rebase.c:753
    +                #7 0x4a9b8b in cmd_rebase builtin/rebase.c:1824
    +                #8 0x407a32 in run_builtin git.c:466
    +                #9 0x407e0a in handle_builtin git.c:721
    +                #10 0x40803d in run_argv git.c:788
    +                #11 0x40850f in cmd_main git.c:923
    +                #12 0x4eee79 in main common-main.c:57
    +                #13 0x7f2e8ca9f209 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    +                #14 0x7f2e8ca9f2bb in __libc_start_main_impl ../csu/libc-start.c:389
    +                #15 0x405fd0 in _start (git+0x405fd0)
    +
    +    This can be seen in e.g. the 4th test of
    +    "t3404-rebase-interactive.sh".
    +
    +    In the larger picture the ownership of the "struct replay_opts" is
    +    quite a mess, e.g. in this case rebase.c's static "get_replay_opts()"
    +    function partially creates it, but nothing in rebase.c will free()
    +    it. The structure is "mostly owned" by the sequencer API, but it also
    +    expects to get these partially populated versions of it.
    +
    +    It would be better to have rebase keep track of what it allocated, and
    +    free() that, and to pass that as a "const" to the sequencer API, which
    +    would copy what it needs to its own version, and to free() that.
    +
    +    But doing so is a much larger change, and however messy the ownership
    +    boundary is here is consistent with what we're doing already, so let's
    +    just free() this to fix the leak.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
11:  c7722f68ae2 = 11:  15f0837697d connected.c: free the "struct packed_git"
12:  7429151b5c4 <  -:  ----------- sequencer.c: fix a pick_commits() leak
13:  fda9914b558 = 12:  f6d76250174 rebase: don't leak on "--abort"
14:  02e1dddf149 <  -:  ----------- sequencer.c: fix sequencer_continue() leak
15:  c9f51abf0e2 = 13:  10a477c7730 cherry-pick: free "struct replay_opts" members
16:  f7d39020a7c = 14:  614c8fc1aef revert: fix parse_options_concat() leak
17:  33a5753cc3a = 15:  f3e6a030394 built-ins: use free() not UNLEAK() if trivial, rm dead code
-- 
2.38.0.1467.g709fbdff1a9

