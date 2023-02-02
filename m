Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B33C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBBJxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjBBJxF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBF565BA
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:52:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so3283643wmb.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t91a9Gj//9ssj0Vn1dbgddIDK/Y3gndsuGypYc0GlT4=;
        b=hzwJ1sy6Aj8zo9ffq2RvqgPInw07WTN9YLQVWabtXFwzM+8JaxwfMDNgZGKPoOHyhX
         X2RXLYDfZwX4Sho4Tz1UNkDCgGGjVu1eiWEhdR1K5YvnFgSUPuK+AqIYFK+lFpZbLQyG
         iE6oVHVK4IPKDznW6TRG7oBimdsvrruYXY+a3LpN10RfOJXROXmcqk2G6UAP90sJTr3b
         cVR941olnAQh5tTOAsBANeUKgzVXu2c5R2G8FEzXjGa3NqkocFwyYNTkiN5brxDWMnEV
         FBpKv/EFScIkV4nPeVf/KhLLFJRcxHSSZ4r4PRUxONPxEePlmaT8zZdXeQlw4mHdwdu+
         pILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t91a9Gj//9ssj0Vn1dbgddIDK/Y3gndsuGypYc0GlT4=;
        b=RZFKWgjDyuaP7L0Z5vu3D828hhLHLaYCb8F/KnjMT+vApWONoEZeHKF/fmum4NBVgi
         eG3J32ky1nvLrC16i2eYre/cjroJiDb3iZdBtJmNyT89JO6TnMa9ti4erPSWoldy/DUE
         r/FUcuIKWkDEyY91jNCTNftr0BJsm3n0Em8fb1NVNUAjE/p5Mp4fgACd0GWYC+3Zyc8A
         72oJhfspXYnzfCL6mhb/0LmhRKZ76rOCb5eFeDbtePi5NOS4WcW2fzp39zkFhL04Aemk
         NqGF2hXx3pH8P6XaEhzr+FV4FDGFB78VuOqoTYOGCOOHWii/8XnUqyGViXioOUE8s/5z
         HrBA==
X-Gm-Message-State: AO0yUKX3hMkjEj35plofQfWbQWmQ5H5P/bocJrMqpW2zwQcydAvxPiVX
        rYc3c8IY+9Z0jJm7oj2r5wjl0XbXqwCMSBG6
X-Google-Smtp-Source: AK7set9A/CAaejgzXkrXU86iPcdgrPaJ4bvTZRh1dNjILbuns56oY9bIhIF75jCpXC4fVL/fqz62oQ==
X-Received: by 2002:a05:600c:46ce:b0:3df:e1d1:e14c with SMTP id q14-20020a05600c46ce00b003dfe1d1e14cmr362141wmo.20.1675331575665;
        Thu, 02 Feb 2023 01:52:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:52:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 00/19] leak fixes: various simple leak fixes
Date:   Thu,  2 Feb 2023 10:52:31 +0100
Message-Id: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See
https://lore.kernel.org/git/cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com/
for the v5. Changes since then:

* Rebased on master, the recent "fsck" changes made the check_tag()
  patch here redundant, and made various existing tests leak-free,
  which we now mark as such.

* Took major rewrites of commit messages from Elijah, thanks. Added a
  corresponding Helped-by footer to those. Fixed other typos etc. in
  commit messages.

* Add a new 18/19 which addreses the TODO issue René & Elijah pointed
  out in previous rounds.

  I was hoping to keep larger changes like that out of this topic, but
  if we need to explain with a "FIXME" comment or similar what exactly
  we need to fix here (as was suggested), then we might as well just
  fix it instead.

* The subsequent free_refs() patch is the same, but we now explain why
  we're not leaking the "remote" (it's free'd by
  "the_repository->remote_state" cleanup).

CI & branch for this at:
https://github.com/avar/git/tree/avar/leak-fixes-more-misc-trivial-6

