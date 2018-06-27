Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29541F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965452AbeF0NZk (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38596 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965398AbeF0NZR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:17 -0400
Received: by mail-qt0-f195.google.com with SMTP id c5-v6so1581205qth.5
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4mmKzGBd1pJHuVRt2wBrsnZQ+n09jN792Lmvms8FIsM=;
        b=RfYoKhXbP2wpoEUYtIT2guyIwcEmIYvMoa3YCxpQSAvLk8udVst2yzkXlZsx6VJWya
         3VGlmwXkgb2fRXEoj4x6UYtCdnjuhMOo/yNvdNJuQcSNX//rQLnGSN1FImPr/ZVLdtyy
         RKRxX7r0x6AccLfKqWNwua9r1h8t/dkwM8XSLK3sbodxJwoojB8vjwqrKC8OkxfMiix3
         ZwR9Yl9NR8qiFuSEsUnyvs/A/dKVq7Szy9BAQMjfppTMZPSe3nlfHBW19f7CZlJ65P/j
         cVSLJ84Gt3oFA4cgumBIzRZu+G0HaR6ewT+zjoxqABrI9OoTZWbILMw7JnwBA63Ym9mk
         /0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4mmKzGBd1pJHuVRt2wBrsnZQ+n09jN792Lmvms8FIsM=;
        b=DzI0D8zuF531gWHA18ZsjBJA+DWhkdE0lX1hyJmfrW1tsEnT9paePoXAaJVEOxBMBd
         pkzqj6AHVeaqUK77ZHoXmVPOGRvyz3/MA4csvZTmrrCfFJbKcLnJa4tEqjSuLZ41iFCq
         xO2d34MruXlWiPgp7RB5Q2vtp3ssIkrISEhiGzpHtLkxFkslgcON5movZVc0Xqp5A04Z
         sL6Lf/DjOpfoOX+R+y4SWgOouUbwxSsv4L+5dvtLrrVIaFnkEKEPqUpCy4cbvhAKlU+U
         5sTXVU/lkZlH1WJjmGTaZuQAYhsfvSla4RPfIXDHUjVuWXvpXaj/JnBKDqqcEmAzLgMe
         UJ0g==
X-Gm-Message-State: APt69E2ZfsJuStEU/smux7BjlCU8J9UJsm5VqRATFtWTmzg3mhrnQJs4
        mrBsfSgWbLy9S4IQzW2/Vx0bfHZ8FWs=
X-Google-Smtp-Source: AAOMgpcBR20IcM2R9w6e0KvI3dg/PWcEZRSP4WcVrycErOid4LFs/S4+SN2h2HAzAnshlcZgA3BT0A==
X-Received: by 2002:ac8:2506:: with SMTP id 6-v6mr5538167qtm.9.1530105916097;
        Wed, 27 Jun 2018 06:25:16 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:15 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 10/22] commit-graph: verify corrupt OID fanout and lookup
Date:   Wed, 27 Jun 2018 09:24:35 -0400
Message-Id: <20180627132447.142473-11-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the commit-graph file, the OID fanout chunk provides an index into
the OID lookup. The 'verify' subcommand should find incorrect values
in the fanout.

Similarly, the 'verify' subcommand should find out-of-order values in
the OID lookup.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 36 ++++++++++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index f30b4ccee9..866a9e7e41 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -843,6 +843,9 @@ static void graph_report(const char *fmt, ...)
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g)
 {
+	uint32_t i, cur_fanout_pos = 0;
+	struct object_id prev_oid, cur_oid;
+
 	if (!g) {
 		graph_report("no commit-graph file loaded");
 		return 1;
@@ -857,5 +860,38 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	if (!g->chunk_commit_data)
 		graph_report("commit-graph is missing the Commit Data chunk");
 
+	if (verify_commit_graph_error)
+		return verify_commit_graph_error;
+
+	for (i = 0; i < g->num_commits; i++) {
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
+			graph_report("commit-graph has incorrect OID order: %s then %s",
+				     oid_to_hex(&prev_oid),
+				     oid_to_hex(&cur_oid));
+
+		oidcpy(&prev_oid, &cur_oid);
+
+		while (cur_oid.hash[0] > cur_fanout_pos) {
+			uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
+			if (i != fanout_value)
+				graph_report("commit-graph has incorrect fanout value: fanout[%d] = %u != %u",
+					     cur_fanout_pos, fanout_value, i);
+
+			cur_fanout_pos++;
+		}
+	}
+
+	while (cur_fanout_pos < 256) {
+		uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
+
+		if (g->num_commits != fanout_value)
+			graph_report("commit-graph has incorrect fanout value: fanout[%d] = %u != %u",
+				     cur_fanout_pos, fanout_value, i);
+
+		cur_fanout_pos++;
+	}
+
 	return verify_commit_graph_error;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index dc16849ddd..8ae2a49cfa 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -247,6 +247,7 @@ test_expect_success 'git commit-graph verify' '
 	git commit-graph verify >output
 '
 
+HASH_LEN=20
 GRAPH_BYTE_VERSION=4
 GRAPH_BYTE_HASH=5
 GRAPH_BYTE_CHUNK_COUNT=6
@@ -258,6 +259,12 @@ GRAPH_BYTE_OID_LOOKUP_ID=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
 			    1 * $GRAPH_CHUNK_LOOKUP_WIDTH))
 GRAPH_BYTE_COMMIT_DATA_ID=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
 			     2 * $GRAPH_CHUNK_LOOKUP_WIDTH))
+GRAPH_FANOUT_OFFSET=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+		       $GRAPH_CHUNK_LOOKUP_WIDTH * $GRAPH_CHUNK_LOOKUP_ROWS))
+GRAPH_BYTE_FANOUT1=$(($GRAPH_FANOUT_OFFSET + 4 * 4))
+GRAPH_BYTE_FANOUT2=$(($GRAPH_FANOUT_OFFSET + 4 * 255))
+GRAPH_OID_LOOKUP_OFFSET=$(($GRAPH_FANOUT_OFFSET + 4 * 256))
+GRAPH_BYTE_OID_LOOKUP_ORDER=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 8))
 
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -312,4 +319,19 @@ test_expect_success 'detect missing commit data chunk' '
 		"missing the Commit Data chunk"
 '
 
+test_expect_success 'detect incorrect fanout' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT1 "\01" \
+		"fanout value"
+'
+
+test_expect_success 'detect incorrect fanout final value' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
+		"fanout value"
+'
+
+test_expect_success 'detect incorrect OID order' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ORDER "\01" \
+		"incorrect OID order"
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

