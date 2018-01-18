Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F361FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 18:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755948AbeARSgg (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 13:36:36 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:44419 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755712AbeARSgb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 13:36:31 -0500
Received: by mail-pf0-f172.google.com with SMTP id m26so15315320pfj.11
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 10:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tMkZnu7S+Ybhx6q7vykcPVMSbNzNJVmFF3bv9ukTbfw=;
        b=s3VShe4D42ovP7MsHuilDodSBCxKNuHjPNvvUbyhBCb24tp75seFLU/hf34XVbI57v
         5dt7+csEHx1Le36UUjjK7v+nVHNqxM9c0cZ+hfiBtxipuM/q/CSl2/qMdJ4LvUddbDfp
         MxSkwywac2D3PkyeCbYlRMpMvTYKZwt8d5FV3wcrHXNDGz/ADOElQnHtaEKBRUJIHR5X
         71Y22Tf52Iv0e6x1Nhamj57ZAoT1JrsHWoSyy19iUdq20VRG4fewWp0X3f/AEmccfkWj
         cVa4+1LT0e22CsygCNvpG0os93aD66vWWFqcsGtUNePVo3cewMPDE3BmvXxlzzREs0rv
         T2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tMkZnu7S+Ybhx6q7vykcPVMSbNzNJVmFF3bv9ukTbfw=;
        b=j59I7YnAKB7VxMY/YYKPJ9DD/Pvz1TPUCFMnd4QWX9oSgezjo7FUnTPPO6A3zoO1Mc
         ugFqjV4Jz/b3cQFPDvYp+63PgOXTpdwH9uFNqXeqP4oZVu31HLkmHNlxk6sSQ5DbOU4R
         hWah3gjNjBaDRmU/9gUU0EQK4mqPGqrOs5MVia6geXfTFliHF68OTUSs77TJCMZOxMlG
         7U4szwYY9sET3Q7BmW5Ts1rAKlHoz5Ma+CjKYpG1a8dfk1QRQav6wHPwkdJngFm1loNB
         BKu0VzlF1CcLhLOWp7axmxYgTFProId7Vvsoi78/s4VG6j84lu+M43ygHvHQHIv7CJMo
         GeQA==
X-Gm-Message-State: AKGB3mIrqScT91UfIvqpzkJ8WHAbI/SNTilCkIpwmImrcSH27CYQom/v
        q5gHJ9AU1YYw7cFVSXPA/eniaQ==
X-Google-Smtp-Source: ACJfBosnopV8Hm5S0+N99oWs3s+Qfac0cBpOJ5KdPj4iKoL7YUK/iEZiuWwLR9OG0cAe3NY2YMAxXQ==
X-Received: by 10.101.72.70 with SMTP id i6mr38547729pgs.9.1516300590602;
        Thu, 18 Jan 2018 10:36:30 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t71sm15610377pfg.115.2018.01.18.10.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 10:36:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/8] [DO NOT APPLY, but improve?] rebase--interactive: introduce "stop" command
Date:   Thu, 18 Jan 2018 10:36:18 -0800
Message-Id: <20180118183618.39853-3-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180118183618.39853-1-sbeller@google.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <20180118183618.39853-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jake suggested using "x false" instead of "edit" for some corner cases.

I do prefer using "x false" for all kinds of things such as stopping
before a commit (edit only let's you stop after a commit), and the
knowledge that "x false" does the least amount of actions behind my back.

We should have that command as well, maybe?

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-rebase--interactive.sh |  1 +
 sequencer.c                | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3cd7446d0b..9eac53f0c5 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -166,6 +166,7 @@ l, label <label>= label current HEAD with a name
 t, reset <label> = reset HEAD to a label
 b, bud = reset HEAD to the revision labeled 'onto', no arguments
 m, merge [<label-or-commit>]* = create a merge commit using a given commit's message
+y, stay = stop for  shortcut for
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
diff --git a/sequencer.c b/sequencer.c
index 2b4e6b1232..4b3b9fe59d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -782,6 +782,7 @@ enum todo_command {
 	TODO_RESET,
 	TODO_BUD,
 	TODO_MERGE,
+	TODO_STOP,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
@@ -803,6 +804,7 @@ static struct {
 	{ 'l', "label" },
 	{ 't', "reset" },
 	{ 'b', "bud" },
+	{ 'y', "stay" },
 	{ 'm', "merge" },
 	{ 0,   "noop" },
 	{ 'd', "drop" },
@@ -1307,6 +1309,12 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return 0;
 	}
 
+	if (item->command == TODO_STOP) {
+		item->commit = NULL;
+		item->arg = "";
+		item->arg_len = 0;
+	}
+
 	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
 	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
 	item->arg_len = (int)(eol - item->arg);
@@ -2407,6 +2415,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				/* `current` will be incremented below */
 				todo_list->current = -1;
 			}
+		} else if (item->command == TODO_STOP) {
+			todo_list->current = -1;
 		} else if (item->command == TODO_LABEL)
 			res = do_label(item->arg, item->arg_len);
 		else if (item->command == TODO_RESET)
-- 
2.16.0.rc1.238.g530d649a79-goog