Ævar Arnfjörð Bjarmason (19):
  tests: mark tests as passing with SANITIZE=leak
  bundle.c: don't leak the "args" in the "struct child_process"
  commit-graph: use free_commit_graph() instead of UNLEAK()
  clone: use free() instead of UNLEAK()
  various: add missing clear_pathspec(), fix leaks
  name-rev: don't xstrdup() an already dup'd string
  repack: fix leaks on error with "goto cleanup"
  worktree: fix a trivial leak in prune_worktrees()
  http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
  http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
  commit-graph: fix a parse_options_concat() leak
  show-branch: free() allocated "head" before return
  builtin/merge.c: use fixed strings, not "strbuf", fix leak
  builtin/merge.c: free "&buf" on "Your local changes..." error
  grep.c: refactor free_grep_patterns()
  grep API: plug memory leaks by freeing "header_list"
  receive-pack: free() the "ref_name" in "struct command"
  push: refactor refspec_append_mapped() for subsequent leak-fix
  push: free_refs() the "local_refs" in set_refspecs()

 archive.c                                  |  1 +
 builtin/clean.c                            |  1 +
 builtin/clone.c                            |  5 ++--
 builtin/commit-graph.c                     | 10 +++++---
 builtin/merge.c                            | 14 +++++-----
 builtin/name-rev.c                         | 23 ++++++++---------
 builtin/push.c                             | 30 +++++++++++++---------
 builtin/receive-pack.c                     | 10 ++++++++
 builtin/repack.c                           | 13 +++++-----
 builtin/reset.c                            | 11 +++++---
 builtin/show-branch.c                      |  1 +
 builtin/stash.c                            |  7 +++--
 builtin/worktree.c                         |  6 ++---
 bundle.c                                   |  6 +++--
 grep.c                                     | 15 +++++++----
 http-backend.c                             |  9 +++++--
 t/t0023-crlf-am.sh                         |  1 +
 t/t1301-shared-repo.sh                     |  1 +
 t/t1302-repo-version.sh                    |  1 +
 t/t1304-default-acl.sh                     |  1 +
 t/t1408-packed-refs.sh                     |  1 +
 t/t1410-reflog.sh                          |  1 +
 t/t1416-ref-transaction-hooks.sh           |  1 +
 t/t1451-fsck-buffer.sh                     |  2 ++
 t/t2401-worktree-prune.sh                  |  1 +
 t/t2402-worktree-list.sh                   |  1 +
 t/t2406-worktree-repair.sh                 |  1 +
 t/t3210-pack-refs.sh                       |  1 +
 t/t3800-mktag.sh                           |  1 +
 t/t4152-am-subjects.sh                     |  2 ++
 t/t4254-am-corrupt.sh                      |  2 ++
 t/t4256-am-format-flowed.sh                |  1 +
 t/t4257-am-interactive.sh                  |  2 ++
 t/t5001-archive-attr.sh                    |  1 +
 t/t5004-archive-corner-cases.sh            |  2 ++
 t/t5302-pack-index.sh                      |  2 ++
 t/t5306-pack-nobase.sh                     |  2 ++
 t/t5312-prune-corruption.sh                |  1 +
 t/t5317-pack-objects-filter-objects.sh     |  1 +
 t/t5330-no-lazy-fetch-with-commit-graph.sh |  1 +
 t/t5403-post-checkout-hook.sh              |  1 +
 t/t5405-send-pack-rewind.sh                |  1 +
 t/t5406-remote-rejects.sh                  |  1 +
 t/t5502-quickfetch.sh                      |  1 +
 t/t5504-fetch-receive-strict.sh            |  1 +
 t/t5507-remote-environment.sh              |  2 ++
 t/t5522-pull-symlink.sh                    |  1 +
 t/t5523-push-upstream.sh                   |  1 +
 t/t5527-fetch-odd-refs.sh                  |  1 +
 t/t5529-push-errors.sh                     |  2 ++
 t/t5546-receive-limits.sh                  |  2 ++
 t/t5547-push-quarantine.sh                 |  2 ++
 t/t5560-http-backend-noserver.sh           |  1 +
 t/t5561-http-backend.sh                    |  1 +
 t/t5562-http-backend-content-length.sh     |  2 ++
 t/t5573-pull-verify-signatures.sh          |  2 ++
 t/t5604-clone-reference.sh                 |  1 +
 t/t5606-clone-options.sh                   |  1 +
 t/t5613-info-alternate.sh                  |  2 ++
 t/t5705-session-id-in-capabilities.sh      |  1 +
 t/t5810-proto-disable-local.sh             |  2 ++
 t/t5813-proto-disable-ssh.sh               |  2 ++
 t/t6011-rev-list-with-bad-commit.sh        |  1 +
 t/t6014-rev-list-all.sh                    |  1 +
 t/t6021-rev-list-exclude-hidden.sh         |  1 +
 t/t6439-merge-co-error-msgs.sh             |  1 +
 t/t6501-freshen-objects.sh                 |  1 +
 t/t7105-reset-patch.sh                     |  2 ++
 t/t7106-reset-unborn-branch.sh             |  2 ++
 t/t7107-reset-pathspec-file.sh             |  1 +
 t/t7301-clean-interactive.sh               |  1 +
 t/t7403-submodule-sync.sh                  |  1 +
 t/t7409-submodule-detached-work-tree.sh    |  1 +
 t/t7416-submodule-dash-url.sh              |  2 ++
 t/t7450-bad-git-dotfiles.sh                |  2 ++
 t/t7612-merge-verify-signatures.sh         |  1 +
 t/t7701-repack-unpack-unreachable.sh       |  1 +
 77 files changed, 181 insertions(+), 62 deletions(-)

