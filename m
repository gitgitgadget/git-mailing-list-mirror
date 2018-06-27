Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B651F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965418AbeF0NZW (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:22 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39668 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965111AbeF0NZU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:20 -0400
Received: by mail-qk0-f194.google.com with SMTP id f3-v6so991716qkd.6
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PKBjYn7EQKFDPf0XdQIYdFiZtsVZpAScqPI3XEaXmM=;
        b=keLYm1FJA+Jb4emBLEyLRDIS5ALJ+7rIy3z04fie4ifGZsx6MLRgzvgHmwgMzsmgWK
         11UB72s5ly0NtGWXicD5H8Nw2TcbisMiP1bkRLoGq7KONISbxLcTzSknz21XiPZkBZj4
         EN5KpBFysBnCNZw2v1fyNjIU9udmIBDdqUX/tDShP3zzRT3Mz08pqJzpII4b5H2zF5Ly
         Tqz+Uir/q1lXCAwD/Otgllq03fnrxoD2fdnHh0q0NsCFw4FlXi0NiupGwSEectHBFdJM
         7ufXXS0+xQiN4djrVaXbSdWQzh6ktzHEudqE0TOZJ3WH/E/DuXfODIonBxOmDBut9imJ
         dgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PKBjYn7EQKFDPf0XdQIYdFiZtsVZpAScqPI3XEaXmM=;
        b=cRCLUbFgj6gOBn9Rj0SE24S8e6I25isT5y3oX6zruEUxYxPBbwMHWkt77gmHh61JzV
         7RQXvj+g6vefVC5bKjrYVBv3U/+7s9s4025TZr1xe7ZlcvXDMKn2Yy6cDYURbsoL5YwO
         9OwwmqW1b18lEuEbRUkzqj1/5wMmn/IVViNSW7QcQHRUJy3yHwmcFftGV7sFcN1K2NPX
         9qymfHtWEgB/BAawUpIf2MLETjWqQRb4eEpwd+4kLd5xAJTG3PW07YDE1izw3PSPGvAL
         m9roqeJ6Ho1KcxZLNpTaElrJDoVwiushHWDqtkQKn2TmbQxl0ftZPs3+i1SKHQScaA8X
         IkBw==
X-Gm-Message-State: APt69E1y5nPGT44tr+E+y5Qc3Z9BxsHWQF3jh52k6apYO+IrrT9RZQSB
        8bRW1t82Xey67SaEwTiVzzasxkYLwe4=
X-Google-Smtp-Source: AAOMgpcJXwFGl8e/JwsK8kXaiQBXkFQWgY4NmAdxgh4XR6j9pKgnF07iaTbK6UnQKHxNfZZr1rctfQ==
X-Received: by 2002:a37:b704:: with SMTP id h4-v6mr5310299qkf.398.1530105920019;
        Wed, 27 Jun 2018 06:25:20 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:19 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 12/22] commit-graph: verify root tree OIDs
Date:   Wed, 27 Jun 2018 09:24:37 -0400
Message-Id: <20180627132447.142473-13-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'verify' subcommand must compare the commit content parsed from the
commit-graph against the content in the object database. Use
lookup_commit() and parse_commit_in_graph_one() to parse the commits
from the graph and compare against a commit that is loaded separately
and parsed directly from the object database.

Add checks for the root tree OID.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 17 ++++++++++++++++-
 t/t5318-commit-graph.sh |  7 +++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 00e89b71e9..5df18394f9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -866,6 +866,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		return verify_commit_graph_error;
 
 	for (i = 0; i < g->num_commits; i++) {
+		struct commit *graph_commit;
+
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
 		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
@@ -883,6 +885,11 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 
 			cur_fanout_pos++;
 		}
+
+		graph_commit = lookup_commit(&cur_oid);
+		if (!parse_commit_in_graph_one(g, graph_commit))
+			graph_report("failed to parse %s from commit-graph",
+				     oid_to_hex(&cur_oid));
 	}
 
 	while (cur_fanout_pos < 256) {
@@ -899,16 +906,24 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		return verify_commit_graph_error;
 
 	for (i = 0; i < g->num_commits; i++) {
-		struct commit *odb_commit;
+		struct commit *graph_commit, *odb_commit;
 
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
+		graph_commit = lookup_commit(&cur_oid);
 		odb_commit = (struct commit *)create_object(r, cur_oid.hash, alloc_commit_node(r));
 		if (parse_commit_internal(odb_commit, 0, 0)) {
 			graph_report("failed to parse %s from object database",
 				     oid_to_hex(&cur_oid));
 			continue;
 		}
+
+		if (oidcmp(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
+			   get_commit_tree_oid(odb_commit)))
+			graph_report("root tree OID for commit %s in commit-graph is %s != %s",
+				     oid_to_hex(&cur_oid),
+				     oid_to_hex(get_commit_tree_oid(graph_commit)),
+				     oid_to_hex(get_commit_tree_oid(odb_commit)));
 	}
 
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a27ec97269..f258c6d5d0 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -267,6 +267,8 @@ GRAPH_BYTE_FANOUT2=$(($GRAPH_FANOUT_OFFSET + 4 * 255))
 GRAPH_OID_LOOKUP_OFFSET=$(($GRAPH_FANOUT_OFFSET + 4 * 256))
 GRAPH_BYTE_OID_LOOKUP_ORDER=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 8))
 GRAPH_BYTE_OID_LOOKUP_MISSING=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 4 + 10))
+GRAPH_COMMIT_DATA_OFFSET=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * $NUM_COMMITS))
+GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
 
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -341,4 +343,9 @@ test_expect_success 'detect OID not in object database' '
 		"from object database"
 '
 
+test_expect_success 'detect incorrect tree OID' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_TREE "\01" \
+		"root tree OID for commit"
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

