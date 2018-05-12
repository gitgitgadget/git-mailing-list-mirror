Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAEDF1F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeELIBE (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:01:04 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43282 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeELIAk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:40 -0400
Received: by mail-lf0-f68.google.com with SMTP id n18-v6so4585963lfh.10
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OEVUNicisU92Mpr8PicCTpQxDXU/BsBeran034vMCq4=;
        b=V1tGmtav4RbEb9vgDeQbGK3+kWykhvP9Qqa4eqwEHQTOw171koWtLbB48PyhxWribW
         qtBqiCFi8oHUvdoDvJlfzm80XG/IwD46O1l+R3prBYxvlL7BlDUQBjNAaPfeIeg6V57a
         zuTwaj45FIagBtjsBAqAFNt6TCIx4CrxJoYlxHIIR+DcCHTDOFqtrbF3VQkqXJLfZPvy
         DwdnrGWgP1OEhtNdSBOXjjbFMFyscsn0wKnVIb2RzkkYODOLzf1vslk6H1AX7cuE2gLc
         lvsmz2RY0C294Iypbpj3IFBoUJdckVdF7oDN7TQhG+Dx5JCIlWeerEo2edjGVvzhutzx
         3TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OEVUNicisU92Mpr8PicCTpQxDXU/BsBeran034vMCq4=;
        b=sH7asBlxaRsnR7r1k1A547nBHrbp6hU3zQaJPKpqXiuW15aRk5tI8L0I3aIyYskSxO
         5CbkgNSfVg0rHvyLRKzfk9f1c54VW/DqusCeWD/Qu6C7hFAEqiqYakp/vLfvv8IyNyFh
         enxhmUC7bpzY/Y2W01N2au0fZC7dqw6Q4r5hZLkwJ+6hYaB87bEezmoBzyqkCrNlvpVT
         4SC7SZDj/f4co4l1zK9hfWv1J1oy2gSDbduJAyhXXs+jaaSA90I5FmMp2Xgn1zOPRkgz
         3BT2HUHcktF95dOBkokbwIsdmao4iedjRdIbdRO5dCJXXq5MjXgD8ENZhK2Ah2rbwmI5
         07zA==
X-Gm-Message-State: ALKqPwfRL14C0k3LavS43xbLSoEYESWaXE3Wgg1WVVBExSWoVIieQlub
        I69UE1LPE/1OThNdj4zBhQymJg==
X-Google-Smtp-Source: AB8JxZpeU6qrnpd0jipDTA3NzZ/HRVCjW6DTjLpyDKVm6cyoWFMLre4beak2lhCVQskQDsXKGEvNlA==
X-Received: by 2002:a19:27c2:: with SMTP id n185-v6mr3413994lfn.25.1526112039236;
        Sat, 12 May 2018 01:00:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/12] bisect.c: use commit-slab for commit weight instead of commit->util
Date:   Sat, 12 May 2018 10:00:23 +0200
Message-Id: <20180512080028.29611-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
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

