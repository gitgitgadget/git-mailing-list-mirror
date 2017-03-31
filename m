Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011CA1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbdCaOML (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:12:11 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48983 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933257AbdCaOME (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:12:04 -0400
X-AuditID: 1207440d-029ff70000003721-15-58de63b2d0f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CC.20.14113.2B36ED85; Fri, 31 Mar 2017 10:12:02 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBw010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:12:01 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/20] cache_ref_iterator_begin(): make function smarter
Date:   Fri, 31 Mar 2017 16:11:15 +0200
Message-Id: <4be692203dbb726612efbafd1ea983feed350760.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqLsp+V6Ewa+NlhZrn91hsui60s1k
        0dB7hdni9or5zBZLHr5mtuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHl3tR9g8
        nvXuYfS4eEnZ4/MmuQD2KC6blNSczLLUIn27BK6MU/cesxQctq+Y/XAnUwPjEeMuRk4OCQET
        ickn5rOA2EICO5gktt4062LkArJPMkncWLIBLMEmoCuxqKeZCcQWEVCTmNh2iAWkiFngDZPE
        gS2/wIqEBbwlTp2/zgZiswioSlw8fwgszisQJfF+8TUmiG3yErvaLrKC2JwCFhLrZh5ih9hs
        LrFg7QS2CYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKEhBrvDsb/
        62QOMQpwMCrx8J7wvhchxJpYVlyZe4hRkoNJSZTXNxwoxJeUn1KZkVicEV9UmpNafIhRgoNZ
        SYSXKQ4ox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4K1IAmoULEpN
        T61Iy8wpQUgzcXCCDOcBGp4CUsNbXJCYW5yZDpE/xagoJc7LCpIQAElklObB9cJSwStGcaBX
        hHm9QKp4gGkErvsV0GAmoMEWX++CDC5JREhJNTC2XNT49W1xuVWUippHy/yNp1+sU3874a38
        7Mff85rE/gvqsTc+Ox9S0zI7irGyYYvooscb36yy7533NfJwifqhfNFLVV2OBuwc2a6mO1eG
        HGy9IhrOUpLFUnqmeb3WyslLTYIy420PlnMszK55WuL8frtCiPR7qdlzfwvsjhAUNnrxauep
        16VKLMUZiYZazEXFiQB5+fq34AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change `cache_ref_iterator_begin()` to take two new arguments:

* `prefix` -- to iterate only over references with the specified
  prefix.

* `prime_dir` -- to "prime" (i.e., pre-load) the cache before starting
  the iteration.

The new functionality makes it possible for
`files_ref_iterator_begin()` to be made more ignorant of the internals
of `ref_cache`, and `find_containing_dir()` and `prime_ref_dir()` to
be made private.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 44 +++++++++++++-------------------------------
 refs/ref-cache.c     | 38 ++++++++++++++++++++++++++++++++++----
 refs/ref-cache.h     | 27 +++++++++------------------
 3 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fefc29433a..736a6c9ff7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1083,7 +1083,6 @@ static struct ref_iterator *files_ref_iterator_begin(
 		const char *prefix, unsigned int flags)
 {
 	struct files_ref_store *refs;
-	struct ref_dir *loose_dir, *packed_dir;
 	struct ref_iterator *loose_iter, *packed_iter;
 	struct files_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
@@ -1109,41 +1108,24 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * condition if loose refs are migrated to the packed-refs
 	 * file by a simultaneous process, but our in-memory view is
 	 * from before the migration. We ensure this as follows:
-	 * First, we call prime_ref_dir(), which pre-reads the loose
-	 * references for the subtree into the cache. (If they've
-	 * already been read, that's OK; we only need to guarantee
-	 * that they're read before the packed refs, not *how much*
-	 * before.) After that, we call get_packed_ref_cache(), which
-	 * internally checks whether the packed-ref cache is up to
-	 * date with what is on disk, and re-reads it if not.
+	 * First, we call start the loose refs iteration with its
+	 * `prime_ref` argument set to true. This causes the loose
+	 * references in the subtree to be pre-read into the cache.
+	 * (If they've already been read, that's OK; we only need to
+	 * guarantee that they're read before the packed refs, not
+	 * *how much* before.) After that, we call
+	 * get_packed_ref_cache(), which internally checks whether the
+	 * packed-ref cache is up to date with what is on disk, and
+	 * re-reads it if not.
 	 */
 
-	loose_dir = get_loose_ref_dir(refs);
-
-	if (prefix && *prefix)
-		loose_dir = find_containing_dir(loose_dir, prefix, 0);
-
-	if (loose_dir) {
-		prime_ref_dir(loose_dir);
-		loose_iter = cache_ref_iterator_begin(loose_dir);
-	} else {
-		/* There's nothing to iterate over. */
-		loose_iter = empty_ref_iterator_begin();
-	}
+	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
+					      prefix, 1);
 
 	iter->packed_ref_cache = get_packed_ref_cache(refs);
 	acquire_packed_ref_cache(iter->packed_ref_cache);
-	packed_dir = get_packed_ref_dir(iter->packed_ref_cache);
-
-	if (prefix && *prefix)
-		packed_dir = find_containing_dir(packed_dir, prefix, 0);
-
-	if (packed_dir) {
-		packed_iter = cache_ref_iterator_begin(packed_dir);
-	} else {
-		/* There's nothing to iterate over. */
-		packed_iter = empty_ref_iterator_begin();
-	}
+	packed_iter = cache_ref_iterator_begin(iter->packed_ref_cache->cache,
+					       prefix, 0);
 
 	iter->iter0 = overlay_ref_iterator_begin(loose_iter, packed_iter);
 	iter->flags = flags;
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 38d4c31985..b3a30350d7 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -177,8 +177,17 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 	return get_ref_dir(entry);
 }
 
