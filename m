Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6793A1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965426AbeF0NZ1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:27 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39831 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965111AbeF0NZY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:24 -0400
Received: by mail-qt0-f193.google.com with SMTP id b20-v6so954305qtp.6
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V3oqnDBPisMWKJDzvrdkQyPdtWIInwzt0XaOujo/FbM=;
        b=JpueNV37NARgFY5RJZ77H05ZFuEtey7gejiY+J9jl1Q6PXSSNJrzg25zIqJhoLcMFT
         Rjn9ChIJUaIxG4bd5NM5DP4Tfsba5zcerVtcu6aWSl2fn9zYIn/NFtvy3EDU4iswNiHR
         ydLuwo3GxtKB4rGiWlJGfFT6DkpxxGG12+wBi7drrhU8hXUeJ6maXC542jEg3isTYry6
         Ri9CGYOYtYTquk1PM6/XnJbSjffbPLCxo2td26ou6WW7ODZQ6F48uxn0O2HE7heG2IYg
         qdiVhz3WF8jdQ8JdUSzUleVzQ3RJ+x9eciXDVHXkbzmn7UP1POYjAjgQrRaCfQB8ti0c
         ruPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V3oqnDBPisMWKJDzvrdkQyPdtWIInwzt0XaOujo/FbM=;
        b=R0tWGpb/OKIa7+hzy9ake5Hk3qDyEe9BspuUWtvd3IepwrT5/HUJ4nhd2KHq022Nyk
         cGEvEJtYW6ga107bXCLiec513HpAEjjffk+ktx0FTEVqv/TXC90lAKRhbheFWnhfj0aW
         6IqhCtIx2nKZx8iZ8LWRjsKJw3g+uBbFTbpbNbX/xrmSgU1EwuWiQroi+FPyl+GHHRqq
         OYVbaMG+9PmwqlYbWask+WL8pGHjVHhRoSjsOys71QnHjCC45JOAlVkPxX1fOTF7e7Y2
         KwQBh5kPOOh6HWKbUxaOMZ7NtAQGgKI5mMvi+BzcHmxsr4kRtuq7TGlRKiU/u2ZM0FmD
         t1sA==
X-Gm-Message-State: APt69E0LtGU0isCZ6SezdRFBfEI2L7vD8zwx6CtJNvI2oIQpwmpZLy5+
        Gxmo53KGEF2KyDZPaG/GXaAH3y+LtJs=
X-Google-Smtp-Source: AAOMgpfMlNhn4hbpv8MpzAiGBX5syVCYRSMJYSa0FiwInrIgWQ6RYRaqLbELNfhsQaol/ltrTkPlBg==
X-Received: by 2002:ac8:2ba9:: with SMTP id m38-v6mr5340202qtm.152.1530105923867;
        Wed, 27 Jun 2018 06:25:23 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:23 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 14/22] commit-graph: verify generation number
Date:   Wed, 27 Jun 2018 09:24:39 -0400
Message-Id: <20180627132447.142473-15-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While iterating through the commit parents, perform the generation
number calculation and compare against the value stored in the
commit-graph.

The tests demonstrate that having a different set of parents affects
the generation number calculation, and this value propagates to
descendants. Hence, we drop the single-line condition on the output.

Since Git will ship with the commit-graph feature without generation
numbers, we need to accept commit-graphs with all generation numbers
equal to zero. In this case, ignore the generation number calculation.

However, verify that we should never have a mix of zero and non-zero
generation numbers. Create a test that sets one commit to generation
zero and all following commits report a failure as they have non-zero
generation in a file that contains generation number zero.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 34 ++++++++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 6d8d774eb0..e0f71658da 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -846,10 +846,14 @@ static void graph_report(const char *fmt, ...)
 	va_end(ap);
 }
 
+#define GENERATION_ZERO_EXISTS 1
+#define GENERATION_NUMBER_EXISTS 2
+
 int verify_commit_graph(struct repository *r, struct commit_graph *g)
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid;
+	int generation_zero = 0;
 
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -911,6 +915,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
+		uint32_t max_generation = 0;
 
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
@@ -945,6 +950,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
 
+			if (graph_parents->item->generation > max_generation)
+				max_generation = graph_parents->item->generation;
+
 			graph_parents = graph_parents->next;
 			odb_parents = odb_parents->next;
 		}
@@ -952,6 +960,32 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		if (odb_parents != NULL)
 			graph_report("commit-graph parent list for commit %s terminates early",
 				     oid_to_hex(&cur_oid));
+
+		if (!graph_commit->generation) {
+			if (generation_zero == GENERATION_NUMBER_EXISTS)
+				graph_report("commit-graph has generation number zero for commit %s, but non-zero elsewhere",
+					     oid_to_hex(&cur_oid));
+			generation_zero = GENERATION_ZERO_EXISTS;
+		} else if (generation_zero == GENERATION_ZERO_EXISTS)
+			graph_report("commit-graph has non-zero generation number for commit %s, but zero elsewhere",
+				     oid_to_hex(&cur_oid));
+
+		if (generation_zero == GENERATION_ZERO_EXISTS)
+			continue;
+
+		/*
+		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
+		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
+		 * extra logic in the following condition.
+		 */
+		if (max_generation == GENERATION_NUMBER_MAX)
+			max_generation--;
+
+		if (graph_commit->generation != max_generation + 1)
+			graph_report("commit-graph generation for commit %s is %u != %u",
+				     oid_to_hex(&cur_oid),
+				     graph_commit->generation,
+				     max_generation + 1);
 	}
 
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index b41c8f4d9b..3128e19aef 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -272,6 +272,7 @@ GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
 GRAPH_BYTE_COMMIT_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3))
+GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 11))
 
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -366,4 +367,14 @@ test_expect_success 'detect wrong parent' '
 		"commit-graph parent for"
 '
 
+test_expect_success 'detect incorrect generation number' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\070" \
+		"generation for commit"
+'
+
+test_expect_success 'detect incorrect generation number' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
+		"non-zero generation number"
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

