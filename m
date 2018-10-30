Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD9D1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeJaHEk (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:40 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:48884 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbeJaHEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:39 -0400
Received: by mail-yw1-f74.google.com with SMTP id v132-v6so9938807ywb.15
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ihuv0b8kbZ6CR3EhoQEBR9jxAwJ1ukt/7uhzNErL5jI=;
        b=Gv+XjylKedilxHmYwzXrxB2JXYxpATBkoVVcR2ri6+acDSeoe1CaJIKZk80tvWikNg
         hC+rvROpJeIvPbd9Llt+nCTrEsBwRr1LWiguqHI/pYrU5GR7XWjjmJa4H6OA6GwPU7r0
         zvSAOAMdAv15RsDb/FbiL04WUUPVT2HKXOpJlJ5B4CxVoZS+W51L//nC6eIGl/xh7Yl7
         38JUnNOuFSeuvkLlNN3KtkH8hDd0hM86x6tfO6UTorE9qOhdL6HfR/frTwcXUP56K9mu
         oQ2mgxz7Imdq+vdZUovDmrguq41duwIcS+Akh5CV/AhrcM7gPyryK1eC4DQ8JCkCb/Ut
         6qQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ihuv0b8kbZ6CR3EhoQEBR9jxAwJ1ukt/7uhzNErL5jI=;
        b=BSaARr9oC7UY3zgYX+X9Uhq1WDkBvxeNMPNT19zdD6Fks5eeudMOLDJBjzcBCQBhH9
         U5++3ftZ+c0pk0JbvXG/0JYZg1psTPxu6KpHpVWqZKQIKthWypwCd2MHrliYWfXlPX5E
         FyiaMBnB79bIh22rxEnIZXUlIpThJR2ydBudN6eVUcUcgbGoN/RFnttAmwVizvDegIXZ
         UbYUTO4bmu1l1dUpDBMKe5NoW9lsynCxGpZDAuJ9j0Wu5vMT4/SaC1pfCRxvGQnDFaDL
         1pPtDaMQo+2CwImpKLsD1nf8RPjnYe7DZC3mo8Tz3W8aHin/zJP1S1KQkVPzdTTC/zzf
         9aMw==
X-Gm-Message-State: AGRZ1gK98l+oLbup03fVD78i/8QDU90IKjPMnoT7T6O9YgmsVP4CAXM6
        WjkUzHOX9M67A5zFvMxmv3Y0ZNVPF+m3J1bsJtCo8OQnZaDK6n3Wj3XyTqY7M6ez/XlGIgS8cUX
        KN7fVSpE78YtmTXpjOcPNYyHT8CwJnSRXIveqqenovkF35tPZP7AOMQaBUEuV
X-Google-Smtp-Source: AJdET5dTy8lTe6DPhf1olTGL3kJZaVmYip6Dx1+J0K8tW0cMEaGx7pV/ighj8OywSQFHkREYIXuPqwGeVTWx
X-Received: by 2002:a25:2708:: with SMTP id n8-v6mr383794ybn.96.1540937364181;
 Tue, 30 Oct 2018 15:09:24 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:14 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-22-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 21/24] commit-graph: convert remaining function to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all functions to handle arbitrary repositories in commit-graph.c
that are used by functions taking a repository argument already.

Notable exclusion is write_commit_graph and its local functions as that
only works on the_repository.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-graph.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..f78a8e96b5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -292,7 +292,8 @@ static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t
 			    g->chunk_oid_lookup, g->hash_len, pos);
 }
 
