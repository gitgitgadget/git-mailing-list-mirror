Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444FBC433E9
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 23:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197FD207BB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 23:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgL2XzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 18:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgL2XzT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 18:55:19 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3326C06179E
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 15:54:38 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o17so34276935lfg.4
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 15:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5zVxCKNU0XKxztAJfIs6Z3+5g0jvrMJaBGwrXuObjo=;
        b=apy/pIbDnDwLSQY2fMGGP9goky6K7ODRCoYl0NhNgtxUyaVsWm+AgWgvTKW2uHCcaY
         82pqSjTsgbscJPKcFYOzKPb/Pgx5wKtzyusgePJGkGsFnqLuTRvNZBD7Xx37anVr8GVp
         E+cnfOrv3QKdIXR6a2whI9FLeSpjIOvCJAlJgxW5lu7KozsCOzjasBxHYGI0cnAhWD4g
         aXgiyjvkF8cEXjDv/25N3nYP3kuPNPZ39okZG7IcXnTAtT/8a9Ai3n8pOZGG9x0Rcces
         ZiuBtVpzA/lpChgX9PSG095s4lUEkZjECDhwQQ0tteLTm2py5hlRqOXo8CicRiRTAKrR
         LeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5zVxCKNU0XKxztAJfIs6Z3+5g0jvrMJaBGwrXuObjo=;
        b=UTlq+RcXYTb/QqyHxlAbQXwKit3ZL8kyAfUiWIzn6FvwxoGFvb6u2hmBn4pvBM2vaW
         djlaZnJScDzdt6La9FoqzeZIQG9PyKjdllueepw+ei6zaOOuED6CKm4UFBVznJgrhuTx
         ymkmS1DF2AdLjE8g89NoHAEX8+ZwaDjJckj3c3vWoGQnfvSS+4brR48m/4aAmVtgNdQw
         xH3JSd/eHE1imM6A1z5K/60HWhNsVUX3pjhosOnD5zDnS8ciC3hBBnA4iO6RZvRGI983
         M84FXOwQfBf53dk3QxDXgbPFgEj++LyP3kznYIbe5lJRyOAzywf5iAwevWgkUhzsU8i8
         ifCA==
X-Gm-Message-State: AOAM530Fk/3te11PM0QCWL6P9ZiATP0b1ScqM2AwJNqx9vFaKwgGZh+e
        tW8bGgKh708f2mQbIdmb4LKA349WURA=
X-Google-Smtp-Source: ABdhPJwhFHJQs55++eHRXGcBXZ9R62AhU3NHKpTHS7ltIf6PvOGLQPCaG2shxftFbQuiFKSQ8n5YAg==
X-Received: by 2002:a2e:2244:: with SMTP id i65mr26515229lji.111.1609286077017;
        Tue, 29 Dec 2020 15:54:37 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id q25sm5777240lfd.282.2020.12.29.15.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 15:54:36 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/4] sha1-lookup: rename `sha1_pos()` as `hash_pos()`
Date:   Wed, 30 Dec 2020 00:52:59 +0100
Message-Id: <8d3b123633d37218587bb2e71232631dea420156.1609282997.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609282997.git.martin.agren@gmail.com>
References: <cover.1609282997.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename this function to reflect that we're not just able to handle SHA-1
these days. There are a few instances of "sha1" left in sha1-lookup.[ch]
after this, but those will be addressed in the next commit.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 sha1-lookup.h       | 6 +++---
 builtin/name-rev.c  | 2 +-
 commit-graph.c      | 6 +++---
 commit.c            | 2 +-
 oid-array.c         | 2 +-
 pack-bitmap-write.c | 2 +-
 rerere.c            | 2 +-
 sha1-lookup.c       | 8 ++++----
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sha1-lookup.h b/sha1-lookup.h
index 5afcd011c6..79973d4785 100644
--- a/sha1-lookup.h
+++ b/sha1-lookup.h
@@ -1,12 +1,12 @@
 #ifndef SHA1_LOOKUP_H
 #define SHA1_LOOKUP_H
 
-typedef const unsigned char *sha1_access_fn(size_t index, void *table);
+typedef const unsigned char *hash_access_fn(size_t index, void *table);
 
