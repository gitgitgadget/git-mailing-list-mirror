Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60AEB1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeJHDIn (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33434 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbeJHDIl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so7344042wmd.0
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=su4j9BpU35uDX5M9u2HTZI+yAps3s1ON2fSVjY7XbmY=;
        b=CHQUDh8wr77Dt3S3jkgpNw32qtWQptrBv5FPWS47JvG+81Y0rANsVnT+26G9GRqSww
         wrfG6iwNS8lc5VsJRJ0qfeRZL+1z96FUbW2Bp3g7TwCpSYppDo5FH6e5NF4qmeGLNfTo
         tMobSzVLn0x8/5gb6xOhC0eh9t/QCMPrU9w+f0CV6k2nPVALOs/E+fLS2aSsDdo4GSzR
         AEzBTQYILMmT3El9B65U+y2iw82F1E3t9FD3yGKscpDqsHKso5DhjJflHZQ3RtNhpqAk
         Ry9jUx52IhiqnzQzeSBagOPYgY9AoY/a1xgxJxFIL6uEHxFhUjHPxCVejoV0XRf8Qvac
         c8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=su4j9BpU35uDX5M9u2HTZI+yAps3s1ON2fSVjY7XbmY=;
        b=LK2quZmVWvgrDJr5JtijPx0RwwvlA7Yg32Z/6eCUYgLQ25FaFtt044RpYiX1g5NeFv
         kcikf61rDJhHHiGjQ4tbQILyNnBmk5Ew+/oybPfpb4cXex6yLjaXcAbL6o+sHBg5CBHJ
         TJCUj0rQxJ/+MkbZwGhXDx5QoJuZAIr1dJ1SKeUGIMYYxpVJ/D4aYMk/e42artn5+Cij
         oCGDRbA9dDVLVMxNbupQ1mJiSndMeYZM2/CZ3UZWIiwjtGXRptXpnmwJYZ0UBKrHYoJ9
         S7agAc+2m7W8kfNWJaqDNc+iPwaq3bixEQRNVZzWuw5aUHCcGw7HiN1opLhtneXJ5t8p
         8kWg==
X-Gm-Message-State: ABuFfogrb51OG5e3EXudhypWzXYhaQd6jhT4UT4N/jgZqCs5tye1vgbS
        l68Desj+/m7t2F04LPHwatDLFZKc
X-Google-Smtp-Source: ACcGV60/TAIpRmrkNt2CNCK7QV7xFWaEqJ1boCFVfDkglWN4wzwWUPcOaCq0dEM4szoiihUEnXqvrA==
X-Received: by 2002:a1c:cc8:: with SMTP id 191-v6mr12983499wmm.55.1538942416800;
        Sun, 07 Oct 2018 13:00:16 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:16 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 08/15] sequencer: change complete_action() to use the refactored functions
Date:   Sun,  7 Oct 2018 21:54:11 +0200
Message-Id: <20181007195418.25752-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

complete_action() used functions that read the todo-list file, made some
changes to it, and wrote it back to the disk.

The previous commits were dedicated to separate the part that deals with
the file from the actual logic of these functions.  Now that this is
done, we can call directly the "logic" functions to avoid useless file
access.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c | 13 +-----
 sequencer.c                   | 76 +++++++++++++++++------------------
 sequencer.h                   |  2 +-
 3 files changed, 38 insertions(+), 53 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index eef1ff2e83..0700339f90 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -71,7 +71,6 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	const char *head_hash = NULL;
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct argv_array make_script_args = ARGV_ARRAY_INIT;
-	FILE *todo_list_file;
 	struct todo_list todo_list = TODO_LIST_INIT;
 
 	if (prepare_branch_to_be_rebased(opts, switch_to))
@@ -94,14 +93,6 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	if (!upstream && squash_onto)
 		write_file(path_squash_onto(), "%s\n", squash_onto);
 
-	todo_list_file = fopen(rebase_path_todo(), "w");
-	if (!todo_list_file) {
-		free(revisions);
-		free(shortrevisions);
-
-		return error_errno(_("could not open %s"), rebase_path_todo());
-	}
-
 	argv_array_pushl(&make_script_args, "", revisions, NULL);
 	if (restrict_revision)
 		argv_array_push(&make_script_args, restrict_revision);
@@ -109,15 +100,13 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	ret = sequencer_make_script(&todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
 				    flags);
