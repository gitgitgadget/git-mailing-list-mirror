Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F281F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfAWU7q (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45271 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfAWU7q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so4079356wrr.12
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0DCJcMRz0JP4DJ7oZrAk1G9A7Y9hdNvFAvKkan2OpFs=;
        b=gdR23jDIXlfoX/uNfwChl/y+fohCSa6ZmDm6QtUZlMEm3d8wwatUofFzRvVNEPh2+x
         vjP3aTkV9cgXPWB96VKJ6GsJHN0NVIUYzBgpVP1/lsXqRB5/9wv0z1GPyeIXSZEatQmM
         IijOYRFP7jtpy8jydiGHDzS93Av6AL+btrS4sjFx0AaFcIV1WFmjBkztV4n8/C5ll3St
         5yUR5n7lydd7aeviFjm+qBvmrnxghliYZE43ewRFr7q/V4eze4gJZqPJded+UEAmF3mW
         Cb0QLDCkG2lssnOPRs/hEQgpc6yXKTzmyYli1PjDqqLYUAW3B5OArNMXLVglP1YSpI0N
         JJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0DCJcMRz0JP4DJ7oZrAk1G9A7Y9hdNvFAvKkan2OpFs=;
        b=msmB9YKztoNOnMpybUwug8ZLiHVHxYK74lnfEMiImjQfi8ALIOAkg3I1rkmD85QvlX
         EAFUFZRg2wYqLRpt0lPS9vBQW9CxWvdveFHBxblogCm+3WgSwGLpmox1wuOlaYL1MsAY
         hGE3mvShc/haA4RCPzXw0zxaoJNRqybpIXibQmFrPFblOjfGFGbNbcV94PLSaBXTuqc+
         /LnjzxCzmxC0ELLmCBDWO882mPhb5cihxdFtErO8MzzIHjMejLgKNlB6xq5ktu+vn0Kq
         1EGipSV35vjFWUDqqLizlQ1N6GPsdgeQlLtgWra5gXy6TYEAZSQtyI3mNoum2bV85ZVD
         gsGA==
X-Gm-Message-State: AJcUukd2kIYoSqo4zNbmjTwOF3sKYwditvGb5v6j4+I9mXMyZPn1sKAw
        CMXJ3Kp13aderhBzs+5WRe3ojjTk
X-Google-Smtp-Source: ALg8bN7cqO32UyFSagKN4s4IihQNCTlA4LLhB3d5MrFagyzIqvoJ/YL7PFX/P+42fi5Y2egbLUuKNg==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr4080413wrq.108.1548277184126;
        Wed, 23 Jan 2019 12:59:44 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:43 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 15/16] sequencer: use edit_todo_list() in complete_action()
Date:   Wed, 23 Jan 2019 21:58:20 +0100
Message-Id: <20190123205821.27459-16-alban.gruin@gmail.com>
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

This changes complete_action() to use edit_todo_list(), now that it can
handle the initial edit of the todo list.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Unchanged since v4.

 sequencer.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8f47f0cf39..21b04e0642 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4709,6 +4709,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf;
 	struct object_id oid;
+	int res;
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
@@ -4733,24 +4734,16 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error(_("nothing to do"));
 	}
 
-	if (todo_list_write_to_file(r, todo_list, todo_file,
-				    shortrevisions, shortonto, -1,
-				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
-		return error_errno(_("could not write '%s'"), todo_file);
-
-	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
-		return error(_("could not copy '%s' to '%s'."), todo_file,
-			     rebase_path_todo_backup());
-
-	if (launch_sequence_editor(todo_file, &new_todo.buf, NULL)) {
+	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
+			     shortonto, flags);
+	if (res == -1)
+		return -1;
+	else if (res == -2) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
 
 		return -1;
-	}
-
-	strbuf_stripspace(&new_todo.buf, 1);
-	if (new_todo.buf.len == 0) {
+	} else if (res == -3) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
 		todo_list_release(&new_todo);
-- 
2.20.1

