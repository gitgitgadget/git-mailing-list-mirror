Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C25C54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjAJFoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjAJFny (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:43:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5579641027
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:43:52 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vm8so25800245ejc.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymo1KbUjIX0G0PqU7miQNpU6f7crkKlp/YySYIUTvRs=;
        b=RFfRT4O5UYnDwyZtnnYOrQDiqSuTtjj1ZK+wCqkDRdphtDR62fGbU1nyGNiltUxDMV
         L0YBdN9QN3x+zCz8Ld3F2jz9TcBEcthbWcjF+XxA45X3lzJndxYgdjo1Oa7OOS+CX1h8
         Ftjg5rn9jRdJye4Zr3D4tFm/7dGKxYNvXL4hQO3G1mZ1QZoB1aju1P7fTUN+VfBBityD
         qtuJTq1UwmgKTtTwn5g1GO7/v8PJXMwY2mrVhC94wXHq7GQPfDcakO/roTSPS0Y2djrb
         BDHiOga9NAsMyisg78tn5LkB9CTxTKhlBQGXp+N9dD/tdWCRYMM4s+w1wwtCKJJub4io
         fw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymo1KbUjIX0G0PqU7miQNpU6f7crkKlp/YySYIUTvRs=;
        b=xIG473OpjCgFCqny+osHIINZuFbGwDmNj0Jd1se1DDznomxQ20sRWjEmLHnLbfRNiZ
         gkXU2jL+0wg4geF8RZC3sHcJUCFB5ig+EaWfe7fZ/Qkj+a4ivQDe2l4e6Gm+S+Q+ZrNt
         Fnpgg5IK1pYVCBrj0zEy87OwKiEAo7nlnw3YYlaGhyyy/yCJlvkN3WHbMQ8qVKU0IrOc
         6D7jd8F/nhREefVAU5IGKN8npOhjg1K3rhi/5oHX8yE25E/ye39dr+bgKzhIZfMEMrb6
         AYk+T1xuVHFGr3CXF/pwpZMXVC9GXMLhSj93cxYbSrksHceAL4lO8eNxPTjxEnn9C6iR
         2rYA==
X-Gm-Message-State: AFqh2krqdMbM8qkMnhFmcsWA9akZ/MVaqkK0NFWPOmgowEBwyOm1rTci
        Zq15rUhKake0aeNtxzQ+cszb2Ga4f6E=
X-Google-Smtp-Source: AMrXdXtpuoS3ypyEdAuHZUm16cRhSCT2WIKZkQtOZLfDca/d/YlHlF5Ypq6XUBV1nijpa5/PFBtAdA==
X-Received: by 2002:a17:907:2587:b0:7c0:e7ad:fb0f with SMTP id ad7-20020a170907258700b007c0e7adfb0fmr47570791ejc.20.1673329430396;
        Mon, 09 Jan 2023 21:43:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/19] leak fixes: various simple leak fixes
Date:   Tue, 10 Jan 2023 06:43:20 +0100
Message-Id: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A hopefully final version of this collection of simple leak fixes. See
https://lore.kernel.org/git/cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com/
for v2.

Changes since v2:

 * Updated reference to function name in a commit subject, spotted by
   René.

 * Dropped a patch that didn't fix a leak, but just did a post-cleanup
   of an already fixed leak.

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
  builtin/merge.c: always free "struct strbuf msg"
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
 68 files changed, 151 insertions(+), 50 deletions(-)

Range-diff against v2:
 1:  3de29c6d75f =  1:  f5b67f44e2d tests: mark tests as passing with SANITIZE=leak
 2:  5036712391d =  2:  88c6b66be3c bundle.c: don't leak the "args" in the "struct child_process"
 3:  a840a1cb330 !  3:  8cc8060cd92 commit-graph: use free() instead of UNLEAK()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    commit-graph: use free() instead of UNLEAK()
    +    commit-graph: use free_commit_graph() instead of UNLEAK()
     
         In 0bfb48e6723 (builtin/commit-graph.c: UNLEAK variables, 2018-10-03)
         this was made to UNLEAK(), but we can just as easily invoke the
 4:  c05620cef49 =  4:  765d5cbcf81 clone: use free() instead of UNLEAK()
 5:  62af6557760 =  5:  5087fb73286 various: add missing clear_pathspec(), fix leaks
 6:  7cea3da9fae =  6:  39cb8aefb58 name-rev: don't xstrdup() an already dup'd string
 7:  b5978d75c6a =  7:  a3f1e800127 repack: fix leaks on error with "goto cleanup"
 8:  468615570f4 =  8:  f918a6f2adc worktree: fix a trivial leak in prune_worktrees()
 9:  8c5c964d872 =  9:  56204806dfd http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
10:  fd34c4817f4 = 10:  5355e0fc60b http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
11:  f7005f32cc0 = 11:  dfb52dbd1c4 commit-graph: fix a parse_options_concat() leak
12:  bf0e9bc5fa6 = 12:  e44e74dcc58 show-branch: free() allocated "head" before return
13:  b157092e8d0 = 13:  6d99fdcc44e builtin/merge.c: always free "struct strbuf msg"
14:  bdd2bc9a956 = 14:  a3bf3045597 builtin/merge.c: free "&buf" on "Your local changes..." error
15:  d5210017cab <  -:  ----------- connected.c: free(new_pack) in check_connected()
16:  2016b4ddd0b = 15:  7c70bbdebc8 object-file.c: release the "tag" in check_tag()
17:  fa2e8a7d297 = 16:  17537e1393e grep.c: refactor free_grep_patterns()
18:  3fcf7054708 = 17:  e4bd46a343e grep API: plug memory leaks by freeing "header_list"
19:  fa5d657312f = 18:  3e4b12cb623 receive-pack: free() the "ref_name" in "struct command"
20:  e5af27134df = 19:  d51ed239a8a push: free_refs() the "local_refs" in set_refspecs()
-- 
2.39.0.1195.gabc92c078c4

