Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F202420C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbdLCWSL (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:18:11 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35251 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbdLCWSC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:18:02 -0500
Received: by mail-it0-f68.google.com with SMTP id f143so2282643itb.0
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 14:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PO3RWacuvt6yknIKWTuWjLzPJvejB7HAMDgn+aVciuA=;
        b=DVB3PJAhutlaKJCKjWsQS0JpDuP+gMuyLcVejVhdZqE+tTFGlOJVkG9pZs+bllvZ5R
         9YqgVAU8PXFmWWlORCWaos1FdqFleGHBjCjaFVi9QtHfVLkKwGOySGZ8TDeQESNJPy4E
         hKtNKdjJdHFGLitsi3AbdR7vapq1Z96D3ptCZxSkJceDX2fBaIy5sIye92GNkHd6k0Yu
         viFTXTSxKc39FIhUFCJY7T7pKRnKeywwWiTeH6zFLC+49H7gH76CnoiWg7RVSkssRmyA
         ImH+mqV3vWkYk52jGPFFoVAB5I44tvTjk7G2UF/4JsLIkzT46GGK9/10ipbfRyPENW0i
         bHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PO3RWacuvt6yknIKWTuWjLzPJvejB7HAMDgn+aVciuA=;
        b=PHQqaQy1TUmSTqvs9VGIx+ulJ78snxxhtYdFj3L9KLZvypfM6BmaNxQeRMSj8Vy1ZK
         Pb2jkIQTzYlQ3pHS46sFKzCQdcHygPLOHC7vVJz4qXDl0GK/NkOTYf6yD54mss2g+iVq
         LrvEvkY5ZjtBqX8yh+idu9JHLGirSKYe9oa4lJ6VSCdI5jxBF08BY6K42FXgMSCA65WK
         TH0e5oW/+lNGCcoTKKlicT5jHJSr2hBwoI1hb/l1BzRKW/TSXW8tLutdHcYgO8+Z6NQV
         5bqO4na9NQhfzPDo/h5og5M69Uske8pi4dXGJAZMxPx+9ouhiwsBTIEhRxk1rmYlNeU7
         j7HA==
X-Gm-Message-State: AKGB3mJZPEnQIvg0CL6KgEp6YVYCtBVFxS80L/dHbzMcG4PTnkEwIGmm
        COI+4PUASc+xmwPBz+yUYzBQMgVM
X-Google-Smtp-Source: AGs4zMbRRGUk1TWdFHheA/NeadGFmvLl4OoKeCy3513gVhNknH0iWaJBfKYxXvjQpS5sq36yCdjYOg==
X-Received: by 10.107.16.86 with SMTP id y83mr12529593ioi.107.1512339481243;
        Sun, 03 Dec 2017 14:18:01 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm5207054ioe.13.2017.12.03.14.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 14:18:00 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 4/9] rebase -i: refactor transform_todo_ids
Date:   Sun,  3 Dec 2017 17:17:16 -0500
Message-Id: <20171203221721.16462-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.g10402c1f5b5c
In-Reply-To: <20171203221721.16462-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The transform_todo_ids function is a little hard to read. Lets try
to make it easier by using more of the strbuf API. Also, since we'll
soon be adding command abbreviations, let's rename the function so
it's name reflects that change.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 builtin/rebase--helper.c |  4 +--
 sequencer.c              | 69 ++++++++++++++++++++----------------------------
 sequencer.h              |  2 +-
 3 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index f8519363a393..7c06a27de821 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -55,9 +55,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	if (command == MAKE_SCRIPT && argc > 1)
 		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
 	if (command == SHORTEN_SHA1S && argc == 1)
-		return !!transform_todo_ids(1);
+		return !!transform_todo_insn(1);
 	if (command == EXPAND_SHA1S && argc == 1)
-		return !!transform_todo_ids(0);
+		return !!transform_todo_insn(0);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
 	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
diff --git a/sequencer.c b/sequencer.c
index 5033b049d995..0ff3c90e44bf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2494,60 +2494,47 @@ int sequencer_make_script(int keep_empty, FILE *out,
 }
 
 
-int transform_todo_ids(int shorten_ids)
+int transform_todo_insn(int shorten_ids)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
-	int fd, res, i;
-	FILE *out;
+	struct strbuf buf = STRBUF_INIT;
+	struct todo_item *item;
+	int i;
 
-	strbuf_reset(&todo_list.buf);
-	fd = open(todo_file, O_RDONLY);
-	if (fd < 0)
-		return error_errno(_("could not open '%s'"), todo_file);
-	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
-		close(fd);
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
-	}
-	close(fd);
 
-	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
-	if (res) {
+	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
 
-	out = fopen(todo_file, "w");
-	if (!out) {
-		todo_list_release(&todo_list);
-		return error(_("unable to open '%s' for writing"), todo_file);
-	}
-	for (i = 0; i < todo_list.nr; i++) {
-		struct todo_item *item = todo_list.items + i;
-		int bol = item->offset_in_buf;
-		const char *p = todo_list.buf.buf + bol;
-		int eol = i + 1 < todo_list.nr ?
-			todo_list.items[i + 1].offset_in_buf :
-			todo_list.buf.len;
-
-		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
-			fwrite(p, eol - bol, 1, out);
-		else {
-			const char *id = shorten_ids ?
-				short_commit_name(item->commit) :
-				oid_to_hex(&item->commit->object.oid);
-			int len;
-
-			p += strspn(p, " \t"); /* left-trim command */
-			len = strcspn(p, " \t"); /* length of command */
-
-			fprintf(out, "%.*s %s %.*s\n",
-				len, p, id, item->arg_len, item->arg);
+	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {
+		/* if the item is not a command write it and continue */
+		if (item->command >= TODO_COMMENT) {
+			strbuf_addf(&buf, "%.*s\n", item->arg_len, item->arg);
+			continue;
+		}
+
+		/* add command to the buffer */
+		strbuf_addstr(&buf, command_to_string(item->command));
+
+		/* add commit id */
+		if (item->commit) {
+			const char *oid = shorten_ids ?
+					  short_commit_name(item->commit) :
+					  oid_to_hex(&item->commit->object.oid);
+
+			strbuf_addf(&buf, " %s", oid);
 		}
+		/* add all the rest */
+		strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);
 	}
-	fclose(out);
+
+	i = write_message(buf.buf, buf.len, todo_file, 0);
 	todo_list_release(&todo_list);
-	return 0;
+	return i;
 }
 
 enum check_level {
diff --git a/sequencer.h b/sequencer.h
index 6f3d3df82c0a..4e444e3bf1c4 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,7 +48,7 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(int keep_empty, FILE *out,
 		int argc, const char **argv);
 
-int transform_todo_ids(int shorten_ids);
+int transform_todo_insn(int shorten_ids);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.15.1.280.g10402c1f5b5c

