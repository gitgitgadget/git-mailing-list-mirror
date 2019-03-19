Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11ABD20248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfCSTEK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:04:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50385 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfCSTEH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:04:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so9580030wmi.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=W6xycFlSlcOqSn91aIjFVvRI7W0T9IFSEbN6hXT8Q9s=;
        b=I7TLIFuew6T5d0kjo3TWUEYZ7jqVZWG72WfV+azH4RUc7sbVCmDZJWuIebNWajiJ+F
         iSSYIl1xS2ucD2qgjNiDezBzZihPCa4bA22y53ibQ2vjgqKhkTUKeTyHtnFKFUoLtYG8
         kBES6KC1wN3YB0JIcM1Ea4Wz08YhjL0eN9hsCq1pFGGfe8rja4d1PcPNh6SHN1fZlF+h
         5iUiDVG7kXWI4xtmj/d05IX4u4XpKC0dQ49G/rCsdwzYwK+XVioTfZmEj0AIB379n4d8
         wznx1Dc0dqGLtX8BACv+5X3QTfkfe2UHgUhLXhgyW8AzUM8oUIOCGh8PjSy3URe/MVz8
         k3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=W6xycFlSlcOqSn91aIjFVvRI7W0T9IFSEbN6hXT8Q9s=;
        b=hcqMToHGUm8WDs+GVplMOU08dYKLDUNeX20wNMThj9+tlnDjLGMyCL9LnCHRtL7pf9
         HKvt2z5obUQMK8Yp6LaRtFhp9jI/8m12ONt3wjbyWFvxo0WZf4dSAVyoL5akbJU2CXOq
         x1z4TEwKDRqQi1RwgFKjZgfL6DKljy7BcyQAgy7IeQ/BN6I4eQ4EVBADefw/rjGEs5rB
         hD/GixsNatAkQ6N5k36GTX6C1fRRn63Lud/knYjl/hW9L5zAhCmK4zEtZNCU9e6Hwwpn
         Ramsp/DCYQyF132SLBxNzZ1de3sFCXbx1IZZ6ZwePjMUR6PoFQX5+iN4aEZ4tZRAktd1
         tBzA==
X-Gm-Message-State: APjAAAWETRGkEF+8LtIuUUynWHDcE2qJ9i1W9BvNTRofHUOOGrIkfBTE
        dvgWJ5HvWTGyamrfKoQDQz/+4od8xgg=
X-Google-Smtp-Source: APXvYqyaLqXcHmfdOyaojE512J1AeDcLzG0kJaxO9jOP6Uzb7U2lqP6CaRnRh1xufJWY/a8DD2TByA==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr4777840wmb.48.1553022244358;
        Tue, 19 Mar 2019 12:04:04 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:04:03 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 08/11] rebase -i: use struct rebase_options to parse args
Date:   Tue, 19 Mar 2019 19:03:14 +0000
Message-Id: <20190319190317.6632-9-phillip.wood123@gmail.com>
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

In order to run `rebase -i` without forking `rebase--interactive` it
will be convenient to use the same structure when parsing the options in
cmd_rebase() and cmd_rebase__interactive().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 203 ++++++++++++++++++++++++++---------------------
 1 file changed, 112 insertions(+), 91 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c93f2aa629..33a2495032 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -50,6 +50,73 @@ enum rebase_type {
 	REBASE_PRESERVE_MERGES
 };
 
