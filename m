Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37506C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352239AbiCaBN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348295AbiCaBNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:13:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE9566220
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u16so31564539wru.4
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4erPuQT6ajCMb/PXUM+nEZCbREDkNVHMawmcLDX5gSA=;
        b=UkFgkhXzgLsuzdlPiakQ+OnW52GySDCtaVc0p6tL6sO3N9LblDeH6WAE6u9XpaqMgt
         G2ojnhquC5w2wFyTBIfOg/0+1UzwbSfESW0PFUWM68SiTUS1WXvi1DmzJC/PjwVtUxNC
         GU6W33xOOw3PrWKgQot1+K+CxstCEHsxiytjTRxnSmtK7Pxay0MkgrvLrvUmnfxP8Ky8
         aIfgzkrbhVuAcXdoqu3eiZa3HmdNVXMGf4/hHLJa61Jv53B51OjmkTy4oGoJgDsfAVyZ
         EYUVyC3p4sS1Ra+b5J0hfPNr/7wG4JIPI8ZX0/bTHwYJR6Zdp15p5xVVjTlXZoync3y6
         VmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4erPuQT6ajCMb/PXUM+nEZCbREDkNVHMawmcLDX5gSA=;
        b=rs4XH2nt3xpDMz9R28FIoNTRk1o7hNvRwfDFANNjoJA5dyBmSiBVd9kOmKWq9fo2iS
         HoUofpKgTwrmW/a3bJke94lXBO20F73cv4Jq8okwxgfsYBYgVZm9rEQAGhSVEUTNxvJ0
         43aS5DsTT5Jl1sR9io6pi/qnYopg1puGjFY5OCv4+36I7Uw9IOjlUlCtIR4DKfktR+f+
         bkfI3uDu/X1hD727fcP9dn0DLvi0xOjTgxAveLCp3yoEB4qInp2Gx7m6sA4uQVxJzi79
         q+yhf2kKnGKWy6yJGj/tOh3ZU8vBpCKDB3cWOdWeqhZis4L3NHpAasR2isTbsKYbzTyJ
         51hQ==
X-Gm-Message-State: AOAM5300XH1RiNaxbBYcWikw77z4fbGtcxVTmHA7F6TgwKIKk+oNIvJ5
        jjEVGqlhLxgo0tqC3XiZC8FcDHpnE+wGTg==
X-Google-Smtp-Source: ABdhPJzyxvOY6Z/BpOEba4Tnk3m1VY4F5FxNGQwqQWpeCGfqzLZpClkx7Zbt21/IF3UQHS15XS9tXw==
X-Received: by 2002:a05:6000:144e:b0:205:9a62:1489 with SMTP id v14-20020a056000144e00b002059a621489mr1936970wrx.439.1648689125561;
        Wed, 30 Mar 2022 18:12:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/27] revision.[ch]: add and use release_revisions()
Date:   Thu, 31 Mar 2022 03:11:05 +0200
Message-Id: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series reduces the memory leaks spotted by our tests by at least
half, see v3[1] for a more general overview.

Changes since v3:

 * Now based on top of ds/partial-bundle-more, since it's in "next"
   and there's a direct (but relatively minor) semantic conflict with
   it.

 * A new 8/27 moves some code in revisions.[ch] around, to make it
  more straightforward to add a REV_INFO_INIT in 9/27.

 * 9/27 and related is now the old { 0 }-using commit from v2, except
   that { 0 } is now REV_INFO_INIT. The goto patten to avoid assuming
   that we can call release_revisions() on a "struct rev_info" without
   having gone through repo_init_revisions() is gone.

 * A minor change in diff context from rebasing on "master".

