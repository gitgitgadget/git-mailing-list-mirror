Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74EE620248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCSTEO (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:04:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53674 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfCSTEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:04:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id e74so17985230wmg.3
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=iqtHuef0ha1SGidogmgtRzyPQw7w5WTPOSsZHX1eA/Q=;
        b=trWxeRLH6H4CSarE9IgC1TZcyX4S0aNpMrcqgFhJhkLqcD/CasBql/QbOmcj2TNIEv
         VSgYSTd1u8SnrLQAXfcnwWJF8grLy0GM6B2miZV9Q6FCjh1S1Nx7Dr9YAMyGQ4esyyEr
         BaNtgoimnkYLZxTT2omjY7Mnc/zXkd3x/QQVtna7zWRIFx4O0iWWPe369Ft1s4OSwmaa
         AzO2+3y0lj4RA7iBp2GN4/TkQ2GD+AsU4Gni5LK/WS7YQ1wOT6pckWhT8zbUMlgLR1AW
         SE8bnpO32chyawTMSlAG27ugDq06NcLJSibYTiY5LVOi8W3DBg1VSO1SXRnUgrzIfj77
         HPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=iqtHuef0ha1SGidogmgtRzyPQw7w5WTPOSsZHX1eA/Q=;
        b=Bv5ZLIP/x2D46nTTi6ey3HYNGlng1JnWvPtQ9fgO4BBxFSceHee00qU/HlL/4UOKXn
         Xo1M8sSfqWgymcckCh2CkekZKJV2ejo0tZD2Ot5fo5KmrzWrG+4v/BCvLaDWzJaPwQp1
         98pLCt70Em17vCIJkBTydAhkZyB8LAfD5p8s+WqXMqkhGnKBunsiM+yU0yRPpliB30+3
         CncnK2ggre2EM/da0qlI8k2arv1h15FsASzAkhKagBe8kk6YL4PLI9Yyxs0oEOePsok5
         JN7ejneldy59uOQlKj6uVIYG6/LmzDW9ZoKfgOqyUwqauvCV6r94xyYc62Kj2l+ghA/2
         jYNA==
X-Gm-Message-State: APjAAAX41utb4vKDNy1u8v11uwm84igsq0mXRGnwkIBupLhjl/r+wMhp
        VnCxSfQPfMauCJmumI1goa/mUNr9R70=
X-Google-Smtp-Source: APXvYqzXXyup1yMYt/zXFANDC+rmwGOsQFptmQ4DjaJzvPbhGkrYrBx6V6sN03m/+AqfJSiYQDa2+Q==
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr4588243wmg.79.1553022247575;
        Tue, 19 Mar 2019 12:04:07 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:04:07 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 11/11] rebase -i: run without forking rebase--interactive
Date:   Tue, 19 Mar 2019 19:03:17 +0000
Message-Id: <20190319190317.6632-12-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the builtin rebase starts an interactive rebase it parses the
options and then repackages them and forks
`rebase--interactive`. Separate the option parsing in
cmd_rebase__interactive() from the business logic to allow interactive
rebases can be run without forking `rebase__interactive` by calling
run_rebase_interactive() directly. This makes it easy to debug the
sequencer without worrying about attaching to child processes. It also
makes it easy to remove cmd_rebase__interactive() in the future when
git-legacy-rebase.sh and git-rebase--preserve-merges.sh are retired.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 221 ++++++++++++++++++-----------------------------
 1 file changed, 86 insertions(+), 135 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 26d25a5242..2e26d350f0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -317,7 +317,9 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 				&revisions, &shortrevisions))
 		return -1;
 
