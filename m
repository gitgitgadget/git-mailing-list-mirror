Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30004C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbiCWUeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbiCWUeC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E98C7F8
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r13so3765256wrr.9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QA7Oi0QeXEjt640jhNIkUHi+RI6uVMAH0FevxP8/FGI=;
        b=Dmw4y1J1RiCp+Sg4x4DJ8xCdYoPmeO0XMws8XEmBPDs+PcFLZnI11K+NNNSb7sPWIb
         ufONZx2+3lT1dT1No5qreiy6Tf7tYZQqjbYwmkmtxIciLqes+Imx2LL6FLYmzdrsVesM
         bPXgUQmi/T6AnbYapeiB0NcgxdhAAgmbiAIbeU1qTD9j9oNKwNoD4REobzVYpcqbk32e
         sP7V2VgPdDoCmvLfUduwbSBiohAUem54XBBlXilEgB1u0qh56zgYngkzuoxUuq/3Pdf8
         R4vHuJB2YjcAbCOUj5Wr5+ayNcUXnkw/WHNDVSjapASRdwcFr5T/cLbioC6Oysmh0MEM
         5w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QA7Oi0QeXEjt640jhNIkUHi+RI6uVMAH0FevxP8/FGI=;
        b=ykKVIKyOOKhAtYQbzejfkjY3VMYvT6Anom/gmk7tDlL6CK9i9CMmNAdWwwSWLBgFkK
         84mZ3TU8NL9V9bCSzUihPajuGu3/KPEZbGXU6nDkkEKmvSASzf2IohZJWvCXFmT1Wbiu
         A7jvL1s9nH7Rhqs+oj1DQMBIT3fzS5iyPbYMnv3kpGsMcAZXYEOafmcfkHO4jBz5ehqI
         5f5kedQm9SplvDoxQJ70ul3/l8iTYdukH8InFuPP10kFUvUseEZPY6u2rSJ/v5olc4Zr
         Wx860zAsUH3A2NCbn4MzcHB7x6ncJZHv4BN2wOzifFP0xMC4fqBw4WtsJgCi7SgoTylG
         xFaA==
X-Gm-Message-State: AOAM533mVeka/OMtiyvg5olZM65ujp7dUwlf+4XzFlsFOd8hr5oyofA7
        hhcehnXYQ0/pFnOiG2Voe9skTYfMN7wd1g==
X-Google-Smtp-Source: ABdhPJxnmN9+/eC4uLd9hcYemTr859OrG7js+eUO2uaKdn2SQBdpzXI3tBRSE1OXo9vhOvvPl/viDg==
X-Received: by 2002:a5d:4204:0:b0:203:d794:93e0 with SMTP id n4-20020a5d4204000000b00203d79493e0mr1618372wrq.136.1648067546553;
        Wed, 23 Mar 2022 13:32:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:25 -0700 (PDT)
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
Subject: [PATCH v2 00/27] revision.[ch]: add and use release_revisions()
Date:   Wed, 23 Mar 2022 21:31:50 +0100
Message-Id: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of the v1 of [1] now that 7391ecd338e (Merge branch
'ds/partial-bundles', 2022-03-21) has landed, which it had a conflict
with. I believe this v2 addresses all the feedback brought up on v1.

As the range-diff shows the v2 is a bit larger, I split up some
commits as suggested in review.

I've also rebased this locally on unsubmitted patches I have which
allow for testing that the tests we mark with SANITIZE=leak have a 1=1
correspondance with what we're marking as passing with
TEST_PASSES_SANITIZE_LEAK=true.