-struct ref_dir *find_containing_dir(struct ref_dir *dir,
-				    const char *refname, int mkdir)
+/*
+ * If refname is a reference name, find the ref_dir within the dir
+ * tree that should hold refname. If refname is a directory name
+ * (i.e., it ends in '/'), then return that ref_dir itself. dir must
+ * represent the top-level directory and must already be complete.
+ * Sort ref_dirs and recurse into subdirectories as necessary. If
+ * mkdir is set, then create any missing directories; otherwise,
+ * return NULL if the desired directory cannot be found.
+ */
+static struct ref_dir *find_containing_dir(struct ref_dir *dir,
+					   const char *refname, int mkdir)
 {
 	const char *slash;
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
@@ -328,7 +337,11 @@ int do_for_each_entry_in_dir(struct ref_dir *dir,
 	return 0;
 }
 
-void prime_ref_dir(struct ref_dir *dir)
+/*
+ * Load all of the refs from `dir` (recursively) into our in-memory
+ * cache.
+ */
+static void prime_ref_dir(struct ref_dir *dir)
 {
 	/*
 	 * The hard work of loading loose refs is done by get_ref_dir(), so we
@@ -494,12 +507,25 @@ static struct ref_iterator_vtable cache_ref_iterator_vtable = {
 	cache_ref_iterator_abort
 };
 
-struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *dir)
+struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
+					      const char *prefix,
+					      int prime_dir)
 {
+	struct ref_dir *dir;
 	struct cache_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 	struct cache_ref_iterator_level *level;
 
+	dir = get_ref_dir(cache->root);
+	if (prefix && *prefix)
+		dir = find_containing_dir(dir, prefix, 0);
+	if (!dir)
+		/* There's nothing to iterate over. */
+		return  empty_ref_iterator_begin();
+
+	if (prime_dir)
+		prime_ref_dir(dir);
+
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable);
@@ -510,5 +536,9 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *dir)
 	level->index = -1;
 	level->dir = dir;
 
+	if (prefix && *prefix)
+		ref_iterator = prefix_ref_iterator_begin(ref_iterator,
+							 prefix, 0);
+
 	return ref_iterator;
 }
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 6eecdf4276..5e7a918ac0 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -234,18 +234,6 @@ int remove_entry_from_dir(struct ref_dir *dir, const char *refname);
  */
 int add_ref_entry(struct ref_dir *dir, struct ref_entry *ref);
 
-/*
- * If refname is a reference name, find the ref_dir within the dir
- * tree that should hold refname. If refname is a directory name
- * (i.e., it ends in '/'), then return that ref_dir itself. dir must
- * represent the top-level directory and must already be complete.
- * Sort ref_dirs and recurse into subdirectories as necessary. If
- * mkdir is set, then create any missing directories; otherwise,
- * return NULL if the desired directory cannot be found.
- */
-struct ref_dir *find_containing_dir(struct ref_dir *dir,
-				    const char *refname, int mkdir);
-
 /*
  * Find the value entry with the given name in dir, sorting ref_dirs
  * and recursing into subdirectories as necessary.  If the name is not
@@ -253,7 +241,15 @@ struct ref_dir *find_containing_dir(struct ref_dir *dir,
  */
 struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname);
 
-struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *dir);
+/*
+ * Start iterating over references in `cache`. If `prefix` is
+ * specified, only include references whose names start with that
+ * prefix. If `prime_dir` is true, then fill any incomplete
+ * directories before beginning the iteration.
+ */
+struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
+					      const char *prefix,
+					      int prime_dir);
 
 typedef int each_ref_entry_fn(struct ref_entry *entry, void *cb_data);
 
@@ -279,9 +275,4 @@ int do_for_each_entry_in_dir(struct ref_dir *dir,
  */
 enum peel_status peel_entry(struct ref_entry *entry, int repeel);
 
-/*
- * Load all of the refs from `dir` into our in-memory cache.
- */
-void prime_ref_dir(struct ref_dir *dir);
-
 #endif /* REFS_REF_CACHE_H */
-- 
2.11.0