1. https://lore.kernel.org/git/cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (27):
  t/helper/test-fast-rebase.c: don't leak "struct strbuf"
  blame: use "goto cleanup" for cleanup_scoreboard()
  string_list API users: use string_list_init_{no,}dup
  format-patch: don't leak "extra_headers" or "ref_message_ids"
  revision.[ch]: split freeing of revs->commit into a function
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

 add-interactive.c                          |  3 +-
 bisect.c                                   | 20 ++++--
 builtin/add.c                              |  3 +-
 builtin/am.c                               |  3 +
 builtin/bisect--helper.c                   |  2 +
 builtin/blame.c                            |  4 +-
 builtin/checkout.c                         |  3 +-
 builtin/commit.c                           |  6 +-
 builtin/describe.c                         |  2 +
 builtin/diff-files.c                       |  8 ++-
 builtin/diff-index.c                       |  5 +-
 builtin/diff.c                             |  2 +-
 builtin/fast-export.c                      |  1 +
 builtin/log.c                              | 36 ++++++----
 builtin/merge.c                            |  2 +
 builtin/pack-objects.c                     |  2 +
 builtin/prune.c                            |  1 +
 builtin/reflog.c                           |  1 +
 builtin/rev-list.c                         | 19 ++++--
 builtin/shortlog.c                         |  8 ++-
 builtin/stash.c                            | 77 +++++++++++-----------
 builtin/submodule--helper.c                | 14 ++--
 bundle.c                                   | 12 ++--
 diff-lib.c                                 |  8 ++-
 fmt-merge-msg.c                            |  1 +
 http-push.c                                |  3 +-
 merge-ort.c                                |  1 +
 merge-recursive.c                          |  5 +-
 midx.c                                     |  1 +
 pack-bitmap-write.c                        |  1 +
 range-diff.c                               |  2 +-
 ref-filter.c                               |  1 +
 reflog-walk.c                              | 24 ++++++-
 reflog-walk.h                              |  1 +
 remote.c                                   |  1 +
 revision.c                                 | 68 ++++++++++++++++---
 revision.h                                 | 65 +++++++++++-------
 sequencer.c                                | 26 ++++++--
 shallow.c                                  |  1 +
 submodule.c                                |  5 +-
 t/helper/test-fast-rebase.c                | 23 +++++--
 t/helper/test-revision-walking.c           |  1 +
 t/lib-git-svn.sh                           |  4 ++
 t/t0056-git-C.sh                           |  1 +
 t/t0062-revision-walking.sh                |  1 +
 t/t0100-previous.sh                        |  1 +
 t/t0101-at-syntax.sh                       |  2 +
 t/t1001-read-tree-m-2way.sh                |  1 +
 t/t1002-read-tree-m-u-2way.sh              |  1 +
 t/t1060-object-corruption.sh               |  2 +
 t/t1401-symbolic-ref.sh                    |  2 +
 t/t1411-reflog-show.sh                     |  1 +
 t/t1412-reflog-loop.sh                     |  2 +
 t/t1415-worktree-refs.sh                   |  1 +
 t/t2015-checkout-unborn.sh                 |  1 +
 t/t2200-add-update.sh                      |  1 +
 t/t3302-notes-index-expensive.sh           |  1 +
 t/t3303-notes-subtrees.sh                  |  1 +
 t/t3305-notes-fanout.sh                    |  1 +
 t/t3408-rebase-multi-line.sh               |  1 +
 t/t4021-format-patch-numbered.sh           |  1 +
 t/t4027-diff-submodule.sh                  |  1 +
 t/t4028-format-patch-mime-headers.sh       |  2 +
 t/t4036-format-patch-signer-mime.sh        |  1 +
 t/t4039-diff-assume-unchanged.sh           |  1 +
 t/t4055-diff-context.sh                    |  1 +
 t/t4066-diff-emit-delay.sh                 |  1 +
 t/t4122-apply-symlink-inside.sh            |  1 +
 t/t4126-apply-empty.sh                     |  1 -
 t/t4128-apply-root.sh                      |  1 +
 t/t4206-log-follow-harder-copies.sh        |  2 +
 t/t4207-log-decoration-colors.sh           |  1 +
 t/t4212-log-corrupt.sh                     |  1 +
 t/t5301-sliding-window.sh                  |  2 +
 t/t5313-pack-bounds-checks.sh              |  2 +
 t/t5316-pack-delta-depth.sh                |  2 +
 t/t5320-delta-islands.sh                   |  2 +
 t/t5322-pack-objects-sparse.sh             |  1 +
 t/t5506-remote-groups.sh                   |  1 +
 t/t5513-fetch-track.sh                     |  1 +
 t/t5515-fetch-merge-logic.sh               |  1 +
 t/t5518-fetch-exit-status.sh               |  1 +
 t/t5532-fetch-proxy.sh                     |  2 +
 t/t5600-clone-fail-cleanup.sh              |  1 +
 t/t5900-repo-selection.sh                  |  2 +
 t/t6002-rev-list-bisect.sh                 |  1 +
 t/t6003-rev-list-topo-order.sh             |  1 +
 t/t6005-rev-list-count.sh                  |  1 +
 t/t6018-rev-list-glob.sh                   |  1 +
 t/t6100-rev-list-in-order.sh               |  1 +
 t/t6101-rev-parse-parents.sh               |  1 +
 t/t6110-rev-list-sparse.sh                 |  1 +
 t/t6114-keep-packs.sh                      |  2 +
 t/t6131-pathspec-icase.sh                  |  2 +
 t/t7008-filter-branch-null-sha1.sh         |  1 +
 t/t7702-repack-cyclic-alternate.sh         |  2 +
 t/t9001-send-email.sh                      |  1 +
 t/t9100-git-svn-basic.sh                   |  1 +
 t/t9101-git-svn-props.sh                   |  2 +
 t/t9104-git-svn-follow-parent.sh           |  2 +
 t/t9106-git-svn-commit-diff-clobber.sh     |  2 +
 t/t9115-git-svn-dcommit-funky-renames.sh   |  1 +
 t/t9116-git-svn-log.sh                     |  1 +
 t/t9122-git-svn-author.sh                  |  2 +
 t/t9127-git-svn-partial-rebuild.sh         |  1 +
 t/t9129-git-svn-i18n-commitencoding.sh     |  1 +
 t/t9132-git-svn-broken-symlink.sh          |  1 +
 t/t9139-git-svn-non-utf8-commitencoding.sh |  1 +
 t/t9146-git-svn-empty-dirs.sh              |  2 +
 t/t9148-git-svn-propset.sh                 |  1 +
 t/t9160-git-svn-preserve-empty-dirs.sh     |  1 +
 t/t9162-git-svn-dcommit-interactive.sh     |  2 +
 t/t9164-git-svn-dcommit-concurrent.sh      |  2 +
 t/t9501-gitweb-standalone-http-status.sh   |  1 +
 wt-status.c                                | 15 +++--
 115 files changed, 436 insertions(+), 148 deletions(-)