All of the individual commits here pass under that, so all the t/*.sh
changes are correct as far as exhaustively marking newly passing tests
with "TEST_PASSES_SANITIZE_LEAK=true" goes.

Now, as I was just about to submit this I noticed that Derrick has
submitted a follow-up series to 7391ecd338e[2]. It textually conflicts
with this one in a minor way, and the resolution is the following:

	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
	index 5f6197a37bb..0c1d5586ed4 100644
	--- a/builtin/pack-objects.c
	+++ b/builtin/pack-objects.c
	@@ -3796,7 +3796,6 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
	 	if (unpack_unreachable)
	 		loosen_unused_packed_objects();
	 
	-	release_revisions(&revs);
	 	oid_array_clear(&recent_objects);
	 }
	 
	@@ -4189,6 +4188,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
	 
	 cleanup:
	 	strvec_clear(&rp);
	+	UNLEAK(revs.diffopt);
	+	release_revisions(&revs);
	 
	 	return 0;
	 }

The UNLEAK() there is new. At the tip of this series we pass (among
many others) t5313-pack-bounds-checks.sh, t5316-pack-delta-depth.sh,
t6114-keep-packs.sh under SANITIZE=leak. When I rebase Derrick's [2]
on top of this series it requires the addition of that UNLEAK().

I didn't look in any detail (didn't have time just now) into why that
now fails exactly, we do the relevant revs.diffopt allocation before.

There's also a trivial conflict here with brian m. carlson's
bc/stash-export series. This series moves the free_stash_info()
function around, so the conflict is the following:
	
	<<<<<<< HEAD
				fprintf_ln(stderr, _("No stash entries found."));
	=======
				free_stash_info(info);
				if (!quiet)
					fprintf_ln(stderr, _("No stash entries found."));
	>>>>>>> origin/seen
	[...]
	<<<<<<< HEAD
		if (get_oid(revision, &info->w_commit))
			return error(_("%s is not a valid reference"), revision);
	=======
		if (get_oid_with_context(the_repository, revision,
					 GET_OID_QUIETLY | GET_OID_RETURN_FAILURE,
					 &info->w_commit, &unused)) {
			if (!quiet)
				error(_("%s is not a valid reference"), revision);
			free_stash_info(info);
			return -1;
		}
	>>>>>>> origin/seen

In both cases the solution is triavial: Keep brian's side, but delete
the two free_stash_info() calls, as we now call it in the invoking
function.
	
1. https://lore.kernel.org/git/cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com/
2. https://lore.kernel.org/git/pull.1186.git.1647970119.gitgitgadget@gmail.com/

Ævar Arnfjörð Bjarmason (27):
  t/helper/test-fast-rebase.c: don't leak "struct strbuf"
  blame: use "goto cleanup" for cleanup_scoreboard()
  string_list API users: use string_list_init_{no,}dup
  format-patch: don't leak "extra_headers" or "ref_message_ids"
  revision.[ch]: split freeing of revs->commit into a function
  revision.[ch]: provide and start using a release_revisions()
  revisions API users: add straightforward release_revisions()
  revisions API users: use release_revisions() needing "{ 0 }" init
  stash: always have the owner of "stash_info" free it
  revisions API users: add "goto cleanup" for release_revisions()
  revisions API users: use release_revisions() in http-push.c
  revisions API users: use release_revisions() in builtin/log.c
  revisions API users: use release_revisions() with UNLEAK()
  revisions API users: use release_revisions() in submodule.c edge case
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
 revision.h                                 |  6 ++
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
 115 files changed, 402 insertions(+), 123 deletions(-)

Range-diff against v1:
 1:  017c67c7540 =  1:  8fbafe61053 t/helper/test-fast-rebase.c: don't leak "struct strbuf"
 2:  db0b04e53a9 =  2:  77e7c2c321e blame: use "goto cleanup" for cleanup_scoreboard()
 -:  ----------- >  3:  151d1175905 string_list API users: use string_list_init_{no,}dup
 3:  ab1afe6c0c8 !  4:  64a76629e23 format-patch: don't leak "extra_headers" or "ref_message_ids"
    @@ Commit message
         variable to hold it, to avoid the eventual cast from "const char *"
         when we free() it.
     
    -    While we're at it let's also move to using string_list_init_nodup()
    -    instead of relying on calloc() implicitly coming up with the same
    -    result. See 770fedaf9fb (string-list.[ch]: add a
    -    string_list_init_{nodup,dup}(), 2021-07-01) for the introduction of
    -    the string_list_init_nodup() helper. The string_list_clear() here is
    -    redundant due to the *_nodup() initialization, but let's add it anyway
    -    for consistency with other API use.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/log.c ##
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      	struct commit *commit;
      	struct commit **list = NULL;
      	struct rev_info rev;
    -+	char *extra_headers = NULL;
    ++	char *to_free = NULL;
      	struct setup_revision_opt s_r_opt;
      	int nr = 0, total, i;
      	int use_stdout = 0;
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      	}
      
     -	rev.extra_headers = strbuf_detach(&buf, NULL);
    -+	extra_headers = strbuf_detach(&buf, NULL);
    -+	rev.extra_headers = extra_headers;
    ++	rev.extra_headers = to_free = strbuf_detach(&buf, NULL);
      
      	if (from) {
      		if (split_ident_line(&rev.from_ident, from, strlen(from)))
    -@@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
    - 		prepare_bases(&bases, base, list, nr);
    - 	}
    - 
    --	if (in_reply_to || thread || cover_letter)
    --		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
    -+	if (in_reply_to || thread || cover_letter) {
    -+		rev.ref_message_ids = xmalloc(sizeof(*rev.ref_message_ids));
    -+		string_list_init_nodup(rev.ref_message_ids);
    -+	}
    - 	if (in_reply_to) {
    - 		const char *msgid = clean_message_id(in_reply_to);
    - 		string_list_append(rev.ref_message_ids, msgid);
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
      	strbuf_release(&rdiff1);
      	strbuf_release(&rdiff2);
      	strbuf_release(&rdiff_title);
    -+	free(extra_headers);
    -+	if (rev.ref_message_ids) {
    ++	free(to_free);
    ++	if (rev.ref_message_ids)
     +		string_list_clear(rev.ref_message_ids, 0);
    -+		free(rev.ref_message_ids);
    -+	}
    ++	free(rev.ref_message_ids);
      	UNLEAK(rev);
      	return 0;
      }
 4:  763e0ab3425 =  5:  4c0718b43d7 revision.[ch]: split freeing of revs->commit into a function
 5:  b89dcadcc22 !  6:  7194aac88e1 revision.[ch]: provide and start using a release_revisions()
    @@ Commit message
         to clear its "diffopt". I.e. we need to call release_revisions() after
         we've inspected any state in "struct rev_info".
     
    +    This leaves in place e.g. clear_pathspec(&rev.prune_data) in
    +    stash_working_tree() in builtin/stash.c, subsequent commits will teach
    +    release_revisions() to free "prune_data" and other members that in
    +    some cases are individually cleared by users of "struct rev_info" by
    +    reaching into its members. Those subsequent commits will remove the
    +    relevant calls to e.g. clear_pathspec().
    +
    +    We avoid amending code in index_differs_from() in diff-lib.c as well
    +    as wt_status_collect_changes_index(), has_unstaged_changes() and
    +    has_uncommitted_changes() in wt-status.c in a way that assumes that we
    +    are already clearing the "diffopt" member. That will be handled in a
    +    subsequent commit.
    +
         1. https://lore.kernel.org/git/87a6k8daeu.fsf@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/stash.c: static int stash_working_tree(struct stash_info *info, const st
      	return ret;
     
      ## diff-lib.c ##
    -@@ diff-lib.c: int index_differs_from(struct repository *r,
    - {
    - 	struct rev_info rev;
    - 	struct setup_revision_opt opt;
    -+	unsigned int has_changes;
    - 
    - 	repo_init_revisions(r, &rev, NULL);
    - 	memset(&opt, 0, sizeof(opt));
     @@ diff-lib.c: int index_differs_from(struct repository *r,
      		diff_flags_or(&rev.diffopt.flags, flags);
      	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
      	run_diff_index(&rev, 1);
     -	object_array_clear(&rev.pending);
    --	return (rev.diffopt.flags.has_changes != 0);
    -+	has_changes = rev.diffopt.flags.has_changes;
     +	release_revisions(&rev);
    -+	return (has_changes != 0);
    + 	return (rev.diffopt.flags.has_changes != 0);
      }
      
    - static struct strbuf *idiff_prefix_cb(struct diff_options *opt, void *data)
     
      ## range-diff.c ##
     @@ range-diff.c: int is_range_diff_range(const char *arg)
    @@ revision.h: void repo_init_revisions(struct repository *r,
     
      ## wt-status.c ##
     @@ wt-status.c: static void wt_status_collect_changes_index(struct wt_status *s)
    - 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
    + 
      	copy_pathspec(&rev.prune_data, &s->pathspec);
      	run_diff_index(&rev, 1);
     -	object_array_clear(&rev.pending);
    @@ wt-status.c: static void wt_status_collect_changes_index(struct wt_status *s)
      	clear_pathspec(&rev.prune_data);
      }
      
    +@@ wt-status.c: int has_unstaged_changes(struct repository *r, int ignore_submodules)
    + 	rev_info.diffopt.flags.quick = 1;
    + 	diff_setup_done(&rev_info.diffopt);
    + 	result = run_diff_files(&rev_info, 0);
    ++	release_revisions(&rev_info);
    + 	return diff_result_code(&rev_info.diffopt, result);
    + }
    + 
     @@ wt-status.c: int has_uncommitted_changes(struct repository *r,
      
      	diff_setup_done(&rev_info.diffopt);
      	result = run_diff_index(&rev_info, 1);
     -	object_array_clear(&rev_info.pending);
    --	return diff_result_code(&rev_info.diffopt, result);
    -+	result = diff_result_code(&rev_info.diffopt, result);
     +	release_revisions(&rev_info);
    -+	return result;
    + 	return diff_result_code(&rev_info.diffopt, result);
      }
      
    - /**
 6:  b5d55539b6d =  7:  3cb36d358d6 revisions API users: add straightforward release_revisions()
 7:  295fa35174f =  8:  42ad1208934 revisions API users: use release_revisions() needing "{ 0 }" init
 -:  ----------- >  9:  88289157533 stash: always have the owner of "stash_info" free it
 8:  0f9d313b338 ! 10:  eafe57663fc revisions API users: add "goto cleanup" for release_revisions()
    @@ builtin/diff-files.c: int cmd_diff_files(int argc, const char **argv, const char
     +		result = -1;
     +		goto cleanup;
      	}
    ++cleanup:
      	result = run_diff_files(&rev, options);
     -	return diff_result_code(&rev.diffopt, result);
     +	result = diff_result_code(&rev.diffopt, result);
    -+cleanup:
     +	release_revisions(&rev);
     +	return result;
      }
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *prefix)
      
      	if (use_bitmap_index) {
    - 		if (!try_bitmap_count(&revs, &filter_options, filter_provided_objects))
    + 		if (!try_bitmap_count(&revs, filter_provided_objects))
     -			return 0;
     +			goto cleanup;
    - 		if (!try_bitmap_disk_usage(&revs, &filter_options, filter_provided_objects))
    + 		if (!try_bitmap_disk_usage(&revs, filter_provided_objects))
     -			return 0;
     +			goto cleanup;
    - 		if (!try_bitmap_traversal(&revs, &filter_options, filter_provided_objects))
    + 		if (!try_bitmap_traversal(&revs, filter_provided_objects))
     -			return 0;
     +			goto cleanup;
      	}
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
     
      ## builtin/stash.c ##
     @@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *prefix)
    - 
    - 	ret = get_stash_info(&info, stash_args.nr, stash_args.v);
    + cleanup:
      	strvec_clear(&stash_args);
    --	if (ret)
    --		return -1;
    -+	if (ret) {
    -+		ret = -1;
    -+		goto cleanup;
    -+	}
    - 
    - 	/*
    - 	 * The config settings are applied only if there are not passed
    -@@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *prefix)
    - 
    - 		if (!show_stat && !show_patch) {
    - 			free_stash_info(&info);
    --			return 0;
    -+			ret = 0;
    -+			goto cleanup;
    - 		}
    - 	}
    - 
    -@@ builtin/stash.c: static int show_stash(int argc, const char **argv, const char *prefix)
    - 	log_tree_diff_flush(&rev);
    - 
      	free_stash_info(&info);
    --	return diff_result_code(&rev.diffopt, 0);
    -+	ret = diff_result_code(&rev.diffopt, 0);
    -+cleanup:
     +	release_revisions(&rev);
    -+	return ret;
    + 	return ret;
      }
      
    - static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int compute_summary_module_list(struct object_id *head_oid,
    @@ builtin/submodule--helper.c: static int compute_summary_module_list(struct objec
      	else
      		run_diff_files(&rev, 0);
      	prepare_submodule_summary(info, &list);
    -+	ret = 0;
     +cleanup:
      	strvec_clear(&diff_args);
      	release_revisions(&rev);
    @@ t/helper/test-fast-rebase.c: int cmd__fast_rebase(int argc, const char **argv)
     -	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1)
     -		return error(_("unhandled options"));
     +	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
    -+		ret =  error(_("unhandled options"));
    ++		ret = error(_("unhandled options"));
     +		goto cleanup;
     +	}
      
    @@ t/helper/test-fast-rebase.c: int cmd__fast_rebase(int argc, const char **argv)
      	init_merge_options(&merge_opt, the_repository);
      	memset(&result, 0, sizeof(result));
     @@ t/helper/test-fast-rebase.c: int cmd__fast_rebase(int argc, const char **argv)
    - 	if (write_locked_index(&the_index, &lock,
      			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
      		die(_("unable to write %s"), get_index_file());
    --
    + 
     +	ret = (result.clean == 0);
     +cleanup:
      	strbuf_release(&reflog_msg);
 9:  8f93b87f369 = 11:  6fb2caf4d17 revisions API users: use release_revisions() in http-push.c
10:  a89f0da4fd7 ! 12:  74818bc372f revisions API users: use release_revisions() in builtin/log.c
    @@ builtin/log.c: int cmd_log(int argc, const char **argv, const char *prefix)
      
      /* format-patch */
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
    + 	if (rev.ref_message_ids)
      		string_list_clear(rev.ref_message_ids, 0);
    - 		free(rev.ref_message_ids);
    - 	}
    + 	free(rev.ref_message_ids);
     -	UNLEAK(rev);
     -	return 0;
     +	return cmd_log_deinit(0, &rev);
