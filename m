Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC248C43215
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9CE20672
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODuUoPnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKWUuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:50:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56223 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKWUuv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 15:50:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so11137679wmb.5
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 12:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4qIZXXR+NmUCcvaonVP8arE9ezZ9Da2fCnzp2UDnRiI=;
        b=ODuUoPnRR15U3ychJZuEfC1lfMEnSxzUdNstu2bsp3XAy8mw2DTKn7Q6rR3FKmlzba
         YyJOKCmM1+VVv+RF4zi471dA7k2f+6/NFk+wiLzS8qhtKw9Ro1q/oTnJgPOwGcmpmNmg
         ghUsikPfJPFkkHnpOypUn1jeNrMfX7RLSE18TwqfhpGnQjj0ZPBecosAHfLH1W8FDKs8
         6jC2wXXyZ8/L9HYOicriWcAqj+IzaUuWkM5wDUoBpXBkCF0Ob28uSjXbKwvRr4ebH8z5
         Am5I2LMTZTsxHsWesFRFeccAZ9Z7AnzP3W5OdCElbdNZcZC/6yLVeLXRElEK1ZVzt2Li
         dtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4qIZXXR+NmUCcvaonVP8arE9ezZ9Da2fCnzp2UDnRiI=;
        b=UwsUE+aKQ2GKMNdEA5aHwrLsd6nIHUAuV2oXEDswZQlfNZfP+QZz1XGvSSuiRuDm+1
         TFGjPti4Ynr0W3/XP8XMDlCQkBPKDnKq54AdZ0DA/RhgsDNhE/ifyH1Y3fzeRmY4o8o1
         FnzWQzub/1H1d2qqH5X+ay2DEU9ykL2nzXN2wDy741JSqHUa3E3Pnga78qHg6WAnrwpY
         rGMd9rGtDK4Q/MGSDAIvPjT8MiX1xA6d0cIlgFaGLRPlZERsLB/+45aJTWCU4D89htkx
         CkFqd9FG18j5VN6BDociWu7nG87nk/6qOYLcdCQFa6/4k4vpGLdPF512gCZXHlBm/hVx
         2g7w==
X-Gm-Message-State: APjAAAURSYMWl8CZmqGvMy74fYJo/roZU/O0GlFHGVtmp0OJ2NCJYc6g
        jaK17i50cK9N4OoMHQF3C8MyUKxJ
X-Google-Smtp-Source: APXvYqwZyPDth/6Vb7dwJoC5tuSrbP+Locm/wrQ+4vwEvNXggOI56KY472nVbhrMCizd6E3OVJ8Hew==
X-Received: by 2002:a1c:152:: with SMTP id 79mr21550091wmb.70.1574542249237;
        Sat, 23 Nov 2019 12:50:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm3642639wrb.67.2019.11.23.12.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 12:50:48 -0800 (PST)
Message-Id: <634e4141e9737835f758c28784d8cd452b0d12f9.1574542243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.git.1574542242.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 20:50:41 +0000
Subject: [PATCH 7/8] rebase: drop the internal `rebase--interactive` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It was only used by the `--preserve-merges` backend, which we just
removed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 181 -----------------------------------------------
 git.c            |   1 -
 2 files changed, 182 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2970a9ae47..69ec2da624 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -142,81 +142,6 @@ static const char *action_names[] = { "undefined",
 				      "edit_todo",
 				      "show_current_patch" };
 
-static int add_exec_commands(struct string_list *commands)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
-					&todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	todo_list_add_exec_commands(&todo_list, commands);
-	res = todo_list_write_to_file(the_repository, &todo_list,
-				      todo_file, NULL, NULL, -1, 0);
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
-
-static int rearrange_squash_in_todo_file(void)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res = 0;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
-					&todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	res = todo_list_rearrange_squash(&todo_list);
-	if (!res)
-		res = todo_list_write_to_file(the_repository, &todo_list,
-					      todo_file, NULL, NULL, -1, 0);
-
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
-
-static int transform_todo_file(unsigned flags)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
-					&todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	res = todo_list_write_to_file(the_repository, &todo_list, todo_file,
-				      NULL, NULL, -1, flags);
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
-
 static int edit_todo_file(unsigned flags)
 {
 	const char *todo_file = rebase_path_todo();
@@ -408,24 +333,6 @@ static int run_rebase_interactive(struct rebase_options *opts,
 
 		break;
 	}
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
-		split_exec_commands(opts->cmd, &commands);
-		ret = add_exec_commands(&commands);
-		string_list_clear(&commands, 0);
-		break;
-	}
 	default:
 		BUG("invalid command '%d'", command);
 	}
