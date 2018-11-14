Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7AA31F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbeKNKPF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:15:05 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:41020 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKPE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:15:04 -0500
Received: by mail-pl1-f201.google.com with SMTP id y2so3237505plr.8
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WNR/f8TluUPmY8S0v4gmPLNTzwVeC3S7nPTCn/rqhYE=;
        b=AIMAYG676oYa/tcQKGgLhROpUZxQIzS0Yl+IVP26pjKB1EyLxUYBtEG4kbNWzVnLGP
         HmBHqtTcvi328g3KNnO/lf4AoNw9qJecVkh1c8VoxlNoMu8IR/c5+FGqjZka3T67lNE7
         JyikqA7YSD0TLnirUhKwL33Di3ipThMBxOF27qFKMm+IOnZO4W7JRjQvf3GRpGF2hEjt
         refOV9DONpCHXa7XGUOTyvqkdD0vpo+wLt7uZVf9xSeLRpXwymVyqqlZGyMBWxl7plsB
         Uy4znsApn2sddPKlBZ3nW4hwc2nTnITqszv4vOfhtfZUc4NTkkKPNG+hiVLKUwn02pMj
         CrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WNR/f8TluUPmY8S0v4gmPLNTzwVeC3S7nPTCn/rqhYE=;
        b=g0QR5bAAmxrODC/AQBmOPI6GC3dX9Bv7IV1MpqJq++9JwATY9QIQKZ7XDq/+ifZQAk
         df/M2JudhnNUictCQuHT2mJVuqCH5+PvNANMSHIl0N6tjcdylf4dxP9uHa8qoNifYGh3
         TIZ0qXjrzPcjSXIj1VHk2wCkajeLw/TMutoZeexnpTuTrK+w5IHvA3Q3nUAJzeUcGqhb
         UZBMPDB6qIndCNDOEtMUZKs1f357KbnX0A5Lx6R41jvZaiDUn5gslgCotHbqbEhIoJCv
         ShGW7de/DXv1shhV9XUTt5SsPr0D6HoRtOMrdWLNulovBtXDYIoZfLh1aIFfLl+9PnJB
         CmUg==
X-Gm-Message-State: AGRZ1gKMDIZUZ6uyQOgMqdn3pFHGjWmHfXoHFZOajSxXfMu33BOxcoOD
        LnNegrOAzQZezOA6lHKDumSQwUI4Nm8O
X-Google-Smtp-Source: AJdET5cDi3zZ1EdV1QNuRur9qOIhjENx2NXBnIEiulkKZQ3h9Ib+RMMeRWQHHmmrYYDLTfioDu7OY753+dwG
X-Received: by 2002:a17:902:d212:: with SMTP id t18mr279714ply.97.1542154461973;
 Tue, 13 Nov 2018 16:14:21 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:13:03 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-21-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 20/23] commit-graph: convert remaining functions to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
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
2.19.1.1215.g8438c0b245-goog