-	if (init_basic_state(&replay, opts->head_name, opts->onto, head_hash)) {
+	if (init_basic_state(&replay,
+			     opts->head_name ? opts->head_name : "detached HEAD",
+			     opts->onto, head_hash)) {
 		free(revisions);
 		free(shortrevisions);
 
@@ -360,6 +362,77 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	return ret;
 }
 
+static int run_rebase_interactive(struct rebase_options *opts,
+				  enum action command)
+{
+	unsigned flags = 0;
+	int abbreviate_commands = 0, ret = 0;
+
+	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
+
+	flags |= opts->keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
+	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
+	flags |= opts->rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
+	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
+	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
+
+	switch (command) {
+	case ACTION_NONE: {
+		if (!opts->onto && !opts->upstream)
+			die(_("a base commit must be provided with --upstream or --onto"));
+
+		ret = do_interactive_rebase(opts, flags);
+		break;
+	}
+	case ACTION_SKIP: {
+		struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+		rerere_clear(the_repository, &merge_rr);
+	}
+		/* fallthrough */
+	case ACTION_CONTINUE: {
+		struct replay_opts replay_opts = get_replay_opts(opts);
+
+		ret = sequencer_continue(the_repository, &replay_opts);
+		break;
+	}
+	case ACTION_EDIT_TODO:
+		ret = edit_todo_file(flags);
+		break;
+	case ACTION_SHOW_CURRENT_PATCH: {
+		struct child_process cmd = CHILD_PROCESS_INIT;
+
+		cmd.git_cmd = 1;
+		argv_array_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
+		ret = run_command(&cmd);
+
+		break;
+	}
+	case ACTION_SHORTEN_OIDS:
+	case ACTION_EXPAND_OIDS:
+		ret = transform_todo_file(flags);
+		break;
+	case ACTION_CHECK_TODO_LIST:
+		ret = check_todo_list_from_file(the_repository);
+		break;
+	case ACTION_REARRANGE_SQUASH:
+		ret = rearrange_squash_in_todo_file();
+		break;
+	case ACTION_ADD_EXEC: {
+		struct string_list commands = STRING_LIST_INIT_DUP;
+
+		split_exec_commands(opts->cmd, &commands);
+		ret = add_exec_commands(&commands);
+		string_list_clear(&commands, 0);
+		break;
+	}
+	default:
+		BUG("invalid command '%d'", command);
+	}
+
+	return ret;
+}
+
 static const char * const builtin_rebase_interactive_usage[] = {
 	N_("git rebase--interactive [<options>]"),
 	NULL
@@ -368,8 +441,6 @@ static const char * const builtin_rebase_interactive_usage[] = {
 int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options opts = REBASE_OPTIONS_INIT;
-	unsigned flags = 0;
-	int abbreviate_commands = 0, ret = 0;
 	struct object_id squash_onto = null_oid;
 	enum action command = ACTION_NONE;
 	struct option options[] = {
@@ -434,8 +505,6 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 
 	opts.rebase_cousins = -1;
 
-	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
-
 	if (argc == 1)
 		usage_with_options(builtin_rebase_interactive_usage, options);
 
@@ -445,71 +514,11 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	if (!is_null_oid(&squash_onto))
 		opts.squash_onto = &squash_onto;
 
-	flags |= opts.keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
-	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
-	flags |= opts.rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
-	flags |= opts.rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
-	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
-
 	if (opts.rebase_cousins >= 0 && !opts.rebase_merges)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
-	switch (command) {
-	case ACTION_NONE: {
-		if (!opts.onto && !opts.upstream)
-			die(_("a base commit must be provided with --upstream or --onto"));
-
-		ret = do_interactive_rebase(&opts, flags);
-		break;
-	}
-	case ACTION_SKIP: {
-		struct string_list merge_rr = STRING_LIST_INIT_DUP;
-
-		rerere_clear(the_repository, &merge_rr);
-	}
-		/* fallthrough */
-	case ACTION_CONTINUE: {
-		struct replay_opts replay_opts = get_replay_opts(&opts);
-
-		ret = sequencer_continue(the_repository, &replay_opts);
-		break;
-	}
-	case ACTION_EDIT_TODO:
-		ret = edit_todo_file(flags);
-		break;
-	case ACTION_SHOW_CURRENT_PATCH: {
-		struct child_process cmd = CHILD_PROCESS_INIT;
-
-		cmd.git_cmd = 1;
-		argv_array_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
-		ret = run_command(&cmd);
-
-		break;
-	}
-	case ACTION_SHORTEN_OIDS:
-	case ACTION_EXPAND_OIDS:
-		ret = transform_todo_file(flags);
-		break;
-	case ACTION_CHECK_TODO_LIST:
-		ret = check_todo_list_from_file(the_repository);
-		break;
-	case ACTION_REARRANGE_SQUASH:
-		ret = rearrange_squash_in_todo_file();
-		break;
-	case ACTION_ADD_EXEC: {
-		struct string_list commands = STRING_LIST_INIT_DUP;
-
-		split_exec_commands(opts.cmd, &commands);
-		ret = add_exec_commands(&commands);
-		string_list_clear(&commands, 0);
-		break;
-	}
-	default:
-		BUG("invalid command '%d'", command);
-	}
-
-	return !!ret;
+	return !!run_rebase_interactive(&opts, command);
 }
 
 static int use_builtin_rebase(void)
@@ -1072,7 +1081,7 @@ static int run_am(struct rebase_options *opts)
 	return status;
 }
 
-static int run_specific_rebase(struct rebase_options *opts)
+static int run_specific_rebase(struct rebase_options *opts, enum action action)
 {
 	const char *argv[] = { NULL, NULL };
 	struct strbuf script_snippet = STRBUF_INIT, buf = STRBUF_INIT;
@@ -1081,77 +1090,19 @@ static int run_specific_rebase(struct rebase_options *opts)
 
 	if (opts->type == REBASE_INTERACTIVE) {
 		/* Run builtin interactive rebase */
-		struct child_process child = CHILD_PROCESS_INIT;
-
-		argv_array_pushf(&child.env_array, "GIT_CHERRY_PICK_HELP=%s",
-				 resolvemsg);
+		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
 		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
-			argv_array_push(&child.env_array,
-					"GIT_SEQUENCE_EDITOR=:");
+			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
 			opts->autosquash = 0;
 		}
+		if (opts->gpg_sign_opt) {
+			/* remove the leading "-S" */
+			char *tmp = xstrdup(opts->gpg_sign_opt + 2);
+			free(opts->gpg_sign_opt);
+			opts->gpg_sign_opt = tmp;
+		}
 
-		child.git_cmd = 1;
-		argv_array_push(&child.args, "rebase--interactive");
-
-		if (opts->action)
-			argv_array_pushf(&child.args, "--%s", opts->action);
-		if (opts->keep_empty)
-			argv_array_push(&child.args, "--keep-empty");
-		if (opts->rebase_merges)
-			argv_array_push(&child.args, "--rebase-merges");
-		if (opts->rebase_cousins)
-			argv_array_push(&child.args, "--rebase-cousins");
-		if (opts->autosquash)
-			argv_array_push(&child.args, "--autosquash");
-		if (opts->flags & REBASE_VERBOSE)
-			argv_array_push(&child.args, "--verbose");
-		if (opts->flags & REBASE_FORCE)
-			argv_array_push(&child.args, "--no-ff");
-		if (opts->restrict_revision)
-			argv_array_pushf(&child.args,
-					 "--restrict-revision=^%s",
-					 oid_to_hex(&opts->restrict_revision->object.oid));
-		if (opts->upstream)
-			argv_array_pushf(&child.args, "--upstream=%s",
-					 oid_to_hex(&opts->upstream->object.oid));
-		if (opts->onto)
-			argv_array_pushf(&child.args, "--onto=%s",
-					 oid_to_hex(&opts->onto->object.oid));
-		if (opts->squash_onto)
-			argv_array_pushf(&child.args, "--squash-onto=%s",
-					 oid_to_hex(opts->squash_onto));
-		if (opts->onto_name)
-			argv_array_pushf(&child.args, "--onto-name=%s",
-					 opts->onto_name);
-		argv_array_pushf(&child.args, "--head-name=%s",
-				 opts->head_name ?
-				 opts->head_name : "detached HEAD");
-		if (opts->strategy)
-			argv_array_pushf(&child.args, "--strategy=%s",
-					 opts->strategy);
-		if (opts->strategy_opts)
-			argv_array_pushf(&child.args, "--strategy-opts=%s",
-					 opts->strategy_opts);
-		if (opts->switch_to)
-			argv_array_pushf(&child.args, "--switch-to=%s",
-					 opts->switch_to);
-		if (opts->cmd)
-			argv_array_pushf(&child.args, "--cmd=%s", opts->cmd);
-		if (opts->allow_empty_message)
-			argv_array_push(&child.args, "--allow-empty-message");
-		if (opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE)
-			argv_array_push(&child.args, "--rerere-autoupdate");
-		else if (opts->allow_rerere_autoupdate == RERERE_NOAUTOUPDATE)
-			argv_array_push(&child.args, "--no-rerere-autoupdate");
-		if (opts->gpg_sign_opt)
-			argv_array_push(&child.args, opts->gpg_sign_opt);
-		if (opts->signoff)
-			argv_array_push(&child.args, "--signoff");
-		if (opts->reschedule_failed_exec)
-			argv_array_push(&child.args, "--reschedule-failed-exec");
-
-		status = run_command(&child);
+		status = run_rebase_interactive(opts, action);
 		goto finished_rebase;
 	}
 
@@ -2212,7 +2163,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	options.revisions = revisions.buf;
 
 run_rebase:
-	ret = !!run_specific_rebase(&options);
+	ret = !!run_specific_rebase(&options, action);
 
 cleanup:
 	strbuf_release(&revisions);
-- 
2.21.0

