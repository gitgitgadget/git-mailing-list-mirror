Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298831F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 22:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390600AbeGKWtb (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 18:49:31 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:35534 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeGKWtb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 18:49:31 -0400
Received: by mail-vk0-f73.google.com with SMTP id x125-v6so8293312vke.2
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=obPQOt3gNoPFhOV2//jOeRay1kJ9hbqUtcNezJX3MNc=;
        b=f9oUNdtdlM86+hSW489xTFGvNHlCAiPWdIf5P4eTG7v0N5jJTfnRxIxgbp6VpJYQTk
         Z3im+0v2QwPQBtTlExs7NBnsvSHtsrImzfqRve8QawCGVuaz3AQF7SZGyvs+JUCkKZvP
         FlgBUZjVJ6dpL61t8eQrJjvU2I0NiaPaeBS/U/ZnZzge23ct/ybO+TQSQbIRatVWmuXY
         bWiMScG6v2Jbwja/ha3r5P1klTi5YieC165gGZg03dXv+1qQGoiZRujPDooPpNO1Ldve
         xt9GEyp2nyfomaBKkcmuPtGfoXeD5JPDcrbZ5OG9wbe8RKwbO2kCrGlcJ+0w739o10dc
         dNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=obPQOt3gNoPFhOV2//jOeRay1kJ9hbqUtcNezJX3MNc=;
        b=qkGuQ47JWUYwlPcbkGG6f4GBytKG3m7YeI6b+7aQBUoTNkXPQDPG+W7d+lcH62Hnjv
         PYWN/uB+Y7gAIL093vTAfQE4uKI80qR119evF0bx3iQy+nTUlQkMXFWNk2cuc55ev06l
         oDoLedbYyXs3ThlhwT/Ds/BhsB5grLott9aXIHXb4g2pZcANRgZPAdRDJk6jXoXnWF1G
         GxPDXdOhk7UhttGw5adqt9DWYYI10MS1j7Zd5S9Dp6LoYLaVSQMrz128euKkweVVD3d7
         V5Q1VkVMaIo51naOvUA3rQdFhDZx5aCa/A/9EyFQ5uxuq0UAt3C/QkdBot0waUBilFm0
         VqZQ==
X-Gm-Message-State: AOUpUlHUS69CjEVpHE3LNVvu8IOI244VJRczok2ruNSFvwvk0EoQk5Vs
        326953tPcNCBCar78sT3EWEAfyXGb0KKdwIwCRCnd2Qff8AH0lwruYeddjXcPyntafB4Kzk35BE
        9QPs6C5qOHtqMdmjmP3iUHCW/pdJih/G0WZJN/8WsewDq+Q1hH/f0FVStiG+wLULcSyormA+keV
        X0
X-Google-Smtp-Source: AAOMgpe09KUzN5PvPJ6mug7UZS+Xuki/w5tinh/gHeUryj68ZKBoULB0kXABOGgEPL8vdC81+J/a88tjCQOsuH2FuZkX
MIME-Version: 1.0
X-Received: by 2002:a1f:3de:: with SMTP id f91-v6mr268443vki.1.1531348979980;
 Wed, 11 Jul 2018 15:42:59 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:42:41 -0700
In-Reply-To: <cover.1531348540.git.jonathantanmy@google.com>
Message-Id: <a045aef6d3a8600759c8186b41fa9c4960d65176.1531348540.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531348540.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v3 5/6] commit-graph: store graph in struct object_store
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of storing commit graphs in static variables, store them in
struct object_store. There are no changes to the signatures of existing
functions - they all still only support the_repository, and support for
other instances of struct repository will be added in a subsequent
commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 commit-graph.c | 40 +++++++++++++++++++---------------------
 object-store.h |  3 +++
 object.c       |  5 +++++
 3 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 143a587581..b6a76a1413 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -183,24 +183,20 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	exit(1);
 }
 
-/* global storage */
-static struct commit_graph *commit_graph = NULL;
-
 static void prepare_commit_graph_one(const char *obj_dir)
 {
 	char *graph_name;
 
-	if (commit_graph)
+	if (the_repository->objects->commit_graph)
 		return;
 
 	graph_name = get_commit_graph_filename(obj_dir);
-	commit_graph = load_commit_graph_one(graph_name);
+	the_repository->objects->commit_graph =
+		load_commit_graph_one(graph_name);
 
 	FREE_AND_NULL(graph_name);
 }
 