-int sha1_pos(const unsigned char *sha1,
+int hash_pos(const unsigned char *hash,
 	     void *table,
 	     size_t nr,
-	     sha1_access_fn fn);
+	     hash_access_fn fn);
 
 /*
  * Searches for sha1 in table, using the given fanout table to determine the
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 725dd04519..4939ceb2e5 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -408,7 +408,7 @@ static const char *get_exact_ref_match(const struct object *o)
 		tip_table.sorted = 1;
 	}
 
-	found = sha1_pos(o->oid.hash, tip_table.table, tip_table.nr,
+	found = hash_pos(o->oid.hash, tip_table.table, tip_table.nr,
 			 nth_tip_table_ent);
 	if (0 <= found)
 		return tip_table.table[found].refname;
diff --git a/commit-graph.c b/commit-graph.c
index 06f8dc1d89..c672feee91 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1043,7 +1043,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 		if (!parent)
 			edge_value = GRAPH_PARENT_NONE;
 		else {
-			edge_value = sha1_pos(parent->item->object.oid.hash,
+			edge_value = hash_pos(parent->item->object.oid.hash,
 					      ctx->commits.list,
 					      ctx->commits.nr,
 					      commit_to_sha1);
@@ -1074,7 +1074,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 		else if (parent->next)
 			edge_value = GRAPH_EXTRA_EDGES_NEEDED | num_extra_edges;
 		else {
-			edge_value = sha1_pos(parent->item->object.oid.hash,
+			edge_value = hash_pos(parent->item->object.oid.hash,
 					      ctx->commits.list,
 					      ctx->commits.nr,
 					      commit_to_sha1);
@@ -1143,7 +1143,7 @@ static int write_graph_chunk_extra_edges(struct hashfile *f,
 
 		/* Since num_parents > 2, this initializer is safe. */
 		for (parent = (*list)->parents->next; parent; parent = parent->next) {
-			int edge_value = sha1_pos(parent->item->object.oid.hash,
+			int edge_value = hash_pos(parent->item->object.oid.hash,
 						  ctx->commits.list,
 						  ctx->commits.nr,
 						  commit_to_sha1);
diff --git a/commit.c b/commit.c
index fe1fa3dc41..0b7bace022 100644
--- a/commit.c
+++ b/commit.c
@@ -113,7 +113,7 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 
 int commit_graft_pos(struct repository *r, const unsigned char *sha1)
 {
-	return sha1_pos(sha1, r->parsed_objects->grafts,
+	return hash_pos(sha1, r->parsed_objects->grafts,
 			r->parsed_objects->grafts_nr,
 			commit_graft_sha1_access);
 }
diff --git a/oid-array.c b/oid-array.c
index 8e1bcedc0c..fb4c3dd795 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -31,7 +31,7 @@ static const unsigned char *sha1_access(size_t index, void *table)
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 {
 	oid_array_sort(array);
-	return sha1_pos(oid->hash, array->oid, array->nr, sha1_access);
+	return hash_pos(oid->hash, array->oid, array->nr, sha1_access);
 }
 
 void oid_array_clear(struct oid_array *array)
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 5e998bdaa7..27ece05ec7 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -482,7 +482,7 @@ static void write_selected_commits_v1(struct hashfile *f,
 		struct bitmapped_commit *stored = &writer.selected[i];
 
 		int commit_pos =
-			sha1_pos(stored->commit->object.oid.hash, index, index_nr, sha1_access);
+			hash_pos(stored->commit->object.oid.hash, index, index_nr, sha1_access);
 
 		if (commit_pos < 0)
 			BUG("trying to write commit not in index");
diff --git a/rerere.c b/rerere.c
index 9281131a9f..9fc76eb756 100644
--- a/rerere.c
+++ b/rerere.c
@@ -147,7 +147,7 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 
 	if (get_sha1_hex(hex, hash))
 		return NULL; /* BUG */
-	pos = sha1_pos(hash, rerere_dir, rerere_dir_nr, rerere_dir_hash);
+	pos = hash_pos(hash, rerere_dir, rerere_dir_nr, rerere_dir_hash);
 	if (pos < 0) {
 		rr_dir = xmalloc(sizeof(*rr_dir));
 		hashcpy(rr_dir->hash, hash);
diff --git a/sha1-lookup.c b/sha1-lookup.c
index 29185844ec..45489edfe8 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -47,11 +47,11 @@ static uint32_t take2(const unsigned char *sha1)
  */
 /*
  * The table should contain "nr" elements.
- * The sha1 of element i (between 0 and nr - 1) should be returned
+ * The hash of element i (between 0 and nr - 1) should be returned
  * by "fn(i, table)".
  */
-int sha1_pos(const unsigned char *hash, void *table, size_t nr,
-	     sha1_access_fn fn)
+int hash_pos(const unsigned char *hash, void *table, size_t nr,
+	     hash_access_fn fn)
 {
 	size_t hi = nr;
 	size_t lo = 0;
@@ -74,7 +74,7 @@ int sha1_pos(const unsigned char *hash, void *table, size_t nr,
 			if (lov != hiv) {
 				/*
 				 * At this point miv could be equal
-				 * to hiv (but sha1 could still be higher);
+				 * to hiv (but hash could still be higher);
 				 * the invariant of (mi < hi) should be
 				 * kept.
 				 */
-- 
2.30.0

