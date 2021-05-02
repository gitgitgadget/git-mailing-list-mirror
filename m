Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849A5C433B4
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8EB613ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhEBFQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 01:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhEBFQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 01:16:25 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C567C06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 22:15:34 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h6so1553866ila.7
        for <git@vger.kernel.org>; Sat, 01 May 2021 22:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qm6xNTVqmlhl6hXzyyoOvfVrc6ueRiPJVsuRHmnxag=;
        b=A+ZGOtZEkHVedJyA1yCkGSivT0cAx8npwjVp2pTuo+DCrlbNJiW29MNrjSaHmI2qUs
         qFOXI5wDgYeqe0Oh/BrPaq62Xem0yL91OhjYfbQVlC9WEV1oLH7NMYQ9YD8XtZ0jmJ2K
         pDpN/55gOiQwmhI/XLjPX6BiXWZ3udNwID/uGxruv4SGDWW7r8OG0VExUUimF0cQNGpx
         HMAlMZCxuGK68ssuB24UWO7ClVF95PA6fVagXnjUo02emLm4qj8dUcg65c/ij1LyJin1
         HHqiKilwYBjtYUA18QL4k6aZVyM3Fw4bcTELda++0sv/lkBX29rJWVOiEwMFG/6ke9Qw
         Sg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6qm6xNTVqmlhl6hXzyyoOvfVrc6ueRiPJVsuRHmnxag=;
        b=QYT4OvKzskApPjdlvSdzaE7/CpdRyQ7uDFUcqkFTdJHUqSXm+XXlrXEwsSx7Ew4zbr
         bfGR9tr8AG2zMm1c6KD3QU5Ms62yfuSd18cTJXp+Au2cHUV4orOELHGslk8qThpQZ5Oo
         ZB+4Jd56u5XMWrc8xnR9IPwNa7i1v1V6gIENFovjqiTxBcoaQXrBjBQii82TdZiYCx6y
         Kti+qzQMFvSaWD9LgUYMQ50y5JsCsjwY4NOrBINIn4Tr6+maabIC5S4xXW9ZFvtBIr44
         oHBIIMB9NVD8SR/o4Xbdf4z7PT48+1fEYhjVckCruqalik0agDDMnvGIYZGyzywx9r6M
         LAzQ==
X-Gm-Message-State: AOAM530UKvSXNJAzOOx++sdiBrhEtdDJRH0eE/kipuVhtDpTCjp3axDz
        wWQ5G243lcwOFLCgaf6G/nx/6tB9oNxJRQ==
X-Google-Smtp-Source: ABdhPJwI+M+BcsJqlyHl75yQoomkrfgRSnGG/eaKgxq6YTrNAo7hTl2JrQq4S7M9/O1KBj8Wfc45zg==
X-Received: by 2002:a92:3307:: with SMTP id a7mr10646060ilf.113.1619932533126;
        Sat, 01 May 2021 22:15:33 -0700 (PDT)
Received: from localhost.localdomain (097-070-162-226.res.spectrum.com. [97.70.162.226])
        by smtp.gmail.com with ESMTPSA id e12sm2134049ilu.75.2021.05.01.22.15.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 May 2021 22:15:32 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 2/2] merge: fix swapped "up to date" message components
Date:   Sun,  2 May 2021 01:14:23 -0400
Message-Id: <20210502051423.48123-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459
In-Reply-To: <20210502051423.48123-1-sunshine@sunshineco.com>
References: <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
 <20210502051423.48123-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Soref <jsoref@gmail.com>

The rewrite of git-merge from shell to C in 1c7b76be7d (Build in merge,
2008-07-07) accidentally transformed the message:

    Already up-to-date. (nothing to squash)

to:

    (nothing to squash)Already up-to-date.

due to reversed printf() arguments. This problem has gone unnoticed
despite being touched over the years by 7f87aff22c (Teach/Fix pull/fetch
-q/-v options, 2008-11-15) and bacec47845 (i18n: git-merge basic
messages, 2011-02-22), and tangentially by bef4830e88 (i18n: merge: mark
messages for translation, 2016-06-17) and 7560f547e6 (treewide: correct
several "up-to-date" to "up to date", 2017-08-23).

Fix it by restoring the message to its intended order. While at it, help
translators out by avoiding "sentence Lego".

[es: rewrote commit message]

Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Josh Soref <jsoref@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/merge.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3472a0ce3b..eddb8ae70d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -393,10 +393,14 @@ static void restore_state(const struct object_id *head,
 }
 
 /* This is called when no merge was necessary. */
-static void finish_up_to_date(const char *msg)
+static void finish_up_to_date(void)
 {
-	if (verbosity >= 0)
-		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
+	if (verbosity >= 0) {
+		if (squash)
+			puts(_("Already up to date. (nothing to squash)"));
+		else
+			puts(_("Already up to date."));
+	}
 	remove_merge_branch_state(the_repository);
 }
 
@@ -1522,7 +1526,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * If head can reach all the merge then we are up to date.
 		 * but first the most common case of merging one remote.
 		 */
-		finish_up_to_date(_("Already up to date."));
+		finish_up_to_date();
 		goto done;
 	} else if (fast_forward != FF_NO && !remoteheads->next &&
 			!common->next &&
@@ -1610,7 +1614,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			}
 		}
 		if (up_to_date) {
-			finish_up_to_date(_("Already up to date."));
+			finish_up_to_date();
 			goto done;
 		}
 	}
-- 
2.31.1.607.g51e8a6a459

