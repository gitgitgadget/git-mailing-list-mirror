Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3551F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 23:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbfJIXoo (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 19:44:44 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46455 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732453AbfJIXon (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 19:44:43 -0400
Received: by mail-pf1-f201.google.com with SMTP id f2so3133127pfk.13
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Eb+VewUU2uRym4eGRLeJWQdvDDFUKR4i2a6K8n7E1yA=;
        b=FxQ06aB/+lxFHIo4RsFWYG7p1CtpqwYIqqZc1ILtnhbWJdud3WMafSCFrPV8wgoxw5
         5B0ldoOvg15GEjayHClKJxMRCJRF08ZihZf6EFFynxRIVUlnUhvxOVLgyJax/8A2eCfT
         GvXgfV5mPcHAof+m0p3GWvwHgs1UKqgW/2xay8OsuLXkQqF43nBOmPoxEtUkYEjPvaeW
         JfyXJF+2NlAjq2jnk94+3vEdxwuD/lALPEwW0DlfgUaX35oHcGaBCMrqZWVpb2oG8RaT
         9NzFnI+GiDqopppiS113ajm5rIIUAKDafBWOb2sBR3zhJ1ivqZsH8+Hhc4KWcEgLYqHx
         1hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Eb+VewUU2uRym4eGRLeJWQdvDDFUKR4i2a6K8n7E1yA=;
        b=ZDFcpT93KSbuRl5gL1FclFBWj/nkfS5d3vwd/aZ1hrA88jQGcWSzlbtBKnreXlJSol
         q9TXTdVl/uRm5Et/igfVPKnL4VwWUgRKO72mUkGggOt5KyjCy8/1ihBO3v/qM4Lgrm9B
         oUJ2aJ6wYEmVJnu0i4oejBdPxdr0u5aKAC+XR4e7gmp8KJ2qFewZPuRs4o+WBFpQoxtj
         sYjK3CFRaPW8W8ECs7OgfXEqIMlEQRybJC8Oaf1NB0VkZMQiA1uYRFkH73BiQXCxk/Uf
         vkuM3X97EJEkPME9+Bl7C9lLxhV2DEGGFJXIALuBmYq7qx3bWl+OYyKj25qUKAh1gsI9
         ramQ==
X-Gm-Message-State: APjAAAVqZ5j+MLI6QQTkhBS1tc2PETmjJ35JORQAfQ/cLkxhy4NhgdBw
        /WthPn2DWRdGjMkJ2XW7BwSmMamuLy44JQ6lpG8Es5FGfhkxkt8n2bMuyKyciwjP4I+3bbnecfw
        aPBLvDJg3dtE/hVl/ZOoMjn9Po425sAWe1ymtnp/6QPSe2ZQfM5VCRryy/q8K98BAaTzm3ZPixd
        Xg
X-Google-Smtp-Source: APXvYqzhFuTcn68bpLFr102OKfA2MHagrEOorjVCWdbp3WClOxaHeQdgMN4jFR00oejNuKB4iEqNbqBK63BmJGVazMJG
X-Received: by 2002:a65:44cb:: with SMTP id g11mr7224673pgs.145.1570664682535;
 Wed, 09 Oct 2019 16:44:42 -0700 (PDT)
Date:   Wed,  9 Oct 2019 16:44:22 -0700
In-Reply-To: <cover.1570663470.git.jonathantanmy@google.com>
Message-Id: <505d8e79cd983d5b3dfd56c4f0432ad647132957.1570663470.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 6/6] index-pack: make quantum of work smaller
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 267 ++++++++++++++++++++-----------------------
 1 file changed, 127 insertions(+), 140 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3908cd3115..f6318037ca 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -38,15 +38,22 @@ struct base_data {
 	struct object_entry *obj;
 	int ref_first, ref_last;
 	int ofs_first, ofs_last;
+	int retain_data;
+	int children_remaining;
 
 	/* Not initialized by make_base(). */
+	struct list_head list;
 	void *data;
 	unsigned long size;
 };
 
+LIST_HEAD(work_head);
+LIST_HEAD(done_head);
+size_t base_cache_used;
+size_t base_cache_limit;
+
 struct thread_local {
 	pthread_t thread;
-	size_t base_cache_used;
 	int pack_fd;
 };
 
@@ -369,36 +376,38 @@ static void free_base_data(struct base_data *c)
 {
 	if (c->data) {
 		FREE_AND_NULL(c->data);
-		get_thread_data()->base_cache_used -= c->size;
+		base_cache_used -= c->size;
 	}
 }
 
-static void prune_base_data(struct base_data *youngest_child)
+static void prune_base_data(struct base_data *retain)
 {
-	struct base_data *b;
-	struct thread_local *data = get_thread_data();
-	struct base_data **ancestry = NULL;
-	int nr = 0, alloc = 0;
-	int i;
+	struct list_head *pos;
 
-	if (data->base_cache_used <= delta_base_cache_limit)
+	if (base_cache_used <= base_cache_limit)
 		return;
 
-	/*
-	 * Free all ancestors of youngest_child until we have enough space,
-	 * starting with the oldest. (We cannot free youngest_child itself.)
-	 */
-	for (b = youngest_child->base; b != NULL; b = b->base) {
-		ALLOC_GROW(ancestry, nr + 1, alloc);
-		ancestry[nr++] = b;
+	list_for_each_prev(pos, &done_head) {
+		struct base_data *b = list_entry(pos, struct base_data, list);
+		if (b->retain_data || b == retain)
+			continue;
+		if (b->data) {
+			free_base_data(b);
+			if (base_cache_used <= base_cache_limit)
+				return;
+		}
 	}
-	for (i = nr - 1;
-	     i >= 0 && data->base_cache_used > delta_base_cache_limit;
-	     i--) {
-		if (ancestry[i]->data)
-			free_base_data(ancestry[i]);
+
+	list_for_each_prev(pos, &work_head) {
+		struct base_data *b = list_entry(pos, struct base_data, list);
+		if (b->retain_data || b == retain)
+			continue;
+		if (b->data) {
+			free_base_data(b);
+			if (base_cache_used <= base_cache_limit)
+				return;
+		}
 	}
-	free(ancestry);
 }
 
 static int is_delta_type(enum object_type type)
@@ -886,7 +895,7 @@ static void *get_base_data(struct base_data *c)
 		if (!delta_nr) {
 			c->data = get_data_from_pack(obj);
 			c->size = obj->size;
-			get_thread_data()->base_cache_used += c->size;
+			base_cache_used += c->size;
 			prune_base_data(c);
 		}
 		for (; delta_nr > 0; delta_nr--) {
@@ -902,7 +911,7 @@ static void *get_base_data(struct base_data *c)
 			free(raw);
 			if (!c->data)
 				bad_object(obj->idx.offset, _("failed to apply delta"));
-			get_thread_data()->base_cache_used += c->size;
+			base_cache_used += c->size;
 			prune_base_data(c);
 		}
 		free(delta);
@@ -920,6 +929,8 @@ static struct base_data *make_base(struct object_entry *obj,
 				&base->ref_first, &base->ref_last);
 	find_ofs_delta_children(obj->idx.offset,
 				&base->ofs_first, &base->ofs_last);
+	base->children_remaining = base->ref_last - base->ref_first +
+		base->ofs_last - base->ofs_first + 2;
 	return base;
 }
 
@@ -953,14 +964,8 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 		    &delta_obj->idx.oid);
 
 	result = make_base(delta_obj, base);
-	if (result->ref_last == -1 && result->ofs_last == -1) {
-		free(result_data);
-	} else {
-		result->data = result_data;
-		result->size = result_size;
-		get_thread_data()->base_cache_used += result->size;
-		prune_base_data(result);
-	}
+	result->data = result_data;
+	result->size = result_size;
 
 	counter_lock();
 	nr_resolved_deltas++;
@@ -969,84 +974,6 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 	return result;
 }
 
