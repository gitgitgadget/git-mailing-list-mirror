Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59778C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjAQRLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjAQRLb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:31 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF0733452
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s21so1794515edi.12
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6AeabcxYPHDZtEfK1cEDXIIDd4wErmSCgmzeYv5yG4=;
        b=kReGi4NFl5BMKDFQDtui2XpdpHl8CpQts2N2KKcYkbLxJd4Ex4eLHUxRYjC1E9WoqA
         4EUeck0x1/Nooh14KMWdT2q0Z9c2YekiWrbYhjA0S9ATitD6K0vwPTll7oURiU2hLxV1
         eSqVAqcz+1LADCu/DxKSOcC68Bu+tIRRxnl5gGHsjDWXBcFajd1YPK+D+BzXvPCHNSyC
         jyHuDb3/hRy99hXKy8iV2wPkRYvIkqkuoWF89wrmxAftaK3QPWca9VUIMsHfQjIYjQjz
         atF3ELd7jDUhHw/PTXMN+KRaAfs3CYsupuP8UaGqos3eE0wSHPz7QhA6BbVOB+B9W1OC
         v7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6AeabcxYPHDZtEfK1cEDXIIDd4wErmSCgmzeYv5yG4=;
        b=R9trNXD/bVHXJ1hzU61QOWX2hZf+igekDHIF5XMHY74LLZEaK8OZ3LWT1AWnewJyTl
         JZ86d7omr7YRIeFMHTY0NVtilJ/tFFpxVr81RpHRoih69DQH87g8Blwysji7CVGo8iN8
         PAIxpvWgFe8+lxV2LV6acLrvu7F0UvFJdYr73wEEmbVRtIuNOxWINk1JwgZqP7i/likU
         Bet9yx3LPNMP3cRI62EPF6pft69iu7uuacpz35J9WQNOm18026CTCvTKu+vcsUjtvpuB
         zaZ/5iGVwGgKHk+wDBkZoJ3ZOCkcgqA7uwFQSKFsE36d9OisD7dcylQ8m9u5/c1cmOEJ
         9vqQ==
X-Gm-Message-State: AFqh2kp4A6Tt0NWJr3aGUGT2BESgpQgPUvGBMOwN+1TX8He/jv+COvkh
        bVb8SFbwaNyQYqXsCHddBUr97817lHIvyQ==
X-Google-Smtp-Source: AMrXdXtyEjtg/mG+wGiymzVyUQJMdmM5T87TY5uxcyHCtN9Jbdmua0m5OpLENold6awRWmZG6PvcsA==
X-Received: by 2002:aa7:de99:0:b0:48e:b020:6c14 with SMTP id j25-20020aa7de99000000b0048eb0206c14mr3979161edv.26.1673975486941;
        Tue, 17 Jan 2023 09:11:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/19] leak fixes: various simple leak fixes
Date:   Tue, 17 Jan 2023 18:11:05 +0100
Message-Id: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See
https://lore.kernel.org/git/cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com/
for the v3. Change since then:

 * Reword the subject of a commit message that no longer matched its
   content/body (thanks René).

 * Re-ran "GIT_TEST_PASSING_SANITIZE_LEAK=check
   GIT_TEST_SANITIZE_LEAK_LOG=true make SANITIZE=leak test" with "git
   rebase -i -x", so and updated the leak markings for other fixes
   that have landed on "master" since they were last updated. The tip
   of this (and all intermediate commits) pass the "check" mode.

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
  object-file.c: release the "tag" in check_tag()
  grep.c: refactor free_grep_patterns()
  grep API: plug memory leaks by freeing "header_list"
  receive-pack: free() the "ref_name" in "struct command"
  push: free_refs() the "local_refs" in set_refspecs()

 archive.c                                  |  1 +
 builtin/clean.c                            |  1 +
 builtin/clone.c                            |  5 +++--
 builtin/commit-graph.c                     | 10 ++++++----
 builtin/merge.c                            | 14 ++++++-------
 builtin/name-rev.c                         | 23 ++++++++++------------
 builtin/push.c                             |  1 +
 builtin/receive-pack.c                     | 10 ++++++++++
 builtin/repack.c                           | 13 ++++++------
 builtin/reset.c                            | 11 ++++++++---
 builtin/show-branch.c                      |  1 +
 builtin/stash.c                            |  7 +++++--
 builtin/worktree.c                         |  6 +++---
 bundle.c                                   |  6 ++++--
 grep.c                                     | 15 +++++++++-----
 http-backend.c                             |  9 +++++++--
 object-file.c                              |  1 +
 t/t0023-crlf-am.sh                         |  1 +
 t/t1301-shared-repo.sh                     |  1 +
 t/t1302-repo-version.sh                    |  1 +
 t/t1304-default-acl.sh                     |  1 +
 t/t1408-packed-refs.sh                     |  1 +
 t/t1410-reflog.sh                          |  1 +
 t/t1416-ref-transaction-hooks.sh           |  1 +
 t/t2401-worktree-prune.sh                  |  1 +
 t/t2402-worktree-list.sh                   |  1 +
 t/t2406-worktree-repair.sh                 |  1 +
 t/t3203-branch-output.sh                   |  2 ++
 t/t3210-pack-refs.sh                       |  1 +
 t/t3800-mktag.sh                           |  1 +
 t/t4152-am-subjects.sh                     |  2 ++
 t/t4254-am-corrupt.sh                      |  2 ++
 t/t4256-am-format-flowed.sh                |  1 +
 t/t4257-am-interactive.sh                  |  2 ++
 t/t5001-archive-attr.sh                    |  1 +
 t/t5004-archive-corner-cases.sh            |  2 ++
 t/t5302-pack-index.sh                      |  2 ++
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
 t/t7105-reset-patch.sh                     |  2 ++
 t/t7106-reset-unborn-branch.sh             |  2 ++
 t/t7107-reset-pathspec-file.sh             |  1 +
 t/t7301-clean-interactive.sh               |  1 +
 t/t7403-submodule-sync.sh                  |  1 +
 t/t7409-submodule-detached-work-tree.sh    |  1 +
 t/t7416-submodule-dash-url.sh              |  2 ++
 t/t7450-bad-git-dotfiles.sh                |  2 ++
 t/t7701-repack-unpack-unreachable.sh       |  1 +
 73 files changed, 158 insertions(+), 50 deletions(-)

