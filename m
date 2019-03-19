Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73DD720248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfCSTEJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:04:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41063 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfCSTEI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:04:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1so51051wrs.8
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=jIl4H+lKKrQtHhb2PKniBl2p8pklzxxLHEYedkNC4PY=;
        b=jIubcVt6uStG2G6rNILWZNRvkhDUUM/Yv+qf92Df2PYGmZ9w6WpgwuNqqpv057iDxX
         SrXU2MjbBMZFXEhcxinNXYiOFbCRsTC5nTlwk851FFai8KFFcEwEmAN1e4gP1+MUJyoj
         N/ZxKyPaJmGwLNpny4J/oYWLQa+O6GiY6xV8a5I9jUjKxxyl4sdpSRj2ECjLVvfbM0iq
         qDu3Lo1SKGyjzdRj5Z40LGiSPDwI548lCuxHd2Zn5siNZb1/3F9STY7GqDwAGRzzJMHa
         UBa92sfRFdMLnDJPiNXIo5blEDGmRJgv/ynqjpTU+QdZD2WB4T/qMDJAFpWu4ih6ZPUt
         ZexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=jIl4H+lKKrQtHhb2PKniBl2p8pklzxxLHEYedkNC4PY=;
        b=I5gteFiLW1aqWeliGPb4wM2elvV2TywkLBmqN6SLemOfAEBXJ3U0L2nIvC03aEzMeE
         3r3Q115sW+v2Rn9sVDjLBDEanNvC0VcRKDGvLYTjK/l6va3lMhQZvP6Aa/arHr+h2asV
         6smG+QR5EgVQeB35Lr1Tci2rvvE1513cilfIoTTX7nUD6lxYmKrahY/ypkc50CltUf1a
         Br4zM3OKsRBUFM6MmRXtwt59wwXCTwaF3ISQvtk5k30PpvRu08yR9JbDwRChupst9wwi
         t5z9WCK2YvW+Xwr3ZJj8mEj2A+UIRZdOeHolYXJcoEsXWtyPlNuBX/nFfB+OUQMG0jxz
         QZVw==
X-Gm-Message-State: APjAAAW7n5n5QorhsgeqUFoFifuqFqu+WwfG7hSek3WlRClD4WBIMC5y
        UYBGgkGFW1KF8QSdZMqc+NzSzSBF5HE=
X-Google-Smtp-Source: APXvYqwuSpqezKzUbZLDDTN2HHAFIISDt28xtOeXItbKCtXVOfy0Yzw7l2v1di4YkfZze319G1FW6Q==
X-Received: by 2002:a5d:468d:: with SMTP id u13mr18173268wrq.132.1553022245647;
        Tue, 19 Mar 2019 12:04:05 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:04:05 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 09/11] rebase -i: use struct rebase_options in do_interactive_rebase()
Date:   Tue, 19 Mar 2019 19:03:15 +0000
Message-Id: <20190319190317.6632-10-phillip.wood123@gmail.com>
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

All the parameters that are passed to do_interactive_rebase() apart from
`flags` are already in `struct rebase_options` so there is no need to
pass them separately.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 69 +++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 33a2495032..21ccb6495e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -113,6 +113,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
+	if (opts->strategy_opts)
+		parse_strategy_opts(&replay, opts->strategy_opts);
 
 	return replay;
 }
@@ -262,44 +264,50 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 	return write_basic_state(opts, head_name, onto, orig_head);
 }
 
-static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
-				 const char *switch_to, struct commit *upstream,
-				 struct commit *onto, const char *onto_name,
-				 struct object_id *squash_onto, const char *head_name,
-				 struct commit *restrict_revision, char *raw_strategies,
-				 struct string_list *commands, unsigned autosquash)
+static void split_exec_commands(const char *cmd, struct string_list *commands)
+{
+	if (cmd && *cmd) {
+		string_list_split(commands, cmd, '\n', -1);
+
+		/* rebase.c adds a new line to cmd after every command,
+		 * so here the last command is always empty */
+		string_list_remove_empty_items(commands, 0);
+	}
+}
+
+static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
 	int ret;
 	const char *head_hash = NULL;
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct argv_array make_script_args = ARGV_ARRAY_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
+	struct replay_opts replay = get_replay_opts(opts);
+	struct string_list commands = STRING_LIST_INIT_DUP;
 
