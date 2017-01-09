Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F01C1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764023AbdAITqp (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:46:45 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36636 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763765AbdAITqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:46:43 -0500
Received: by mail-pf0-f171.google.com with SMTP id 189so20544545pfu.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 11:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBKVcup3LwUPrvA4J+owpYrxuNm4ZWIxNY7Y5oA+XL4=;
        b=RKKENxgmesborIxRK57MaB9nZes3ES+RzfX6GTWA+3H+wyFdYJQ9NlT+Dm50G0KiZh
         MMdWKAlAnOmKP/fkm5npgPFoY6sZRSIdYr8FQtZ9l+pTOfzqfeqBDddYWYZ0Hnro+hUa
         l0xomRppdR/DBkxPpPkcshXfFnea6As4R5c7J46d+vvWtfZzU9G+bsQKmeYxX0htryCV
         8aC5Cbx9sGUjkctabURksOmIqQzwONuVqXQ9t7NSHMVMj46BrfTObnvLem3rsPyc8vpQ
         qEJfTRoqlXis88Kv0k7lrSP8uZHGh1WOintHZANZ10H/7E8w3zciwORCwBEanJg7Do3k
         IaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBKVcup3LwUPrvA4J+owpYrxuNm4ZWIxNY7Y5oA+XL4=;
        b=qrlzsB5cThmZdZEofOYXDMYlBwo66i42NxlCjNoDr3OyErsPjzPNtYClXTkIegccT5
         4h+2iJTtRZfMk4Ph2zjKquFn9jVvwGsvOPWKlcJjEpFHeIXbgf6RVcR88mUT8AuZmkTY
         OpfklSXyo1LOB5uVqgLqqIzqDGGu5cetojJcp/21HaPHmjZ6A9QOzKywiVSIZO7gzKeu
         vnavLlWxQrnN9JcacbR20+vCJb/M1EKKtCR0+DpS0zxuGFfPtqn/hQmWXEwbf1ssZDi7
         8dCRspxL4kwZSDCvRDorhk9dHgO29ZG5Cqi6gioT1WHouTSlUti98NJZcOwwBUiifp0I
         JRZw==
X-Gm-Message-State: AIkVDXJTOKpXN3RhwED8Y8i1+xra9IwpR/vmvifT2BWTzoveIpcLOqmyk7XKhSr2opLW0eJJ
X-Received: by 10.99.152.10 with SMTP id q10mr164470160pgd.106.1483991197204;
        Mon, 09 Jan 2017 11:46:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:45b6:2235:29e9:acb7])
        by smtp.gmail.com with ESMTPSA id a24sm181565709pfh.57.2017.01.09.11.46.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 11:46:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/5] unpack-trees: factor working tree update out of check_updates
Date:   Mon,  9 Jan 2017 11:46:21 -0800
Message-Id: <20170109194621.17013-6-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
In-Reply-To: <20170109194621.17013-1-sbeller@google.com>
References: <20170109194621.17013-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes check_updates shorter and easier to understand.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ac59510251..ddb3e3dcff 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -256,12 +256,13 @@ static struct progress *get_progress(struct unpack_trees_options *o)
 				    total, 50, 1);
 }
 
-static int check_updates(struct unpack_trees_options *o)
+static int update_working_tree_files(struct unpack_trees_options *o,
+				     struct progress *progress,
+				     unsigned start_cnt)
 {
-	unsigned cnt = 0;
+	unsigned cnt = start_cnt;
 	int i, errs = 0;
 
-	struct progress *progress = NULL;
 	struct index_state *index = &o->result;
 	struct checkout state = CHECKOUT_INIT;
 
@@ -270,15 +271,6 @@ static int check_updates(struct unpack_trees_options *o)
 	state.refresh_cache = 1;
 	state.istate = index;
 
-	progress = get_progress(o);
-
-	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
-
-	cnt = remove_workingtree_files(o, progress);
-	remove_marked_cache_entries(index);
-	remove_scheduled_dirs();
-
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -288,11 +280,31 @@ static int check_updates(struct unpack_trees_options *o)
 				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
-			if (o->update && !o->dry_run) {
+			if (o->update && !o->dry_run)
 				errs |= checkout_entry(ce, &state, NULL);
-			}
 		}
 	}
+
+	return errs;
+}
+
+static int check_updates(struct unpack_trees_options *o)
+{
+	struct progress *progress = NULL;
+	struct index_state *index = &o->result;
+	int errs;
+	unsigned total_removed;
+
+	progress = get_progress(o);
+
+	if (o->update)
+		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
+
+	total_removed = remove_workingtree_files(o, progress);
+	remove_marked_cache_entries(index);
+	remove_scheduled_dirs();
+	errs = update_working_tree_files(o, progress, total_removed);
+
 	stop_progress(&progress);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
-- 
2.11.0.rc2.30.g7c4be45.dirty

