Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8349F1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeJHDIx (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34260 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeJHDIm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id z25-v6so7337811wmf.1
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fK0kS4M9zCqeOQRATMV7NdTbQ0OaSTne9/Z0cJRvP/8=;
        b=p96KfojYV0Pph0/Afk+Ta6vqbxmzUvblQlI9FR89XZGZKC68rLznoNrVV2YAR2jyw0
         cyFw8TrXCweWEPIKVMT6Ulm9yfFWqZuRq2QebWsdBM+loRPa/XJ+9/dfVFPXHQQm6i2D
         5JAVaI41RVixXvk10pE/1we5sqv1YdEB43KhTjWm9UkWD/QO1L38pxEOJmKjaGrRCsBa
         wMAFEaRxpq1UKjDzkuM0ZlVAFm8NuROOLxCy2R9Qdcewdv0bRpj0tzwfs9VBsRJ5v8f2
         OmLsspeTVFdVPsBPkRIZ6RFSxw9BYqqkmgsjX+nAzn4hVh7hTiBVu2YSH/E61q3//j/B
         9+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fK0kS4M9zCqeOQRATMV7NdTbQ0OaSTne9/Z0cJRvP/8=;
        b=TPIfuYmkNSw6WbM1+D39x2UHorPGmnOikNF/1ii1SMYAreUodpOP4Hd25hPDLUb/zN
         cyAeqK9OamDemg+U2E3++ejhVwJMs+UeUUdV1NqxJbya+puLw6DfpFCV+rk+YD7vXwiJ
         HAUA4T1nd6KbVeOw8nExeHJ1WWklou+fyVPiWfu25Mf3NdYQIL4fQ5NzWIZ7bFx9Sg/6
         YAQ5afKrM4uCUms+ZONybmO8M0N+dc1QsElHPpKSlnkSyH5QVhg4DfP7RTIOr0AcSOJD
         icG/WbUuRjds8DZoCCMYcUke50+vRdywhfIhmkJxBrE1+CDzcOebhaTsMNMtQkmxZR/8
         47jA==
X-Gm-Message-State: ABuFfohXz5Zba6txNPgSHow7AE5cENeFBYcIJYv07gA6Qp3ELFzMr0vY
        7JmmTeZnI9nFPgAXS8XzV0TTx5fK
X-Google-Smtp-Source: ACcGV63ZJrMY/CC7Tx4p6x0EMlxqziFaAGXra96QLrkX+HfDKD7rHw/5yFLZLgMVIAA2t+1t+7cWlQ==
X-Received: by 2002:a1c:84cd:: with SMTP id g196-v6mr13417483wmd.38.1538942417967;
        Sun, 07 Oct 2018 13:00:17 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:17 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 09/15] sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Date:   Sun,  7 Oct 2018 21:54:12 +0200
Message-Id: <20181007195418.25752-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors skip_unnecessary_picks() to work on a todo_list.  The
file-handling logic is completely dropped here, as its only usage is
made by complete_action().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 56 +++++++++++++++--------------------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b37935e5ab..a432b64048 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4545,38 +4545,20 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 }
 
 /* skip picking commits whose parents are unchanged */
-static int skip_unnecessary_picks(struct object_id *output_oid)
+static int skip_unnecessary_picks(struct todo_list *todo_list,
+				  struct object_id *output_oid)
 {
-	const char *todo_file = rebase_path_todo();
-	struct strbuf buf = STRBUF_INIT;
-	struct todo_list todo_list = TODO_LIST_INIT;
 	struct object_id *parent_oid;
 	int fd, i;
 
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
-	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
-		todo_list_release(&todo_list);
-		return -1;
-	}
-
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
@@ -4590,37 +4572,29 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
 		oidcpy(output_oid, &item->commit->object.oid);
 	}
 	if (i > 0) {
-		int offset = get_item_line_offset(&todo_list, i);
+		int offset = get_item_line_offset(todo_list, i);
 		const char *done_path = rebase_path_done();
 
 		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
 		if (fd < 0) {
 			error_errno(_("could not open '%s' for writing"),
 				    done_path);
-			todo_list_release(&todo_list);
 			return -1;
 		}
-		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
+		if (write_in_full(fd, todo_list->buf.buf, offset) < 0) {
 			error_errno(_("could not write to '%s'"), done_path);
-			todo_list_release(&todo_list);
 			close(fd);
 			return -1;
 		}
 		close(fd);
 
-		if (rewrite_file(rebase_path_todo(), todo_list.buf.buf + offset,
-				 todo_list.buf.len - offset) < 0) {
-			todo_list_release(&todo_list);
-			return -1;
-		}
+		strbuf_splice(&todo_list->buf, 0, offset, NULL, 0);
 
-		todo_list.current = i;
-		if (is_fixup(peek_command(&todo_list, 0)))
-			record_in_rewritten(output_oid, peek_command(&todo_list, 0));
+		todo_list->current = i;
+		if (is_fixup(peek_command(todo_list, 0)))
+			record_in_rewritten(output_oid, peek_command(todo_list, 0));
 	}
 
-	todo_list_release(&todo_list);
-
 	return 0;
 }
 
@@ -4701,6 +4675,11 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 
 	todo_list_transform(&new_todo, flags & ~(TODO_LIST_SHORTEN_IDS));
 
+	if (opts->allow_ff && skip_unnecessary_picks(&new_todo, &oid)) {
+		todo_list_release(&new_todo);
+		return error(_("could not skip unnecessary pick commands"));
+	}
+
 	if (rewrite_file(todo_file, new_todo.buf.buf, new_todo.buf.len) < 0) {
 		todo_list_release(&new_todo);
 		return error_errno(_("could not write '%s'"), todo_file);
@@ -4708,12 +4687,9 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 
 	todo_list_release(&new_todo);
 
-	if (opts->allow_ff && skip_unnecessary_picks(&oid))
-		return error(_("could not skip unnecessary pick commands"));
-
 	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
 		return -1;
-;
+
 	if (require_clean_work_tree("rebase", "", 1, 1))
 		return -1;
 
-- 
2.19.1

