Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E97C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjARMqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjARMpa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:45:30 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C02BF03
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:36 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s21so5112384edi.12
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdZF1tAGansRLUszaKL7L1yU4x1TqVC4B8AnL/+51jg=;
        b=Ixb14NXayPKYxL6aByM5PVIZz5OnMEMBWwfaBn4Hd5JnXVIbxpkkRdLdTC3IJ6qRBD
         McH1rKqrKWG6raedQBeS0+bcKwH+zSb8QOJivWP4HuZhxPZp/VA9fVNkvX7WuWcjQEY1
         FOGX1ZejBhyCnWGm40vjJGu/CpowkQls0eLFPPqyHsQrtKUS23sCnpIpu30bdmV5dg6c
         UM+g7yeSaD2ZYs91BTL0i9A/5HvWmMYKIpTKX0OYuULyESudziS93wQBmdt4urd4W7c0
         Z7qUgDV4HKszhULSHLc0U6mUdPnvxhwC0MSwDKqDxbIkG1CTfNMarIodo0HgOK1YsAji
         a4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdZF1tAGansRLUszaKL7L1yU4x1TqVC4B8AnL/+51jg=;
        b=i39eAVa/XxMF9fKAr6Gbxmk2zJmfdBQu+wbCBx+GhHtpSLd6yS+DRoAYZQPcgpHJgV
         FP0RuxGlpxnX4mMcF4mDiltuJkarOLXS8oMqEjFa6sU5RS6+wxqriQNd/aV5cmnOH8hS
         yNQfCms+bL4V2AfYifI/55dmxki60wTOx9AC6/3zrQoHJny0iFWDlTNj7AbniE1ZNZot
         gyW65T4SeFRqwwYqW6c+NuPj0CnhMjNor7lxupWl46xUOBRoEVvHjcGS2gp/A0FdAo3R
         MV6MWlJvfPgAVcf3Qi3wR7u85XoyNR4+t0PcAKXnZQ/oP0p27F37WOpogOfrlpg2YYhK
         NUtA==
X-Gm-Message-State: AFqh2krwCXPC5rIsVOKTUQ0sHMppz7VTPQUWUyF9Zp/4nfYGFX30ydSN
        YCGTaNMV+jcHnWSq0EDI+GISQ57Fazjl2w==
X-Google-Smtp-Source: AMrXdXslzfj900fda//LnFzbPZCQPDqn9VD2gmRV176PTfqxC/qZ/WjiXr+fC/sokbiGXvlm4YryNA==
X-Received: by 2002:a05:6402:100b:b0:462:6e5e:329a with SMTP id c11-20020a056402100b00b004626e5e329amr6885574edu.8.1674043714236;
        Wed, 18 Jan 2023 04:08:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/19] leak fixes: various simple leak fixes
Date:   Wed, 18 Jan 2023 13:08:13 +0100
Message-Id: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See
https://lore.kernel.org/git/cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com/
for the v4. Change since then:

* Don't mark t/t3203-branch-output.sh as passing, which was new in
  v4. As noted in
  https://lore.kernel.org/git/xmqq1qns8gz4.fsf_-_@gitster.g/ it still
  leaked.

  As I noted in
  https://lore.kernel.org/git/230118.86o7qwxg4e.gmgdl@evledraar.gmail.com/
  this was a gcc v.s. clang difference.

  I a fix for that "filter" leak as a follow-up, let's just fix it for
  real at some point, rather than using the UNLEAK(), sorry about the
  churn.

* The couple of things René pointed out on v4 I both took (and he
  seems to think so) as suggestions for eventual follow-ups.

  In general I agree that some of the fixes here have deeper
  root-cause fixes that are worth doing at some point, but in the
  meantime having some simple leak fixes (and CI regression testing
  for them) is an improvement.

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
 72 files changed, 156 insertions(+), 50 deletions(-)

Range-diff against v4:
 1:  2ed69e3cda3 =  1:  c47fc0fb637 tests: mark tests as passing with SANITIZE=leak
 2:  9993786ba0d =  2:  9eb758117dc bundle.c: don't leak the "args" in the "struct child_process"
 3:  8e98d7c4ebf =  3:  01b6229f18a commit-graph: use free_commit_graph() instead of UNLEAK()
 4:  966d7657d54 =  4:  f4f3aef2861 clone: use free() instead of UNLEAK()
 5:  93a8f8fa1b9 =  5:  8d10fbe0b8f various: add missing clear_pathspec(), fix leaks
 6:  bd15d991ac7 =  6:  eb5dc3ac192 name-rev: don't xstrdup() an already dup'd string
 7:  fd890121ebe =  7:  1fac90c306a repack: fix leaks on error with "goto cleanup"
 8:  1fe25bc6981 !  8:  02248aca3eb worktree: fix a trivial leak in prune_worktrees()
    @@ t/t2406-worktree-repair.sh
      . ./test-lib.sh
      
      test_expect_success setup '
    -
    - ## t/t3203-branch-output.sh ##
    -@@
    - #!/bin/sh
    - 
    - test_description='git branch display tests'
    -+
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - . "$TEST_DIRECTORY"/lib-terminal.sh
    - 
 9:  6b3dd9b15f0 =  9:  b39d6d29dd5 http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
10:  246f71bb447 = 10:  928dea2d4ee http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
11:  ab31d8d10da = 11:  5770b9eb764 commit-graph: fix a parse_options_concat() leak
12:  9054b353220 = 12:  3ff86cb808c show-branch: free() allocated "head" before return
13:  05836b08e0f = 13:  1f3e3524580 builtin/merge.c: use fixed strings, not "strbuf", fix leak
14:  e8ea18b08c2 = 14:  15e4b8db805 builtin/merge.c: free "&buf" on "Your local changes..." error
15:  66c24afb893 = 15:  d36ad1f818a object-file.c: release the "tag" in check_tag()
16:  52744d9690f = 16:  10959760dfc grep.c: refactor free_grep_patterns()
17:  8ff63d9095c = 17:  6a8f4a567aa grep API: plug memory leaks by freeing "header_list"
18:  0ad7d59b881 = 18:  3c3d48df04b receive-pack: free() the "ref_name" in "struct command"
19:  b3aee41d0b4 = 19:  f29500a4abc push: free_refs() the "local_refs" in set_refspecs()
-- 
2.39.0.1225.g30a3d88132d

