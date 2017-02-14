Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D95C2013A
	for <e@80x24.org>; Tue, 14 Feb 2017 11:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdBNLdR (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 06:33:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:53062 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbdBNLcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 06:32:31 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8NWM-1cPezt3Yp8-00w0PB; Tue, 14
 Feb 2017 12:32:23 +0100
Date:   Tue, 14 Feb 2017 12:32:18 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] name-hash: precompute hash values during preload-index
In-Reply-To: <cover.1487071883.git.johannes.schindelin@gmx.de>
Message-ID: <8621305c69898e012720d4fe66d42b096f053073.1487071883.git.johannes.schindelin@gmx.de>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:x6GxIOpMve3xsN7Ti2JgCklTZ0g4fjE5AyqmUJeiSdBbQyfGEb0
 vy4dRcNW1dll1T4UndscXQu452un952+Q5WhS1Dc972c+XPyPVrjQ5LLaPU421WZBusWGJI
 v0EV8unMFnGy2BAk6egDSli4RHK6aDnKSf17Uanr0ivgr7RxqTy9jxBkYb0SCa5e4SLlrgJ
 Qd+BmYCT3j/wG7p+qJkEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KWSIOHdjCHo=:m81IEhsbV9tPf+N91+wy6f
 l5yF7dIg3hUeZrqmLcnFwP84peS0pj+4a0UdRNt+WzFMbRMDSqCG2FZbx4yFVJQxk14ImpCTs
 +U5UT6LnXAE6qynI0RMHkzCWh/aTGq6F1gAz71HOjGxdx9v1QJ8e+yrljzS58S+o+3/kuxJVI
 RHc1ykB3Wj06Q+DkmBukJKcfHPIsyC1+VzXybnkp6PJBdnZeO+3TPrryuv/CbYiRFVInWuw7W
 fXFNEvevKKGYhE/B0+Zc7psrnvVPC54iqGkFWa3B7lZwRQry2DKqfjx/5rdrgnInrfCimEe+9
 v4snsAQj0+cy4hHjhSmIOaDNJp4zOXNR3jjqvlGooFg/9ZBZXwlbjQPlu3rjWJJM0KIYd36Dj
 izEFGh1daBdFzEloh7rvUd7jtQcKmlWOEXNHVFNJpo/Mtl9hkfI8xJTz7AEHoAT+f8/su1qYp
 yIhIWkMzk+8f0A4NHpbYBp/LyyRfNW6KhDD2AogkTwtRfUSxht2D85sxVVTM+aZSiapo+a7TB
 hyjB0MQcaLgKJ3ehZGQy5omqno5sGdSM8sWbA6IeglyuXxPosN6MBccZH5tcl+jw9fNgxpuSs
 p7P9Dg+1YhMgNVmcLIQWQgCFhYfcigozL6k3EPguCYoUjnP64CBwyzg3XiVPCKr2x2ML+kvMb
 nv0vQXhiD2zot/BeBw7wZuFbb0k/ypRpqCTGVWjs99/68DYm860Ek7ojZb9+qX3by98Vegi7D
 Q24K+A17d5BJg6iESZVr87C6fNzEnMZIUktQLfOZWkkpZ5sscM09AaFhL5V//gefs0HWBRWQw
 HGxeFPH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Precompute the istate.name_hash and istate.dir_hash values
for each cache-entry during the preload-index phase.

Move the expensive memihash() calculations from lazy_init_name_hash()
to the multi-threaded preload-index phase.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h         |  6 ++++++
 name-hash.c     | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 preload-index.c |  2 ++
 read-cache.c    |  3 +++
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 61fc86e6d71..56f7c97cdbe 100644
--- a/cache.h
+++ b/cache.h
@@ -173,6 +173,10 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned int index;	/* for link extension */
+	struct {
+		unsigned initialized:1, root_entry:1;
+		unsigned int name, dir;
+	} precomputed_hash;
 	struct object_id oid;
 	char name[FLEX_ARRAY]; /* more */
 };
@@ -229,6 +233,8 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
 
+void precompute_istate_hashes(struct cache_entry *ce);
+
 /* Forward structure decls */
 struct pathspec;
 struct child_process;
diff --git a/name-hash.c b/name-hash.c
index ad0bc0cef73..49eb84846df 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -50,6 +50,10 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 	 */
 	struct dir_entry *dir;
 	unsigned int hash;