-static struct commit_list **insert_parent_or_die(struct commit_graph *g,
+static struct commit_list **insert_parent_or_die(struct repository *r,
+						 struct commit_graph *g,
 						 uint64_t pos,
 						 struct commit_list **pptr)
 {
@@ -303,7 +304,7 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 		die("invalid parent position %"PRIu64, pos);
 
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
-	c = lookup_commit(the_repository, &oid);
+	c = lookup_commit(r, &oid);
 	if (!c)
 		die(_("could not find commit %s"), oid_to_hex(&oid));
 	c->graph_pos = pos;
@@ -317,7 +318,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
-static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
+static int fill_commit_in_graph(struct repository *r,
+				struct commit *item,
+				struct commit_graph *g, uint32_t pos)
 {
 	uint32_t edge_value;
 	uint32_t *parent_data_ptr;
@@ -341,13 +344,13 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	edge_value = get_be32(commit_data + g->hash_len);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
-	pptr = insert_parent_or_die(g, edge_value, pptr);
+	pptr = insert_parent_or_die(r, g, edge_value, pptr);
 
 	edge_value = get_be32(commit_data + g->hash_len + 4);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
 	if (!(edge_value & GRAPH_OCTOPUS_EDGES_NEEDED)) {
-		pptr = insert_parent_or_die(g, edge_value, pptr);
+		pptr = insert_parent_or_die(r, g, edge_value, pptr);
 		return 1;
 	}
 
@@ -355,7 +358,7 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 			  4 * (uint64_t)(edge_value & GRAPH_EDGE_LAST_MASK));
 	do {
 		edge_value = get_be32(parent_data_ptr);
-		pptr = insert_parent_or_die(g,
+		pptr = insert_parent_or_die(r, g,
 					    edge_value & GRAPH_EDGE_LAST_MASK,
 					    pptr);
 		parent_data_ptr++;
@@ -374,7 +377,9 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	}
 }
 
-static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
+static int parse_commit_in_graph_one(struct repository *r,
+				     struct commit_graph *g,
+				     struct commit *item)
 {
 	uint32_t pos;
 
@@ -382,7 +387,7 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item
 		return 1;
 
 	if (find_commit_in_graph(item, g, &pos))
-		return fill_commit_in_graph(item, g, pos);
+		return fill_commit_in_graph(r, item, g, pos);
 
 	return 0;
 }
@@ -391,7 +396,7 @@ int parse_commit_in_graph(struct repository *r, struct commit *item)
 {
 	if (!prepare_commit_graph(r))
 		return 0;
-	return parse_commit_in_graph_one(r->objects->commit_graph, item);
+	return parse_commit_in_graph_one(r, r->objects->commit_graph, item);
 }
 
 void load_commit_graph_info(struct repository *r, struct commit *item)
@@ -403,19 +408,22 @@ void load_commit_graph_info(struct repository *r, struct commit *item)
 		fill_commit_graph_info(item, r->objects->commit_graph, pos);
 }
 
-static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
+static struct tree *load_tree_for_commit(struct repository *r,
+					 struct commit_graph *g,
+					 struct commit *c)
 {
 	struct object_id oid;
 	const unsigned char *commit_data = g->chunk_commit_data +
 					   GRAPH_DATA_WIDTH * (c->graph_pos);
 
 	hashcpy(oid.hash, commit_data);
-	c->maybe_tree = lookup_tree(the_repository, &oid);
+	c->maybe_tree = lookup_tree(r, &oid);
 
 	return c->maybe_tree;
 }
 
-static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
+static struct tree *get_commit_tree_in_graph_one(struct repository *r,
+						 struct commit_graph *g,
 						 const struct commit *c)
 {
 	if (c->maybe_tree)
@@ -423,12 +431,12 @@ static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
 	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("get_commit_tree_in_graph_one called from non-commit-graph commit");
 
-	return load_tree_for_commit(g, (struct commit *)c);
+	return load_tree_for_commit(r, g, (struct commit *)c);
 }
 
 struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit *c)
 {
-	return get_commit_tree_in_graph_one(r->objects->commit_graph, c);
+	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -1025,7 +1033,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		}
 
 		graph_commit = lookup_commit(r, &cur_oid);
-		if (!parse_commit_in_graph_one(g, graph_commit))
+		if (!parse_commit_in_graph_one(r, g, graph_commit))
 			graph_report("failed to parse %s from commit-graph",
 				     oid_to_hex(&cur_oid));
 	}
@@ -1061,7 +1069,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 			continue;
 		}
 
-		if (!oideq(&get_commit_tree_in_graph_one(g, graph_commit)->object.oid,
+		if (!oideq(&get_commit_tree_in_graph_one(r, g, graph_commit)->object.oid,
 			   get_commit_tree_oid(odb_commit)))
 			graph_report("root tree OID for commit %s in commit-graph is %s != %s",
 				     oid_to_hex(&cur_oid),
-- 
2.19.1.930.g4563a0d9d0-goog