Range-diff against v5:
 1:  c47fc0fb637 !  1:  36da48d4db9 tests: mark tests as passing with SANITIZE=leak
    @@ Commit message
           t7701-repack-unpack-unreachable.sh: In b0c61be3209 (Merge branch
           'rs/reflog-expiry-cleanup', 2022-12-26)
     
    +    - t3800-mktag.sh, t5302-pack-index.sh, t5306-pack-nobase.sh,
    +      t5573-pull-verify-signatures.sh, t7612-merge-verify-signatures.sh: In
    +      69bbbe484ba (hash-object: use fsck for object checks, 2023-01-18).
    +
    +    - t1451-fsck-buffer.sh: In 8e4309038f0 (fsck: do not assume
    +      NUL-termination of buffers, 2023-01-19).
    +
    +    - t6501-freshen-objects.sh: In abf2bb895b4 (Merge branch
    +      'jk/hash-object-fsck', 2023-01-30)
    +
         1. 9ea1378d046 (Merge branch 'ab/various-leak-fixes', 2022-12-14)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ t/t0023-crlf-am.sh
      cat >patchfile <<\EOF
     
      ## t/t1301-shared-repo.sh ##
    -@@ t/t1301-shared-repo.sh: test_description='Test shared repository initialization'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    +@@ t/t1301-shared-repo.sh: GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
      export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
    + TEST_CREATE_REPO_NO_TEMPLATE=1
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    @@ t/t1410-reflog.sh: test_description='Test prune and reflog expiration'
      
      check_have () {
     
    + ## t/t1451-fsck-buffer.sh ##
    +@@ t/t1451-fsck-buffer.sh: so.
    + These tests _might_ catch such overruns in normal use, but should be run with
    + ASan or valgrind for more confidence.
    + '
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + # the general idea for tags and commits is to build up the "base" file
    +
      ## t/t3210-pack-refs.sh ##
     @@ t/t3210-pack-refs.sh: semantic is still the same.
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    @@ t/t3210-pack-refs.sh: semantic is still the same.
      
      test_expect_success 'enable reflogs' '
     
    + ## t/t3800-mktag.sh ##
    +@@
    + 
    + test_description='git mktag: tag object verify test'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + ###########################################################
    +
      ## t/t4152-am-subjects.sh ##
     @@
      #!/bin/sh
    @@ t/t4257-am-interactive.sh
      
      test_expect_success 'set up patches to apply' '
     
    + ## t/t5302-pack-index.sh ##
    +@@
    + #
    + 
    + test_description='pack index with 64-bit offsets and object CRC'
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup' '
    +
    + ## t/t5306-pack-nobase.sh ##
    +@@
    + test_description='git-pack-object with missing base
    + 
    + '
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + # Create A-B chain
    +
      ## t/t5317-pack-objects-filter-objects.sh ##
     @@ t/t5317-pack-objects-filter-objects.sh: test_description='git pack-objects using object filtering'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    @@ t/t5502-quickfetch.sh: test_description='test quickfetch from local'
      
      test_expect_success setup '
     
    + ## t/t5573-pull-verify-signatures.sh ##
    +@@
    + #!/bin/sh
    + 
    + test_description='pull signature verification tests'
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY/lib-gpg.sh"
    + 
    +
      ## t/t5604-clone-reference.sh ##
     @@ t/t5604-clone-reference.sh: test_description='test clone --reference'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    @@ t/t6021-rev-list-exclude-hidden.sh
      
      test_expect_success 'setup' '
     
    + ## t/t6501-freshen-objects.sh ##
    +@@ t/t6501-freshen-objects.sh: test_description='check pruning of dependent objects'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + # We care about reachability, so we do not want to use
    +
      ## t/t7403-submodule-sync.sh ##
     @@ t/t7403-submodule-sync.sh: These tests exercise the "git submodule sync" subcommand.
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    @@ t/t7403-submodule-sync.sh: These tests exercise the "git submodule sync" subcomm
      
      test_expect_success setup '
     
    + ## t/t7612-merge-verify-signatures.sh ##
    +@@ t/t7612-merge-verify-signatures.sh: test_description='merge signature verification tests'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY/lib-gpg.sh"
    + 
    +
      ## t/t7701-repack-unpack-unreachable.sh ##
     @@ t/t7701-repack-unpack-unreachable.sh: test_description='git repack works correctly'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 2:  9eb758117dc !  2:  f0f1a388350 bundle.c: don't leak the "args" in the "struct child_process"
    @@ Commit message
         bundle.c: don't leak the "args" in the "struct child_process"
     
         Fix a leak that's been here since 7366096de9d (bundle API: change
    -    "flags" to be "extra_index_pack_args", 2021-09-05), if can't verify
    -    the bundle we didn't call child_process_clear() to clear the "args".
    +    "flags" to be "extra_index_pack_args", 2021-09-05). If we can't verify
    +    the bundle, we didn't call child_process_clear() to clear the "args".
     
    -    But rather than doing that let's verify the bundle before we start
    -    preparing the process we're going to spawn, if we get an error we
    -    don't need to push anything to the "args".
    +    But rather than adding an additional child_process_clear() call, let's
    +    verify the bundle before we start preparing the process we're going to
    +    spawn. If we fail to verify, we don't need to push anything to the
    +    child_process "args".
     
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## bundle.c ##
 3:  01b6229f18a =  3:  cf0dddf4e8c commit-graph: use free_commit_graph() instead of UNLEAK()
 4:  f4f3aef2861 =  4:  0430c1fec1b clone: use free() instead of UNLEAK()
 5:  8d10fbe0b8f =  5:  fb2d9875c73 various: add missing clear_pathspec(), fix leaks
 6:  eb5dc3ac192 =  6:  bca659788de name-rev: don't xstrdup() an already dup'd string
 7:  1fac90c306a !  7:  09950d92940 repack: fix leaks on error with "goto cleanup"
    @@ Metadata
      ## Commit message ##
         repack: fix leaks on error with "goto cleanup"
     
    -    Change cmd_repack() to "goto cleanup" rather than "return ret" on
    -    error, when we returned we'd potentially skip cleaning up the
    -    string_lists and other data we'd allocated in this function.
    +    In cmd_repack() when we hit an error, replace "return ret" with "goto
    +    cleanup" to ensure we free the necessary data structures.
     
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/repack.c ##
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     +	return ret;
      }
     
    + ## t/t5312-prune-corruption.sh ##
    +@@ t/t5312-prune-corruption.sh: what currently happens. If that changes, these tests should be revisited.
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'disable reflogs' '
    +
      ## t/t6011-rev-list-with-bad-commit.sh ##
     @@
      
 8:  02248aca3eb =  8:  cd3eb9e68ff worktree: fix a trivial leak in prune_worktrees()
 9:  b39d6d29dd5 =  9:  e80a719913b http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
