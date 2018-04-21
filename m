Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A6C1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeDUKbZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:31:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:36553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbeDUKbY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:31:24 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8pKi-1fHa5h2OSK-00CAZo; Sat, 21
 Apr 2018 12:31:17 +0200
Date:   Sat, 21 Apr 2018 12:31:00 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v8 03/16] sequencer: refactor how original todo list lines
 are accessed
In-Reply-To: <cover.1524306546.git.johannes.schindelin@gmx.de>
Message-ID: <9b7fc34e8f20205109a6c081671ec8d6e0b1e27f.1524306546.git.johannes.schindelin@gmx.de>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RsHhwo6hpR7tS6cKsSGSROe637jxnrVxCmMBh6bdb0voJbUP0ru
 yld16RR0vTjcS4jQvAVR6jWxipzuRtZAECgrm5gagRA7FkEGY/KA9yCMM+5eKQHt7Gkmqtq
 w0THpMdpmwt7HXx5BFB5RFaAmX3C0IzAntXJybk7AoRgkHLOWShLsKQKxHBD+2cCfc0J5YT
 SaZEvvxRHfdRgOI7XnX6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qZc82yP1sZU=:BgBRSFZVNyv7fe7w/pL5Hr
 MbgYUXxR3H/JF3g9AWRqxuatgDSptdd9l+wWfCcX3E8m58iNTXCvOvO1/2c+Yqigmu6NdAlVr
 6M7Tz4OoQ1LS11GnXF7c5iqS/ekHCjCAj6AxkLwCL1t3cQxPdeV2ppQaQBGcqyHcKKnGWlPHq
 FBnCzdyFaqdgLmt+UdplSWDSnDQJ8LyCwgAMZNQ0iSYfuKiWn1gpYhyHVZjq3XhOiyMYznCES
 sQS67jsefRpyMJWUqkptgxwWzp9xOJk6mHhQL1MJHfit7ZpLkWjHsgfaLMi2ndl5dicRHP8QM
 cKHnuZGn7wxjBhK/xgXqnr1Nzu1lIjuNLS8rQYUDrTjD0SOEJZ/v7c85ItQ3TGzMQ+9UP1Lss
 7F6vWQNrCqHctiZwEvx8gLE2fvOH4HGjcZ8xzSajQeRzVpnM9SleEz44mZxfF5S//fP42YcOi
 RkbkGJ45yzxRF1SrN7Rqx4+4t3RvG0a6e0MVZ2NvSpNx0T802KUEhVQfgpy4jpqtKNYm0WMk/
 3Yg99A/4NFnwsleYvTvkf8mzZBnJ96c/Fws5zbFWRYdLfpi3+RYopcFLB48kUTXhZfirkL3u8
 RmcmkucUEualdGzaPtp/dj+l/ZfgQIhCdbnLcqcyE0qSQvdNJ1w1y6apMw4ua+2hfNyYcxTyH
 Lgc+1svECuaVPZ8oamp+i6J4PIei0dgYMQliqy2FooLRCVHhqdZSxNO6Wr4fAkK+avSX4qHyL
 6/ozmdTKZYSB7QJv2ypVFNgglZUdK4W6pcrDv9KB1yw2/PLIuxtbxVpLt4P1p/9GVMw7ttK3e
 p1u0aYfNyUneVVERQXfq1OO1Qr2tNavDccrv9r/Rooin59Ekjw=
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
index 1ee70d843c1..3d0a45ab25a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1870,6 +1870,23 @@ static int count_commands(struct todo_list *todo_list)
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
@@ -2244,29 +2261,27 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
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
@@ -3297,8 +3312,7 @@ int skip_unnecessary_picks(void)
 		oid = &item->commit->object.oid;
 	}
 	if (i > 0) {
-		int offset = i < todo_list.nr ?
-			todo_list.items[i].offset_in_buf : todo_list.buf.len;
+		int offset = get_item_line_offset(&todo_list, i);
 		const char *done_path = rebase_path_done();
 
 		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
@@ -3478,12 +3492,10 @@ int rearrange_squash(void)
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
2.17.0.windows.1.15.gaa56ade3205


