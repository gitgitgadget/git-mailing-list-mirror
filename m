Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD8120A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbdLERxC (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:53:02 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35117 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbdLERwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:52:53 -0500
Received: by mail-it0-f65.google.com with SMTP id f143so3552560itb.0
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 09:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qLZ8GpkjJZjZTpyrsX4jRbdtNDToc3SPmsAjBeLlT9Y=;
        b=NUeqfwAj3DdyeapVVfI4E2Fx+6Jvi8PdRMyejcpDXq7hDaCa1qr2lUk8YA1nWPJHZO
         RXeOYyHzpK2CqCNJWAVDC36TFNNo0uajZMr/GGkewzJqO8CHYdAk0KLJNaCFecMGbvb3
         Vsx64sGD6Nn7Dpb2aBxlhWk8RpYMuJp0VY0ae9OA3ELT3iipjt169/yWgGaF9ECsXQZ+
         bs79EMiRsNE5p3/wIpdwANw4Q7T++7JpaS9Dp6BxIOY1bo2bAT/DBnLLK2ZWP+CXm+4a
         kyECyBS8Bd4hhtrctSPiNJqXq21mQXNxLsg8S2ni7uyFent6InB7Ik1H6RoWM6JqNE0M
         fBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qLZ8GpkjJZjZTpyrsX4jRbdtNDToc3SPmsAjBeLlT9Y=;
        b=RrZi3R/2TylJpbs3QMrqGlgjoy2ebAN5mTgca8Hduh2nIEGtSEWn14/0TRuH6N99jn
         AZisehnjsDUni3UDhHQXR3HbUp9w53CcVFx63/+58uwXZg7CZsPBxTm/aeojQLSLm1ud
         ihM+C4gwT2MEyr1gcJLXh/xkx+3FHQuSezLUsJwMy+EFHK14bl1xosISLCq8WUn93Iz6
         Nq3JmGwNPiBab76Q5FDsp5R+PmsVeWeg2ppUNssFR7GCvCjCTyiXdUqkdnaT63EAgoEQ
         gL1cXdBPMiXFQ0ayIt9ALLmIsjPXq+VcY37X6Baw7Hh2dZUk3lw2v4SUrGhllvpZz2CA
         frgA==
X-Gm-Message-State: AJaThX7wPXTguYi8RXnBrDWVFo2pGA8L0/iKAka4Xtfx/HD28H4POYF/
        5VLKnEFGNZsyvDOK4Wm1QgYUxz60Z3Y=
X-Google-Smtp-Source: AGs4zMazfcdBqVpt3bK0LSFlrcwiI0GY7EfyaBdv6+KqBGxkf5EikH9qOT287C0hX07W44lNkeWMzA==
X-Received: by 10.107.152.137 with SMTP id a131mr28740617ioe.168.1512496372843;
        Tue, 05 Dec 2017 09:52:52 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i195sm264737ioi.44.2017.12.05.09.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:52:52 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 4/9] rebase -i: refactor transform_todo_ids
Date:   Tue,  5 Dec 2017 12:52:30 -0500
Message-Id: <20171205175235.32319-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.gbdce6e0789cb
In-Reply-To: <20171205175235.32319-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171205175235.32319-1-liambeguin@gmail.com>
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
 sequencer.c              | 69 ++++++++++++++++------------------------
 sequencer.h              |  2 +-
 3 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index f8519363a393..8ad4779d1650 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -55,9 +55,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	if (command == MAKE_SCRIPT && argc > 1)
 		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
 	if (command == SHORTEN_SHA1S && argc == 1)
-		return !!transform_todo_ids(1);
+		return !!transform_todos(1);
 	if (command == EXPAND_SHA1S && argc == 1)
-		return !!transform_todo_ids(0);
+		return !!transform_todos(0);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
 	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
diff --git a/sequencer.c b/sequencer.c
index 5033b049d995..c9a661a8c4bd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2494,60 +2494,47 @@ int sequencer_make_script(int keep_empty, FILE *out,
 }
 
 
-int transform_todo_ids(int shorten_ids)
+int transform_todos(int shorten_ids)
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
index 6f3d3df82c0a..4f7f2c93f83e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,7 +48,7 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(int keep_empty, FILE *out,
 		int argc, const char **argv);
 
-int transform_todo_ids(int shorten_ids);
+int transform_todos(int shorten_ids);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.15.1.280.g10402c1f5b5c

