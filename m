Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0087C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiCINSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiCINSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA92105A9B
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k24so2984891wrd.7
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXXN8AT2/PPg7c3YsvYNwnm8OsDR7ePj4aToLe0COU0=;
        b=PH3xVk0sTnyzU8GMcCgcFBncRh0oIzIsDty5SznHvrpFNX0bnCbAeHogW0exzV9auh
         ylFAdDH85Pv/7d3BcmcJ6B2zjwBe+P3Qkw23GXWqoLeGPAXPtWmU4nRy4RIXFm9ZVQLa
         KF2sc3OTK9vkgb/DgMP836LHT/yuRkFhsq2312w5NFLx/2iLd4YTu9svqxbUtLQAAtzZ
         k4yA9zZsezpkfE0VwiOa1U+l0iRDsz+aI6TgUk9DXUqgbtzCl3QD14GfJhGtW1gsezwN
         4fKnCJcZ1l940ztUEDG2XasBmyINye7hfcc6nl3CtoBNA34mwNC7nm23XORTo95dNgPv
         lcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXXN8AT2/PPg7c3YsvYNwnm8OsDR7ePj4aToLe0COU0=;
        b=lSISAepnzCLuvqWgqyw29WiXMqvdVOKrjytDFkNHAI8zn97m+XZUFWLTz1aaTqvgK9
         O4tD7KGZSqivAB4oqGfsOkBDrXumuf1BhXRjWiBtYQpITup3AZiZMVk23nXF5dZatsU2
         LriTdtQ2ZVK/JD9ibOmpaC7/RLHRhRd1iqx3U9PKvdLt9632H9G8qECJm9VwclOONe+H
         y9+XkSdrqVzKhUl2d0vwdMOMtHkPivx61gvtoIhS7b2a/G/tUCGNCDK95s3BQxECpd3f
         sXLZ+Md1xO8EbMoKSWBRtbqGrmx2J+VVYkRzh6QXWTmKNDQinbs4Kq478Ea2/I98fQke
         KSNg==
X-Gm-Message-State: AOAM532YMHRnqsatwqsKZF2xDdF0UwD/uVM/P4/NRxpDAIeWjzvGda5i
        ExzOhzyrssyiP+8opsKJJXVAZN7QF84=
X-Google-Smtp-Source: ABdhPJxNY+MgKvq3xydRmza9czPWwYAt11nYrkq95q4zZqpbxdQyTkYJifyHgOZDLDus50vrbAdDpg==
X-Received: by 2002:a05:6000:11d0:b0:1f1:f6ea:f9a with SMTP id i16-20020a05600011d000b001f1f6ea0f9amr12057535wrx.40.1646831863599;
        Wed, 09 Mar 2022 05:17:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/24] revision.[ch]: add and use release_revisions()
Date:   Wed,  9 Mar 2022 14:16:30 +0100
Message-Id: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== For Junio ==

This has a trivially resolved conflict with Derrick Stolee's
aaf251cdc5c (revision: put object filter into struct rev_info,
2022-03-08) currently in "seen" in builtin/rev-list.c.

The resolution is to just keep the "goto cleanup" in place of "return
0" in the conflicting lines, but to otherwise keep Derrick's version.

It will pass with/without SANITIZE=leak when applied to both "master"
and "seen". I omitted one test change (described in a relevant commit
message) due to the latter not being true (no fault of "seen", just a
new leaking command being added to a test).

== Summary ==

Ever since we started running regular leak testing in CI with
956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in CI,
2021-09-23) a major roadblock for making headway in marking tests as
leak-free has been the leaks in the revision.[ch] API.

Since we use it for an revision walking, including "log", "rev-list"
etc. we haven't been able to run common test setup in many cases
without dying when compiled with SANITIZE=leak, and cases where we
genuinely leak memory are often obscured by several concurrent leaks
in the revisions API.

