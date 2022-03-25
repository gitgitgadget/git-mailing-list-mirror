Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92184C433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiCYRaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiCYRaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:30:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E3C2528A
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:28:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r64so4835474wmr.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBJPzyjfyfoYtjJ9u1KkBYKRFcBC3BhhWQB6iVE9K/M=;
        b=TKuLapej4Ijz5Aq9Vy0GN0wNk/CjF3Oqf5c22e92t2OW+W138iBTmpPRrKL6T59zZF
         PyACD5KfypIY4DRUg40AK1BhDgbziF93w16AlGluMVxWpGRe0ID76H/SrsLTPH09rM3J
         a6csDJKDB6OmJ/TYCFDYbltz3ZjvGHyv1Z4hbJesm/RVT9vUSJG3RXWB5UD9MGXudfGd
         uNlYD69oyqR/wGeRYZPmE8Iu1BLuJQtnGFJEm16pGgT2ZTgS4q1iRZcmpqag25ecQgFT
         tEi6pxcGqziU4nd64NlW6QRwnOziuQlhB+tm9GNqO68fA2qM35iosmbuulW6nK36aXhv
         GwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBJPzyjfyfoYtjJ9u1KkBYKRFcBC3BhhWQB6iVE9K/M=;
        b=o0qYKAIacKni94J88aiJCkZVm2cC8jnajzKwtZwZBH4m7463ux7ipXd13T8TvlCU6l
         eqloHxAf+qfqTHNfG6nJSvALNqHKD00aPQiwxHEo6kre3QAcHwPuSEhX0GU3XP2Lg957
         XZTlAqpEMc0i77opz3WBiLOUcwkp2qwjURY5HACNjetw7n+k4gnjGDsl8SMbhs+3btVz
         MgVCvDTl/r8/fF6qwbm3O2r/5A5MN3R68TpMJBMnAUITVLriTZMHvgyunB9k08EqVJWn
         Qi4+4b/qMDwR3bBzxd7o7+07qxx5H7JB6x3iWtAG2/HvRnh7epJwA9QBdDGL5JLFkcQC
         c9VA==
X-Gm-Message-State: AOAM5337IWYlCZgjLRFu2sehU7q4QiNC21eQjmBgo9O4ZwsH3MYfop2w
        +4rvyGXdLd0WOB5jJzVAnJEY77V8el/Iag==
X-Google-Smtp-Source: ABdhPJzhNECXQdcNMr2yO2fHKsvtzowvnC1e5xBplRJ7jHjFyKxlzm/cefm5mrjKORywDm0/fa2PPw==
X-Received: by 2002:a05:600c:1c84:b0:38c:abf0:c1c8 with SMTP id k4-20020a05600c1c8400b0038cabf0c1c8mr10827789wms.111.1648228771248;
        Fri, 25 Mar 2022 10:19:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:30 -0700 (PDT)
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
Subject: [PATCH v3 00/27] revision.[ch]: add and use release_revisions()
Date:   Fri, 25 Mar 2022 18:18:24 +0100
Message-Id: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

= Brief summary, more in the v1 CL[1]:

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

[NOTE: These numbers are for v1, and may not be *exactly* those
anymore as "master" has moved, but are going to be in that ballpark].

= Changes since v2[2]

I think this addresses all the outstanding commments/feedback on the
v2. Thanks to Junio for the review!

This still has a similar textual conflict as v2[2], and will require
my [3] on top of ds/partial-bundle-more to fully pass the leak tests,
currently "seen" is failing due to that issue.

1. https://lore.kernel.org/git/cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com/
3. https://lore.kernel.org/git/patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (27):
  t/helper/test-fast-rebase.c: don't leak "struct strbuf"
  blame: use "goto cleanup" for cleanup_scoreboard()
  string_list API users: use string_list_init_{no,}dup
  format-patch: don't leak "extra_headers" or "ref_message_ids"
  revision.[ch]: split freeing of revs->commit into a function
  revision.[ch]: provide and start using a release_revisions()
  revisions API users: add straightforward release_revisions()
  revisions API users: add "goto cleanup" for "rev_info" early exit
  revisions API users: use release_revisions() in submodule.c edge case
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
 bisect.c                                   | 19 ++++--
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
 builtin/submodule--helper.c                | 17 +++--
 bundle.c                                   | 12 +++-
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
 revision.c                                 | 64 +++++++++++++++---
 revision.h                                 |  6 ++
 sequencer.c                                | 26 ++++++--
 shallow.c                                  |  1 +
 submodule.c                                | 43 ++++++------
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
 115 files changed, 416 insertions(+), 145 deletions(-)