-static int prepare_commit_graph_run_once = 0;
-
 /*
  * Return 1 if commit_graph is non-NULL, and 0 otherwise.
  *
@@ -212,9 +208,9 @@ static int prepare_commit_graph(void)
 	struct alternate_object_database *alt;
 	char *obj_dir;
 
-	if (prepare_commit_graph_run_once)
-		return !!commit_graph;
-	prepare_commit_graph_run_once = 1;
+	if (the_repository->objects->commit_graph_attempted)
+		return !!the_repository->objects->commit_graph;
+	the_repository->objects->commit_graph_attempted = 1;
 
 	if (!core_commit_graph)
 		return 0;
@@ -223,16 +219,16 @@ static int prepare_commit_graph(void)
 	prepare_commit_graph_one(obj_dir);
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects->alt_odb_list;
-	     !commit_graph && alt;
+	     !the_repository->objects->commit_graph && alt;
 	     alt = alt->next)
 		prepare_commit_graph_one(alt->path);
-	return !!commit_graph;
+	return !!the_repository->objects->commit_graph;
 }
 
 static void close_commit_graph(void)
 {
-	free_commit_graph(commit_graph);
-	commit_graph = NULL;
+	free_commit_graph(the_repository->objects->commit_graph);
+	the_repository->objects->commit_graph = NULL;
 }
 
 static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
@@ -342,7 +338,7 @@ int parse_commit_in_graph(struct commit *item)
 {
 	if (!prepare_commit_graph())
 		return 0;
-	return parse_commit_in_graph_one(commit_graph, item);
+	return parse_commit_in_graph_one(the_repository->objects->commit_graph, item);
 }
 
 void load_commit_graph_info(struct commit *item)
@@ -350,8 +346,8 @@ void load_commit_graph_info(struct commit *item)
 	uint32_t pos;
 	if (!prepare_commit_graph())
 		return;
-	if (find_commit_in_graph(item, commit_graph, &pos))
-		fill_commit_graph_info(item, commit_graph, pos);
+	if (find_commit_in_graph(item, the_repository->objects->commit_graph, &pos))
+		fill_commit_graph_info(item, the_repository->objects->commit_graph, pos);
 }
 
 static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
@@ -379,7 +375,7 @@ static struct tree *get_commit_tree_in_graph_one(struct commit_graph *g,
 
 struct tree *get_commit_tree_in_graph(const struct commit *c)
 {
-	return get_commit_tree_in_graph_one(commit_graph, c);
+	return get_commit_tree_in_graph_one(the_repository->objects->commit_graph, c);
 }
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -696,15 +692,17 @@ void write_commit_graph(const char *obj_dir,
 
 	if (append) {
 		prepare_commit_graph_one(obj_dir);
-		if (commit_graph)
-			oids.alloc += commit_graph->num_commits;
+		if (the_repository->objects->commit_graph)
+			oids.alloc += the_repository->objects->commit_graph->num_commits;
 	}
 
 	if (oids.alloc < 1024)
 		oids.alloc = 1024;
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
-	if (append && commit_graph) {
+	if (append && the_repository->objects->commit_graph) {
+		struct commit_graph *commit_graph =
+			the_repository->objects->commit_graph;
 		for (i = 0; i < commit_graph->num_commits; i++) {
 			const unsigned char *hash = commit_graph->chunk_oid_lookup +
 				commit_graph->hash_len * i;
diff --git a/object-store.h b/object-store.h
index 0e13543bab..e481f7ad41 100644
--- a/object-store.h
+++ b/object-store.h
@@ -106,6 +106,9 @@ struct raw_object_store {
 	 */
 	struct oidmap *replace_map;
 
+	struct commit_graph *commit_graph;
+	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
+
 	/*
 	 * private data
 	 *
diff --git a/object.c b/object.c
index b0faab85d4..e2c112cc1a 100644
--- a/object.c
+++ b/object.c
@@ -9,6 +9,7 @@
 #include "alloc.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "commit-graph.h"
 
 unsigned int get_max_object_index(void)
 {
@@ -507,6 +508,10 @@ void raw_object_store_clear(struct raw_object_store *o)
 	oidmap_free(o->replace_map, 1);
 	FREE_AND_NULL(o->replace_map);
 
+	free_commit_graph(o->commit_graph);
+	o->commit_graph = NULL;
+	o->commit_graph_attempted = 0;
+
 	free_alt_odbs(o);
 	o->alt_odb_tail = NULL;
 
-- 
2.18.0.203.gfac676dfb9-goog

