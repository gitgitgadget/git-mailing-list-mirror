Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C937E5CC
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642706; cv=none; b=EflMyUhrqJaY2WtxNgP+gW377AnrBTZdi1Wz7nB4Bk5lCMhw/tTs2/Oo8xdSCAOdasyhsA0drSnh6TUuINOfcqkkdOQsiwTR1qbRNBDpuMQzQOroyEfVJSmj7EIfCPF+BoBH122AiXSV/YZDXovMAxjBwNzhRBPcPXvm1jQuWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642706; c=relaxed/simple;
	bh=znMKJU1iXsZx19OmoO2n/H+9prnHtgGzRcPwsISseh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU/H6VyGkcXf3v/UVgwUVwBDF84atYcsrf5KbPcnthbuwHTcaJzGbhA5ThVkwASZVdBf5VY2gZtc+9tLta3+F+1IuQ+urKRFqgoCCHMMGN0fEt/46hY0tviFVaGjWcU6kovdB1wsfKVf9G+0qUshpLs/5EGv1O87jFizuuWLmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es; spf=pass smtp.mailfrom=hsal.es; dkim=pass (2048-bit key) header.d=hsal.es header.i=@hsal.es header.b=JJfzJFYd; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hsal.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hsal.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hsal.es header.i=@hsal.es header.b="JJfzJFYd"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h4Jzw6NlKzMlH9;
	Tue, 21 Jul 2026 16:05:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
	t=1784642700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfEU+pxdhzGIaHwEwAXK8MVrBPX9iCM6epQyMvNUszM=;
	b=JJfzJFYdSOD9YABV+lwOVgWfeZ6vyvydz1nRj2MwoxA5R8jidhCPFpZDdt1/W+IlHT4t2J
	gBFU0TzQnjTukxPAMFEMBX3oS4+13Q6h8+O57WB8NB2Zs1HR1c+8W5r81wqARe+6Bjf0iP
	aT1K4UAlmtOtamKvwfcJppDIQzGXW9FXRgUB0YquwAR7Qb5w2Ax2vUUA3vaAUQG1ftClhQ
	ORF6laR7JqaloC5Ledbr0A9awXypvHVtNStYZ2LuUeOL6Nu3FFtLSM8wlY8EwFamSStVhv
	ezraM7glYf7sk1uJ4xFGqAWM9T62LQjhWdqGWMQokZWVkwbCG/Akq2cG921nbw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: git@vger.kernel.org
Cc: Hugo Sales <hugo@hsal.es>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/1] rebase: add --[no-]edit to --continue
Date: Tue, 21 Jul 2026 15:04:42 +0100
Message-ID: <20260721140443.1809379-2-hugo@hsal.es>
In-Reply-To: <20260721140443.1809379-1-hugo@hsal.es>
References: <20260721140443.1809379-1-hugo@hsal.es>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4h4Jzw6NlKzMlH9

Allow skipping the editor when continuing after resolving conflicts,
via --no-edit or the rebase.noEdit configuration variable. The --edit
option overrides rebase.noEdit when both are set.

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 Documentation/config/rebase.adoc |  6 ++++
 Documentation/git-rebase.adoc    | 17 +++++++++--
 builtin/rebase.c                 | 29 ++++++++++++++++--
 sequencer.c                      | 29 +++++++++++++++++-
 t/t3436-rebase-more-options.sh   | 52 ++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/rebase.adoc b/Documentation/config/rebase.adoc
index c6187ab28b..321ab8b529 100644
--- a/Documentation/config/rebase.adoc
+++ b/Documentation/config/rebase.adoc
@@ -62,6 +62,12 @@ instead of:
 +
 Defaults to false.
 
+rebase.noEdit::
+	When set to true, `git rebase --continue` uses the commit message
+	without launching $EDITOR, as if `--no-edit` were given.  The
+	`--edit` option to `git rebase --continue` overrides this setting.
+	Defaults to false.
+
 rebase.rescheduleFailedExec::
 	Automatically reschedule `exec` commands that failed. This only makes
 	sense in interactive mode (or when an `--exec` option was provided).
diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..cc0a69b5a5 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -181,6 +181,16 @@ including not with each other:
 
 --continue::
 	Restart the rebasing process after having resolved a merge conflict.
++
+-e::
+--edit::
+--no-edit::
+	With `--continue`, edit or do not edit the commit message,
+	respectively. By default, the configured $EDITOR is opened so you
+	can update the commit message after resolving conflicts.
+	`--no-edit` reuses the existing message without launching an
+	editor. The `rebase.noEdit` configuration variable can be used to
+	enable `--no-edit` by default; `--edit` overrides that setting.
 
 --skip::
 	Restart the rebasing process by skipping the current patch.
@@ -783,9 +793,10 @@ Commit Rewording
 When a conflict occurs while rebasing, rebase stops and asks the user
 to resolve.  Since the user may need to make notable changes while
 resolving conflicts, after conflicts are resolved and the user has run
-`git rebase --continue`, the rebase should open an editor and ask the
-user to update the commit message.  The 'merge' backend does this, while
-the 'apply' backend blindly applies the original commit message.
+`git rebase --continue`, the rebase opens an editor and asks the
+user to update the commit message, unless `rebase.noEdit` is set or
+`--no-edit` is passed to `--continue`.  The 'merge' backend does this,
+while the 'apply' backend blindly applies the original commit message.
 
 Miscellaneous differences
 ~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 10a306310c..5827b20baf 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -43,7 +43,7 @@ static char const * const builtin_rebase_usage[] = {
 		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
 		"--root [<branch>]"),
-	"git rebase --continue | --abort | --skip | --edit-todo",
+	"git rebase --continue [--[no-]edit] | --abort | --skip | --edit-todo",
 	NULL
 };
 
@@ -135,6 +135,8 @@ struct rebase_options {
 	int config_autosquash;
 	int config_rebase_merges;
 	int config_update_refs;
+	int config_no_edit;
+	int edit;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -156,6 +158,8 @@ struct rebase_options {
 		.update_refs = -1,                      \
 		.config_update_refs = -1,               \
 		.strategy_opts = STRING_LIST_INIT_NODUP,\
+		.config_no_edit = -1,                   \
+		.edit = -1,                             \
 	}
 
 static void rebase_options_release(struct rebase_options *opts)
@@ -215,6 +219,13 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 		replay.have_squash_onto = 1;
 	}
 
+	if (opts->action == ACTION_CONTINUE) {
+		if (opts->edit >= 0)
+			replay.edit = opts->edit;
+		else if (opts->config_no_edit > 0)
+			replay.edit = 0;
+	}
+
 	return replay;
 }
 
@@ -841,6 +852,11 @@ static int rebase_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.noedit")) {
+		opts->config_no_edit = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.forkpoint")) {
 		opts->fork_point = git_config_bool(var, value) ? -1 : 0;
 		return 0;
@@ -1171,6 +1187,8 @@ int cmd_rebase(int argc,
 			    ACTION_CONTINUE),
 		OPT_CMDMODE(0, "skip", &options.action,
 			    N_("skip current patch and continue"), ACTION_SKIP),
+		OPT_BOOL('e', "edit", &options.edit,
+			 N_("edit the commit message")),
 		OPT_CMDMODE(0, "abort", &options.action,
 			    N_("abort and check out the original branch"),
 			    ACTION_ABORT),
@@ -1311,10 +1329,15 @@ int cmd_rebase(int argc,
 			"which is no longer supported; use 'merges' instead"));
 
 	if (options.action != ACTION_NONE && total_argc != 2) {
-		usage_with_options(builtin_rebase_usage,
-				   builtin_rebase_options);
+		if (options.action != ACTION_CONTINUE ||
+		    options.edit < 0 || total_argc != 3)
+			usage_with_options(builtin_rebase_usage,
+					   builtin_rebase_options);
 	}
 
+	if (options.edit >= 0 && options.action != ACTION_CONTINUE)
+		die(_("--edit and --no-edit can only be used with --continue"));
+
 	if (argc > 2)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
