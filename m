Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA8DC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B132087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElYeSSyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgKKUCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgKKUCa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:30 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDD4C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:30 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so3688904wrr.13
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eD1ODDn8YazYa2TxKvej2ageSWRW9od1dWKHaSlyndc=;
        b=ElYeSSyPfr3Y48QAOgOESeLh6VqSH+QckVyEonFzgFXUvw8TANgPp1BMcm357vaJW8
         Z4RQ9StOTF3IndZEbbjKLUyaYoQ5YbK0soZ3pVeQqRDluJZJoK29poU1Vle3uaocSuIj
         ITmU8D86ogEXlleJMkNVE+pdW3cRhBN1wH6Pd5x2r8KYIxuNUgGbbamNQrrQyhPlJVk2
         +IXosO1JmZygo7+gLdusppcTBXvL2mY/mR+ZTUMhpsWYFod6qulTU17o9qAjgpO9cyWD
         ZYVImkvq11f9oYdbM2P/6ia555JEMklFc7P4DZCov4bzZGD9S+RWu09yRTug3nsvBkj/
         H0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eD1ODDn8YazYa2TxKvej2ageSWRW9od1dWKHaSlyndc=;
        b=hO9U03TcQ1kWUkxn85km9og8U8pEC+vvQmNBJ4hdVaLSpkq6yslOuhUFLWYwv//DNx
         1owfFZgyUNpgiuIRrDcdKF/suZjPai9CqSEW0H/MqVp5DlhCBt37TNLsTexjuRZg4V3X
         GKzO7+D9g6kixAgQbQYR+YsXFwZmurcZSFLFaXTZlxb3btKZzNHHOpHwSwSnFj21ZD1O
         8Sbnt5AbBMhQvrc8D/lX/LbJgaTOqinNQRRzfd/PMVzIXBWFo7RHRdePEmdqZ4TH9fyT
         F8CKdMBKfU1JPJDqiKg7Ko8/jCQyQOllOmLlCMeNIR3VHVecs0BJOVt56zIcRnJ6PBP+
         DsdA==
X-Gm-Message-State: AOAM533hs1ZmlInbKvw/4RS0/Ufb8dIE7sdrz8Twv/ANS//muOyWr1lo
        fu+rbiRifSklABDUGdXfHR6UcfqOMfk=
X-Google-Smtp-Source: ABdhPJznfvAtEja8h1BsmBKS1Fruyjl4ztlNIZLceN5PJ1repXYAQ60f7bGqEWKzNBqIgscQo4Lq9A==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr21926858wrm.403.1605124948280;
        Wed, 11 Nov 2020 12:02:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m126sm3768386wmm.0.2020.11.11.12.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:27 -0800 (PST)
Message-Id: <861e8d65ae8065595d9d4ccff5f70155fec408c9.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:11 +0000
Subject: [PATCH v6 05/15] hashmap: provide deallocation function names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

hashmap_free(), hashmap_free_entries(), and hashmap_free_() have existed
for a while, but aren't necessarily the clearest names, especially with
hashmap_partial_clear() being added to the mix and lazy-initialization
now being supported.  Peff suggested we adopt the following names[1]:

  - hashmap_clear() - remove all entries and de-allocate any
    hashmap-specific data, but be ready for reuse

  - hashmap_clear_and_free() - ditto, but free the entries themselves

  - hashmap_partial_clear() - remove all entries but don't deallocate
    table

  - hashmap_partial_clear_and_free() - ditto, but free the entries

This patch provides the new names and converts all existing callers over
to the new naming scheme.

[1] https://lore.kernel.org/git/20201030125059.GA3277724@coredump.intra.peff.net/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-interactive.c       |  2 +-
 blame.c                 |  2 +-
 bloom.c                 |  2 +-
 builtin/fetch.c         |  6 +++---
 builtin/shortlog.c      |  2 +-
 config.c                |  2 +-
 diff.c                  |  4 ++--
 diffcore-rename.c       |  2 +-
 dir.c                   |  8 ++++----
 hashmap.c               |  6 +++---
 hashmap.h               | 44 +++++++++++++++++++++++++----------------
 merge-recursive.c       |  6 +++---
 name-hash.c             |  4 ++--
 object.c                |  2 +-
 oidmap.c                |  2 +-
 patch-ids.c             |  2 +-
 range-diff.c            |  2 +-
 ref-filter.c            |  2 +-
 revision.c              |  2 +-
 sequencer.c             |  4 ++--
 submodule-config.c      |  4 ++--
 t/helper/test-hashmap.c |  6 +++---
 22 files changed, 63 insertions(+), 53 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 555c4abf32..a14c0feaa2 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -557,7 +557,7 @@ static int get_modified_files(struct repository *r,
 		if (ps)
 			clear_pathspec(&rev.prune_data);
 	}
