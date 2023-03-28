Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C383C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjC1N7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjC1N71 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E3413A
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u1so6995241wmn.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/E4mJhSaRKZKY3C8z44DLKQBaQwDQrzWpG8wH7god0=;
        b=XMNn7gpH87jTgaofhWu23eTrZmeY07s+mu+SoSittPot05s1m+wkgcGSJudXHPVr5r
         dEogFoypwrb2gE0uKj53I3OLtEJrWFAAZLjzlFuLC+kC+kFya/Sv/HvMoJZEHjv4m1bC
         1S/3RFHEXC0L+gX1p8wstU29Iy7wfjgv6Pfp9gE36Pq/Mi53QX9HGg0x+Ijc8j2RsLji
         rgckCDvGtnrQEgGtUbZfHxNCq4BLBm1A0Colg4JOTZHWvRwdV9hFIhbcSYw+eNI8h8hI
         2oHZlLbgyC6jMBiL+1v3Cp5G2/RP8/znedNVh5N3rxR0mmsOuNolkhSjG4TRbpNtmvAr
         YUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/E4mJhSaRKZKY3C8z44DLKQBaQwDQrzWpG8wH7god0=;
        b=lKbY7PNmt+lAfz9EjjB+Xlr9OFX7gs7b0hSqnDLJ9FKsOxvlQ5YyoaLfW8u8ZiUAUF
         HGMZ2jPbcCxUNv0/0bMtafrcIKpXVQVun344KGsg+Dc40gDp8eHQm4g7yBhQzsM6Ao/a
         fzHJt7Cpv851LgrAVg43dcsVZqGBCuxPjDinLF3Y3PUsTXnCf3d0sOTSAlgiKbC+Rp7N
         KiT+nA/7/3hIlhF5bay9Snrvv44v4kJQ0rdFOg2r5L3NmHZcWmAQrGTliuUqyV0QuT5w
         tP7CuiUamMlJsYEqliZ3eO8ec3LqLp+lgXOGgq/qEn54qrFh6yjvHFQJHS4voIDfPqRs
         Vdew==
X-Gm-Message-State: AO0yUKWn8TFWFKe/zG8HlceXR7umLgIz/OVlj5ppDDUSI5rd7Gqp4zUA
        juPeA8ZSX4y2A3fJDcJ7tD/mUf7i+dDi0g==
X-Google-Smtp-Source: AK7set9hnOsoXWYA7JLWCyjcORjvWDAlAhUY3SBzfUTYD3qw8d66qsQ1OXlJLEbgwfESs/alhIus4g==
X-Received: by 2002:a7b:c4cb:0:b0:3ed:253c:621b with SMTP id g11-20020a7bc4cb000000b003ed253c621bmr14265357wmk.21.1680011953922;
        Tue, 28 Mar 2023 06:59:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/17] cocci: apply the "cache.h" part of "the_repository.pending"
Date:   Tue, 28 Mar 2023 15:58:46 +0200
Message-Id: <patch-v2-05.17-3e721fa5db0-20230328T110946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"cache.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-patch.c                                   |  2 +-
 apply.c                                       |  4 +-
 archive.c                                     |  2 +-
 branch.c                                      |  2 +-
 builtin/am.c                                  | 16 +++---
 builtin/bisect.c                              | 19 +++----
 builtin/blame.c                               |  9 ++--
 builtin/branch.c                              |  2 +-
 builtin/checkout.c                            | 16 +++---
 builtin/commit-tree.c                         |  4 +-
 builtin/commit.c                              |  8 +--
 builtin/describe.c                            |  5 +-
 builtin/fast-import.c                         |  8 +--
 builtin/fetch.c                               |  2 +-
 builtin/fsck.c                                |  2 +-
 builtin/log.c                                 |  8 +--
 builtin/ls-files.c                            |  4 +-
 builtin/ls-tree.c                             |  9 ++--
 builtin/merge-base.c                          |  4 +-
 builtin/merge-recursive.c                     |  6 +--
 builtin/merge.c                               | 10 ++--
 builtin/name-rev.c                            |  7 +--
 builtin/notes.c                               | 22 ++++----
 builtin/prune.c                               |  2 +-
 builtin/pull.c                                |  4 +-
 builtin/range-diff.c                          | 12 ++---
 builtin/read-tree.c                           |  2 +-
 builtin/rebase.c                              | 12 +++--
 builtin/receive-pack.c                        | 10 ++--
 builtin/replace.c                             | 16 +++---
 builtin/reset.c                               | 19 +++----
 builtin/rev-list.c                            |  2 +-
 builtin/rev-parse.c                           | 12 +++--
 builtin/rm.c                                  |  2 +-
 builtin/show-branch.c                         | 12 ++---
 builtin/show-ref.c                            |  4 +-
 builtin/sparse-checkout.c                     |  2 +-
 builtin/stash.c                               | 13 ++---
 builtin/submodule--helper.c                   |  4 +-
 builtin/tag.c                                 |  6 +--
 builtin/unpack-file.c                         |  2 +-
 builtin/update-ref.c                          |  8 +--
 builtin/verify-commit.c                       |  2 +-
 builtin/verify-tag.c                          |  2 +-
 builtin/worktree.c                            |  8 +--
 cache.h                                       | 15 ------
 checkout.c                                    |  2 +-
 combine-diff.c                                |  6 +--
 commit.c                                      | 10 ++--
 contrib/coccinelle/the_repository.cocci       | 44 ++++++++++++++++
 .../coccinelle/the_repository.pending.cocci   | 37 --------------
 diff-lib.c                                    |  2 +-
 diff.c                                        |  4 +-
 fmt-merge-msg.c                               |  4 +-
 log-tree.c                                    | 15 +++---
 mailmap.c                                     |  2 +-
 notes-merge.c                                 |  2 +-
 notes.c                                       |  6 +--
 object-name.c                                 |  5 +-
 parse-options-cb.c                            |  8 +--
 range-diff.c                                  |  8 +--
 read-cache.c                                  |  2 +-
 rebase-interactive.c                          |  2 +-
 ref-filter.c                                  |  8 +--
 remote.c                                      |  6 +--
 reset.c                                       |  4 +-
 revision.c                                    | 11 ++--
 sequencer.c                                   | 51 ++++++++++---------
 submodule-config.c                            |  2 +-
 submodule.c                                   |  8 +--
 t/helper/test-fast-rebase.c                   | 10 ++--
 t/helper/test-match-trees.c                   |  4 +-
 t/helper/test-oidmap.c                        |  6 +--
 t/helper/test-reach.c                         |  2 +-
 t/helper/test-submodule-config.c              |  2 +-
 tag.c                                         |  4 +-
 transport-helper.c                            |  2 +-
 transport.c                                   |  3 +-
 wt-status.c                                   | 18 +++----
 79 files changed, 332 insertions(+), 310 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.cocci

diff --git a/add-patch.c b/add-patch.c
index e6c34b9c381..6a32b49b29c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -415,7 +415,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		strvec_push(&args,
 			    /* could be on an unborn branch */
 			    !strcmp("HEAD", s->revision) &&
-			    get_oid("HEAD", &oid) ?
+			    repo_get_oid(the_repository, "HEAD", &oid) ?
 			    empty_tree_oid_hex() : s->revision);
 	}
 	color_arg_index = args.nr;
