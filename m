Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2506C1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBJN11 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55266 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBJN1W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so12204182wmh.4
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCCMXnk/QC9967cjOWBhRPOzBQ+hp5/JMaKiI2Tq0VQ=;
        b=gHV3mc+oMiRAB8Vh9ELhtqE+MF83nfMhTrP4gXO/sXXW1XKHO2Qu6hoTTb0nrdESq/
         1eEPcRMlhcl6AWKICq+L48C99jdW5Oyw8Vy1klfBP4AjoJZ7irHe8Z+F1di89PGdFGA7
         zKtaI083lyrh3DgodX+OrDpu8AuafnlWtHiZe6q6fOkqTwqFG2gCwnkbq8MaqzrYhMmy
         WBZjMNRfNBW3Yde0UzjwNc3j4hDjCw9mUx9KVggKIj3uFxBtYSPRk5k5zbdCygTRl+Wb
         XlBTncAPquMp85yNuohe7KP7z+R8F3gkm7gS9ycs9nIvlwgpX30e0LdtqcfMh3aHq99X
         g7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCCMXnk/QC9967cjOWBhRPOzBQ+hp5/JMaKiI2Tq0VQ=;
        b=SFPcsfHWpf3i3kUQTvgsWZwt5YKiVsnrfxT4mAo9Xy8YDhECXXdYFg9cl+QeAB1nIQ
         Xw+IqWjKaVWdbUeLuy93MzmeAohrOHlrQOfLxdcpdNka/22bVmqANEQ5egyKhWeYGt1T
         j4wDmOeMHefkGMfyjzuz6ezbvTIu4brJM91PE6IBFwoFXJYkBebr8bZ6Wa5m9k7J4bYG
         3eAa3IfUiFuqbgwbX/JWzV+ItwtFhEbsk/ktKEDEO+s4fqMOSvHYNWQ/0QKBLdxCaiXg
         imN0wM80l20HZIA/TkKS32BHuO0yz27adyU2C4m6mwqMMN+SkNiWkbac8l3T0HajQfqy
         ksRw==
X-Gm-Message-State: AHQUAua+v7BTyZbhawRX1jr4sOhaNMMFGd/4tT6z4InogKEONYNjJJDF
        ATI5orBRBf4+YfSdZriKEJjC5f2Y
X-Google-Smtp-Source: AHgI3IY7jRqUj9+xtFyndKSvk+IwGm81bE7+hHeCEUeELtsukoCmL6lVodXEQMX/lOO8klVoG8Fucg==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr1718424wrx.243.1549805239404;
        Sun, 10 Feb 2019 05:27:19 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:18 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 11/16] sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Date:   Sun, 10 Feb 2019 14:26:43 +0100
Message-Id: <20190210132648.12821-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210132648.12821-1-alban.gruin@gmail.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
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
 sequencer.c | 82 +++++++++++++----------------------------------------
 1 file changed, 19 insertions(+), 63 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index eb8a622af0..eacaf52250 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4717,52 +4717,22 @@ int check_todo_list_from_file(struct repository *r)
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
@@ -4771,42 +4741,26 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
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
 
@@ -4879,6 +4833,11 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
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
@@ -4887,9 +4846,6 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	todo_list_release(&new_todo);
 
-	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
-		return error(_("could not skip unnecessary pick commands"));
-
 	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
 		return -1;
 
-- 
2.20.1