Range-diff against v2:
 1:  8fbafe61053 !  1:  7c8298f564f t/helper/test-fast-rebase.c: don't leak "struct strbuf"
    @@ Commit message
         cases. But after f9500261e0a only the "if" block would free these two
         "struct strbuf".
     
    -    This change is needed so that a subsequent addition of a "goto
    -    cleanup" pattern when adding release_revisions() doesn't solve this
    -    unrelated bug while it's at it.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/helper/test-fast-rebase.c ##
 2:  77e7c2c321e !  2:  515bacc8f27 blame: use "goto cleanup" for cleanup_scoreboard()
    @@ Commit message
         Bloom filters, 2020-04-16) to use a "goto cleanup", so that we can be
         sure that we call cleanup_scoreboard().
     
    -    This change is needed so that a subsequent addition of a
    -    release_revisions() doesn't solve this unrelated issue while it's at
    -    it.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/blame.c ##
 3:  151d1175905 =  3:  58b59542c2b string_list API users: use string_list_init_{no,}dup
 4:  64a76629e23 =  4:  71495dfd073 format-patch: don't leak "extra_headers" or "ref_message_ids"
 5:  4c0718b43d7 !  5:  12fb45f02c1 revision.[ch]: split freeing of revs->commit into a function
    @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
      
     +static void release_revisions_commit_list(struct rev_info *revs)
     +{
    -+	struct commit_list *commits = revs->commits;
    -+
    -+	if (!commits)
    -+		return;
    -+	free_commit_list(commits);
    -+	revs->commits = NULL;
    ++	if (revs->commits) {
    ++		free_commit_list(revs->commits);
    ++		revs->commits = NULL;
    ++	}
     +}
     +
      static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
 6:  7194aac88e1 !  6:  1e93a60d81a revision.[ch]: provide and start using a release_revisions()
    @@ range-diff.c: int is_range_diff_range(const char *arg)
     
      ## revision.c ##
     @@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
    - 	revs->commits = NULL;
    + 	}
      }
      
     +void release_revisions(struct rev_info *revs)
     +{
    -+	if (!revs)
    -+		return;
     +	object_array_clear(&revs->pending);
     +}
     +
 7:  3cb36d358d6 =  7:  c4fc1c98e7b revisions API users: add straightforward release_revisions()
 8:  42ad1208934 !  8:  f8a9443fe6f revisions API users: use release_revisions() needing "{ 0 }" init
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    revisions API users: use release_revisions() needing "{ 0 }" init
    +    revisions API users: add "goto cleanup" for "rev_info" early exit
     
    -    Use release_revisions() to various users of "struct rev_list" which
    -    need to have their "struct rev_info" zero-initialized before we can
    -    start using it. In all of these cases we might "goto cleanup" (or equivalent),
    +    Add release_revisions() in various users of "struct rev_info" that can
    +    mostly use a "goto cleanup" pattern, but also have an early "return"
    +    before we've called repo_init_revisions(). We need to avoid calling
    +    release_revisions() with uninitialized memory.
    +
    +    It would be a lot cleaner to be able to initialize "struct rev_info"
    +    with "{ 0 }" here, or if a "REV_INFO_INIT" existed, we'll hopefully
    +    get around to making the initialization easier in the future (now it
    +    can't be done via a macro).
    +
    +    Until then let's leave a "cleanup_no_rev[s]" in place to document the
    +    intention here. Only status_submodule() in builtin/submodule--helper.c
    +    strictly speaking needs this, the other ones could keep their "return"
    +    for the early exit. But let's have them also use the "goto
    +    cleanup[...]" for consistency, and for the eventual migration to
    +    simpler initialization.
     
         For the bundle.c code see the early exit case added in
         3bbbe467f29 (bundle verify: error out if called without an object
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## bisect.c ##
    -@@ bisect.c: void read_bisect_terms(const char **read_bad, const char **read_good)
    -  */
    - enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
    - {
    --	struct rev_info revs;
    -+	struct rev_info revs = { 0 };
    - 	struct commit_list *tried;
    - 	int reaches = 0, all = 0, nr, steps;
    - 	enum bisect_error res = BISECT_OK;
     @@ bisect.c: enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
      
      	res = check_good_are_ancestors_of_bad(r, prefix, no_checkout);
      	if (res)
     -		return res;
    -+		goto cleanup;
    ++		goto cleanup_no_revs;
      
      	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
      
    @@ bisect.c: enum bisect_error bisect_next_all(struct repository *r, const char *pr
     +	res = bisect_checkout(bisect_rev, no_checkout);
     +cleanup:
     +	release_revisions(&revs);
    ++cleanup_no_revs:
     +	return res;
      }
      
    @@ bisect.c: enum bisect_error bisect_next_all(struct repository *r, const char *pr
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static void status_submodule(const char *path, const struct object_id *ce_oid,
    - {
    - 	char *displaypath;
    - 	struct strvec diff_files_args = STRVEC_INIT;
    --	struct rev_info rev;
    -+	struct rev_info rev = { 0 };
    - 	int diff_files_result;
    - 	struct strbuf buf = STRBUF_INIT;
    - 	const char *git_dir;
    + 
    + 	if ((CE_STAGEMASK & ce_flags) >> CE_STAGESHIFT) {
    + 		print_status(flags, 'U', path, null_oid(), displaypath);
    +-		goto cleanup;
    ++		goto cleanup_no_rev;
    + 	}
    + 
    + 	strbuf_addf(&buf, "%s/.git", path);
     @@ builtin/submodule--helper.c: static void status_submodule(const char *path, const struct object_id *ce_oid,
    + 	    !is_git_directory(git_dir)) {
    + 		print_status(flags, '-', path, ce_oid, displaypath);
    + 		strbuf_release(&buf);
    +-		goto cleanup;
    ++		goto cleanup_no_rev;
    + 	}
    + 	strbuf_release(&buf);
    + 
    +@@ builtin/submodule--helper.c: static void status_submodule(const char *path, const struct object_id *ce_oid,
    + 	}
    + 
      cleanup:
    ++	release_revisions(&rev);
    ++cleanup_no_rev:
      	strvec_clear(&diff_files_args);
      	free(displaypath);
    -+	release_revisions(&rev);
      }
    - 
    - static void status_submodule_cb(const struct cache_entry *list_item,
     
      ## bundle.c ##
     @@ bundle.c: int verify_bundle(struct repository *r,
    - 	 * to be verbose about the errors
    - 	 */
    - 	struct string_list *p = &header->prerequisites;
    --	struct rev_info revs;
    -+	struct rev_info revs = { 0 };
    - 	const char *argv[] = {NULL, "--all", NULL};
    - 	struct commit *commit;
      	int i, ret = 0, req_nr;
      	const char *message = _("Repository lacks these prerequisite commits:");
      
    @@ bundle.c: int verify_bundle(struct repository *r,
     -		return error(_("need a repository to verify a bundle"));
     +	if (!r || !r->objects || !r->objects->odb) {
     +		ret = error(_("need a repository to verify a bundle"));
    -+		goto cleanup;
    ++		goto cleanup_no_revs;
     +	}
      
      	repo_init_revisions(r, &revs, NULL);
    @@ bundle.c: int verify_bundle(struct repository *r,
      			list_refs(r, 0, NULL);
      		}
      	}
    ++
     +cleanup:
     +	release_revisions(&revs);
    ++cleanup_no_revs:
      	return ret;
      }
      
14:  38f4f1c4ecb !  9:  5f5c0d26395 revisions API users: use release_revisions() in submodule.c edge case
    @@ Commit message
         revisions API users: use release_revisions() in submodule.c edge case
     
         Use release_revisions() on the the "struct rev_info" in
    -    show_submodule_diff_summary() where we need to pre-initialize with "{
    -    0 }" to make sure that we won't segfault when calling
    -    release_revisions().
    -
    -    Most functions that use "struct rev_info" will call
    -    repo_init_revisions() early, which will do an equivalent memset(). In
    -    this case we might "goto out" before doing the equivalent of that
    -    operation, see the "goto" on "(!left || !right || !sub)" added in
    +    show_submodule_diff_summary() where we'd otherwise need to do the
    +    equivalent of pre-initializing the "struct rev_info" with "{ 0 }" if
    +    we were going to add it to the cleanup being performed in the "out"
    +    part of the function, let's instead introduce an "out_no_rev" for the
    +    reasons discussed in the preceding commit.
    +
    +    Doing so for the "goto" on "(!left || !right || !sub)" added in
         8e6df65015f (submodule: refactor show_submodule_summary with helper
    -    function, 2016-08-31).
    +    function, 2016-08-31) would have been straightforward, as in the
    +    preceding commit.
    +
    +    But for the case of prepare_submodule_diff_summary() failing it's less
    +    straightforward. Reading the pre-image we could simply retain the
    +    "goto out" if it fails, because we can see that the first thing it
    +    does is call repo_init_revisions().
    +
    +    But having a hard reliance on that would be a bit nasty, as we'd
    +    potentially introduce a segfault if the function did some other
    +    initialization first, and early aborted if that failed.
    +
    +    Let's just fold that helper function away into
    +    show_submodule_diff_summary() itself, which was its only user. Now
    +    following the flow of initialization is more obvious, and it's
    +    immediately clear that the "goto out" if prepare_revision_walk()
    +    returns non-zero is safe.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## submodule.c ##
    -@@ submodule.c: void show_submodule_diff_summary(struct diff_options *o, const char *path,
    - 		struct object_id *one, struct object_id *two,
    - 		unsigned dirty_submodule)
    +@@ submodule.c: void handle_ignore_submodules_arg(struct diff_options *diffopt,
    + 	 */
    + }
    + 
    +-static int prepare_submodule_diff_summary(struct repository *r, struct rev_info *rev,
    +-					  const char *path,
    +-					  struct commit *left, struct commit *right,
    +-					  struct commit_list *merge_bases)
    +-{
    +-	struct commit_list *list;
    +-
    +-	repo_init_revisions(r, rev, NULL);
    +-	setup_revisions(0, NULL, rev, NULL);
    +-	rev->left_right = 1;
    +-	rev->first_parent_only = 1;
    +-	left->object.flags |= SYMMETRIC_LEFT;
    +-	add_pending_object(rev, &left->object, path);
    +-	add_pending_object(rev, &right->object, path);
    +-	for (list = merge_bases; list; list = list->next) {
    +-		list->item->object.flags |= UNINTERESTING;
    +-		add_pending_object(rev, &list->item->object,
    +-			oid_to_hex(&list->item->object.oid));
    +-	}
    +-	return prepare_revision_walk(rev);
    +-}
    +-
    + static void print_submodule_diff_summary(struct repository *r, struct rev_info *rev, struct diff_options *o)
      {
    --	struct rev_info rev;
    -+	struct rev_info rev = { 0 };
    + 	static const char format[] = "  %m %s";
    +@@ submodule.c: void show_submodule_diff_summary(struct diff_options *o, const char *path,
      	struct commit *left = NULL, *right = NULL;
      	struct commit_list *merge_bases = NULL;
      	struct repository *sub;
    ++	struct commit_list *list;
    + 
    + 	sub = open_submodule(path);
    + 	show_submodule_header(o, path, one, two, dirty_submodule,
    +@@ submodule.c: void show_submodule_diff_summary(struct diff_options *o, const char *path,
    + 	 * all the information the user needs.
    + 	 */
    + 	if (!left || !right || !sub)
    +-		goto out;
    ++		goto out_no_rev;
    + 
    ++	repo_init_revisions(sub, &rev, NULL);
    ++	setup_revisions(0, NULL, &rev, NULL);
    ++	rev.left_right = 1;
    ++	rev.first_parent_only = 1;
    ++	left->object.flags |= SYMMETRIC_LEFT;
    ++	add_pending_object(&rev, &left->object, path);
    ++	add_pending_object(&rev, &right->object, path);
    ++	for (list = merge_bases; list; list = list->next) {
    ++		list->item->object.flags |= UNINTERESTING;
    ++		add_pending_object(&rev, &list->item->object,
    ++			oid_to_hex(&list->item->object.oid));
    ++	}
    + 	/* Treat revision walker failure the same as missing commits */
    +-	if (prepare_submodule_diff_summary(sub, &rev, path, left, right, merge_bases)) {
    ++	if (prepare_revision_walk(&rev)) {
    + 		diff_emit_submodule_error(o, "(revision walker failed)\n");
    + 		goto out;
    + 	}
     @@ submodule.c: void show_submodule_diff_summary(struct diff_options *o, const char *path,
      	print_submodule_diff_summary(sub, &rev, o);
      
      out:
     +	release_revisions(&rev);
    ++out_no_rev:
      	if (merge_bases)
      		free_commit_list(merge_bases);
      	clear_commit_marks(left, ~0);
 9:  88289157533 ! 10:  9da5c5f5f5d stash: always have the owner of "stash_info" free it
    @@ Commit message
     
         Change the initialization of the "revision" member of "struct
         stash_info" to be initialized vi a macro, and more importantly that
    -    that initializing function be tasked to free it, usually via "goto
    +    that initializing function be tasked to free it, usually via a "goto
         cleanup" pattern.
     
         Despite the "revision" name (and the topic of the series containing
10:  eafe57663fc ! 11:  da4fcd04345 revisions API users: add "goto cleanup" for release_revisions()
    @@ Metadata
      ## Commit message ##
         revisions API users: add "goto cleanup" for release_revisions()
     
    -    Add a release_revisions() to various users of "struct rev_list" which
    +    Add a release_revisions() to various users of "struct rev_info" which
         requires a minor refactoring to a "goto cleanup" pattern to use that
         function.
     
11:  6fb2caf4d17 = 12:  b6acc61fb61 revisions API users: use release_revisions() in http-push.c
12:  74818bc372f ! 13:  2eae0e809e5 revisions API users: use release_revisions() in builtin/log.c
    @@ Commit message
         "format-patch", etc. commands, all of which live in this file.
     
         The release_revisions() API still only frees the "pending" member, but
    -    will learn to more members of "struct rev_info" in subsequent commits.
    +    will learn to release more members of "struct rev_info" in subsequent
    +    commits.
     
         In the case of "format-patch" revert the addition of UNLEAK() in
    -    dee839a2633 (format-patch: mark rev_info with UNLEAK, 2021-12-16), and
    +    dee839a2633 (format-patch: mark rev_info with UNLEAK, 2021-12-16),
         which will cause several tests that previously passed under
         "TEST_PASSES_SANITIZE_LEAK=true" to start failing.
     
    @@ Commit message
         incremental progress in that direction. See [1] for further details
         about this approach.
     
    +    Note that the release_revisions() will not be sufficient to deal with
    +    the code in cmd_show() added in 5d7eeee2ac6 (git-show: grok blobs,
    +    trees and tags, too, 2006-12-14) which clobbers the "pending" array in
    +    the case of "OBJ_COMMIT". That will need to be dealt with by some
    +    future follow-up work.
    +
         1. https://lore.kernel.org/git/220218.861r00ib86.gmgdl@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
13:  8717e6e8471 = 14:  216eb3b41f7 revisions API users: use release_revisions() with UNLEAK()
15:  566b739ac6c = 15:  f8e0eb52957 revisions API users: use release_revisions() for "prune_data" users
16:  bc36810e56e ! 16:  0a5662a9f67 revisions API: have release_revisions() release "commits"
    @@ Commit message
         revisions API: have release_revisions() release "commits"
     
         Extend the the release_revisions() function so that it frees the
    -    "commits" in the "struct ref_info".
    +    "commits" in the "struct rev_info".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## revision.c ##
    -@@ revision.c: void release_revisions(struct rev_info *revs)
    +@@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
    + 
    + void release_revisions(struct rev_info *revs)
      {
    - 	if (!revs)
    - 		return;
     +	release_revisions_commit_list(revs);
      	object_array_clear(&revs->pending);
      }
17:  a93251edf85 ! 17:  65803961ee2 revisions API: have release_revisions() release "mailmap"
    @@ Commit message
         revisions API: have release_revisions() release "mailmap"
     
         Extend the the release_revisions() function so that it frees the
    -    "prune_data" in the "struct ref_info".
    +    "mailmap" in the "struct rev_info".
     
         The log family of functions now calls the clear_mailmap() function
         added in fa8afd18e5a (revisions API: provide and use a
    @@ builtin/commit.c: static const char *find_author_by_nickname(const char *name)
     
      ## revision.c ##
     @@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
    - 	revs->commits = NULL;
    + 	}
      }
      
     +static void release_revisions_mailmap(struct string_list *mailmap)
    @@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
     +
      void release_revisions(struct rev_info *revs)
      {
    - 	if (!revs)
    - 		return;
      	release_revisions_commit_list(revs);
      	object_array_clear(&revs->pending);
     +	release_revisions_mailmap(revs->mailmap);
18:  424fac7ab95 ! 18:  ac68630dbf6 revisions API: have release_revisions() release "cmdline"
    @@ Commit message
         revisions API: have release_revisions() release "cmdline"
     
         Extend the the release_revisions() function so that it frees the
    -    "cmdline" in the "struct ref_info". This in combination with a
    +    "cmdline" in the "struct rev_info". This in combination with a
         preceding change to free "commits" and "mailmap" means that we can
         whitelist another test under "TEST_PASSES_SANITIZE_LEAK=true".
     
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    fixup with bc0e0439040?
    -
      ## revision.c ##
     @@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
    - 	revs->commits = NULL;
    + 	}
      }
      
     +static void release_revisions_cmdline(struct rev_cmdline_info *cmdline)
    @@ revision.c: static void release_revisions_commit_list(struct rev_info *revs)
      {
      	if (!mailmap)
     @@ revision.c: void release_revisions(struct rev_info *revs)
    - 		return;
    + {
      	release_revisions_commit_list(revs);
      	object_array_clear(&revs->pending);
     +	release_revisions_cmdline(&revs->cmdline);
19:  d5b7a8a690e ! 19:  740abb80c57 revisions API: have release_revisions() release "filter"
    @@ Commit message
         revisions API: have release_revisions() release "filter"
     
         Extend the the release_revisions() function so that it frees the
    -    "cmdline" in the "struct ref_info". This in combination with a
    +    "filter" in the "struct rev_info". This in combination with a
         preceding change to free "cmdline" means that we can mark another set
         of tests as passing under "TEST_PASSES_SANITIZE_LEAK=true".
     
20:  857880bb4b6 ! 20:  26163e5e754 revisions API: have release_revisions() release "grep_filter"
    @@ Commit message
         revisions API: have release_revisions() release "grep_filter"
     
         Extend the the release_revisions() function so that it frees the
    -    "grep_filter" in the "struct ref_info".This allows us to mark a test
    +    "grep_filter" in the "struct rev_info".This allows us to mark a test
         as passing under "TEST_PASSES_SANITIZE_LEAK=true".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
21:  f98d473f08e ! 21:  842faebddc4 revisions API: have release_revisions() release "prune_data"
    @@ Commit message
         revisions API: have release_revisions() release "prune_data"
     
         Extend the the release_revisions() function so that it frees the
    -    "prune_data" in the "struct ref_info". This means that any code that
    +    "prune_data" in the "struct rev_info". This means that any code that
         calls "release_revisions()" already can get rid of adjacent calls to
         clear_pathspec().
     
22:  827430315fa ! 22:  bf93197993c revisions API: clear "boundary_commits" in release_revisions()
    @@ Commit message
     
      ## revision.c ##
     @@ revision.c: void release_revisions(struct rev_info *revs)
    - 		return;
    + {
      	release_revisions_commit_list(revs);
      	object_array_clear(&revs->pending);
     +	object_array_clear(&revs->boundary_commits);
23:  c559b7d538b = 23:  af874c17fbd revisions API: release "reflog_info" in release revisions()
24:  c3a22f5b474 = 24:  006fa1fcc34 revisions API: call diff_free(&revs->pruning) in revisions_release()
25:  dabbb430ece = 25:  0eacbd66711 revisions API: have release_revisions() release "date_mode"
26:  644d1b54afe ! 26:  5efc0ae58ed revisions API: have release_revisions() release "topo_walk_info"
    @@ revision.c: static void release_revisions_mailmap(struct string_list *mailmap)
     +
      void release_revisions(struct rev_info *revs)
      {
    - 	if (!revs)
    + 	release_revisions_commit_list(revs);
     @@ revision.c: void release_revisions(struct rev_info *revs)
      	free_grep_patterns(&revs->grep_filter);
      	diff_free(&revs->pruning);
27:  2a4d50a0ec8 = 27:  6c6fdf696af revisions API: add a TODO for diff_free(&revs->diffopt)
-- 
2.35.1.1509.ge4eeb5bd39e

