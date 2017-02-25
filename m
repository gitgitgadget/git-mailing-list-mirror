Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85DC92022D
	for <e@80x24.org>; Sat, 25 Feb 2017 07:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdBYHcS (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 02:32:18 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35055 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdBYHcR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 02:32:17 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so5904587pgz.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 23:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qydMrluMTq6MKFE5lLXU7N1NSY2ksosB24NZf5QOAm0=;
        b=pin+eRWhfHa7EG6qaWTW/IZTqh9pp8AwT/cBiCDOa/8dGNaBan7OZsR1DIsyTFD0ZE
         dvvvc+jsqju0AdtL+1Pdl3vM95wClQulRWgXcrMh/3AU6kMYCcpqY+RyxD9yoX6pmoh8
         vj5XlhdLO2mdkkxU1q4ytaw58Xp3lcgR/Z0ObVlZC9Eu9sU7Q0e/2rGbY+KqjtoyCSOh
         wItRqTpTJcxOzzPEGJUIB03qE4SDHbcEQClcXPmZovEbSU0qAZ/JQ3Agzq2FHbdGqPo6
         RnQSDPa3ssXnoM6MuVO19CzOJbj/rnNphjk5kvE5AIOjA2VjSBfI1BXAVS4Zu8QaYpH8
         WCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qydMrluMTq6MKFE5lLXU7N1NSY2ksosB24NZf5QOAm0=;
        b=T2eqCJMmPUk87SsZtGZqMylkRJ9UrMyoV4ac1dNbA8l40S6BJIHTmWvSWEjrJ9huIM
         gYNNE3HKVOOIt75jZSxO7YWLsF/cWlJGvA7rA1jFt1CG9xgVpKjwS1xkz9BygKoASd3o
         Zo2bs2wcWGI76HvZ+tTCJUGQIa3TizmKY8orH66i5kUmoWQy1h4/PeDSc8IRXj4HEHSb
         Q54ovHaeofr0Zbi3B7EMf7GWvXT+f6uxwK09mXrI+OXbgYxtjIqWTsvGWw6AxJzFzdpT
         sAbjBsGYlWzILX4Uu3WR3ig0sQu7dDYSWQHX6Qb+Z739jrvRS/X/FeeybPz09+tB3gYq
         UjYw==
X-Gm-Message-State: AMke39kIH2S95mZ6Sfr9mH9LePDU+tZp+zIHehgquc7Seaju7wMFJndZFugRllC5nipRvQ==
X-Received: by 10.84.218.78 with SMTP id f14mr9501653plm.146.1488007926054;
        Fri, 24 Feb 2017 23:32:06 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id q7sm18680789pfb.98.2017.02.24.23.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 23:32:05 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 1/6 v5] revision.c: do not update argv with unknown option
Date:   Sat, 25 Feb 2017 07:32:01 +0000
Message-Id: <1488007921-13432-1-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

handle_revision_opt() tries to recognize and handle the given argument. If an
option was unknown to it, it used to add the option to unkv[(*unkc)++].  This
increment of unkc causes the variable in the caller to change.

Teach handle_revision_opt to not update unknown arguments inside unkc anymore.
This is now the responsibility of the caller.

There are two callers of this function:

1. setup_revision: Changes have been made so that setup_revision will now
update the unknown option in argv

2. parse_revision_opt: No changes are required here. This function throws an
error whenever the option provided as argument was unknown to
handle_revision_opt().

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
 revision.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index b37dbec..5674a9a 100644
--- a/revision.c
+++ b/revision.c
@@ -2016,8 +2016,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->ignore_missing = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
-		if (!opts)
-			unkv[(*unkc)++] = arg;
 		return opts;
 	}
 	if (revs->graph && revs->track_linear)
@@ -2234,6 +2232,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
+			/* arg is an unknown option */
+			argv[left++] = arg;
 			continue;
 		}
 
-- 
2.1.4

