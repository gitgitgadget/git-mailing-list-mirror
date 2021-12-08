Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B869EC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhLHPBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbhLHPBp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:45 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6D2C061D5E
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so4534835wrr.8
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rUwtAM5n8PXdZ1ZzhiowLzizhW+rKmtt1++YkNmqdkM=;
        b=H8nnGVF15Pn5yiUElY+fymo8fKkpcZGzt5qQ747UqkmXIcxgyr5ClT8Ygk97ikQm79
         HLaVX/jziOv4nId1/xy2Hmvp1gIgUstlB6xf1P3Pl2OvUMauDBfi2II+Y6j/p5563tQ4
         +6YBaFlfToZF1wb59X54AiFvZtxRUgyIvwxy88vy41b2eLvQX/+TWYj+GhvT+df20KJc
         OTsgU59ANppvkaNmNtDpx8xYkB+YYJadlGK4ElCOlKuv9GUMvtrVscz0l5NoQIzNWI0w
         5bl1sHs0CSYVuh9YT5RoZB/XQqAtudAF1xzPiZKIzd6AlPPqULtmI8nqSk3ci8iAzkEw
         IW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rUwtAM5n8PXdZ1ZzhiowLzizhW+rKmtt1++YkNmqdkM=;
        b=YdlXT6sW8vu9sjcp7gBoZ+6/6eiEaSZdi0fw7OT6iY+xLwL4YEuHQgzt7mi+0KOGOd
         mPM7Njm2DJHciqOWyUbV4Gc/j/jQtW/US8Vhghxp41cxi2fFQKF4mK1tZSv6LKjPQTzf
         QBdYmUs21gYwA4bkLsIkCR8U5cjN2m9LfotvLxQgnuhqZorHeyjmkfxjD9RBNkQKCYAx
         Wz1WAkIIVmLT0igeKEmIuj32nX7Qh+fPd240yy6F+klLZ1Fca/sAuM+ewMedAx6cUv9S
         taXrgAOFhays15cKETj3F0Yk7up/n8igEKqlXCADRI2i9cPG1uEtSjd+qHPFX3PYm3Hf
         yxTQ==
X-Gm-Message-State: AOAM532FODo7g7KaHgj58T2wqZ9p07vKC/rA70//XSBeFZnDwdv4bCDz
        Z1AvvjXH3GXyAgAS+Z4CBzz/gF1R1YE=
X-Google-Smtp-Source: ABdhPJxzu5tpId11ZTR/6pAg82p1i8rO1W75ivZPZrgpVGdt/d8X2dAfoWdozpytiOP8lELj2l74zQ==
X-Received: by 2002:adf:fd4c:: with SMTP id h12mr61282487wrs.429.1638975491359;
        Wed, 08 Dec 2021 06:58:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm3017429wrt.3.2021.12.08.06.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:11 -0800 (PST)
Message-Id: <24b0566aba5d8800d209261a14aca4d872af8027.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:58 +0000
Subject: [PATCH v2 11/14] reset_head(): take struct rebase_head_opts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This function takes a confusingly large number of parameters which
makes it difficult to remember which order to pass them in. The
following commits will add a couple more parameters which makes the
problem worse. To address this change the function to take a struct of
options. Using a struct means that it is no longer necessary to
remember which order to pass the parameters in and anyone reading the
code can easily see which value is passed to each parameter.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 57 ++++++++++++++++++++++++++++++------------------
 reset.c          | 38 +++++++++++++++-----------------
 reset.h          | 40 +++++++++++++++++++++++++++++----
 sequencer.c      |  5 ++---
 4 files changed, 92 insertions(+), 48 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fdd822c470f..ecc368dd4f4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -571,6 +571,7 @@ static int finish_rebase(struct rebase_options *opts)
 static int move_to_original_branch(struct rebase_options *opts)
 {
 	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
+	struct reset_head_opts ropts = { 0 };
 	int ret;
 
 	if (!opts->head_name)
@@ -583,9 +584,11 @@ static int move_to_original_branch(struct rebase_options *opts)
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
 	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
 		    opts->head_name);
-	ret = reset_head(the_repository, NULL, opts->head_name,
-			 RESET_HEAD_REFS_ONLY,
-			 orig_head_reflog.buf, head_reflog.buf, NULL);
+	ropts.branch = opts->head_name;
+	ropts.flags = RESET_HEAD_REFS_ONLY;
+	ropts.orig_head_msg = orig_head_reflog.buf;
+	ropts.head_msg = head_reflog.buf;
+	ret = reset_head(the_repository, &ropts);
 
 	strbuf_release(&orig_head_reflog);
 	strbuf_release(&head_reflog);
