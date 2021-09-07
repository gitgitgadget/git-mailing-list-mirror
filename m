Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1A1C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F73761090
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346849AbhIGVGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346666AbhIGVG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E54AC0613CF
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u9so16365131wrg.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=szrFP+/gqahXpQGXcxmmzdt5jMhIwUJjRm2DWV4JWZA=;
        b=qSiFoMT4Y0W6b6tMIowfq1bHo5ZJWqs54ZKkQofBTZuRMKDcMPfOFbUqll2Fe3VGnv
         PKisnd9peiBw7XGmS+BcZdpi6rhOh0lfgmIjmRy/Ym488F0nYHU8IrIV1zIxLnmwsqQG
         MLmQ90j7efaZUirSll42/BIuGdlTk6mR3irgVfGCAp6FZ17V9RE3B5UykRInwcSmIpJg
         ZS0zdPjv5OGfLDh1uwxUCgOzBHBprzszsjp27t8XcCj5QWh7w27wqu6l09vLKEPUY5JL
         Yiu9BTyXVRvj2YKWmTUFxiF7UDH62e2hJxBXANke8h6PT4kQltWa5sM0KOVOGjvoi4N7
         Q/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=szrFP+/gqahXpQGXcxmmzdt5jMhIwUJjRm2DWV4JWZA=;
        b=pKsNsdyD6RhqWsrKeOfAszuXFygcGo4oOZ30Sgk2HiWZ1RVVVqwtZVUkA3KW00VjLn
         TF7/32UOnsThZKZeQ1dmUvODcIovB+Cd344rOWmelJhaTa+1BrHWJK/ewwubYDL4V+K0
         0pb121cmjY8G7ZflEPSs7OPKxHlD/7NXL034wShyxN2S+lV97IU5YpLwzir+BjbfCUr9
         u9XUMfMXRxKlf7pmlQUB/MEcCH3f6tslyFyqpmHHbqoKP0F6ydLgmC6Fdgqm4L2leMvK
         71VXTjtANRecM14Ihc1/9Ni/vqxsuabzdLU+orQWQCBM87+VnChPItJFNU9lEhOSCuV0
         iOsg==
X-Gm-Message-State: AOAM533MbEOFHF9xZWW51vsUeycfeU/sVU520phgEfMlH5ap7pFqjXvf
        T6pZeLhvesmmUsvtmHLwAC+HcFGfbfg=
X-Google-Smtp-Source: ABdhPJwuzVRp78mz0toswK55te/XxcyfARrspbhrygqQ6fBmCIUIc9iaJmi4hr5XIwVSpjxry4dyNQ==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr325736wrq.247.1631048718736;
        Tue, 07 Sep 2021 14:05:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm91856wmb.47.2021.09.07.14.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:18 -0700 (PDT)
Message-Id: <b5a16e205e6c1fd4e888438c13bab9b7d992b7e9.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:08 +0000
Subject: [PATCH v3 07/11] rebase: drop the internal `rebase--interactive`
 command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It was only used by the `--preserve-merges` backend, which we just
removed.

Helped-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 193 +----------------------------------------------
 git.c            |   1 -
 2 files changed, 1 insertion(+), 193 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5f8d9f89ba4..0935e8d6e83 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -162,12 +162,7 @@ enum action {
 	ACTION_ABORT,
 	ACTION_QUIT,
 	ACTION_EDIT_TODO,
-	ACTION_SHOW_CURRENT_PATCH,
-	ACTION_SHORTEN_OIDS,
-	ACTION_EXPAND_OIDS,
-	ACTION_CHECK_TODO_LIST,
-	ACTION_REARRANGE_SQUASH,
-	ACTION_ADD_EXEC
+	ACTION_SHOW_CURRENT_PATCH
 };
 
 static const char *action_names[] = { "undefined",
@@ -178,81 +173,6 @@ static const char *action_names[] = { "undefined",
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
@@ -402,7 +322,6 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 	flags |= opts->rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
-	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 	flags |= opts->reapply_cherry_picks ? TODO_LIST_REAPPLY_CHERRY_PICKS : 0;
 
 	switch (command) {
@@ -437,24 +356,6 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 
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
@@ -476,98 +377,6 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static const char * const builtin_rebase_interactive_usage[] = {
-	N_("git rebase--interactive [<options>]"),
-	NULL
-};
-
-int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
-{
-	struct rebase_options opts = REBASE_OPTIONS_INIT;
-	struct object_id squash_onto = *null_oid();
-	enum action command = ACTION_NONE;
-	struct option options[] = {
-		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
-			   REBASE_FORCE),
-		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
-			N_("keep commits which start empty"),
-			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
-			parse_opt_keep_empty),
-		OPT_BOOL_F(0, "allow-empty-message", &opts.allow_empty_message,
-			   N_("allow commits with empty messages"),
-			   PARSE_OPT_HIDDEN),
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
-	return !!run_sequencer_rebase(&opts, command);
-}
-
 static int is_merge(struct rebase_options *opts)
 {
 	return opts->type == REBASE_MERGE;
diff --git a/git.c b/git.c
index 18bed9a9964..268cdd82cfc 100644
--- a/git.c
+++ b/git.c
@@ -577,7 +577,6 @@ static struct cmd_struct commands[] = {
 	{ "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
-	{ "rebase--interactive", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
-- 
gitgitgadget

