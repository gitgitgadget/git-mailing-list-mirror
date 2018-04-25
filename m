Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF831F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeDYM2m (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:28:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:34209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753110AbeDYM2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:28:39 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MfmZs-1ez7ll0utY-00N6nC; Wed, 25 Apr 2018 14:28:33 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 03/17] sequencer: refactor how original todo list lines are accessed
Date:   Wed, 25 Apr 2018 14:28:29 +0200
Message-Id: <eb63a8dc3d698d0ee513b957fc775c6396b3a0d8.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:chT9A54Pq5sY0fjvAFgHks11wZKjkD6x+prPke3u1jizDYPAPLz
 5zI6l6U1umyVHCcwGxpfYXs/ezIXW02mNI3rAD+aHeHb9+EcD9E768DOY/tpSyQScItEBKy
 4WLy/pyTLEq+39DtNRoslpFPHnWJUYa775wClVqY84VzqECsUcehkAzDooZbqzNrqeGehRR
 zAxBHTyXcAsz6jcCywvYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VzjeyfQZjjM=:nxcb+qu+zYu0wusXNPHtfg
 ACd0M9hJnCqvfMpZNuRJlsx3lnUqnsmlnMCe8KQC/c+3vaSz4dFePhB07jEjSLCdqHGcWwBT4
 CLF0zQxDrrhYkhOF0b6dykjKeepiC/Xtb5rav4lSR/PsgjgaMPkRWQzTpEiRiKL1iEE2xGoMV
 uLK2RCcH9BT3nA5QiyOPx6EiQmnlZsgUfaeMDxHFSaLfyUQnjGFrD8rA7msCdJxmJ2xIGEeMj
 jFXMo5EeDuWU/KyX63U+6Gq/UKzcGl5TKUmZL+qK1ls/rqnkOA59n2KItFSOj63dNRT9y6CHx
 Ck4eMmCBV0gnvXfdP3ODp1HmASLiWU9lJrQYjnuFB1A1DNrB+ppsY1ometxFouTYFCUltSVLs
 If62Z49JnSyJfxsHujPgew6yNG3vVpywHpy8TtoUNuO78nNnRppc1/U+JBypjpS+LlCO8AFqF
 l/VrZZaeTLQiS1AH096+FFyapwFQdJgbwIf9Ed6moNnOYVviERiMCUUDpY+bZYskxv/WFvEe7
 cVYDj248r+ULYNKS5DbLrFGg7UlU56Q3j+3kfy2Nauk/DVzvZ6IKF7so7yBv5hKmhhsk1dmG6
 UeQOZ7yNVg8iuMhZlTv6KpJ9fXBGZW0RyQyAImJUKTW+f5rULMAEXkKEp6j+WXbRs6tvabzQo
 EA2S6adEsK77QlTRbfZdFLxKZMnXLlhDmhJ9nvCthcP5eA8vecQewvlUD7ReN/BB4j6ObrsQM
 TTUCADAifXKTpc1wrbgU6bdHT8Va6InPN5L2XbZ0tU9MqNqSP2EkDp/ZvbB7EQCcJb1ZoaKUY
 mPxKoT4I1niAw8MXyibAjbD4OiNjiPqa/CdZSBo3myxQx9ZxQJXeLRdckXiJNAt4KhRaixd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we did a lot of arithmetic gymnastics to get at the line in
the todo list (as stored in todo_list.buf). This might have been fast,
but only in terms of execution speed, not in terms of developer time.

Let's refactor this to make it a lot easier to read, and hence to
reason about the correctness of the code. It is not performance-critical
code anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 60 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c131e39fa93..eac1c341c1c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1871,6 +1871,23 @@ static int count_commands(struct todo_list *todo_list)
 	return count;
 }
 
+static int get_item_line_offset(struct todo_list *todo_list, int index)
+{
+	return index < todo_list->nr ?
+		todo_list->items[index].offset_in_buf : todo_list->buf.len;
+}
+
+static const char *get_item_line(struct todo_list *todo_list, int index)
+{
+	return todo_list->buf.buf + get_item_line_offset(todo_list, index);
+}
+
+static int get_item_line_length(struct todo_list *todo_list, int index)
+{
+	return get_item_line_offset(todo_list, index + 1)
+		-  get_item_line_offset(todo_list, index);
+}
+
 static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
 {
 	int fd;
@@ -2250,29 +2267,27 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
 	if (fd < 0)
 		return error_errno(_("could not lock '%s'"), todo_path);
-	offset = next < todo_list->nr ?
-		todo_list->items[next].offset_in_buf : todo_list->buf.len;
+	offset = get_item_line_offset(todo_list, next);
 	if (write_in_full(fd, todo_list->buf.buf + offset,
 			todo_list->buf.len - offset) < 0)
 		return error_errno(_("could not write to '%s'"), todo_path);
 	if (commit_lock_file(&todo_lock) < 0)
 		return error(_("failed to finalize '%s'"), todo_path);
 
-	if (is_rebase_i(opts)) {
-		const char *done_path = rebase_path_done();
-		int fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
-		int prev_offset = !next ? 0 :
-			todo_list->items[next - 1].offset_in_buf;
+	if (is_rebase_i(opts) && next > 0) {
+		const char *done = rebase_path_done();
+		int fd = open(done, O_CREAT | O_WRONLY | O_APPEND, 0666);
+		int ret = 0;
 
-		if (fd >= 0 && offset > prev_offset &&
-		    write_in_full(fd, todo_list->buf.buf + prev_offset,
-				  offset - prev_offset) < 0) {
-			close(fd);
-			return error_errno(_("could not write to '%s'"),
-					   done_path);
-		}
-		if (fd >= 0)
-			close(fd);
+		if (fd < 0)
+			return 0;
+		if (write_in_full(fd, get_item_line(todo_list, next - 1),
+				  get_item_line_length(todo_list, next - 1))
+		    < 0)
+			ret = error_errno(_("could not write to '%s'"), done);
+		if (close(fd) < 0)
+			ret = error_errno(_("failed to finalize '%s'"), done);
+		return ret;
 	}
 	return 0;
 }
@@ -3307,8 +3322,7 @@ int skip_unnecessary_picks(void)
 		oid = &item->commit->object.oid;
 	}
 	if (i > 0) {
-		int offset = i < todo_list.nr ?
-			todo_list.items[i].offset_in_buf : todo_list.buf.len;
+		int offset = get_item_line_offset(&todo_list, i);
 		const char *done_path = rebase_path_done();
 
 		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
@@ -3488,12 +3502,10 @@ int rearrange_squash(void)
 				continue;
 
 			while (cur >= 0) {
-				int offset = todo_list.items[cur].offset_in_buf;
-				int end_offset = cur + 1 < todo_list.nr ?
-					todo_list.items[cur + 1].offset_in_buf :
-					todo_list.buf.len;
-				char *bol = todo_list.buf.buf + offset;
-				char *eol = todo_list.buf.buf + end_offset;
+				const char *bol =
+					get_item_line(&todo_list, cur);
+				const char *eol =
+					get_item_line(&todo_list, cur + 1);
 
 				/* replace 'pick', by 'fixup' or 'squash' */
 				command = todo_list.items[cur].command;
-- 
2.17.0.windows.1.33.gfcbb1fa0445


