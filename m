Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E80F1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965449AbeF0NZi (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:38 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46540 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965412AbeF0NZS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:18 -0400
Received: by mail-qt0-f195.google.com with SMTP id h5-v6so1560175qtm.13
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNO7TYlAMTNGHYxSLs0OfXEe4rjkHHUfAiqSkwOMnJQ=;
        b=G5iSGsPUXzHjlEqPGtVoglT6SyB+1fZLk4ItwjB0nrEbJYlmb+yklrKUSqi0iOgugw
         MRyYOLstGpXwBGdgoJ5U1gGppuhX/pW/y2qDtRmOesh+snyNuusL0WjZEajpdnbdnET7
         BaYenh710lFZeAow0YiNrdznVtoR3z3Ybx/4TepX1ur6rw1WTR+GUAVTX7GCujh3w+fS
         x8LJobfxoVyyYiFnNUhngbXVTZ3r2ARUnTVVj1GpDeFRhyR/VHnmqskQtDNfNeaIb35k
         8yAqy7aT7C4cw01x8uziX9LdYl+teaVRILdSCi9HBGxAv6GIV1Qg403DGl+xaUsa/bPE
         Sn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PNO7TYlAMTNGHYxSLs0OfXEe4rjkHHUfAiqSkwOMnJQ=;
        b=TaACyb62epz6pGmxafrTDND1jpGS07Y/FQEVA08faeVzWWgrT/cFgpyrpzIsAagMZT
         OHrUeak/CdZdhLsYqgpArhOY1y53T57fYVUI3YT+fZqSlUH3pFcuE+TrtZJ6qEXgpcuV
         EThaQYCZFpEwWbAB9XNhV0TJwLY6QADGGNSOuOMvHB9cglsAnAshQEnHFLWqCRmQocTe
         NhXNSXbb933+98a5zCNqjXtoDzgpY3tyBTo4K7jeej1egCGQC7y6VKQGguUnONne4iy2
         ERrTiRFHy9vAOfUXfedYgSvTu0pUCvIt5T+FNohuk5mQ+K+Jy67901s+Ht3GQVkrK6gg
         Ag4w==
X-Gm-Message-State: APt69E1aMvqV4uimwdZ4pPQNgi6CMVvNzRl4vcSRIOHTzozElTs0H8ay
        MaY9qtoQAVEUwiK877Z4gWcemYuN1Bw=
X-Google-Smtp-Source: AAOMgpfUDvgyEEwu4JtwQ365yqR+0PYZ8gWTw6i3cl1cMmm5znsNDwReBaMjfpvGZyhBzmRHFmNsLw==
X-Received: by 2002:ac8:5354:: with SMTP id d20-v6mr5404916qto.141.1530105917917;
        Wed, 27 Jun 2018 06:25:17 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:17 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 11/22] commit-graph: verify objects exist
Date:   Wed, 27 Jun 2018 09:24:36 -0400
Message-Id: <20180627132447.142473-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the 'verify' subcommand, load commits directly from the object
database to ensure they exist. Parse by skipping the commit-graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 18 ++++++++++++++++++
 t/t5318-commit-graph.sh |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 866a9e7e41..00e89b71e9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -11,6 +11,7 @@
 #include "sha1-lookup.h"
 #include "commit-graph.h"
 #include "object-store.h"
+#include "alloc.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -242,6 +243,7 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 {
 	struct commit *c;
 	struct object_id oid;
+
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c = lookup_commit(&oid);
 	if (!c)
@@ -893,5 +895,21 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		cur_fanout_pos++;
 	}
 
+	if (verify_commit_graph_error)
+		return verify_commit_graph_error;
+
+	for (i = 0; i < g->num_commits; i++) {
+		struct commit *odb_commit;
+
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		odb_commit = (struct commit *)create_object(r, cur_oid.hash, alloc_commit_node(r));
+		if (parse_commit_internal(odb_commit, 0, 0)) {
+			graph_report("failed to parse %s from object database",
+				     oid_to_hex(&cur_oid));
+			continue;
+		}
+	}
+
 	return verify_commit_graph_error;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 8ae2a49cfa..a27ec97269 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -247,6 +247,7 @@ test_expect_success 'git commit-graph verify' '
 	git commit-graph verify >output
 '
 
+NUM_COMMITS=9
 HASH_LEN=20
 GRAPH_BYTE_VERSION=4
 GRAPH_BYTE_HASH=5
@@ -265,6 +266,7 @@ GRAPH_BYTE_FANOUT1=$(($GRAPH_FANOUT_OFFSET + 4 * 4))
 GRAPH_BYTE_FANOUT2=$(($GRAPH_FANOUT_OFFSET + 4 * 255))
 GRAPH_OID_LOOKUP_OFFSET=$(($GRAPH_FANOUT_OFFSET + 4 * 256))
 GRAPH_BYTE_OID_LOOKUP_ORDER=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 8))
+GRAPH_BYTE_OID_LOOKUP_MISSING=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 4 + 10))
 
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -334,4 +336,9 @@ test_expect_success 'detect incorrect OID order' '
 		"incorrect OID order"
 '
 
+test_expect_success 'detect OID not in object database' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_MISSING "\01" \
+		"from object database"
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

