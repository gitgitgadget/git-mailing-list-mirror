Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F056BC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiKCRHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiKCRG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:06:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3A1B9C3
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt23so7008546ejc.7
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCsrycrXcdWaYw7wAsZf7hDyN5NQpiGIcDypupOue8Q=;
        b=YxQ6mmouX2aRzcur6XmUY6oTZs/lVYYWe5SLGtkPuE9gvA+PX40mMMVR4/Lk6y2c8B
         USl8n7Nr+W22hzWL99c03f2wspkNi6KJ1vqTnrBkD+N3iWhIgnYpUHMSsGec01qRoUjw
         4i4ApYkClQ6ZNiEOAJVut0tEYrCv+LaxrJpWXYIvmAxbry9KuoE7iD58mW4rUrVK+vSa
         YVYVGYPvK1oTTFWz2eqkhh+5VxOal5W4g09q59wStXe4Qs5nrib9twMEniYug2gP6xEf
         ennRBfAFyxDSvjY0NV4d9mKE1GlPNTy5aMs9yt3qEjbMzhgzDL820qqoVBgcyhkSeZId
         EQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCsrycrXcdWaYw7wAsZf7hDyN5NQpiGIcDypupOue8Q=;
        b=wUOwqqtYlshP+tajAfzhGucV/vnGKI8j0NQvUTlUf/TR4hu6EQhAeoGhmKgTkDUGZP
         LX/LtRoM7+FfJO1fO0SajrUbbqLU2Yl0I83bMG784ZCJLU1B8d64TD4kBfew7ZfDOydd
         WWojCe8c1j2gO73I08xMoUwA5KndMaBfiyPey9kU8fMel5fMb+1OI7Il9R9XtRzw9Ygw
         WlrCXYb0GVdvvtztB0MlawBkQkbfkVz1q5UdFtBeeuPXqQ56yRukPnboDlyNfoRUeUqR
         /v6Lucv+w5s6qRxz2rMjwDeJyjVyF2xCwsrF5bDmZgAfRrBiC3Rm9VT02UMg0z0cwH6S
         PQzA==
X-Gm-Message-State: ACrzQf1zE1MdQ6i/uHWw0JjKP/8BmCu+LOsh2i3xZSEp4bfU9B/23DMt
        mcizPOswyJVsjVOi05vreP8moSWznMWVow==
X-Google-Smtp-Source: AMsMyM7C9x+L6+ws54nMp+F/ZOvwIU6VMfWPCerg7RtQQHTcGRyNYeueWXFQZ0AzPsef9Tic70tkCQ==
X-Received: by 2002:a17:907:3f19:b0:7a3:2317:4221 with SMTP id hq25-20020a1709073f1900b007a323174221mr29750052ejc.562.1667495179871;
        Thu, 03 Nov 2022 10:06:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:19 -0700 (PDT)
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
Subject: [PATCH 00/17] leak fixes: use existing constructors & other trivia
Date:   Thu,  3 Nov 2022 18:05:59 +0100
Message-Id: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the very minor exceptions of:

* 03-04/17 (which need trivial oilerplate)
* 05/17 (need to add trivial control flow to a free_*() function)
* 12/17 (narrowing scope of allocation)
* 17/17: Add "goto ret" pattern, combine two "ret" variables

These are all "one-line" leak fixes where we merely need to make use
of an existing release function. The "one-line" only having the slight
disclaimer of needing to e.g. add braces to an "if" in one case, etc.

Each commit in this series is tested with:

	GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true \
	make SANITIZE=leak test

I.e. mark tests as leak-free as we fix the leaks.

In 17/17 I replace uses of UNLEAK() where we can just as easily free()
instead, i.e. most of it's built-ins doing UNLEAK(x) instead of
strbuf_release(&x) etc.

As 17/17 notes I still think these's a place for unleak (some of the
remaining ones are quite tricky), but that we gain more from leaving
it for those tricky cases. Before this series we have 28 uses of
UNLEAK(), after it's 15.

Ævar Arnfjörð Bjarmason (17):
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
  sequencer.c: fix a pick_commits() leak
  rebase: don't leak on "--abort"
  sequencer.c: fix sequencer_continue() leak
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
 sequencer.c                              | 12 +++++--
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
 77 files changed, 150 insertions(+), 51 deletions(-)

-- 
2.38.0.1451.g86b35f4140a

