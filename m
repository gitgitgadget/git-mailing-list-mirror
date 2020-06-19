Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6A8C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F1520771
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV7LazGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405428AbgFSPzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392832AbgFSPVR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 11:21:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE73DC0613EF
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 08:21:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y20so9467255wmi.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8jt1l85ipJwBf5Gv1mFGxpUO6zH2f6bmfNBMJABphsA=;
        b=XV7LazGBApaySfcLAcPY5wfPkGRepH3ToQlgjWUUBeTJfvl+v09r1o+tmYF/55bUtS
         s31xV7ZBHHSp0P9SO0H5gQpTJ8sc/SPVGoRXsK2e9y+PKNBnAchWwuwBiVxSfwcxTlWE
         ncZMkmSnTyKe6XE9pA/REg4PbKXHFA2/AsLcEg/kUELWv3nDoVi4AUGIs/MmjYlQfnE+
         qco21vrAkzfNavmriSOLwpdK/PZ5fhJEZ07vaq7O1Oy4RBlXbJEYNQDKOTW1eAQRrYmM
         ULgJchDWTXRKA+fnJswNtb3AiuUvUcBu/y9iVcxjPSDKjuk8Y0Bwau28Y3bAB7xkOzEx
         ub7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8jt1l85ipJwBf5Gv1mFGxpUO6zH2f6bmfNBMJABphsA=;
        b=algHVpoWXgyR5ezajG6zWIAtzXPn/zPiUSX9F7swnrtQgi7inNJ3jEU8g8MxEPT0CP
         kgxPaufMXlMw7/TsQERHS+/PY0sSXmk7VLJXd1xExg0CJneL8OGM1ykJwLme10ctOxvl
         b9+gyptsoJwxyIOmUfgNhDEhfyAPTcUDV1AX2jd8pzTa4ByKi5m4PhdRwPrs2SGXV8T5
         QSMIojJETWNNpLiG+jTjslWy0Eq4yo3HvXCoLO15B1Bj2sxmIiqAXT4kEgaIiZi7wIV3
         zOUnliLMW/rdmnFsTobXXaW2kbyDwZsFbpzaLl71Sf27HyB7qt6rPfg4yqdawJL0FRyr
         y+fg==
X-Gm-Message-State: AOAM532SPXBQy77wtFccGjxPqcxbBscUtCdW8xnpH9CuSrllVTvm1E+9
        Y1o0dNZQH25jxtKXEGiFd33+arb2
X-Google-Smtp-Source: ABdhPJzCHywdd2K0xuCJ5F9dIUM8VHDtdi6MygsNVdsYQ5MQCtmRSEm2/EPdlo4QHzKUEoT74v/4SA==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr4605728wmj.137.1592580074015;
        Fri, 19 Jun 2020 08:21:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b19sm14910504wmj.0.2020.06.19.08.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:21:13 -0700 (PDT)
Message-Id: <220989b86d651cf300c1cdb8b5a399ee66d839fc.1592580071.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.665.git.1592580071.gitgitgadget@gmail.com>
References: <pull.665.git.1592580071.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Jun 2020 15:21:08 +0000
Subject: [PATCH 1/3] refs: update delete_ref() to take a struct repository
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

There are a number of places where we delete pseudo refs by calling
unlink() on the pseduo ref path rather than using the refs api. The
assumption that these refs are always files will not valid once
repositories start storing their refs in a reftable. As the current code
is already aware of which repository the ref is in update delete_ref()
to take a struct repository* so that we can safely change the unlink()
calls to delete_ref() later. It would be possible to change the unlink()
to use refs_delete_ref(get_main_ref_store(r), ...) but that gets quite
cumbersome.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/am.c           |  9 +++++----
 builtin/branch.c       |  4 ++--
 builtin/notes.c        |  5 +++--
 builtin/rebase.c       |  6 +++---
 builtin/remote.c       |  6 ++++--
 builtin/replace.c      |  2 +-
 builtin/reset.c        |  2 +-
 builtin/revert.c       |  2 +-
 builtin/send-pack.c    |  3 ++-
 builtin/stash.c        |  2 +-
 builtin/symbolic-ref.c |  3 ++-
 builtin/tag.c          |  2 +-
 builtin/update-ref.c   |  2 +-
 fast-import.c          |  2 +-
 refs.c                 |  6 +++---
 refs.h                 |  2 +-
 reset.c                |  2 +-
 sequencer.c            | 20 ++++++++++----------
 sequencer.h            |  2 +-
 transport.c            |  7 ++++---
 transport.h            |  3 ++-
 21 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 69e50de018b..cd2e3f1f3b5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -951,7 +951,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