-	fputs(todo_list.buf.buf, todo_list_file);
-	fclose(todo_list_file);
 
 	if (ret)
 		error(_("could not generate todo list"));
 	else {
 		discard_cache();
 		ret = complete_action(opts, flags, shortrevisions, onto_name, onto,
-				      head_hash, cmd, autosquash);
+				      head_hash, cmd, autosquash, &todo_list);
 	}
 
 	free(revisions);
diff --git a/sequencer.c b/sequencer.c
index dfb8d1c974..b37935e5ab 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4624,93 +4624,89 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
 	return 0;
 }
 
+static int todo_list_rearrange_squash(struct todo_list *todo_list);
+
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
-		    unsigned autosquash)
+		    unsigned autosquash, struct todo_list *todo_list)
 {
 	const char *shortonto, *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	struct strbuf *buf = &(todo_list.buf);
+	struct todo_list new_todo = TODO_LIST_INIT;
+	struct strbuf *buf = &todo_list->buf;
 	struct object_id oid;
-	struct stat st;
+	int command_count;
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
 
-	if (!lstat(todo_file, &st) && st.st_size == 0 &&
-	    write_message("noop\n", 5, todo_file, 0))
-		return -1;
+	if (buf->len == 0)
+		strbuf_add(buf, "noop\n", 5);
+
+	if (todo_list_parse_insn_buffer(buf->buf, todo_list))
+		BUG("unusable todo list");
 
-	if (autosquash && rearrange_squash_in_todo_file())
+	if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
 	if (cmd && *cmd)
-		sequencer_add_exec_commands(cmd);
+		todo_list_add_exec_commands(todo_list, cmd);
 
-	if (strbuf_read_file(buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(buf->buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	if (count_commands(&todo_list) == 0) {
+	command_count = count_commands(todo_list);
+	if (command_count == 0) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
-		todo_list_release(&todo_list);
 
 		return error(_("nothing to do"));
 	}
 
+	todo_list_transform(todo_list, flags | TODO_LIST_SHORTEN_IDS);
+
 	strbuf_addch(buf, '\n');
 	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
 				      "Rebase %s onto %s (%d commands)",
-				      count_commands(&todo_list)),
-			      shortrevisions, shortonto, count_commands(&todo_list));
+				      command_count),
+			      shortrevisions, shortonto, command_count);
 	append_todo_help(0, flags & TODO_LIST_KEEP_EMPTY, buf);
 
-	if (write_message(buf->buf, buf->len, todo_file, 0)) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	if (write_message(buf->buf, buf->len, todo_file, 0))
+		return error_errno(_("could not write '%s'"), todo_file);
 
 	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
 		return error(_("could not copy '%s' to '%s'."), todo_file,
 			     rebase_path_todo_backup());
 
-	if (transform_todo_file(flags | TODO_LIST_SHORTEN_IDS))
-		return error(_("could not transform the todo list"));
-
-	strbuf_reset(buf);
-
-	if (launch_sequence_editor(todo_file, buf, NULL)) {
+	if (launch_sequence_editor(todo_file, &new_todo.buf, NULL)) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
-		todo_list_release(&todo_list);
 
 		return -1;
 	}
 
-	strbuf_stripspace(buf, 1);
-	if (buf->len == 0) {
+	strbuf_stripspace(&new_todo.buf, 1);
+	if (new_todo.buf.len == 0) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
-		todo_list_release(&todo_list);
+		todo_list_release(&new_todo);
 
 		return error(_("nothing to do"));
 	}
 
-	todo_list_release(&todo_list);
-
-	if (check_todo_list_from_file()) {
+	if (todo_list_check(todo_list, &new_todo)) {
 		checkout_onto(opts, onto_name, onto, orig_head);
+		todo_list_release(&new_todo);
+
 		return -1;
 	}
 
-	if (transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS)))
-		return error(_("could not transform the todo list"));
+	todo_list_transform(&new_todo, flags & ~(TODO_LIST_SHORTEN_IDS));
+
+	if (rewrite_file(todo_file, new_todo.buf.buf, new_todo.buf.len) < 0) {
+		todo_list_release(&new_todo);
+		return error_errno(_("could not write '%s'"), todo_file);
+	}
+
+	todo_list_release(&new_todo);
 
 	if (opts->allow_ff && skip_unnecessary_picks(&oid))
 		return error(_("could not skip unnecessary pick commands"));
diff --git a/sequencer.h b/sequencer.h
index 21d9ba09ab..5bd3b79282 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -141,7 +141,7 @@ int check_todo_list_from_file(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
-		    unsigned autosquash);
+		    unsigned autosquash, struct todo_list *todo_list);
 int rearrange_squash_in_todo_file(void);
 
 extern const char sign_off_header[];
-- 
2.19.1

