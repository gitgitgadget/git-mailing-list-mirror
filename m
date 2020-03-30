Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D266C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FE520675
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 12:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXuBMcTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgC3Mnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:43:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38117 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgC3Mnl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 08:43:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so21423100wrv.5
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7zMnJZf3Mk6iE1dfTseoJMVNZQ6Y1co2wnq/rJfkuY=;
        b=PXuBMcTr8y1u+ndEWJwDz0Z52QBFZySk8bIeJkf06Er0bs49mhK1GpqtiUFVGMparO
         Ox0KAzHBUGXqkGy8wU0yRRIoOkJ+Pk8bWNL7ma4d6KW9xqMIAGI1cQq1PNIuE1114d2Y
         15AyqL2TaQcxqA5d3Nx3dtzinLU5Wk5K+DyfNz1qoR82hj45A+msPrv4ddbIR4Y6Q6xI
         EMqWNVg4U1xc63TG5jCjPOq+N+WAL89gWYTFPPe9aVxysxxZe+LPAP7xchv4TVoEf8x7
         VWmpGXfdyDHBDl8ceueveg4gYbTAIKVHxMJFBWoIrSazDjZlQA3HJSNzcg5qYC91GVC2
         a1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7zMnJZf3Mk6iE1dfTseoJMVNZQ6Y1co2wnq/rJfkuY=;
        b=YrMySdhrXDy+chUG0L+U/+3TpKWnCqLxu/PE8GkiEa0vLZ9mipuifH1EcnvvS6zpGs
         79hZPL4ZO0W00a+tOIO9ylFbZzdFI0dU5F/TXw2pNa7lI73pvjjq2MiBUA2eC3nINoM7
         kGtdW5s/7mrpRUu5EQmwAO1eA3T5TAMRZF/GJaRnpieN4tHkFdW0nJQ43BUzCpogp7jb
         9xAgyCs7aSIm0EoXNR4UThBTY4E6dXXS+0nMAL2gbmhk7Aye6YeyTCTcV9F04lqQ6tpz
         fI8ttAK/wR/8GrbnUxmocVy699EK5NSsHdaNC9wvhcQOhe84JMLHsYDVDMgfsOsKp5Gh
         G4Sw==
X-Gm-Message-State: ANhLgQ3OUYXRhSTplQSw+IAzl5uybwM6WxgOLePO5Z+he+/bRvdRYUxS
        niPI+ueG1OQsQ+OQsJkbsl7OMTKw
X-Google-Smtp-Source: ADFU+vtuSr6JWQYfXa8bicZSfs9QsumoEXZwAlX82Jf5vpRatBeB0Q43QxlHTpwycH8AHo61bDx+mA==
X-Received: by 2002:adf:ff81:: with SMTP id j1mr14541045wrr.171.1585572218994;
        Mon, 30 Mar 2020 05:43:38 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-428-45.w2-6.abo.wanadoo.fr. [2.6.211.45])
        by smtp.googlemail.com with ESMTPSA id 9sm20228480wmm.6.2020.03.30.05.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 05:43:38 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>, jan.steffens@gmail.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1 1/2] sequencer: don't abbreviate a command if it doesn't have a short form
Date:   Mon, 30 Mar 2020 14:42:35 +0200
Message-Id: <20200330124236.6716-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200330124236.6716-1-alban.gruin@gmail.com>
References: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
 <20200330124236.6716-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the sequencer is requested to abbreviate commands, it will replace
those that does not have a short form (eg. `noop') by a comment mark.
`noop' serves no purpose, except when fast-forwarding (ie. by running
`git rebase').  Removing it will break this command when
`rebase.abbreviateCommands' is set to true.

This changes todo_list_to_strbuf() to check if a command has an actual
short form, and to ignore it if not.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6fd2674632..79d0c5cb2e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1578,7 +1578,7 @@ static const char *command_to_string(const enum todo_command command)
 
 static char command_to_char(const enum todo_command command)
 {
-	if (command < TODO_COMMENT && todo_command_info[command].c)
+	if (command < TODO_COMMENT)
 		return todo_command_info[command].c;
 	return comment_line_char;
 }
@@ -4963,6 +4963,8 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
 		max = num;
 
 	for (item = todo_list->items, i = 0; i < max; i++, item++) {
+		char cmd;
+
 		/* if the item is not a command write it and continue */
 		if (item->command >= TODO_COMMENT) {
 			strbuf_addf(buf, "%.*s\n", item->arg_len,
@@ -4971,8 +4973,9 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
 		}
 
 		/* add command to the buffer */
-		if (flags & TODO_LIST_ABBREVIATE_CMDS)
-			strbuf_addch(buf, command_to_char(item->command));
+		cmd = command_to_char(item->command);
+		if (flags & TODO_LIST_ABBREVIATE_CMDS && cmd)
+			strbuf_addch(buf, cmd);
 		else
 			strbuf_addstr(buf, command_to_string(item->command));
 
-- 
2.25.0