diff --git a/sequencer.c b/sequencer.c
index 1355a99a09..be2945b12d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2211,6 +2211,25 @@ static int should_edit(struct replay_opts *opts) {
 	return opts->edit;
 }
 
+static int should_edit_rebase_continue(struct replay_opts *opts)
+{
+	if (opts->edit < 0)
+		return 1;
+	return opts->edit;
+}
+
+static void finalize_continue_edit_flags(struct replay_opts *opts,
+					 unsigned int *flags)
+{
+	if (*flags & CLEANUP_MSG)
+		return;
+
+	if (should_edit_rebase_continue(opts))
+		*flags |= EDIT_MSG;
+	else
+		*flags &= ~EDIT_MSG;
+}
+
 static void refer_to_commit(struct repository *r, struct strbuf *msgbuf,
 			    const struct commit *commit,
 			    bool use_commit_reference)
@@ -5281,7 +5300,7 @@ static int commit_staged_changes(struct repository *r,
 				 struct todo_list *todo_list)
 {
 	struct replay_ctx *ctx = opts->ctx;
-	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
+	unsigned int flags = ALLOW_EMPTY;
 	unsigned int final_fixup = 0, is_clean;
 	struct strbuf rev = STRBUF_INIT;
 	const char *reflog_action = reflog_message(opts, "continue", NULL);
@@ -5446,6 +5465,8 @@ static int commit_staged_changes(struct repository *r,
 		}
 	}
 
+	finalize_continue_edit_flags(opts, &flags);
+
 	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
 			   reflog_action, opts, flags)) {
 		ret = error(_("could not commit staged changes."));
@@ -5503,6 +5524,12 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			res = -1;
 			goto release_todo_list;
 		}
+
+		/*
+		 * Command-line --[no-]edit applies only to this
+		 * --continue invocation, not to subsequent picks.
+		 */
+		opts->edit = -1;
 	} else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick(r, opts);
 	else if ((res = read_populate_todo(r, &todo_list, opts)))
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 94671d3c46..c84c6717ab 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -201,6 +201,58 @@ test_expect_success '--ignore-date is an alias for --reset-author-date' '
 	test_atime_is_ignored -2
 '
 
+test_expect_success '--no-edit on continue uses existing commit message' '
+	git checkout commit2 &&
+	test_must_fail git rebase -m --onto commit2^^ commit2^ &&
+	echo resolved >foo &&
+	git add foo &&
+	write_script fail-if-editor-invoked <<-\EOF &&
+	echo editor invoked >&2
+	exit 1
+	EOF
+	GIT_EDITOR=./fail-if-editor-invoked git rebase --continue --no-edit &&
+	git log --format=%s -1 >actual &&
+	echo commit2 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-edit cannot be used when starting a rebase' '
+	test_must_fail git rebase --no-edit -m main side 2>err &&
+	test_grep "only be used with --continue" err
+'
+
+test_expect_success 'rebase.noEdit skips editor on continue' '
+	git config rebase.noEdit true &&
+	git checkout commit2 &&
+	test_must_fail git rebase -m --onto commit2^^ commit2^ &&
+	echo resolved >foo &&
+	git add foo &&
+	write_script fail-if-editor-invoked <<-\EOF &&
+	echo editor invoked >&2
+	exit 1
+	EOF
+	GIT_EDITOR=./fail-if-editor-invoked git rebase --continue &&
+	git log --format=%s -1 >actual &&
+	echo commit2 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--edit on continue overrides rebase.noEdit' '
+	git config rebase.noEdit true &&
+	git checkout commit2 &&
+	test_must_fail git rebase -m --onto commit2^^ commit2^ &&
+	echo resolved >foo &&
+	git add foo &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_MESSAGE="edited on continue" \
+			git rebase --continue --edit
+	) &&
+	test_write_lines "edited on continue" "" >expect &&
+	git log --format=%B -1 >actual &&
+	test_cmp expect actual
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.54.0

