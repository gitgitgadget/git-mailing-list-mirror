Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD431F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeJ1GMZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33922 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbeJ1GMY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so4671236wrt.1
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQjWbAa1AqPLBhKMxBHgI1DXTTvMfufvppHI61as7+Y=;
        b=smkxkcqup5yd+sEF9+joMXvCpO9ZzViAbYaBdRNHaAeu3R9XygGYEx5Yuw12uXHrPx
         P3na8fP/1LPtmn6ieqtU9w9JNyNlMaV/UO8M6MiUKwdWXdBgdUVP/IzJI6VoAURXEinf
         bDWTZS3Ywc8pjwVLxfDPl1R1Ibv80VsgloqbswbfJLp0GjnyjvDcG6Z4IEjKWok//uYP
         /RqGgz5tcUiiqKQ8sZwfA5MGQH5EjioySxS03RsOMZc06/yWTp4lwcRScTTfcRETpDVH
         1w6ISmAeWVeioGVyDk24kiOqGGTbBsixZBf7gZOLogPRW6u1bc8JKfhvAceP5hE3+Crp
         SxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQjWbAa1AqPLBhKMxBHgI1DXTTvMfufvppHI61as7+Y=;
        b=C3eUG1rVNEjGAKD1HJWjaKXe9muws/I5cwxT5vyPxTpG0jcCTp2BL0nEmAekqe5y0x
         ygchz1DdIiYYVAoypZwQOlpSDBnxzAnKruxgnY99eDG9BnmkM/zDK8Mce5XId/tBLhlB
         T/k7BPjv0dyMQiS1/qzZE6rtwMZKiDewpZqI54Wr9svP7UZGSgXZ8MPZUUqYSpBJmEmv
         ldKYi/Sfz98rjm1ezNHhNU/MqGVt4KUkP+p4CRKNJbTgmkP01xtuthw8OvanS0mtJKsB
         cpNTAmLItjy1+q/SoOcQhQtfrXGNej0pxMOtYN0IRPx8HuYILGEk+f7v7noleP0qEmwI
         NbSg==
X-Gm-Message-State: AGRZ1gI2um/wX4FrQXRjvYcdjMLPHPnEA20gql/9fNUjzdLUHLM7Wgm8
        Y4xU1Oncbu3b7XbDESrZ1nZqByay
X-Google-Smtp-Source: AJdET5cC3Fmir0olxnPR5VLVhpfE6ZdE5XloxLWum6F+chmLalhvcdjMUYsG1OyyddSLeWnMmM63Jw==
X-Received: by 2002:adf:f00a:: with SMTP id j10-v6mr599722wro.170.1540675803884;
        Sat, 27 Oct 2018 14:30:03 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:30:03 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 09/16] sequencer: change complete_action() to use the refactored functions
Date:   Sat, 27 Oct 2018 23:29:23 +0200
Message-Id: <20181027212930.9303-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
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

The parsing of the list has to be done by the caller.  If the buffer of
the todo list provided by the caller is empty, a `noop' command is
directly added to the todo list, without touching to the buffer.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c | 16 ++-----
 sequencer.c                   | 82 ++++++++++++++++-------------------
 sequencer.h                   |  2 +-
 3 files changed, 42 insertions(+), 58 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index eef1ff2e83..c07330bdff 100644
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
@@ -109,15 +100,16 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	ret = sequencer_make_script(&todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
 				    flags);
-	fputs(todo_list.buf.buf, todo_list_file);
-	fclose(todo_list_file);
 
 	if (ret)
 		error(_("could not generate todo list"));
 	else {
 		discard_cache();
+		if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list))
+			BUG("unusable todo list");
+
 		ret = complete_action(opts, flags, shortrevisions, onto_name, onto,
-				      head_hash, cmd, autosquash);
+				      head_hash, cmd, autosquash, &todo_list);
 	}
 
 	free(revisions);
diff --git a/sequencer.c b/sequencer.c
index 94167588a2..1f7579328b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4501,93 +4501,85 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
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
+	if (buf->len == 0) {
+		struct todo_item *item = append_new_todo(todo_list);
+		item->command = TODO_NOOP;
+		item->commit = NULL;
+		item->arg = NULL;
+		item->arg_len = item->flags = item->offset_in_buf = 0;
+	}
 
-	if (autosquash && rearrange_squash_in_todo_file())
+	if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
 	if (cmd && *cmd)
-		sequencer_add_exec_commands(cmd);
-
-	if (strbuf_read_file(buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(buf->buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
+		todo_list_add_exec_commands(todo_list, cmd);
 
-	if (count_commands(&todo_list) == 0) {
+	command_count = count_commands(todo_list);
+	if (command_count == 0) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
-		todo_list_release(&todo_list);
 
 		return error(_("nothing to do"));
 	}
 
-	strbuf_addch(buf, '\n');
-	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
-				      "Rebase %s onto %s (%d commands)",
-				      count_commands(&todo_list)),
-			      shortrevisions, shortonto, count_commands(&todo_list));
-	append_todo_help(0, flags & TODO_LIST_KEEP_EMPTY, buf);
-
-	if (write_message(buf->buf, buf->len, todo_file, 0)) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	if (todo_list_write_to_file(todo_list, todo_file,
+				    shortrevisions, shortonto, command_count,
+				    1, -1, flags | TODO_LIST_SHORTEN_IDS))
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
+	if (todo_list_parse_insn_buffer(new_todo.buf.buf, &new_todo) ||
+	    todo_list_check(todo_list, &new_todo)) {
+		fprintf(stderr, _(edit_todo_list_advice));
 		checkout_onto(opts, onto_name, onto, orig_head);
+		todo_list_release(&new_todo);
+
 		return -1;
 	}
 
-	if (transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS)))
-		return error(_("could not transform the todo list"));
+	if (todo_list_write_to_file(&new_todo, todo_file, NULL, NULL, 0, 0, -1,
+				    flags & ~(TODO_LIST_SHORTEN_IDS))) {
+		todo_list_release(&new_todo);
+		return error_errno(_("could not write '%s'"), todo_file);
+	}
+
+	todo_list_release(&new_todo);
 
 	if (opts->allow_ff && skip_unnecessary_picks(&oid))
 		return error(_("could not skip unnecessary pick commands"));
diff --git a/sequencer.h b/sequencer.h
index 5af96723e6..4a051e5dc9 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -138,7 +138,7 @@ int check_todo_list_from_file(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
-		    unsigned autosquash);
+		    unsigned autosquash, struct todo_list *todo_list);
 int rearrange_squash_in_todo_file(void);
 
 extern const char sign_off_header[];
-- 
2.19.1

