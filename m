Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186FCC433E5
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E61112245C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhOGrbXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbgGaP1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgGaP12 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D51C061756
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so9607568wmi.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gqAEXd4mpqL3byXE0CYoL2mBYhDTCLOQxi22DFzunL4=;
        b=EhOGrbXg5QFKFCyFu9jaWTzHRkZRcDA164OIbhJCmBGNEyuPPEQ1Lvr0kZDqRpMwYO
         Gq7f0CwygJ5U4TRV7ZmJpgbQwl2Wp4fn5GHUTjj0tjZnSagTRpDf71WFu4p0jFrPUxHv
         C3DjbVkh7K5r93SLEUSMvn1awBgdgofPPNI2e/vmWh4CbC/eSB/crF2WbSz5Q/Qz5JHr
         b0qOMDOcaB9IpfXkw7kx52ua5LfjDWD7wraqv9DF/BkBscqGGWwHsLDcODXKt3VKRbOO
         67ZWOfXav0CvCSfyTz3hlEtcMWtgxrzMAeI3fZeLYr3GvReR5cX53r51Rg+zSIUzZHuT
         GIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gqAEXd4mpqL3byXE0CYoL2mBYhDTCLOQxi22DFzunL4=;
        b=rVySTnwwIJhvjIvGbTMYTjP34aXy0ZNi6Z57zJOq1CKzyPT735W4on8fYQxjHpkj9M
         da4diZzJ+Q3RI3KM7v0H272MMtd5msXUtEqxIIw6yN5PLFHckV34k7LdoflCAl+t5u45
         hkaVZ7ofZMHuz6eH6/F66JFtAsyu7IS+jel6drWkRkXqnzqiLhIoV6513V/JbrD9DyG1
         zmH9xYLR90g1FgUHgHSI+Dm9cWh5I5tkd80jZI0ltdE0G7889uiAtfMDuhykQlf4uvQJ
         5FQmQYt5AWokVkpdEHJDaol0qCllyopGnanMxZQh0ppt2jFBAAeYzx4xZTeDgTDtrflr
         Ef8A==
X-Gm-Message-State: AOAM532ba+sCtq5V0NyNxtTIq/V7rCtQwTrW9UfDkjNJF1CDnyKGKd1j
        9+Lw1L4r+M1JUFv9QJWvLmzxYtuu
X-Google-Smtp-Source: ABdhPJwz2M7SBAHbCApdsiXvdQ0SED/0Eucx+l35yFlHZ0OYd30CPKnd/NyCuJprFuIx73K8h3LTSg==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr4461594wmj.111.1596209246411;
        Fri, 31 Jul 2020 08:27:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm12485858wma.44.2020.07.31.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:26 -0700 (PDT)
Message-Id: <d12f6e905ceb13cb3e5bdb5fde44f8338a9667b2.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:03 +0000
Subject: [PATCH v20 07/21] Treat CHERRY_PICK_HEAD as a pseudo ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Check for existence and delete CHERRY_PICK_HEAD through ref functions.
This will help cherry-pick work with alternate ref storage backends.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/commit.c | 34 +++++++++++++++++++---------------
 builtin/merge.c  |  2 +-
 path.c           |  1 -
 path.h           |  7 ++++---
 sequencer.c      | 42 ++++++++++++++++++++++++++----------------
 wt-status.c      |  4 ++--
 6 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d1b7396052..e27120b982 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -847,21 +847,25 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
 				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-			    whence == FROM_MERGE