@@ -669,13 +672,15 @@ static int run_am(struct rebase_options *opts)
 
 	status = run_command(&format_patch);
 	if (status) {
+		struct reset_head_opts ropts = { 0 };
 		unlink(rebased_patches);
 		free(rebased_patches);
 		strvec_clear(&am.args);
 
-		reset_head(the_repository, &opts->orig_head,
-			   opts->head_name, 0,
-			   NULL, NULL, DEFAULT_REFLOG_ACTION);
+		ropts.oid = &opts->orig_head;
+		ropts.branch = opts->head_name;
+		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
+		reset_head(the_repository, &ropts);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
 			"these revisions:\n"
@@ -814,14 +819,17 @@ static int rebase_config(const char *var, const char *value, void *data)
 static int checkout_up_to_date(struct rebase_options *options)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct reset_head_opts ropts = { 0 };
 	int ret = 0;
 
 	strbuf_addf(&buf, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    options->switch_to);
-	if (reset_head(the_repository, &options->orig_head,
-		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-		       NULL, buf.buf, NULL) < 0)
+	ropts.oid = &options->orig_head;
+	ropts.branch = options->head_name;
+	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	ropts.head_msg = buf.buf;
+	if (reset_head(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
 	strbuf_release(&buf);
 
@@ -1033,6 +1041,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
 	int preserve_merges_selected = 0;
+	struct reset_head_opts ropts = { 0 };
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -1270,9 +1279,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
-
-		if (reset_head(the_repository, NULL, NULL, RESET_HEAD_HARD,
-			       NULL, NULL, NULL) < 0)
+		ropts.flags = RESET_HEAD_HARD;
+		if (reset_head(the_repository, &ropts) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
 		if (read_basic_state(&options))
@@ -1289,9 +1297,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		if (read_basic_state(&options))
 			exit(1);
-		if (reset_head(the_repository, &options.orig_head,
-			       options.head_name, RESET_HEAD_HARD,
-			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
+		ropts.oid = &options.orig_head;
+		ropts.branch = options.head_name;
+		ropts.flags = RESET_HEAD_HARD;
+		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
+		if (reset_head(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
 		remove_branch_state(the_repository, 0);
@@ -1758,10 +1768,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
-	if (reset_head(the_repository, &options.onto->object.oid, NULL,
-		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
-		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-		       NULL, msg.buf, DEFAULT_REFLOG_ACTION))
+	ropts.oid = &options.onto->object.oid;
+	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
+			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	ropts.head_msg = msg.buf;
+	ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
+	if (reset_head(the_repository, &ropts))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
@@ -1776,8 +1788,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
-		reset_head(the_repository, NULL, options.head_name,
-			   RESET_HEAD_REFS_ONLY, NULL, msg.buf, NULL);
+		memset(&ropts, 0, sizeof(ropts));
+		ropts.branch = options.head_name;
+		ropts.flags = RESET_HEAD_REFS_ONLY;
+		ropts.head_msg = msg.buf;
+		reset_head(the_repository, &ropts);
 		strbuf_release(&msg);
 		ret = finish_rebase(&options);
 		goto cleanup;
diff --git a/reset.c b/reset.c
index 4a92e4bc30b..78145d5c456 100644
--- a/reset.c
+++ b/reset.c
@@ -8,14 +8,17 @@
 #include "tree.h"
 #include "unpack-trees.h"
 
-static int update_refs(const struct object_id *oid, const char *switch_to_branch,
-		       const struct object_id *head, const char *reflog_head,
-		       const char *reflog_orig_head,
-		       const char *default_reflog_action, unsigned flags)
+static int update_refs(const struct reset_head_opts *opts,
+		       const struct object_id *oid,
+		       const struct object_id *head)
 {
-	unsigned detach_head = flags & RESET_HEAD_DETACH;
-	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
-	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
+	unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
+	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	const char *switch_to_branch = opts->branch;
+	const char *reflog_head = opts->head_msg;
+	const char *reflog_orig_head = opts->orig_head_msg;
+	const char *default_reflog_action = opts->default_reflog_action;
 	struct object_id *old_orig = NULL, oid_old_orig;
 	struct strbuf msg = STRBUF_INIT;
 	const char *reflog_action;
@@ -69,14 +72,13 @@ static int update_refs(const struct object_id *oid, const char *switch_to_branch
 	return ret;
 }
 
-int reset_head(struct repository *r, struct object_id *oid,
-	       const char *switch_to_branch, unsigned flags,
-	       const char *reflog_orig_head, const char *reflog_head,
-	       const char *default_reflog_action)
+int reset_head(struct repository *r, const struct reset_head_opts *opts)
 {
-	unsigned reset_hard = flags & RESET_HEAD_HARD;
-	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
-	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
+	const struct object_id *oid = opts->oid;
+	const char *switch_to_branch = opts->branch;
+	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
+	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
+	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -104,9 +106,7 @@ int reset_head(struct repository *r, struct object_id *oid,
 		oid = &head_oid;
 
 	if (refs_only)
-		return update_refs(oid, switch_to_branch, head, reflog_head,
-				   reflog_orig_head, default_reflog_action,
-				   flags);
+		return update_refs(opts, oid, head);
 
 	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
@@ -151,9 +151,7 @@ int reset_head(struct repository *r, struct object_id *oid,
 	}
 
 	if (oid != &head_oid || update_orig_head || switch_to_branch)
-		ret = update_refs(oid, switch_to_branch, head, reflog_head,
-				  reflog_orig_head, default_reflog_action,
-				  flags);
+		ret = update_refs(opts, oid, head);
 
 leave_reset_head:
 	rollback_lock_file(&lock);
diff --git a/reset.h b/reset.h
index 2daec804259..a205be2fb85 100644
--- a/reset.h
+++ b/reset.h
@@ -6,15 +6,47 @@
 
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
 
+/* Request a detached checkout */
 #define RESET_HEAD_DETACH (1<<0)
+/* Request a reset rather than a checkout */
 #define RESET_HEAD_HARD (1<<1)
+/* Run the post-checkout hook */
 #define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
+/* Only update refs, do not touch the worktree */
 #define RESET_HEAD_REFS_ONLY (1<<3)
+/* Update ORIG_HEAD as well as HEAD */
 #define RESET_ORIG_HEAD (1<<4)
 
-int reset_head(struct repository *r, struct object_id *oid,
-	       const char *switch_to_branch, unsigned flags,
-	       const char *reflog_orig_head, const char *reflog_head,
-	       const char *default_reflog_action);
+struct reset_head_opts {
+	/*
+	 * The commit to checkout/reset to. Defaults to HEAD.
+	 */
+	const struct object_id *oid;
+	/*
+	 * Optional branch to switch to.
+	 */
+	const char *branch;
+	/*
+	 * Flags defined above.
+	 */
+	unsigned flags;
+	/*
+	 * Optional reflog message for HEAD, if this omitted but oid or branch
+	 * are given then default_reflog_action must be given.
+	 */
+	const char *head_msg;
+	/*
+	 * Optional reflog message for ORIG_HEAD, if this omitted and flags
+	 * contains RESET_ORIG_HEAD then default_reflog_action must be given.
+	 */
+	const char *orig_head_msg;
+	/*
+	 * Action to use in default reflog messages, only required if a ref is
+	 * being updated and the reflog messages above are omitted.
+	 */
+	const char *default_reflog_action;
+};
+
+int reset_head(struct repository *r, const struct reset_head_opts *opts);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index 78d203dec47..a62ea9d0e05 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4109,6 +4109,7 @@ void create_autostash(struct repository *r, const char *path)
 	if (has_unstaged_changes(r, 1) ||
 	    has_uncommitted_changes(r, 1)) {
 		struct child_process stash = CHILD_PROCESS_INIT;
+		struct reset_head_opts ropts = { .flags = RESET_HEAD_HARD };
 		struct object_id oid;
 
 		strvec_pushl(&stash.args,
@@ -4130,10 +4131,8 @@ void create_autostash(struct repository *r, const char *path)
 			    path);
 		write_file(path, "%s", oid_to_hex(&oid));
 		printf(_("Created autostash: %s\n"), buf.buf);
-		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
-			       NULL) < 0)
+		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
-
 		if (discard_index(r->index) < 0 ||
 			repo_read_index(r) < 0)
 			die(_("could not read index"));
-- 
gitgitgadget

