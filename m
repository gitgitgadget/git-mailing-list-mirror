Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B351EC2BA1A
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 03:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A85A20776
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 03:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5rjM2tC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDYDAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbgDYDAx (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 23:00:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A137FC09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 20:00:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id g2so4474496plo.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 20:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rih5fgqoIJsqa0XMaouHupFPMdNFXNvfJwa2td2FniE=;
        b=m5rjM2tCWYX7m5WgRvVzi8pwfEazQMRAqL142e7zdU22ZIiHNySFUBQsuAyCNSpbPv
         RAdAGNkXP0DBWtUE2asDyAMBaKk8ucZQARYx5GNbVO1N0ti2vUWrW4evCtaDZKF8QGnW
         GPQfcmsn1IbgMQQ/rZmyO6s5j20R4cHcQSe8O1FQy15/x5kLb4Ed7HjHpR57hfo+rGtW
         2UFNyY86kkv9d/bEMQ2Z+Imd+v/VdSdc+dB28IVOCj4YsGim73bP0oaLPjfhtkA0XhNt
         Ls+BMSNQW20RVEFKumZPCNp5NSdzsTASF315VkxK4kgWiJjmuEkcs3roeWM4OsMjCbtc
         ghPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rih5fgqoIJsqa0XMaouHupFPMdNFXNvfJwa2td2FniE=;
        b=TtmAG/64hSUb06/N5VTVeG4ILg7KxzWamK/XFL/ZG7At1ujQPrjF3po5l657zK5phG
         TkHgAkaDFEmlgBzEzWGyH8NJiIihtZnU5cQO0/eD/XIuhHTlF2AbuMzZm3z2Z1oLBJ3n
         icnsNwfU/PmL11SXFGJ0r+oohAhYrTU/Kvyf+rtuK8uU+lkG3ooivllcZzeJHWTbB+OQ
         y9xdomIJ8B55lDPYAIilVay/s+5av8mq1UpDct+VM6DEZKEIEnxr7MmDE285HN9HKGUH
         K2rtp2nM+XlkoSJCmHpoNiDX6qjRSaQCHnGZ9Plcxs6vpi37yBjeVZqFFvl1kfzjeH5j
         iCUg==
X-Gm-Message-State: AGi0PubKXBekLDKzcohjjKUPvkkH6M6It5w0qg1ZMuCPx3y4uQe792N7
        nWYoYtgMMkMk51Vr28lnLLgqzVMutGo=
X-Google-Smtp-Source: APiQypKOM8MT743Eqlwx1O0EOtLg/Y5MXhOaG84u4WBEX/FDcvB3lv0gw+siVggne0kHWpU16r/gfQ==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr12023313plr.246.1587783652226;
        Fri, 24 Apr 2020 20:00:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:79a:d9e8:1f9e:c3b5:9fc6:c4b2])
        by smtp.gmail.com with ESMTPSA id f99sm5990992pjg.22.2020.04.24.20.00.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 20:00:51 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 3/3] oidmap: return oidmap_entry pointers
Date:   Sat, 25 Apr 2020 08:29:21 +0530
Message-Id: <20200425025921.1397-3-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200425025921.1397-1-abhishekkumar8222@gmail.com>
References: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
 <20200425025921.1397-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

oidmap_entry is usually embedded as first member of user data
structures. Since oidmap is unaware of structure, it returns an void
pointer for oidmap_get(), oidmap_put() and oidmap_remove().

