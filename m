Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480551F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeESF2v (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:28:51 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:46395 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeESF2q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:46 -0400
Received: by mail-lf0-f42.google.com with SMTP id z27-v6so708667lfg.13
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oz50BMGSI+DRefU5lBQkJIWsPsYFU/nfZCYSZN9SniA=;
        b=P2OLltcdoEChjSv972szJEQsbCIBY2GkJH0X/u03GUJRsAE38gwpNuKkJmMUeNTZaQ
         9NIXSh+klIYHN6LImrY/PZL9XmMH2gkZ6gwnoiA4KsjSH02KTLtT99uGWlubSpJzBOFF
         7hgSKm5580orMsx/xV1zCSWMMIDCY6LZOEU9dOI3/sQul0UUpmZBVTHgyv3ULWUUstOc
         FVAOnALYftaL1N9E7loorAX+z3NGvdDmMGg/TS39PuvBlChKeIth3hhuuzYYrPpY1/4x
         Bd5+Q7qqq6Gu9rcQfmTixkeaXomWOhFhbcrFIpd1SxY/aJsmlHQZ93SB12f/7/muGUfv
         pE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oz50BMGSI+DRefU5lBQkJIWsPsYFU/nfZCYSZN9SniA=;
        b=f7b7SwNCb30d0fUubY6G8xp0MSQJXAVuXsbtEk8ZzWokAPHJcDJmeh/p6UgBQOllBE
         +sgPi60zhURYNiRMftA69BkkPAOWT19cffxXN16ULDY9uVsK590MgL3/zmMQL8ZOQeU/
         NtgWm6r81sACmve/78+3k1dahj6aYm8tlQb6+nlN0IeAZkC0G6CGP5+UwZ3jX0LBvA3w
         LpJDpwqkT8/0eNy/l4J8XH5tW8auDxpyRr5pa3X4xkB/BRSKpWhOkn2ydzsGRrAmxQ9W
         Vdt1nRBiAnUdckQsZZHi81GOIuwQmeLaYtpIb+EFEl05Th/kig5+fxJDbi2Zl5TGxGMW
         ADGA==
X-Gm-Message-State: ALKqPweYlXpC2AnKARC/OW4sUf3ivrUHkr8hEWfkL7/0AIIatnSJ/2pG
        ZGqkpSVfqP2Wdn3yMKCvjMs=
X-Google-Smtp-Source: AB8JxZptefrDeS2yQ1F2y4oFAjj3Z9EOKDsZYg/PxiKPhJukZSjniYksvvB/6Ju0MyEEjKlQkTcslA==
X-Received: by 2002:a2e:997:: with SMTP id 145-v6mr7599139ljj.46.1526707725285;
        Fri, 18 May 2018 22:28:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 09/15] bisect.c: use commit-slab for commit weight instead of commit->util
Date:   Sat, 19 May 2018 07:28:25 +0200
Message-Id: <20180519052831.12603-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519052831.12603-1-pclouds@gmail.com>
References: <20180513055208.17952-1-pclouds@gmail.com>
 <20180519052831.12603-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.
---
 bisect.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index a579b50884..6de1abd407 100644
--- a/bisect.c
+++ b/bisect.c
@@ -12,6 +12,7 @@
 #include "bisect.h"
 #include "sha1-array.h"
 #include "argv-array.h"
+#include "commit-slab.h"
 
 static struct oid_array good_revs;
 static struct oid_array skipped_revs;
@@ -70,16 +71,19 @@ static void clear_distance(struct commit_list *list)
 	}
 }
 
+define_commit_slab(commit_weight, int *);
+static struct commit_weight commit_weight;
+
 #define DEBUG_BISECT 0
 
 static inline int weight(struct commit_list *elem)
 {
-	return *((int*)(elem->item->util));
+	return **commit_weight_at(&commit_weight, elem->item);
 }
 
 static inline void weight_set(struct commit_list *elem, int weight)
 {
-	*((int*)(elem->item->util)) = weight;
+	**commit_weight_at(&commit_weight, elem->item) = weight;
 }
 
 static int count_interesting_parents(struct commit *commit)
@@ -265,7 +269,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		struct commit *commit = p->item;
 		unsigned flags = commit->object.flags;
 
-		p->item->util = &weights[n++];
+		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
 		switch (count_interesting_parents(commit)) {
 		case 0:
 			if (!(flags & TREESAME)) {
@@ -372,6 +376,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	int *weights;
 
 	show_list("bisection 2 entry", 0, 0, *commit_list);
+	init_commit_weight(&commit_weight);
 
 	/*
 	 * Count the number of total and tree-changing items on the
@@ -412,6 +417,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	}
 	free(weights);
 	*commit_list = best;
+	clear_commit_weight(&commit_weight);
 }
 
 static int register_ref(const char *refname, const struct object_id *oid,
-- 
2.17.0.705.g3525833791