+struct rebase_options {
+	enum rebase_type type;
+	const char *state_dir;
+	struct commit *upstream;
+	const char *upstream_name;
+	const char *upstream_arg;
+	char *head_name;
+	struct object_id orig_head;
+	struct commit *onto;
+	const char *onto_name;
+	const char *revisions;
+	const char *switch_to;
+	int root;
+	struct object_id *squash_onto;
+	struct commit *restrict_revision;
+	int dont_finish_rebase;
+	enum {
+		REBASE_NO_QUIET = 1<<0,
+		REBASE_VERBOSE = 1<<1,
+		REBASE_DIFFSTAT = 1<<2,
+		REBASE_FORCE = 1<<3,
+		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
+	} flags;
+	struct argv_array git_am_opts;
+	const char *action;
+	int signoff;
+	int allow_rerere_autoupdate;
+	int keep_empty;
+	int autosquash;
+	char *gpg_sign_opt;
+	int autostash;
+	char *cmd;
+	int allow_empty_message;
+	int rebase_merges, rebase_cousins;
+	char *strategy, *strategy_opts;
+	struct strbuf git_format_patch_opt;
+	int reschedule_failed_exec;
+};
+
+#define REBASE_OPTIONS_INIT {			  	\
+		.type = REBASE_UNSPECIFIED,	  	\
+		.flags = REBASE_NO_QUIET, 		\
+		.git_am_opts = ARGV_ARRAY_INIT,		\
+		.git_format_patch_opt = STRBUF_INIT	\
+	}
+
+static struct replay_opts get_replay_opts(const struct rebase_options *opts)
+{
+	struct replay_opts replay = REPLAY_OPTS_INIT;
+
+	sequencer_init_config(&replay);
+
+	replay.action = REPLAY_INTERACTIVE_REBASE;
+	replay.signoff = opts->signoff;
+	replay.allow_ff = !(opts->flags & REBASE_FORCE);
+	if (opts->allow_rerere_autoupdate)
+		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
+	replay.allow_empty = 1;
+	replay.allow_empty_message = opts->allow_empty_message;
+	replay.verbose = opts->flags & REBASE_VERBOSE;
+	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
+	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
+	replay.strategy = opts->strategy;
+
+	return replay;
+}
+
 static int add_exec_commands(struct string_list *commands)
 {
 	const char *todo_file = rebase_path_todo();
@@ -265,32 +332,30 @@ static const char * const builtin_rebase_interactive_usage[] = {
 
 int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 {
-	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1, ret = 0;
-	const char *onto_name = NULL, *head_name = NULL, *switch_to = NULL,
-		*cmd = NULL;
-	struct commit *onto = NULL, *upstream = NULL, *restrict_revision = NULL;
+	struct rebase_options opts = REBASE_OPTIONS_INIT;
+	unsigned flags = 0;
+	int abbreviate_commands = 0, ret = 0;
 	struct object_id squash_onto = null_oid;
-	struct object_id *squash_onto_opt = NULL;
 	struct string_list commands = STRING_LIST_INIT_DUP;
-	char *raw_strategies = NULL;
 	enum {
 		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
 		SHORTEN_OIDS, EXPAND_OIDS, CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC
 	} command = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
-		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
+		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
+			   REBASE_FORCE),
+		OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits")),
 		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
 			 N_("allow commits with empty messages")),
-		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
-		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
+		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase merge commits")),
+		OPT_BOOL(0, "rebase-cousins", &opts.rebase_cousins,
 			 N_("keep original branch points of cousins")),
-		OPT_BOOL(0, "autosquash", &autosquash,
+		OPT_BOOL(0, "autosquash", &opts.autosquash,
 			 N_("move commits that begin with squash!/fixup!")),
 		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
-		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
+		OPT_BIT('v', "verbose", &opts.flags,
+			N_("display a diffstat of what changed upstream"),
+			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 			    CONTINUE),
 		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), SKIP),
@@ -308,86 +373,86 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
 		OPT_CMDMODE(0, "add-exec-commands", &command,
 			N_("insert exec commands in todo list"), ADD_EXEC),
