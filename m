Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4231C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiDMUE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiDMUEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421E87B10E
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1844992wmz.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alVp9PHCtGKF6t4vEcTcRZqgEuCLXzmEQpPawxgD0Us=;
        b=FZQpW9ySKf6HCg6WiglP3vdmeM/26F2nNehWBQkdXY0/3WQMeq0VkYkKkrmawvPG/i
         ngqVk5BVhpdGlrsPdBk97BEyzMs5GVCQEHMW9pSZt9m7euMw+ulfWe2DoM6oetWmi5JJ
         7OqMPLz/qWw/2MweAm5W8ylvhQjOTk5NjdJuJ6L1s2qO07DrAbJ9IUGxlutETNjw6oEM
         BmvPhAX8viB4gEtl1VhuBZGaGJyaeqOf2WYnjii3A96WvbYP24WzxS70LZGEL6C7FYqi
         pdFW9+C7MsDvzYDOvgPuGP+3JI2QDDzDzzp2fYXYIm3jJZyTioKKFLvG+OM+o6oPAF8i
         7zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alVp9PHCtGKF6t4vEcTcRZqgEuCLXzmEQpPawxgD0Us=;
        b=A/2RKt3Mnr6gNtfYmxn1kvTlrmGft18b0QW51xm8AMCqR2VFd4lBa1Zb6bK+94YG8N
         pkN+Z3IDvt8EkYuuct2RKQi2b9el5L6zI4E9F+WnO5Yrqryz0TM21w3R/hi4lxEFnj5w
         lZ4eL14Pd0X5XFQGNzJQYImZ38ofgHezceqttfR4XHBeR2vICl89Nb65+bDoJms8XcQ5
         KAZkW3lzAUUs4GScztxgomLGrw0kU9Cz7am+k6LNRpL6b++0GJf4S2W8iKBRK8wIsSeY
         Mkwpd7ZPrv2KC52Y+AGxCJv5mNAbR1HJ8emcWmzD1ZFT7LgzYuJmmsWFobNMgmKh0GpZ
         yIoA==
X-Gm-Message-State: AOAM530l/03jMdthaoNWHqLULDA9CAp75aJ6UP+dAX6svB5Njx8R+X8d
        wRJ8HjmjgtHiK4ut/n9uCc0fxWoRjkH8AQ==
X-Google-Smtp-Source: ABdhPJwww7WuUYL/SLcgCjvSfayVob19QPjsoiL1I/q9YA1fktSvDjlT0KBkbslwhSkBaXUpK6zteg==
X-Received: by 2002:a05:600c:3b26:b0:38c:8358:4b84 with SMTP id m38-20020a05600c3b2600b0038c83584b84mr282192wms.185.1649880120524;
        Wed, 13 Apr 2022 13:02:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:01:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 00/27] revision.[ch]: add and use release_revisions()
Date:   Wed, 13 Apr 2022 22:01:29 +0200
Message-Id: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series reduces the memory leaks spotted by our tests by at least
half, see v3[1] for a more general overview.

The only change in this v6 is a trivial adjustment of the freeing for
the "cmdline" to get rid of a boilerplate was-always-unnecessary NULL
check for the "cmdline", which could never be NULL in that
case. Thanks to Phillip Wood for spotting it.