Range-diff against v3:
 1:  7c8298f564f =  1:  b99a07f98ee t/helper/test-fast-rebase.c: don't leak "struct strbuf"
 2:  515bacc8f27 =  2:  da5be507c0f blame: use "goto cleanup" for cleanup_scoreboard()
 3:  58b59542c2b =  3:  243f7c8df96 string_list API users: use string_list_init_{no,}dup
 4:  71495dfd073 =  4:  69f0aabe38f format-patch: don't leak "extra_headers" or "ref_message_ids"
 5:  12fb45f02c1 =  5:  2d0ed57ec2e revision.[ch]: split freeing of revs->commit into a function
 6:  1e93a60d81a !  6:  b9beaba16bf revision.[ch]: provide and start using a release_revisions()
    @@ revision.h: void repo_init_revisions(struct repository *r,
      		    struct setup_revision_opt *);
      
     +/**
    -+ * Free data allocated in a "struct rev_info" after it's been setup
    -+ * with repo_init_revisions() and setup_revisions().
    ++ * Free data allocated in a "struct rev_info" after it's been
    ++ * initialized with repo_init_revisions().
     + */
     +void release_revisions(struct rev_info *revs);
     +
 7:  c4fc1c98e7b !  7:  80ec9a131c0 revisions API users: add straightforward release_revisions()
    @@ builtin/merge.c: static int evaluate_result(void)
      
     
      ## builtin/pack-objects.c ##
    -@@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
    - 	strbuf_release(&buf);
    - 	string_list_clear(&include_packs, 0);
    - 	string_list_clear(&exclude_packs, 0);
    -+	release_revisions(&revs);
    - }
    - 
    - static void read_object_list_from_stdin(void)
    -@@ builtin/pack-objects.c: static void get_object_list(int ac, const char **av)
    - 	if (unpack_unreachable)
    - 		loosen_unused_packed_objects();
    - 
    -+	release_revisions(&revs);
    - 	oid_array_clear(&recent_objects);
    - }
    - 
    +@@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const char *prefix)
    + 		read_object_list_from_stdin();
    + 	} else if (pfd.have_revs) {
    + 		get_object_list(&pfd.revs, rp.nr, rp.v);
    ++		release_revisions(&pfd.revs);
    + 	} else {
    + 		struct rev_info revs;
    + 
    + 		repo_init_revisions(the_repository, &revs, NULL);
    + 		get_object_list(&revs, rp.nr, rp.v);
    ++		release_revisions(&revs);
    + 	}
    + 	cleanup_preferred_base();
    + 	if (include_tag && nr_result)
     
      ## builtin/prune.c ##
     @@ builtin/prune.c: int cmd_prune(int argc, const char **argv, const char *prefix)
    @@ submodule.c: static void collect_changed_submodules(struct repository *r,
     +	release_revisions(&rev);
      }
      
    - static void free_submodules_oids(struct string_list *submodules)
    + static void free_submodules_data(struct string_list *submodules)
     
      ## t/helper/test-revision-walking.c ##
     @@ t/helper/test-revision-walking.c: static int run_revision_walk(void)
 8:  f8a9443fe6f <  -:  ----------- revisions API users: add "goto cleanup" for "rev_info" early exit
 9:  5f5c0d26395 <  -:  ----------- revisions API users: use release_revisions() in submodule.c edge case
 -:  ----------- >  8:  086cec742b4 revision.[ch]: document and move code declared around "init"
 -:  ----------- >  9:  2f4e65fb534 revisions API users: use release_revisions() needing REV_INFO_INIT