This pointer is rather a pointer to a oidmap entry. Teach the functions
to return a oidmap_entry pointer and add helper macros to return
pointers to container struct.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 list-objects-filter.c  |  8 +++++---
 oidmap.c               | 21 ++++++++++++---------
 oidmap.h               | 42 ++++++++++++++++++++++++++++++++++++------
 replace-object.c       |  7 ++++---
 sequencer.c            | 28 ++++++++++++++++++----------
 t/helper/test-oidmap.c |  8 +++++---
 6 files changed, 80 insertions(+), 34 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 1e8d4e763d..16b45d913e 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -183,13 +183,15 @@ static enum list_objects_filter_result filter_trees_depth(
 		return include_it ? LOFR_MARK_SEEN | LOFR_DO_SHOW : LOFR_ZERO;
 
 	case LOFS_BEGIN_TREE:
-		seen_info = oidmap_get(
-			&filter_data->seen_at_depth, &obj->oid);
+		oidmap_get_entry(seen_info, base, &filter_data->seen_at_depth,
+				 &obj->oid);
+
 		if (!seen_info) {
 			seen_info = xcalloc(1, sizeof(*seen_info));
 			oidcpy(&seen_info->base.oid, &obj->oid);
 			seen_info->depth = filter_data->current_depth;
-			oidmap_put(&filter_data->seen_at_depth, seen_info);
+			oidmap_put_entry(seen_info, base,
+					 &filter_data->seen_at_depth);
 			already_seen = 0;
 		} else {
 			already_seen =
diff --git a/oidmap.c b/oidmap.c
index 44345a8cf2..0e64c0e8a2 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -33,15 +33,18 @@ void oidmap_free(struct oidmap *map, int free_entries)
 		hashmap_free(&map->map);
 }
 
-void *oidmap_get(const struct oidmap *map, const struct object_id *key)
+struct oidmap_entry *oidmap_get(const struct oidmap *map,
+		const struct object_id *key)
 {
 	if (!map->map.cmpfn)
 		return NULL;
 
-	return hashmap_get_from_hash(&map->map, oidhash(key), key);
+	return oidmap_entry_from_hashmap_entry(
+		hashmap_get_from_hash(&map->map, oidhash(key), key));
 }
 
-void *oidmap_remove(struct oidmap *map, const struct object_id *key)
+struct oidmap_entry *oidmap_remove(struct oidmap *map,
+		const struct object_id *key)
 {
 	struct hashmap_entry entry;
 
@@ -49,16 +52,16 @@ void *oidmap_remove(struct oidmap *map, const struct object_id *key)
 		oidmap_init(map, 0);
 
 	hashmap_entry_init(&entry, oidhash(key));
-	return hashmap_remove(&map->map, &entry, key);
+	return oidmap_entry_from_hashmap_entry(
+		hashmap_remove(&map->map, &entry, key));
 }
 
-void *oidmap_put(struct oidmap *map, void *entry)
+struct oidmap_entry *oidmap_put(struct oidmap *map, struct oidmap_entry *entry)
 {
-	struct oidmap_entry *to_put = entry;
-
 	if (!map->map.cmpfn)
 		oidmap_init(map, 0);
 
-	hashmap_entry_init(&to_put->internal_entry, oidhash(&to_put->oid));
-	return hashmap_put(&map->map, &to_put->internal_entry);
+	hashmap_entry_init(&entry->internal_entry, oidhash(&entry->oid));
+	return oidmap_entry_from_hashmap_entry(
+		hashmap_put(&map->map, &entry->internal_entry));
 }
diff --git a/oidmap.h b/oidmap.h
index d79b087ab0..f250f0bf87 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -46,25 +46,55 @@ void oidmap_free(struct oidmap *map, int free_entries);
 /*
  * Returns the oidmap entry for the specified oid, or NULL if not found.
  */
-void *oidmap_get(const struct oidmap *map,
+struct oidmap_entry *oidmap_get(const struct oidmap *map,
 		 const struct object_id *key);
 
+/*
+ * Returns pointer to container struct of the oidmap entry for the
+ * specified oid, or NULL if not found.
+ */
+#define oidmap_get_entry(var, member, map, key) \
+	var = container_of_or_null_offset( \
+		oidmap_get(map, key), \
+		OFFSETOF_VAR(var, member))
 /*
  * Adds or replaces an oidmap entry.
  *
- * ((struct oidmap_entry *) entry)->internal_entry will be populated by this
- * function.
- *
  * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
  */
-void *oidmap_put(struct oidmap *map, void *entry);
+struct oidmap_entry *oidmap_put(struct oidmap *map, struct oidmap_entry *entry);
+
+/*
+ * Adds or replaces an oidmap entry.
+ *
+ * Returns pointer to container struct of replaced entry, or NULL if
+ * not found (i.e. the entry was added).
+ *
+ * The struct type of @var contains a "struct oidmap_entry" @member.
+ */
+#define oidmap_put_entry(var, member, map) \
+	container_of_or_null_offset( \
+		oidmap_put(map, &var->member), \
+		OFFSETOF_VAR(var, member))
 
 /*
  * Removes an oidmap entry matching the specified oid.
  *
  * Returns the removed entry, or NULL if not found.
  */
-void *oidmap_remove(struct oidmap *map, const struct object_id *key);
+struct oidmap_entry *oidmap_remove(struct oidmap *map,
+		const struct object_id *key);
+
+/*
+ * Removes an oidmap entry matching the specified oid.
+ *
+ * Returns pointer to container struct of the removed entry, or NULL if
+ * not found.
+ */
+#define oidmap_remove_entry(var, member, map, key) \
+	var = container_of_or_null_offset( \
+		oidmap_remove(map, key), \
+		OFFSETOF_VAR(var, member))
 
 #define oidmap_entry_from_hashmap_entry(entry) \
 	container_of_or_null(entry, struct oidmap_entry, internal_entry)
diff --git a/replace-object.c b/replace-object.c
index 7bd9aba6ee..ab0354db7a 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -26,7 +26,7 @@ static int register_replace_ref(struct repository *r,
 	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
-	if (oidmap_put(r->objects->replace_map, repl_obj))
+	if (oidmap_put_entry(repl_obj, original, r->objects->replace_map))
 		die(_("duplicate replace ref: %s"), refname);
 
 	return 0;
@@ -73,8 +73,9 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 
 	/* Try to recursively replace the object */
 	while (depth-- > 0) {
-		struct replace_object *repl_obj =
-			oidmap_get(r->objects->replace_map, cur);
+		struct replace_object *repl_obj;
+		oidmap_get_entry(repl_obj, original, r->objects->replace_map,
+				 cur);
 		if (!repl_obj)
 			return cur;
 		cur = &repl_obj->replacement;
diff --git a/sequencer.c b/sequencer.c
index f30bb73c70..012e7865db 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4506,7 +4506,8 @@ static const char *label_oid(struct object_id *oid, const char *label,
 	struct object_id dummy;
 	int i;
 
-	string_entry = oidmap_get(&state->commit2label, oid);
+	oidmap_get_entry(string_entry, entry, &state->commit2label, oid);
+
 	if (string_entry)
 		return string_entry->string;
 
@@ -4606,7 +4607,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
 
 	FLEX_ALLOC_STR(string_entry, string, label);
 	oidcpy(&string_entry->entry.oid, oid);
-	oidmap_put(&state->commit2label, string_entry);
+	oidmap_put_entry(string_entry, entry, &state->commit2label);
 
 	return string_entry->string;
 }
@@ -4645,7 +4646,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		struct object_id *oid = &revs->cmdline.rev[0].item->oid;
 		FLEX_ALLOC_STR(entry, string, "onto");
 		oidcpy(&entry->entry.oid, oid);
-		oidmap_put(&state.commit2label, entry);
+		oidmap_put_entry(entry, entry, /* member name */
+				 &state.commit2label);
 
 		FLEX_ALLOC_STR(onto_label_entry, label, "onto");
 		hashmap_entry_init(&onto_label_entry->entry, strihash("onto"));
@@ -4689,7 +4691,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
 			FLEX_ALLOC_STR(entry, string, buf.buf);
 			oidcpy(&entry->entry.oid, &commit->object.oid);
-			oidmap_put(&commit2todo, entry);
+			oidmap_put_entry(entry, entry, /* member name */
+					 &commit2todo);
 
 			continue;
 		}
@@ -4731,7 +4734,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
 		FLEX_ALLOC_STR(entry, string, buf.buf);
 		oidcpy(&entry->entry.oid, &commit->object.oid);
-		oidmap_put(&commit2todo, entry);
+		oidmap_put_entry(entry, entry, /* member name */
+				 &commit2todo);
 	}
 
 	/*
@@ -4769,7 +4773,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		commit = iter->item;
 		if (oidset_contains(&shown, &commit->object.oid))
 			continue;
-		entry = oidmap_get(&state.commit2label, &commit->object.oid);
+
+		oidmap_get_entry(entry, entry /* member name */,
+				 &state.commit2label, &commit->object.oid);
 
 		if (entry)
 			strbuf_addf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
@@ -4793,8 +4799,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		else {
 			const char *to = NULL;
 
-			entry = oidmap_get(&state.commit2label,
-					   &commit->object.oid);
+			oidmap_get_entry(entry, entry /* member name */,
+					 &state.commit2label, &commit->object.oid);
 			if (entry)
 				to = entry->string;
 			else if (!rebase_cousins)
@@ -4813,11 +4819,13 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
 		for (iter2 = list; iter2; iter2 = iter2->next) {
 			struct object_id *oid = &iter2->item->object.oid;
-			entry = oidmap_get(&commit2todo, oid);
+			oidmap_get_entry(entry, entry /* member name */,
+					 &commit2todo, oid);
 			/* only show if not already upstream */
 			if (entry)
 				strbuf_addf(out, "%s\n", entry->string);
-			entry = oidmap_get(&state.commit2label, oid);
+			oidmap_get_entry(entry, entry /* member name */,
+					 &state.commit2label, oid);
 			if (entry)
 				strbuf_addf(out, "%s %s\n",
 					    cmd_label, entry->string);
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 3f599b21b8..fc19c1cb8e 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -59,7 +59,7 @@ int cmd__oidmap(int argc, const char **argv)
 			oidcpy(&entry->entry.oid, &oid);
 
 			/* add / replace entry */
-			entry = oidmap_put(&map, entry);
+			entry = oidmap_put_entry(entry, entry, /* member name */ &map);
 
 			/* print and free replaced entry, if any */
 			puts(entry ? entry->name : "NULL");
@@ -73,7 +73,8 @@ int cmd__oidmap(int argc, const char **argv)
 			}
 
 			/* lookup entry in oidmap */
-			entry = oidmap_get(&map, &oid);
+			oidmap_get_entry(entry, entry /* member name */,
+					&map, &oid);
 
 			/* print result */
 			puts(entry ? entry->name : "NULL");
@@ -86,7 +87,8 @@ int cmd__oidmap(int argc, const char **argv)
 			}
 
 			/* remove entry from oidmap */
-			entry = oidmap_remove(&map, &oid);
+			oidmap_remove_entry(entry, entry, /* member name */
+				      &map, &oid);
 
 			/* print result and free entry*/
 			puts(entry ? entry->name : "NULL");
-- 
2.26.0

