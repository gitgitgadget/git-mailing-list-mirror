Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73151F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfAWU7p (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35273 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfAWU7k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so4144210wrb.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Va+2fB4tF8JYiUz4dB1BTqGO/Uvg0TfiKWiPrXdaHI=;
        b=IuQKiOv9bHM6+P5n/LEYM7dHDZgmslRdjfEcKUmQnF5aM+SLc9ETkWL6x7XYiTE6ME
         3IQfG35bLewBtLjJUUnlGj0+q3laNFpIX6/0KqOct7xEX0kleiY+4F4tUl/0QbLronpU
         jd6cREf5hCTFKSZKtJKzT+5lwpA75dbL+dgfeUvC5uqt8OEHMgNgCsJW7BECJdJl4kKn
         LqYB3k3BqtkhuNsYyRNpyqvsFB/s3JkFth6iMy+zTXWF4Cu5X6/2qd0yC4FHzANZCXH2
         NgIeSsoasZyoRykpAPnBo4weZQHyvMQE8HcXH2WONuE3WJj/L56MTVVsnBBjgerduAsr
         yJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Va+2fB4tF8JYiUz4dB1BTqGO/Uvg0TfiKWiPrXdaHI=;
        b=lHchK4OrUvenBdzIzEN8/Wbip4Ut4/PlPxSmqKnqg3P8kHvUFB328PCpvbXJFeMHqQ
         7HZ7PT9UeEZQZjFsVpZsQNvWsviHlOGj3QEfd6Z4UGdnNAtYk6lYsOBP6OMnH1UGvjXY
         Fe+QJEu0Bb8OcJ1vfjctfTKYKLO0o6v5W/2OVe7spe3lNqpZBMkdPfvk4cbIGrWHtGW+
         NMchFAFYaJ8snOl7zRuXMdA/L3AzwXK/NRZxnTchnt9QU1c5RlL48yLl+EGdA3kOXols
         QxE9rUYBi2fFlLkwrH/jUzK3qN1E55tDxwj3EcsM/PpE98gzm7RbJLj5MSLf/Y5RzMpN
         1Cug==
X-Gm-Message-State: AJcUukeE2o250xDr10DSuAFnzZr4krJikvxbSJV7skePfFYPHKjdXARS
        egs8xRgdechhoJhuPp56cu8J7SXl
X-Google-Smtp-Source: ALg8bN7Y853hLLJDUqmzW5M47/Cb2FqEz7bKaw2ag4V0BrOPPXpDGmQuw/q4mIvT4o9nPJZ0RJYByg==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr4540249wrn.27.1548277178720;
        Wed, 23 Jan 2019 12:59:38 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:38 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 12/16] rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
Date:   Wed, 23 Jan 2019 21:58:17 +0100
Message-Id: <20190123205821.27459-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123205821.27459-1-alban.gruin@gmail.com>
References: <20181229160413.19333-1-alban.gruin@gmail.com>
 <20190123205821.27459-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like complete_action(), edit_todo_list() used a
function (transform_todo_file()) that read the todo list from the disk
and wrote it back, resulting in useless disk accesses.

This changes edit_todo_list() to call directly todo_list_write_to_file()
instead.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Squashed <5440ddf5-0b80-3d00-7daf-133a8611efa8@ramsayjones.plus.com>
from Ramsay Jones.

 rebase-interactive.c | 38 ++++++++++++++++----------------------
 sequencer.c          |  4 ++--
 sequencer.h          |  3 ---
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index dfa6dd530f..d396ecc599 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -79,39 +79,33 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 
 int edit_todo_list(struct repository *r, unsigned flags)
 {
-	struct strbuf buf = STRBUF_INIT;
 	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res = 0;
 
-	if (strbuf_read_file(&buf, todo_file, 0) < 0)
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	strbuf_stripspace(&buf, 1);
-	if (write_message(buf.buf, buf.len, todo_file, 0)) {
-		strbuf_release(&buf);
+	strbuf_stripspace(&todo_list.buf, 1);
+	todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
+	if (todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
+				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP)) {
+		todo_list_release(&todo_list);
 		return -1;
 	}
 
-	strbuf_release(&buf);
-
-	transform_todo_file(r, flags | TODO_LIST_SHORTEN_IDS);
-
-	if (strbuf_read_file(&buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	append_todo_help(1, 0, &buf);
-	if (write_message(buf.buf, buf.len, todo_file, 0)) {
-		strbuf_release(&buf);
+	strbuf_reset(&todo_list.buf);
+	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
+		todo_list_release(&todo_list);
 		return -1;
 	}
 
-	strbuf_release(&buf);
+	if (!todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list))
+		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
+					      flags & ~(TODO_LIST_SHORTEN_IDS));
 
-	if (launch_sequence_editor(todo_file, NULL, NULL))
-		return -1;
-
-	transform_todo_file(r, flags & ~(TODO_LIST_SHORTEN_IDS));
-
-	return 0;
+	todo_list_release(&todo_list);
+	return res;
 }
 
 define_commit_slab(commit_seen, unsigned char);
diff --git a/sequencer.c b/sequencer.c
index a817afffa9..d8d045067c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -383,8 +383,8 @@ static void print_advice(struct repository *r, int show_hint,
 	}
 }
 
-int write_message(const void *buf, size_t len, const char *filename,
-		  int append_eol)
+static int write_message(const void *buf, size_t len, const char *filename,
+			 int append_eol)
 {
 	struct lock_file msg_file = LOCK_INIT;
 
diff --git a/sequencer.h b/sequencer.h
index 0c30e43f0a..c5bee8124c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -64,9 +64,6 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
 
-int write_message(const void *buf, size_t len, const char *filename,
-		  int append_eol);
-
 /*
  * Note that ordering matters in this enum. Not only must it match the mapping
  * of todo_command_info (in sequencer.c), it is also divided into several
-- 
2.20.1