10:  9da5c5f5f5d = 10:  145a0f74b6a stash: always have the owner of "stash_info" free it
11:  da4fcd04345 = 11:  c9898a5a96b revisions API users: add "goto cleanup" for release_revisions()
12:  b6acc61fb61 = 12:  6e41d666223 revisions API users: use release_revisions() in http-push.c
13:  2eae0e809e5 = 13:  02ca92660af revisions API users: use release_revisions() in builtin/log.c
14:  216eb3b41f7 = 14:  1aeb1127f34 revisions API users: use release_revisions() with UNLEAK()
15:  f8e0eb52957 = 15:  c12b3d5a035 revisions API users: use release_revisions() for "prune_data" users
16:  0a5662a9f67 = 16:  2e351702677 revisions API: have release_revisions() release "commits"
17:  65803961ee2 = 17:  f67f1f5a575 revisions API: have release_revisions() release "mailmap"
18:  ac68630dbf6 = 18:  1df61550e5a revisions API: have release_revisions() release "cmdline"
19:  740abb80c57 = 19:  065c3cc91b2 revisions API: have release_revisions() release "filter"
20:  26163e5e754 = 20:  806fef06b87 revisions API: have release_revisions() release "grep_filter"
21:  842faebddc4 = 21:  fabbe452a14 revisions API: have release_revisions() release "prune_data"
22:  bf93197993c = 22:  cb201fa1914 revisions API: clear "boundary_commits" in release_revisions()
23:  af874c17fbd = 23:  0363a69073c revisions API: release "reflog_info" in release revisions()
24:  006fa1fcc34 = 24:  bad359b2983 revisions API: call diff_free(&revs->pruning) in revisions_release()
25:  0eacbd66711 = 25:  9a51c1ae1d1 revisions API: have release_revisions() release "date_mode"
26:  5efc0ae58ed = 26:  b56db37940d revisions API: have release_revisions() release "topo_walk_info"
27:  6c6fdf696af = 27:  b02cb8fcded revisions API: add a TODO for diff_free(&revs->diffopt)
-- 
2.35.1.1557.g4e3e9cdb5e0

