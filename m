Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898D620248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfCETSw (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:18:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33856 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCETSv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:18:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id o10so2812361wmc.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5y6DoiZN7wGWdQtj8/hHi8p8Eo1Xd0owlk+06U0AvVY=;
        b=e5O6k7TfB7zstd5/glCEjfnr1s8ZOnYJAWf5A6W0eOLPynpZEtEvfDs/iZE+JWZ78H
         w8er7PUJD5VdDJXPZm/6Wp72HnJxlCjMQ2uLsvNFQQGbmulnX3EY9xm3AkNQxzD68NWg
         zQAgjd2/8P9An0RZ4JqpcnglA/V2t64CSeVaNNF+ijeaBwmU1rW80mVIs5Txxks16ik/
         LfH/FXGRJ+eaezZ1IGm9JRsk2LHpFmiX9sXEodgnAHJ+93MrHUQSlQ3X+3zxwqFnIy2X
         KjT/szu5YNwc0ML9VYIOE9oixaMVwFzlS7wnJzZKU5c2MlXb5mrrCYENXFdxV7O0rh9x
         VPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5y6DoiZN7wGWdQtj8/hHi8p8Eo1Xd0owlk+06U0AvVY=;
        b=tUq8YGCqNjSq6p4Zhh1wPop3oEV3NWS4Kac6cijVtcIhdcriFcBc2CheXShVXMDp7S
         NlFXBWVLiXgxeYdJI3JkzCGdMTKKabWjgWhnlwIX3/AcS1IpoV4bCCFv54Z8xQw0WXla
         0eibJSxd6LqSykkTEJEWJ4d9foTjyH46QH4zpbUTp1PU4bo909T/vLAThA64luqW8/AD
         OXiCVjFqcEeG0GoYOprjq0DVGXJto3Rataqw6yqgl+nVNebewOHq7Yq0gEp+XPQ2KHLk
         OCPs8VMZV6o7xSrhYNUakvU1zcLnC1GGqZSJX6QX9ul5JwLopCkm3YbBtB62WPAkZtre
         gHkg==
X-Gm-Message-State: APjAAAXtVBYi4EfcHQIN7Gn80LmAN7Kq86UB+tTKZzWCvOx023LRqvO+
        /Seux19fU7MnRmDIB9g2XyQkslrb
X-Google-Smtp-Source: APXvYqw9VXDtgpuNWCo6q6IaPE9QYKsatfSFpLRb/FFS6NCsj4WxxrXlTsKnlqzaxdj38lIYoUFeMQ==
X-Received: by 2002:a1c:d044:: with SMTP id h65mr82376wmg.120.1551813528906;
        Tue, 05 Mar 2019 11:18:48 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:48 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 13/18] sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Date:   Tue,  5 Mar 2019 20:18:00 +0100
Message-Id: <20190305191805.13561-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305191805.13561-1-alban.gruin@gmail.com>
References: <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190305191805.13561-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors skip_unnecessary_picks() to work on a todo_list.  As this
function is only called by complete_action() (and thus is not used by
rebase -p), the file-handling logic is completely dropped here.

Instead of truncating the todo list’s buffer, the items are moved to
the beginning of the list, eliminating the need to reparse the list.
This also means its buffer cannot be directly written to the disk.

rewrite_file() is then removed, as it is now unused.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 sequencer.c | 82 +++++++++++++----------------------------------------
 1 file changed, 19 insertions(+), 63 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ffa4334982..894c7538d5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4700,52 +4700,22 @@ int check_todo_list_from_file(struct repository *r)
 	return res;
 }
 
-static int rewrite_file(const char *path, const char *buf, size_t len)
-{
-	int rc = 0;
-	int fd = open(path, O_WRONLY | O_TRUNC);
-	if (fd < 0)
-		return error_errno(_("could not open '%s' for writing"), path);
-	if (write_in_full(fd, buf, len) < 0)
-		rc = error_errno(_("could not write to '%s'"), path);
-	if (close(fd) && !rc)
-		rc = error_errno(_("could not close '%s'"), path);
-	return rc;
-}
-
 /* skip picking commits whose parents are unchanged */