+	int orig_namelen = namelen;
+
+	if (ce->precomputed_hash.initialized && ce->precomputed_hash.root_entry)
+		return NULL; /* item does not have a parent directory */
 
 	/* get length of parent directory */
 	while (namelen > 0 && !is_dir_sep(ce->name[namelen - 1]))
@@ -59,7 +63,10 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 	namelen--;
 
 	/* lookup existing entry for that directory */
-	hash = memihash(ce->name, namelen);
+	if (ce->precomputed_hash.initialized && orig_namelen == ce_namelen(ce))
+		hash = ce->precomputed_hash.dir;
+	else
+		hash = memihash(ce->name, namelen);
 	dir = find_dir_entry_1(istate, ce->name, namelen, hash);
 	if (!dir) {
 		/* not found, create it and add to hash table */
@@ -99,10 +106,18 @@ static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
 
 static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 {
+	unsigned int h;
+
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
-	hashmap_entry_init(ce, memihash(ce->name, ce_namelen(ce)));
+
+	if (ce->precomputed_hash.initialized)
+		h = ce->precomputed_hash.name;
+	else
+		h = memihash(ce->name, ce_namelen(ce));
+
+	hashmap_entry_init(ce, h);
 	hashmap_add(&istate->name_hash, ce);
 
 	if (ignore_case)
@@ -244,3 +259,41 @@ void free_name_hash(struct index_state *istate)
 	hashmap_free(&istate->name_hash, 0);
 	hashmap_free(&istate->dir_hash, 1);
 }
+
+/*
+ * Precompute the hash values for this cache_entry
+ * for use in the istate.name_hash and istate.dir_hash.
+ *
+ * If the item is in the root directory, just compute the hash value (for
+ * istate.name_hash) on the full path.
+ *
+ * If the item is in a subdirectory, first compute the hash value for the
+ * immediate parent directory (for istate.dir_hash) and then the hash value for
+ * the full path by continuing the computation.
+ *
+ * Note that these hashes will be used by wt_status_collect_untracked() as it
+ * scans the worktree and maps observed paths back to the index (optionally
+ * ignoring case). Technically, we only *NEED* to precompute this for
+ * non-skip-worktree items (since status should not observe skipped items), but
+ * because lazy_init_name_hash() hashes everything, we force it here.
+ */
+void precompute_istate_hashes(struct cache_entry *ce)
+{
+	int namelen = ce_namelen(ce);
+
+	while (namelen > 0 && !is_dir_sep(ce->name[namelen - 1]))
+		namelen--;
+
+	if (namelen <= 0) {
+		ce->precomputed_hash.name = memihash(ce->name, ce_namelen(ce));
+		ce->precomputed_hash.root_entry = 1;
+	} else {
+		namelen--;
+		ce->precomputed_hash.dir = memihash(ce->name, namelen);
+		ce->precomputed_hash.name = memihash_continue(
+			ce->precomputed_hash.dir, ce->name + namelen,
+			ce_namelen(ce) - namelen);
+		ce->precomputed_hash.root_entry = 0;
+	}
+	ce->precomputed_hash.initialized = 1;
+}
diff --git a/preload-index.c b/preload-index.c
index c1fe3a3ef9c..602737f9d0f 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -47,6 +47,8 @@ static void *preload_thread(void *_data)
 		struct cache_entry *ce = *cep++;
 		struct stat st;
 
+		precompute_istate_hashes(ce);
+
 		if (ce_stage(ce))
 			continue;
 		if (S_ISGITLINK(ce->ce_mode))
diff --git a/read-cache.c b/read-cache.c
index 9054369dd0c..1a25c345441 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -73,6 +73,7 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 	copy_cache_entry(new, old);
 	new->ce_flags &= ~CE_HASHED;
 	new->ce_namelen = namelen;
+	new->precomputed_hash.initialized = 0;
 	new->index = 0;
 	memcpy(new->name, new_name, namelen + 1);
 
@@ -614,6 +615,7 @@ static struct cache_entry *create_alias_ce(struct index_state *istate,
 	new = xcalloc(1, cache_entry_size(len));
 	memcpy(new->name, alias->name, len);
 	copy_cache_entry(new, ce);
+	new->precomputed_hash.initialized = 0;
 	save_or_free_index_entry(istate, ce);
 	return new;
 }
@@ -1446,6 +1448,7 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 	ce->ce_stat_data.sd_size  = get_be32(&ondisk->size);
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
+	ce->precomputed_hash.initialized = 0;
 	ce->index = 0;
 	hashcpy(ce->oid.hash, ondisk->sha1);
 	memcpy(ce->name, name, len);
-- 
2.11.1.windows.1


