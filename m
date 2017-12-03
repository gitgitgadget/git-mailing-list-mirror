Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41BC220C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbdLCWSI (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:18:08 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:37617 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbdLCWSD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:18:03 -0500
Received: by mail-it0-f67.google.com with SMTP id d137so2269365itc.2
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 14:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xeqTKt7s/N6+a6+7smQzS3TMxx+oSNMNDHIPZsPVwqI=;
        b=kp5qiVo39QSUOunsJzBPz7xkOUdEY9S5u+09ZUoCb1GizRBhg9etJspr0YPj9yvxMU
         ldXPo0v8rEdRJ3bAzJVVCZsRgdS4l1T3jh9LPaAfrg3pnABEvzHwpA5M1Fp6KD9DA3oV
         uVqhejWPyiETRTq8uzmTZLT1evx8mmii6ytIr94cBdEUBKjI3TdIQ1RyjmK4EXujEhqi
         1Hvp7ABtyG7v4tDF1qx+327gOJdBdDRbWvyctS3i6gfKevZs1z0nOf9lNoPCjgyf1WDI
         zDg0eXl8OFWtdLWlXbDvKhuIHDUCZRR9CQM7c7C1gawPVHcwJlZ0FHEyIYTvHGNeslf6
         xBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xeqTKt7s/N6+a6+7smQzS3TMxx+oSNMNDHIPZsPVwqI=;
        b=DYydR9edJShjo95ADS4Oj2TVGwH/VvD1qNOHtUk4CBqSxnoA8WjKoMwdTHKAFJ247P
         dxfzadd6C+CtX2G84vqlKOm3N+ttbwUs+LUNLBbpH4IMlVj67bfoDZBRgMEmSPYuq1eb
         ZwDvQeBZx4LApp333m2yMrvXrD6AGNNBUZMNay5VpzUozcsmoIFXs86xbQQBDFU9X6kG
         7rSh+mN2L/o9Sb0gn+yTsdnfJ3mphLFwmcFbw7VpYQyexz9iPYHNw+R7KLwkFzieBRtb
         2FhSHV3frJRu9pwQVqgiL2q71SM3OeVgEzMNmgp6XaDrRGZJkQ5HJ8FAvLcyJR57KA0l
         8btw==
X-Gm-Message-State: AJaThX5yRKiwYOuGN4ULEqv/IXm0s9c1vpfcVa1ioULad/n97iewrZ8P
        hl4hGmA51wpcL92mOyyvcTq+0AT2
X-Google-Smtp-Source: AGs4zMYFVEpoUZ3ME2rkuOD1hcMuGIV+rfJzu2yTZbgfoB11QpaGRCVOsdXpwUI2gwzTdkeIIuF03g==
X-Received: by 10.107.164.225 with SMTP id d94mr20957836ioj.175.1512339482110;
        Sun, 03 Dec 2017 14:18:02 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm5207054ioe.13.2017.12.03.14.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 14:18:01 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 5/9] rebase -i: replace reference to sha1 with oid
Date:   Sun,  3 Dec 2017 17:17:17 -0500
Message-Id: <20171203221721.16462-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.g10402c1f5b5c
In-Reply-To: <20171203221721.16462-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we are trying to abstract the hash function name elsewhere in the
code base, lets use OID instead of SHA-1 in the rebase--helper too.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 builtin/rebase--helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 7c06a27de821..af0f91164fd0 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -14,7 +14,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int keep_empty = 0;
 	enum {
-		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S,
+		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH
 	} command = 0;
 	struct option options[] = {
@@ -27,9 +27,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "make-script", &command,
 			N_("make rebase script"), MAKE_SCRIPT),
 		OPT_CMDMODE(0, "shorten-ids", &command,
-			N_("shorten SHA-1s in the todo list"), SHORTEN_SHA1S),
+			N_("shorten commit ids in the todo list"), SHORTEN_OIDS),
 		OPT_CMDMODE(0, "expand-ids", &command,
-			N_("expand SHA-1s in the todo list"), EXPAND_SHA1S),
+			N_("expand commit ids in the todo list"), EXPAND_OIDS),
 		OPT_CMDMODE(0, "check-todo-list", &command,
 			N_("check the todo list"), CHECK_TODO_LIST),
 		OPT_CMDMODE(0, "skip-unnecessary-picks", &command,
@@ -54,9 +54,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!sequencer_remove_state(&opts);
 	if (command == MAKE_SCRIPT && argc > 1)
 		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
-	if (command == SHORTEN_SHA1S && argc == 1)
+	if (command == SHORTEN_OIDS && argc == 1)
 		return !!transform_todo_insn(1);
-	if (command == EXPAND_SHA1S && argc == 1)
+	if (command == EXPAND_OIDS && argc == 1)
 		return !!transform_todo_insn(0);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
-- 
2.15.1.280.g10402c1f5b5c

