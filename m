Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C07B1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBJN1X (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40011 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfBJN1V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so11785786wmc.5
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0NDArt2ZOnPddPKB0bqPTGH17eRLhjgKJKk5Pm4QjI=;
        b=ep4NS9A2pGtpr+nFIwe7MaSOyWhn+RO9Sty10qZYq/NN2muGpM+rs+UCPNI3McK1XZ
         3/M/NiNKhRd7wc4lZWkV2Yo80NAdyeTdj7JgoGIXrqdOMRDzR9+coE+oZMs//S3DUkQn
         kMSzGzJXDhOMVarbJSXt/CSEBGlMHzP+16uVkIip1mTpOe5rHQk1UFPUTua7X6F+vTJD
         QdS6Z6GH1L0Khs9sc732wBcAa2Sw4jL+Ts6W5mcyQy56aS4mMYcgY09rtVRsEu6fipl7
         MjwE2X9mbvJiNsPuNvHjp0VL3+CR+HxxL9xnmNyrfiIXGr3limcSruSJvh6yznNK+Ds8
         12OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0NDArt2ZOnPddPKB0bqPTGH17eRLhjgKJKk5Pm4QjI=;
        b=Soe0yDyKHvKlFPpaC1sT1PFnAIKh+iYLOP/0e2V8OXZCAxqKHQ5iUvzdwaFjiOrwuF
         Kfwbak95NPDnu3NJIoZ2OaFtMIPpCQ+3gwZ9XNuWPapNvtBJobGbqlJbdvEB+QahlZoN
         RCL08PAmGTvlVSjQhCQQLmeCKn9QPRsXBp4yRkChA0ywjHnx9ZXyye5K22wGDLsZOB7D
         J2GGSZb3B05+moVwdDwaY/7iCOjpvy+cm2iXqPkClRymvfRtqkHEfRCB/JHjS8ccQ88G
         qqXltjr5uPjpSC98oFHDrVFZESWRsFloSmjD1A9l8FvBPDr8b/uRxzr97L4Pk5clpfMx
         iQ0Q==
X-Gm-Message-State: AHQUAua69aftgnugEI8aej/mVS/qGx71URtwQ1HkaXe6fWY2R8nxJKBc
        95RourhKshHXtbHTcytuNJh9qNjr
X-Google-Smtp-Source: AHgI3IZt0sVDyJSty43MdbgFVpcu9anA9KTuJMHwmyhUyOarFXESx3wYHtgFM9/1W87cE1Rjyunmng==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr23125663wrw.211.1549805238201;
        Sun, 10 Feb 2019 05:27:18 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:17 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 10/16] sequencer: change complete_action() to use the refactored functions
Date:   Sun, 10 Feb 2019 14:26:42 +0100
Message-Id: <20190210132648.12821-11-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210132648.12821-1-alban.gruin@gmail.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
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
directly added to the todo list, without touching the buffer.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c | 20 +++------
 sequencer.c                   | 79 +++++++++++++++--------------------
 sequencer.h                   |  2 +-
 3 files changed, 41 insertions(+), 60 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 506154b5e2..4f2949922f 100644
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
@@ -109,16 +100,17 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
 				    flags);
-	fputs(todo_list.buf.buf, todo_list_file);
-	fclose(todo_list_file);
 
 	if (ret)
 		error(_("could not generate todo list"));
 	else {
 		discard_cache();
-		ret = complete_action(the_repository, opts, flags,
-				      shortrevisions, onto_name, onto,
-				      head_hash, commands, autosquash);
+		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+						&todo_list))
+			BUG("unusable todo list");
+
+		ret = complete_action(the_repository, opts, flags, shortrevisions, onto_name,
+				      onto, head_hash, commands, autosquash, &todo_list);
 	}
 
 	free(revisions);
diff --git a/sequencer.c b/sequencer.c
index dbef2547f7..eb8a622af0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4810,93 +4810,82 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
 	return 0;
 }
 
+static int todo_list_rearrange_squash(struct todo_list *todo_list);
+
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, struct string_list *commands,
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
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
 
-	if (!lstat(todo_file, &st) && st.st_size == 0 &&
-	    write_message("noop\n", 5, todo_file, 0))
-		return -1;
+	if (buf->len == 0) {
+		struct todo_item *item = append_new_todo(todo_list);
+		item->command = TODO_NOOP;
+		item->commit = NULL;
+		item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
+	}
 
-	if (autosquash && rearrange_squash_in_todo_file(r))
+	if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
 	if (commands->nr)
-		sequencer_add_exec_commands(r, commands);
+		todo_list_add_exec_commands(todo_list, commands);
 
-	if (strbuf_read_file(buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(r, buf->buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	if (count_commands(&todo_list) == 0) {
+	if (count_commands(todo_list) == 0) {
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
+	if (todo_list_write_to_file(r, todo_list, todo_file,
+				    shortrevisions, shortonto, -1,
+				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
+		return error_errno(_("could not write '%s'"), todo_file);
 
 	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
 		return error(_("could not copy '%s' to '%s'."), todo_file,
 			     rebase_path_todo_backup());
 
-	if (transform_todo_file(r, flags | TODO_LIST_SHORTEN_IDS))
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
-	if (check_todo_list_from_file(r)) {
+	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) ||
+	    todo_list_check(todo_list, &new_todo)) {
+		fprintf(stderr, _(edit_todo_list_advice));
 		checkout_onto(opts, onto_name, onto, orig_head);
+		todo_list_release(&new_todo);
+
 		return -1;
 	}
 
-	if (transform_todo_file(r, flags & ~(TODO_LIST_SHORTEN_IDS)))
-		return error(_("could not transform the todo list"));
+	if (todo_list_write_to_file(r, &new_todo, todo_file, NULL, NULL, -1,
+				    flags & ~(TODO_LIST_SHORTEN_IDS))) {
+		todo_list_release(&new_todo);
+		return error_errno(_("could not write '%s'"), todo_file);
+	}
+
+	todo_list_release(&new_todo);
 
 	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
 		return error(_("could not skip unnecessary pick commands"));
diff --git a/sequencer.h b/sequencer.h
index e25f5151d3..7029b39cd6 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -152,7 +152,7 @@ int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, struct string_list *commands,
-		    unsigned autosquash);
+		    unsigned autosquash, struct todo_list *todo_list);
 int rearrange_squash_in_todo_file(struct repository *r);
 
 extern const char sign_off_header[];
-- 
2.20.1

