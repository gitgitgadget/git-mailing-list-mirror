Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6391F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeKAWta (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:49:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45024 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeKAWta (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:49:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id n12so12252101qkh.11
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=51vf9rmyUST7LXKwNKxANNRDC7ro8zDKgJwS3AqXweg=;
        b=RhLPgp6BvneNOpak6OVeths1yX4t5PuYVOniv34MNd2Fs5hImyVGNg+cdWR2aSTJg6
         BpvA1WRrQKDzEtnRukg5KhS74VLJ8E0HHnyliX8Zoz2DIGkMfItabpDaXoOu5xkuhfM5
         sN8x8mB3wwWYAKgH982BBy2lz2PuhpeOppo2U5zIgE7eFCgJe+rsGPcVkI4oCjhDCazC
         suDINoG9RKM9KIFl7OK+Qu8tRLpKdQomxpy6HdrPj+4x+otKd22W6suUnJi5g6UmQIIz
         Vxaq3BRIXeIlD3tzEUxev/MILGKekojz1fQ2X7Exi4npB4l0Rw605ftQGWrKQxh1t8Kd
         eg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=51vf9rmyUST7LXKwNKxANNRDC7ro8zDKgJwS3AqXweg=;
        b=QyU4W8mF1CAYNnEuGwy7Vb5p20zv43Wfpsfj4oWyJEjsCmo1W70Dzti74lqy2iHenL
         jqLoHfFrQaXdjlEUAts5gIQyZYFgSYTAAf+AE84KafkPeVWd+m75oDvBkO5GKFgvFqMl
         M9uvqsUVrIUtpn7i3t/aa8hyd1QXNfA+mDNZj71Jy0dAk6Iu9endx5urqGys3QLNdRSo
         jMHnrDbdKvUSGRfeIlLzGooXZulaf6N5peznQZ3lgAEnFNLBzNRysfWE2kY5vG6MhPJS
         ZLnj+AX4A3Pvs8QzgnKjhN1fezHUAQxSkyXTe1ofZNJMNXwuprmRuLgNYBPcLeJNE9bv
         5Fog==
X-Gm-Message-State: AGRZ1gJOWH1+WKSG8j+fEdPJTwO6qSXAkSDBRv8SHFkI7qIJnO//bnHR
        EnDtPMKuJ5fjq/G4pVjDuX4YvnrU
X-Google-Smtp-Source: AJdET5f0yMnSjXKTo4T1KJKt3RE64WQ0YqsD/tHVrfIC5rT0xz0yyrRZSQ2bMDZY0Qj7xbkeXA2BwQ==
X-Received: by 2002:a37:7484:: with SMTP id p126-v6mr6328258qkc.153.1541079987624;
        Thu, 01 Nov 2018 06:46:27 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id f75sm7347357qkf.96.2018.11.01.06.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:46:27 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, szeder.dev@gmail.com,
        peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 1/7] prio-queue: add 'peek' operation
Date:   Thu,  1 Nov 2018 13:46:17 +0000
Message-Id: <20181101134623.84055-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.1.542.gc4df23f792
In-Reply-To: <20181101134623.84055-1-dstolee@microsoft.com>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When consuming a priority queue, it can be convenient to inspect
the next object that will be dequeued without actually dequeueing
it. Our existing library did not have such a 'peek' operation, so
add it as prio_queue_peek().

Add a reference-level comparison in t/helper/test-prio-queue.c
so this method is exercised by t0009-prio-queue.sh. Further, add
a test that checks the behavior when the compare function is NULL
(i.e. the queue becomes a stack).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 prio-queue.c               |  9 +++++++++
 prio-queue.h               |  6 ++++++
 t/helper/test-prio-queue.c | 26 ++++++++++++++++++--------
 t/t0009-prio-queue.sh      | 14 ++++++++++++++
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index a078451872..d3f488cb05 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -85,3 +85,12 @@ void *prio_queue_get(struct prio_queue *queue)
 	}
 	return result;
 }
+
+void *prio_queue_peek(struct prio_queue *queue)
+{
+	if (!queue->nr)
+		return NULL;
+	if (!queue->compare)
+		return queue->array[queue->nr - 1].data;
+	return queue->array[0].data;
+}
diff --git a/prio-queue.h b/prio-queue.h
index d030ec9dd6..682e51867a 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -46,6 +46,12 @@ extern void prio_queue_put(struct prio_queue *, void *thing);
  */
 extern void *prio_queue_get(struct prio_queue *);
 
+/*
+ * Gain access to the "thing" that would be returned by
+ * prio_queue_get, but do not remove it from the queue.
+ */
+extern void *prio_queue_peek(struct prio_queue *);
+
 extern void clear_prio_queue(struct prio_queue *);
 
 /* Reverse the LIFO elements */
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index 9807b649b1..5bc9c46ea5 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -22,14 +22,24 @@ int cmd__prio_queue(int argc, const char **argv)
 	struct prio_queue pq = { intcmp };
 
 	while (*++argv) {
-		if (!strcmp(*argv, "get"))
-			show(prio_queue_get(&pq));
-		else if (!strcmp(*argv, "dump")) {
-			int *v;
-			while ((v = prio_queue_get(&pq)))
-			       show(v);
-		}
-		else {
+		if (!strcmp(*argv, "get")) {
+			void *peek = prio_queue_peek(&pq);
+			void *get = prio_queue_get(&pq);
+			if (peek != get)
+				BUG("peek and get results do not match");
+			show(get);
+		} else if (!strcmp(*argv, "dump")) {
+			void *peek;
+			void *get;
+			while ((peek = prio_queue_peek(&pq))) {
+				get = prio_queue_get(&pq);
+				if (peek != get)
+					BUG("peek and get results do not match");
+				show(get);
+			}
+		} else if (!strcmp(*argv, "stack")) {
+			pq.compare = NULL;
+		} else {
 			int *v = malloc(sizeof(*v));
 			*v = atoi(*argv);
 			prio_queue_put(&pq, v);
diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
index e56dfce668..3941ad2528 100755
--- a/t/t0009-prio-queue.sh
+++ b/t/t0009-prio-queue.sh
@@ -47,4 +47,18 @@ test_expect_success 'notice empty queue' '
 	test_cmp expect actual
 '
 
+cat >expect <<'EOF'
+3
+2
+6
+4
+5
+1
+8
+EOF
+test_expect_success 'stack order' '
+	test-tool prio-queue stack 8 1 5 4 6 2 3 dump >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 2d3b1c576c85b7f5db1f418907af00ab88e0c303
-- 
2.19.1.542.gc4df23f792