-		{ OPTION_CALLBACK, 0, "onto", &onto, N_("onto"), N_("onto"),
+		{ OPTION_CALLBACK, 0, "onto", &opts.onto, N_("onto"), N_("onto"),
 		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
-		{ OPTION_CALLBACK, 0, "restrict-revision", &restrict_revision,
+		{ OPTION_CALLBACK, 0, "restrict-revision", &opts.restrict_revision,
 		  N_("restrict-revision"), N_("restrict revision"),
 		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
 		{ OPTION_CALLBACK, 0, "squash-onto", &squash_onto, N_("squash-onto"),
 		  N_("squash onto"), PARSE_OPT_NONEG, parse_opt_object_id, 0 },
-		{ OPTION_CALLBACK, 0, "upstream", &upstream, N_("upstream"),
+		{ OPTION_CALLBACK, 0, "upstream", &opts.upstream, N_("upstream"),
 		  N_("the upstream commit"), PARSE_OPT_NONEG, parse_opt_commit,
 		  0 },
-		OPT_STRING(0, "head-name", &head_name, N_("head-name"), N_("head name")),
-		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign, N_("key-id"),
+		OPT_STRING(0, "head-name", &opts.head_name, N_("head-name"), N_("head name")),
+		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign_opt, N_("key-id"),
 			N_("GPG-sign commits"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
 			   N_("rebase strategy")),
-		OPT_STRING(0, "strategy-opts", &raw_strategies, N_("strategy-opts"),
+		OPT_STRING(0, "strategy-opts", &opts.strategy_opts, N_("strategy-opts"),
 			   N_("strategy options")),
-		OPT_STRING(0, "switch-to", &switch_to, N_("switch-to"),
+		OPT_STRING(0, "switch-to", &opts.switch_to, N_("switch-to"),
 			   N_("the branch or commit to checkout")),
-		OPT_STRING(0, "onto-name", &onto_name, N_("onto-name"), N_("onto name")),
-		OPT_STRING(0, "cmd", &cmd, N_("cmd"), N_("the command to run")),
-		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_auto),
+		OPT_STRING(0, "onto-name", &opts.onto_name, N_("onto-name"), N_("onto name")),
+		OPT_STRING(0, "cmd", &opts.cmd, N_("cmd"), N_("the command to run")),
+		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_autoupdate),
 		OPT_BOOL(0, "reschedule-failed-exec", &opts.reschedule_failed_exec,
 			 N_("automatically re-schedule any `exec` that fails")),
 		OPT_END()
 	};
 
-	sequencer_init_config(&opts);
+	opts.rebase_cousins = -1;
+
 	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
 
-	opts.action = REPLAY_INTERACTIVE_REBASE;
-	opts.allow_ff = 1;
-	opts.allow_empty = 1;
-
 	if (argc == 1)
 		usage_with_options(builtin_rebase_interactive_usage, options);
 
 	argc = parse_options(argc, argv, NULL, options,
 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
 
-	opts.gpg_sign = xstrdup_or_null(opts.gpg_sign);
-
 	if (!is_null_oid(&squash_onto))
-		squash_onto_opt = &squash_onto;
+		opts.squash_onto = &squash_onto;
 
-	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
+	flags |= opts.keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
-	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
-	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
+	flags |= opts.rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
+	flags |= opts.rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
-	if (rebase_cousins >= 0 && !rebase_merges)
+	if (opts.rebase_cousins >= 0 && !opts.rebase_merges)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
-	if (cmd && *cmd) {
-		string_list_split(&commands, cmd, '\n', -1);
+	if (opts.cmd && *opts.cmd) {
+		string_list_split(&commands, opts.cmd, '\n', -1);
 
 		/* rebase.c adds a new line to cmd after every command,
 		 * so here the last command is always empty */
 		string_list_remove_empty_items(&commands, 0);
 	}
 
 	switch (command) {
-	case NONE:
-		if (!onto && !upstream)
+	case NONE: {
+		struct replay_opts replay_opts = get_replay_opts(&opts);
+		if (!opts.onto && !opts.upstream)
 			die(_("a base commit must be provided with --upstream or --onto"));
 
-		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
-					    onto_name, squash_onto_opt, head_name, restrict_revision,
-					    raw_strategies, &commands, autosquash);
+		ret = do_interactive_rebase(&replay_opts, flags, opts.switch_to, opts.upstream, opts.onto,
+					    opts.onto_name, opts.squash_onto, opts.head_name, opts.restrict_revision,
+					    opts.strategy_opts, &commands, opts.autosquash);
 		break;
+	}
 	case SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 		rerere_clear(the_repository, &merge_rr);
+	}
 		/* fallthrough */
-	case CONTINUE:
-		ret = sequencer_continue(the_repository, &opts);
+	case CONTINUE: {
+		struct replay_opts replay_opts = get_replay_opts(&opts);
+
+		ret = sequencer_continue(the_repository, &replay_opts);
 		break;
 	}
 	case EDIT_TODO:
@@ -446,45 +511,6 @@ static int use_builtin_rebase(void)
 	return ret;
 }
 
-struct rebase_options {
-	enum rebase_type type;
-	const char *state_dir;
-	struct commit *upstream;
-	const char *upstream_name;
-	const char *upstream_arg;
-	char *head_name;
-	struct object_id orig_head;
-	struct commit *onto;
-	const char *onto_name;
-	const char *revisions;
-	const char *switch_to;
-	int root;
-	struct object_id *squash_onto;
-	struct commit *restrict_revision;
-	int dont_finish_rebase;
-	enum {
-		REBASE_NO_QUIET = 1<<0,
-		REBASE_VERBOSE = 1<<1,
-		REBASE_DIFFSTAT = 1<<2,
-		REBASE_FORCE = 1<<3,
-		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
-	} flags;
-	struct argv_array git_am_opts;
-	const char *action;
-	int signoff;
-	int allow_rerere_autoupdate;
-	int keep_empty;
-	int autosquash;
-	char *gpg_sign_opt;
-	int autostash;
-	char *cmd;
-	int allow_empty_message;
-	int rebase_merges, rebase_cousins;
-	char *strategy, *strategy_opts;
-	struct strbuf git_format_patch_opt;
-	int reschedule_failed_exec;
-};
-
 static int is_interactive(struct rebase_options *opts)
 {
 	return opts->type == REBASE_INTERACTIVE ||
@@ -1380,13 +1406,7 @@ static int check_exec_cmd(const char *cmd)
 
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
-	struct rebase_options options = {
-		.type = REBASE_UNSPECIFIED,
-		.flags = REBASE_NO_QUIET,
-		.git_am_opts = ARGV_ARRAY_INIT,
-		.allow_empty_message = 1,
-		.git_format_patch_opt = STRBUF_INIT,
-	};
+	struct rebase_options options = REBASE_OPTIONS_INIT;
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
 	int ok_to_skip_pre_rebase = 0;
@@ -1540,6 +1560,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
+	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
 
 	strbuf_reset(&buf);
-- 
2.21.0