11:  a93c8838257 = 13:  8717e6e8471 revisions API users: use release_revisions() with UNLEAK()
12:  8811a5ca840 = 14:  38f4f1c4ecb revisions API users: use release_revisions() in submodule.c edge case
14:  761bbd1763c = 15:  566b739ac6c revisions API users: use release_revisions() for "prune_data" users
15:  4a0adf6fd00 = 16:  bc36810e56e revisions API: have release_revisions() release "commits"
16:  1a988c96371 ! 17:  a93251edf85 revisions API: have release_revisions() release "mailmap"
    @@ builtin/commit.c: static const char *find_author_by_nickname(const char *name)
      	struct commit *commit;
      	struct strbuf buf = STRBUF_INIT;
     -	struct string_list mailmap = STRING_LIST_INIT_NODUP;
    -+	struct string_list *mailmap = xmalloc(sizeof(struct string_list));
      	const char *av[20];
      	int ac = 0;
      
    @@ builtin/commit.c: static const char *find_author_by_nickname(const char *name)
      	av[++ac] = NULL;
      	setup_revisions(ac, av, &revs, NULL);
     -	revs.mailmap = &mailmap;
    -+	string_list_init_nodup(mailmap);
    -+	revs.mailmap = mailmap;
    ++	revs.mailmap = xmalloc(sizeof(struct string_list));
    ++	string_list_init_nodup(revs.mailmap);
      	read_mailmap(revs.mailmap);
      
      	if (prepare_revision_walk(&revs))
    @@ t/t0056-git-C.sh
      
      test_expect_success '"git -C <path>" runs git from the directory <path>' '
     
    + ## t/t3302-notes-index-expensive.sh ##
    +@@ t/t3302-notes-index-expensive.sh: test_description='Test commit notes index (expensive!)'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + create_repo () {
    +
      ## t/t4055-diff-context.sh ##
     @@
      
    @@ t/t7008-filter-branch-null-sha1.sh
      
      test_description='filter-branch removal of trees with null sha1'
     +
    -+TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
      test_expect_success 'setup: base commits' '
17:  b5687ed1355 ! 18:  424fac7ab95 revisions API: have release_revisions() release "cmdline"
    @@ t/t1060-object-corruption.sh
      
      test_description='see how we handle various forms of corruption'
     +
    -+TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
      # convert "1234abcd" to ".git/objects/12/34abcd"
     
    - ## t/t2015-checkout-unborn.sh ##
    -@@ t/t2015-checkout-unborn.sh: test_description='checkout from unborn branch'
    + ## t/t3303-notes-subtrees.sh ##
    +@@ t/t3303-notes-subtrees.sh: test_description='Test commit notes organized in subtrees'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
      export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    - test_expect_success 'setup' '
    + number_of_commits=100
     
    - ## t/t3408-rebase-multi-line.sh ##
    -@@ t/t3408-rebase-multi-line.sh: test_description='rebasing a commit with multi-line first paragraph.'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + ## t/t3305-notes-fanout.sh ##
    +@@
    + 
    + test_description='Test that adding/removing many notes triggers automatic fanout restructuring'
      
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    - test_expect_success setup '
    + path_has_fanout() {
     
    - ## t/t4207-log-decoration-colors.sh ##
    -@@ t/t4207-log-decoration-colors.sh: test_description='Test for "git log --decorate" colors'
    + ## t/t3408-rebase-multi-line.sh ##
    +@@ t/t3408-rebase-multi-line.sh: test_description='rebasing a commit with multi-line first paragraph.'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
      export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
    @@ t/t4207-log-decoration-colors.sh: test_description='Test for "git log --decorate
      
      test_expect_success setup '
     
    - ## t/t4212-log-corrupt.sh ##
    + ## t/t4027-diff-submodule.sh ##
     @@
      
    - test_description='git log with invalid commit headers'
    + test_description='difference in submodules'
      
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
    + . "$TEST_DIRECTORY"/lib-diff.sh
      
    - test_expect_success 'setup' '
     
    - ## t/t5313-pack-bounds-checks.sh ##
    + ## t/t4128-apply-root.sh ##
     @@
    - #!/bin/sh
      
    - test_description='bounds-checking of access to mmapped on-disk file formats'
    -+
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - clear_base () {
    -
    - ## t/t5322-pack-objects-sparse.sh ##
    -@@ t/t5322-pack-objects-sparse.sh: test_description='pack-objects object selection using sparse algorithm'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    - 
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - test_expect_success 'setup repo' '
    -
    - ## t/t5506-remote-groups.sh ##
    -@@ t/t5506-remote-groups.sh: test_description='git remote group handling'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + test_description='apply same filename'
      
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    - mark() {
    + test_expect_success 'setup' '
     
    - ## t/t5513-fetch-track.sh ##
    + ## t/t4212-log-corrupt.sh ##
     @@
      
    - test_description='fetch follows remote-tracking branches correctly'
    + test_description='git log with invalid commit headers'
      
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    - test_expect_success setup '
    + test_expect_success 'setup' '
     
      ## t/t5515-fetch-merge-logic.sh ##
     @@ t/t5515-fetch-merge-logic.sh: export GIT_TEST_PROTOCOL_VERSION
    @@ t/t5518-fetch-exit-status.sh: test_description='fetch exit status test'
      
      test_expect_success setup '
     
    - ## t/t5532-fetch-proxy.sh ##
    -@@
    - #!/bin/sh
    - 
    - test_description='fetching via git:// using core.gitproxy'
    -+
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - test_expect_success 'setup remote repo' '
    -
    - ## t/t5900-repo-selection.sh ##
    -@@
    - #!/bin/sh
    - 
    - test_description='selecting remote repo in ambiguous cases'
    -+
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - reset() {
    -
      ## t/t6002-rev-list-bisect.sh ##
     @@
      #
    @@ t/t6003-rev-list-topo-order.sh
      . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
      
     
    - ## t/t6018-rev-list-glob.sh ##
    -@@ t/t6018-rev-list-glob.sh: test_description='rev-list/rev-parse --glob'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + ## t/t6005-rev-list-count.sh ##
    +@@
    + 
    + test_description='git rev-list --max-count and --skip test'
      
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    - commit () {
    + test_expect_success 'setup' '
     
    - ## t/t6019-rev-list-ancestry-path.sh ##
    -@@ t/t6019-rev-list-ancestry-path.sh: test_description='--ancestry-path'
    + ## t/t6018-rev-list-glob.sh ##
    +@@ t/t6018-rev-list-glob.sh: test_description='rev-list/rev-parse --glob'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
      export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
     +TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
    - test_merge () {
    + commit () {
     
      ## t/t6100-rev-list-in-order.sh ##
     @@
    @@ t/t6100-rev-list-in-order.sh
      
      test_expect_success 'setup a commit history with trees, blobs' '
     
    - ## t/t6101-rev-parse-parents.sh ##
    -@@ t/t6101-rev-parse-parents.sh: test_description='Test git rev-parse with different parent options'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    - 
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - test_cmp_rev_output () {
    -
    - ## t/t6114-keep-packs.sh ##
    -@@
    - #!/bin/sh
    - 
    - test_description='rev-list with .keep packs'
    -+
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - test_expect_success 'setup' '
    -
    - ## t/t7702-repack-cyclic-alternate.sh ##
    -@@
    - #
    - 
    - test_description='repack involving cyclic alternate'
    -+
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - test_expect_success setup '
    -
      ## t/t9100-git-svn-basic.sh ##
     @@ t/t9100-git-svn-basic.sh: test_description='git svn basic tests'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    @@ t/t9106-git-svn-commit-diff-clobber.sh
      
      test_expect_success 'initialize repo' '
     
    + ## t/t9115-git-svn-dcommit-funky-renames.sh ##
    +@@
    + 
    + test_description='git svn dcommit can commit renames of files with ugly names'
    + 
    ++TEST_FAILS_SANITIZE_LEAK=true
    + . ./lib-git-svn.sh
    + 
    + test_expect_success 'load repository with strange names' '
    +
    + ## t/t9116-git-svn-log.sh ##
    +@@
    + #
    + 
    + test_description='git svn log tests'
    ++
    ++TEST_FAILS_SANITIZE_LEAK=true
    + . ./lib-git-svn.sh
    + 
    + test_expect_success 'setup repository and import' '
    +
      ## t/t9122-git-svn-author.sh ##
     @@
      #!/bin/sh
    @@ t/t9122-git-svn-author.sh
      
      test_expect_success 'setup svn repository' '
     
    - ## t/t9129-git-svn-i18n-commitencoding.sh ##
    + ## t/t9127-git-svn-partial-rebuild.sh ##
     @@
    + #
      
    - test_description='git svn honors i18n.commitEncoding in config'
    - 
    + test_description='git svn partial-rebuild tests'
    ++
     +TEST_FAILS_SANITIZE_LEAK=true
      . ./lib-git-svn.sh
      
    - compare_git_head_with () {
    + test_expect_success 'initialize svnrepo' '
     
    - ## t/t9139-git-svn-non-utf8-commitencoding.sh ##
    + ## t/t9129-git-svn-i18n-commitencoding.sh ##
     @@
      
    - test_description='git svn refuses to dcommit non-UTF8 messages'
    + test_description='git svn honors i18n.commitEncoding in config'
      
     +TEST_FAILS_SANITIZE_LEAK=true
      . ./lib-git-svn.sh
      
    - # ISO-2022-JP can pass for valid UTF-8, so skipping that in this test
    + compare_git_head_with () {
     
    - ## t/t9148-git-svn-propset.sh ##
    + ## t/t9132-git-svn-broken-symlink.sh ##
     @@
      
    - test_description='git svn propset tests'
    + test_description='test that git handles an svn repository with empty symlinks'
      
     +TEST_FAILS_SANITIZE_LEAK=true
      . ./lib-git-svn.sh
    - 
    - test_expect_success 'setup propset via import' '
    + test_expect_success 'load svn dumpfile' '
    + 	svnadmin load "$rawsvnrepo" <<EOF
     
    - ## t/t9151-svn-mergeinfo.sh ##
    + ## t/t9139-git-svn-non-utf8-commitencoding.sh ##
     @@
      
    - test_description='git-svn svn mergeinfo properties'
    + test_description='git svn refuses to dcommit non-UTF8 messages'
      
     +TEST_FAILS_SANITIZE_LEAK=true
      . ./lib-git-svn.sh
      
    - test_expect_success 'load svn dump' "
    + # ISO-2022-JP can pass for valid UTF-8, so skipping that in this test
     
    - ## t/t9157-git-svn-fetch-merge.sh ##
    + ## t/t9146-git-svn-empty-dirs.sh ##
     @@
    - #
    + # Copyright (c) 2009 Eric Wong
      
    - test_description='git svn merge detection'
    + test_description='git svn creates empty directories'
     +
     +TEST_FAILS_SANITIZE_LEAK=true
      . ./lib-git-svn.sh
      
    - svn_ver="$(svn --version --quiet)"
    + test_expect_success 'initialize repo' '
     
    - ## t/t9159-git-svn-no-parent-mergeinfo.sh ##
    + ## t/t9148-git-svn-propset.sh ##
     @@
    - #!/bin/sh
    - test_description='git svn handling of root commits in merge ranges'
    -+
    + 
    + test_description='git svn propset tests'
    + 
     +TEST_FAILS_SANITIZE_LEAK=true
      . ./lib-git-svn.sh
      
    - svn_ver="$(svn --version --quiet)"
    + test_expect_success 'setup propset via import' '
     
    - ## t/t9161-git-svn-mergeinfo-push.sh ##
    + ## t/t9151-svn-mergeinfo.sh ##
     @@
      
    - test_description='git-svn svn mergeinfo propagation'
    + test_description='git-svn svn mergeinfo properties'
      
     +TEST_FAILS_SANITIZE_LEAK=true
      . ./lib-git-svn.sh
      
      test_expect_success 'load svn dump' "
     
    + ## t/t9160-git-svn-preserve-empty-dirs.sh ##
    +@@ t/t9160-git-svn-preserve-empty-dirs.sh: This test uses git to clone a Subversion repository that contains empty
    + directories, and checks that corresponding directories are created in the
    + local Git repository with placeholder files.'
    + 
    ++TEST_FAILS_SANITIZE_LEAK=true
    + . ./lib-git-svn.sh
    + 
    + GIT_REPO=git-svn-repo
    +
      ## t/t9162-git-svn-dcommit-interactive.sh ##
     @@
      # Copyright (c) 2011 Frédéric Heitzmann
    @@ t/t9162-git-svn-dcommit-interactive.sh
      
      test_expect_success 'initialize repo' '
     
    - ## t/t9163-git-svn-reset-clears-caches.sh ##
    -@@ t/t9163-git-svn-reset-clears-caches.sh: test_description='git svn reset clears memoized caches'
    - GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    - 
    -+TEST_FAILS_SANITIZE_LEAK=true
    - . ./lib-git-svn.sh
    - 
    - svn_ver="$(svn --version --quiet)"
    -
    - ## t/t9165-git-svn-fetch-merge-branch-of-branch.sh ##
    + ## t/t9164-git-svn-dcommit-concurrent.sh ##
     @@
      #
      
    - test_description='git svn merge detection'
    + test_description='concurrent git svn dcommit'
     +
     +TEST_FAILS_SANITIZE_LEAK=true
      . ./lib-git-svn.sh
      
    - svn_ver="$(svn --version --quiet)"
    + 
     
    - ## t/t9166-git-svn-fetch-merge-branch-of-branch2.sh ##
    -@@
    - #
    + ## t/t9501-gitweb-standalone-http-status.sh ##
    +@@ t/t9501-gitweb-standalone-http-status.sh: code and message.'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
    - test_description='git svn merge detection'
    -+
    -+TEST_FAILS_SANITIZE_LEAK=true
    - . ./lib-git-svn.sh
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./lib-gitweb.sh
      
    - svn_ver="$(svn --version --quiet)"
    + #
 -:  ----------- > 19:  d5b7a8a690e revisions API: have release_revisions() release "filter"
18:  fc486e1bc46 ! 20:  857880bb4b6 revisions API: have release_revisions() release "grep_filter"
    @@ Commit message
         revisions API: have release_revisions() release "grep_filter"
     
         Extend the the release_revisions() function so that it frees the
    -    "grep_filter" in the "struct ref_info".
    +    "grep_filter" in the "struct ref_info".This allows us to mark a test
    +    as passing under "TEST_PASSES_SANITIZE_LEAK=true".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## revision.c ##
     @@ revision.c: void release_revisions(struct rev_info *revs)
    - 	object_array_clear(&revs->pending);
      	release_revisions_cmdline(&revs->cmdline);
    + 	list_objects_filter_release(&revs->filter);
      	release_revisions_mailmap(revs->mailmap);
     +	free_grep_patterns(&revs->grep_filter);
      }
      
      static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
    +
    + ## t/t9151-svn-mergeinfo.sh ##
    +@@
    + 
    + test_description='git-svn svn mergeinfo properties'
    + 
    +-TEST_FAILS_SANITIZE_LEAK=true
    + . ./lib-git-svn.sh
    + 
    + test_expect_success 'load svn dump' "
19:  b5948be0d4e ! 21:  f98d473f08e revisions API: have release_revisions() release "prune_data"
    @@ diff-lib.c: int do_diff_cache(const struct object_id *tree_oid, struct diff_opti
     
      ## revision.c ##
     @@ revision.c: void release_revisions(struct rev_info *revs)
    - 	release_revisions_commit_list(revs);
      	object_array_clear(&revs->pending);
      	release_revisions_cmdline(&revs->cmdline);
    + 	list_objects_filter_release(&revs->filter);
     +	clear_pathspec(&revs->prune_data);
      	release_revisions_mailmap(revs->mailmap);
      	free_grep_patterns(&revs->grep_filter);
20:  fa53e81c7c0 ! 22:  827430315fa revisions API: clear "boundary_commits" in release_revisions()
    @@ Commit message
         revisions API: clear "boundary_commits" in release_revisions()
     
         Clear the "boundary_commits" object_array in release_revisions(). This
    -    makes a *lot* of tests pass under SANITIZE=leak, including most of the
    -    t/t[0-9]*git-svn*.sh tests.
    +    makes a few more tests pass under SANITIZE=leak, including
    +    "t/t4126-apply-empty.sh" which started failed as an UNLEAK() in
    +    cmd_format_patch() was removed in a preceding commit.
     
    -    This includes the tests we had false-positive passes on before my
    -    6798b08e848 (perl Git.pm: don't ignore signalled failure in
    -    _cmd_close(), 2022-02-01), now they pass for real.
    -
    -    Since there are 66 tests matching t/t[0-9]*git-svn*.sh it's easier to
    -    list those that don't pass than to touch most of those 66. So let's
    -    introduce a "TEST_FAILS_SANITIZE_LEAK=true", which if set in the tests
    -    won't cause lib-git-svn.sh to set "TEST_PASSES_SANITIZE_LEAK=true.
    -
    -    This change also marks all the tests that we removed
    -    "TEST_FAILS_SANITIZE_LEAK=true" from in an earlier commit due to
    -    removing the UNLEAK() from cmd_format_patch(), we can now assert that
    -    its API use doesn't leak any "struct rev_info" memory.
    +    This also re-marks the various tests relying on "git format-patch" as
    +    passing under "SANITIZE=leak", in the preceding "revisions API users:
    +    use release_revisions() in builtin/log.c" commit those were marked as
    +    failing as we removed the UNLEAK(rev) from cmd_format_patch() in
    +    "builtin/log.c".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## revision.c ##
     @@ revision.c: void release_revisions(struct rev_info *revs)
    + 		return;
      	release_revisions_commit_list(revs);
      	object_array_clear(&revs->pending);
    - 	release_revisions_cmdline(&revs->cmdline);
     +	object_array_clear(&revs->boundary_commits);
    + 	release_revisions_cmdline(&revs->cmdline);
    + 	list_objects_filter_release(&revs->filter);
      	clear_pathspec(&revs->prune_data);
    - 	release_revisions_mailmap(revs->mailmap);
    - 	free_grep_patterns(&revs->grep_filter);
     
      ## t/t4021-format-patch-numbered.sh ##
     @@
    @@ t/t9001-send-email.sh: test_description='git send-email'
      . ./test-lib.sh
      
      # May be altered later in the test
    +
    + ## t/t9116-git-svn-log.sh ##
    +@@
    + 
    + test_description='git svn log tests'
    + 
    +-TEST_FAILS_SANITIZE_LEAK=true
    + . ./lib-git-svn.sh
    + 
    + test_expect_success 'setup repository and import' '
21:  ccf276641d6 ! 23:  c559b7d538b revisions API: release "reflog_info" in release revisions()
    @@ Commit message
     
      ## reflog-walk.c ##
     @@
    - #include "reflog-walk.h"
      
      struct complete_reflogs {
    --	char *ref;
    -+	const char *ref;
    - 	const char *short_ref;
    + 	char *ref;
    +-	const char *short_ref;
    ++	char *short_ref;
      	struct reflog_info {
      		struct object_id ooid, noid;
    + 		char *email;
     @@ reflog-walk.c: static void free_complete_reflog(struct complete_reflogs *array)
    - 		free(array->items[i].message);
      	}
      	free(array->items);
    --	free(array->ref);
    -+	free((char *)array->ref);
    -+	free((char *)array->short_ref);
    + 	free(array->ref);
    ++	free(array->short_ref);
      	free(array);
      }
      
22:  f387b9e744a ! 24:  c3a22f5b474 revisions API: call diff_free(&revs->pruning) in revisions_release()
    @@ Metadata
      ## Commit message ##
         revisions API: call diff_free(&revs->pruning) in revisions_release()
     
    -    Call diff_free() on the "pruning" member of "struct rev_info". We'll
    -    handle the "diffopt" member of the same type some other time, doing so
    -    will require us to untangle the "no_free" conditions I added in
    -    e900d494dcf (diff: add an API for deferred freeing, 2021-02-11).
    -
    -    Even without "diffopt" addressing leaks in "pruning" makes several
    -    tests pass under SANITIZE=leak.
    +    Call diff_free() on the "pruning" member of "struct rev_info".  Doing
    +    so makes several tests pass under SANITIZE=leak.
     
         This was also the last missing piece that allows us to remove the
         UNLEAK() in "cmd_diff" and "cmd_diff_index", which allows us to use
    @@ revision.c: void release_revisions(struct rev_info *revs)
      	clear_pathspec(&revs->prune_data);
      	release_revisions_mailmap(revs->mailmap);
      	free_grep_patterns(&revs->grep_filter);
    -+	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
     +	diff_free(&revs->pruning);
      	reflog_walk_info_release(revs->reflog_info);
      }
      
     
    - ## t/t2016-checkout-patch.sh ##
    -@@
    + ## t/t1001-read-tree-m-2way.sh ##
    +@@ t/t1001-read-tree-m-2way.sh: In the test, these paths are used:
    + 	yomin   - not in H or M
    + '
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY"/lib-read-tree.sh
      
    - test_description='git checkout --patch'
    +
    + ## t/t1002-read-tree-m-u-2way.sh ##
    +@@ t/t1002-read-tree-m-u-2way.sh: This is identical to t1001, but uses -u to update the work tree as well.
    + 
    + '
      
     +TEST_PASSES_SANITIZE_LEAK=true
    - . ./lib-patch-mode.sh
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY"/lib-read-tree.sh
    + 
    +
    + ## t/t2200-add-update.sh ##
    +@@ t/t2200-add-update.sh: only the updates to dir/sub.
    + Also tested are "git add -u" without limiting, and "git add -u"
    + without contents changes, and other conditions'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
      
    - test_expect_success PERL 'setup' '
    + test_expect_success setup '
     
      ## t/t4039-diff-assume-unchanged.sh ##
     @@
23:  fd457f0d85c ! 25:  dabbb430ece revisions API: have release_revisions() release "date_mode"
    @@ Commit message
      ## revision.c ##
     @@ revision.c: void release_revisions(struct rev_info *revs)
      	release_revisions_cmdline(&revs->cmdline);
    - 	object_array_clear(&revs->boundary_commits);
    + 	list_objects_filter_release(&revs->filter);
      	clear_pathspec(&revs->prune_data);
     +	date_mode_release(&revs->date_mode);
      	release_revisions_mailmap(revs->mailmap);
      	free_grep_patterns(&revs->grep_filter);
    - 	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
    + 	diff_free(&revs->pruning);
24:  e02a097b884 ! 26:  644d1b54afe revisions API: have release_revisions() release "topo_walk_info"
    @@ revision.c: static void release_revisions_mailmap(struct string_list *mailmap)
      {
      	if (!revs)
     @@ revision.c: void release_revisions(struct rev_info *revs)
    - 	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
    + 	free_grep_patterns(&revs->grep_filter);
      	diff_free(&revs->pruning);
      	reflog_walk_info_release(revs->reflog_info);
     +	release_revisions_topo_walk_info(revs->topo_walk_info);
    @@ revision.c: static void compute_indegrees_to_depth(struct rev_info *revs,
      	clear_author_date_slab(&info->author_date);
     +	free(info);
     +}
    -+
    -+static void reset_topo_walk(struct rev_info *revs)
    -+{
    -+	struct topo_walk_info *info = revs->topo_walk_info;
      
     -	FREE_AND_NULL(revs->topo_walk_info);
    -+	release_revisions_topo_walk_info(info);
    ++static void reset_topo_walk(struct rev_info *revs)
    ++{
    ++	release_revisions_topo_walk_info(revs->topo_walk_info);
     +	revs->topo_walk_info = NULL;
      }
      
13:  d18bfa5691f ! 27:  2a4d50a0ec8 revisions API users: use release_revisions() in wt-status.c edge case
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    revisions API users: use release_revisions() in wt-status.c edge case
    +    revisions API: add a TODO for diff_free(&revs->diffopt)
     
    -    Use release_revisions() for the "struct rev_info" in
    -    has_unstaged_changes() which didn't require the addition of a "goto"
    -    pattern, but needed us to refactor another "return fn(...)" pattern.
    +    Add a TODO comment indicating that we should release "diffopt" in
    +    release_revisions(). In a preceding commit we started releasing the
    +    "pruning" member of the same type, but handling "diffopt" will require
    +    us to untangle the "no_free" conditions I added in e900d494dcf (diff:
    +    add an API for deferred freeing, 2021-02-11).
     
    -    This change is split from preceding changes to make similar
    -    conversions in those commits easier to review, as they are all
    -    repetitions of the same pattern.
    +    Let's leave a TODO comment to that effect, and so that we don't forget
    +    refactor code that was changed to use release_revisions() in earlier
    +    commits to stop using the "diffopt" member after a call to
    +    release_revisions(). This works currently, but would become a logic
    +    error as soon as we started freeing "diffopt". Doing that change now
    +    doesn't harm anything, and future-proofs us against a later change to
    +    release_revisions().
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## diff-lib.c ##
    +@@ diff-lib.c: int index_differs_from(struct repository *r,
    + {
    + 	struct rev_info rev;
    + 	struct setup_revision_opt opt;
    ++	unsigned has_changes;
    + 
    + 	repo_init_revisions(r, &rev, NULL);
    + 	memset(&opt, 0, sizeof(opt));
    +@@ diff-lib.c: int index_differs_from(struct repository *r,
    + 		diff_flags_or(&rev.diffopt.flags, flags);
    + 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
    + 	run_diff_index(&rev, 1);
    ++	has_changes = rev.diffopt.flags.has_changes;
    + 	release_revisions(&rev);
    +-	return (rev.diffopt.flags.has_changes != 0);
    ++	return (has_changes != 0);
    + }
    + 
    + static struct strbuf *idiff_prefix_cb(struct diff_options *opt, void *data)
    +
    + ## revision.c ##
    +@@ revision.c: void release_revisions(struct rev_info *revs)
    + 	date_mode_release(&revs->date_mode);
    + 	release_revisions_mailmap(revs->mailmap);
    + 	free_grep_patterns(&revs->grep_filter);
    ++	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
    + 	diff_free(&revs->pruning);
    + 	reflog_walk_info_release(revs->reflog_info);
    + 	release_revisions_topo_walk_info(revs->topo_walk_info);
    +
      ## wt-status.c ##
     @@ wt-status.c: int has_unstaged_changes(struct repository *r, int ignore_submodules)
      	rev_info.diffopt.flags.quick = 1;
      	diff_setup_done(&rev_info.diffopt);
      	result = run_diff_files(&rev_info, 0);
    ++	result = diff_result_code(&rev_info.diffopt, result);
    + 	release_revisions(&rev_info);
     -	return diff_result_code(&rev_info.diffopt, result);
    ++	return result;
    + }
    + 
    + /**
    +@@ wt-status.c: int has_uncommitted_changes(struct repository *r,
    + 
    + 	diff_setup_done(&rev_info.diffopt);
    + 	result = run_diff_index(&rev_info, 1);
     +	result = diff_result_code(&rev_info.diffopt, result);
    -+	release_revisions(&rev_info);
    + 	release_revisions(&rev_info);
    +-	return diff_result_code(&rev_info.diffopt, result);
     +	return result;
      }
      
-- 
2.35.1.1452.ga7cfc89151f