@@ -433,94 +340,6 @@ static int run_rebase_interactive(struct rebase_options *opts,
 	return ret;
 }
 
-static const char * const builtin_rebase_interactive_usage[] = {
-	N_("git rebase--interactive [<options>]"),
-	NULL
-};
-
-int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
-{
-	struct rebase_options opts = REBASE_OPTIONS_INIT;
-	struct object_id squash_onto = null_oid;
-	enum action command = ACTION_NONE;
-	struct option options[] = {
-		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
-			   REBASE_FORCE),
-		OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits")),
-		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
-			 N_("allow commits with empty messages")),
-		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase merge commits")),
-		OPT_BOOL(0, "rebase-cousins", &opts.rebase_cousins,
-			 N_("keep original branch points of cousins")),
-		OPT_BOOL(0, "autosquash", &opts.autosquash,
-			 N_("move commits that begin with squash!/fixup!")),
-		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
-		OPT_BIT('v', "verbose", &opts.flags,
-			N_("display a diffstat of what changed upstream"),
-			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
-		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
-			    ACTION_CONTINUE),
-		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), ACTION_SKIP),
-		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo list"),
-			    ACTION_EDIT_TODO),
-		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
-			    ACTION_SHOW_CURRENT_PATCH),
-		OPT_CMDMODE(0, "shorten-ids", &command,
-			N_("shorten commit ids in the todo list"), ACTION_SHORTEN_OIDS),
-		OPT_CMDMODE(0, "expand-ids", &command,
-			N_("expand commit ids in the todo list"), ACTION_EXPAND_OIDS),
-		OPT_CMDMODE(0, "check-todo-list", &command,
-			N_("check the todo list"), ACTION_CHECK_TODO_LIST),
-		OPT_CMDMODE(0, "rearrange-squash", &command,
-			N_("rearrange fixup/squash lines"), ACTION_REARRANGE_SQUASH),
-		OPT_CMDMODE(0, "add-exec-commands", &command,
-			N_("insert exec commands in todo list"), ACTION_ADD_EXEC),
-		{ OPTION_CALLBACK, 0, "onto", &opts.onto, N_("onto"), N_("onto"),
-		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
-		{ OPTION_CALLBACK, 0, "restrict-revision", &opts.restrict_revision,
-		  N_("restrict-revision"), N_("restrict revision"),
-		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
-		{ OPTION_CALLBACK, 0, "squash-onto", &squash_onto, N_("squash-onto"),
-		  N_("squash onto"), PARSE_OPT_NONEG, parse_opt_object_id, 0 },
-		{ OPTION_CALLBACK, 0, "upstream", &opts.upstream, N_("upstream"),
-		  N_("the upstream commit"), PARSE_OPT_NONEG, parse_opt_commit,
-		  0 },
-		OPT_STRING(0, "head-name", &opts.head_name, N_("head-name"), N_("head name")),
-		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign_opt, N_("key-id"),
-			N_("GPG-sign commits"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
-			   N_("rebase strategy")),
-		OPT_STRING(0, "strategy-opts", &opts.strategy_opts, N_("strategy-opts"),
-			   N_("strategy options")),
-		OPT_STRING(0, "switch-to", &opts.switch_to, N_("switch-to"),
-			   N_("the branch or commit to checkout")),
-		OPT_STRING(0, "onto-name", &opts.onto_name, N_("onto-name"), N_("onto name")),
-		OPT_STRING(0, "cmd", &opts.cmd, N_("cmd"), N_("the command to run")),
-		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_autoupdate),
-		OPT_BOOL(0, "reschedule-failed-exec", &opts.reschedule_failed_exec,
-			 N_("automatically re-schedule any `exec` that fails")),
-		OPT_END()
-	};
-
-	opts.rebase_cousins = -1;
-
-	if (argc == 1)
-		usage_with_options(builtin_rebase_interactive_usage, options);
-
-	argc = parse_options(argc, argv, prefix, options,
-			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
-
-	if (!is_null_oid(&squash_onto))
-		opts.squash_onto = &squash_onto;
-
-	if (opts.rebase_cousins >= 0 && !opts.rebase_merges)
-		warning(_("--[no-]rebase-cousins has no effect without "
-			  "--rebase-merges"));
-
-	return !!run_rebase_interactive(&opts, command);
-}
-
 static int is_interactive(struct rebase_options *opts)
 {
 	return opts->type == REBASE_INTERACTIVE;
diff --git a/git.c b/git.c
index ce6ab0ece2..015e155dcd 100644
--- a/git.c
+++ b/git.c
@@ -551,7 +551,6 @@ static struct cmd_struct commands[] = {
 	{ "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
-	{ "rebase--interactive", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
-- 
gitgitgadget

