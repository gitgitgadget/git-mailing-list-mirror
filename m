Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638E61F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932500AbeDBUf0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:35:26 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37799 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932476AbeDBUfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:35:09 -0400
Received: by mail-qt0-f193.google.com with SMTP id w12so16912165qti.4
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RBxUZvagp/DMbW3JKfGvTgPuDYglFujTxS6wUxEC5sk=;
        b=UT/9ZbPXkA50gpzGtgA7/C5PwRSslvRHDHhQVbzwH+zGwh6gvKaHxHMx17VXSKb19i
         wIT+CS12x9cEGN9sFD3xkZzvwe8FJHQS3ySdLyrXFnd1xPrYI5ZCbov2z9PJj4FYbxNW
         T8xCb5BSVv0mQJLhv9pYQAl4NEi+uVF2FqQHDG/saQS5RufNz5EpNpu1cNrb+MQHLhLC
         ARZce9Cke9xhKKRRQfo7UxVVYvu/cPm+XSd+Km9yZfViPceg5ZeGVs6Qq5Mf7bPqfvgX
         pYTamC8/lgcvw4hHBbl/t8GpAodRYz7qsJbG5GYxooVshdSYWA2tDHDWSvtVJs5cduAk
         Q3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RBxUZvagp/DMbW3JKfGvTgPuDYglFujTxS6wUxEC5sk=;
        b=k/WF7hREv+NAzQGiPZ7295ocOx3YXW63owBko6RTeZJ/44M2YrnHipdlnNaHu0GK4J
         o1vJa9fbIIfTaEowQSp5A1MIi8k/V1CbtIivTJQmDluyO7r7j8M90JI+sUaSlbYEnjxp
         9NGjzcECiFEyQ+lpMej7P2gNO4QjeFZsLuMrnLUUI68PRIpYq65E7H0SBKBTGylsNo51
         ym7iHVpHjQxBZztliO1EaijgQy7RH9k/TZ0QOkYybZh4PWNKMj17sZwsOlCGidYPPmTW
         hDXjCTZ0l6I/e2x8s7MIvKOpqwnRsmuIB5EZohwUbm157NAdZpkKrkoqpaEv8ePZ8V59
         JS8w==
X-Gm-Message-State: ALQs6tB/kRKPG4/e7ZXoGqX/UD1VeDJ6C2LBC9wf5CkI7RmWlQg/dceX
        cS2X5JOtInON6TAcR5BJeRICmxjZLsc=
X-Google-Smtp-Source: AIpwx49slQpsw39E/gHEWB7tiNwJPXJV8LUWRS0bdnB4Xr4LWNSDFDeFwXLcuPbVCvQyYnEfDjaZlA==
X-Received: by 10.200.68.85 with SMTP id m21mr16724163qtn.49.1522701308730;
        Mon, 02 Apr 2018 13:35:08 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:35:08 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 10/14] commit-graph: close under reachability
Date:   Mon,  2 Apr 2018 16:34:23 -0400
Message-Id: <20180402203427.170177-11-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach write_commit_graph() to walk all parents from the commits
discovered in packfiles. This prevents gaps given by loose objects or
previously-missed packfiles.

Also automatically add commits from the existing graph file, if it
exists.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index b1bd3a892d..ea29c5c2d8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -367,6 +367,50 @@ static int add_packed_commits(const struct object_id *oid,
 	return 0;
 }
 
+static void add_missing_parents(struct packed_oid_list *oids, struct commit *commit)
+{
+	struct commit_list *parent;
+	for (parent = commit->parents; parent; parent = parent->next) {
+		if (!(parent->item->object.flags & UNINTERESTING)) {
+			ALLOC_GROW(oids->list, oids->nr + 1, oids->alloc);
+			oidcpy(&oids->list[oids->nr], &(parent->item->object.oid));
+			oids->nr++;
+			parent->item->object.flags |= UNINTERESTING;
+		}
+	}
+}
+
+static void close_reachable(struct packed_oid_list *oids)
+{
+	int i;
+	struct commit *commit;
+
+	for (i = 0; i < oids->nr; i++) {
+		commit = lookup_commit(&oids->list[i]);
+		if (commit)
+			commit->object.flags |= UNINTERESTING;
+	}
+
+	/*
+	 * As this loop runs, oids->nr may grow, but not more
+	 * than the number of missing commits in the reachable
+	 * closure.
+	 */
+	for (i = 0; i < oids->nr; i++) {
+		commit = lookup_commit(&oids->list[i]);
+
+		if (commit && !parse_commit(commit))
+			add_missing_parents(oids, commit);
+	}
+
+	for (i = 0; i < oids->nr; i++) {
+		commit = lookup_commit(&oids->list[i]);
+
+		if (commit)
+			commit->object.flags &= ~UNINTERESTING;
+	}
+}
+
 void write_commit_graph(const char *obj_dir)
 {
 	struct packed_oid_list oids;
@@ -390,6 +434,7 @@ void write_commit_graph(const char *obj_dir)
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
 	for_each_packed_object(add_packed_commits, &oids, 0);
+	close_reachable(&oids);
 
 	QSORT(oids.list, oids.nr, commit_compare);
 
-- 
2.17.0.14.gba1221a8ce