1. https://lore.kernel.org/git/cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (27):
  t/helper/test-fast-rebase.c: don't leak "struct strbuf"
  blame: use "goto cleanup" for cleanup_scoreboard()
  string_list API users: use string_list_init_{no,}dup
  format-patch: don't leak "extra_headers" or "ref_message_ids"
  cocci: add and apply free_commit_list() rules
  revision.[ch]: provide and start using a release_revisions()
  revisions API users: add straightforward release_revisions()
  revision.[ch]: document and move code declared around "init"
  revisions API users: use release_revisions() needing REV_INFO_INIT
  stash: always have the owner of "stash_info" free it
  revisions API users: add "goto cleanup" for release_revisions()
  revisions API users: use release_revisions() in http-push.c
  revisions API users: use release_revisions() in builtin/log.c
  revisions API users: use release_revisions() with UNLEAK()
  revisions API users: use release_revisions() for "prune_data" users
  revisions API: have release_revisions() release "commits"
  revisions API: have release_revisions() release "mailmap"
  revisions API: have release_revisions() release "cmdline"
  revisions API: have release_revisions() release "filter"
  revisions API: have release_revisions() release "grep_filter"
  revisions API: have release_revisions() release "prune_data"
  revisions API: clear "boundary_commits" in release_revisions()
  revisions API: release "reflog_info" in release revisions()
  revisions API: call diff_free(&revs->pruning) in revisions_release()
  revisions API: have release_revisions() release "date_mode"
  revisions API: have release_revisions() release "topo_walk_info"
  revisions API: add a TODO for diff_free(&revs->diffopt)

 add-interactive.c                          |   3 +-
 bisect.c                                   |  20 ++--
 builtin/add.c                              |   3 +-
 builtin/am.c                               |   3 +
 builtin/bisect--helper.c                   |   2 +
 builtin/blame.c                            |   4 +-
 builtin/checkout.c                         |   3 +-
 builtin/commit.c                           |   6 +-
 builtin/describe.c                         |   2 +
 builtin/diff-files.c                       |   8 +-
 builtin/diff-index.c                       |   5 +-
 builtin/diff.c                             |   2 +-
 builtin/fast-export.c                      |   1 +
 builtin/log.c                              |  36 ++++---
 builtin/merge.c                            |   2 +
 builtin/pack-objects.c                     |   2 +
 builtin/prune.c                            |   1 +
 builtin/reflog.c                           |   1 +
 builtin/rev-list.c                         |  25 +++--
 builtin/shortlog.c                         |   8 +-
 builtin/stash.c                            | 115 +++++++++++----------
 builtin/submodule--helper.c                |  14 ++-
 bundle.c                                   |  12 ++-
 commit.c                                   |  19 ++--
 contrib/coccinelle/free.cocci              |  27 +++++
 diff-lib.c                                 |   8 +-
 fmt-merge-msg.c                            |   1 +
 http-push.c                                |   3 +-
 merge-ort.c                                |   1 +
 merge-recursive.c                          |   5 +-
 midx.c                                     |   1 +
 pack-bitmap-write.c                        |   1 +
 range-diff.c                               |   2 +-
 ref-filter.c                               |   1 +
 reflog-walk.c                              |  24 ++++-
 reflog-walk.h                              |   1 +
 remote.c                                   |   1 +
 revision.c                                 |  70 ++++++++++---
 revision.h                                 |  73 ++++++++-----
 sequencer.c                                |  26 +++--
 shallow.c                                  |   1 +
 submodule.c                                |  11 +-
 t/helper/test-fast-rebase.c                |  23 +++--
 t/helper/test-revision-walking.c           |   1 +
 t/lib-git-svn.sh                           |   4 +
 t/t0056-git-C.sh                           |   1 +
 t/t0062-revision-walking.sh                |   1 +
 t/t0100-previous.sh                        |   1 +
 t/t0101-at-syntax.sh                       |   2 +
 t/t1001-read-tree-m-2way.sh                |   1 +
 t/t1002-read-tree-m-u-2way.sh              |   1 +
 t/t1060-object-corruption.sh               |   2 +
 t/t1401-symbolic-ref.sh                    |   2 +
 t/t1411-reflog-show.sh                     |   1 +
 t/t1412-reflog-loop.sh                     |   2 +
 t/t1415-worktree-refs.sh                   |   1 +
 t/t2015-checkout-unborn.sh                 |   1 +
 t/t2200-add-update.sh                      |   1 +
 t/t3302-notes-index-expensive.sh           |   1 +
 t/t3303-notes-subtrees.sh                  |   1 +
 t/t3305-notes-fanout.sh                    |   1 +
 t/t3408-rebase-multi-line.sh               |   1 +
 t/t4021-format-patch-numbered.sh           |   1 +
 t/t4027-diff-submodule.sh                  |   1 +
 t/t4028-format-patch-mime-headers.sh       |   2 +
 t/t4036-format-patch-signer-mime.sh        |   1 +
 t/t4039-diff-assume-unchanged.sh           |   1 +
 t/t4055-diff-context.sh                    |   1 +
 t/t4066-diff-emit-delay.sh                 |   1 +
 t/t4122-apply-symlink-inside.sh            |   1 +
 t/t4126-apply-empty.sh                     |   1 -
 t/t4128-apply-root.sh                      |   1 +
 t/t4206-log-follow-harder-copies.sh        |   2 +
 t/t4207-log-decoration-colors.sh           |   1 +
 t/t4212-log-corrupt.sh                     |   1 +
 t/t5301-sliding-window.sh                  |   2 +
 t/t5313-pack-bounds-checks.sh              |   2 +
 t/t5316-pack-delta-depth.sh                |   2 +
 t/t5320-delta-islands.sh                   |   2 +
 t/t5322-pack-objects-sparse.sh             |   1 +
 t/t5506-remote-groups.sh                   |   1 +
 t/t5513-fetch-track.sh                     |   1 +
 t/t5515-fetch-merge-logic.sh               |   1 +
 t/t5518-fetch-exit-status.sh               |   1 +
 t/t5532-fetch-proxy.sh                     |   2 +
 t/t5600-clone-fail-cleanup.sh              |   1 +
 t/t5900-repo-selection.sh                  |   2 +
 t/t6002-rev-list-bisect.sh                 |   1 +
 t/t6003-rev-list-topo-order.sh             |   1 +
 t/t6005-rev-list-count.sh                  |   1 +
 t/t6018-rev-list-glob.sh                   |   1 +
 t/t6100-rev-list-in-order.sh               |   1 +
 t/t6101-rev-parse-parents.sh               |   1 +
 t/t6110-rev-list-sparse.sh                 |   1 +
 t/t6114-keep-packs.sh                      |   2 +
 t/t6131-pathspec-icase.sh                  |   2 +
 t/t7008-filter-branch-null-sha1.sh         |   1 +
 t/t7702-repack-cyclic-alternate.sh         |   2 +
 t/t9001-send-email.sh                      |   1 +
 t/t9100-git-svn-basic.sh                   |   1 +
 t/t9101-git-svn-props.sh                   |   2 +
 t/t9104-git-svn-follow-parent.sh           |   2 +
 t/t9106-git-svn-commit-diff-clobber.sh     |   2 +
 t/t9115-git-svn-dcommit-funky-renames.sh   |   1 +
 t/t9116-git-svn-log.sh                     |   1 +
 t/t9122-git-svn-author.sh                  |   2 +
 t/t9127-git-svn-partial-rebuild.sh         |   1 +
 t/t9129-git-svn-i18n-commitencoding.sh     |   1 +
 t/t9132-git-svn-broken-symlink.sh          |   1 +
 t/t9139-git-svn-non-utf8-commitencoding.sh |   1 +
 t/t9146-git-svn-empty-dirs.sh              |   2 +
 t/t9148-git-svn-propset.sh                 |   1 +
 t/t9160-git-svn-preserve-empty-dirs.sh     |   1 +
 t/t9162-git-svn-dcommit-interactive.sh     |   2 +
 t/t9164-git-svn-dcommit-concurrent.sh      |   2 +
 t/t9501-gitweb-standalone-http-status.sh   |   1 +
 wt-status.c                                |  15 +--
 117 files changed, 500 insertions(+), 190 deletions(-)