-	hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
+	hashmap_clear_and_free(&s.file_map, struct pathname_entry, ent);
 	if (unmerged_count)
 		*unmerged_count = s.unmerged_count;
 	if (binary_count)
diff --git a/blame.c b/blame.c
index 686845b2b4..229beb6452 100644
--- a/blame.c
+++ b/blame.c
@@ -435,7 +435,7 @@ static void get_fingerprint(struct fingerprint *result,
 
 static void free_fingerprint(struct fingerprint *f)
 {
-	hashmap_free(&f->map);
+	hashmap_clear(&f->map);
 	free(f->entries);
 }
 
diff --git a/bloom.c b/bloom.c
index 68c73200a5..719c313a1c 100644
--- a/bloom.c
+++ b/bloom.c
@@ -287,7 +287,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 		}
 
 	cleanup:
-		hashmap_free_entries(&pathmap, struct pathmap_hash_entry, entry);
+		hashmap_clear_and_free(&pathmap, struct pathmap_hash_entry, entry);
 	} else {
 		for (i = 0; i < diff_queued_diff.nr; i++)
 			diff_free_filepair(diff_queued_diff.queue[i]);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f9c3c49f14..ecf8537605 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -393,7 +393,7 @@ static void find_non_local_tags(const struct ref *refs,
 		item = refname_hash_add(&remote_refs, ref->name, &ref->old_oid);
 		string_list_insert(&remote_refs_list, ref->name);
 	}
-	hashmap_free_entries(&existing_refs, struct refname_hash_entry, ent);
+	hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
 
 	/*
 	 * We may have a final lightweight tag that needs to be
@@ -428,7 +428,7 @@ static void find_non_local_tags(const struct ref *refs,
 		**tail = rm;
 		*tail = &rm->next;
 	}
-	hashmap_free_entries(&remote_refs, struct refname_hash_entry, ent);
+	hashmap_clear_and_free(&remote_refs, struct refname_hash_entry, ent);
 	string_list_clear(&remote_refs_list, 0);
 	oidset_clear(&fetch_oids);
 }
@@ -573,7 +573,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		}
 	}
 	if (existing_refs_populated)
-		hashmap_free_entries(&existing_refs, struct refname_hash_entry, ent);
+		hashmap_clear_and_free(&existing_refs, struct refname_hash_entry, ent);
 
 	return ref_map;
 }
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 0a5c4968f6..83f0a739b4 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -220,7 +220,7 @@ static void strset_clear(struct strset *ss)
 {
 	if (!ss->map.table)
 		return;
-	hashmap_free_entries(&ss->map, struct strset_item, ent);
+	hashmap_clear_and_free(&ss->map, struct strset_item, ent);
 }
 
 static void insert_records_from_trailers(struct shortlog *log,
diff --git a/config.c b/config.c
index 2bdff4457b..8f324ed3a6 100644
--- a/config.c
+++ b/config.c
@@ -1963,7 +1963,7 @@ void git_configset_clear(struct config_set *cs)
 		free(entry->key);
 		string_list_clear(&entry->value_list, 1);
 	}
-	hashmap_free_entries(&cs->config_hash, struct config_set_element, ent);
+	hashmap_clear_and_free(&cs->config_hash, struct config_set_element, ent);
 	cs->hash_initialized = 0;
 	free(cs->list.items);
 	cs->list.nr = 0;
diff --git a/diff.c b/diff.c
index 2bb2f8f57e..8e0e59f5cf 100644
--- a/diff.c
+++ b/diff.c
@@ -6289,9 +6289,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
 				dim_moved_lines(o);
 
-			hashmap_free_entries(&add_lines, struct moved_entry,
+			hashmap_clear_and_free(&add_lines, struct moved_entry,
 						ent);
-			hashmap_free_entries(&del_lines, struct moved_entry,
+			hashmap_clear_and_free(&del_lines, struct moved_entry,
 						ent);
 		}
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 99e63e90f8..d367a6d244 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -407,7 +407,7 @@ static int find_exact_renames(struct diff_options *options)
 		renames += find_identical_files(&file_table, i, options);
 
 	/* Free the hash data structure and entries */
-	hashmap_free_entries(&file_table, struct file_similarity, entry);
+	hashmap_clear_and_free(&file_table, struct file_similarity, entry);
 
 	return renames;
 }
