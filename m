Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37AD31F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 23:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfJFXbo (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 19:31:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39654 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfJFXbo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 19:31:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2AF2B1F4DC;
        Sun,  6 Oct 2019 23:30:48 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 20/20] hashmap_entry: remove first member requirement from docs
Date:   Sun,  6 Oct 2019 23:30:43 +0000
Message-Id: <20191006233043.3516-21-e@80x24.org>
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
References: <20191006233043.3516-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Comments stating that "struct hashmap_entry" must be the first
member in a struct are no longer valid.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Eric Wong <e@80x24.org>
---
 attr.c                  | 2 +-
 builtin/fetch.c         | 2 +-
 hashmap.h               | 4 ++--
 merge-recursive.h       | 4 ++--
 ref-filter.c            | 2 +-
 refs.c                  | 2 +-
 remote.h                | 2 +-
 sub-process.h           | 2 +-
 t/helper/test-hashmap.c | 1 +
 9 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/attr.c b/attr.c
index 15f0efdf60..e5c951db69 100644
--- a/attr.c
+++ b/attr.c
@@ -62,7 +62,7 @@ static struct attr_hashmap g_attr_hashmap;
 
 /* The container for objects stored in "struct attr_hashmap" */
 struct attr_hash_entry {
-	struct hashmap_entry ent; /* must be the first member! */
+	struct hashmap_entry ent;
 	const char *key; /* the key; memory should be owned by value */
 	size_t keylen; /* length of the key */
 	void *value; /* the stored value */
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 09f7170616..a3154a4edb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -251,7 +251,7 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 }
 
 struct refname_hash_entry {
-	struct hashmap_entry ent; /* must be the first member */
+	struct hashmap_entry ent;
 	struct object_id oid;
 	int ignore;
 	char refname[FLEX_ARRAY];
diff --git a/hashmap.h b/hashmap.h
index bf4a05937d..bd2701549f 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -13,7 +13,7 @@
  *
  * struct hashmap map;
  * struct long2string {
- *     struct hashmap_entry ent; // must be the first member!
+ *     struct hashmap_entry ent;
  *     long key;
  *     char value[FLEX_ARRAY];   // be careful with allocating on stack!
  * };
@@ -141,7 +141,7 @@ static inline unsigned int oidhash(const struct object_id *oid)
 
 /*
  * struct hashmap_entry is an opaque structure representing an entry in the
- * hash table, which must be used as first member of user data structures.
+ * hash table.
  * Ideally it should be followed by an int-sized member to prevent unused
  * memory on 64-bit systems due to alignment.
  */
diff --git a/merge-recursive.h b/merge-recursive.h
index c2b7bb65c6..daa742568e 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -50,7 +50,7 @@ struct merge_options {
  *                       in get_directory_renames() for details
  */
 struct dir_rename_entry {
-	struct hashmap_entry ent; /* must be the first member! */
+	struct hashmap_entry ent;
 	char *dir;
 	unsigned non_unique_new_dir:1;
 	struct strbuf new_dir;
@@ -58,7 +58,7 @@ struct dir_rename_entry {
 };
 
 struct collision_entry {
-	struct hashmap_entry ent; /* must be the first member! */
+	struct hashmap_entry ent;
 	char *target_file;
 	struct string_list source_files;
 	unsigned reported_already:1;
diff --git a/ref-filter.c b/ref-filter.c
index 0950b789e3..5c10a343c6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -79,7 +79,7 @@ static struct expand_data {
 } oi, oi_deref;
 
 struct ref_to_worktree_entry {
-	struct hashmap_entry ent; /* must be the first member! */
+	struct hashmap_entry ent;
 	struct worktree *wt; /* key is wt->head_ref */
 };
 
diff --git a/refs.c b/refs.c
index 2d3eb40f39..1ab0bb54d3 100644
--- a/refs.c
+++ b/refs.c
@@ -1772,7 +1772,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 
 struct ref_store_hash_entry
 {
-	struct hashmap_entry ent; /* must be the first member! */
+	struct hashmap_entry ent;
 
 	struct ref_store *refs;
 
diff --git a/remote.h b/remote.h
index 83e885672b..0e1d2b245b 100644
--- a/remote.h
+++ b/remote.h
@@ -14,7 +14,7 @@ enum {
 };
 
 struct remote {
-	struct hashmap_entry ent;  /* must be first */
+	struct hashmap_entry ent;
 
 	const char *name;
 	int origin, configured_in_repo;
diff --git a/sub-process.h b/sub-process.h
index 0d12708b8c..e85f21fa1a 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -24,7 +24,7 @@
 
 /* Members should not be accessed directly. */
 struct subprocess_entry {
-	struct hashmap_entry ent; /* must be the first member! */
+	struct hashmap_entry ent;
 	const char *cmd;
 	struct child_process process;
 };
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index cc577c8956..f38706216f 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -5,6 +5,7 @@
 
 struct test_entry
 {
+	int padding; /* hashmap entry no longer needs to be the first member */
 	struct hashmap_entry ent;
 	/* key and value as two \0-terminated strings */
 	char key[FLEX_ARRAY];