-/*
- * Standard boolean compare-and-swap: atomically check whether "*type" is
- * "want"; if so, swap in "set" and return true. Otherwise, leave it untouched
- * and return false.
- */
-static int compare_and_swap_type(signed char *type,
-				 enum object_type want,
-				 enum object_type set)
-{
-	enum object_type old;
-
-	type_cas_lock();
-	old = *type;
-	if (old == want)
-		*type = set;
-	type_cas_unlock();
-
-	return old == want;
-}
-
-static struct base_data *find_unresolved_deltas_1(struct base_data *base,
-						  struct base_data *prev_base)
-{
-	if (base->ref_first <= base->ref_last) {
-		struct object_entry *child = objects + ref_deltas[base->ref_first].obj_no;
-		struct base_data *result;
-
-		if (!compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
-					   base->obj->real_type))
-			BUG("child->real_type != OBJ_REF_DELTA");
-
-		get_base_data(base);
-		result = resolve_delta(child, base);
-		if (base->ref_first == base->ref_last && base->ofs_last == -1)
-			free_base_data(base);
-
-		base->ref_first++;
-		return result;
-	}
-
-	if (base->ofs_first <= base->ofs_last) {
-		struct object_entry *child = objects + ofs_deltas[base->ofs_first].obj_no;
-		struct base_data *result;
-
-		assert(child->real_type == OBJ_OFS_DELTA);
-		child->real_type = base->obj->real_type;
-		get_base_data(base);
-		result = resolve_delta(child, base);
-		if (base->ofs_first == base->ofs_last)
-			free_base_data(base);
-
-		base->ofs_first++;
-		return result;
-	}
-
-	free_base_data(base);
-	return NULL;
-}
-
-static void find_unresolved_deltas(struct base_data *base)
-{
-	struct base_data *new_base, *prev_base = NULL;
-	for (;;) {
-		new_base = find_unresolved_deltas_1(base, prev_base);
-
-		if (new_base) {
-			prev_base = base;
-			base = new_base;
-		} else {
-			free(base);
-			base = prev_base;
-			if (!base)
-				return;
-			prev_base = base->base;
-		}
-	}
-}
-
 static int compare_ofs_delta_entry(const void *a, const void *b)
 {
 	const struct ofs_delta_entry *delta_a = a;
@@ -1065,33 +992,97 @@ static int compare_ref_delta_entry(const void *a, const void *b)
 	return oidcmp(&delta_a->oid, &delta_b->oid);
 }
 