Range-diff against v5:
 1:  f6b7b27109c <  -:  ----------- list-objects-filter: remove CL_ARG__FILTER
 2:  692f9578614 <  -:  ----------- pack-objects: move revs out of get_object_list()
 3:  56ee616b898 <  -:  ----------- pack-objects: parse --filter directly into revs.filter
 4:  00f69fb967f <  -:  ----------- bundle: move capabilities to end of 'verify'
 5:  e33162a7a4f <  -:  ----------- bundle: output hash information in 'verify'
 6:  ba6177f59bb <  -:  ----------- pack-objects: lazily set up "struct rev_info", don't leak
 7:  e20f951a64c =  1:  1e904ad33b4 t/helper/test-fast-rebase.c: don't leak "struct strbuf"
 8:  de2e08a14e6 =  2:  c2dcdfab458 blame: use "goto cleanup" for cleanup_scoreboard()
 9:  364aa7d8990 =  3:  21fe41e4ad8 string_list API users: use string_list_init_{no,}dup
10:  5d4ad92d47b =  4:  f7fb26752b9 format-patch: don't leak "extra_headers" or "ref_message_ids"
11:  c38db28f920 =  5:  9eada36dacf cocci: add and apply free_commit_list() rules
12:  b99f96599bb =  6:  22de5dc3cc1 revision.[ch]: provide and start using a release_revisions()
13:  521f6967b64 =  7:  31c8eccf68e revisions API users: add straightforward release_revisions()
14:  003b507e0b7 =  8:  4a0e57acf17 revision.[ch]: document and move code declared around "init"
15:  240307bc3c6 =  9:  2bfa8640b6b revisions API users: use release_revisions() needing REV_INFO_INIT
16:  4c5404912e9 = 10:  f0c3d274fb5 stash: always have the owner of "stash_info" free it
17:  4210232e3a1 = 11:  e93791b6242 revisions API users: add "goto cleanup" for release_revisions()
18:  1918ca0a85d = 12:  2c744ccdbb1 revisions API users: use release_revisions() in http-push.c
19:  6a02b7aae4e = 13:  fdb3a63e0a9 revisions API users: use release_revisions() in builtin/log.c
20:  ddc7402b054 = 14:  31ce58da43d revisions API users: use release_revisions() with UNLEAK()
21:  03e9bd73d4b = 15:  71d59de2fe1 revisions API users: use release_revisions() for "prune_data" users
22:  285673e40bf = 16:  dcf63f64135 revisions API: have release_revisions() release "commits"
23:  ca659940ee5 = 17:  3e226c5b3d4 revisions API: have release_revisions() release "mailmap"
24:  7987c748ba4 ! 18:  ccae0f32ad5 revisions API: have release_revisions() release "cmdline"
    @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
     +{
     +	unsigned int i;
     +
    -+	if (!cmdline)
    -+		return;
     +	for (i = 0; i < cmdline->nr; i++)
     +		free((char *)cmdline->rev[i].name);
     +	free(cmdline->rev);
25:  e6e87ce3608 = 19:  2fc60559f1c revisions API: have release_revisions() release "filter"
26:  ebdcdc88d79 = 20:  e7e0e46bbb2 revisions API: have release_revisions() release "grep_filter"
27:  84c8714571a = 21:  54514a01096 revisions API: have release_revisions() release "prune_data"
28:  d96642d3502 = 22:  69745303734 revisions API: clear "boundary_commits" in release_revisions()
29:  0e9745d9ee1 = 23:  87ba9572b10 revisions API: release "reflog_info" in release revisions()
30:  c7f3e92a8d1 = 24:  79279864c42 revisions API: call diff_free(&revs->pruning) in revisions_release()
31:  d428d752462 = 25:  4aadeabaae7 revisions API: have release_revisions() release "date_mode"
32:  fbf233ec768 = 26:  f0cedadbb94 revisions API: have release_revisions() release "topo_walk_info"
33:  ec2c77ce869 = 27:  3be672a8150 revisions API: add a TODO for diff_free(&revs->diffopt)
-- 
2.36.0.rc2.843.g193535c2aa7

