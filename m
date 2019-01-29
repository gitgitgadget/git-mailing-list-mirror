Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF06D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfA2PDR (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:03:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46719 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfA2PDO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so22368640wrt.13
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VT2XN0SdGEyhJbn04SJLhKrNqJa6THxb4lrxlXbwUH0=;
        b=Sr6DenUaAU8I0n04I3+az3kT3J+hybdVYqfEtZr1zu1/hw8GM/iHf4uZNFqyCnN0ra
         zhiRpPK6FSOLvmMj5eeKYEoqBXaF49F+cyCgCqCV7Vmc1NTN7riucPViq0N7xHMkB8sZ
         ZSq7Koctd6WteYqlc/QWXewmyFQno3WIU7i69Agi7zcoz+cqW0f3IRjmhH0YYW+nhDpT
         xRvLWhsg5Rm/XTC043Dyp65meWN2wHhtz01lO0yRpuFBnh65FPhgEZPItEmamA2C5nlJ
         f9sn57OXh0ax6BH4JYMSDGJrEi3iclbn3Xg+DhJKjz4KRpbjNnzZ8zCESwkLXEDybTBb
         BfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VT2XN0SdGEyhJbn04SJLhKrNqJa6THxb4lrxlXbwUH0=;
        b=jCA2s6+TPmN/hwTIynJkshqpysHuX8EnSmswV82/BpqDlxo0tEB3zM4gsOZ8sXA0dq
         z4JBBdRgD1tMeX5zIAGbyaZ8UHego/dN0usuyOejLGqxr4d/4SOLhV27rNzLMO+3Qp3q
         o7rX22fnygeA+Gi9OVBQK9tCXz/Xt3tUqeSx9EEDjvOZraA8TeE8Uv8ji3cnSnngFVbt
         cj1bw2Ky1zB7uHbaGul+09VnOZrI6NQTtu4eGd2NIGrlcbnVWeKWrUdFfDhKiwhdyRqX
         nl+7n41fLj6FlnYQM7veUvKW7zLfzXLinf9gz0CoGPvdSKrK8Tm28WL/JXNvMHnpHMIz
         SN+A==
X-Gm-Message-State: AJcUukdhZeBN4XodyiU8tev7l80YP7oHS1cm1rj3D0ZLIpPUq2YUegvr
        u3Z7AOtFjhD7/biGq8BJ8EhfG+xA
X-Google-Smtp-Source: ALg8bN59H6VPp2k54b1KKbMsiFrlK5vSYO1hD3GI04qMC+DZ802fWtdQ7OGUGjo1caSUpG6oTuyMCA==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr25721574wrx.79.1548774192336;
        Tue, 29 Jan 2019 07:03:12 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.googlemail.com with ESMTPSA id 129sm4420851wmd.18.2019.01.29.07.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:03:11 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 11/16] sequencer: refactor skip_unnecessary_picks() to work on a todo_list
Date:   Tue, 29 Jan 2019 16:01:54 +0100
Message-Id: <20190129150159.10588-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150159.10588-1-alban.gruin@gmail.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
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
 sequencer.c | 78 ++++++++++++-----------------------------------------
 1 file changed, 17 insertions(+), 61 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2a43ca685b..a817afffa9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4661,52 +4661,22 @@ int check_todo_list_from_file(struct repository *r)
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
+				  struct object_id *output_oid)
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
@@ -4720,37 +4690,21 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
 		oidcpy(output_oid, &item->commit->object.oid);
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
+			record_in_rewritten(output_oid, peek_command(todo_list, 0));
 	}
 
-	todo_list_release(&todo_list);
-
 	return 0;
 }
 
@@ -4823,6 +4777,11 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
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
@@ -4831,9 +4790,6 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	todo_list_release(&new_todo);
 
-	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
-		return error(_("could not skip unnecessary pick commands"));
-
 	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
 		return -1;
 
-- 
2.20.1

