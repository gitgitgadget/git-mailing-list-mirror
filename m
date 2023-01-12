Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0304EC54EBE
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 17:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjALRV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjALRVU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 12:21:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD1513D1B
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:51:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t5so14279130wrq.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgpj+QKvwzYqSXRoszMnytACqtwxS1VF2bK1HRxQdWc=;
        b=gV02UifPmn51lih3+7lU9b5CdHca9OG/Hk81lzLajEf3ZtQarHFd3y6gf9YSHbGwdX
         8e9ofUQLpocv8KxN8FsHFDPGL5zD5vcf2ICnnvzELmfvtmxxltPG+5O0vRILGFJXsSHk
         mbmC6DKzImvk4EebTW6Nowf1+kioH2dgPmTjvUxZxrBBKwt/hEe073mRVCyukWNkkWkO
         J0d2hARGQTsZSiR9hKj6wftMtGWPVNPw/746Q0JdnSkqPVZjdYkZxi9/nnb4MVDUYNEj
         nCXE+NCGD0QDFq1HVs7E+uYA9aM0qHP9MoptpMMCTKX2uaf+LG6YxfYlXPuUBPQHxIQ7
         kC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rgpj+QKvwzYqSXRoszMnytACqtwxS1VF2bK1HRxQdWc=;
        b=eFEosazr34uvfdTWIVQ9iSbJUG6vv0IGW9Zjs3K44sHESIv9El0VprTjAeBOJRUapu
         0ElbGtUpkRww9hf6Qqhw0agOFyPVfmRNIQWBfF3hseiMFtvlBL9UreVVLLkzDztXqbrL
         aX34zHYC+ShpSjXBfcTsg0jyC/3f8VNJxrkdP+ril5pLddEdPFVdKsWyUXVhH2AZxao0
         ffLImsygTzhiBGXe/lkt5lkz/+xJRIE7uZVytDEQMcTcf0os4G9f3uj6eWFK3HeL7OsI
         +nGXKW50mtq9XSsw/LbOqVFlVLjM0q5iiSkUdwWgjox5SJ8UuoxDAYodIHgkauD0xQlX
         5IKA==
X-Gm-Message-State: AFqh2kqM/clwzSm1+q5e2ai4IATr0V3pAAkozczRHUvBugJoqdY/MeO/
        q8XK/VPHIkNDNDAuI9T3rjbv0/JFbJM=
X-Google-Smtp-Source: AMrXdXs0hjlTEQvgKjZ8+sQkKyH5B+cWnPEM6IJiSNg/UP44UGFaswYvhvsMyyHk2O9a9tuVisABYw==
X-Received: by 2002:adf:e184:0:b0:2ba:4ee8:d708 with SMTP id az4-20020adfe184000000b002ba4ee8d708mr18892580wrb.32.1673542202564;
        Thu, 12 Jan 2023 08:50:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020adff30a000000b0024228b0b932sm20314855wro.27.2023.01.12.08.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 08:50:02 -0800 (PST)
Message-Id: <pull.1461.git.1673542201452.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Jan 2023 16:50:01 +0000
Subject: [PATCH] rebase: cleanup "--exec" option handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When handling "--exec" rebase collects the commands into a struct
string_list, then prepends "exec " to each command creating a multi line
string and finally splits that string back into a list of commands. This
is an artifact of the scripted rebase and the need to support "rebase
--preserve-merges". Now that "--preserve-merges" no-longer exists we can
cleanup the way the argument is handled. There is no need to add the
"exec " prefix to the commands as that is added by todo_list_to_strbuf().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase: cleanup "--exec" option handling
    
    A small cleanup following the removal of "--preserve-merges"

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1461%2Fphillipwood%2Frebase-cleanup-exec-handling-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1461/phillipwood/rebase-cleanup-exec-handling-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1461

 builtin/rebase.c | 45 +++++++++++----------------------------------
 sequencer.c      |  4 ++--
 2 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1481c5b6a5b..a26cc0cfdb5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -113,7 +113,7 @@ struct rebase_options {
 	int autostash;
 	int committer_date_is_author_date;
 	int ignore_date;
-	char *cmd;
+	struct string_list exec;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
 	char *strategy, *strategy_opts;
@@ -131,6 +131,7 @@ struct rebase_options {
 		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = STRVEC_INIT,		\
+		.exec = STRING_LIST_INIT_NODUP,		\
 		.git_format_patch_opt = STRBUF_INIT,	\
 		.fork_point = -1,			\
 	}
@@ -243,17 +244,6 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 	return write_basic_state(opts, head_name, onto, orig_head);
 }
 
