Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C4AC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FE820771
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRGmdkMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405353AbgFSPzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392836AbgFSPVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 11:21:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA829C0613F0
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 08:21:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f185so9472687wmf.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=She8SLUBVexCyT2wdw5ZzfdUPxNkxXz2qt7g2es+G10=;
        b=gRGmdkMOH35YRPhAkWz7XPa6sgOngEmm4zvJecnno5UtLl+dxFC9GU0+W18o6AjP9x
         r6FukLEW2YARhqgAyze25lwarEuEyDJZhRL3H61OHsQBd3IvEntQ+Nj3aEBjmVSwGhqI
         vuFq/a6wFJ6f6zFZOd2XI3OOI02RrlNiQOUbDLHCOSlXplakKCw2oWFTyPBoNapkIRuw
         /TntRpiPjAxASOQQQBK8Wo+QTZcfGWdqvLyHw4Sx5cN3ROfSAMCFwCGFQXDZzkGAZ+yB
         d5EZdxiQTd2V/kN4vN6VIt0nrGx3iJsNKul6StxaS5mUykEm22nPizINx/+ORI92ubMI
         RJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=She8SLUBVexCyT2wdw5ZzfdUPxNkxXz2qt7g2es+G10=;
        b=sRLHdjRhdBM2vmgJVdPsVvVAqE0pxpAVeXyfyoUuqaw88j+zaphlTb+rBEQZfSa06C
         sOMm22/YIv7bnqkSEvy1itqE8WcOPQsixR8KHMYl7kDQj5UJxZvhLf/iYvqYBwLPNgcJ
         cEEm+TXRaXIfY8U2c5mR2AelR3wNjxXLu37aEOdXmoGWhnGW2VMFoEFVysCVTfR7y0iF
         zzVB7TV1AvObimcb7AvnAmn5qOcH0QDKoFAW9zxbgPq8QR2vG7Fr9aVnV7ZPQJzyvG8T
         4eWS245bsYYEqHizYm+Iz1RtVvhlouykBBdRPsReDkSPv4KoJypdzgmDpieBrz0q3t8W
         IIjw==
X-Gm-Message-State: AOAM532dmX9fvCY3aYDQRQ2Ntrxw2aVonVU8AOUurRDSggxF3WdVZZkH
        eHc7/8L4PfTsjqu3Jkg+JjEgyrWQ
X-Google-Smtp-Source: ABdhPJwd5FnR0SxSxqP6fhHiTtt0NgMGCt5LBQ1mn8zaMzi+XmZwjTHpx39/QDvP66sWyKDVpEUatA==
X-Received: by 2002:a1c:7d4c:: with SMTP id y73mr4191982wmc.188.1592580074832;
        Fri, 19 Jun 2020 08:21:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm7357506wrx.8.2020.06.19.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:21:14 -0700 (PDT)
Message-Id: <b5f881ba1adbab94a08c7336ad3b674370acb6d8.1592580071.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.665.git.1592580071.gitgitgadget@gmail.com>
References: <pull.665.git.1592580071.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Jun 2020 15:21:09 +0000
Subject: [PATCH 2/3] refs: update update_ref() to take a struct repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

There are a number of places where we create pseudo refs such as
CHERRY_PICK head where the deletion takes a struct repository* but the
creation of the ref does not. Change update_ref() so that creation and
deletion match.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 bisect.c                 | 18 +++++++++++-------
 builtin/am.c             | 10 +++++-----
 builtin/bisect--helper.c |  6 +++---
 builtin/checkout.c       |  3 ++-
 builtin/clone.c          | 16 ++++++++--------
 builtin/merge.c          | 10 +++++-----
 builtin/notes.c          | 10 +++++-----
 builtin/pull.c           |  3 ++-
 builtin/reset.c          |  8 ++++----
 builtin/stash.c          |  2 +-
 builtin/update-ref.c     |  3 ++-
 diff.c                   |  2 +-
 notes-cache.c            |  4 ++--
 notes-cache.h            |  2 +-
 notes-utils.c            |  2 +-
 refs.c                   |  4 ++--
 refs.h                   |  2 +-
 reset.c                  |  6 +++---
 sequencer.c              | 21 +++++++++++----------
 transport-helper.c       | 32 ++++++++++++++++++--------------
 transport-internal.h     |  4 +++-
 transport.c              |  8 +++++---
 22 files changed, 96 insertions(+), 80 deletions(-)

