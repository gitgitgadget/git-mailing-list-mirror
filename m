Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C4D1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKKGEV (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:04:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41207 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKKGEV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id d29so7344799plj.8
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 22:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7bx7No5ny48AlPXWaDEH3I4QXKUiiPGhgj61jJxGBY=;
        b=VSCPzYtvXbNf4fvTOLtHV7zRRxHhsFjXk9wmFmZv8OAxYLpi6GLDA8EWzWtkSks8B9
         4HVqavzItHhIYDgG0aG7Erxrj+9EEHJ4/LzFeHOvDu4MbjzX0PJylP4uDyrEJMz91k8a
         8QwFIg6VUoPG7UszEx7Za2G04hOlZe/sN4XaCCSdGEo3FVZrDHFsBrkBKvSrGgEmQABW
         WwfCtpEIY1RnNKvw/BTyXNXNLsVoJf6AdvVy+llSDn8nG3i/KsikYdVrZ+Sy1djfxXdO
         T8Tit89TdElW25t9v3gPeNdBS5xyQBBO53pW/hu9NoqdsYTitneFa7VfGpEE6WgI6UQK
         d5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7bx7No5ny48AlPXWaDEH3I4QXKUiiPGhgj61jJxGBY=;
        b=AS+Bcbe/T0QYX/jgKtcLeMkdnmWUcYXHfoDVDo8915tHiaN5xh+YsTrtIbGbcvX5fz
         QN2sLwshPvn+wiKOqadtYzbCKPFmeZKnHE/M1PyabyAIqt7ELRhqsATpggWitGUQit2M
         2ZOVC1qLxdcRZohtFRTD1kQ+W/01hj3LS+0laeaFr2k6OOqp/RWFIqsNdfb1jTPnXc2r
         5sDyhl3rDfsJ4WYkyWIIv8YlNwfCGHYLwi2xUM8uOkRkhjbtxN4719z+6qnQhCeL7QUV
         dZzw4okTj98Wzd1W6JNMEcEAA3Yn0wPsiEE/I/ED9g5B5mgFJa0HNzza+XImV+lB71eL
         Uc+w==
X-Gm-Message-State: APjAAAX/CNiI8Wpat229OtyIX2E5ea7mKeZqNtBJ0zzcpQMoI1s8xaiM
        TwOr1qhCNI5yizD7PrrYWx5ULsKk
X-Google-Smtp-Source: APXvYqzh2d86VhrW9Yyot1MGNUcFgtbdHhmXh30y1Wu949HPGnx+gz+UBy5HSYa610pqQntbh3IIjA==
X-Received: by 2002:a17:902:fe91:: with SMTP id x17mr23562547plm.141.1573452259972;
        Sun, 10 Nov 2019 22:04:19 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id v16sm15112315pje.1.2019.11.10.22.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:04:19 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v6 5/9] sequencer: reencode revert/cherry-pick's todo list
Date:   Mon, 11 Nov 2019 13:03:38 +0700
Message-Id: <23f9de4527a15e1b4b0e9ee32e5603d970a9c3b2.1573452046.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.164.g78daf050de.dirty
In-Reply-To: <cover.1573452046.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573452046.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep revert/cherry-pick's todo list in line with rebase todo list.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 05403a9005..6ab1bba39d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2562,14 +2562,17 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	enum todo_command command = opts->action == REPLAY_PICK ?
 		TODO_PICK : TODO_REVERT;
 	const char *command_string = todo_command_info[command].str;
+	const char *encoding;
 	struct commit *commit;
 
 	if (prepare_revs(opts))
 		return -1;
 
+	encoding = get_log_output_encoding();
+
 	while ((commit = get_revision(opts->revs))) {
 		struct todo_item *item = append_new_todo(todo_list);
-		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
 		const char *subject;
 		int subject_len;
 
-- 
2.24.0.164.g78daf050de.dirty