10:  928dea2d4ee = 10:  9d9df0caf17 http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
11:  5770b9eb764 = 11:  65e25377791 commit-graph: fix a parse_options_concat() leak
12:  3ff86cb808c = 12:  3b1d47b9d62 show-branch: free() allocated "head" before return
13:  1f3e3524580 = 13:  a85e5f3b14e builtin/merge.c: use fixed strings, not "strbuf", fix leak
14:  15e4b8db805 = 14:  7dbc422d5b4 builtin/merge.c: free "&buf" on "Your local changes..." error
15:  d36ad1f818a <  -:  ----------- object-file.c: release the "tag" in check_tag()
16:  10959760dfc ! 15:  aa51668b70d grep.c: refactor free_grep_patterns()
    @@ Commit message
         grep.c: refactor free_grep_patterns()
     
         Refactor the free_grep_patterns() function to split out the freeing of
    -    the "struct grep_pat" it contains, right now we're only freeing the
    +    the "struct grep_pat" it contains. Right now we're only freeing the
         "pattern_list", but we should be freeing another member of the same
         type, which we'll do in the subsequent commit.
     
    @@ Commit message
     
                 if (!x)
                         return;
    -            free(y);
    +            free_pattern_expr(y);
     
    -    But after the cleanup in db84376f981 (which was a narrow segfault fix,
    -    and thus avoided refactoring this) we ended up with:
    +    While at it, instead of:
     
                 if (!x)
                         return;
    -            free(x);
    +            free_pattern_expr(x);
     
         Let's instead do:
     
                 if (x)
    -                    free(x);
    +                    free_pattern_expr(x);
     
    -    This doesn't matter for the subsequent change, but as we're
    -    refactoring this function let's make it easier to reason about, and to
    -    extend in the future, i.e. if we start to free free() members that
    -    come after "pattern_expression" in the "struct grep_opt".
    +    This will make it easier to free additional members from
    +    free_grep_patterns() in the future.
     
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## grep.c ##
17:  6a8f4a567aa ! 16:  0c51ea7fd2d grep API: plug memory leaks by freeing "header_list"
    @@ Metadata
      ## Commit message ##
         grep API: plug memory leaks by freeing "header_list"
     
    -    When the "header_list" struct member was added in [1] it wasn't made
    -    to free the list using loop added for the adjacent "pattern_list"
    -    member, see [2] for when we started freeing it.
    -
    -    This makes e.g. this command leak-free when run on git.git:
    +    When the "header_list" struct member was added in [1], freeing this
    +    field was neglected. Fix that now, so that commands like
     
                 ./git -P log -1 --color=always --author=A origin/master
     
    +    will run leak-free.
    +
         1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
            not union, 2010-01-17)
    -    2. b48fb5b6a95 (grep: free expressions and patterns when done.,
    -       2006-09-27)
     
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## grep.c ##
18:  3c3d48df04b ! 17:  4b2db91f5cb receive-pack: free() the "ref_name" in "struct command"
    @@ Commit message
         receive-pack: free() the "ref_name" in "struct command"
     
         Fix a memory leak that's been with us since this code was introduced
    -    in 575f497456e (Add first cut at "git-receive-pack", 2005-06-29), see
    +    in 575f497456e (Add first cut at "git-receive-pack", 2005-06-29). See
         eb1af2df0b1 (git-receive-pack: start parsing ref update commands,
         2005-06-29) for the later change that refactored the code to add the
         "ref_name" member.
 -:  ----------- > 18:  aa33f7e05c8 push: refactor refspec_append_mapped() for subsequent leak-fix
19:  f29500a4abc ! 19:  67076dfba6d push: free_refs() the "local_refs" in set_refspecs()
    @@ Commit message
         Fix a memory leak that's been with us since this code was added in
         ca02465b413 (push: use remote.$name.push as a refmap, 2013-12-03).
     
    +    The "remote = remote_get(...)" added in the same commit would seem to
    +    leak based only on the context here, but that function is a wrapper
    +    for sticking the remotes we fetch into "the_repository->remote_state".
    +
    +    See fd3cb0501e1 (remote: move static variables into per-repository
    +    struct, 2021-11-17) for the addition of code in repository.c that
    +    free's the "remote" allocated here.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/push.c ##
-- 
2.39.1.1392.g63e6d408230