diff --git a/bisect.c b/bisect.c
index d5e830410f5..f2987df1c40 100644
--- a/bisect.c
+++ b/bisect.c
@@ -704,17 +704,20 @@ static int is_expected_rev(const struct object_id *oid)
 	return res;
 }
 
-static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
+static enum bisect_error bisect_checkout(struct repository *r,
+					 const struct object_id *bisect_rev,
+					 int no_checkout)
 {
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 	enum bisect_error res = BISECT_OK;
 
 	memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), the_hash_algo->hexsz + 1);
-	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	update_ref(r, NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0,
+		   UPDATE_REFS_DIE_ON_ERR);
 
 	argv_checkout[2] = bisect_rev_hex;
 	if (no_checkout) {
-		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
+		update_ref(r, NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	} else {
 		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
@@ -820,7 +823,8 @@ static void handle_skipped_merge_base(const struct object_id *mb)
  * for early success, this will be converted back to 0 in
  * check_good_are_ancestors_of_bad().
  */
-static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
+static enum bisect_error check_merge_bases(struct repository *r, int rev_nr,
+					   struct commit **rev, int no_checkout)
 {
 	enum bisect_error res = BISECT_OK;
 	struct commit_list *result;
@@ -838,7 +842,7 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
-			res = bisect_checkout(mb, no_checkout);
+			res = bisect_checkout(r, mb, no_checkout);
 			if (!res)
 				/* indicate early success */
 				res = BISECT_INTERNAL_SUCCESS_MERGE_BASE;
@@ -903,7 +907,7 @@ static enum bisect_error check_good_are_ancestors_of_bad(struct repository *r,
 
 	rev = get_bad_and_good_commits(r, &rev_nr);
 	if (check_ancestors(r, rev_nr, rev, prefix))
-		res = check_merge_bases(rev_nr, rev, no_checkout);
+		res = check_merge_bases(r, rev_nr, rev, no_checkout);
 	free(rev);
 
 	if (!res) {
@@ -1065,7 +1069,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 		  nr), nr, steps_msg);
 	free(steps_msg);
 
-	return bisect_checkout(bisect_rev, no_checkout);
+	return bisect_checkout(r, bisect_rev, no_checkout);
 }
 
 static inline int log2i(int n)
diff --git a/builtin/am.c b/builtin/am.c
index cd2e3f1f3b5..2adc6b7ab7f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1013,8 +1013,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	if (!get_oid("HEAD", &curr_head)) {
 		write_state_text(state, "abort-safety", oid_to_hex(&curr_head));
 		if (!state->rebasing)
-			update_ref("am", "ORIG_HEAD", &curr_head, NULL, 0,
-				   UPDATE_REFS_DIE_ON_ERR);
+			update_ref(the_repository, "am", "ORIG_HEAD",
+				   &curr_head, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 	} else {
 		write_state_text(state, "abort-safety", "");
 		if (!state->rebasing)
@@ -1378,7 +1378,7 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
 
 	oidcpy(&state->orig_commit, &commit_oid);
 	write_state_text(state, "original-commit", oid_to_hex(&commit_oid));
-	update_ref("am", "REBASE_HEAD", &commit_oid,
+	update_ref(the_repository, "am", "REBASE_HEAD", &commit_oid,
 		   NULL, REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 
 	return 0;
@@ -1594,7 +1594,7 @@ static void do_commit(const struct am_state *state)
 	strbuf_addf(&sb, "%s: %.*s", reflog_msg, linelen(state->msg),
 			state->msg);
 
-	update_ref(sb.buf, "HEAD", &commit, old_oid, 0,
+	update_ref(the_repository, sb.buf, "HEAD", &commit, old_oid, 0,
 		   UPDATE_REFS_DIE_ON_ERR);
 
 	if (state->rebasing) {
@@ -2055,7 +2055,7 @@ static void am_abort(struct am_state *state)
 	clean_index(&curr_head, &orig_head);
 
 	if (has_orig_head)
-		update_ref("am --abort", "HEAD", &orig_head,
+		update_ref(the_repository, "am --abort", "HEAD", &orig_head,
 			   has_curr_head ? &curr_head : NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	else if (curr_branch)
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ec4996282e3..09b37b67913 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -222,7 +222,7 @@ static int bisect_write(const char *state, const char *rev,
 		goto finish;
 	}
 
-	if (update_ref(NULL, tag.buf, &oid, NULL, 0,
+	if (update_ref(the_repository, NULL, tag.buf, &oid, NULL, 0,
 		       UPDATE_REFS_MSG_ON_ERR)) {
 		res = -1;
 		goto finish;
@@ -582,8 +582,8 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			res = error(_("invalid ref: '%s'"), start_head.buf);
 			goto finish;
 		}
-		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
-			       UPDATE_REFS_MSG_ON_ERR)) {
+		if (update_ref(the_repository, NULL, "BISECT_HEAD", &oid, NULL,
+			       0, UPDATE_REFS_MSG_ON_ERR)) {
 			res = -1;
 			goto finish;
 		}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index af849c644fe..4f8c9924953 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -892,7 +892,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (!strcmp(new_branch_info->name, "HEAD") && !new_branch_info->path && !opts->force_detach) {
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new_branch_info->path) {	/* No longer on any branch. */
-		update_ref(msg.buf, "HEAD", &new_branch_info->commit->object.oid, NULL,
+		update_ref(the_repository, msg.buf, "HEAD",
+			   &new_branch_info->commit->object.oid, NULL,
 			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old_branch_info->path &&
diff --git a/builtin/clone.c b/builtin/clone.c
index 2a8e3aaaed3..6d7686df758 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -647,8 +647,8 @@ static void write_followtags(const struct ref *refs, const char *msg)
 						OBJECT_INFO_QUICK |
 						OBJECT_INFO_SKIP_FETCH_OBJECT))
 			continue;
-		update_ref(msg, ref->name, &ref->old_oid, NULL, 0,
-			   UPDATE_REFS_DIE_ON_ERR);
+		update_ref(the_repository, msg, ref->name, &ref->old_oid, NULL,
+			   0, UPDATE_REFS_DIE_ON_ERR);
 	}
 }
 
@@ -719,24 +719,24 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		if (create_symref("HEAD", our->name, NULL) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare) {
-			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
-				   UPDATE_REFS_DIE_ON_ERR);
+			update_ref(the_repository, msg, "HEAD", &our->old_oid,
+				   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(the_repository,
 							   &our->old_oid);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
-		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
-			   UPDATE_REFS_DIE_ON_ERR);
+		update_ref(the_repository, msg, "HEAD", &c->object.oid, NULL,
+			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 	} else if (remote) {
 		/*
 		 * We know remote HEAD points to a non-branch, or
 		 * HEAD points to a branch but we don't know which one.
 		 * Detach HEAD in all these cases.
 		 */
-		update_ref(msg, "HEAD", &remote->old_oid, NULL, REF_NO_DEREF,
-			   UPDATE_REFS_DIE_ON_ERR);
+		update_ref(the_repository, msg, "HEAD", &remote->old_oid, NULL,
+			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 	}
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 7da707bf55d..72633be6503 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -450,8 +450,8 @@ static void finish(struct commit *head_commit,
 		if (verbosity >= 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
 		else {
-			update_ref(reflog_message.buf, "HEAD", new_head, head,
-				   0, UPDATE_REFS_DIE_ON_ERR);
+			update_ref(the_repository, reflog_message.buf, "HEAD",
+				   new_head, head, 0, UPDATE_REFS_DIE_ON_ERR);
 			/*
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
@@ -1423,8 +1423,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		remote_head_oid = &remoteheads->item->object.oid;
 		read_empty(remote_head_oid, 0);
-		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
-			   UPDATE_REFS_DIE_ON_ERR);
+		update_ref(the_repository, "initial pull", "HEAD",
+			   remote_head_oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 		goto done;
 	}
 
@@ -1490,7 +1490,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		free(list);
 	}
 
-	update_ref("updating ORIG_HEAD", "ORIG_HEAD",
+	update_ref(the_repository, "updating ORIG_HEAD", "ORIG_HEAD",
 		   &head_commit->object.oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
 	if (remoteheads && !common) {
diff --git a/builtin/notes.c b/builtin/notes.c
index b852afe5a3e..b4a56111209 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -747,7 +747,7 @@ static int merge_commit(struct notes_merge_options *o)
 	format_commit_message(partial, "%s", &msg, &pretty_ctx);
 	strbuf_trim(&msg);
 	strbuf_insertstr(&msg, 0, "notes: ");
-	update_ref(msg.buf, o->local_ref, &oid,
+	update_ref(the_repository, msg.buf, o->local_ref, &oid,
 		   is_null_oid(&parent_oid) ? NULL : &parent_oid,
 		   0, UPDATE_REFS_DIE_ON_ERR);
 
@@ -861,13 +861,13 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	if (result >= 0) /* Merge resulted (trivially) in result_oid */
 		/* Update default notes ref with new commit */
-		update_ref(msg.buf, default_notes_ref(), &result_oid, NULL, 0,
-			   UPDATE_REFS_DIE_ON_ERR);
+		update_ref(the_repository, msg.buf, default_notes_ref(),
+			   &result_oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 	else { /* Merge has unresolved conflicts */
 		const struct worktree *wt;
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
-		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", &result_oid, NULL,
-			   0, UPDATE_REFS_DIE_ON_ERR);
+		update_ref(the_repository, msg.buf, "NOTES_MERGE_PARTIAL",
+			   &result_oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
 		wt = find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
 		if (wt)
diff --git a/builtin/pull.c b/builtin/pull.c
index 00e5857a8d1..ea4148ba1e1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -625,7 +625,8 @@ static int pull_into_void(const struct object_id *merge_head,
 				  merge_head, 0))
 		return 1;
 
-	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
+	if (update_ref(the_repository, "initial pull", "HEAD", merge_head,
+		       curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
 		return 1;
 
 	return 0;
diff --git a/builtin/reset.c b/builtin/reset.c
index de407783c4e..1e89d331788 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -264,13 +264,13 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 	if (!get_oid("HEAD", &oid_orig)) {
 		orig = &oid_orig;
 		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
-		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
-			   UPDATE_REFS_MSG_ON_ERR);
+		update_ref(the_repository, msg.buf, "ORIG_HEAD", orig, old_orig,
+			   0, UPDATE_REFS_MSG_ON_ERR);
 	} else if (old_orig)
 		delete_ref(the_repository, NULL, "ORIG_HEAD", old_orig, 0);
 	set_reflog_message(&msg, "updating HEAD", rev);
-	update_ref_status = update_ref(msg.buf, "HEAD", oid, orig, 0,
-				       UPDATE_REFS_MSG_ON_ERR);
+	update_ref_status = update_ref(the_repository, msg.buf, "HEAD", oid,
+				       orig, 0, UPDATE_REFS_MSG_ON_ERR);
 	strbuf_release(&msg);
 	return update_ref_status;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index dc318cb52be..a9dee125c4f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -792,7 +792,7 @@ static int do_store_stash(const struct object_id *w_commit, const char *stash_ms
 	if (!stash_msg)
 		stash_msg = "Created via \"git stash store\".";
 
-	if (update_ref(stash_msg, ref_stash, w_commit, NULL,
+	if (update_ref(the_repository, stash_msg, ref_stash, w_commit, NULL,
 		       REF_FORCE_CREATE_REFLOG,
 		       quiet ? UPDATE_REFS_QUIET_ON_ERR :
 		       UPDATE_REFS_MSG_ON_ERR)) {
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index b3ec9e5362c..b5534fcc01a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -554,7 +554,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 				  (oldval && !is_null_oid(&oldoid)) ? &oldoid : NULL,
 				  default_flags);
 	else
-		return update_ref(msg, refname, &oid, oldval ? &oldoid : NULL,
+		return update_ref(the_repository, msg, refname, &oid,
+				  oldval ? &oldoid : NULL,
 				  default_flags | create_reflog_flag,
 				  UPDATE_REFS_DIE_ON_ERR);
 }
diff --git a/diff.c b/diff.c
index d24aaa30478..b796ea8f56a 100644
--- a/diff.c
+++ b/diff.c
@@ -6870,7 +6870,7 @@ size_t fill_textconv(struct repository *r,
 		 * Since generating a cache entry is the slow path anyway,
 		 * this extra overhead probably isn't a big deal.
 		 */
-		notes_cache_write(driver->textconv_cache);
+		notes_cache_write(r, driver->textconv_cache);
 	}
 
 	return size;
diff --git a/notes-cache.c b/notes-cache.c
index 2473314d686..cbd41a03f0f 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -48,7 +48,7 @@ void notes_cache_init(struct repository *r, struct notes_cache *c,
 	strbuf_release(&ref);
 }
 
-int notes_cache_write(struct notes_cache *c)
+int notes_cache_write(struct repository *r, struct notes_cache *c)
 {
 	struct object_id tree_oid, commit_oid;
 
@@ -63,7 +63,7 @@ int notes_cache_write(struct notes_cache *c)
 	if (commit_tree(c->validity, strlen(c->validity), &tree_oid, NULL,
 			&commit_oid, NULL, NULL) < 0)
 		return -1;
-	if (update_ref("update notes cache", c->tree.update_ref, &commit_oid,
+	if (update_ref(r, "update notes cache", c->tree.update_ref, &commit_oid,
 		       NULL, 0, UPDATE_REFS_QUIET_ON_ERR) < 0)
 		return -1;
 
diff --git a/notes-cache.h b/notes-cache.h
index 56f8c98e244..f268425fd71 100644
--- a/notes-cache.h
+++ b/notes-cache.h
@@ -12,7 +12,7 @@ struct notes_cache {
 
 void notes_cache_init(struct repository *r, struct notes_cache *c,
 		      const char *name, const char *validity);
-int notes_cache_write(struct notes_cache *c);
+int notes_cache_write(struct repository *r, struct notes_cache *c);
 
 char *notes_cache_get(struct notes_cache *c, struct object_id *oid, size_t
 		      *outsize);
diff --git a/notes-utils.c b/notes-utils.c
index 4bf4888d8c1..fd044cc1546 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -53,7 +53,7 @@ void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
 
 	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
 	strbuf_insertstr(&buf, 0, "notes: ");
-	update_ref(buf.buf, t->update_ref, &commit_oid, NULL, 0,
+	update_ref(r, buf.buf, t->update_ref, &commit_oid, NULL, 0,
 		   UPDATE_REFS_DIE_ON_ERR);
 
 	strbuf_release(&buf);
diff --git a/refs.c b/refs.c
index db2d0907d44..7f120f8d33a 100644
--- a/refs.c
+++ b/refs.c
@@ -1205,12 +1205,12 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	return 0;
 }
 
-int update_ref(const char *msg, const char *refname,
+int update_ref(struct repository *r, const char *msg, const char *refname,
 	       const struct object_id *new_oid,
 	       const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr)
 {
-	return refs_update_ref(get_main_ref_store(the_repository), msg, refname, new_oid,
+	return refs_update_ref(get_main_ref_store(r), msg, refname, new_oid,
 			       old_oid, flags, onerr);
 }
 
diff --git a/refs.h b/refs.h
index 7d9bc045484..b0a7ab490f2 100644
--- a/refs.h
+++ b/refs.h
@@ -728,7 +728,7 @@ void ref_transaction_free(struct ref_transaction *transaction);
 int refs_update_ref(struct ref_store *refs, const char *msg, const char *refname,
 		    const struct object_id *new_oid, const struct object_id *old_oid,
 		    unsigned int flags, enum action_on_err onerr);
-int update_ref(const char *msg, const char *refname,
+int update_ref(struct repository *r, const char *msg, const char *refname,
 	       const struct object_id *new_oid, const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr);
 
diff --git a/reset.c b/reset.c
index 31ec2dbf829..95facc0f4eb 100644
--- a/reset.c
+++ b/reset.c
@@ -104,7 +104,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 				strbuf_addstr(&msg, "updating ORIG_HEAD");
 				reflog_orig_head = msg.buf;
 			}
-			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
+			update_ref(r, reflog_orig_head, "ORIG_HEAD", orig,
 				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
 		} else if (old_orig)
 			delete_ref(r, NULL, "ORIG_HEAD", old_orig, 0);
@@ -116,11 +116,11 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 		reflog_head = msg.buf;
 	}
 	if (!switch_to_branch)
-		ret = update_ref(reflog_head, "HEAD", oid, orig,
+		ret = update_ref(r, reflog_head, "HEAD", oid, orig,
 				 detach_head ? REF_NO_DEREF : 0,
 				 UPDATE_REFS_MSG_ON_ERR);
 	else {
-		ret = update_ref(reflog_head, switch_to_branch, oid,
+		ret = update_ref(r, reflog_head, switch_to_branch, oid,
 				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 		if (!ret)
 			ret = create_symref("HEAD", switch_to_branch,
diff --git a/sequencer.c b/sequencer.c
index 88f1b13a600..0a75e34a372 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1426,9 +1426,9 @@ static int try_to_commit(struct repository *r,
 	return res;
 }
 
-static int write_rebase_head(struct object_id *oid)
+static int write_rebase_head(struct repository *r, struct object_id *oid)
 {
-	if (update_ref("rebase", "REBASE_HEAD", oid,
+	if (update_ref(r, "rebase", "REBASE_HEAD", oid,
 		       NULL, REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
 		return error(_("could not update %s"), "REBASE_HEAD");
 
@@ -1465,7 +1465,7 @@ static int do_commit(struct repository *r,
 	}
 	if (res == 1) {
 		if (is_rebase_i(opts) && oid)
-			if (write_rebase_head(oid))
+			if (write_rebase_head(r, oid))
 			    return -1;
 		return run_git_commit(r, msg_file, opts, flags);
 	}
@@ -1939,11 +1939,11 @@ static int do_pick_commit(struct repository *r,
 	if ((command == TODO_PICK || command == TODO_REWORD ||
 	     command == TODO_EDIT) && !opts->no_commit &&
 	    (res == 0 || res == 1) &&
-	    update_ref(NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL,
+	    update_ref(r, NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL,
 		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
 	if (command == TODO_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
-	    update_ref(NULL, "REVERT_HEAD", &commit->object.oid, NULL,
+	    update_ref(r, NULL, "REVERT_HEAD", &commit->object.oid, NULL,
 		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
 
@@ -3018,7 +3018,7 @@ static int make_patch(struct repository *r,
 	p = short_commit_name(commit);
 	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
 		return -1;
-	res |= write_rebase_head(&commit->object.oid);
+	res |= write_rebase_head(r, &commit->object.oid);
 
 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
@@ -3337,8 +3337,8 @@ static int do_reset(struct repository *r,
 	free((void *)desc.buffer);
 
 	if (!ret)
-		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
-						len, name), "HEAD", &oid,
+		ret = update_ref(r, reflog_message(opts, "reset", "'%.*s'",
+						   len, name), "HEAD", &oid,
 				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 
 	strbuf_release(&ref_name);
@@ -3862,7 +3862,8 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 		return error(_("could not detach HEAD"));
 	}
 
-	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+	return update_ref(r, NULL, "ORIG_HEAD", &oid, NULL, 0,
+			  UPDATE_REFS_MSG_ON_ERR);
 }
 
 static int stopped_at_head(struct repository *r)
@@ -4113,7 +4114,7 @@ static int pick_commits(struct repository *r,
 			}
 			msg = reflog_message(opts, "finish", "%s onto %s",
 				head_ref.buf, buf.buf);
-			if (update_ref(msg, head_ref.buf, &head, &orig,
+			if (update_ref(r, msg, head_ref.buf, &head, &orig,
 				       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 				res = error(_("could not update %s"),
 					head_ref.buf);
diff --git a/transport-helper.c b/transport-helper.c
index a46afcb69db..723eca96c82 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -805,9 +805,10 @@ static int push_update_ref_status(struct strbuf *buf,
 	return !(status == REF_STATUS_OK);
 }
 
-static int push_update_refs_status(struct helper_data *data,
-				    struct ref *remote_refs,
-				    int flags)
+static int push_update_refs_status(struct repository *r,
+				   struct helper_data *data,
+				   struct ref *remote_refs,
+				   int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
@@ -834,7 +835,7 @@ static int push_update_refs_status(struct helper_data *data,
 		private = apply_refspecs(&data->rs, ref->name);
 		if (!private)
 			continue;
-		update_ref("update by helper", private, &ref->new_oid, NULL,
+		update_ref(r, "update by helper", private, &ref->new_oid, NULL,
 			   0, 0);
 		free(private);
 	}
@@ -868,7 +869,8 @@ static void set_common_push_options(struct transport *transport,
 	}
 }
 
-static int push_refs_with_push(struct transport *transport,
+static int push_refs_with_push(struct repository *r,
+			       struct transport *transport,
 			       struct ref *remote_refs, int flags)
 {
 	int force_all = flags & TRANSPORT_PUSH_FORCE;
@@ -950,11 +952,12 @@ static int push_refs_with_push(struct transport *transport,
 	strbuf_release(&buf);
 	string_list_clear(&cas_options, 0);
 
-	return push_update_refs_status(data, remote_refs, flags);
+	return push_update_refs_status(r, data, remote_refs, flags);
 }
 
-static int push_refs_with_export(struct transport *transport,
-		struct ref *remote_refs, int flags)
+static int push_refs_with_export(struct repository *r,
+				 struct transport *transport,
+				 struct ref *remote_refs, int flags)
 {
 	struct ref *ref;
 	struct child_process *helper, exporter;
@@ -1021,7 +1024,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die(_("error while running fast-export"));
-	if (push_update_refs_status(data, remote_refs, flags))
+	if (push_update_refs_status(r, data, remote_refs, flags))
 		return 1;
 
 	if (data->export_marks) {
@@ -1033,14 +1036,15 @@ static int push_refs_with_export(struct transport *transport,
 	return 0;
 }
 
-static int push_refs(struct transport *transport,
-		struct ref *remote_refs, int flags)
+static int push_refs(struct repository *r, struct transport *transport,
+	       struct ref *remote_refs, int flags)
 {
 	struct helper_data *data = transport->data;
 
 	if (process_connect(transport, 1)) {
 		do_take_over(transport);
-		return transport->vtable->push_refs(transport, remote_refs, flags);
+		return transport->vtable->push_refs(r, transport, remote_refs,
+						    flags);
 	}
 
 	if (!remote_refs) {
@@ -1051,10 +1055,10 @@ static int push_refs(struct transport *transport,
 	}
 
 	if (data->push)
-		return push_refs_with_push(transport, remote_refs, flags);
+		return push_refs_with_push(r, transport, remote_refs, flags);
 
 	if (data->export)
-		return push_refs_with_export(transport, remote_refs, flags);
+		return push_refs_with_export(r, transport, remote_refs, flags);
 
 	return -1;
 }
diff --git a/transport-internal.h b/transport-internal.h
index 1cde6258a73..1ba1d063cc1 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -2,6 +2,7 @@
 #define TRANSPORT_INTERNAL_H
 
 struct ref;
+struct repository;
 struct transport;
 struct argv_array;
 
@@ -56,7 +57,8 @@ struct transport_vtable {
 	 * could be a different value from peer_ref->new_oid if the
 	 * process involved generating new commits.
 	 **/
-	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
+	int (*push_refs)(struct repository *r, struct transport *transport,
+			 struct ref *refs, int flags);
 	int (*connect)(struct transport *connection, const char *name,
 		       const char *executable, int fd[2]);
 
diff --git a/transport.c b/transport.c
index 5729577078a..c4b4ac0322d 100644
--- a/transport.c
+++ b/transport.c
@@ -446,7 +446,7 @@ void transport_update_tracking_ref(struct repository *r, struct remote *remote,
 		if (ref->deletion) {
 			delete_ref(r, NULL, rs.dst, NULL, 0);
 		} else
-			update_ref("update by push", rs.dst, &ref->new_oid,
+			update_ref(r, "update by push", rs.dst, &ref->new_oid,
 				   NULL, 0, 0);
 		free(rs.dst);
 	}
@@ -661,7 +661,8 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	free(head);
 }
 
-static int git_transport_push(struct transport *transport, struct ref *remote_refs, int flags)
+static int git_transport_push(struct repository *r, struct transport *transport,
+			      struct ref *remote_refs, int flags)
 {
 	struct git_transport_data *data = transport->data;
 	struct send_pack_args args;
@@ -1234,7 +1235,8 @@ int transport_push(struct repository *r,
 
 		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY)) {
 			trace2_region_enter("transport_push", "push_refs", r);
-			push_ret = transport->vtable->push_refs(transport, remote_refs, flags);
+			push_ret = transport->vtable->push_refs(
+				r, transport, remote_refs, flags);
 			trace2_region_leave("transport_push", "push_refs", r);
 		} else
 			push_ret = 0;
-- 
gitgitgadget