-	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+	delete_ref(the_repository, NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
 		am_destroy(state);
@@ -1018,7 +1018,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	} else {
 		write_state_text(state, "abort-safety", "");
 		if (!state->rebasing)
-			delete_ref(NULL, "ORIG_HEAD", NULL, 0);
+			delete_ref(the_repository, NULL, "ORIG_HEAD", NULL, 0);
 	}
 
 	/*
@@ -1051,7 +1051,7 @@ static void am_next(struct am_state *state)
 
 	oidclr(&state->orig_commit);
 	unlink(am_path(state, "original-commit"));
-	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+	delete_ref(the_repository, NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 	if (!get_oid("HEAD", &head))
 		write_state_text(state, "abort-safety", oid_to_hex(&head));
@@ -2059,7 +2059,8 @@ static void am_abort(struct am_state *state)
 			   has_curr_head ? &curr_head : NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	else if (curr_branch)
-		delete_ref(NULL, curr_branch, NULL, REF_NO_DEREF);
+		delete_ref(the_repository, NULL, curr_branch, NULL,
+			   REF_NO_DEREF);
 
 	free(curr_branch);
 	am_destroy(state);
diff --git a/builtin/branch.c b/builtin/branch.c
index accb61b1aae..a4409d42d7c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -265,8 +265,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			goto next;
 		}
 
-		if (delete_ref(NULL, name, is_null_oid(&oid) ? NULL : &oid,
-			       REF_NO_DEREF)) {
+		if (delete_ref(the_repository, NULL, name,
+			       is_null_oid(&oid) ? NULL : &oid, REF_NO_DEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote-tracking branch '%s'")
 			      : _("Error deleting branch '%s'"),
diff --git a/builtin/notes.c b/builtin/notes.c
index 2987c08a2e9..b852afe5a3e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -694,9 +694,10 @@ static int merge_abort(struct notes_merge_options *o)
 	 * notes_merge_abort() to remove .git/NOTES_MERGE_WORKTREE.
 	 */
 
-	if (delete_ref(NULL, "NOTES_MERGE_PARTIAL", NULL, 0))
+	if (delete_ref(the_repository, NULL, "NOTES_MERGE_PARTIAL", NULL, 0))
 		ret += error(_("failed to delete ref NOTES_MERGE_PARTIAL"));
-	if (delete_ref(NULL, "NOTES_MERGE_REF", NULL, REF_NO_DEREF))
+	if (delete_ref(the_repository, NULL, "NOTES_MERGE_REF", NULL,
+		       REF_NO_DEREF))
 		ret += error(_("failed to delete ref NOTES_MERGE_REF"));
 	if (notes_merge_abort(o))
 		ret += error(_("failed to remove 'git notes merge' worktree"));
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 37ba76ac3d2..82284df8d94 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -724,7 +724,7 @@ static int finish_rebase(struct rebase_options *opts)
 	struct strbuf dir = STRBUF_INIT;
 	int ret = 0;
 
