Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B227D208E9
	for <e@80x24.org>; Sun,  5 Aug 2018 17:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeHETbG (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:31:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43035 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeHETbG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:31:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so10118666wrv.10
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Pd1LZ/S0ZT878cpU5mfk4xcrg68eKxzRMt4WIxP9UM=;
        b=NDS3WKsjQB1Vytw/W0k5Vfi93oQcQQM21B2OAVQrxK8CmvK93IURHBtT9LkFzkkpx/
         bxhmYDT5KN6FOlHWYE5Wh72LS6Wio4JkCq98xdTtpSQVt0bMVFIENnxCJFlRhHfz6f0J
         eENRYgYygqweRR2dQlVsTtQcDpD/1f/3SjHlCviRbtt121Mq/1V8722QHjpFXdWMR++A
         MZ1leKhJtLhQfJPRsMfOV+7AGmVHD986tYOZjKPKlL/t5IK+8Vuew2Z1eQvCfjZ7X8+t
         FAxvLdZBscMz2qv/aLRaICk5GS/aZ1CV4VYTATV+TwQxHjRnhrfd6sdIKI6ySaxrtou4
         iWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Pd1LZ/S0ZT878cpU5mfk4xcrg68eKxzRMt4WIxP9UM=;
        b=W7eOP04D19u9Mi+/Krd7MDWCB05vyBW1adRMMVNJuIvKd/poCTgW9oaUJxlCHw4tMP
         3hyZlohvyRUVdCq6e/xAIAiSs5o0UgAV3F0pP/185jjnNS83W5Mz6opFkpTKBpQakhxH
         rrHkHc3Ymlj2MHHdHG9GhxcFnsWjnAslpGqaZNoWP+gYyMcCKMTV3XRYkm/nFiQ7bvjS
         FZfSSXPgScCm8vevZBstm3IqdRJcIl/j55160r72LeO2bGtzCNmI368mJxNpldIFJbmg
         Gix/Un6iBrRJWl6Q8mwnbsUVHgbf6+h+8kq0Qckm/RM/9e5BNkbkDGsG+h4FqErW2Mcu
         hGqw==
X-Gm-Message-State: AOUpUlErc4QqRFz+ijB1/rpV5X2tEgg5V2omLi+0VJwOFGB2OBZmiFeJ
        rf9Oe/dFzvT6lS82xwC2mv9hdAOs
X-Google-Smtp-Source: AAOMgpc88wacTSSR7f2PnbD94K7wPBGLQlefZXOF1a4c4qQc7JKMunAjA93o8T65MDhiQ8siFp6U+Q==
X-Received: by 2002:a5d:540d:: with SMTP id g13-v6mr7974237wrv.4.1533489946060;
        Sun, 05 Aug 2018 10:25:46 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id x62-v6sm7523228wmg.1.2018.08.05.10.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 10:25:45 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/6] Add delta-islands.{c,h}
Date:   Sun,  5 Aug 2018 19:25:21 +0200
Message-Id: <20180805172525.15278-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.327.ga7d188ab43
In-Reply-To: <20180805172525.15278-1-chriscool@tuxfamily.org>
References: <20180805172525.15278-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Hosting providers that allow users to "fork" existing
repos want those forks to share as much disk space as
possible.

Alternates are an existing solution to keep all the
objects from all the forks into a unique central repo,
but this can have some drawbacks. Especially when
packing the central repo, deltas will be created
between objects from different forks.

This can make cloning or fetching a fork much slower
and much more CPU intensive as Git might have to
compute new deltas for many objects to avoid sending
objects from a different fork.

Because the inefficiency primarily arises when an
object is delitified against another object that does
not exist in the same fork, we partition objects into
sets that appear in the same fork, and define
"delta islands". When finding delta base, we do not
allow an object outside the same island to be
considered as its base.

So "delta islands" is a way to store objects from
different forks in the same repo and packfile without
having deltas between objects from different forks.

This patch implements the delta islands mechanism in
"delta-islands.{c,h}", but does not yet make use of it.

A few new fields are added in 'struct object_entry'
in "pack-objects.h" though.

The documentation will follow in a patch that actually
uses delta islands in "builtin/pack-objects.c".

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile        |   1 +
 delta-islands.c | 487 ++++++++++++++++++++++++++++++++++++++++++++++++
 delta-islands.h |  11 ++
 pack-objects.h  |   4 +
 4 files changed, 503 insertions(+)
 create mode 100644 delta-islands.c
 create mode 100644 delta-islands.h

