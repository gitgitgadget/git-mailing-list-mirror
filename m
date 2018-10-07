Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6FFD1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeJHDIs (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43992 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbeJHDIr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so18560702wrt.10
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IruHl0hMBftjMx1LoJgGdc1u8HOmZRkzqCH7OEFdMJ0=;
        b=WVfBJy6/HaFBNRPVxCcp6FXsDkyCF9cgkvB+Et3tVDAONxSRMra0AvKSXflpzkM6Rs
         itSMxY3kfsk8fAugs8fOh+Gy0U99b46Y7I0uOLEg+wIKB5KuzxCmbBwgfTHXMxltdas+
         Umv/RvHJhM95uzbSM84Gkeiqpq3cn8V8bA5Y0hNGBszIVqHqTN43qZfkXfx4c+JI58s4
         1rxIA1Rt6v+m1nxuHR6KcmEt0gAK/axknI4ZkJeg7Nx4IjAnYA9UN6A9VOLmbjqe0msq
         qsbFdj0CXs2VSEZ/2xbPue/EwW2/VeYSxyMLfoNtNKWFQBOz+HbG4OE9KWrDoGyO91Ry
         YfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IruHl0hMBftjMx1LoJgGdc1u8HOmZRkzqCH7OEFdMJ0=;
        b=gwL+a5q6hLs6i7PEkdOqLjpgLbgYRP0N1SXDrozGGa5K3JhKqD01nOFafVn6BECARE
         UckET8/lJf7aRy9QIc0C6t+i3PjY+xWOqlqSn1Gu7T38pdb4YSSMN10Bc0CwE3Fr1uhF
         mvRZ8MPVVRQdYYFKVekw5BBYPMdD/GkF1kBL1BYurIvaBk6rgFsZSUHSodT8TXMUQcIg
         8hfPXLk90SWxuzK2LDcTr8hQ/HJKNIFM+pRaNW3/9wz0JhM557WKuWedX/zPucTQ7uhi
         AlicP1XFVx03MtSsFW4EzWLxi7hFR4aJzVxEP2V9hTxSCWRxv05qHBnw5mmquThT6U8Y
         rq3A==
X-Gm-Message-State: ABuFfoimEFC4jzcC2//V4WSd/SXr8adzq6+CmgZifegUApZJgjJNO7/R
        eoxECub+jw7/YG1s8Cs7DBGY+rPr
X-Google-Smtp-Source: ACcGV63yWiQ89SOh9fUcW076V4wB56J/nsYAuxsT81Y+pQv4pyDEYWfF5CvGXD1yGhovFw3m9THUwg==
X-Received: by 2002:adf:9464:: with SMTP id 91-v6mr14647707wrq.200.1538942422937;
        Sun, 07 Oct 2018 13:00:22 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:22 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 13/15] sequencer: use edit_todo_list() in complete_action()
Date:   Sun,  7 Oct 2018 21:54:16 +0200
Message-Id: <20181007195418.25752-14-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
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
 sequencer.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bfcbe8239b..93b9b40f66 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4608,7 +4608,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf;
 	struct object_id oid;
-	int command_count;
+	int command_count, res;
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
@@ -4633,27 +4633,16 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return error(_("nothing to do"));
 	}
 
-	todo_list_transform(todo_list, flags | TODO_LIST_SHORTEN_IDS);
-
-	append_todo_help(flags & TODO_LIST_KEEP_EMPTY, command_count,
-			 shortrevisions, shortonto, buf);
-
-	if (write_message(buf->buf, buf->len, todo_file, 0))
-		return error_errno(_("could not write '%s'"), todo_file);
-
-	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
-		return error(_("could not copy '%s' to '%s'."), todo_file,
-			     rebase_path_todo_backup());
-
-	if (launch_sequence_editor(todo_file, &new_todo.buf, NULL)) {
+	res = edit_todo_list(todo_list, &new_todo, flags,
+			     command_count, shortrevisions, shortonto);
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
@@ -4668,8 +4657,6 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return -1;
 	}
 
-	todo_list_transform(&new_todo, flags & ~(TODO_LIST_SHORTEN_IDS));
-
 	if (opts->allow_ff && skip_unnecessary_picks(&new_todo, &oid)) {
 		todo_list_release(&new_todo);
 		return error(_("could not skip unnecessary pick commands"));
-- 
2.19.1