-static void resolve_base(struct object_entry *obj)
+static void *do_work(void *data)
 {
-	struct base_data *base_obj = make_base(obj, NULL);
-
-	find_unresolved_deltas(base_obj);
-}
-
-static void *threaded_second_pass(void *data)
-{
-	set_thread_data(data);
+	if (data)
+		set_thread_data(data);
 	for (;;) {
-		int i;
-		counter_lock();
-		display_progress(progress, nr_resolved_deltas);
-		counter_unlock();
+		struct base_data *parent = NULL;
+		struct object_entry *child_obj;
+		struct base_data *child;
+
 		work_lock();
-		while (nr_dispatched < nr_objects &&
-		       is_delta_type(objects[nr_dispatched].type))
-			nr_dispatched++;
-		if (nr_dispatched >= nr_objects) {
-			work_unlock();
-			break;
+		if (list_empty(&work_head)) {
+			while (nr_dispatched < nr_objects &&
+			       is_delta_type(objects[nr_dispatched].type))
+				nr_dispatched++;
+			if (nr_dispatched >= nr_objects) {
+				work_unlock();
+				break;
+			}
+			child_obj = &objects[nr_dispatched++];
+		} else {
+			parent = list_first_entry(&work_head, struct base_data,
+						  list);
+
+			if (parent->ref_first <= parent->ref_last) {
+				child_obj = objects +
+					ref_deltas[parent->ref_first++].obj_no;
+				assert(child_obj->real_type == OBJ_REF_DELTA);
+				child_obj->real_type = parent->obj->real_type;
+			} else {
+				child_obj = objects +
+					ofs_deltas[parent->ofs_first++].obj_no;
+				assert(child_obj->real_type == OBJ_OFS_DELTA);
+				child_obj->real_type = parent->obj->real_type;
+			}
+
+			if (parent->ref_first > parent->ref_last &&
+			    parent->ofs_first > parent->ofs_last) {
+				list_del(&parent->list);
+				list_add(&parent->list, &done_head);
+			}
+
+			get_base_data(parent);
+			parent->retain_data++;
 		}
-		i = nr_dispatched++;
 		work_unlock();
 
-		resolve_base(&objects[i]);
+		if (parent) {
+			child = resolve_delta(child_obj, parent);
+			if (!child->children_remaining)
+				FREE_AND_NULL(child->data);
+		} else {
+			child = make_base(child_obj, NULL);
+			if (child->children_remaining) {
+				/*
+				 * Since this child has its own delta children,
+				 * we will need this data in the future.
+				 * Inflate now so that future iterations will
+				 * have access to this object's data while
+				 * outside the work mutex.
+				 */
+				child->data = get_data_from_pack(child_obj);
+				child->size = child_obj->size;
+			}
+		}
+
+		work_lock();
+		if (parent)
+			parent->retain_data--;
+		if (child->data) {
+			list_add(&child->list, &work_head);
+			base_cache_used += child->size;
+			prune_base_data(NULL);
+		} else {
+			struct base_data *p = parent;
+
+			while (p) {
+				struct base_data *next_p;
+
+				p->children_remaining--;
+				if (p->children_remaining)
+					break;
+
+				next_p = p->base;
+				free_base_data(p);
+				list_del(&p->list);
+				free(p);
+
+				p = next_p;
+			}
+		}
+		work_unlock();
 	}
 	return NULL;
 }
@@ -1192,11 +1183,12 @@ static void resolve_deltas(void)
 					  nr_ref_deltas + nr_ofs_deltas);
 
 	nr_dispatched = 0;