diff --git a/dir.c b/dir.c
index 78387110e6..161dce121e 100644
--- a/dir.c
+++ b/dir.c
@@ -817,8 +817,8 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 
 clear_hashmaps:
 	warning(_("disabling cone pattern matching"));
-	hashmap_free_entries(&pl->parent_hashmap, struct pattern_entry, ent);
-	hashmap_free_entries(&pl->recursive_hashmap, struct pattern_entry, ent);
+	hashmap_clear_and_free(&pl->parent_hashmap, struct pattern_entry, ent);
+	hashmap_clear_and_free(&pl->recursive_hashmap, struct pattern_entry, ent);
 	pl->use_cone_patterns = 0;
 }
 
@@ -921,8 +921,8 @@ void clear_pattern_list(struct pattern_list *pl)
 		free(pl->patterns[i]);
 	free(pl->patterns);
 	free(pl->filebuf);
-	hashmap_free_entries(&pl->recursive_hashmap, struct pattern_entry, ent);
-	hashmap_free_entries(&pl->parent_hashmap, struct pattern_entry, ent);
+	hashmap_clear_and_free(&pl->recursive_hashmap, struct pattern_entry, ent);
+	hashmap_clear_and_free(&pl->parent_hashmap, struct pattern_entry, ent);
 
 	memset(pl, 0, sizeof(*pl));
 }
diff --git a/hashmap.c b/hashmap.c
index 922ed07954..5009471800 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -183,7 +183,7 @@ static void free_individual_entries(struct hashmap *map, ssize_t entry_offset)
 	while ((e = hashmap_iter_next(&iter)))
 		/*
 		 * like container_of, but using caller-calculated
-		 * offset (caller being hashmap_free_entries)
+		 * offset (caller being hashmap_clear_and_free)
 		 */
 		free((char *)e - entry_offset);
 }
@@ -199,11 +199,11 @@ void hashmap_partial_clear_(struct hashmap *map, ssize_t entry_offset)
 	map->private_size = 0;
 }
 
-void hashmap_free_(struct hashmap *map, ssize_t entry_offset)
+void hashmap_clear_(struct hashmap *map, ssize_t entry_offset)
 {
 	if (!map || !map->table)
 		return;
-	if (entry_offset >= 0)  /* called by hashmap_free_entries */
+	if (entry_offset >= 0)  /* called by hashmap_clear_and_free */
 		free_individual_entries(map, entry_offset);
 	free(map->table);
 	memset(map, 0, sizeof(*map));
diff --git a/hashmap.h b/hashmap.h
index e9430d582a..7251687d73 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -96,7 +96,7 @@
  *         }
  *
  *         if (!strcmp("end", action)) {
- *             hashmap_free_entries(&map, struct long2string, ent);
+ *             hashmap_clear_and_free(&map, struct long2string, ent);
  *             break;
  *         }
  *     }