diff --git a/Makefile b/Makefile
index 08e5c54549..2804298977 100644
--- a/Makefile
+++ b/Makefile
@@ -840,6 +840,7 @@ LIB_OBJS += csum-file.o
 LIB_OBJS += ctype.o
 LIB_OBJS += date.o
 LIB_OBJS += decorate.o
+LIB_OBJS += delta-islands.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
 LIB_OBJS += diffcore-order.o
diff --git a/delta-islands.c b/delta-islands.c
new file mode 100644
index 0000000000..f7902a64ad
--- /dev/null
+++ b/delta-islands.c
@@ -0,0 +1,487 @@
+#include "cache.h"
+#include "attr.h"
+#include "object.h"
+#include "blob.h"
+#include "commit.h"
+#include "tag.h"
+#include "tree.h"
+#include "delta.h"
+#include "pack.h"
+#include "tree-walk.h"
+#include "diff.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "progress.h"
+#include "refs.h"
+#include "khash.h"
+#include "pack-bitmap.h"
+#include "pack-objects.h"
+#include "delta-islands.h"
+#include "sha1-array.h"
+#include "config.h"
+
+KHASH_INIT(str, const char *, void *, 1, kh_str_hash_func, kh_str_hash_equal)
+
+static khash_sha1 *island_marks;
+static unsigned island_counter;
+static unsigned island_counter_core;
+
+static kh_str_t *remote_islands;
+
+struct remote_island {
+	uint64_t hash;
+	struct oid_array oids;
+};
+
+struct island_bitmap {
+	uint32_t refcount;
+	uint32_t bits[];
+};
+
+static uint32_t island_bitmap_size;
+
+/*
+ * Allocate a new bitmap; if "old" is not NULL, the new bitmap will be a copy
+ * of "old". Otherwise, the new bitmap is empty.
+ */
+static struct island_bitmap *island_bitmap_new(const struct island_bitmap *old)
+{
+	size_t size = sizeof(struct island_bitmap) + (island_bitmap_size * 4);
+	struct island_bitmap *b = xcalloc(1, size);
+
+	if (old)
+		memcpy(b, old, size);
+
+	b->refcount = 1;
+	return b;
+}
+
+static void island_bitmap_or(struct island_bitmap *a, const struct island_bitmap *b)
+{
+	uint32_t i;
+
+	for (i = 0; i < island_bitmap_size; ++i)
+		a->bits[i] |= b->bits[i];
+}
+
+static int island_bitmap_is_subset(struct island_bitmap *self,
+		struct island_bitmap *super)
+{
+	uint32_t i;
+
+	if (self == super)
+		return 1;
+
+	for (i = 0; i < island_bitmap_size; ++i) {
+		if ((self->bits[i] & super->bits[i]) != self->bits[i])
+			return 0;
+	}
+
+	return 1;
+}
+
+#define ISLAND_BITMAP_BLOCK(x) (x / 32)
+#define ISLAND_BITMAP_MASK(x) (1 << (x % 32))
+
+static void island_bitmap_set(struct island_bitmap *self, uint32_t i)
+{
+	self->bits[ISLAND_BITMAP_BLOCK(i)] |= ISLAND_BITMAP_MASK(i);
+}
+
+static int island_bitmap_get(struct island_bitmap *self, uint32_t i)
+{
+	return (self->bits[ISLAND_BITMAP_BLOCK(i)] & ISLAND_BITMAP_MASK(i)) != 0;
+}
+
+int in_same_island(const struct object_id *trg_oid, const struct object_id *src_oid)
+{
+	khiter_t trg_pos, src_pos;
+
+	/* If we aren't using islands, assume everything goes together. */
+	if (!island_marks)
+		return 1;
+
+	/*
+	 * If we don't have a bitmap for the target, we can delta it
+	 * against anything -- it's not an important object
+	 */
+	trg_pos = kh_get_sha1(island_marks, trg_oid->hash);
+	if (trg_pos >= kh_end(island_marks))
+		return 1;
+
+	/*
+	 * if the source (our delta base) doesn't have a bitmap,
+	 * we don't want to base any deltas on it!
+	 */
+	src_pos = kh_get_sha1(island_marks, src_oid->hash);
+	if (src_pos >= kh_end(island_marks))
+		return 0;
+
+	return island_bitmap_is_subset(kh_value(island_marks, trg_pos),
+				kh_value(island_marks, src_pos));
+}
+
+int island_delta_cmp(const struct object_id *a, const struct object_id *b)
+{
+	khiter_t a_pos, b_pos;
+	struct island_bitmap *a_bitmap = NULL, *b_bitmap = NULL;
+
+	if (!island_marks)
+		return 0;
+
+	a_pos = kh_get_sha1(island_marks, a->hash);
+	if (a_pos < kh_end(island_marks))
+		a_bitmap = kh_value(island_marks, a_pos);
+
+	b_pos = kh_get_sha1(island_marks, b->hash);
+	if (b_pos < kh_end(island_marks))
+		b_bitmap = kh_value(island_marks, b_pos);
+
+	if (a_bitmap) {
+		if (!b_bitmap || !island_bitmap_is_subset(a_bitmap, b_bitmap))
+			return -1;
+	}
+	if (b_bitmap) {
+		if (!a_bitmap || !island_bitmap_is_subset(b_bitmap, a_bitmap))
+			return 1;
+	}
+
+	return 0;
+}
+
+static struct island_bitmap *create_or_get_island_marks(struct object *obj)
+{
+	khiter_t pos;
+	int hash_ret;
+
+	pos = kh_put_sha1(island_marks, obj->oid.hash, &hash_ret);
+	if (hash_ret)
+		kh_value(island_marks, pos) = island_bitmap_new(NULL);
+
+	return kh_value(island_marks, pos);
+}
+
+static void set_island_marks(struct object *obj, struct island_bitmap *marks)
+{
+	struct island_bitmap *b;
+	khiter_t pos;
+	int hash_ret;
+
+	pos = kh_put_sha1(island_marks, obj->oid.hash, &hash_ret);
+	if (hash_ret) {
+		/*
+		 * We don't have one yet; make a copy-on-write of the
+		 * parent.
+		 */
+		marks->refcount++;
+		kh_value(island_marks, pos) = marks;
+		return;
+	}
+
+	/*
+	 * We do have it. Make sure we split any copy-on-write before
+	 * updating.
+	 */
+	b = kh_value(island_marks, pos);
+	if (b->refcount > 1) {
+		b->refcount--;
+		b = kh_value(island_marks, pos) = island_bitmap_new(b);
+	}
+	island_bitmap_or(b, marks);
+}
+
+static void mark_remote_island_1(struct remote_island *rl, int is_core_island)
+{
+	uint32_t i;
+
+	for (i = 0; i < rl->oids.nr; ++i) {
+		struct island_bitmap *marks;
+		struct object *obj = parse_object(&rl->oids.oid[i]);
+
+		if (!obj)
+			continue;
+
+		marks = create_or_get_island_marks(obj);
+		island_bitmap_set(marks, island_counter);
+
+		if (is_core_island && obj->type == OBJ_COMMIT)
+			obj->flags |= NEEDS_BITMAP;
+
+		/* If it was a tag, also make sure we hit the underlying object. */
+		while (obj && obj->type == OBJ_TAG) {
+			obj = ((struct tag *)obj)->tagged;
+			if (obj) {
+				parse_object(&obj->oid);
+				marks = create_or_get_island_marks(obj);
+				island_bitmap_set(marks, island_counter);
+			}
+		}
+	}
+
+	if (is_core_island)
+		island_counter_core = island_counter;
+
+	island_counter++;
+}
+
+static int cmp_tree_depth(const void *va, const void *vb)
+{
+	struct object_entry *a = *(struct object_entry **)va;
+	struct object_entry *b = *(struct object_entry **)vb;
+	return a->tree_depth - b->tree_depth;
+}
+
+void resolve_tree_islands(int progress, struct packing_data *to_pack)
+{
+	struct progress *progress_state = NULL;
+	struct object_entry **todo;
+	int nr = 0;
+	int i;
+
+	if (!island_marks)
+		return;
+
+	/*
+	 * We process only trees, as commits and tags have already been handled
+	 * (and passed their marks on to root trees, as well. We must make sure
+	 * to process them in descending tree-depth order so that marks
+	 * propagate down the tree properly, even if a sub-tree is found in
+	 * multiple parent trees.
+	 */
+	ALLOC_ARRAY(todo, to_pack->nr_objects);
+	for (i = 0; i < to_pack->nr_objects; i++) {
+		if (oe_type(&to_pack->objects[i]) == OBJ_TREE)
+			todo[nr++] = &to_pack->objects[i];
+	}
+	QSORT(todo, nr, cmp_tree_depth);
+
+	if (progress)
+		progress_state = start_progress(_("Propagating island marks"), nr);
+
+	for (i = 0; i < nr; i++) {
+		struct object_entry *ent = todo[i];
+		struct island_bitmap *root_marks;
+		struct tree *tree;
+		struct tree_desc desc;
+		struct name_entry entry;
+		khiter_t pos;
+
+		pos = kh_get_sha1(island_marks, ent->idx.oid.hash);
+		if (pos >= kh_end(island_marks))
+			continue;
+
+		root_marks = kh_value(island_marks, pos);
+
+		tree = lookup_tree(&ent->idx.oid);
+		if (!tree || parse_tree(tree) < 0)
+			die(_("bad tree object %s"), oid_to_hex(&ent->idx.oid));
+
+		init_tree_desc(&desc, tree->buffer, tree->size);
+		while (tree_entry(&desc, &entry)) {
+			struct object *obj;
+
+			if (S_ISGITLINK(entry.mode))
+				continue;
+
+			obj = lookup_object(entry.oid->hash);
+			if (!obj)
+				continue;
+
+			set_island_marks(obj, root_marks);
+		}
+
+		free_tree_buffer(tree);
+
+		display_progress(progress_state, i+1);
+	}
+
+	stop_progress(&progress_state);
+	free(todo);
+}
+
+static regex_t *island_regexes;
+static unsigned int island_regexes_alloc, island_regexes_nr;
+static const char *core_island_name;
+
+static int island_config_callback(const char *k, const char *v, void *cb)
+{
+	if (!strcmp(k, "pack.island")) {
+		struct strbuf re = STRBUF_INIT;
+
+		if (!v)
+			return config_error_nonbool(k);
+
+		if (island_regexes_nr >= island_regexes_alloc) {
+			island_regexes_alloc = (island_regexes_alloc + 8) * 2;
+			island_regexes = xrealloc(island_regexes,
+					island_regexes_alloc * sizeof(regex_t));
+		}
+
+		if (*v != '^')
+			strbuf_addch(&re, '^');
+		strbuf_addstr(&re, v);
+
+		if (regcomp(&island_regexes[island_regexes_nr], re.buf, REG_EXTENDED))
+			die(_("failed to load island regex for '%s': %s"), k, re.buf);
+
+		strbuf_release(&re);
+		island_regexes_nr++;
+		return 0;
+	}
+
+	if (!strcmp(k, "pack.islandcore"))
+		return git_config_string(&core_island_name, k, v);
+
+	return 0;
+}
+
+static void add_ref_to_island(const char *island_name, const struct object_id *oid)
+{
+	uint64_t sha_core;
+	struct remote_island *rl = NULL;
+
+	int hash_ret;
+	khiter_t pos = kh_put_str(remote_islands, island_name, &hash_ret);
+
+	if (hash_ret) {
+		kh_key(remote_islands, pos) = xstrdup(island_name);
+		kh_value(remote_islands, pos) = xcalloc(1, sizeof(struct remote_island));
+	}
+
+	rl = kh_value(remote_islands, pos);
+	oid_array_append(&rl->oids, oid);
+
+	memcpy(&sha_core, oid->hash, sizeof(uint64_t));
+	rl->hash += sha_core;
+}
+
+static int find_island_for_ref(const char *refname, const struct object_id *oid,
+			       int flags, void *data)
+{
+	int i, m;
+	regmatch_t matches[8];
+	struct strbuf island_name = STRBUF_INIT;
+
+	/* walk backwards to get last-one-wins ordering */
+	for (i = island_regexes_nr - 1; i >= 0; i--) {
+		if (!regexec(&island_regexes[i], refname,
+			     ARRAY_SIZE(matches), matches, 0))
+			break;
+	}
+
+	if (i < 0)
+		return 0;
+
+	for (m = 1; m < ARRAY_SIZE(matches); m++) {
+		regmatch_t *match = &matches[m];
+
+		if (match->rm_so == -1)
+			continue;
+
+		if (island_name.len)
+			strbuf_addch(&island_name, '-');
+
+		strbuf_add(&island_name, refname + match->rm_so, match->rm_eo - match->rm_so);
+	}
+
+	add_ref_to_island(island_name.buf, oid);
+	strbuf_release(&island_name);
+	return 0;
+}
+
+static struct remote_island *get_core_island(void)
+{
+	if (core_island_name) {
+		khiter_t pos = kh_get_str(remote_islands, core_island_name);
+		if (pos < kh_end(remote_islands))
+			return kh_value(remote_islands, pos);
+	}
+
+	return NULL;
+}
+
+static void deduplicate_islands(void)
+{
+	struct remote_island *island, *core = NULL, **list;
+	unsigned int island_count, dst, src, ref, i = 0;
+
+	island_count = kh_size(remote_islands);
+	list = xmalloc(island_count * sizeof(struct remote_island *));
+
+	kh_foreach_value(remote_islands, island, {
+		list[i++] = island;
+	});
+
+	for (ref = 0; ref + 1 < island_count; ref++) {
+		for (src = ref + 1, dst = src; src < island_count; src++) {
+			if (list[ref]->hash == list[src]->hash)
+				continue;
+
+			if (src != dst)
+				list[dst] = list[src];
+
+			dst++;
+		}
+		island_count = dst;
+	}
+
+	island_bitmap_size = (island_count / 32) + 1;
+	core = get_core_island();
+
+	for (i = 0; i < island_count; ++i) {
+		mark_remote_island_1(list[i], core && list[i]->hash == core->hash);
+	}
+
+	free(list);
+}
+
+void load_delta_islands(void)
+{
+	island_marks = kh_init_sha1();
+	remote_islands = kh_init_str();
+
+	git_config(island_config_callback, NULL);
+	for_each_ref(find_island_for_ref, NULL);
+	deduplicate_islands();
+
+	fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);
+}
+
+void propagate_island_marks(struct commit *commit)
+{
+	khiter_t pos = kh_get_sha1(island_marks, commit->object.oid.hash);
+
+	if (pos < kh_end(island_marks)) {
+		struct commit_list *p;
+		struct island_bitmap *root_marks = kh_value(island_marks, pos);
+
+		parse_commit(commit);
+		set_island_marks(&get_commit_tree(commit)->object, root_marks);
+		for (p = commit->parents; p; p = p->next)
+			set_island_marks(&p->item->object, root_marks);
+	}
+}
+
+int compute_pack_layers(struct packing_data *to_pack)
+{
+	uint32_t i;
+
+	if (!core_island_name || !island_marks)
+		return 1;
+
+	for (i = 0; i < to_pack->nr_objects; ++i) {
+		struct object_entry *entry = &to_pack->objects[i];
+		khiter_t pos = kh_get_sha1(island_marks, entry->idx.oid.hash);
+
+		entry->layer = 1;
+
+		if (pos < kh_end(island_marks)) {
+			struct island_bitmap *bitmap = kh_value(island_marks, pos);
+
+			if (island_bitmap_get(bitmap, island_counter_core))
+				entry->layer = 0;
+		}
+	}
+
+	return 2;
+}
diff --git a/delta-islands.h b/delta-islands.h
new file mode 100644
index 0000000000..f9725730f4
--- /dev/null
+++ b/delta-islands.h
@@ -0,0 +1,11 @@
+#ifndef DELTA_ISLANDS_H
+#define DELTA_ISLANDS_H
+
+int island_delta_cmp(const struct object_id *a, const struct object_id *b);
+int in_same_island(const struct object_id *, const struct object_id *);
+void resolve_tree_islands(int progress, struct packing_data *to_pack);
+void load_delta_islands(void);
+void propagate_island_marks(struct commit *commit);
+int compute_pack_layers(struct packing_data *to_pack);
+
+#endif /* DELTA_ISLANDS_H */
diff --git a/pack-objects.h b/pack-objects.h
index edf74dabdd..8eecd67991 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -100,6 +100,10 @@ struct object_entry {
 	unsigned type_:TYPE_BITS;
 	unsigned no_try_delta:1;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
+
+	unsigned int tree_depth; /* should be repositioned for packing? */
+	unsigned char layer;
+
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
-- 
2.18.0.327.ga7d188ab43