-static void split_exec_commands(const char *cmd, struct string_list *commands)
-{
-	if (cmd && *cmd) {
-		string_list_split(commands, cmd, '\n', -1);
-
-		/* rebase.c adds a new line to cmd after every command,
-		 * so here the last command is always empty */
-		string_list_remove_empty_items(commands, 0);
-	}
-}
-
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
 	int ret;
@@ -261,7 +251,6 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	struct strvec make_script_args = STRVEC_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct replay_opts replay = get_replay_opts(opts);
-	struct string_list commands = STRING_LIST_INIT_DUP;
 
 	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head->object.oid,
 				&revisions, &shortrevisions))
@@ -297,14 +286,12 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 						&todo_list))
 			BUG("unusable todo list");
 
-		split_exec_commands(opts->cmd, &commands);
 		ret = complete_action(the_repository, &replay, flags,
 			shortrevisions, opts->onto_name, opts->onto,
-			&opts->orig_head->object.oid, &commands,
+			&opts->orig_head->object.oid, &opts->exec,
 			opts->autosquash, opts->update_refs, &todo_list);
 	}
 
-	string_list_clear(&commands, 0);
 	free(revisions);
 	free(shortrevisions);
 	todo_list_release(&todo_list);
@@ -1032,7 +1019,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct object_id branch_base;
 	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
-	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
@@ -1127,7 +1113,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			N_("GPG-sign commits"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_AUTOSTASH(&options.autostash),
-		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
+		OPT_STRING_LIST('x', "exec", &options.exec, N_("exec"),
 				N_("add exec lines after each commit of the "
 				   "editable list")),
 		OPT_BOOL_F(0, "allow-empty-message",
@@ -1250,7 +1236,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (trace2_is_enabled()) {
 		if (is_merge(&options))
 			trace2_cmd_mode("interactive");
-		else if (exec.nr)
+		else if (options.exec.nr)
 			trace2_cmd_mode("interactive-exec");
 		else
 			trace2_cmd_mode(action_names[options.action]);
@@ -1378,7 +1364,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
 	    (options.action != ACTION_NONE) ||
-	    (exec.nr > 0) ||
+	    (options.exec.nr > 0) ||
 	    options.autosquash) {
 		allow_preemptive_ff = 0;
 	}
@@ -1402,8 +1388,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	for (i = 0; i < exec.nr; i++)
-		if (check_exec_cmd(exec.items[i].string))
+	for (i = 0; i < options.exec.nr; i++)
+		if (check_exec_cmd(options.exec.items[i].string))
 			exit(1);
 
 	if (!(options.flags & REBASE_NO_QUIET))
@@ -1422,17 +1408,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (gpg_sign)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
 
-	if (exec.nr) {
-		int i;
-
+	if (options.exec.nr)
 		imply_merge(&options, "--exec");
 
-		strbuf_reset(&buf);
-		for (i = 0; i < exec.nr; i++)
-			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
-		options.cmd = xstrdup(buf.buf);
-	}
-
 	if (rebase_merges) {
 		if (!*rebase_merges)
 			; /* default mode; do nothing */
@@ -1543,7 +1521,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.empty == EMPTY_UNSPECIFIED) {
 		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
 			options.empty = EMPTY_ASK;
-		else if (exec.nr > 0)
+		else if (options.exec.nr > 0)
 			options.empty = EMPTY_KEEP;
 		else
 			options.empty = EMPTY_DROP;
@@ -1831,11 +1809,10 @@ cleanup:
 	free(options.head_name);
 	strvec_clear(&options.git_am_opts);
 	free(options.gpg_sign_opt);
-	free(options.cmd);
+	string_list_clear(&options.exec, 0);
 	free(options.strategy);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
-	string_list_clear(&exec, 0);
 	string_list_clear(&strategy_options, 0);
 	return !!ret;
 }
diff --git a/sequencer.c b/sequencer.c
index bcb662e23be..3e4a1972897 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5745,8 +5745,8 @@ static void todo_list_add_exec_commands(struct todo_list *todo_list,
 
 		base_items[i].command = TODO_EXEC;
 		base_items[i].offset_in_buf = base_offset;
-		base_items[i].arg_offset = base_offset + strlen("exec ");
-		base_items[i].arg_len = command_len - strlen("exec ");
+		base_items[i].arg_offset = base_offset;
+		base_items[i].arg_len = command_len;
 
 		base_offset += command_len + 1;
 	}

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