Range-diff against v3:
 1:  f5b67f44e2d =  1:  2ed69e3cda3 tests: mark tests as passing with SANITIZE=leak
 2:  88c6b66be3c =  2:  9993786ba0d bundle.c: don't leak the "args" in the "struct child_process"
 3:  8cc8060cd92 =  3:  8e98d7c4ebf commit-graph: use free_commit_graph() instead of UNLEAK()
 4:  765d5cbcf81 =  4:  966d7657d54 clone: use free() instead of UNLEAK()
 5:  5087fb73286 =  5:  93a8f8fa1b9 various: add missing clear_pathspec(), fix leaks
 6:  39cb8aefb58 =  6:  bd15d991ac7 name-rev: don't xstrdup() an already dup'd string
 7:  a3f1e800127 =  7:  fd890121ebe repack: fix leaks on error with "goto cleanup"
 8:  f918a6f2adc !  8:  1fe25bc6981 worktree: fix a trivial leak in prune_worktrees()
    @@ t/t2406-worktree-repair.sh
      . ./test-lib.sh
      
      test_expect_success setup '
    +
    + ## t/t3203-branch-output.sh ##
    +@@
    + #!/bin/sh
    + 
    + test_description='git branch display tests'
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY"/lib-terminal.sh
    + 
 9:  56204806dfd =  9:  6b3dd9b15f0 http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
10:  5355e0fc60b = 10:  246f71bb447 http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
11:  dfb52dbd1c4 = 11:  ab31d8d10da commit-graph: fix a parse_options_concat() leak
12:  e44e74dcc58 = 12:  9054b353220 show-branch: free() allocated "head" before return
13:  6d99fdcc44e ! 13:  05836b08e0f builtin/merge.c: always free "struct strbuf msg"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    builtin/merge.c: always free "struct strbuf msg"
    +    builtin/merge.c: use fixed strings, not "strbuf", fix leak
     
         Follow-up 465028e0e25 (merge: add missing strbuf_release(),
         2021-10-07) and address the "msg" memory leak in this block. We could
14:  a3bf3045597 = 14:  e8ea18b08c2 builtin/merge.c: free "&buf" on "Your local changes..." error
15:  7c70bbdebc8 = 15:  66c24afb893 object-file.c: release the "tag" in check_tag()
16:  17537e1393e = 16:  52744d9690f grep.c: refactor free_grep_patterns()
17:  e4bd46a343e = 17:  8ff63d9095c grep API: plug memory leaks by freeing "header_list"
18:  3e4b12cb623 ! 18:  0ad7d59b881 receive-pack: free() the "ref_name" in "struct command"
    @@ t/t5527-fetch-odd-refs.sh: test_description='test fetching of oddly-named refs'
      
      # afterwards we will have:
     
    + ## t/t5560-http-backend-noserver.sh ##
    +@@ t/t5560-http-backend-noserver.sh: test_description='test git-http-backend-noserver'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
    +
    + ## t/t5561-http-backend.sh ##
    +@@ t/t5561-http-backend.sh: test_description='test git-http-backend'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY"/lib-httpd.sh
    + 
    +
    + ## t/t5562-http-backend-content-length.sh ##
    +@@
    + #!/bin/sh
    + 
    + test_description='test git-http-backend respects CONTENT_LENGTH'
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_lazy_prereq GZIP 'gzip --version'
    +
      ## t/t5705-session-id-in-capabilities.sh ##
     @@
      
19:  d51ed239a8a ! 19:  b3aee41d0b4 push: free_refs() the "local_refs" in set_refspecs()
    @@ t/t1416-ref-transaction-hooks.sh: test_description='reference transaction hooks'
      
      test_expect_success setup '
     
    + ## t/t2402-worktree-list.sh ##
    +@@ t/t2402-worktree-list.sh: test_description='test git worktree list'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup' '
    +
      ## t/t5504-fetch-receive-strict.sh ##
     @@ t/t5504-fetch-receive-strict.sh: test_description='fetch/receive strict mode'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
-- 
2.39.0.1225.g30a3d88132d