@@ -237,7 +237,7 @@ void hashmap_init(struct hashmap *map,
 
 /* internal functions for clearing or freeing hashmap */
 void hashmap_partial_clear_(struct hashmap *map, ssize_t offset);
-void hashmap_free_(struct hashmap *map, ssize_t offset);
+void hashmap_clear_(struct hashmap *map, ssize_t offset);
 
 /*
  * Frees a hashmap structure and allocated memory for the table, but does not
@@ -253,40 +253,50 @@ void hashmap_free_(struct hashmap *map, ssize_t offset);
  *      free(e->somefield);
  *      free(e);
  *    }
- *    hashmap_free(map);
+ *    hashmap_clear(map);
  *
  * instead of
  *
  *    hashmap_for_each_entry(map, hashmap_iter, e, hashmap_entry_name) {
  *      free(e->somefield);
  *    }
- *    hashmap_free_entries(map, struct my_entry_struct, hashmap_entry_name);
+ *    hashmap_clear_and_free(map, struct my_entry_struct, hashmap_entry_name);
  *
  * to avoid the implicit extra loop over the entries.  However, if there are
  * no special fields in your entry that need to be freed beyond the entry
  * itself, it is probably simpler to avoid the explicit loop and just call
- * hashmap_free_entries().
+ * hashmap_clear_and_free().
  */
-#define hashmap_free(map) hashmap_free_(map, -1)
+#define hashmap_clear(map) hashmap_clear_(map, -1)
 
 /*
- * Basically the same as calling hashmap_free() followed by hashmap_init(),
- * but doesn't incur the overhead of deallocating and reallocating
- * map->table; it leaves map->table allocated and the same size but zeroes
- * it out so it's ready for use again as an empty map.  As with
- * hashmap_free(), you may need to free the entries yourself before calling
- * this function.
+ * Similar to hashmap_clear(), except that the table is no deallocated; it
+ * is merely zeroed out but left the same size as before.  If the hashmap
+ * will be reused, this avoids the overhead of deallocating and
+ * reallocating map->table.  As with hashmap_clear(), you may need to free
+ * the entries yourself before calling this function.
  */
 #define hashmap_partial_clear(map) hashmap_partial_clear_(map, -1)
 
 /*
- * Frees @map and all entries.  @type is the struct type of the entry
- * where @member is the hashmap_entry struct used to associate with @map.
+ * Similar to hashmap_clear() but also frees all entries.  @type is the
+ * struct type of the entry where @member is the hashmap_entry struct used
+ * to associate with @map.
  *
- * See usage note above hashmap_free().
+ * See usage note above hashmap_clear().
  */
-#define hashmap_free_entries(map, type, member) \
-	hashmap_free_(map, offsetof(type, member));
+#define hashmap_clear_and_free(map, type, member) \
+	hashmap_clear_(map, offsetof(type, member))
+
+/*
+ * Similar to hashmap_partial_clear() but also frees all entries.  @type is
+ * the struct type of the entry where @member is the hashmap_entry struct
+ * used to associate with @map.
+ *
+ * See usage note above hashmap_clear().
+ */
+#define hashmap_partial_clear_and_free(map, type, member) \
+	hashmap_partial_clear_(map, offsetof(type, member))
 
 /* hashmap_entry functions */
 
diff --git a/merge-recursive.c b/merge-recursive.c
index d0214335a7..f736a0f632 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2651,7 +2651,7 @@ static struct string_list *get_renames(struct merge_options *opt,
 		free(e->target_file);
 		string_list_clear(&e->source_files, 0);
 	}
-	hashmap_free_entries(&collisions, struct collision_entry, ent);
+	hashmap_clear_and_free(&collisions, struct collision_entry, ent);
 	return renames;
 }
 
@@ -2870,7 +2870,7 @@ static void initial_cleanup_rename(struct diff_queue_struct *pairs,
 		strbuf_release(&e->new_dir);
 		/* possible_new_dirs already cleared in get_directory_renames */
 	}
-	hashmap_free_entries(dir_renames, struct dir_rename_entry, ent);
+	hashmap_clear_and_free(dir_renames, struct dir_rename_entry, ent);
 	free(dir_renames);
 
 	free(pairs->queue);
@@ -3497,7 +3497,7 @@ static int merge_trees_internal(struct merge_options *opt,
 		string_list_clear(entries, 1);
 		free(entries);
 
-		hashmap_free_entries(&opt->priv->current_file_dir_set,
+		hashmap_clear_and_free(&opt->priv->current_file_dir_set,
 					struct path_hashmap_entry, e);
 
 		if (clean < 0) {
diff --git a/name-hash.c b/name-hash.c
index fb526a3775..5d3c7b12c1 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -726,6 +726,6 @@ void free_name_hash(struct index_state *istate)
 		return;
 	istate->name_hash_initialized = 0;
 
-	hashmap_free(&istate->name_hash);
-	hashmap_free_entries(&istate->dir_hash, struct dir_entry, ent);
+	hashmap_clear(&istate->name_hash);
+	hashmap_clear_and_free(&istate->dir_hash, struct dir_entry, ent);
 }
diff --git a/object.c b/object.c
index 3257518656..b8406409d5 100644
--- a/object.c
+++ b/object.c
@@ -532,7 +532,7 @@ void raw_object_store_clear(struct raw_object_store *o)
 	close_object_store(o);
 	o->packed_git = NULL;
 
-	hashmap_free(&o->pack_map);
+	hashmap_clear(&o->pack_map);
 }
 
 void parsed_object_pool_clear(struct parsed_object_pool *o)
diff --git a/oidmap.c b/oidmap.c
index 423aa014a3..286a04a53c 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -27,7 +27,7 @@ void oidmap_free(struct oidmap *map, int free_entries)
 		return;
 
 	/* TODO: make oidmap itself not depend on struct layouts */
-	hashmap_free_(&map->map, free_entries ? 0 : -1);
+	hashmap_clear_(&map->map, free_entries ? 0 : -1);
 }
 
 void *oidmap_get(const struct oidmap *map, const struct object_id *key)
