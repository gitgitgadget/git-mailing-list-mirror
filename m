Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9590BC433FE
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A11760EE5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbhIWP2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbhIWP15 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 11:27:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4EAC061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 08:26:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so18337458wrg.5
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LuCHhe3n1SwJwMKug383m/LGPGwoTImPL9C5Mtvgz0g=;
        b=mEwQIAjzpwrM00ygbhrtf5gymmTQWM++I/EUWqfBZdayYaD76/6uQB2HNR/3C2/cii
         PJT4ELqGeTHOrmMoQAITAUfSJ0Fz3ngmyTc3OcJPskmqSKw1LDabTBZpw0DJ97c0ipLq
         4W55ifaYSue5aA+m6SabdMQkjeRwo6Bb4PO2FskS/aVb+f3AFslprJFPfvMu0RoIo9c/
         36zLBhZ3LE25w3RK9TFoMsAZLbDgYUyiGps2uY2/6wvXFz+G8ng7eE+tOIjSH3Sb+QUj
         bHGIeJ2t5Lo6HwXmXFWoE383Ec2Il4XMWf7/1PN1xM36P7ANHLmHgL7ZKkvtfD07AWGd
         t2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LuCHhe3n1SwJwMKug383m/LGPGwoTImPL9C5Mtvgz0g=;
        b=5J+H6UXXtiTcH+rs0IS0xEsHFF6HKkl+Bj7KnNPan6PdYXa80ClZJMC0BFTFUmG2sB
         /S3VklYYwQnW1wlh5OvnUGHYDye9jqRCNQOdLpcVp8beuaooZm3AA4S3aiZ/fecddBCB
         JB3bvu3oXPiB3Y4TU4ZnjihV912SAZlsQdWE14DSM8j38AMx4IscrVyC6Aw1SxMWXdRS
         9nYlVnVp8cHG+hjhF3/Gwamu4Zc416LHPAnJiUZ1Txwjn5b1bUgJz+Q2i/vBuiLycrtn
         QZkck8Wtq2rIJQ7nO1ndp1RMn8vk5DUd/zg7UhJtlIfAO/bNByvnum6rd4P+o+P1gIMa
         VBoA==
X-Gm-Message-State: AOAM531A1Uma0oSm+6zIEevxUMb4t0Ig3OPPparbuD/T8JCTK0yf/mUS
        SvNHckJKBxWM9OBl8CIbZa6FLEcOw9k=
X-Google-Smtp-Source: ABdhPJwYsNfqb1sEr0ij/aDEFBrIk4GBKjsMyCYwO06agZ5ujfbUOLXkkvBJvyBN3DfYq3uCSU2N+A==
X-Received: by 2002:a1c:9dd2:: with SMTP id g201mr16422219wme.46.1632410784145;
        Thu, 23 Sep 2021 08:26:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm6140913wrc.55.2021.09.23.08.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:26:23 -0700 (PDT)
Message-Id: <98ebefc140e5ae61cd415b17fb95ee9184520c83.1632410782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1034.v2.git.1632410782.gitgitgadget@gmail.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
        <pull.1034.v2.git.1632410782.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Sep 2021 15:26:20 +0000
Subject: [PATCH v2 1/2] sequencer.c: factor out a function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This code is heavily indented and obscures the high level logic within
the loop. Let's move it to its own function before modifying it in the
next commit. Note that there is a subtle change in behavior if the
todo list cannot be reread. Previously todo_list->current was
incremented before returning, now it returns immediately.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3f..a248c886c27 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4254,6 +4254,27 @@ static int stopped_at_head(struct repository *r)
 
 }
 
+static int reread_todo_if_changed(struct repository *r,
+				  struct todo_list *todo_list,
+				  struct replay_opts *opts)
+{
+	struct stat st;
+
+	if (stat(get_todo_path(opts), &st)) {
+		return error_errno(_("could not stat '%s'"),
+				   get_todo_path(opts));
+	} else if (match_stat_data(&todo_list->stat, &st)) {
+		/* Reread the todo file if it has changed. */
+		todo_list_release(todo_list);
+		if (read_populate_todo(r, todo_list, opts))
+			return -1; /* message was printed */
+		/* `current` will be incremented on return */
+		todo_list->current = -1;
+	}
+
+	return 0;
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
@@ -4433,20 +4454,9 @@ static int pick_commits(struct repository *r,
 							item->commit,
 							arg, item->arg_len,
 							opts, res, 0);
-		} else if (is_rebase_i(opts) && check_todo && !res) {
-			struct stat st;
-
-			if (stat(get_todo_path(opts), &st)) {
-				res = error_errno(_("could not stat '%s'"),
-						  get_todo_path(opts));
-			} else if (match_stat_data(&todo_list->stat, &st)) {
-				/* Reread the todo file if it has changed. */
-				todo_list_release(todo_list);
-				if (read_populate_todo(r, todo_list, opts))
-					res = -1; /* message was printed */
-				/* `current` will be incremented below */
-				todo_list->current = -1;
-			}
+		} else if (is_rebase_i(opts) && check_todo && !res &&
+			   reread_todo_if_changed(r, todo_list, opts)) {
+			return -1;
 		}
 
 		todo_list->current++;
-- 
gitgitgadget

