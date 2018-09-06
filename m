Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD231F404
	for <e@80x24.org>; Thu,  6 Sep 2018 15:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbeIFTtq (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 15:49:46 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:46848 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbeIFTtp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 15:49:45 -0400
Received: by mail-qk1-f182.google.com with SMTP id j7-v6so7531288qkd.13
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jhthZjT4+PJiiKm6ONkpGulGD0sJwGIRV55BJY720x8=;
        b=ZdiNTPq03SSyUSjqiieIC8wMcPTzSgC37IJOZm2YzfQe1WfJe83Hhaeng5m6/b1aDL
         dciMBuFureO0sV0XPzAI9L4gplTmhqwmaaQEzz9fOdBX92QFA/QwVr/8Vqy6pycSE98n
         m6CVsAQAS/fKiv5UsgF/cNC/T3tBiBaJRnSI86HG0CY2BuAa5knBy+qchncSxXnP3Lzm
         8ba3YcuG7J7C5TXN26AQhWGCN2CdNAw5TFHnbuUGKXQl80ce+OWEnJE52ApU7dP8r1l/
         LxqnQFr2+9vWCQJh83JDcDmZvNrvjBdY7N+y2Pr89Pr4yXUcPZMqL3VF9kbnuk5Y2AOR
         +tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jhthZjT4+PJiiKm6ONkpGulGD0sJwGIRV55BJY720x8=;
        b=tEGtUHJ2H3+FL227f5jIVqMgKSeKaNu/JlcvJGjoZZRSlKxPqcUDmxmbXXZew2HMCW
         iSN9q9o70xFeFttj1Adg2wJ3mQxooew758h2rsdZ9VAXtcBmhRE9WmieGJMa0lfme/XZ
         +2VTj/pv69++Fy+z2BQD0lG1wpZ+Z8WGYyq9veC+Uca0H2mg8QEmDChHgN/9c+ZEhaok
         t2EJt82mHPYKzvc40wW6hb/HVazLdy9cny1c2V9Olnhaut0vJo78Ei9mNZtwx9gMyCqK
         bisEq0GeOxGNdmvg6MsWXka4E6N83aPjXCH8YRg/yaENpBulD4N7r7+VKcq46dQUl0v3
         hC8w==
X-Gm-Message-State: APzg51Bf02QCFrBFypaP7etW2KKsWTIPC5z/vo0ZrLllnlyUp+EIIc00
        JMAWdGLuCD05MejlUTcGLSVho2Mh
X-Google-Smtp-Source: ANB0Vdao4q7pokqAWW7qNtxSXxv8q6b0BYbv5ijTXx/5pOwqvzPTS5g3qTqZOsOBIGTtI+ct0dZxOg==
X-Received: by 2002:a37:c987:: with SMTP id m7-v6mr2482557qkl.324.1536246826511;
        Thu, 06 Sep 2018 08:13:46 -0700 (PDT)
Received: from linux.mshome.net ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id z3-v6sm2752030qkc.55.2018.09.06.08.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:13:40 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 3/6] commit-reach: use trace2 in can_all_from_reach
Date:   Thu,  6 Sep 2018 15:13:06 +0000
Message-Id: <20180906151309.66712-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906151309.66712-1-dstolee@microsoft.com>
References: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
 <20180906151309.66712-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 0fc3b1ac18..0a75644653 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -563,6 +563,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 	struct commit **list = NULL;
 	int i;
 	int result = 1;
+	uint32_t num_walked = 0;
 
 	ALLOC_ARRAY(list, from->nr);
 	for (i = 0; i < from->nr; i++) {
@@ -573,6 +574,8 @@ int can_all_from_reach_with_flag(struct object_array *from,
 			return 0;
 	}
 
+	trace2_region_enter("can_all_from_reach_with_flag");
+
 	QSORT(list, from->nr, compare_commits_by_gen);
 
 	for (i = 0; i < from->nr; i++) {
@@ -590,6 +593,8 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				continue;
 			}
 
+			num_walked++;
+
 			for (parent = stack->item->parents; parent; parent = parent->next) {
 				if (parent->item->object.flags & (with_flag | RESULT))
 					stack->item->object.flags |= RESULT;
@@ -622,6 +627,9 @@ int can_all_from_reach_with_flag(struct object_array *from,
 		clear_commit_marks(list[i], RESULT);
 		clear_commit_marks(list[i], assign_flag);
 	}
+
+	trace2_data_intmax("can_all_from_reach_with_flag", "num_walked", num_walked);
+	trace2_region_leave("can_all_from_reach_with_flag");
 	return result;
 }
 
-- 
2.19.0.rc2