-static int skip_unnecessary_picks(struct repository *r, struct object_id *output_oid)
+static int skip_unnecessary_picks(struct repository *r,
+				  struct todo_list *todo_list,
+				  struct object_id *base_oid)
 {
-	const char *todo_file = rebase_path_todo();
-	struct strbuf buf = STRBUF_INIT;
-	struct todo_list todo_list = TODO_LIST_INIT;
 	struct object_id *parent_oid;
-	int fd, i;
-
-	if (!read_oneliner(&buf, rebase_path_onto(), 0))
-		return error(_("could not read 'onto'"));
-	if (get_oid(buf.buf, output_oid)) {
-		strbuf_release(&buf);
-		return error(_("need a HEAD to fixup"));
-	}
-	strbuf_release(&buf);
-
-	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
-		return -1;
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
+	int i;
 
-	for (i = 0; i < todo_list.nr; i++) {
-		struct todo_item *item = todo_list.items + i;
+	for (i = 0; i < todo_list->nr; i++) {
+		struct todo_item *item = todo_list->items + i;
 
 		if (item->command >= TODO_NOOP)
 			continue;
 		if (item->command != TODO_PICK)
 			break;
 		if (parse_commit(item->commit)) {
-			todo_list_release(&todo_list);
 			return error(_("could not parse commit '%s'"),
 				oid_to_hex(&item->commit->object.oid));
 		}
@@ -4754,42 +4724,26 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
 		if (item->commit->parents->next)
 			break; /* merge commit */
 		parent_oid = &item->commit->parents->item->object.oid;
-		if (!oideq(parent_oid, output_oid))
+		if (!oideq(parent_oid, base_oid))
 			break;
-		oidcpy(output_oid, &item->commit->object.oid);
+		oidcpy(base_oid, &item->commit->object.oid);
 	}
 	if (i > 0) {
-		int offset = get_item_line_offset(&todo_list, i);
 		const char *done_path = rebase_path_done();
 
-		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
-		if (fd < 0) {
-			error_errno(_("could not open '%s' for writing"),
-				    done_path);
-			todo_list_release(&todo_list);
-			return -1;
-		}
-		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
+		if (todo_list_write_to_file(r, todo_list, done_path, NULL, NULL, i, 0)) {
 			error_errno(_("could not write to '%s'"), done_path);
-			todo_list_release(&todo_list);
-			close(fd);
 			return -1;
 		}
-		close(fd);
 
-		if (rewrite_file(rebase_path_todo(), todo_list.buf.buf + offset,
-				 todo_list.buf.len - offset) < 0) {
-			todo_list_release(&todo_list);
-			return -1;
-		}
+		MOVE_ARRAY(todo_list->items, todo_list->items + i, todo_list->nr - i);
+		todo_list->nr -= i;
+		todo_list->current = 0;
 
-		todo_list.current = i;
-		if (is_fixup(peek_command(&todo_list, 0)))
-			record_in_rewritten(output_oid, peek_command(&todo_list, 0));
+		if (is_fixup(peek_command(todo_list, 0)))
+			record_in_rewritten(base_oid, peek_command(todo_list, 0));
 	}
 
-	todo_list_release(&todo_list);
-
 	return 0;
 }
 
@@ -4860,6 +4814,11 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	}
 
+	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
+		todo_list_release(&new_todo);
+		return error(_("could not skip unnecessary pick commands"));
+	}
+
 	if (todo_list_write_to_file(r, &new_todo, todo_file, NULL, NULL, -1,
 				    flags & ~(TODO_LIST_SHORTEN_IDS))) {
 		todo_list_release(&new_todo);
@@ -4868,9 +4827,6 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	todo_list_release(&new_todo);
 
-	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
-		return error(_("could not skip unnecessary pick commands"));
-
 	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
 		return -1;
 
-- 
2.20.1

