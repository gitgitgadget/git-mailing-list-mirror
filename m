Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0D02047F
	for <e@80x24.org>; Wed, 27 Sep 2017 22:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbdI0WTR (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 18:19:17 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:53683 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdI0WTP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 18:19:15 -0400
Received: by mail-pg0-f49.google.com with SMTP id j70so8524637pgc.10
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JJu/+vrOCTt+1K9hTDPrfhDrrv4hmTaakX8BXHBERww=;
        b=ojt+BZJdGXj0lNi5daZd6zd2WcFrEK+NvJUhMoAE1nhaJqBw0QTS4H5FQAI7iDDba1
         iKpRS4mI7VwQrRZxjrqKD5sTf195TtYV1k/I/RtaVIOfkuwfBl26OZKX5/bKncvLEJVI
         vcCITNpZnOd8bvDUjuiDqo6X9bH+5Jsx5XeOuWMUfyx/uDDNdvu+qqsBYZAmslS718xX
         G0fkU3n9ET6Kcz9oP3byDUJ5w4j37i48CwvWMYyFZWJrEFttkqg4+umR4weALHHDfeUX
         HV0FUDR98G3EMWHAV8PtajAO65s23lkUv3Q4h1i01IlPSBnrYL4c/rkSWVKWG7R/LvTA
         wa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JJu/+vrOCTt+1K9hTDPrfhDrrv4hmTaakX8BXHBERww=;
        b=eXZneZNf2h9l4trluPd41Ui8tG+nU5WmgRTiH6h/2jEN1/3u4QUJUUuldYqfJhLXTH
         /sQGa0YsWfKr6xFjsaUNaPuq+C7RE+NDgimqbmn1L7ueSfpgTqu8kY3PpEU8mdpPjRCT
         Xzo7FA7W9+0uXboV5mZSaM56Kt0oYehgg8FfdmIcXQWj67uglekQFTI/WyN8/6i6zQPC
         lF9HoCFl1i8zMOrJvHRo/q4R+pr5ZJ4SwBvfygCHelV2ehEtWM/1Q14s+QpDXYmVRs4I
         KpoaWnZmo/4G7KA7toGf4B70qCLawUd5qDWAOct6WFh4KLZWcbqugKW9stg2o0tR5tCQ
         6vXQ==
X-Gm-Message-State: AHPjjUhif0qac3RsWCqFemiTHyF4dUyHwGLWtrgMKNgMAA1P4vUe7GjY
        OyzOtt4HQ26UlQ67z8TCpwpvOa7GZq0=
X-Google-Smtp-Source: AOwi7QDPiVe6/2TkYZVpZ2lRSefmlXxACgkGsWY65PyPrBOtOvwmUo7a2pEAjaQ9HfBKZD7rETX4fg==
X-Received: by 10.98.202.138 with SMTP id y10mr2464104pfk.151.1506550754049;
        Wed, 27 Sep 2017 15:19:14 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id h9sm8848pfh.98.2017.09.27.15.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 15:19:13 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@jeffhostetler.com
Subject: [PATCH] oidmap: map with OID as key
Date:   Wed, 27 Sep 2017 15:19:10 -0700
Message-Id: <20170927221910.164552-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.2.606.g7451fcdc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to using the hashmap in hashmap.c, but with an
easier-to-use API. In particular, custom entry comparisons no longer
need to be written, and lookups can be done without constructing a
temporary entry structure.

oidset has been updated to use oidmap.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I have been wishing for an OID map for a while, and it seems to me that
Jeff Hostetler's recent patches [1] could use one too, so here it is.

(Also, I wonder if some details such as grow_at, shrink_at, and
do_count_items can be removed, since the applications of this are
narrower than that of hashmap.)

[1] https://public-inbox.org/git/20170922202632.53714-1-git@jeffhostetler.com/
---
 Makefile |   1 +
 oidmap.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 oidmap.h |  98 ++++++++++++++++++++++++++++++++++++++++
 oidset.c |  38 ++++------------
 oidset.h |   4 +-
 5 files changed, 263 insertions(+), 30 deletions(-)
 create mode 100644 oidmap.c
 create mode 100644 oidmap.h

diff --git a/Makefile b/Makefile
index ed4ca438b..64136dde4 100644
--- a/Makefile
+++ b/Makefile
@@ -821,6 +821,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pack-bitmap.o
diff --git a/oidmap.c b/oidmap.c
new file mode 100644
index 000000000..40e696cee
--- /dev/null
+++ b/oidmap.c
@@ -0,0 +1,152 @@
+#include "cache.h"
+#include "oidmap.h"
+
+#define OIDMAP_INITIAL_SIZE 64
+/* grow / shrink by 2^2 */
+#define OIDMAP_RESIZE_BITS 2
+/* load factor in percent */
+#define OIDMAP_LOAD_FACTOR 80
+
+static void alloc_table(struct oidmap *map, unsigned int size)
+{
+	map->tablesize = size;
+	map->table = xcalloc(size, sizeof(struct oidmap_entry *));
+
+	/* calculate resize thresholds for new size */
+	map->grow_at = (unsigned int) ((uint64_t) size * OIDMAP_LOAD_FACTOR / 100);
+	if (size <= OIDMAP_INITIAL_SIZE)
+		map->shrink_at = 0;
+	else
+		/*
+		 * The shrink-threshold must be slightly smaller than
+		 * (grow-threshold / resize-factor) to prevent erratic resizing,
+		 * thus we divide by (resize-factor + 1).
+		 */
+		map->shrink_at = map->grow_at / ((1 << OIDMAP_RESIZE_BITS) + 1);
+}
+
+static inline unsigned int bucket(const struct oidmap *map,
+				  const struct object_id *key)
+{
+	unsigned int hash;
+	memcpy(&hash, key->hash, sizeof(hash));
+	return hash & (map->tablesize - 1);
+}
+
+static void rehash(struct oidmap *map, unsigned int newsize)
+{
+	unsigned int i, oldsize = map->tablesize;
+	struct oidmap_entry **oldtable = map->table;
+
+	alloc_table(map, newsize);
+	for (i = 0; i < oldsize; i++) {
+		struct oidmap_entry *e = oldtable[i];
+		while (e) {
+			struct oidmap_entry *next = e->next;
+			unsigned int b = bucket(map, &e->oid);
+			e->next = map->table[b];
+			map->table[b] = e;
+			e = next;
+		}
+	}
+	free(oldtable);
+}
+
+static inline struct oidmap_entry **find_entry_ptr(const struct oidmap *map,
+						   const struct object_id *key)
+{
+	struct oidmap_entry **e = &map->table[bucket(map, key)];
+	while (*e && oidcmp(&(*e)->oid, key))
+		e = &(*e)->next;
+	return e;
+}
+
+void oidmap_init(struct oidmap *map, size_t initial_size)
+{
+	unsigned int size = OIDMAP_INITIAL_SIZE;
+
+	memset(map, 0, sizeof(*map));
+
+	/* calculate initial table size and allocate the table */
+	initial_size = (unsigned int) ((uint64_t) initial_size * 100
+			/ OIDMAP_LOAD_FACTOR);
+	while (initial_size > size)
+		size <<= OIDMAP_RESIZE_BITS;
+	alloc_table(map, size);
+
+	/*
+	 * Keep track of the number of items in the map and
+	 * allow the map to automatically grow as necessary.
+	 */
+	map->do_count_items = 1;
+}
+
+void oidmap_free(struct oidmap *map, int free_entries)
+{
+	if (!map || !map->table)
+		return;
+	if (free_entries) {
+		int i;
+		for (i = 0; i < map->tablesize; i++) {
+			struct oidmap_entry *e = map->table[i];
+			while (e) {
+				struct oidmap_entry *next = e->next;
+				free(e);
+				e = next;
+			}
+		}
+	}
+	free(map->table);
+	memset(map, 0, sizeof(*map));
+}
+
+void *oidmap_get(const struct oidmap *map, const struct object_id *key)
+{
+	return *find_entry_ptr(map, key);
+}
+
+static void oidmap_add(struct oidmap *map, struct oidmap_entry *entry)
+{
+	unsigned int b = bucket(map, &entry->oid);
+
+	/* add entry */
+	entry->next = map->table[b];
+	map->table[b] = entry;
+
+	/* fix size and rehash if appropriate */
+	if (map->do_count_items) {
+		map->private_size++;
+		if (map->private_size > map->grow_at)
+			rehash(map, map->tablesize << OIDMAP_RESIZE_BITS);
+	}
+}
+
+void *oidmap_remove(struct oidmap *map, const struct object_id *key)
+{
+	struct oidmap_entry *old;
+	struct oidmap_entry **e = find_entry_ptr(map, key);
+	if (!*e)
+		return NULL;
+
+	/* remove existing entry */
+	old = *e;
+	*e = old->next;
+	old->next = NULL;
+
+	/* fix size and rehash if appropriate */
+	if (map->do_count_items) {
+		map->private_size--;
+		if (map->private_size < map->shrink_at)
+			rehash(map, map->tablesize >> OIDMAP_RESIZE_BITS);
+	}
+
+	return old;
+}
+
+void *oidmap_put(struct oidmap *map, void *entry)
+{
+	struct oidmap_entry *to_put = entry;
+	struct oidmap_entry *old = oidmap_remove(map, &to_put->oid);
+	oidmap_add(map, to_put);
+	return old;
+}
diff --git a/oidmap.h b/oidmap.h
new file mode 100644
index 000000000..a543ed828
--- /dev/null
+++ b/oidmap.h
@@ -0,0 +1,98 @@
+#ifndef OIDMAP_H
+#define OIDMAP_H
+
+/*
+ * struct oidmap_entry is a structure representing an entry in the hash table,
+ * which must be used as first member of user data structures. It must be
+ * zero-initialized (or use OIDMAP_ENTRY_INIT).
+ */
+struct oidmap_entry {
+	/*
+	 * next points to the next entry in case of collisions (i.e. if
+	 * multiple entries map to the same bucket). For oidmap's internal use
+	 * only.
+	 */
+	struct oidmap_entry *next;
+
+	struct object_id oid;
+};
+#define OIDMAP_ENTRY_INIT { NULL }
+
+/*
+ * struct oidmap is the hash table structure. Members can be used as follows,
+ * but should not be modified directly.
+ */
+struct oidmap {
+	struct oidmap_entry **table;
+
+	/* total number of entries (0 means the hashmap is empty) */
+	unsigned int private_size; /* use oidmap_get_size() */
+
+	/*
+	 * tablesize is the allocated size of the hash table. A non-0 value
+	 * indicates that the hashmap is initialized. It may also be useful
+	 * for statistical purposes (i.e. `size / tablesize` is the current
+	 * load factor).
+	 */
+	unsigned int tablesize;
+
+	unsigned int grow_at;
+	unsigned int shrink_at;
+
+	unsigned int do_count_items : 1;
+};
+
+/* oidmap functions */
+
+/*
+ * Initializes an oidmap structure.
+ *
+ * `map` is the oidmap to initialize.
+ *
+ * If the total number of entries is known in advance, the `initial_size`
+ * parameter may be used to preallocate a sufficiently large table and thus
+ * prevent expensive resizing. If 0, the table is dynamically resized.
+ */
+extern void oidmap_init(struct oidmap *map, size_t initial_size);
+
+/*
+ * Frees an oidmap structure and allocated memory.
+ *
+ * If `free_entries` is true, each oidmap_entry in the map is freed as well
+ * using stdlibs free().
+ */
+extern void oidmap_free(struct oidmap *map, int free_entries);
+
+/*
+ * Return the number of items in the map.
+ */
+static inline unsigned int oidmap_get_size(struct oidmap *map)
+{
+	if (map->do_count_items)
+		return map->private_size;
+
+	BUG("oidmap_get_size: size not set");
+	return 0;
+}
+
+/*
+ * Returns the oidmap entry for the specified oid, or NULL if not found.
+ */
+extern void *oidmap_get(const struct oidmap *map,
+			const struct object_id *key);
+
+/*
+ * Adds or replaces an oidmap entry.
+ *
+ * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
+ */
+extern void *oidmap_put(struct oidmap *map, void *entry);
+
+/*
+ * Removes an oidmap entry matching the specified oid.
+ *
+ * Returns the removed entry, or NULL if not found.
+ */
+extern void *oidmap_remove(struct oidmap *map, const struct object_id *key);
+
+#endif
diff --git a/oidset.c b/oidset.c
index a6a08ba52..6fe7036c4 100644
--- a/oidset.c
+++ b/oidset.c
@@ -1,50 +1,30 @@
 #include "cache.h"
 #include "oidset.h"
 
-struct oidset_entry {
-	struct hashmap_entry hash;
-	struct object_id oid;
-};
-
-static int oidset_hashcmp(const void *unused_cmp_data,
-			  const void *va, const void *vb,
-			  const void *vkey)
-{
-	const struct oidset_entry *a = va, *b = vb;
-	const struct object_id *key = vkey;
-	return oidcmp(&a->oid, key ? key : &b->oid);
-}
-
 int oidset_contains(const struct oidset *set, const struct object_id *oid)
 {
-	struct hashmap_entry key;
-
-	if (!set->map.cmpfn)
+	if (!set->map.tablesize)
 		return 0;
-
-	hashmap_entry_init(&key, sha1hash(oid->hash));
-	return !!hashmap_get(&set->map, &key, oid);
+	return !!oidmap_get(&set->map, oid);
 }
 
 int oidset_insert(struct oidset *set, const struct object_id *oid)
 {
-	struct oidset_entry *entry;
-
-	if (!set->map.cmpfn)
-		hashmap_init(&set->map, oidset_hashcmp, NULL, 0);
+	struct oidmap_entry *entry;
 
-	if (oidset_contains(set, oid))
+	if (!set->map.tablesize)
+		oidmap_init(&set->map, 0);
+	else if (oidset_contains(set, oid))
 		return 1;
 
-	entry = xmalloc(sizeof(*entry));
-	hashmap_entry_init(&entry->hash, sha1hash(oid->hash));
+	entry = xcalloc(1, sizeof(*entry));
 	oidcpy(&entry->oid, oid);
 
-	hashmap_add(&set->map, entry);
+	oidmap_put(&set->map, entry);
 	return 0;
 }
 
 void oidset_clear(struct oidset *set)
 {
-	hashmap_free(&set->map, 1);
+	oidmap_free(&set->map, 1);
 }
diff --git a/oidset.h b/oidset.h
index b7eaab5b8..b1ec82bfc 100644
--- a/oidset.h
+++ b/oidset.h
@@ -1,6 +1,8 @@
 #ifndef OIDSET_H
 #define OIDSET_H
 
+#include "oidmap.h"
+
 /**
  * This API is similar to sha1-array, in that it maintains a set of object ids
  * in a memory-efficient way. The major differences are:
@@ -17,7 +19,7 @@
  * A single oidset; should be zero-initialized (or use OIDSET_INIT).
  */
 struct oidset {
-	struct hashmap map;
+	struct oidmap map;
 };
 
 #define OIDSET_INIT { { NULL } }
-- 
2.14.2.822.g60be5d43e6-goog

