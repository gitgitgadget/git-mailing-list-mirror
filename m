Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70821F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965423AbeF0NZZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:25 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42670 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965419AbeF0NZW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:22 -0400
Received: by mail-qk0-f193.google.com with SMTP id u62-v6so987264qkf.9
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/BukKMyaFSaYGC2lVrZYjc0U2pHz9xfVV2imdQSrfs=;
        b=lXL7iV+Tfm4Yya5m3GJAT/R5DWwW/IGFFp7FfnYj32xiaEo3cgimjVLNsTPRksISaS
         NHZSiGS4RWinKLmCdqgXBCSeNeV/tYXXmB6OVBr7Y5uJAtsqDMRVsj5TyNk4Vz4aFz4W
         f6N7rwpkCmezrUS3pVdrST28vfVpm3GEJx/EhX77psN8qZ/IaSTc99L53kVJvoE+dHsH
         p78KScgRrwOGQ16dy9CjvDQNj78Ao2Y+cMNTSfylWPybnICyT46ijVMXVnMxM8DC6/5W
         YcphiVN36LZcEm8vVesBH63jfhzW04ApjQsb9HdOhmIHJdLrfXaJUGzEgIixBam5Zi80
         +BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/BukKMyaFSaYGC2lVrZYjc0U2pHz9xfVV2imdQSrfs=;
        b=S1wQfPJ4l0WMkegOTcs2hRu8fDyMOuxiFSlkfvsXOWxV0kBvaepsPDx1VyCIB9kv+H
         s5L7bmMV9R/DGgTHV0nvdPNpw4+zvpl+Cd74/zAwO/Png1vWz7p/1TXN9cdf5GTcyDqn
         JFoQJ/Ta/f5YRnbGdjfKLSdVQAUxy0921Ax9v3i9hxcc6PjjVUBdwDmSS7MQ5m8c6OWn
         ALHoOZ65tUcfNa/P/YbPQO/p+C/kUNwW1xlEFuH02+3u6kuBoM1nXchA7LQ2kjn06ZHd
         6PNzN+H+R8bEVBSzafJTyCP0kJRVk/uVFyw9PDq9TleBACqMYgZ2lPIwMR9iL2O08NwS
         RFAw==
X-Gm-Message-State: APt69E3HHqVd/K7Kong03ktt11b9Smb7an0ARW+dvgRHyfklaQoxoWXa
        evZUPR9GV3IY6+2L1jCBtJlxj8apjS8=
X-Google-Smtp-Source: AAOMgpeFaTYi+oyGwOTGaisFAg23q5bOGsGUTENyViRRnuNcdO5DdKhtoKYgd2k1i4RAJJYtFYrv7g==
X-Received: by 2002:a37:21e6:: with SMTP id f99-v6mr4880730qki.206.1530105921736;
        Wed, 27 Jun 2018 06:25:21 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:21 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 13/22] commit-graph: verify parent list
Date:   Wed, 27 Jun 2018 09:24:38 -0400
Message-Id: <20180627132447.142473-14-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file stores parents in a two-column portion of the
commit data chunk. If there is only one parent, then the second column
stores 0xFFFFFFFF to indicate no second parent.

The 'verify' subcommand checks the parent list for the commit loaded
from the commit-graph and the one parsed from the object database. Test
these checks for corrupt parents, too many parents, and wrong parents.

Add a boundary check to insert_parent_or_die() for when the parent
position value is out of range.

The octopus merge will be tested in a later commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 28 ++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 18 ++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 5df18394f9..6d8d774eb0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -244,6 +244,9 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 	struct commit *c;
 	struct object_id oid;
 
+	if (pos >= g->num_commits)
+		die("invalid parent position %"PRIu64, pos);
+
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
 	c = lookup_commit(&oid);
 	if (!c)
@@ -907,6 +910,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
+		struct commit_list *graph_parents, *odb_parents;
 
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
@@ -924,6 +928,30 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 				     oid_to_hex(&cur_oid),
 				     oid_to_hex(get_commit_tree_oid(graph_commit)),
 				     oid_to_hex(get_commit_tree_oid(odb_commit)));
+
+		graph_parents = graph_commit->parents;
+		odb_parents = odb_commit->parents;
+
+		while (graph_parents) {
+			if (odb_parents == NULL) {
+				graph_report("commit-graph parent list for commit %s is too long",
+					     oid_to_hex(&cur_oid));
+				break;
+			}
+
+			if (oidcmp(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
+				graph_report("commit-graph parent for %s is %s != %s",
+					     oid_to_hex(&cur_oid),
+					     oid_to_hex(&graph_parents->item->object.oid),
+					     oid_to_hex(&odb_parents->item->object.oid));
+
+			graph_parents = graph_parents->next;
+			odb_parents = odb_parents->next;
+		}
+
+		if (odb_parents != NULL)
+			graph_report("commit-graph parent list for commit %s terminates early",
+				     oid_to_hex(&cur_oid));
 	}
 
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index f258c6d5d0..b41c8f4d9b 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -269,6 +269,9 @@ GRAPH_BYTE_OID_LOOKUP_ORDER=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 8))
 GRAPH_BYTE_OID_LOOKUP_MISSING=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 4 + 10))
 GRAPH_COMMIT_DATA_OFFSET=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * $NUM_COMMITS))
 GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
+GRAPH_BYTE_COMMIT_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
+GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4))
+GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3))
 
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -348,4 +351,19 @@ test_expect_success 'detect incorrect tree OID' '
 		"root tree OID for commit"
 '
 
+test_expect_success 'detect incorrect parent int-id' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_PARENT "\01" \
+		"invalid parent"
+'
+
+test_expect_success 'detect extra parent int-id' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_EXTRA_PARENT "\00" \
+		"is too long"
+'
+
+test_expect_success 'detect wrong parent' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_WRONG_PARENT "\01" \
+		"commit-graph parent for"
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