-	if (prepare_branch_to_be_rebased(the_repository, opts, switch_to))
+	if (prepare_branch_to_be_rebased(the_repository, &replay,
+					 opts->switch_to))
 		return -1;
 
-	if (get_revision_ranges(upstream, onto, &head_hash,
+	if (get_revision_ranges(opts->upstream, opts->onto, &head_hash,
 				&revisions, &shortrevisions))
 		return -1;
 
-	if (raw_strategies)
-		parse_strategy_opts(opts, raw_strategies);
-
-	if (init_basic_state(opts, head_name, onto, head_hash)) {
+	if (init_basic_state(&replay, opts->head_name, opts->onto, head_hash)) {
 		free(revisions);
 		free(shortrevisions);
 
 		return -1;
 	}
 
-	if (!upstream && squash_onto)
+	if (!opts->upstream && opts->squash_onto)
 		write_file(path_squash_onto(), "%s\n",
-			   oid_to_hex(squash_onto));
+			   oid_to_hex(opts->squash_onto));
 
 	argv_array_pushl(&make_script_args, "", revisions, NULL);
-	if (restrict_revision)
+	if (opts->restrict_revision)
 		argv_array_push(&make_script_args,
-				oid_to_hex(&restrict_revision->object.oid));
+				oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
@@ -313,10 +321,13 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 						&todo_list))
 			BUG("unusable todo list");
 
-		ret = complete_action(the_repository, opts, flags, shortrevisions, onto_name,
-				      onto, head_hash, commands, autosquash, &todo_list);
+		split_exec_commands(opts->cmd, &commands);
+		ret = complete_action(the_repository, &replay, flags,
+			shortrevisions, opts->onto_name, opts->onto, head_hash,
+			&commands, opts->autosquash, &todo_list);
 	}
 
+	string_list_clear(&commands, 0);
 	free(revisions);
 	free(shortrevisions);
 	todo_list_release(&todo_list);
@@ -336,7 +347,6 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	unsigned flags = 0;
 	int abbreviate_commands = 0, ret = 0;
 	struct object_id squash_onto = null_oid;
-	struct string_list commands = STRING_LIST_INIT_DUP;
 	enum {
 		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
 		SHORTEN_OIDS, EXPAND_OIDS, CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC
@@ -424,23 +434,12 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
-	if (opts.cmd && *opts.cmd) {
-		string_list_split(&commands, opts.cmd, '\n', -1);
-
-		/* rebase.c adds a new line to cmd after every command,
-		 * so here the last command is always empty */
-		string_list_remove_empty_items(&commands, 0);
-	}
-
 	switch (command) {
 	case NONE: {
-		struct replay_opts replay_opts = get_replay_opts(&opts);
 		if (!opts.onto && !opts.upstream)
 			die(_("a base commit must be provided with --upstream or --onto"));
 
-		ret = do_interactive_rebase(&replay_opts, flags, opts.switch_to, opts.upstream, opts.onto,
-					    opts.onto_name, opts.squash_onto, opts.head_name, opts.restrict_revision,
-					    opts.strategy_opts, &commands, opts.autosquash);
+		ret = do_interactive_rebase(&opts, flags);
 		break;
 	}
 	case SKIP: {
@@ -477,14 +476,18 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	case REARRANGE_SQUASH:
 		ret = rearrange_squash_in_todo_file();
 		break;
-	case ADD_EXEC:
+	case ADD_EXEC: {
+		struct string_list commands = STRING_LIST_INIT_DUP;
+
+		split_exec_commands(opts.cmd, &commands);
 		ret = add_exec_commands(&commands);
+		string_list_clear(&commands, 0);
 		break;
+	}
 	default:
 		BUG("invalid command '%d'", command);
 	}
 
-	string_list_clear(&commands, 0);
 	return !!ret;
 }
 
-- 
2.21.0