+	base_cache_limit = delta_base_cache_limit * nr_threads;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
 		for (i = 0; i < nr_threads; i++) {
 			int ret = pthread_create(&thread_data[i].thread, NULL,
-						 threaded_second_pass, thread_data + i);
+						 do_work, thread_data + i);
 			if (ret)
 				die(_("unable to create thread: %s"),
 				    strerror(ret));
@@ -1206,7 +1198,7 @@ static void resolve_deltas(void)
 		cleanup_thread();
 		return;
 	}
-	threaded_second_pass(&nothread_data);
+	do_work(&nothread_data);
 }
 
 /*
@@ -1362,10 +1354,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 	for (i = 0; i < nr_ref_deltas; i++) {
 		struct ref_delta_entry *d = sorted_by_pos[i];
 		enum object_type type;
-		struct base_data *base;
 		void *data;
 		unsigned long size;
-		struct object_entry *obj;
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
@@ -1376,11 +1366,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		if (check_object_signature(&d->oid, data,
 					   size, type_name(type)))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
-		obj = append_obj_to_pack(f, d->oid.hash, data, size, type);
-		base = make_base(obj, NULL);
-		base->data = data;
-		base->size = size;
-		find_unresolved_deltas(base);
+		append_obj_to_pack(f, d->oid.hash, data, size, type);
+		do_work(NULL); /* will pick up new object in objects array (added by append_obj_to_pack) */
 		display_progress(progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
-- 
2.23.0.581.g78d2f28ef7-goog