diff --git a/patch-ids.c b/patch-ids.c
index 12aa6d494b..21973e4933 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -71,7 +71,7 @@ int init_patch_ids(struct repository *r, struct patch_ids *ids)
 
 int free_patch_ids(struct patch_ids *ids)
 {
-	hashmap_free_entries(&ids->patches, struct patch_id, ent);
+	hashmap_clear_and_free(&ids->patches, struct patch_id, ent);
 	return 0;
 }
 
diff --git a/range-diff.c b/range-diff.c
index 24dc435e48..befeecae44 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -266,7 +266,7 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 		}
 	}
 
-	hashmap_free(&map);
+	hashmap_clear(&map);
 }
 
 static void diffsize_consume(void *data, char *line, unsigned long len)
diff --git a/ref-filter.c b/ref-filter.c
index c62f6b4822..5e66b8cd76 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2222,7 +2222,7 @@ void ref_array_clear(struct ref_array *array)
 	used_atom_cnt = 0;
 
 	if (ref_to_worktree_map.worktrees) {
-		hashmap_free_entries(&(ref_to_worktree_map.map),
+		hashmap_clear_and_free(&(ref_to_worktree_map.map),
 					struct ref_to_worktree_entry, ent);
 		free_worktrees(ref_to_worktree_map.worktrees);
 		ref_to_worktree_map.worktrees = NULL;
diff --git a/revision.c b/revision.c
index aa62212040..f27649d45d 100644
--- a/revision.c
+++ b/revision.c
@@ -139,7 +139,7 @@ static void paths_and_oids_clear(struct hashmap *map)
 		free(entry->path);
 	}
 
-	hashmap_free_entries(map, struct path_and_oids_entry, ent);
+	hashmap_clear_and_free(map, struct path_and_oids_entry, ent);
 }
 
 static void paths_and_oids_insert(struct hashmap *map,
diff --git a/sequencer.c b/sequencer.c
index 00acb12496..23a09c3e7a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5058,7 +5058,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
 	oidmap_free(&commit2todo, 1);
 	oidmap_free(&state.commit2label, 1);
-	hashmap_free_entries(&state.labels, struct labels_entry, entry);
+	hashmap_clear_and_free(&state.labels, struct labels_entry, entry);
 	strbuf_release(&state.buf);
 
 	return 0;
@@ -5577,7 +5577,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 	for (i = 0; i < todo_list->nr; i++)
 		free(subjects[i]);
 	free(subjects);
-	hashmap_free_entries(&subject2item, struct subject2item_entry, entry);
+	hashmap_clear_and_free(&subject2item, struct subject2item_entry, entry);
 
 	clear_commit_todo_item(&commit_todo);
 
diff --git a/submodule-config.c b/submodule-config.c
index c569e22aa3..f502505566 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -103,8 +103,8 @@ static void submodule_cache_clear(struct submodule_cache *cache)
 				ent /* member name */)
 		free_one_config(entry);
 
-	hashmap_free_entries(&cache->for_path, struct submodule_entry, ent);
-	hashmap_free_entries(&cache->for_name, struct submodule_entry, ent);
+	hashmap_clear_and_free(&cache->for_path, struct submodule_entry, ent);
+	hashmap_clear_and_free(&cache->for_name, struct submodule_entry, ent);
 	cache->initialized = 0;
 	cache->gitmodules_read = 0;
 }
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index f38706216f..2475663b49 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -110,7 +110,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 				hashmap_add(&map, &entries[i]->ent);
 			}
 
-			hashmap_free(&map);
+			hashmap_clear(&map);
 		}
 	} else {
 		/* test map lookups */
@@ -130,7 +130,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 			}
 		}
 
-		hashmap_free(&map);
+		hashmap_clear(&map);
 	}
 }
 
@@ -262,6 +262,6 @@ int cmd__hashmap(int argc, const char **argv)
 	}
 
 	strbuf_release(&line);
-	hashmap_free_entries(&map, struct test_entry, ent);
+	hashmap_clear_and_free(&map, struct test_entry, ent);
 	return 0;
 }
-- 
gitgitgadget