diff --git a/apply.c b/apply.c
index 8776ab939ad..ed6abc7722f 100644
--- a/apply.c
+++ b/apply.c
@@ -3612,7 +3612,7 @@ static int try_threeway(struct apply_state *state,
 	/* Preimage the patch was prepared for */
 	if (patch->is_new)
 		write_object_file("", 0, OBJ_BLOB, &pre_oid);
-	else if (get_oid(patch->old_oid_prefix, &pre_oid) ||
+	else if (repo_get_oid(the_repository, patch->old_oid_prefix, &pre_oid) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
 		return error(_("repository lacks the necessary blob to perform 3-way merge."));
 
@@ -4129,7 +4129,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			else
 				return error(_("sha1 information is lacking or "
 					       "useless for submodule %s"), name);
-		} else if (!get_oid_blob(patch->old_oid_prefix, &oid)) {
+		} else if (!repo_get_oid_blob(the_repository, patch->old_oid_prefix, &oid)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
diff --git a/archive.c b/archive.c
index 1c2ca78e52a..cb7ca69cce1 100644
--- a/archive.c
+++ b/archive.c
@@ -463,7 +463,7 @@ static void parse_treeish_arg(const char **argv,
 		dwim_ref(name, strlen(name), &oid, &ref, 0);
 	}
 
-	if (get_oid(name, &oid))
+	if (repo_get_oid(the_repository, name, &oid))
 		die(_("not a valid object name: %s"), name);
 
 	commit = lookup_commit_reference_gently(ar_args->repo, &oid, 1);
diff --git a/branch.c b/branch.c
index eacef62b7c9..efea29af1ac 100644
--- a/branch.c
+++ b/branch.c
@@ -532,7 +532,7 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 		explicit_tracking = 1;
 
 	real_ref = NULL;
-	if (get_oid_mb(start_name, &oid)) {
+	if (repo_get_oid_mb(the_repository, start_name, &oid)) {
 		if (explicit_tracking) {
 			int code = die_message(_(upstream_missing), start_name);
 			advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
diff --git a/builtin/am.c b/builtin/am.c
index 5e6b237c424..775beac2a92 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1067,7 +1067,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	else
 		write_state_text(state, "applying", "");
 
-	if (!get_oid("HEAD", &curr_head)) {
+	if (!repo_get_oid(the_repository, "HEAD", &curr_head)) {
 		write_state_text(state, "abort-safety", oid_to_hex(&curr_head));
 		if (!state->rebasing)
 			update_ref("am", "ORIG_HEAD", &curr_head, NULL, 0,
@@ -1110,7 +1110,7 @@ static void am_next(struct am_state *state)
 	unlink(am_path(state, "original-commit"));
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
-	if (!get_oid("HEAD", &head))
+	if (!repo_get_oid(the_repository, "HEAD", &head))
 		write_state_text(state, "abort-safety", oid_to_hex(&head));
 	else
 		write_state_text(state, "abort-safety", "");
@@ -1403,7 +1403,7 @@ static void write_index_patch(const struct am_state *state)
 	struct rev_info rev_info;
 	FILE *fp;
 
-	if (!get_oid("HEAD", &head)) {
+	if (!repo_get_oid(the_repository, "HEAD", &head)) {
 		struct commit *commit = lookup_commit_or_die(&head, "HEAD");
 		tree = get_commit_tree(commit);
 	} else
@@ -1557,7 +1557,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	struct commit *result;
 	char *their_tree_name;
 
-	if (get_oid("HEAD", &our_tree) < 0)
+	if (repo_get_oid(the_repository, "HEAD", &our_tree) < 0)
 		oidcpy(&our_tree, the_hash_algo->empty_tree);
 
 	if (build_fake_ancestor(state, index_path))
@@ -1647,7 +1647,7 @@ static void do_commit(const struct am_state *state)
 	if (write_index_as_tree(&tree, &the_index, get_index_file(), 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
-	if (!get_oid_commit("HEAD", &parent)) {
+	if (!repo_get_oid_commit(the_repository, "HEAD", &parent)) {
 		old_oid = &parent;
 		commit_list_insert(lookup_commit(the_repository, &parent),
 				   &parents);
@@ -2089,7 +2089,7 @@ static void am_skip(struct am_state *state)
 
 	am_rerere_clear();
 
-	if (get_oid("HEAD", &head))
+	if (repo_get_oid(the_repository, "HEAD", &head))
 		oidcpy(&head, the_hash_algo->empty_tree);
 
 	if (clean_index(&head, &head))
@@ -2131,7 +2131,7 @@ static int safe_to_abort(const struct am_state *state)
 		oidclr(&abort_safety);
 	strbuf_release(&sb);
 
-	if (get_oid("HEAD", &head))
+	if (repo_get_oid(the_repository, "HEAD", &head))
 		oidclr(&head);
 
 	if (oideq(&head, &abort_safety))
@@ -2164,7 +2164,7 @@ static void am_abort(struct am_state *state)
 	if (!has_curr_head)
 		oidcpy(&curr_head, the_hash_algo->empty_tree);
 
-	has_orig_head = !get_oid("ORIG_HEAD", &orig_head);
+	has_orig_head = !repo_get_oid(the_repository, "ORIG_HEAD", &orig_head);
 	if (!has_orig_head)
 		oidcpy(&orig_head, the_hash_algo->empty_tree);
 
diff --git a/builtin/bisect.c b/builtin/bisect.c
index c64c8d715a5..f925ceeb3c0 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -236,7 +236,7 @@ static int bisect_reset(const char *commit)
 	} else {
 		struct object_id oid;
 
-		if (get_oid_commit(commit, &oid))
+		if (repo_get_oid_commit(the_repository, commit, &oid))
 			return error(_("'%s' is not a valid commit"), commit);
 		strbuf_addstr(&branch, commit);
 	}
@@ -294,7 +294,7 @@ static int bisect_write(const char *state, const char *rev,
 		goto finish;
 	}
 
-	if (get_oid(rev, &oid)) {
+	if (repo_get_oid(the_repository, rev, &oid)) {
 		res = error(_("couldn't get the oid of the rev '%s'"), rev);
 		goto finish;
 	}
@@ -777,7 +777,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	 */
 	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &flags);
 	if (!head)
-		if (get_oid("HEAD", &head_oid))
+		if (repo_get_oid(the_repository, "HEAD", &head_oid))
 			return error(_("bad HEAD - I need a HEAD"));
 
 	/*
@@ -803,11 +803,11 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 		}
 	} else {
 		/* Get the rev from where we start. */
-		if (!get_oid(head, &head_oid) &&
+		if (!repo_get_oid(the_repository, head, &head_oid) &&
 		    !starts_with(head, "refs/heads/")) {
 			strbuf_reset(&start_head);
 			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
-		} else if (!get_oid(head, &head_oid) &&
+		} else if (!repo_get_oid(the_repository, head, &head_oid) &&
 			   skip_prefix(head, "refs/heads/", &head)) {
 			strbuf_addstr(&start_head, head);
 		} else {
@@ -830,7 +830,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 		write_file(git_path_bisect_first_parent(), "\n");
 
 	if (no_checkout) {
-		if (get_oid(start_head.buf, &oid) < 0) {
+		if (repo_get_oid(the_repository, start_head.buf, &oid) < 0) {
 			res = error(_("invalid ref: '%s'"), start_head.buf);
 			goto finish;
 		}
@@ -935,11 +935,12 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
 
 	if (argc == 0) {
 		const char *head = "BISECT_HEAD";
-		enum get_oid_result res_head = get_oid(head, &oid);
+		enum get_oid_result res_head = repo_get_oid(the_repository,
+							    head, &oid);
 
 		if (res_head == MISSING_OBJECT) {
 			head = "HEAD";
-			res_head = get_oid(head, &oid);
+			res_head = repo_get_oid(the_repository, head, &oid);
 		}
 
 		if (res_head)
@@ -955,7 +956,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
 	for (; argc; argc--, argv++) {
 		struct commit *commit;
 
-		if (get_oid(*argv, &oid)){
+		if (repo_get_oid(the_repository, *argv, &oid)){
 			error(_("Bad rev input: %s"), *argv);
 			oid_array_clear(&revs);
 			return BISECT_FAILED;
diff --git a/builtin/blame.c b/builtin/blame.c
index fdd9f0c0fc7..6c266019ebb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -603,8 +603,9 @@ static int read_ancestry(const char *graft_file)
 
 static int update_auto_abbrev(int auto_abbrev, struct blame_origin *suspect)
 {
-	const char *uniq = find_unique_abbrev(&suspect->commit->object.oid,
-					      auto_abbrev);
+	const char *uniq = repo_find_unique_abbrev(the_repository,
+						   &suspect->commit->object.oid,
+						   auto_abbrev);
 	int len = strlen(uniq);
 	if (auto_abbrev < len)
 		return len;
@@ -804,7 +805,7 @@ static int is_a_rev(const char *name)
 {
 	struct object_id oid;
 
-	if (get_oid(name, &oid))
+	if (repo_get_oid(the_repository, name, &oid))
 		return 0;
 	return OBJ_NONE < oid_object_info(the_repository, &oid, NULL);
 }
@@ -847,7 +848,7 @@ static void build_ignorelist(struct blame_scoreboard *sb,
 						    peel_to_commit_oid, sb);
 	}
 	for_each_string_list_item(i, ignore_rev_list) {
-		if (get_oid_committish(i->string, &oid) ||
+		if (repo_get_oid_committish(the_repository, i->string, &oid) ||
 		    peel_to_commit_oid(&oid, sb))
 			die(_("cannot find revision %s to ignore"), i->string);
 		oidset_insert(&sb->ignore_list, &oid);
diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb9..968ea03c059 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -280,7 +280,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		item = string_list_append(&refs_to_delete, name);
 		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
 				    : (flags & REF_ISSYMREF) ? target
-				    : find_unique_abbrev(&oid, DEFAULT_ABBREV));
+				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
 
 	next:
 		free(target);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 734d730980c..18f3fc76ced 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -433,8 +433,8 @@ static int checkout_worktree(const struct checkout_opts *opts,
 					      "Updated %d paths from %s",
 					      nr_checkouts),
 				   nr_checkouts,
-				   find_unique_abbrev(&opts->source_tree->object.oid,
-						      DEFAULT_ABBREV));
+				   repo_find_unique_abbrev(the_repository, &opts->source_tree->object.oid,
+							   DEFAULT_ABBREV));
 		else if (!nr_unmerged || nr_checkouts)
 			fprintf_ln(stderr, Q_("Updated %d path from the index",
 					      "Updated %d paths from the index",
@@ -658,10 +658,12 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
 	if (print_sha1_ellipsis()) {
 		fprintf(stderr, "%s %s... %s\n", msg,
-			find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV), sb.buf);
+			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV),
+			sb.buf);
 	} else {
 		fprintf(stderr, "%s %s %s\n", msg,
-			find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV), sb.buf);
+			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV),
+			sb.buf);
 	}
 	strbuf_release(&sb);
 }
@@ -1074,7 +1076,7 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 			" git branch <new-branch-name> %s\n\n",
 			/* Give ngettext() the count */
 			lost),
-			find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV));
+			repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
 }
 
 /*
@@ -1336,7 +1338,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
 
-	if (get_oid_mb(arg, rev)) {
+	if (repo_get_oid_mb(the_repository, arg, rev)) {
 		/*
 		 * Either case (3) or (4), with <something> not being
 		 * a commit, or an attempt to use case (1) with an
@@ -1762,7 +1764,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	} else if (!opts->accept_ref && opts->from_treeish) {
 		struct object_id rev;
 
-		if (get_oid_mb(opts->from_treeish, &rev))
+		if (repo_get_oid_mb(the_repository, opts->from_treeish, &rev))
 			die(_("could not resolve %s"), opts->from_treeish);
 
 		setup_new_branch_info_and_source_tree(new_branch_info,
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index e805da5bb1c..b046c193067 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -46,7 +46,7 @@ static int parse_parent_arg_callback(const struct option *opt,
 
 	BUG_ON_OPT_NEG_NOARG(unset, arg);
 
-	if (get_oid_commit(arg, &oid))
+	if (repo_get_oid_commit(the_repository, arg, &oid))
 		die(_("not a valid object name %s"), arg);
 
 	assert_oid_type(&oid, OBJ_COMMIT);
@@ -124,7 +124,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		die(_("must give exactly one tree"));
 
-	if (get_oid_tree(argv[0], &tree_oid))
+	if (repo_get_oid_tree(the_repository, argv[0], &tree_oid))
 		die(_("not a valid object name %s"), argv[0]);
 
 	if (!buffer.len) {
diff --git a/builtin/commit.c b/builtin/commit.c
index f71ed41bf59..95bca976a58 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -557,7 +557,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->index_file = index_file;
 	s->fp = fp;
 	s->nowarn = nowarn;
-	s->is_initial = get_oid(s->reference, &oid) ? 1 : 0;
+	s->is_initial = repo_get_oid(the_repository, s->reference, &oid) ? 1 : 0;
 	if (!s->is_initial)
 		oidcpy(&s->oid_commit, &oid);
 	s->status_format = status_format;
@@ -1000,7 +1000,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (amend)
 			parent = "HEAD^1";
 
-		if (get_oid(parent, &oid)) {
+		if (repo_get_oid(the_repository, parent, &oid)) {
 			int i, ita_nr = 0;
 
 			/* TODO: audit for interaction with sparse-index. */
@@ -1567,7 +1567,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	else
 		fd = -1;
 
-	s.is_initial = get_oid(s.reference, &oid) ? 1 : 0;
+	s.is_initial = repo_get_oid(the_repository, s.reference, &oid) ? 1 : 0;
 	if (!s.is_initial)
 		oidcpy(&s.oid_commit, &oid);
 
@@ -1710,7 +1710,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
-	if (get_oid("HEAD", &oid))
+	if (repo_get_oid(the_repository, "HEAD", &oid))
 		current_head = NULL;
 	else {
 		current_head = lookup_commit_or_die(&oid, "HEAD");
diff --git a/builtin/describe.c b/builtin/describe.c
index 5b5930f5c8c..de3743e803a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -299,7 +299,8 @@ static void append_name(struct commit_name *n, struct strbuf *dst)
 
 static void append_suffix(int depth, const struct object_id *oid, struct strbuf *dst)
 {
-	strbuf_addf(dst, "-%d-g%s", depth, find_unique_abbrev(oid, abbrev));
+	strbuf_addf(dst, "-%d-g%s", depth,
+		    repo_find_unique_abbrev(the_repository, oid, abbrev));
 }
 
 static void describe_commit(struct object_id *oid, struct strbuf *dst)
@@ -532,7 +533,7 @@ static void describe(const char *arg, int last_one)
 	if (debug)
 		fprintf(stderr, _("describe %s\n"), arg);
 
-	if (get_oid(arg, &oid))
+	if (repo_get_oid(the_repository, arg, &oid))
 		die(_("Not a valid object name %s"), arg);
 	cmit = lookup_commit_reference_gently(the_repository, &oid, 1);
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index f7548ff4a35..7faedc9aa44 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2487,7 +2487,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		if (commit_oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
-	} else if (!get_oid(p, &commit_oid)) {
+	} else if (!repo_get_oid(the_repository, p, &commit_oid)) {
 		unsigned long size;
 		char *buf = read_object_with_reference(the_repository,
 						       &commit_oid,
@@ -2600,7 +2600,7 @@ static int parse_objectish(struct branch *b, const char *objectish)
 			} else
 				parse_from_existing(b);
 		}
-	} else if (!get_oid(objectish, &b->oid)) {
+	} else if (!repo_get_oid(the_repository, objectish, &b->oid)) {
 		parse_from_existing(b);
 		if (is_null_oid(&b->oid))
 			b->delete = 1;
@@ -2655,7 +2655,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			oidcpy(&n->oid, &oe->idx.oid);
-		} else if (!get_oid(from, &n->oid)) {
+		} else if (!repo_get_oid(the_repository, from, &n->oid)) {
 			unsigned long size;
 			char *buf = read_object_with_reference(the_repository,
 							       &n->oid,
@@ -2828,7 +2828,7 @@ static void parse_new_tag(const char *arg)
 		oe = find_mark(marks, from_mark);
 		type = oe->type;
 		oidcpy(&oid, &oe->idx.oid);
-	} else if (!get_oid(from, &oid)) {
+	} else if (!repo_get_oid(the_repository, from, &oid)) {
 		struct object_entry *oe = find_object(&oid);
 		if (!oe) {
 			type = oid_object_info(the_repository, &oid, NULL);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7221e57f352..6bab662829f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1490,7 +1490,7 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 		int old_nr;
 		if (!has_glob_specials(s)) {
 			struct object_id oid;
-			if (get_oid(s, &oid))
+			if (repo_get_oid(the_repository, s, &oid))
 				die(_("%s is not a valid object"), s);
 			if (!has_object(the_repository, &oid, 0))
 				die(_("the object %s does not exist"), s);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index c4a633c0329..4537d9f0f22 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -959,7 +959,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		struct object_id oid;
-		if (!get_oid(arg, &oid)) {
+		if (!repo_get_oid(the_repository, arg, &oid)) {
 			struct object *obj = lookup_object(the_repository,
 							   &oid);
 
diff --git a/builtin/log.c b/builtin/log.c
index 4693385e8ed..1e7bbedf5d2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1656,7 +1656,7 @@ static struct commit *get_base_commit(const char *base_commit,
 			struct commit *commit;
 			struct object_id oid;
 
-			if (get_oid(upstream, &oid)) {
+			if (repo_get_oid(the_repository, upstream, &oid)) {
 				if (die_on_failure)
 					die(_("failed to resolve '%s' as a valid ref"), upstream);
 				else
@@ -2414,7 +2414,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 {
 	struct object_id oid;
-	if (get_oid(arg, &oid) == 0) {
+	if (repo_get_oid(the_repository, arg, &oid) == 0) {
 		struct commit *commit = lookup_commit_reference(the_repository,
 								&oid);
 		if (commit) {
@@ -2436,12 +2436,12 @@ static void print_commit(char sign, struct commit *commit, int verbose,
 {
 	if (!verbose) {
 		fprintf(file, "%c %s\n", sign,
-		       find_unique_abbrev(&commit->object.oid, abbrev));
+		       repo_find_unique_abbrev(the_repository, &commit->object.oid, abbrev));
 	} else {
 		struct strbuf buf = STRBUF_INIT;
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
 		fprintf(file, "%c %s %s\n", sign,
-		       find_unique_abbrev(&commit->object.oid, abbrev),
+		       repo_find_unique_abbrev(the_repository, &commit->object.oid, abbrev),
 		       buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 26e309f533a..7fc82d7f760 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -363,7 +363,7 @@ static void show_ru_info(struct index_state *istate)
 			if (!ui->mode[i])
 				continue;
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
-			       find_unique_abbrev(&ui->oid[i], abbrev),
+			       repo_find_unique_abbrev(the_repository, &ui->oid[i], abbrev),
 			       i + 1);
 			write_name(path);
 		}
@@ -578,7 +578,7 @@ void overlay_tree_on_index(struct index_state *istate,
 	read_tree_fn_t fn = NULL;
 	int err;
 
-	if (get_oid(tree_name, &oid))
+	if (repo_get_oid(the_repository, tree_name, &oid))
 		die("tree-ish %s not found.", tree_name);
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 64d8e54318c..568088b6d66 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -229,7 +229,7 @@ static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 		return early;
 
 	printf("%06o %s %s\t", mode, type_name(object_type(mode)),
-	       find_unique_abbrev(oid, options->abbrev));
+	       repo_find_unique_abbrev(the_repository, oid, options->abbrev));
 	show_tree_common_default_long(options, base, pathname, base->len);
 	return recurse;
 }
@@ -260,7 +260,8 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 	}
 
 	printf("%06o %s %s %7s\t", mode, type_name(type),
-	       find_unique_abbrev(oid, options->abbrev), size_text);
+	       repo_find_unique_abbrev(the_repository, oid, options->abbrev),
+	       size_text);
 	show_tree_common_default_long(options, base, pathname, base->len);
 	return recurse;
 }
@@ -311,7 +312,7 @@ static int show_tree_object(const struct object_id *oid, struct strbuf *base,
 	if (early >= 0)
 		return early;
 
-	str = find_unique_abbrev(oid, options->abbrev);
+	str = repo_find_unique_abbrev(the_repository, oid, options->abbrev);
 	if (options->null_termination) {
 		fputs(str, stdout);
 		fputc('\0', stdout);
@@ -434,7 +435,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			ls_tree_usage, ls_tree_options);
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
-	if (get_oid(argv[0], &oid))
+	if (repo_get_oid(the_repository, argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
 	/*
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index be8f3b221c9..5b0ed0d2738 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -43,7 +43,7 @@ static struct commit *get_commit_reference(const char *arg)
 	struct object_id revkey;
 	struct commit *r;
 
-	if (get_oid(arg, &revkey))
+	if (repo_get_oid(the_repository, arg, &revkey))
 		die("Not a valid object name %s", arg);
 	r = lookup_commit_reference(the_repository, &revkey);
 	if (!r)
@@ -119,7 +119,7 @@ static int handle_fork_point(int argc, const char **argv)
 	const char *commitname;
 
 	commitname = (argc == 2) ? argv[1] : "HEAD";
-	if (get_oid(commitname, &oid))
+	if (repo_get_oid(the_repository, commitname, &oid))
 		die("Not a valid object name: '%s'", commitname);
 
 	derived = lookup_commit_reference(the_repository, &oid);
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index b9acbf5d342..a50b328d943 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -49,7 +49,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		}
 		if (bases_count < ARRAY_SIZE(bases)-1) {
 			struct object_id *oid = xmalloc(sizeof(struct object_id));
-			if (get_oid(argv[i], oid))
+			if (repo_get_oid(the_repository, argv[i], oid))
 				die(_("could not parse object '%s'"), argv[i]);
 			bases[bases_count++] = oid;
 		}
@@ -70,9 +70,9 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	o.branch1 = argv[++i];
 	o.branch2 = argv[++i];
 
-	if (get_oid(o.branch1, &h1))
+	if (repo_get_oid(the_repository, o.branch1, &h1))
 		die(_("could not resolve ref '%s'"), o.branch1);
-	if (get_oid(o.branch2, &h2))
+	if (repo_get_oid(the_repository, o.branch2, &h2))
 		die(_("could not resolve ref '%s'"), o.branch2);
 
 	o.branch1 = better1 = better_branch_name(o.branch1);
diff --git a/builtin/merge.c b/builtin/merge.c
index 19c31d4ff48..6a0519c39db 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -339,7 +339,7 @@ static int save_state(struct object_id *stash)
 	else if (!len)		/* no changes */
 		goto out;
 	strbuf_setlen(&buffer, buffer.len-1);
-	if (get_oid(buffer.buf, stash))
+	if (repo_get_oid(the_repository, buffer.buf, stash))
 		die(_("not a valid object: %s"), buffer.buf);
 	rc = 0;
 out:
@@ -1566,10 +1566,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		if (verbosity >= 0) {
 			printf(_("Updating %s..%s\n"),
-			       find_unique_abbrev(&head_commit->object.oid,
-						  DEFAULT_ABBREV),
-			       find_unique_abbrev(&remoteheads->item->object.oid,
-						  DEFAULT_ABBREV));
+			       repo_find_unique_abbrev(the_repository, &head_commit->object.oid,
+						       DEFAULT_ABBREV),
+			       repo_find_unique_abbrev(the_repository, &remoteheads->item->object.oid,
+						       DEFAULT_ABBREV));
 		}
 		commit = remoteheads->item;
 		if (!commit) {
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 723ba616a88..cd9c000f56b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -494,7 +494,8 @@ static void show_name(const struct object *obj,
 	else if (allow_undefined)
 		printf("undefined\n");
 	else if (always)
-		printf("%s\n", find_unique_abbrev(oid, DEFAULT_ABBREV));
+		printf("%s\n",
+		       repo_find_unique_abbrev(the_repository, oid, DEFAULT_ABBREV));
 	else
 		die("cannot describe '%s'", oid_to_hex(oid));
 	strbuf_release(&buf);
@@ -528,7 +529,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 			counter = 0;
 
 			*(p+1) = 0;
-			if (!get_oid(p - (hexsz - 1), &oid)) {
+			if (!repo_get_oid(the_repository, p - (hexsz - 1), &oid)) {
 				struct object *o =
 					lookup_object(the_repository, &oid);
 				if (o)
@@ -605,7 +606,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		struct object *object;
 		struct commit *commit;
 
-		if (get_oid(*argv, &oid)) {
+		if (repo_get_oid(the_repository, *argv, &oid)) {
 			fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
 					*argv);
 			continue;
diff --git a/builtin/notes.c b/builtin/notes.c
index 75ce7f3f574..73c9c691781 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -259,7 +259,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 
-	if (get_oid(arg, &object))
+	if (repo_get_oid(the_repository, arg, &object))
 		die(_("failed to resolve '%s' as a valid ref."), arg);
 	if (!(buf = read_object_file(&object, &type, &len)))
 		die(_("failed to read object '%s'."), arg);
@@ -309,9 +309,9 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 			die(_("malformed input line: '%s'."), buf.buf);
 		strbuf_rtrim(split[0]);
 		strbuf_rtrim(split[1]);
-		if (get_oid(split[0]->buf, &from_obj))
+		if (repo_get_oid(the_repository, split[0]->buf, &from_obj))
 			die(_("failed to resolve '%s' as a valid ref."), split[0]->buf);
-		if (get_oid(split[1]->buf, &to_obj))
+		if (repo_get_oid(the_repository, split[1]->buf, &to_obj))
 			die(_("failed to resolve '%s' as a valid ref."), split[1]->buf);
 
 		if (rewrite_cmd)
@@ -379,7 +379,7 @@ static int list(int argc, const char **argv, const char *prefix)
 
 	t = init_notes_check("list", 0);
 	if (argc) {
-		if (get_oid(argv[0], &object))
+		if (repo_get_oid(the_repository, argv[0], &object))
 			die(_("failed to resolve '%s' as a valid ref."), argv[0]);
 		note = get_note(t, &object);
 		if (note) {
@@ -434,7 +434,7 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	object_ref = argc > 1 ? argv[1] : "HEAD";
 
-	if (get_oid(object_ref, &object))
+	if (repo_get_oid(the_repository, object_ref, &object))
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("add", NOTES_INIT_WRITABLE);
@@ -522,12 +522,12 @@ static int copy(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_copy_usage, options);
 	}
 
-	if (get_oid(argv[0], &from_obj))
+	if (repo_get_oid(the_repository, argv[0], &from_obj))
 		die(_("failed to resolve '%s' as a valid ref."), argv[0]);
 
 	object_ref = 1 < argc ? argv[1] : "HEAD";
 
-	if (get_oid(object_ref, &object))
+	if (repo_get_oid(the_repository, object_ref, &object))
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("copy", NOTES_INIT_WRITABLE);
@@ -606,7 +606,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 
 	object_ref = 1 < argc ? argv[1] : "HEAD";
 
-	if (get_oid(object_ref, &object))
+	if (repo_get_oid(the_repository, object_ref, &object))
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check(argv[0], NOTES_INIT_WRITABLE);
@@ -668,7 +668,7 @@ static int show(int argc, const char **argv, const char *prefix)
 
 	object_ref = argc ? argv[0] : "HEAD";
 
-	if (get_oid(object_ref, &object))
+	if (repo_get_oid(the_repository, object_ref, &object))
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("show", 0);
@@ -718,7 +718,7 @@ static int merge_commit(struct notes_merge_options *o)
 	 * and target notes ref from .git/NOTES_MERGE_REF.
 	 */
 
-	if (get_oid("NOTES_MERGE_PARTIAL", &oid))
+	if (repo_get_oid(the_repository, "NOTES_MERGE_PARTIAL", &oid))
 		die(_("failed to read ref NOTES_MERGE_PARTIAL"));
 	else if (!(partial = lookup_commit_reference(the_repository, &oid)))
 		die(_("could not find commit from NOTES_MERGE_PARTIAL."));
@@ -897,7 +897,7 @@ static int remove_one_note(struct notes_tree *t, const char *name, unsigned flag
 {
 	int status;
 	struct object_id oid;
-	if (get_oid(name, &oid))
+	if (repo_get_oid(the_repository, name, &oid))
 		return error(_("Failed to resolve '%s' as a valid ref."), name);
 	status = remove_note(t, oid.hash);
 	if (status)
diff --git a/builtin/prune.c b/builtin/prune.c
index 119a253a2ad..202f7367746 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -172,7 +172,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		struct object_id oid;
 		const char *name = *argv++;
 
-		if (!get_oid(name, &oid)) {
+		if (!repo_get_oid(the_repository, name, &oid)) {
 			struct object *object = parse_object_or_die(&oid,
 								    name);
 			add_pending_object(&revs, object, "");
diff --git a/builtin/pull.c b/builtin/pull.c
index 56f679d94a0..bc0f29064b3 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1031,7 +1031,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (file_exists(git_path_merge_head(the_repository)))
 		die_conclude_merge();
 
-	if (get_oid("HEAD", &orig_head))
+	if (repo_get_oid(the_repository, "HEAD", &orig_head))
 		oidclr(&orig_head);
 
 	if (opt_rebase) {
@@ -1056,7 +1056,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_dry_run)
 		return 0;
 
-	if (get_oid("HEAD", &curr_head))
+	if (repo_get_oid(the_repository, "HEAD", &curr_head))
 		oidclr(&curr_head);
 
 	if (!is_null_oid(&orig_head) && !is_null_oid(&curr_head) &&
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index aecfae12d3a..556ee84b6d3 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -65,20 +65,20 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	if (dash_dash == 3 ||
 	    (dash_dash < 0 && argc > 2 &&
-	     !get_oid_committish(argv[0], &oid) &&
-	     !get_oid_committish(argv[1], &oid) &&
-	     !get_oid_committish(argv[2], &oid))) {
+	     !repo_get_oid_committish(the_repository, argv[0], &oid) &&
+	     !repo_get_oid_committish(the_repository, argv[1], &oid) &&
+	     !repo_get_oid_committish(the_repository, argv[2], &oid))) {
 		if (dash_dash < 0)
 			; /* already validated arguments */
-		else if (get_oid_committish(argv[0], &oid))
+		else if (repo_get_oid_committish(the_repository, argv[0], &oid))
 			usage_msg_optf(_("not a revision: '%s'"),
 				       builtin_range_diff_usage, options,
 				       argv[0]);
-		else if (get_oid_committish(argv[1], &oid))
+		else if (repo_get_oid_committish(the_repository, argv[1], &oid))
 			usage_msg_optf(_("not a revision: '%s'"),
 				       builtin_range_diff_usage, options,
 				       argv[1]);
-		else if (get_oid_committish(argv[2], &oid))
+		else if (repo_get_oid_committish(the_repository, argv[2], &oid))
 			usage_msg_optf(_("not a revision: '%s'"),
 				       builtin_range_diff_usage, options,
 				       argv[2]);
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 11759c415f3..fe19852634b 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -199,7 +199,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 
-		if (get_oid(arg, &oid))
+		if (repo_get_oid(the_repository, arg, &oid))
 			die("Not a valid object name %s", arg);
 		if (list_tree(&oid) < 0)
 			die("failed to unpack tree object %s", arg);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b7b908b66b..55ecc2d5f33 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -219,13 +219,15 @@ static int get_revision_ranges(struct commit *upstream, struct commit *onto,
 	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
 			     oid_to_hex(orig_head));
 
-	shorthead = find_unique_abbrev(orig_head, DEFAULT_ABBREV);
+	shorthead = repo_find_unique_abbrev(the_repository, orig_head,
+					    DEFAULT_ABBREV);
 
 	if (upstream) {
 		const char *shortrev;
 
-		shortrev = find_unique_abbrev(&base_rev->object.oid,
-					      DEFAULT_ABBREV);
+		shortrev = repo_find_unique_abbrev(the_repository,
+						   &base_rev->object.oid,
+						   DEFAULT_ABBREV);
 
 		*shortrevisions = xstrfmt("%s..%s", shortrev, shorthead);
 	} else
@@ -1262,7 +1264,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		int fd;
 
 		/* Sanity check */
-		if (get_oid("HEAD", &head))
+		if (repo_get_oid(the_repository, "HEAD", &head))
 			die(_("Cannot read HEAD"));
 
 		fd = repo_hold_locked_index(the_repository, &lock_file, 0);
@@ -1681,7 +1683,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
-		if (get_oid_mb(options.onto_name, &branch_base) < 0) {
+		if (repo_get_oid_mb(the_repository, options.onto_name, &branch_base) < 0) {
 			if (keep_base)
 				die(_("'%s': need exactly one merge base with branch"),
 				    options.upstream_name);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cccdb73807c..c6ab537a44f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1344,7 +1344,7 @@ static int head_has_history(void)
 {
 	struct object_id oid;
 
-	return !get_oid("HEAD", &oid);
+	return !repo_get_oid(the_repository, "HEAD", &oid);
 }
 
 static const char *push_to_deploy(unsigned char *sha1,
@@ -1680,11 +1680,11 @@ static void check_aliased_update_internal(struct command *cmd,
 	rp_error("refusing inconsistent update between symref '%s' (%s..%s) and"
 		 " its target '%s' (%s..%s)",
 		 cmd->ref_name,
-		 find_unique_abbrev(&cmd->old_oid, DEFAULT_ABBREV),
-		 find_unique_abbrev(&cmd->new_oid, DEFAULT_ABBREV),
+		 repo_find_unique_abbrev(the_repository, &cmd->old_oid, DEFAULT_ABBREV),
+		 repo_find_unique_abbrev(the_repository, &cmd->new_oid, DEFAULT_ABBREV),
 		 dst_cmd->ref_name,
-		 find_unique_abbrev(&dst_cmd->old_oid, DEFAULT_ABBREV),
-		 find_unique_abbrev(&dst_cmd->new_oid, DEFAULT_ABBREV));
+		 repo_find_unique_abbrev(the_repository, &dst_cmd->old_oid, DEFAULT_ABBREV),
+		 repo_find_unique_abbrev(the_repository, &dst_cmd->new_oid, DEFAULT_ABBREV));
 
 	cmd->error_string = dst_cmd->error_string =
 		"inconsistent aliased update";
diff --git a/builtin/replace.c b/builtin/replace.c
index 71d8e949e35..f765a3e2d75 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -56,7 +56,7 @@ static int show_reference(struct repository *r, const char *refname,
 			struct object_id object;
 			enum object_type obj_type, repl_type;
 
-			if (get_oid(refname, &object))
+			if (repo_get_oid(the_repository, refname, &object))
 				return error(_("failed to resolve '%s' as a valid ref"), refname);
 
 			obj_type = oid_object_info(r, &object, NULL);
@@ -114,7 +114,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 	base_len = ref.len;
 
 	for (p = argv; *p; p++) {
-		if (get_oid(*p, &oid)) {
+		if (repo_get_oid(the_repository, *p, &oid)) {
 			error("failed to resolve '%s' as a valid ref", *p);
 			had_error = 1;
 			continue;
@@ -208,10 +208,10 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
 {
 	struct object_id object, repl;
 
-	if (get_oid(object_ref, &object))
+	if (repo_get_oid(the_repository, object_ref, &object))
 		return error(_("failed to resolve '%s' as a valid ref"),
 			     object_ref);
-	if (get_oid(replace_ref, &repl))
+	if (repo_get_oid(the_repository, replace_ref, &repl))
 		return error(_("failed to resolve '%s' as a valid ref"),
 			     replace_ref);
 
@@ -322,7 +322,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	struct object_id old_oid, new_oid, prev;
 	struct strbuf ref = STRBUF_INIT;
 
-	if (get_oid(object_ref, &old_oid) < 0)
+	if (repo_get_oid(the_repository, object_ref, &old_oid) < 0)
 		return error(_("not a valid object name: '%s'"), object_ref);
 
 	type = oid_object_info(the_repository, &old_oid, NULL);
@@ -377,7 +377,7 @@ static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 		struct object_id oid;
 		struct commit *commit;
 
-		if (get_oid(argv[i], &oid) < 0) {
+		if (repo_get_oid(the_repository, argv[i], &oid) < 0) {
 			strbuf_release(&new_parents);
 			return error(_("not a valid object name: '%s'"),
 				     argv[i]);
@@ -424,7 +424,7 @@ static int check_one_mergetag(struct commit *commit,
 	/* iterate over new parents */
 	for (i = 1; i < mergetag_data->argc; i++) {
 		struct object_id oid;
-		if (get_oid(mergetag_data->argv[i], &oid) < 0)
+		if (repo_get_oid(the_repository, mergetag_data->argv[i], &oid) < 0)
 			return error(_("not a valid object name: '%s'"),
 				     mergetag_data->argv[i]);
 		if (oideq(get_tagged_oid(tag), &oid))
@@ -454,7 +454,7 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 	const char *buffer;
 	unsigned long size;
 
-	if (get_oid(old_ref, &old_oid) < 0)
+	if (repo_get_oid(the_repository, old_ref, &old_oid) < 0)
 		return error(_("not a valid object name: '%s'"), old_ref);
 	commit = lookup_commit_reference(the_repository, &old_oid);
 	if (!commit)
diff --git a/builtin/reset.c b/builtin/reset.c
index 24b04aeecb9..cd4165537c5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -90,7 +90,7 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 
 	if (reset_type == KEEP) {
 		struct object_id head_oid;
-		if (get_oid("HEAD", &head_oid))
+		if (repo_get_oid(the_repository, "HEAD", &head_oid))
 			return error(_("You do not have a valid HEAD."));
 		if (!fill_tree_descriptor(the_repository, desc + nr, &head_oid))
 			return error(_("Failed to find tree of HEAD."));
@@ -125,7 +125,7 @@ static void print_new_head_line(struct commit *commit)
 	struct strbuf buf = STRBUF_INIT;
 
 	printf(_("HEAD is now at %s"),
-		find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV));
+		repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
 
 	pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
 	if (buf.len > 0)
@@ -261,8 +261,8 @@ static void parse_args(struct pathspec *pathspec,
 		 * has to be unambiguous. If there is a single argument, it
 		 * can not be a tree
 		 */
-		else if ((!argv[1] && !get_oid_committish(argv[0], &unused)) ||
-			 (argv[1] && !get_oid_treeish(argv[0], &unused))) {
+		else if ((!argv[1] && !repo_get_oid_committish(the_repository, argv[0], &unused)) ||
+			 (argv[1] && !repo_get_oid_treeish(the_repository, argv[0], &unused))) {
 			/*
 			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
@@ -289,9 +289,9 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 	struct object_id *orig = NULL, oid_orig,
 		*old_orig = NULL, oid_old_orig;
 
-	if (!get_oid("ORIG_HEAD", &oid_old_orig))
+	if (!repo_get_oid(the_repository, "ORIG_HEAD", &oid_old_orig))
 		old_orig = &oid_old_orig;
-	if (!get_oid("HEAD", &oid_orig)) {
+	if (!repo_get_oid(the_repository, "HEAD", &oid_orig)) {
 		orig = &oid_orig;
 		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
 		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
@@ -367,13 +367,14 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
-	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
+	unborn = !strcmp(rev, "HEAD") && repo_get_oid(the_repository, "HEAD",
+						      &oid);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
 		oidcpy(&oid, the_hash_algo->empty_tree);
 	} else if (!pathspec.nr && !patch_mode) {
 		struct commit *commit;
-		if (get_oid_committish(rev, &oid))
+		if (repo_get_oid_committish(the_repository, rev, &oid))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
 		commit = lookup_commit_reference(the_repository, &oid);
 		if (!commit)
@@ -381,7 +382,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		oidcpy(&oid, &commit->object.oid);
 	} else {
 		struct tree *tree;
-		if (get_oid_treeish(rev, &oid))
+		if (repo_get_oid_treeish(the_repository, rev, &oid))
 			die(_("Failed to resolve '%s' as a valid tree."), rev);
 		tree = parse_tree_indirect(&oid);
 		if (!tree)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 85e522dff8a..e88affc2764 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -135,7 +135,7 @@ static void show_commit(struct commit *commit, void *data)
 		if (!revs->graph)
 			fputs(get_revision_mark(revs, commit), stdout);
 		if (revs->abbrev_commit && revs->abbrev)
-			fputs(find_unique_abbrev(&commit->object.oid, revs->abbrev),
+			fputs(repo_find_unique_abbrev(the_repository, &commit->object.oid, revs->abbrev),
 			      stdout);
 		else
 			fputs(oid_to_hex(&commit->object.oid), stdout);
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index e1fa9c6348c..5db9d6ad518 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -164,7 +164,8 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
 		}
 	}
 	else if (abbrev)
-		show_with_type(type, find_unique_abbrev(oid, abbrev));
+		show_with_type(type,
+			       repo_find_unique_abbrev(the_repository, oid, abbrev));
 	else
 		show_with_type(type, oid_to_hex(oid));
 }
@@ -189,7 +190,7 @@ static int show_default(void)
 		struct object_id oid;
 
 		def = NULL;
-		if (!get_oid(s, &oid)) {
+		if (!repo_get_oid(the_repository, s, &oid)) {
 			show_rev(NORMAL, &oid, s);
 			return 1;
 		}
@@ -281,7 +282,7 @@ static int try_difference(const char *arg)
 		return 0;
 	}
 
-	if (!get_oid_committish(start, &start_oid) && !get_oid_committish(end, &end_oid)) {
+	if (!repo_get_oid_committish(the_repository, start, &start_oid) && !repo_get_oid_committish(the_repository, end, &end_oid)) {
 		show_rev(NORMAL, &end_oid, end);
 		show_rev(symmetric ? NORMAL : REVERSED, &start_oid, start);
 		if (symmetric) {
@@ -339,7 +340,7 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 
 	*dotdot = 0;
-	if (get_oid_committish(arg, &oid) ||
+	if (repo_get_oid_committish(the_repository, arg, &oid) ||
 	    !(commit = lookup_commit_reference(the_repository, &oid))) {
 		*dotdot = '^';
 		return 0;
@@ -870,7 +871,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (skip_prefix(arg, "--disambiguate=", &arg)) {
-				for_each_abbrev(arg, show_abbrev, NULL);
+				repo_for_each_abbrev(the_repository, arg,
+						     show_abbrev, NULL);
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
diff --git a/builtin/rm.c b/builtin/rm.c
index dc198f79082..e093cb99966 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -371,7 +371,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 */
 	if (!force) {
 		struct object_id oid;
-		if (get_oid("HEAD", &oid))
+		if (repo_get_oid(the_repository, "HEAD", &oid))
 			oidclr(&oid);
 		if (check_local_mod(&oid, index_only))
 			exit(1);
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 8342b68aef7..9d208db3b43 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -313,8 +313,8 @@ static void show_one_commit(struct commit *commit, int no_name)
 		}
 		else
 			printf("[%s] ",
-			       find_unique_abbrev(&commit->object.oid,
-						  DEFAULT_ABBREV));
+			       repo_find_unique_abbrev(the_repository, &commit->object.oid,
+						       DEFAULT_ABBREV));
 	}
 	puts(pretty_str);
 	strbuf_release(&pretty);
@@ -415,7 +415,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_oid(refname + ofs, &tmp) || !oideq(&tmp, oid))
+	if (repo_get_oid(the_repository, refname + ofs, &tmp) || !oideq(&tmp, oid))
 		ofs = 5;
 	return append_ref(refname + ofs, oid, 0);
 }
@@ -430,7 +430,7 @@ static int append_remote_ref(const char *refname, const struct object_id *oid,
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_oid(refname + ofs, &tmp) || !oideq(&tmp, oid))
+	if (repo_get_oid(the_repository, refname + ofs, &tmp) || !oideq(&tmp, oid))
 		ofs = 5;
 	return append_ref(refname + ofs, oid, 0);
 }
@@ -534,7 +534,7 @@ static int show_independent(struct commit **rev,
 static void append_one_rev(const char *av)
 {
 	struct object_id revkey;
-	if (!get_oid(av, &revkey)) {
+	if (!repo_get_oid(the_repository, av, &revkey)) {
 		append_ref(av, &revkey, 0);
 		return;
 	}
@@ -837,7 +837,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			die(Q_("cannot handle more than %d rev.",
 			       "cannot handle more than %d revs.",
 			       MAX_REVS), MAX_REVS);
-		if (get_oid(ref_name[num_rev], &revkey))
+		if (repo_get_oid(the_repository, ref_name[num_rev], &revkey))
 			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
 		commit = lookup_commit_reference(the_repository, &revkey);
 		if (!commit)
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 1f28d7fe4b9..b5a68e23e65 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -34,7 +34,7 @@ static void show_one(const char *refname, const struct object_id *oid)
 	if (quiet)
 		return;
 
-	hex = find_unique_abbrev(oid, abbrev);
+	hex = repo_find_unique_abbrev(the_repository, oid, abbrev);
 	if (hash_only)
 		printf("%s\n", hex);
 	else
@@ -44,7 +44,7 @@ static void show_one(const char *refname, const struct object_id *oid)
 		return;
 
 	if (!peel_iterated_oid(oid, &peeled)) {
-		hex = find_unique_abbrev(&peeled, abbrev);
+		hex = repo_find_unique_abbrev(the_repository, &peeled, abbrev);
 		printf("%s %s^{}\n", hex, refname);
 	}
 }
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8d5ae6f2a60..d73d3d2d825 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -469,7 +469,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
 		return update_working_directory(NULL);
 	}
 
-	if (get_oid("HEAD", &oid)) {
+	if (repo_get_oid(the_repository, "HEAD", &oid)) {
 		FILE *fp;
 
 		/* assume we are in a fresh repo, but update the sparse-checkout file */
diff --git a/builtin/stash.c b/builtin/stash.c
index 6a12fed2713..dd5f67e7e6e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -202,7 +202,7 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 
 	revision = info->revision.buf;
 
-	if (get_oid(revision, &info->w_commit))
+	if (repo_get_oid(the_repository, revision, &info->w_commit))
 		return error(_("%s is not a valid reference"), revision);
 
 	assert_stash_like(info, revision);
@@ -232,7 +232,7 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 static int do_clear_stash(void)
 {
 	struct object_id obj;
-	if (get_oid(ref_stash, &obj))
+	if (repo_get_oid(the_repository, ref_stash, &obj))
 		return 0;
 
 	return delete_ref(NULL, ref_stash, &obj, 0);
@@ -1084,7 +1084,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	int ret = 0;
 
 	/* No initial commit. */
-	if (get_oid("HEAD", &dummy))
+	if (repo_get_oid(the_repository, "HEAD", &dummy))
 		return -1;
 
 	if (repo_read_index(the_repository) < 0)
@@ -1356,7 +1356,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		goto done;
 	}
 
-	if (get_oid("HEAD", &info->b_commit)) {
+	if (repo_get_oid(the_repository, "HEAD", &info->b_commit)) {
 		if (!quiet)
 			fprintf_ln(stderr, _("You do not have "
 					     "the initial commit yet"));
@@ -1374,8 +1374,9 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
 	if (flags & REF_ISSYMREF)
 		skip_prefix(branch_ref, "refs/heads/", &branch_name);
-	head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
-					     DEFAULT_ABBREV);
+	head_short_sha1 = repo_find_unique_abbrev(the_repository,
+						  &head_commit->object.oid,
+						  DEFAULT_ABBREV);
 	strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
 	pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d05d1a84623..b21857479de 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1176,7 +1176,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 	if (!summary_limit)
 		return 0;
 
-	if (!get_oid(argc ? argv[0] : "HEAD", &head_oid)) {
+	if (!repo_get_oid(the_repository, argc ? argv[0] : "HEAD", &head_oid)) {
 		if (argc) {
 			argv++;
 			argc--;
@@ -1189,7 +1189,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 			argc--;
 		}
 	} else {
-		if (get_oid("HEAD", &head_oid))
+		if (repo_get_oid(the_repository, "HEAD", &head_oid))
 			die(_("could not fetch a revision for HEAD"));
 	}
 
diff --git a/builtin/tag.c b/builtin/tag.c
index adcaa547b0d..7af7eaa4139 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -138,7 +138,7 @@ static int delete_tags(const char **argv)
 		if (!ref_exists(name))
 			printf(_("Deleted tag '%s' (was %s)\n"),
 				item->string + 10,
-				find_unique_abbrev(oid, DEFAULT_ABBREV));
+				repo_find_unique_abbrev(the_repository, oid, DEFAULT_ABBREV));
 
 		free(oid);
 	}
@@ -590,7 +590,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (argc > 2)
 		die(_("too many arguments"));
 
-	if (get_oid(object_ref, &object))
+	if (repo_get_oid(the_repository, object_ref, &object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
 	if (strbuf_check_tag_ref(&ref, tag))
@@ -631,7 +631,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	ref_transaction_free(transaction);
 	if (force && !is_null_oid(&prev) && !oideq(&prev, &object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag,
-		       find_unique_abbrev(&prev, DEFAULT_ABBREV));
+		       repo_find_unique_abbrev(the_repository, &prev, DEFAULT_ABBREV));
 
 cleanup:
 	ref_sorting_release(sorting);
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index e9b105a5397..b9e258a553f 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -30,7 +30,7 @@ int cmd_unpack_file(int argc, const char **argv, const char *prefix)
 
 	if (argc != 2 || !strcmp(argv[1], "-h"))
 		usage("git unpack-file <blob>");
-	if (get_oid(argv[1], &oid))
+	if (repo_get_oid(the_repository, argv[1], &oid))
 		die("Not a valid object name %s", argv[1]);
 
 	git_config(git_default_config, NULL);
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a84e7b47a20..1ba0727ba77 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -116,7 +116,7 @@ static int parse_next_oid(const char **next, const char *end,
 		(*next)++;
 		*next = parse_arg(*next, &arg);
 		if (arg.len) {
-			if (get_oid(arg.buf, oid))
+			if (repo_get_oid(the_repository, arg.buf, oid))
 				goto invalid;
 		} else {
 			/* Without -z, an empty value means all zeros: */
@@ -134,7 +134,7 @@ static int parse_next_oid(const char **next, const char *end,
 		*next += arg.len;
 
 		if (arg.len) {
-			if (get_oid(arg.buf, oid))
+			if (repo_get_oid(the_repository, arg.buf, oid))
 				goto invalid;
 		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
 			/* With -z, treat an empty value as all zeros: */
@@ -549,7 +549,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		refname = argv[0];
 		value = argv[1];
 		oldval = argv[2];
-		if (get_oid(value, &oid))
+		if (repo_get_oid(the_repository, value, &oid))
 			die("%s: not a valid SHA1", value);
 	}
 
@@ -560,7 +560,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 			 * must not already exist:
 			 */
 			oidclr(&oldoid);
-		else if (get_oid(oldval, &oldoid))
+		else if (repo_get_oid(the_repository, oldval, &oldoid))
 			die("%s: not a valid old SHA1", oldval);
 	}
 
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 7aedf10e856..2a0c927ee93 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -39,7 +39,7 @@ static int verify_commit(const char *name, unsigned flags)
 	struct object_id oid;
 	struct object *obj;
 
-	if (get_oid(name, &oid))
+	if (repo_get_oid(the_repository, name, &oid))
 		return error("commit '%s' not found.", name);
 
 	obj = parse_object(the_repository, &oid);
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 5c00b0b0f77..2a9aac43b85 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -52,7 +52,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		struct object_id oid;
 		const char *name = argv[i++];
 
-		if (get_oid(name, &oid)) {
+		if (repo_get_oid(the_repository, name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
 			continue;
 		}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 80d05e246d8..62c02fe2dee 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -553,7 +553,7 @@ static void print_preparing_worktree_line(int detach,
 		else
 			fprintf_ln(stderr, _("Preparing worktree (resetting branch '%s'; was at %s)"),
 				  new_branch,
-				  find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV));
+				  repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
 	} else if (new_branch) {
 		fprintf_ln(stderr, _("Preparing worktree (new branch '%s')"), new_branch);
 	} else {
@@ -567,7 +567,7 @@ static void print_preparing_worktree_line(int detach,
 			if (!commit)
 				die(_("invalid reference: %s"), branch);
 			fprintf_ln(stderr, _("Preparing worktree (detached HEAD %s)"),
-				  find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV));
+				  repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
 		}
 		strbuf_release(&s);
 	}
@@ -757,7 +757,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 		strbuf_addstr(&sb, "(bare)");
 	else {
 		strbuf_addf(&sb, "%-*s ", abbrev_len,
-				find_unique_abbrev(&wt->head_oid, DEFAULT_ABBREV));
+				repo_find_unique_abbrev(the_repository, &wt->head_oid, DEFAULT_ABBREV));
 		if (wt->is_detached)
 			strbuf_addstr(&sb, "(detached HEAD)");
 		else if (wt->head_ref) {
@@ -794,7 +794,7 @@ static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
 
 		if (path_len > *maxlen)
 			*maxlen = path_len;
-		sha1_len = strlen(find_unique_abbrev(&wt[i]->head_oid, *abbrev));
+		sha1_len = strlen(repo_find_unique_abbrev(the_repository, &wt[i]->head_oid, *abbrev));
 		if (sha1_len > *abbrev)
 			*abbrev = sha1_len;
 	}
diff --git a/cache.h b/cache.h
index 5a736a2b7e7..1d05a8e945f 100644
--- a/cache.h
+++ b/cache.h
@@ -1103,9 +1103,7 @@ void check_repository_format(struct repository_format *fmt);
  * reentrant, as it calls into other non-reentrant git code.
  */
 const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
-#define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_repository, oid, len)
 int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
-#define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
 
 /* set default permissions by passing mode arguments to open(2) */
 int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
@@ -1330,17 +1328,8 @@ enum get_oid_result get_oid_with_context(struct repository *repo, const char *st
 					 unsigned flags, struct object_id *oid,
 					 struct object_context *oc);
 
-#define get_oid(str, oid)		repo_get_oid(the_repository, str, oid)
-#define get_oid_commit(str, oid)	repo_get_oid_commit(the_repository, str, oid)
-#define get_oid_committish(str, oid)	repo_get_oid_committish(the_repository, str, oid)
-#define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, oid)
-#define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, str, oid)
-#define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, oid)
-#define get_oid_mb(str, oid) 		repo_get_oid_mb(the_repository, str, oid)
-
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
 int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
-#define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repository, prefix, fn, data)
 
 int set_disambiguate_hint_config(const char *var, const char *value);
 
@@ -1388,8 +1377,6 @@ int repo_interpret_branch_name(struct repository *r,
 			       const char *str, int len,
 			       struct strbuf *buf,
 			       const struct interpret_branch_name_options *options);
-#define interpret_branch_name(str, len, buf, options) \
-	repo_interpret_branch_name(the_repository, str, len, buf, options)
 
 int validate_headref(const char *ref);
 
@@ -1409,8 +1396,6 @@ void *read_object_with_reference(struct repository *r,
 struct object *repo_peel_to_type(struct repository *r,
 				 const char *name, int namelen,
 				 struct object *o, enum object_type);
-#define peel_to_type(name, namelen, obj, type) \
-	repo_peel_to_type(the_repository, name, namelen, obj, type)
 
 const char *git_editor(void);
 const char *git_sequence_editor(void);
diff --git a/checkout.c b/checkout.c
index 2e39dae684f..1247b882248 100644
--- a/checkout.c
+++ b/checkout.c
@@ -23,7 +23,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.src = cb->src_ref;
 	if (remote_find_tracking(remote, &query) ||
-	    get_oid(query.dst, cb->dst_oid)) {
+	    repo_get_oid(the_repository, query.dst, cb->dst_oid)) {
 		free(query.dst);
 		return 0;
 	}
diff --git a/combine-diff.c b/combine-diff.c
index 91051dc3258..e917362faf7 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -949,11 +949,11 @@ static void show_combined_header(struct combine_diff_path *elem,
 			 "", elem->path, line_prefix, c_meta, c_reset);
 	printf("%s%sindex ", line_prefix, c_meta);
 	for (i = 0; i < num_parent; i++) {
-		abb = find_unique_abbrev(&elem->parent[i].oid,
-					 abbrev);
+		abb = repo_find_unique_abbrev(the_repository,
+					      &elem->parent[i].oid, abbrev);
 		printf("%s%s", i ? "," : "", abb);
 	}
-	abb = find_unique_abbrev(&elem->oid, abbrev);
+	abb = repo_find_unique_abbrev(the_repository, &elem->oid, abbrev);
 	printf("..%s%s\n", abb, c_reset);
 
 	if (mode_differs) {
diff --git a/commit.c b/commit.c
index 7b63d3b0e1c..c0b1db3d3e1 100644
--- a/commit.c
+++ b/commit.c
@@ -81,7 +81,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	struct object_id oid;
 	struct commit *commit;
 
-	if (get_oid_committish(name, &oid))
+	if (repo_get_oid_committish(the_repository, name, &oid))
 		return NULL;
 	commit = lookup_commit_reference(the_repository, &oid);
 	if (parse_commit(commit))
@@ -1274,7 +1274,8 @@ void verify_merge_signature(struct commit *commit, int verbosity,
 
 	ret = check_commit_signature(commit, &signature_check);
 
-	find_unique_abbrev_r(hex, &commit->object.oid, DEFAULT_ABBREV);
+	repo_find_unique_abbrev_r(the_repository, hex, &commit->object.oid,
+				  DEFAULT_ABBREV);
 	switch (signature_check.result) {
 	case 'G':
 		if (ret || (check_trust && signature_check.trust_level < TRUST_MARGINAL))
@@ -1635,10 +1636,11 @@ struct commit *get_merge_parent(const char *name)
 	struct object *obj;
 	struct commit *commit;
 	struct object_id oid;
-	if (get_oid(name, &oid))
+	if (repo_get_oid(the_repository, name, &oid))
 		return NULL;
 	obj = parse_object(the_repository, &oid);
-	commit = (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
+	commit = (struct commit *)repo_peel_to_type(the_repository, name, 0,
+						    obj, OBJ_COMMIT);
 	if (commit && !merge_remote_util(commit))
 		set_merge_remote_desc(commit, name, obj);
 	return commit;
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
new file mode 100644
index 00000000000..dcdba314fc2
--- /dev/null
+++ b/contrib/coccinelle/the_repository.cocci
@@ -0,0 +1,44 @@
+// Fully migrated "the_repository" additions
+@@
+@@
+(
+// cache.h
+- get_oid
++ repo_get_oid
+|
+- get_oid_commit
++ repo_get_oid_commit
+|
+- get_oid_committish
++ repo_get_oid_committish
+|
+- get_oid_tree
++ repo_get_oid_tree
+|
+- get_oid_treeish
++ repo_get_oid_treeish
+|
+- get_oid_blob
++ repo_get_oid_blob
+|
+- get_oid_mb
++ repo_get_oid_mb
+|
+- find_unique_abbrev
++ repo_find_unique_abbrev
+|
+- find_unique_abbrev_r
++ repo_find_unique_abbrev_r
+|
+- for_each_abbrev
++ repo_for_each_abbrev
+|
+- interpret_branch_name
++ repo_interpret_branch_name
+|
+- peel_to_type
++ repo_peel_to_type
+)
+  (
++ the_repository,
+  ...)
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 8b3f2580e6b..2d200ab83e7 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,44 +5,7 @@
 @@
 @@
 (
-// cache.h
-- get_oid
-+ repo_get_oid
-|
-- get_oid_commit
-+ repo_get_oid_commit
-|
-- get_oid_committish
-+ repo_get_oid_committish
-|
-- get_oid_tree
-+ repo_get_oid_tree
-|
-- get_oid_treeish
-+ repo_get_oid_treeish
-|
-- get_oid_blob
-+ repo_get_oid_blob
-|
-- get_oid_mb
-+ repo_get_oid_mb
-|
-- find_unique_abbrev
-+ repo_find_unique_abbrev
-|
-- find_unique_abbrev_r
-+ repo_find_unique_abbrev_r
-|
-- for_each_abbrev
-+ repo_for_each_abbrev
-|
-- interpret_branch_name
-+ repo_interpret_branch_name
-|
-- peel_to_type
-+ repo_peel_to_type
 // commit-reach.h
-|
 - get_merge_bases
 + repo_get_merge_bases
 |
diff --git a/diff-lib.c b/diff-lib.c
index 70b3578b907..628e13c8b03 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -582,7 +582,7 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 	if (revs->pending.nr == 1) {
 		struct object_id oid;
 
-		if (get_oid("HEAD", &oid))
+		if (repo_get_oid(the_repository, "HEAD", &oid))
 			die(_("unable to get HEAD"));
 
 		mb_child[1] = lookup_commit_reference(the_repository, &oid);
diff --git a/diff.c b/diff.c
index 1617aa50a98..81f115d32c9 100644
--- a/diff.c
+++ b/diff.c
@@ -4364,7 +4364,7 @@ static int similarity_index(struct diff_filepair *p)
 static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
 {
 	if (startup_info->have_repository)
-		return find_unique_abbrev(oid, abbrev);
+		return repo_find_unique_abbrev(the_repository, oid, abbrev);
 	else {
 		char *hex = oid_to_hex(oid);
 		if (abbrev < 0)
@@ -5000,7 +5000,7 @@ static int diff_opt_find_object(const struct option *option,
 	struct object_id oid;
 
 	BUG_ON_OPT_NEG(unset);
-	if (get_oid(arg, &oid))
+	if (repo_get_oid(the_repository, arg, &oid))
 		return error(_("unable to resolve '%s'"), arg);
 
 	if (!opt->objfind)
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 24cc44bdbc9..bb56d957a64 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -603,7 +603,9 @@ static void find_merge_parents(struct merge_parents *result,
 		 * util field yet.
 		 */
 		obj = parse_object(the_repository, &oid);
-		parent = (struct commit *)peel_to_type(NULL, 0, obj, OBJ_COMMIT);
+		parent = (struct commit *)repo_peel_to_type(the_repository,
+							    NULL, 0, obj,
+							    OBJ_COMMIT);
 		if (!parent)
 			continue;
 		commit_list_insert(parent, &parents);
diff --git a/log-tree.c b/log-tree.c
index 3adcb576e4c..49411c5c6a6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -236,7 +236,8 @@ static void show_parents(struct commit *commit, int abbrev, FILE *file)
 	struct commit_list *p;
 	for (p = commit->parents; p ; p = p->next) {
 		struct commit *parent = p->item;
-		fprintf(file, " %s", find_unique_abbrev(&parent->object.oid, abbrev));
+		fprintf(file, " %s",
+			repo_find_unique_abbrev(the_repository, &parent->object.oid, abbrev));
 	}
 }
 
@@ -244,7 +245,8 @@ static void show_children(struct rev_info *opt, struct commit *commit, int abbre
 {
 	struct commit_list *p = lookup_decoration(&opt->children, &commit->object);
 	for ( ; p; p = p->next) {
-		fprintf(opt->diffopt.file, " %s", find_unique_abbrev(&p->item->object.oid, abbrev));
+		fprintf(opt->diffopt.file, " %s",
+			repo_find_unique_abbrev(the_repository, &p->item->object.oid, abbrev));
 	}
 }
 
@@ -647,7 +649,8 @@ void show_log(struct rev_info *opt)
 
 		if (!opt->graph)
 			put_revision_mark(opt, commit);
-		fputs(find_unique_abbrev(&commit->object.oid, abbrev_commit), opt->diffopt.file);
+		fputs(repo_find_unique_abbrev(the_repository, &commit->object.oid, abbrev_commit),
+		      opt->diffopt.file);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit, opt->diffopt.file);
 		if (opt->children.name)
@@ -709,8 +712,8 @@ void show_log(struct rev_info *opt)
 
 		if (!opt->graph)
 			put_revision_mark(opt, commit);
-		fputs(find_unique_abbrev(&commit->object.oid,
-					 abbrev_commit),
+		fputs(repo_find_unique_abbrev(the_repository, &commit->object.oid,
+					      abbrev_commit),
 		      opt->diffopt.file);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit, opt->diffopt.file);
@@ -718,7 +721,7 @@ void show_log(struct rev_info *opt)
 			show_children(opt, commit, abbrev_commit);
 		if (parent)
 			fprintf(opt->diffopt.file, " (from %s)",
-			       find_unique_abbrev(&parent->object.oid, abbrev_commit));
+			       repo_find_unique_abbrev(the_repository, &parent->object.oid, abbrev_commit));
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), opt->diffopt.file);
 		show_decorations(opt, commit);
 		if (opt->commit_format == CMIT_FMT_ONELINE) {
diff --git a/mailmap.c b/mailmap.c
index da2589b0822..ed8289aea58 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -213,7 +213,7 @@ static int read_mailmap_blob(struct string_list *map, const char *name)
 
 	if (!name)
 		return 0;
-	if (get_oid(name, &oid) < 0)
+	if (repo_get_oid(the_repository, name, &oid) < 0)
 		return 0;
 
 	buf = read_object_file(&oid, &type, &size);
diff --git a/notes-merge.c b/notes-merge.c
index 5b1a9ff13f7..f9137ec768f 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -567,7 +567,7 @@ int notes_merge(struct notes_merge_options *o,
 	trace_printf("\tlocal commit: %.7s\n", oid_to_hex(&local_oid));
 
 	/* Dereference o->remote_ref into remote_oid */
-	if (get_oid(o->remote_ref, &remote_oid)) {
+	if (repo_get_oid(the_repository, o->remote_ref, &remote_oid)) {
 		/*
 		 * Failed to get remote_oid. If o->remote_ref looks like an
 		 * unborn ref, perform the merge using an empty notes tree.
diff --git a/notes.c b/notes.c
index a7187236e98..427cfdac294 100644
--- a/notes.c
+++ b/notes.c
@@ -946,7 +946,7 @@ void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 		for_each_glob_ref(string_list_add_one_ref, glob, list);
 	} else {
 		struct object_id oid;
-		if (get_oid(glob, &oid))
+		if (repo_get_oid(the_repository, glob, &oid))
 			warning("notes ref %s is invalid", glob);
 		if (!unsorted_string_list_has_string(list, glob))
 			string_list_append(list, glob);
@@ -1023,7 +1023,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->dirty = 0;
 
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
-	    get_oid_treeish(notes_ref, &object_oid))
+	    repo_get_oid_treeish(the_repository, notes_ref, &object_oid))
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
@@ -1350,7 +1350,7 @@ void expand_loose_notes_ref(struct strbuf *sb)
 {
 	struct object_id object;
 
-	if (get_oid(sb->buf, &object)) {
+	if (repo_get_oid(the_repository, sb->buf, &object)) {
 		/* fallback to expand_notes_ref */
 		expand_notes_ref(sb);
 	}
diff --git a/object-name.c b/object-name.c
index 69db1ec498a..19ba23216a5 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1667,7 +1667,8 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 	struct interpret_branch_name_options options = {
 		.allowed = allowed
 	};
-	int used = interpret_branch_name(name, len, sb, &options);
+	int used = repo_interpret_branch_name(the_repository, name, len, sb,
+					      &options);
 
 	if (used < 0)
 		used = 0;
@@ -1720,7 +1721,7 @@ int get_oidf(struct object_id *oid, const char *fmt, ...)
 	strbuf_vaddf(&sb, fmt, ap);
 	va_end(ap);
 
-	ret = get_oid(sb.buf, oid);
+	ret = repo_get_oid(the_repository, sb.buf, oid);
 	strbuf_release(&sb);
 
 	return ret;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index d346dbe2100..0f7b40d0c08 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -91,7 +91,7 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 
 	if (!arg)
 		return -1;
-	if (get_oid(arg, &oid))
+	if (repo_get_oid(the_repository, arg, &oid))
 		return error("malformed object name %s", arg);
 	commit = lookup_commit_reference(the_repository, &oid);
 	if (!commit)
@@ -110,7 +110,7 @@ int parse_opt_commit(const struct option *opt, const char *arg, int unset)
 
 	if (!arg)
 		return -1;
-	if (get_oid(arg, &oid))
+	if (repo_get_oid(the_repository, arg, &oid))
 		return error("malformed object name %s", arg);
 	commit = lookup_commit_reference(the_repository, &oid);
 	if (!commit)
@@ -129,7 +129,7 @@ int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 	}
 	if (!arg)
 		return -1;
-	if (get_oid(arg, &oid))
+	if (repo_get_oid(the_repository, arg, &oid))
 		return error(_("malformed object name '%s'"), arg);
 	oid_array_append(opt->value, &oid);
 	return 0;
@@ -146,7 +146,7 @@ int parse_opt_object_id(const struct option *opt, const char *arg, int unset)
 	}
 	if (!arg)
 		return -1;
-	if (get_oid(arg, &oid))
+	if (repo_get_oid(the_repository, arg, &oid))
 		return error(_("malformed object name '%s'"), arg);
 	*target = oid;
 	return 0;
diff --git a/range-diff.c b/range-diff.c
index 4bd65ab7496..5bcf966f6c5 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -94,7 +94,7 @@ static int read_patches(const char *range, struct string_list *list,
 				strbuf_reset(&buf);
 			}
 			CALLOC_ARRAY(util, 1);
-			if (get_oid(p, &util->oid)) {
+			if (repo_get_oid(the_repository, p, &util->oid)) {
 				error(_("could not parse commit '%s'"), p);
 				FREE_AND_NULL(util);
 				string_list_clear(list, 1);
@@ -390,7 +390,7 @@ static void output_pair_header(struct diff_options *diffopt,
 
 	if (!dashes->len)
 		strbuf_addchars(dashes, '-',
-				strlen(find_unique_abbrev(oid, abbrev)));
+				strlen(repo_find_unique_abbrev(the_repository, oid, abbrev)));
 
 	if (!b_util) {
 		color = color_old;
@@ -412,7 +412,7 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, "%*s:  %s ", patch_no_width, "-", dashes->buf);
 	else
 		strbuf_addf(buf, "%*d:  %s ", patch_no_width, a_util->i + 1,
-			    find_unique_abbrev(&a_util->oid, abbrev));
+			    repo_find_unique_abbrev(the_repository, &a_util->oid, abbrev));
 
 	if (status == '!')
 		strbuf_addf(buf, "%s%s", color_reset, color);
@@ -424,7 +424,7 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, " %*s:  %s", patch_no_width, "-", dashes->buf);
 	else
 		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
-			    find_unique_abbrev(&b_util->oid, abbrev));
+			    repo_find_unique_abbrev(the_repository, &b_util->oid, abbrev));
 
 	commit = lookup_commit_reference(the_repository, oid);
 	if (commit) {
diff --git a/read-cache.c b/read-cache.c
index 1bcf6732718..c1d47b9fc83 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2630,7 +2630,7 @@ int repo_index_has_changes(struct repository *repo,
 
 	if (tree)
 		cmp = tree->object.oid;
-	if (tree || !get_oid_tree("HEAD", &cmp)) {
+	if (tree || !repo_get_oid_tree(the_repository, "HEAD", &cmp)) {
 		struct diff_options opt;
 
 		repo_diff_setup(repo, &opt);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 7407c593191..c151db0ad2f 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -187,7 +187,7 @@ int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
 		struct commit *commit = item->commit;
 		if (commit && !*commit_seen_at(&commit_seen, commit)) {
 			strbuf_addf(&missing, " - %s %.*s\n",
-				    find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV),
+				    repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV),
 				    item->arg_len,
 				    todo_item_get_arg(old_todo, item));
 			*commit_seen_at(&commit_seen, commit) = 1;
diff --git a/ref-filter.c b/ref-filter.c
index ed802778da7..4982841b3da 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1093,9 +1093,11 @@ static const char *do_grab_oid(const char *field, const struct object_id *oid,
 	case O_FULL:
 		return oid_to_hex(oid);
 	case O_LENGTH:
-		return find_unique_abbrev(oid, atom->u.oid.length);
+		return repo_find_unique_abbrev(the_repository, oid,
+					       atom->u.oid.length);
 	case O_SHORT:
-		return find_unique_abbrev(oid, DEFAULT_ABBREV);
+		return repo_find_unique_abbrev(the_repository, oid,
+					       DEFAULT_ABBREV);
 	default:
 		BUG("unknown %%(%s) option", field);
 	}
@@ -2783,7 +2785,7 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (get_oid(arg, &oid))
+	if (repo_get_oid(the_repository, arg, &oid))
 		die(_("malformed object name %s"), arg);
 
 	merge_commit = lookup_commit_reference_gently(the_repository, &oid, 0);
diff --git a/remote.c b/remote.c
index b04e5da3383..a0f22c8751e 100644
--- a/remote.c
+++ b/remote.c
@@ -1165,7 +1165,7 @@ static int try_explicit_object_name(const char *name,
 		return 0;
 	}
 
-	if (get_oid(name, &oid))
+	if (repo_get_oid(the_repository, name, &oid))
 		return -1;
 
 	if (match) {
@@ -1253,7 +1253,7 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 	if (!advice_enabled(ADVICE_PUSH_UNQUALIFIED_REF_NAME))
 		return;
 
-	if (get_oid(matched_src_name, &oid))
+	if (repo_get_oid(the_repository, matched_src_name, &oid))
 		BUG("'%s' is not a valid object, "
 		    "match_explicit_lhs() should catch this!",
 		    matched_src_name);
@@ -2507,7 +2507,7 @@ static int parse_push_cas_option(struct push_cas_option *cas, const char *arg, i
 		entry->use_tracking = 1;
 	else if (!colon[1])
 		oidclr(&entry->expect);
-	else if (get_oid(colon + 1, &entry->expect))
+	else if (repo_get_oid(the_repository, colon + 1, &entry->expect))
 		return error(_("cannot parse expected object name '%s'"),
 			     colon + 1);
 	return 0;
diff --git a/reset.c b/reset.c
index 58b3829ff73..8c471e22d99 100644
--- a/reset.c
+++ b/reset.c
@@ -39,7 +39,7 @@ static int update_refs(const struct reset_head_opts *opts,
 	prefix_len = msg.len;
 
 	if (update_orig_head) {
-		if (!get_oid("ORIG_HEAD", &oid_old_orig))
+		if (!repo_get_oid(the_repository, "ORIG_HEAD", &oid_old_orig))
 			old_orig = &oid_old_orig;
 		if (head) {
 			if (!reflog_orig_head) {
@@ -107,7 +107,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
-	if (!get_oid("HEAD", &head_oid)) {
+	if (!repo_get_oid(the_repository, "HEAD", &head_oid)) {
 		head = &head_oid;
 	} else if (!oid || !reset_hard) {
 		ret = error(_("could not determine HEAD revision"));
diff --git a/revision.c b/revision.c
index e4c066e90b7..e08f697c47c 100644
--- a/revision.c
+++ b/revision.c
@@ -326,7 +326,8 @@ static void add_pending_object_with_path(struct rev_info *revs,
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
 		struct strbuf buf = STRBUF_INIT;
 		size_t namelen = strlen(name);
-		int len = interpret_branch_name(name, namelen, &buf, &options);
+		int len = repo_interpret_branch_name(the_repository, name,
+						     namelen, &buf, &options);
 
 		if (0 < len && len < namelen && buf.len)
 			strbuf_addstr(&buf, name + len);
@@ -356,7 +357,7 @@ void add_head_to_pending(struct rev_info *revs)
 {
 	struct object_id oid;
 	struct object *obj;
-	if (get_oid("HEAD", &oid))
+	if (repo_get_oid(the_repository, "HEAD", &oid))
 		return;
 	obj = parse_object(revs->repo, &oid);
 	if (!obj)
@@ -1870,7 +1871,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 		flags ^= UNINTERESTING | BOTTOM;
 		arg++;
 	}
-	if (get_oid_committish(arg, &oid))
+	if (repo_get_oid_committish(the_repository, arg, &oid))
 		return 0;
 	while (1) {
 		it = get_reference(revs, arg, &oid, 0);
@@ -1951,10 +1952,10 @@ static void prepare_show_merge(struct rev_info *revs)
 	int i, prune_num = 1; /* counting terminating NULL */
 	struct index_state *istate = revs->repo->index;
 
-	if (get_oid("HEAD", &oid))
+	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (get_oid("MERGE_HEAD", &oid))
+	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
 		die("--merge without MERGE_HEAD?");
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca20..d73827632d8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -417,7 +417,8 @@ struct commit_message {
 
 static const char *short_commit_name(struct commit *commit)
 {
-	return find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV);
+	return repo_find_unique_abbrev(the_repository, &commit->object.oid,
+				       DEFAULT_ABBREV);
 }
 
 static int get_message(struct commit *commit, struct commit_message *out)
@@ -559,7 +560,7 @@ static void update_abort_safety_file(void)
 	if (!file_exists(git_path_seq_dir()))
 		return;
 
-	if (!get_oid("HEAD", &head))
+	if (!repo_get_oid(the_repository, "HEAD", &head))
 		write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
 	else
 		write_file(git_path_abort_safety_file(), "%s", "");
@@ -1404,7 +1405,7 @@ static int parse_head(struct repository *r, struct commit **head)
 	struct commit *current_head;
 	struct object_id oid;
 
-	if (get_oid("HEAD", &oid)) {
+	if (repo_get_oid(the_repository, "HEAD", &oid)) {
 		current_head = NULL;
 	} else {
 		current_head = lookup_commit_reference(r, &oid);
@@ -1995,7 +1996,7 @@ static int update_squash_messages(struct repository *r,
 		struct commit *head_commit;
 		const char *head_message, *body;
 
-		if (get_oid("HEAD", &head))
+		if (repo_get_oid(the_repository, "HEAD", &head))
 			return error(_("need a HEAD to fixup"));
 		if (!(head_commit = lookup_commit_reference(r, &head)))
 			return error(_("could not read HEAD"));
@@ -2065,7 +2066,7 @@ static void flush_rewritten_pending(void)
 	FILE *out;
 
 	if (strbuf_read_file(&buf, rebase_path_rewritten_pending(), (GIT_MAX_HEXSZ + 1) * 2) > 0 &&
-	    !get_oid("HEAD", &newoid) &&
+	    !repo_get_oid(the_repository, "HEAD", &newoid) &&
 	    (out = fopen_or_warn(rebase_path_rewritten_list(), "a"))) {
 		char *bol = buf.buf, *eol;
 
@@ -2150,7 +2151,7 @@ static int do_pick_commit(struct repository *r,
 		if (write_index_as_tree(&head, r->index, r->index_file, 0, NULL))
 			return error(_("your index file is unmerged."));
 	} else {
-		unborn = get_oid("HEAD", &head);
+		unborn = repo_get_oid(the_repository, "HEAD", &head);
 		/* Do we want to generate a root commit? */
 		if (is_pick_or_similar(command) && opts->have_squash_onto &&
 		    oideq(&head, &opts->squash_onto)) {
@@ -2604,7 +2605,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
-	status = get_oid(bol, &commit_oid);
+	status = repo_get_oid(the_repository, bol, &commit_oid);
 	if (status < 0)
 		error(_("could not parse '%s'"), bol); /* return later */
 	*end_of_object_name = saved;
@@ -3025,7 +3026,7 @@ static int read_populate_opts(struct replay_opts *opts)
 		}
 
 		if (read_oneliner(&buf, rebase_path_squash_onto(), 0)) {
-			if (get_oid_committish(buf.buf, &opts->squash_onto) < 0) {
+			if (repo_get_oid_committish(the_repository, buf.buf, &opts->squash_onto) < 0) {
 				ret = error(_("unusable squash-onto"));
 				goto done_rebase_i;
 			}
@@ -3226,7 +3227,7 @@ static int rollback_is_safe(void)
 	else
 		die_errno(_("could not read '%s'"), git_path_abort_safety_file());
 
-	if (get_oid("HEAD", &actual_head))
+	if (repo_get_oid(the_repository, "HEAD", &actual_head))
 		oidclr(&actual_head);
 
 	return oideq(&actual_head, &expected_head);
@@ -3537,7 +3538,7 @@ static int intend_to_amend(void)
 	struct object_id head;
 	char *p;
 
-	if (get_oid("HEAD", &head))
+	if (repo_get_oid(the_repository, "HEAD", &head))
 		return error(_("cannot read HEAD"));
 
 	p = oid_to_hex(&head);
@@ -3703,7 +3704,7 @@ static int do_label(struct repository *r, const char *name, int len)
 	if (!transaction) {
 		error("%s", err.buf);
 		ret = -1;
-	} else if (get_oid("HEAD", &head_oid)) {
+	} else if (repo_get_oid(the_repository, "HEAD", &head_oid)) {
 		error(_("could not read HEAD"));
 		ret = -1;
 	} else if (ref_transaction_update(transaction, ref_name.buf, &head_oid,
@@ -4459,7 +4460,7 @@ void create_autostash(struct repository *r, const char *path)
 		if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
 			die(_("Cannot autostash"));
 		strbuf_trim_trailing_newline(&buf);
-		if (get_oid(buf.buf, &oid))
+		if (repo_get_oid(the_repository, buf.buf, &oid))
 			die(_("Unexpected stash response: '%s'"),
 			    buf.buf);
 		strbuf_reset(&buf);
@@ -4584,7 +4585,7 @@ static int stopped_at_head(struct repository *r)
 	struct commit *commit;
 	struct commit_message message;
 
-	if (get_oid("HEAD", &head) ||
+	if (repo_get_oid(the_repository, "HEAD", &head) ||
 	    !(commit = lookup_commit(r, &head)) ||
 	    parse_commit(commit) || get_message(commit, &message))
 		fprintf(stderr, _("Stopped at HEAD\n"));
@@ -4734,7 +4735,7 @@ static int pick_commits(struct repository *r,
 				 * otherwise we do not.
 				 */
 				if (item->command == TODO_REWORD &&
-				    !get_oid("HEAD", &oid) &&
+				    !repo_get_oid(the_repository, "HEAD", &oid) &&
 				    (oideq(&item->commit->object.oid, &oid) ||
 				     (opts->have_squash_onto &&
 				      oideq(&opts->squash_onto, &oid))))
@@ -4823,7 +4824,7 @@ static int pick_commits(struct repository *r,
 			struct object_id head, orig;
 			int res;
 
-			if (get_oid("HEAD", &head)) {
+			if (repo_get_oid(the_repository, "HEAD", &head)) {
 				res = error(_("cannot read HEAD"));
 cleanup_head_ref:
 				strbuf_release(&head_ref);
@@ -4870,8 +4871,8 @@ static int pick_commits(struct repository *r,
 			log_tree_opt.disable_stdin = 1;
 
 			if (read_oneliner(&buf, rebase_path_orig_head(), 0) &&
-			    !get_oid(buf.buf, &orig) &&
-			    !get_oid("HEAD", &head)) {
+			    !repo_get_oid(the_repository, buf.buf, &orig) &&
+			    !repo_get_oid(the_repository, "HEAD", &head)) {
 				diff_tree_oid(&orig, &head, "",
 					      &log_tree_opt.diffopt);
 				log_tree_diff_flush(&log_tree_opt);
@@ -4963,7 +4964,7 @@ static int commit_staged_changes(struct repository *r,
 		struct strbuf rev = STRBUF_INIT;
 		struct object_id head, to_amend;
 
-		if (get_oid("HEAD", &head))
+		if (repo_get_oid(the_repository, "HEAD", &head))
 			return error(_("cannot amend non-existing commit"));
 		if (!read_oneliner(&rev, rebase_path_amend(), 0))
 			return error(_("invalid file: '%s'"), rebase_path_amend());
@@ -5188,7 +5189,7 @@ int sequencer_pick_revisions(struct repository *r,
 		if (!strlen(name))
 			continue;
 
-		if (!get_oid(name, &oid)) {
+		if (!repo_get_oid(the_repository, name, &oid)) {
 			if (!lookup_commit_reference_gently(r, &oid, 1)) {
 				enum object_type type = oid_object_info(r,
 									&oid,
@@ -5231,7 +5232,7 @@ int sequencer_pick_revisions(struct repository *r,
 	if (walk_revs_populate_todo(&todo_list, opts) ||
 			create_seq_dir(r) < 0)
 		return -1;
-	if (get_oid("HEAD", &oid) && (opts->action == REPLAY_REVERT))
+	if (repo_get_oid(the_repository, "HEAD", &oid) && (opts->action == REPLAY_REVERT))
 		return error(_("can't revert as initial commit"));
 	if (save_head(oid_to_hex(&oid)))
 		return -1;
@@ -5363,7 +5364,8 @@ static const char *label_oid(struct object_id *oid, const char *label,
 		strbuf_grow(&state->buf, GIT_MAX_HEXSZ);
 		label = p = state->buf.buf;
 
-		find_unique_abbrev_r(p, oid, default_abbrev);
+		repo_find_unique_abbrev_r(the_repository, p, oid,
+					  default_abbrev);
 
 		/*
 		 * We may need to extend the abbreviated hash so that there is
@@ -6096,7 +6098,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	struct object_id oid = onto->object.oid;
 	int res;
 
-	find_unique_abbrev_r(shortonto, &oid, DEFAULT_ABBREV);
+	repo_find_unique_abbrev_r(the_repository, shortonto, &oid,
+				  DEFAULT_ABBREV);
 
 	if (buf->len == 0) {
 		struct todo_item *item = append_new_todo(todo_list);
@@ -6372,8 +6375,8 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 		if (file_exists(git_path_seq_dir()))
 			*whence = FROM_CHERRY_PICK_MULTI;
 		if (file_exists(rebase_path()) &&
-		    !get_oid("REBASE_HEAD", &rebase_head) &&
-		    !get_oid("CHERRY_PICK_HEAD", &cherry_pick_head) &&
+		    !repo_get_oid(the_repository, "REBASE_HEAD", &rebase_head) &&
+		    !repo_get_oid(the_repository, "CHERRY_PICK_HEAD", &cherry_pick_head) &&
 		    oideq(&rebase_head, &cherry_pick_head))
 			*whence = FROM_REBASE_PICK;
 		else
diff --git a/submodule-config.c b/submodule-config.c
index 89a7bf0a93d..57972c3e131 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -537,7 +537,7 @@ static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
 	}
 
 	strbuf_addf(rev, "%s:.gitmodules", oid_to_hex(treeish_name));
-	if (get_oid(rev->buf, gitmodules_oid) >= 0)
+	if (repo_get_oid(the_repository, rev->buf, gitmodules_oid) >= 0)
 		ret = 1;
 
 	return ret;
diff --git a/submodule.c b/submodule.c
index 2a057c35b74..f028044e2dc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -66,7 +66,7 @@ int is_writing_gitmodules_ok(void)
 {
 	struct object_id oid;
 	return file_exists(GITMODULES_FILE) ||
-		(get_oid(GITMODULES_INDEX, &oid) < 0 && get_oid(GITMODULES_HEAD, &oid) < 0);
+		(repo_get_oid(the_repository, GITMODULES_INDEX, &oid) < 0 && repo_get_oid(the_repository, GITMODULES_HEAD, &oid) < 0);
 }
 
 /*
@@ -1626,7 +1626,7 @@ get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
 		if (!task->repo) {
 			strbuf_addf(err, _("Could not access submodule '%s' at commit %s\n"),
 				    cs_data->path,
-				    find_unique_abbrev(cs_data->super_oid, DEFAULT_ABBREV));
+				    repo_find_unique_abbrev(the_repository, cs_data->super_oid, DEFAULT_ABBREV));
 
 			fetch_task_release(task);
 			free(task);
@@ -1637,8 +1637,8 @@ get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
 			strbuf_addf(err,
 				    _("Fetching submodule %s%s at commit %s\n"),
 				    spf->prefix, task->sub->path,
-				    find_unique_abbrev(cs_data->super_oid,
-						       DEFAULT_ABBREV));
+				    repo_find_unique_abbrev(the_repository, cs_data->super_oid,
+							    DEFAULT_ABBREV));
 
 		spf->changed_count++;
 		/*
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index b1edb92a032..3f8d5761780 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -26,7 +26,8 @@
 
 static const char *short_commit_name(struct commit *commit)
 {
-	return find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV);
+	return repo_find_unique_abbrev(the_repository, &commit->object.oid,
+				       DEFAULT_ABBREV);
 }
 
 static struct commit *peel_committish(const char *name)
@@ -34,10 +35,11 @@ static struct commit *peel_committish(const char *name)
 	struct object *obj;
 	struct object_id oid;
 
-	if (get_oid(name, &oid))
+	if (repo_get_oid(the_repository, name, &oid))
 		return NULL;
 	obj = parse_object(the_repository, &oid);
-	return (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
+	return (struct commit *)repo_peel_to_type(the_repository, name, 0, obj,
+						  OBJ_COMMIT);
 }
 
 static char *get_author(const char *message)
@@ -120,7 +122,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 	strbuf_addf(&branch_name, "refs/heads/%s", argv[4]);
 
 	/* Sanity check */
-	if (get_oid("HEAD", &head))
+	if (repo_get_oid(the_repository, "HEAD", &head))
 		die(_("Cannot read HEAD"));
 	assert(oideq(&onto->object.oid, &head));
 
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 04bc2563f3e..f2ae92ca2c8 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -10,9 +10,9 @@ int cmd__match_trees(int ac, const char **av)
 
 	setup_git_directory();
 
-	if (get_oid(av[1], &hash1))
+	if (repo_get_oid(the_repository, av[1], &hash1))
 		die("cannot parse %s as an object name", av[1]);
-	if (get_oid(av[2], &hash2))
+	if (repo_get_oid(the_repository, av[2], &hash2))
 		die("cannot parse %s as an object name", av[2]);
 	one = parse_tree_indirect(&hash1);
 	if (!one)
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 883d40efd45..8c9b6e7f695 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -50,7 +50,7 @@ int cmd__oidmap(int argc, const char **argv)
 
 		if (!strcmp("put", cmd) && p1 && p2) {
 
-			if (get_oid(p1, &oid)) {
+			if (repo_get_oid(the_repository, p1, &oid)) {
 				printf("Unknown oid: %s\n", p1);
 				continue;
 			}
@@ -68,7 +68,7 @@ int cmd__oidmap(int argc, const char **argv)
 
 		} else if (!strcmp("get", cmd) && p1) {
 
-			if (get_oid(p1, &oid)) {
+			if (repo_get_oid(the_repository, p1, &oid)) {
 				printf("Unknown oid: %s\n", p1);
 				continue;
 			}
@@ -81,7 +81,7 @@ int cmd__oidmap(int argc, const char **argv)
 
 		} else if (!strcmp("remove", cmd) && p1) {
 
-			if (get_oid(p1, &oid)) {
+			if (repo_get_oid(the_repository, p1, &oid)) {
 				printf("Unknown oid: %s\n", p1);
 				continue;
 			}
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index de8f26639d4..afb9bb3189f 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -58,7 +58,7 @@ int cmd__reach(int ac, const char **av)
 		if (buf.len < 3)
 			continue;
 
-		if (get_oid_committish(buf.buf + 2, &oid))
+		if (repo_get_oid_committish(the_repository, buf.buf + 2, &oid))
 			die("failed to resolve %s", buf.buf + 2);
 
 		orig = parse_object(r, &oid);
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 22a41c40926..91c82d4159d 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -42,7 +42,7 @@ int cmd__submodule_config(int argc, const char **argv)
 
 		if (commit[0] == '\0')
 			oidclr(&commit_oid);
-		else if (get_oid(commit, &commit_oid) < 0)
+		else if (repo_get_oid(the_repository, commit, &commit_oid) < 0)
 			die_usage(argc, argv, "Commit not found.");
 
 		if (lookup_name) {
diff --git a/tag.c b/tag.c
index 18b718cca66..85c348ad824 100644
--- a/tag.c
+++ b/tag.c
@@ -52,7 +52,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name_to_report ?
 				name_to_report :
-				find_unique_abbrev(oid, DEFAULT_ABBREV),
+				repo_find_unique_abbrev(the_repository, oid, DEFAULT_ABBREV),
 				type_name(type));
 
 	buf = read_object_file(oid, &type, &size);
@@ -60,7 +60,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 		return error("%s: unable to read file.",
 				name_to_report ?
 				name_to_report :
-				find_unique_abbrev(oid, DEFAULT_ABBREV));
+				repo_find_unique_abbrev(the_repository, oid, DEFAULT_ABBREV));
 
 	ret = run_gpg_verify(buf, size, flags);
 
diff --git a/transport-helper.c b/transport-helper.c
index 82ac63e2609..1939763ab5d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1082,7 +1082,7 @@ static int push_refs_with_export(struct transport *transport,
 		struct object_id oid;
 
 		private = apply_refspecs(&data->rs, ref->name);
-		if (private && !get_oid(private, &oid)) {
+		if (private && !repo_get_oid(the_repository, private, &oid)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append_nodup(&revlist_args,
 						 strbuf_detach(&buf, NULL));
diff --git a/transport.c b/transport.c
index 906dbad5a08..dbbfeb8d010 100644
--- a/transport.c
+++ b/transport.c
@@ -779,7 +779,8 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 static int measure_abbrev(const struct object_id *oid, int sofar)
 {
 	char hex[GIT_MAX_HEXSZ + 1];
-	int w = find_unique_abbrev_r(hex, oid, DEFAULT_ABBREV);
+	int w = repo_find_unique_abbrev_r(the_repository, hex, oid,
+					  DEFAULT_ABBREV);
 
 	return (w < sofar) ? sofar : w;
 }
diff --git a/wt-status.c b/wt-status.c
index 90525bd26fd..0f0b92eece4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1338,7 +1338,7 @@ static void abbrev_oid_in_line(struct strbuf *line)
 		 * it after abbreviation.
 		 */
 		strbuf_trim(split[1]);
-		if (!get_oid(split[1]->buf, &oid)) {
+		if (!repo_get_oid(the_repository, split[1]->buf, &oid)) {
 			strbuf_reset(split[1]);
 			strbuf_add_unique_abbrev(split[1], &oid,
 						 DEFAULT_ABBREV);
@@ -1504,8 +1504,8 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 	else
 		status_printf_ln(s, color,
 			_("You are currently cherry-picking commit %s."),
-			find_unique_abbrev(&s->state.cherry_pick_head_oid,
-					   DEFAULT_ABBREV));
+			repo_find_unique_abbrev(the_repository, &s->state.cherry_pick_head_oid,
+						DEFAULT_ABBREV));
 
 	if (s->hints) {
 		if (has_unmerged(s))
@@ -1534,8 +1534,8 @@ static void show_revert_in_progress(struct wt_status *s,
 	else
 		status_printf_ln(s, color,
 			_("You are currently reverting commit %s."),
-			find_unique_abbrev(&s->state.revert_head_oid,
-					   DEFAULT_ABBREV));
+			repo_find_unique_abbrev(the_repository, &s->state.revert_head_oid,
+						DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1677,9 +1677,9 @@ static void wt_status_get_detached_from(struct repository *r,
 		state->detached_from = xstrdup(from);
 	} else
 		state->detached_from =
-			xstrdup(find_unique_abbrev(&cb.noid, DEFAULT_ABBREV));
+			xstrdup(repo_find_unique_abbrev(the_repository, &cb.noid, DEFAULT_ABBREV));
 	oidcpy(&state->detached_oid, &cb.noid);
-	state->detached_at = !get_oid("HEAD", &oid) &&
+	state->detached_at = !repo_get_oid(the_repository, "HEAD", &oid) &&
 			     oideq(&oid, &state->detached_oid);
 
 	free(ref);
@@ -1770,13 +1770,13 @@ void wt_status_get_state(struct repository *r,
 	} else if (wt_status_check_rebase(NULL, state)) {
 		;		/* all set */
 	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
-		   !get_oid("CHERRY_PICK_HEAD", &oid)) {
+		   !repo_get_oid(the_repository, "CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
 	wt_status_check_bisect(NULL, state);
 	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
-	    !get_oid("REVERT_HEAD", &oid)) {
+	    !repo_get_oid(the_repository, "REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
 		oidcpy(&state->revert_head_oid, &oid);
 	}
-- 
2.40.0.rc1.1034.g5867a1b10c5