This series adds a release_revisions() and works towards fixing those
memory leaks one at a time. As the diffstat to t/* shows we can mark a
*lot* of tests leak-free as a result, and those are only the the tests
that 100% pass with this series.

An approximate count of the total number of memory leaks in the test
suite (approximate because some are "hidden" due to SANITIZE=leak
causing "git" to die) is, before this series (running with "--tee" and
"--verbose-log"):

    $ grep -a "SUMMARY: LeakSanitizer.*leaked in .*allocation" test-results/*.out|wc -l
    12032

After:

    $ grep -a "SUMMARY: LeakSanitizer.*leaked in .*allocation" test-results/*.out|wc -l
    6652

I.e. this recudes the number of times "git" dies due to having any of
N number of leaks by around half, and that's severely undercounting
the amount of individual memory leaks.

This is a rather large series, but it should be fairly easy to
review. I've leaned towards splitting commits up for ease of review,
such that when there's repetitive changes (e.g. additions of
release_revisions()) that they're split such that each commit has
hunks that make the same sort of change, whenever possible.

All of the changes to "t/*" are then just adding
"TEST_PASSES_SANITIZE_LEAK=true" lines as we go along.

This doesn't fix all of the leaks in the revision.[ch] API. In
particular there's harder edge cases where the ownership of a struct
member isn't very straightforward (sometimes revision.c will allocate
it, sometimes not). This does fix all of the common cases though, and
what's left is best suited for a follow-up series.

Ævar Arnfjörð Bjarmason (24):
  t/helper/test-fast-rebase.c: don't leak "struct strbuf"
  blame: use "goto cleanup" for cleanup_scoreboard()
  format-patch: don't leak "extra_headers" or "ref_message_ids"
  revision.[ch]: split freeing of revs->commit into a function
  revision.[ch]: provide and start using a release_revisions()
  revisions API users: add straightforward release_revisions()
  revisions API users: use release_revisions() needing "{ 0 }" init
  revisions API users: add "goto cleanup" for release_revisions()
  revisions API users: use release_revisions() in http-push.c
  revisions API users: use release_revisions() in builtin/log.c
  revisions API users: use release_revisions() with UNLEAK()
  revisions API users: use release_revisions() in submodule.c edge case
  revisions API users: use release_revisions() in wt-status.c edge case
  revisions API users: use release_revisions() for "prune_data" users
  revisions API: have release_revisions() release "commits"
  revisions API: have release_revisions() release "mailmap"
  revisions API: have release_revisions() release "cmdline"
  revisions API: have release_revisions() release "grep_filter"
  revisions API: have release_revisions() release "prune_data"
  revisions API: clear "boundary_commits" in release_revisions()
  revisions API: release "reflog_info" in release revisions()
  revisions API: call diff_free(&revs->pruning) in revisions_release()
  revisions API: have release_revisions() release "date_mode"
  revisions API: have release_revisions() release "topo_walk_info"

 add-interactive.c                             |  3 +-
 bisect.c                                      | 20 ++++--
 builtin/add.c                                 |  3 +-
 builtin/am.c                                  |  3 +
 builtin/bisect--helper.c                      |  2 +
 builtin/blame.c                               |  4 +-
 builtin/checkout.c                            |  3 +-
 builtin/commit.c                              |  7 +-
 builtin/describe.c                            |  2 +
 builtin/diff-files.c                          |  8 ++-
 builtin/diff-index.c                          |  5 +-
 builtin/diff.c                                |  2 +-
 builtin/fast-export.c                         |  1 +
 builtin/log.c                                 | 35 +++++++---
 builtin/merge.c                               |  2 +
 builtin/pack-objects.c                        |  2 +
 builtin/prune.c                               |  1 +
 builtin/reflog.c                              |  1 +
 builtin/rev-list.c                            | 19 +++--
 builtin/shortlog.c                            |  2 +
 builtin/stash.c                               | 20 +++---
 builtin/submodule--helper.c                   | 15 ++--
 bundle.c                                      | 12 ++--
 diff-lib.c                                    |  8 ++-
 fmt-merge-msg.c                               |  1 +
 http-push.c                                   |  3 +-
 merge-ort.c                                   |  1 +
 merge-recursive.c                             |  1 +
 midx.c                                        |  1 +
 pack-bitmap-write.c                           |  1 +
 range-diff.c                                  |  2 +-
 ref-filter.c                                  |  1 +
 reflog-walk.c                                 | 26 ++++++-
 reflog-walk.h                                 |  1 +
 remote.c                                      |  1 +
 revision.c                                    | 69 ++++++++++++++++---
 revision.h                                    |  6 ++
 sequencer.c                                   | 26 +++++--
 shallow.c                                     |  1 +
 submodule.c                                   |  5 +-
 t/helper/test-fast-rebase.c                   | 22 ++++--
 t/helper/test-revision-walking.c              |  1 +
 t/lib-git-svn.sh                              |  4 ++
 t/t0056-git-C.sh                              |  1 +
 t/t0062-revision-walking.sh                   |  1 +
 t/t0100-previous.sh                           |  1 +
 t/t0101-at-syntax.sh                          |  2 +
 t/t1060-object-corruption.sh                  |  2 +
 t/t1401-symbolic-ref.sh                       |  2 +
 t/t1411-reflog-show.sh                        |  1 +
 t/t1412-reflog-loop.sh                        |  2 +
 t/t1415-worktree-refs.sh                      |  1 +
 t/t2015-checkout-unborn.sh                    |  1 +
 t/t2016-checkout-patch.sh                     |  1 +
 t/t3408-rebase-multi-line.sh                  |  1 +
 t/t4021-format-patch-numbered.sh              |  1 +
 t/t4028-format-patch-mime-headers.sh          |  2 +
 t/t4036-format-patch-signer-mime.sh           |  1 +
 t/t4039-diff-assume-unchanged.sh              |  1 +
 t/t4055-diff-context.sh                       |  1 +
 t/t4066-diff-emit-delay.sh                    |  1 +
 t/t4122-apply-symlink-inside.sh               |  1 +
 t/t4126-apply-empty.sh                        |  1 -
 t/t4206-log-follow-harder-copies.sh           |  2 +
 t/t4207-log-decoration-colors.sh              |  1 +
 t/t4212-log-corrupt.sh                        |  1 +
 t/t5313-pack-bounds-checks.sh                 |  2 +
 t/t5322-pack-objects-sparse.sh                |  1 +
 t/t5506-remote-groups.sh                      |  1 +
 t/t5513-fetch-track.sh                        |  1 +
 t/t5515-fetch-merge-logic.sh                  |  1 +
 t/t5518-fetch-exit-status.sh                  |  1 +
 t/t5532-fetch-proxy.sh                        |  2 +
 t/t5900-repo-selection.sh                     |  2 +
 t/t6002-rev-list-bisect.sh                    |  1 +
 t/t6003-rev-list-topo-order.sh                |  1 +
 t/t6018-rev-list-glob.sh                      |  1 +
 t/t6019-rev-list-ancestry-path.sh             |  1 +
 t/t6100-rev-list-in-order.sh                  |  1 +
 t/t6101-rev-parse-parents.sh                  |  1 +
 t/t6110-rev-list-sparse.sh                    |  1 +
 t/t6114-keep-packs.sh                         |  2 +
 t/t6131-pathspec-icase.sh                     |  2 +
 t/t7008-filter-branch-null-sha1.sh            |  2 +
 t/t7702-repack-cyclic-alternate.sh            |  2 +
 t/t9001-send-email.sh                         |  1 +
 t/t9100-git-svn-basic.sh                      |  1 +
 t/t9101-git-svn-props.sh                      |  2 +
 t/t9104-git-svn-follow-parent.sh              |  2 +
 t/t9106-git-svn-commit-diff-clobber.sh        |  2 +
 t/t9122-git-svn-author.sh                     |  2 +
 t/t9129-git-svn-i18n-commitencoding.sh        |  1 +
 t/t9139-git-svn-non-utf8-commitencoding.sh    |  1 +
 t/t9148-git-svn-propset.sh                    |  1 +
 t/t9151-svn-mergeinfo.sh                      |  1 +
 t/t9157-git-svn-fetch-merge.sh                |  2 +
 t/t9159-git-svn-no-parent-mergeinfo.sh        |  2 +
 t/t9161-git-svn-mergeinfo-push.sh             |  1 +
 t/t9162-git-svn-dcommit-interactive.sh        |  2 +
 t/t9163-git-svn-reset-clears-caches.sh        |  1 +
 ...65-git-svn-fetch-merge-branch-of-branch.sh |  2 +
 ...6-git-svn-fetch-merge-branch-of-branch2.sh |  2 +
 wt-status.c                                   | 15 ++--
 103 files changed, 359 insertions(+), 90 deletions(-)

-- 
2.35.1.1295.g6b025d3e231

