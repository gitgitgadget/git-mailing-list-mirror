Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA40FC4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiL1SAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiL1SA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B92165B3
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d4so7536503wrw.6
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9vP1De+eu39eNRwRQHDG2WNgl7OVWSp8APLI/L4030=;
        b=LnvvWODC3DVDDbcgOjvgYxy2pKurganpJ72JdZnCMmfcLAP5MCtJ8xJ4n961zA+yyG
         0mNwYR93rHKRklU5fSn8esD0kc17UQhgz4IpQX+LkvyQI3tSRL4O/rVDg4KNmosDQM20
         GtVVC/TKpWQb6fx+h53brRq+ahJBh3EqTE1Ms3XWBBNdUTJsCIV0yw79PGrv/2HFTXmT
         wxwlOfdhoyMVvpGJr8ako3V3uHUvMzhRimI5mFHj8pbi32XkTqX2lfAL0nWm/gURg30K
         bqVXo38nMjUK/VM/YDAyyPysNoaYChhHGZYtJylmsAt31LH6Yy8ow4P6vG+btZmp8bl5
         s+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9vP1De+eu39eNRwRQHDG2WNgl7OVWSp8APLI/L4030=;
        b=bIZCVwD/Vy/TU7YxFfx1pOzU99CBG2mxG02ZnO0jA1Fv6EuWcZHZ9+4KZ3wyx9aN0+
         ZrSdjFbaU6sGgxLyVQ2i0vCUp55vd4ullYFgG3CzdlZMrvBXGPxY6+kXaCR9YC/Ox8CC
         GQ7HyooUkkNRoImyDgH4Z80k5cyC2H6VLqC88d4HfHJnDfGPmeFYtNl8p70k5UpC0Akx
         vfrFK8nxTkQv8wjVT1kwWpOJRcq8PC59eAJmi1eNAMJfpdtCGun294rwIUFLUQKF9PeY
         JbdG8U7q6B4X3kNavRkE2K7Iv4534E121xM7CHD+6StxVlFLxYJoJy3rWvFWFvrPNBqb
         XaFQ==
X-Gm-Message-State: AFqh2kpP2+D2dLWm1gqK2s62e2Cf4xCwp7c3oUwC9FGrQUr8x1A3A7/I
        hcCYVkc7BApXkja1Z0vsmMixdxTWwcR0lg==
X-Google-Smtp-Source: AMrXdXtmXZF5tTXrlTzRAtyJgVnk4gWyVRf80+Vsy5gPn6pODir77CBbVZIYdb/A6Adp+FM2iARklg==
X-Received: by 2002:a5d:438e:0:b0:24d:867f:10e6 with SMTP id i14-20020a5d438e000000b0024d867f10e6mr18071264wrq.32.1672250425788;
        Wed, 28 Dec 2022 10:00:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/20] leak fixes: various simple leak fixes
Date:   Wed, 28 Dec 2022 19:00:00 +0100
Message-Id: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the ab/various-leak-fixes topic merged in
9ea1378d046 (Merge branch 'ab/various-leak-fixes', 2022-12-14). Like
that topic this is mixed collection of various leak fixes, all of
which should be simple to review & reason about.

With this series we'll all 32 more tests to the linux-leaks CI job, as
they're now leak-free, out of those 11 are made leak-free in this
topic, the others are already leak-free, but aren't being tested in
CI.

Ævar Arnfjörð Bjarmason (20):
  t6021: mark as passing with SANITIZE=leak
  tests: mark tests as passing with SANITIZE=leak
  bundle.c: don't leak the "args" in the "struct child_process"
  commit-graph: use free() instead of UNLEAK()
  clone: use free() instead of UNLEAK()
  archive.c: call clear_pathspec() in write_archive()
  stash: fix a "struct pathspec" leak
  reset: fix cmd_reset() leaks with a clear_pathspec() call
  name-rev: don't xstrdup() an already dup'd string
  repack: fix leaks on error with "goto cleanup"
  worktree: fix a trivial leak in prune_worktrees()
  http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
  commit-graph: fix a parse_options_concat() leak
  show-branch: free() allocated "head" before return
  builtin/merge.c: always free "struct strbuf msg"
  builtin/merge.c: free "&buf" on "Your local changes..." error
  connected.c: free(new_pack) in check_connected()
  object-file.c: free the "t.tag" in check_tag()
  grep.c: make it easier to extend free_grep_patterns()
  grep API: plug memory leaks by freeing "header_list"

 archive.c                                  |  1 +
 builtin/clone.c                            |  5 +++--
 builtin/commit-graph.c                     | 10 ++++++----
 builtin/merge.c                            |  5 ++++-
 builtin/name-rev.c                         |  3 ++-
 builtin/repack.c                           | 13 +++++++------
 builtin/reset.c                            | 11 ++++++++---
 builtin/show-branch.c                      |  1 +
 builtin/stash.c                            |  9 ++++++---
 builtin/worktree.c                         |  6 +++---
 bundle.c                                   |  6 ++++--
 connected.c                                | 13 +++++++------
 grep.c                                     | 15 ++++++++++-----
 http-backend.c                             |  7 +++++--
 object-file.c                              |  1 +
 t/t0023-crlf-am.sh                         |  1 +
 t/t1301-shared-repo.sh                     |  1 +
 t/t1302-repo-version.sh                    |  1 +
 t/t1304-default-acl.sh                     |  1 +
 t/t1408-packed-refs.sh                     |  1 +
 t/t1410-reflog.sh                          |  1 +
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
 t/t5502-quickfetch.sh                      |  1 +
 t/t5604-clone-reference.sh                 |  1 +
 t/t5613-info-alternate.sh                  |  2 ++
 t/t6011-rev-list-with-bad-commit.sh        |  1 +
 t/t6014-rev-list-all.sh                    |  1 +
 t/t6021-rev-list-exclude-hidden.sh         |  1 +
 t/t6439-merge-co-error-msgs.sh             |  1 +
 t/t7105-reset-patch.sh                     |  2 ++
 t/t7106-reset-unborn-branch.sh             |  2 ++
 t/t7107-reset-pathspec-file.sh             |  1 +
 t/t7403-submodule-sync.sh                  |  1 +
 t/t7701-repack-unpack-unreachable.sh       |  1 +
 47 files changed, 108 insertions(+), 38 deletions(-)

-- 
2.39.0.1153.gb0033028ca9

