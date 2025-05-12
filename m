Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE122D4FF
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747075832; cv=none; b=m939ITGzuFHDiOducsN1a5NQRPDoqA475Vc3Vn2GtUYEf90K6b5HyipRywCS1LbFF0EFzY+SD3IWH+dciOsVjVX2aNN2xdOwUwDvgQ1hSHt0DVFIoZBPfQhd1VlQnQR99LOJRzOqxBieyeuihtzgopDA7OB3467smKdpp6r8rV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747075832; c=relaxed/simple;
	bh=Vmf/Lsa5RAHxbYod+BMxDOO3Ev8w/UMue07eCZn0OMc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/TokczGhilwmAkHTZm7hwbgyctVdKQFgVLX07L+QPzBICdDMJzWcXAsFm9SU04vtC9yveEFGSiRFwkRPqJ5fejfVk4ssF19SpcLyGx1rmMiS4daQrf48d4w3irg3kCVmfK7TK82hwP1GxaC4EiNgl/QECkKvOTs0GQvjNBRCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WhwTYutN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WhwTYutN"
Received: (qmail 3440 invoked by uid 109); 12 May 2025 18:50:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Vmf/Lsa5RAHxbYod+BMxDOO3Ev8w/UMue07eCZn0OMc=; b=WhwTYutNNUbuQ2fd5FFrm85x4hsNgCa0yybeIgtPgMHYeTqtX9rA7Rr8W8BlD8GqZCr5UGVAQP3lVPGdQQAcisLs441lZ/uzeKPsZtWVUO/Rj+fJEcdHK+iX7lV10y5aH/7uq1epCbOejCsFWVrMuMW/2IwTBrel1+93LZJ/0cEzyFaPMqZ0pD7xiSGX4jrtb+X5UibYLhJZU1a6FyFXtd7oD7RdaxbEK3VJFBoJ5Je364O4LDQw7rVIEZj9/QKPIBAVL3L8NN8bWJYhLcOEFw1yJxFYVmV857CKqrGHLFMf1xs5+dZrWY4X56Hs3gGHVeLgW0jQlwFK3AoVPNotdw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 May 2025 18:50:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10349 invoked by uid 111); 12 May 2025 18:50:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 May 2025 14:50:30 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 May 2025 14:50:28 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/3] oidmap: rename oidmap_free() to oidmap_clear()
Message-ID: <20250512185028.GA1276214@coredump.intra.peff.net>
References: <20250512185006.GA1275914@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512185006.GA1275914@coredump.intra.peff.net>

This function does not free the oidmap struct itself; it just drops all
items from the map (using hashmap_clear_() internally). It should be
called oidmap_clear(), per CodingGuidelines.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c      | 2 +-
 list-objects-filter.c   | 2 +-
 object-store.c          | 2 +-
 oidmap.c                | 2 +-
 oidmap.h                | 5 +++--
 sequencer.c             | 4 ++--
 t/unit-tests/u-oidmap.c | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c4cd4ed5c8..0984b607bf 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -924,7 +924,7 @@ int cmd_rev_list(int argc,
 			free((void *)entry->path);
 		}
 
-		oidmap_free(&missing_objects, true);
+		oidmap_clear(&missing_objects, true);
 	}
 
 	stop_progress(&progress);
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 7765761b3c..78b397bc19 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -244,7 +244,7 @@ static void filter_trees_free(void *filter_data) {
 	struct filter_trees_depth_data *d = filter_data;
 	if (!d)
 		return;
-	oidmap_free(&d->seen_at_depth, 1);
+	oidmap_clear(&d->seen_at_depth, 1);
 	free(d);
 }
 
diff --git a/object-store.c b/object-store.c
index 6ab50d25d3..bc24e80829 100644
--- a/object-store.c
+++ b/object-store.c
@@ -1017,7 +1017,7 @@ void raw_object_store_clear(struct raw_object_store *o)
 {
 	FREE_AND_NULL(o->alternate_db);
 
-	oidmap_free(o->replace_map, 1);
+	oidmap_clear(o->replace_map, 1);
 	FREE_AND_NULL(o->replace_map);
 	pthread_mutex_destroy(&o->replace_mutex);
 
diff --git a/oidmap.c b/oidmap.c
index 8b1bc4dec9..508d6c7dec 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -22,7 +22,7 @@ void oidmap_init(struct oidmap *map, size_t initial_size)
 	hashmap_init(&map->map, oidmap_neq, NULL, initial_size);
 }
 
-void oidmap_free(struct oidmap *map, int free_entries)
+void oidmap_clear(struct oidmap *map, int free_entries)
 {
 	if (!map)
 		return;
diff --git a/oidmap.h b/oidmap.h
index fad412827a..603ae1adbc 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -36,12 +36,13 @@ struct oidmap {
 void oidmap_init(struct oidmap *map, size_t initial_size);
 
 /*
- * Frees an oidmap structure and allocated memory.
+ * Clear an oidmap, freeing any allocated memory. The map is empty and
+ * can be reused without another explicit init.
  *
  * If `free_entries` is true, each oidmap_entry in the map is freed as well
  * using stdlibs free().
  */
-void oidmap_free(struct oidmap *map, int free_entries);
+void oidmap_clear(struct oidmap *map, int free_entries);
 
 /*
  * Returns the oidmap entry for the specified oid, or NULL if not found.
diff --git a/sequencer.c b/sequencer.c
index b5c4043757..7fa24db143 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6053,8 +6053,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	oidset_clear(&interesting);
 	oidset_clear(&child_seen);
 	oidset_clear(&shown);
-	oidmap_free(&commit2todo, 1);
-	oidmap_free(&state.commit2label, 1);
+	oidmap_clear(&commit2todo, 1);
+	oidmap_clear(&state.commit2label, 1);
 	hashmap_clear_and_free(&state.labels, struct labels_entry, entry);
 	strbuf_release(&state.buf);
 
diff --git a/t/unit-tests/u-oidmap.c b/t/unit-tests/u-oidmap.c
index dc805b7e3c..b23af449f6 100644
--- a/t/unit-tests/u-oidmap.c
+++ b/t/unit-tests/u-oidmap.c
@@ -35,7 +35,7 @@ void test_oidmap__initialize(void)
 
 void test_oidmap__cleanup(void)
 {
-	oidmap_free(&map, 1);
+	oidmap_clear(&map, 1);
 }
 
 void test_oidmap__replace(void)
-- 
2.49.0.821.gd3b3298025

