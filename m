Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3CD20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbdLERxE (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:53:04 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:42753 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbdLERwy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:52:54 -0500
Received: by mail-it0-f66.google.com with SMTP id p139so3620895itb.1
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3NvS3qErWIoJ9z/D6iTaNDqqW2kM0jCshwyPChtmDAk=;
        b=dXyHricOqpYAgFjJG+Ftwv3wDDHGi7pBjJ+0JD0V3lWwL//2vv0n6vpSyBpY3hvDEW
         7TzLBrpACUWY4G3OTTpj7lnzl6daEA/ZETJ+WIp1ah7jep5LolgHfrT0B9Oxnv9i11ij
         bBkY6ZOzqHxm1Uj8a28miHtOkyKutpdYAiKkceZFg3xKsa7t9suZtNMI8oKok5Q2k85m
         +oeNcrhbgAMp6FQitfnl/RQJf9lKSfwI0Ss93F/URSVRdWs779iqOldLmtaUZnj/AuSl
         HHEmwjpmVXDTVLj4Gjgqx1Kens/6y6GP1mOmxGWwx122TFFtIl7SRAM1aR/Wn5D7tbYp
         VrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3NvS3qErWIoJ9z/D6iTaNDqqW2kM0jCshwyPChtmDAk=;
        b=oWcD9JeGVPr9cPLeZMAp0t5jvasG+NFHLJMSV+om6BAUo8hkuzglieQByGhJYJiXUf
         jd7m/y5ivico/TixMAG3WbPqk4hKKxeWEAdbi4vPb458AVNVUmxHJIpAjx4dFihH9RbB
         LmSe23su+JvH0tHiINgZUi6z68Wm7kXpRScq6HNCdOAWcBHpXWHAz+gcgrTiU3RGnNnH
         gJHAGXPTJoEz7RyQtPv6O0F7VKB9jo+jWT6RmS9O6zcXt5LaN/j8XSDX5OQyD0Vi2l34
         ZfPt0LNYugZjfRLqVvtD8vHumlEUaujqdY/7M55Cdq9q/sSYXabsFOT4edYtszQMIqHy
         4QAA==
X-Gm-Message-State: AKGB3mJsvERYo0gwhMyFYg7dlWDOhJuJycwniGxijKWXK0Z3BfEIafmJ
        gIFQZ0xGbsCpdckZi37u/U0Y1xmHhQE=
X-Google-Smtp-Source: AGs4zMZfG1RzByvkJoenSprtN6E8mOLV/l+5d4ktvLhV46DF2fmkq0mvdDGXRa3L48wwL18UZ9A2Kg==
X-Received: by 10.107.52.140 with SMTP id b134mr1159886ioa.291.1512496373786;
        Tue, 05 Dec 2017 09:52:53 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i195sm264737ioi.44.2017.12.05.09.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:52:53 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 5/9] rebase -i: replace reference to sha1 with oid
Date:   Tue,  5 Dec 2017 12:52:31 -0500
Message-Id: <20171205175235.32319-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.gbdce6e0789cb
In-Reply-To: <20171205175235.32319-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171205175235.32319-1-liambeguin@gmail.com>
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
index 8ad4779d1650..c3b8e4d401f8 100644
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
 		return !!transform_todos(1);
-	if (command == EXPAND_SHA1S && argc == 1)
+	if (command == EXPAND_OIDS && argc == 1)
 		return !!transform_todos(0);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
-- 
2.15.1.280.g10402c1f5b5c

