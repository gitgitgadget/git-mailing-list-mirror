Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28DC11F516
	for <e@80x24.org>; Mon,  2 Jul 2018 10:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933311AbeGBK6S (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 06:58:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35644 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbeGBK6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 06:58:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id h40-v6so3977046wrh.2
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXLD6prqNFZoPXRrM8+b+LaaNBGbwKDLZQhV7PydGAY=;
        b=s47k4eE32moYvOIJccuUjFwnQU213v9NfxS4nGJbHcYCJkihERBhWuoSmtq/SyBAWx
         ZOo4RKxzX7wpVzxeIgC9Bfx3WJSSYL+NtXSZuuiCgDDfBjlVZia2zkc6T2MB7KdC8u5d
         qm4qR+IhlOSjY0ZKNE7aSZ0PLbyqo46B1uQv1P/rlvr0CYefot2wz+CO6Jy+tDcsOa4G
         Zv/HOPvNvxfVTHFVkzVluEtmb89pt1cD11VQqrMbs6jleqY8v81hZhrQfBslZOKOJn8U
         IYxcNDe3/seApaIMwHwwIPcyfZiLzdM7roSMFUfD1fKLkkUlEdtztR03Z+4BMqUGG0Gw
         s4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXLD6prqNFZoPXRrM8+b+LaaNBGbwKDLZQhV7PydGAY=;
        b=ZQgHtLzWNP/xIXM22MzwC/GHqhn9ZA7m9nGRszbI9U7wAX6n5U9gNlLhXWZ2+jMQoG
         VESBmwvBdeYDlr9cYIDHB3vJI+qgnaqyqxgXCTwssKuIym0ibabrC7aF3guLLIIPmcsg
         QMpKVrDhiF5S30pGvcFKedBkMR6hplsZXa6+8KVF6lAh7pcBL8x60dvqkfDZ4kjMWzme
         fIExLMpKdBfORuOl+cfjdij7igGTzxSQar77QN0g5toVGoGRaST8pQy5OZET5IMpQpPW
         KIhLzqewlBKjR31SM76osXDy6VkIPt7mk5ypB58bBP/FAuQVd3GekPhX2dqcdw9Avp9P
         qoPA==
X-Gm-Message-State: APt69E0kriQ/3fsA17HrziV7jB8fEi5HMrhA8gW1NF93oR4Gv0awnv94
        uvfIXKRE0sdPfdlN9JtauqyQN14t
X-Google-Smtp-Source: AAOMgpcZFhru8lTLLlXAdCwtqU2U34VfgCBTy1/ZaDIaK7E5V6oiFdsmbG61jvrTR8i3EB9p2nTWTg==
X-Received: by 2002:adf:97d5:: with SMTP id t21-v6mr3374581wrb.28.1530529089532;
        Mon, 02 Jul 2018 03:58:09 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id m64-v6sm7462437wmb.38.2018.07.02.03.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 03:58:08 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 6/7] rebase -i: rewrite setup_reflog_action() in C
Date:   Mon,  2 Jul 2018 12:57:16 +0200
Message-Id: <20180702105717.26386-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702105717.26386-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites (the misnamed) setup_reflog_action() from shell to C. The
new version is called prepare_branch_to_be_rebased().

A new command is added to rebase--helper.c, “checkout-base”, as well as
a new flag, “verbose”, to avoid silencing the output of the checkout
operation called by checkout_base_commit().

The function `run_git_checkout()` will also be used in the next commit,
therefore its code is not part of `checkout_base_commit()`.

The shell version is then stripped in favour of a call to the helper.

As $GIT_REFLOG_ACTION is no longer set at the first call of
checkout_onto(), a call to comment_for_reflog() is added at the
beginning of this function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   |  9 +++++++--
 git-rebase--interactive.sh | 16 ++--------------
 sequencer.c                | 30 ++++++++++++++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 731a64971..6c789e78b 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,12 +13,12 @@ static const char * const builtin_rebase_helper_usage[] = {
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
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -28,6 +28,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -51,6 +52,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "edit-todo", &command,
 			    N_("edit the todo list during an interactive rebase"),
 			    EDIT_TODO),
+		OPT_CMDMODE(0, "prepare-branch", &command,
+			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_END()
 	};
 
@@ -94,5 +97,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!append_todo_help(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
+	if (command == PREPARE_BRANCH && argc == 2)
+		return !!prepare_branch_to_be_rebased(&opts, argv[1], verbose);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2defe607f..77e972bb6 100644
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
+	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
 	init_basic_state
 
 	init_revisions_and_shortrevisions
diff --git a/sequencer.c b/sequencer.c
index 9e2b34a49..a61276d2c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3132,6 +3132,36 @@ static const char *reflog_message(struct replay_opts *opts,
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
+	if (verbose)
+		return run_command(&cmd);
+	return run_command_silent_on_success(&cmd);
+}
+
+int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit,
+				 int verbose)
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
index ffab798f1..3821420b0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -106,6 +106,9 @@ int update_head_with_reflog(const struct commit *old_head,
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
+int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit,
+				 int verbose);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
-- 
2.18.0