-				? _("\n"
-					"It looks like you may be committing a merge.\n"
-					"If this is not correct, please remove the file\n"
-					"	%s\n"
-					"and try again.\n")
-				: _("\n"
-					"It looks like you may be committing a cherry-pick.\n"
-					"If this is not correct, please remove the file\n"
-					"	%s\n"
-					"and try again.\n"),
-				whence == FROM_MERGE ?
-					git_path_merge_head(the_repository) :
-					git_path_cherry_pick_head(the_repository));
+			if (whence == FROM_MERGE)
+				status_printf_ln(
+					s, GIT_COLOR_NORMAL,
+
+					_("\n"
+					  "It looks like you may be committing a merge.\n"
+					  "If this is not correct, please remove the file\n"
+					  "	%s\n"
+					  "and try again.\n"),
+					git_path_merge_head(the_repository));
+			else
+				status_printf_ln(
+					s, GIT_COLOR_NORMAL,
+
+					_("\n"
+					  "It looks like you may be committing a cherry-pick.\n"
+					  "If this is not correct, please run\n"
+					  "	git cherry-pick --abort\n"
+					  "and try again.\n"));
 		}
 
 		fprintf(s->fp, "\n");
diff --git a/builtin/merge.c b/builtin/merge.c
index 7da707bf55..93b0a7b6ed 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1352,7 +1352,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
-	if (file_exists(git_path_cherry_pick_head(the_repository))) {
+	if (ref_exists("CHERRY_PICK_HEAD")) {
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 			    "Please, commit your changes before you merge."));
diff --git a/path.c b/path.c
index 8b2c753191..783cc2ae81 100644
--- a/path.c
+++ b/path.c
@@ -1528,7 +1528,6 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
-REPO_GIT_PATH_FUNC(cherry_pick_head, "CHERRY_PICK_HEAD")
 REPO_GIT_PATH_FUNC(revert_head, "REVERT_HEAD")
 REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
 REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
diff --git a/path.h b/path.h
index 1f1bf8f87a..8941c018a9 100644
--- a/path.h
+++ b/path.h
@@ -170,7 +170,6 @@ void report_linked_checkout_garbage(void);
 	}
 
 struct path_cache {
-	const char *cherry_pick_head;
 	const char *revert_head;
 	const char *squash_msg;
 	const char *merge_msg;
@@ -182,9 +181,11 @@ struct path_cache {
 	const char *shallow;
 };
 
-#define PATH_CACHE_INIT { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL }
+#define PATH_CACHE_INIT                                              \
+	{                                                            \
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL \
+	}
 
-const char *git_path_cherry_pick_head(struct repository *r);
 const char *git_path_revert_head(struct repository *r);
 const char *git_path_squash_msg(struct repository *r);
 const char *git_path_merge_msg(struct repository *r);
diff --git a/sequencer.c b/sequencer.c
index fd7701c88a..601b1cffcd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -381,7 +381,8 @@ static void print_advice(struct repository *r, int show_hint,
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-		unlink(git_path_cherry_pick_head(r));
+		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
+				NULL, 0);
 		return;
 	}
 