-	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+	delete_ref(the_repository, NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 	apply_autostash(state_dir_path("autostash", opts));
 	close_object_store(the_repository->objects);
 	/*
@@ -736,7 +736,7 @@ static int finish_rebase(struct rebase_options *opts)
 		struct replay_opts replay = REPLAY_OPTS_INIT;
 
 		replay.action = REPLAY_INTERACTIVE_REBASE;
-		ret = sequencer_remove_state(&replay);
+		ret = sequencer_remove_state(the_repository, &replay);
 	} else {
 		strbuf_addstr(&dir, opts->state_dir);
 		if (remove_dir_recursively(&dir, 0))
@@ -1573,7 +1573,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			struct replay_opts replay = REPLAY_OPTS_INIT;
 
 			replay.action = REPLAY_INTERACTIVE_REBASE;
-			ret = !!sequencer_remove_state(&replay);
+			ret = !!sequencer_remove_state(the_repository, &replay);
 		} else {
 			strbuf_reset(&buf);
 			strbuf_addstr(&buf, options.state_dir);
diff --git a/builtin/remote.c b/builtin/remote.c
index e8377994e57..cde14a7bebe 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -762,7 +762,8 @@ static int mv(int argc, const char **argv)
 		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
-		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
+		if (delete_ref(the_repository, NULL, item->string, NULL,
+			       REF_NO_DEREF))
 			die(_("deleting '%s' failed"), item->string);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
@@ -1343,7 +1344,8 @@ static int set_head(int argc, const char **argv)
 			head_name = xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
-		if (delete_ref(NULL, buf.buf, NULL, REF_NO_DEREF))
+		if (delete_ref(the_repository, NULL, buf.buf, NULL,
+			       REF_NO_DEREF))
 			result |= error(_("Could not delete %s"), buf.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
diff --git a/builtin/replace.c b/builtin/replace.c
index b36d17a657f..ba57bc78ba8 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -136,7 +136,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 static int delete_replace_ref(const char *name, const char *ref,
 			      const struct object_id *oid)
 {
-	if (delete_ref(NULL, ref, oid, 0))
+	if (delete_ref(the_repository, NULL, ref, oid, 0))
 		return 1;
 	printf_ln(_("Deleted replace ref '%s'"), name);
 	return 0;
diff --git a/builtin/reset.c b/builtin/reset.c
index 8ae69d6f2b9..de407783c4e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -267,7 +267,7 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
 			   UPDATE_REFS_MSG_ON_ERR);
 	} else if (old_orig)
-		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+		delete_ref(the_repository, NULL, "ORIG_HEAD", old_orig, 0);
 	set_reflog_message(&msg, "updating HEAD", rev);
 	update_ref_status = update_ref(msg.buf, "HEAD", oid, orig, 0,
 				       UPDATE_REFS_MSG_ON_ERR);
diff --git a/builtin/revert.c b/builtin/revert.c
index f61cc5d82cf..b025a9cf91f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -204,7 +204,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	opts->strategy = xstrdup_or_null(opts->strategy);
 
 	if (cmd == 'q') {
-		int ret = sequencer_remove_state(opts);
+		int ret = sequencer_remove_state(the_repository, opts);
 		if (!ret)
 			remove_branch_state(the_repository, 0);
 		return ret;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 2b9610f1217..3129e408ad8 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -299,7 +299,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	if (!args.dry_run && remote) {
 		struct ref *ref;
 		for (ref = remote_refs; ref; ref = ref->next)
-			transport_update_tracking_ref(remote, ref, args.verbose);
+			transport_update_tracking_ref(the_repository, remote,
+						      ref, args.verbose);
 	}
 
 	if (!ret && !transport_refs_pushed(remote_refs))
diff --git a/builtin/stash.c b/builtin/stash.c
index 0c52a3b849c..dc318cb52be 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -208,7 +208,7 @@ static int do_clear_stash(void)
 	if (get_oid(ref_stash, &obj))
 		return 0;
 
-	return delete_ref(NULL, ref_stash, &obj, 0);
+	return delete_ref(the_repository, NULL, ref_stash, &obj, 0);
 }
 
 static int clear_stash(int argc, const char **argv, const char *prefix)
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 80237f0df10..b7cdb03c3b1 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -58,7 +58,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 			die("Cannot delete %s, not a symbolic ref", argv[0]);
 		if (!strcmp(argv[0], "HEAD"))
 			die("deleting '%s' is not allowed", argv[0]);
-		return delete_ref(NULL, argv[0], NULL, REF_NO_DEREF);
+		return delete_ref(the_repository, NULL, argv[0], NULL,
+				  REF_NO_DEREF);
 	}
 
 	switch (argc) {
diff --git a/builtin/tag.c b/builtin/tag.c
index 5cbd80dc3e9..109f8393100 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -100,7 +100,7 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 static int delete_tag(const char *name, const char *ref,
 		      const struct object_id *oid, const void *cb_data)
 {
-	if (delete_ref(NULL, ref, oid, 0))
+	if (delete_ref(the_repository, NULL, ref, oid, 0))
 		return 1;
 	printf(_("Deleted tag '%s' (was %s)\n"), name,
 	       find_unique_abbrev(oid, DEFAULT_ABBREV));
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index b74dd9a69d9..b3ec9e5362c 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -550,7 +550,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		 * For purposes of backwards compatibility, we treat
 		 * NULL_SHA1 as "don't care" here:
 		 */
-		return delete_ref(msg, refname,
+		return delete_ref(the_repository, msg, refname,
 				  (oldval && !is_null_oid(&oldoid)) ? &oldoid : NULL,
 				  default_flags);
 	else
diff --git a/fast-import.c b/fast-import.c
index 0dfa14dc8c3..80bcb682072 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1613,7 +1613,7 @@ static int update_branch(struct branch *b)
 
 	if (is_null_oid(&b->oid)) {
 		if (b->delete)
-			delete_ref(NULL, b->name, NULL, 0);
+			delete_ref(the_repository, NULL, b->name, NULL, 0);
 		return 0;
 	}
 	if (read_ref(b->name, &old_oid))
diff --git a/refs.c b/refs.c
index 224ff66c7bb..db2d0907d44 100644
--- a/refs.c
+++ b/refs.c
@@ -863,11 +863,11 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	return 0;
 }
 
-int delete_ref(const char *msg, const char *refname,
+int delete_ref(struct repository *r, const char *msg, const char *refname,
 	       const struct object_id *old_oid, unsigned int flags)
 {
-	return refs_delete_ref(get_main_ref_store(the_repository), msg, refname,
-			       old_oid, flags);
+	return refs_delete_ref(get_main_ref_store(r), msg, refname, old_oid,
+			       flags);
 }
 
 void copy_reflog_msg(struct strbuf *sb, const char *msg)
diff --git a/refs.h b/refs.h
index e010f8aec28..7d9bc045484 100644
--- a/refs.h
+++ b/refs.h
@@ -414,7 +414,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    const char *refname,
 		    const struct object_id *old_oid,
 		    unsigned int flags);
-int delete_ref(const char *msg, const char *refname,
+int delete_ref(struct repository *r, const char *msg, const char *refname,
 	       const struct object_id *old_oid, unsigned int flags);
 
 /*
diff --git a/reset.c b/reset.c
index 2f4fbd07c54..31ec2dbf829 100644
--- a/reset.c
+++ b/reset.c
@@ -107,7 +107,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
 				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
 		} else if (old_orig)
-			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+			delete_ref(r, NULL, "ORIG_HEAD", old_orig, 0);
 	}
 
 	if (!reflog_head) {
diff --git a/sequencer.c b/sequencer.c
index fd7701c88a8..88f1b13a600 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -281,7 +281,7 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 	return buf.buf;
 }
 
-int sequencer_remove_state(struct replay_opts *opts)
+int sequencer_remove_state(struct repository *r, struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int i, ret = 0;
@@ -293,7 +293,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 			char *eol = strchr(p, '\n');
 			if (eol)
 				*eol = '\0';
-			if (delete_ref("(rebase) cleanup", p, NULL, 0) < 0) {
+			if (delete_ref(r, "(rebase) cleanup", p, NULL, 0) < 0) {
 				warning(_("could not delete '%s'"), p);
 				ret = -1;
 			}
@@ -2325,7 +2325,7 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
 	if (!have_finished_the_last_pick())
 		return;
 
-	sequencer_remove_state(&opts);
+	sequencer_remove_state(r, &opts);
 }
 
 static void todo_list_write_total_nr(struct todo_list *todo_list)
@@ -2833,7 +2833,7 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 	if (reset_merge(&oid))
 		goto fail;
 	strbuf_release(&buf);
-	return sequencer_remove_state(opts);
+	return sequencer_remove_state(r, opts);
 fail:
 	strbuf_release(&buf);
 	return -1;
@@ -3858,7 +3858,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 
 	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
 		apply_autostash(rebase_path_autostash());
-		sequencer_remove_state(opts);
+		sequencer_remove_state(r, opts);
 		return error(_("could not detach HEAD"));
 	}
 
@@ -3938,7 +3938,7 @@ static int pick_commits(struct repository *r,
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
 			unlink(git_path_merge_head(r));
-			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+			delete_ref(r, NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 			if (item->command == TODO_BREAK) {
 				if (!opts->verbose)
@@ -4194,7 +4194,7 @@ static int pick_commits(struct repository *r,
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
-	return sequencer_remove_state(opts);
+	return sequencer_remove_state(r, opts);
 }
 
 static int continue_single_pick(struct repository *r)
@@ -5201,7 +5201,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	if (count_commands(todo_list) == 0) {
 		apply_autostash(rebase_path_autostash());
-		sequencer_remove_state(opts);
+		sequencer_remove_state(r, opts);
 
 		return error(_("nothing to do"));
 	}
@@ -5212,12 +5212,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	else if (res == -2) {
 		apply_autostash(rebase_path_autostash());
-		sequencer_remove_state(opts);
+		sequencer_remove_state(r, opts);
 
 		return -1;
 	} else if (res == -3) {
 		apply_autostash(rebase_path_autostash());
-		sequencer_remove_state(opts);
+		sequencer_remove_state(r, opts);
 		todo_list_release(&new_todo);
 
 		return error(_("nothing to do"));
diff --git a/sequencer.h b/sequencer.h
index d31c41f018c..f892e567d47 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -132,7 +132,7 @@ int sequencer_pick_revisions(struct repository *repo,
 int sequencer_continue(struct repository *repo, struct replay_opts *opts);
 int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_skip(struct repository *repo, struct replay_opts *opts);
-int sequencer_remove_state(struct replay_opts *opts);
+int sequencer_remove_state(struct repository *repo, struct replay_opts *opts);
 
 #define TODO_LIST_KEEP_EMPTY (1U << 0)
 #define TODO_LIST_SHORTEN_IDS (1U << 1)
diff --git a/transport.c b/transport.c
index 7d50c502adf..5729577078a 100644
--- a/transport.c
+++ b/transport.c
@@ -429,7 +429,8 @@ int transport_refs_pushed(struct ref *ref)
 	return 0;
 }
 
-void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
+void transport_update_tracking_ref(struct repository *r, struct remote *remote,
+				   struct ref *ref, int verbose)
 {
 	struct refspec_item rs;
 
@@ -443,7 +444,7 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 		if (verbose)
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
 		if (ref->deletion) {
-			delete_ref(NULL, rs.dst, NULL, 0);
+			delete_ref(r, NULL, rs.dst, NULL, 0);
 		} else
 			update_ref("update by push", rs.dst, &ref->new_oid,
 				   NULL, 0, 0);
@@ -1252,7 +1253,7 @@ int transport_push(struct repository *r,
 			       TRANSPORT_RECURSE_SUBMODULES_ONLY))) {
 			struct ref *ref;
 			for (ref = remote_refs; ref; ref = ref->next)
-				transport_update_tracking_ref(transport->remote, ref, verbose);
+				transport_update_tracking_ref(r, transport->remote, ref, verbose);
 		}
 
 		if (porcelain && !push_ret)
diff --git a/transport.h b/transport.h
index 4298c855be6..24596ae27d5 100644
--- a/transport.h
+++ b/transport.h
@@ -258,7 +258,8 @@ int transport_helper_init(struct transport *transport, const char *name);
 int bidirectional_transfer_loop(int input, int output);
 
 /* common methods used by transport.c and builtin/send-pack.c */
-void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose);
+void transport_update_tracking_ref(struct repository *r, struct remote *remote,
+				   struct ref *ref, int verbose);
 
 int transport_refs_pushed(struct ref *ref);
 
-- 
gitgitgadget

