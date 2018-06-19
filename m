Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 551821F403
	for <e@80x24.org>; Tue, 19 Jun 2018 15:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966854AbeFSPpJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 11:45:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52817 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeFSPpD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 11:45:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so1186259wmb.2
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=57obhL+eB4LYMgqkhYW5Lemu7xQO8twNw7ktuzBKoxo=;
        b=Mk7PzpuysyTK4C+N6pJy7LD8xjg1y02N3W90a4My+1wkRTjuPfrWhzFaXi5Q6jCahx
         8HJfmpmtgnrLGJO+zPYPa4WQ18LfoQ6kZMc9FQuPv93zWafxYpWs9sq/SD7kXZ6jcdA2
         U4428gtaN4CublbvmFvdqe4LDlRHjSU2hZG7uqI89R+ccyWkye4IRlphUgZnDD3H65iB
         uKsPS67gCGuXUylZiTZJvc9WrHfkyAnbGg1b5QrnlafJs5j5SO1XW2y1qfEwnumoYbbQ
         IrVFGicSUwxZBQ5fOGTDIROSbBfNqZPyZ+2LopicjiAf6+ZZtzEV74YYwAZnjD/55Mx9
         1wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=57obhL+eB4LYMgqkhYW5Lemu7xQO8twNw7ktuzBKoxo=;
        b=fjAID1G2X1d4XSU8AfbBWJF4LvBhoxomdnpkI3IN1yVGGmzYAxtpWn37Y1aNeb5TbW
         8nUQX1Y5jzhtl/QaO9s2xfZhqWMwYswZ660F/FQLSMEuvR52S19Gi++x4bhHnQIoh6/0
         scbm5cFhbC5bL5T0jVMYTbQSTYdj5Z09zVjDHZ2Ptap2SywUXG/jWUuSNY8Xv5c8PwP4
         q0eZgWY/v686WcXMZoQCfH0zcS7V1IZvf08fImXr1beLRHz+Ll798EgF+8xTp9GyZyIC
         +7O1VzEDw9G03X0b1Q2DovK8ZkAc4MeFw4PLXh2C8wX8aibcK+IMntIzES09coUaqxIB
         2VSw==
X-Gm-Message-State: APt69E25c9jAGJys66cfMYxoJq0wj6IfSc66x9oGicT0447BMa+eim1Z
        LdeLENapDWG+eJmS8YmD1z3e+tjk
X-Google-Smtp-Source: ADUXVKIqdgQXtROTk6cnfRsda6jFCe1rqNBt01W1WT8uoz6+G3gW8NmGZ7HPvSubgBjeIZDtVHkPrw==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr11876749wmb.102.1529423102130;
        Tue, 19 Jun 2018 08:45:02 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id q77-v6sm596176wmg.25.2018.06.19.08.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 08:45:01 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 2/3] rebase -i: rewrite setup_reflog_action() in C
Date:   Tue, 19 Jun 2018 17:44:20 +0200
Message-Id: <20180619154421.14999-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180619154421.14999-1-alban.gruin@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180619154421.14999-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites setup_reflog_action() from shell to C. The new version is
called checkout_base_commit().

A new command is added to rebase--helper.c, “checkout-base”, as such as
a new flag, “verbose”, to avoid silencing the output of the checkout
operation called by checkout_base_commit().

The shell version is then stripped in favour of a call to the helper. As
$GIT_REFLOG_ACTION is not longer set at the first call of
checkout_onto(), a call to comment_for_reflog() is added at the
beginning of this function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   |  9 +++++++--
 git-rebase--interactive.sh | 16 ++--------------
 sequencer.c                | 28 ++++++++++++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index d2990b210..7cd74da2e 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, verbose = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, CHECKOUT_BASE
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -27,6 +27,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT__VERBOSE(&verbose, N_("print subcommands output even if they succeed")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -50,6 +51,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "edit-todo", &command,
 			    N_("edit the todo list during an interactive rebase"),
 			    EDIT_TODO),
+		OPT_CMDMODE(0, "checkout-base", &command,
+			    N_("checkout the base commit"), CHECKOUT_BASE),
 		OPT_END()
 	};
 
@@ -93,5 +96,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!append_todo_help(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
+	if (command == CHECKOUT_BASE && argc == 2)
+		return !!checkout_base_commit(&opts, argv[1], verbose);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2defe607f..af46cf9c2 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -72,6 +72,7 @@ collapse_todo_ids() {
 
 # Switch to the branch in $into and notify it in the reflog
 checkout_onto () {
+	comment_for_reflog start
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
 	git update-ref ORIG_HEAD $orig_head
@@ -119,19 +120,6 @@ initiate_action () {
 	esac
 }
 
-setup_reflog_action () {
-	comment_for_reflog start
-
-	if test ! -z "$switch_to"
-	then
-		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-		output git checkout "$switch_to" -- ||
-			die "$(eval_gettext "Could not checkout \$switch_to")"
-
-		comment_for_reflog start
-	fi
-}
-
 init_basic_state () {
 	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
 	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
@@ -211,7 +199,7 @@ git_rebase__interactive () {
 		return 0
 	fi
 
-	setup_reflog_action
+	git rebase--helper --checkout-base "$switch_to" ${verbose:+--verbose}
 	init_basic_state
 
 	init_revisions_and_shortrevisions
diff --git a/sequencer.c b/sequencer.c
index 9aa7ddb33..a7a73e3ef 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3133,6 +3133,34 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+static int run_git_checkout(struct replay_opts *opts, const char *commit,
+				int verbose, const char *action)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	cmd.git_cmd = 1;
+
+	argv_array_push(&cmd.args, "checkout");
+	argv_array_push(&cmd.args, commit);
+	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
+
+	return run_command_silent_on_success(&cmd, verbose);
+}
+
+int checkout_base_commit(struct replay_opts *opts, const char *commit,
+			 int verbose)
+{
+	const char *action;
+
+	if (commit && *commit) {
+		action = reflog_message(opts, "start", "checkout %s", commit);
+		if (run_git_checkout(opts, commit, verbose, action))
+			return error(_("Could not checkout %s"), commit);
+	}
+
+	return 0;
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index 35730b13e..42c3dda81 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -100,6 +100,9 @@ int update_head_with_reflog(const struct commit *old_head,
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
+int checkout_base_commit(struct replay_opts *opts, const char *commit,
+			 int verbose);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
-- 
2.16.4