@@ -1455,7 +1456,8 @@ static int do_commit(struct repository *r,
 				    author, opts, flags, &oid);
 		strbuf_release(&sb);
 		if (!res) {
-			unlink(git_path_cherry_pick_head(r));
+			refs_delete_ref(get_main_ref_store(r), "",
+					"CHERRY_PICK_HEAD", NULL, 0);
 			unlink(git_path_merge_msg(r));
 			if (!is_rebase_i(opts))
 				print_commit_summary(r, NULL, &oid,
@@ -1966,7 +1968,8 @@ static int do_pick_commit(struct repository *r,
 		flags |= ALLOW_EMPTY;
 	} else if (allow == 2) {
 		drop_commit = 1;
-		unlink(git_path_cherry_pick_head(r));
+		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
+				NULL, 0);
 		unlink(git_path_merge_msg(r));
 		fprintf(stderr,
 			_("dropping %s %s -- patch contents already upstream\n"),
@@ -2305,8 +2308,10 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int need_cleanup = 0;
 
-	if (file_exists(git_path_cherry_pick_head(r))) {
-		if (!unlink(git_path_cherry_pick_head(r)) && verbose)
+	if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD")) {
+		if (!refs_delete_ref(get_main_ref_store(r), "",
+				     "CHERRY_PICK_HEAD", NULL, 0) &&
+		    verbose)
 			warning(_("cancelling a cherry picking in progress"));
 		opts.action = REPLAY_PICK;
 		need_cleanup = 1;
@@ -2671,8 +2676,9 @@ static int create_seq_dir(struct repository *r)
 	enum replay_action action;
 	const char *in_progress_error = NULL;
 	const char *in_progress_advice = NULL;
-	unsigned int advise_skip = file_exists(git_path_revert_head(r)) ||
-				file_exists(git_path_cherry_pick_head(r));
+	unsigned int advise_skip =
+		file_exists(git_path_revert_head(r)) ||
+		refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
 
 	if (!sequencer_get_last_command(r, &action)) {
 		switch (action) {
@@ -2771,7 +2777,7 @@ static int rollback_single_pick(struct repository *r)
 {
 	struct object_id head_oid;
 
-	if (!file_exists(git_path_cherry_pick_head(r)) &&
+	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 	    !file_exists(git_path_revert_head(r)))
 		return error(_("no cherry-pick or revert in progress"));
 	if (read_ref_full("HEAD", 0, &head_oid, NULL))
@@ -2874,7 +2880,8 @@ int sequencer_skip(struct repository *r, struct replay_opts *opts)
 		}
 		break;
 	case REPLAY_PICK:
-		if (!file_exists(git_path_cherry_pick_head(r))) {
+		if (!refs_ref_exists(get_main_ref_store(r),
+				     "CHERRY_PICK_HEAD")) {
 			if (action != REPLAY_PICK)
 				return error(_("no cherry-pick in progress"));
 			if (!rollback_is_safe())
@@ -3569,7 +3576,8 @@ static int do_merge(struct repository *r,
 					oid_to_hex(&j->item->object.oid));
 
 		strbuf_release(&ref_name);
-		unlink(git_path_cherry_pick_head(r));
+		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
+				NULL, 0);
 		rollback_lock_file(&lock);
 
 		rollback_lock_file(&lock);
@@ -4201,7 +4209,7 @@ static int continue_single_pick(struct repository *r)
 {
 	const char *argv[] = { "commit", NULL };
 
-	if (!file_exists(git_path_cherry_pick_head(r)) &&
+	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 	    !file_exists(git_path_revert_head(r)))
 		return error(_("no cherry-pick or revert in progress"));
 	return run_command_v_opt(argv, RUN_GIT_CMD);
@@ -4318,9 +4326,10 @@ static int commit_staged_changes(struct repository *r,
 	}
 
 	if (is_clean) {
-		const char *cherry_pick_head = git_path_cherry_pick_head(r);
-
-		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
+		if (refs_ref_exists(get_main_ref_store(r),
+				    "CHERRY_PICK_HEAD") &&
+		    refs_delete_ref(get_main_ref_store(r), "",
+				    "CHERRY_PICK_HEAD", NULL, 0))
 			return error(_("could not remove CHERRY_PICK_HEAD"));
 		if (!final_fixup)
 			return 0;
@@ -4379,7 +4388,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 
 	if (!is_rebase_i(opts)) {
 		/* Verify that the conflict has been resolved */
-		if (file_exists(git_path_cherry_pick_head(r)) ||
+		if (refs_ref_exists(get_main_ref_store(r),
+				    "CHERRY_PICK_HEAD") ||
 		    file_exists(git_path_revert_head(r))) {
 			res = continue_single_pick(r);
 			if (res)
@@ -5442,7 +5452,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 
 int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 {
-	if (file_exists(git_path_cherry_pick_head(r))) {
+	if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD")) {
 		struct object_id cherry_pick_head, rebase_head;
 
 		if (file_exists(git_path_seq_dir()))
diff --git a/wt-status.c b/wt-status.c
index 20f2075868..8fddf65a4b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1673,8 +1673,8 @@ void wt_status_get_state(struct repository *r,
 		state->merge_in_progress = 1;
 	} else if (wt_status_check_rebase(NULL, state)) {
 		;		/* all set */
-	} else if (!stat(git_path_cherry_pick_head(r), &st) &&
-			!get_oid("CHERRY_PICK_HEAD", &oid)) {
+	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
+		   !get_oid("CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
-- 
gitgitgadget

