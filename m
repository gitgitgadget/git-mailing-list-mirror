Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8CC1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 23:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbfJIXoj (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 19:44:39 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50496 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732453AbfJIXoj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 19:44:39 -0400
Received: by mail-pg1-f202.google.com with SMTP id r24so2848791pgj.17
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 16:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vfVKLDVvz1vgelhZRwxAz5ryowrHlYdbTANJzXjWwb0=;
        b=TqX/aWsm4MZT/VZ/0FwAf/gzbgTYOZ39MHdiAI3tDwHEJ0aT4JwueZDVvQS2CbWtUE
         4KbuRuvfsb4uM6jzHV/HtoefSg8dUVlgbJEVQUGyrBnpEVdRmz+KwHN1vL9Xjap8OEF5
         ALw7OmzGQqzbQ4AWnZCwj/2IReX3BsxxmQ4UGudyZDLDOwXJlPdTVgzVTdy1xYyskgf1
         u0PW9D35ep6U3YF55ux9qL0BuKCQHgkunHrngQP9kbtun1r40sUXcgRkdmwUQAAvJn5S
         62lhbzrbHHPdAlLx5NnXIUX9X0w8RCJRz0tHlPbpmV5V37koS7iVlu8g31XsCz500GmJ
         HDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vfVKLDVvz1vgelhZRwxAz5ryowrHlYdbTANJzXjWwb0=;
        b=X1eTvBbZ94Dqtcx0fwlvQ+kTFI2nl7NZyqehtZKApgqPjrm1nG7nQRyisU/oqAE6qF
         dPIGpBAXrOIce6vglPakr0naIB3ELo2OTq5O6JPjLk63HMJ2TKQllbGFZscfkYsbEWtu
         iv0dFqoLRUtpXDOv4SwZbmbc97w1eXuYur47nk8lOhcKsdxQ33U4qlH7S2J2KaCgcqz3
         2cQ32z4T155iQXqkl8HCPu/odosPK0Ql4ZWD7t2Sil7IZxqWei4sKIxYTH83JMss65QM
         qFX5O/JwpZ4QGYNhvJfLaP9ysBJ2rRX4dk/4zJwlUj55ldlmF7tcELcaTBxLMdePuN6J
         8sFg==
X-Gm-Message-State: APjAAAV9x+jzPsCtzezpoQTeWRIOEw27q1a1PZASBiCTAjlQ3Tsu9lbR
        PCfNVMsJOwiGLh97Idh85+zx+yAwvyN3xxVHSnC1jEje7xoct+9GFConDNIveAgKY+RWrIwXFYY
        TBeUwT+Pq8MRHubqKO7K9WvyD/e01EXidXimu5ml8PpHYRtp7Qf7nbMYDecEHARAfRSAJtgUTaP
        10
X-Google-Smtp-Source: APXvYqyI2Qw/FidcEcsZxhpAuZKjE1DX0bXMrQwdBLUk0egzE0ocQJJzLkT3viOadvkScBBiPcIsAwmysd1wW8ecPAxt
X-Received: by 2002:a65:5302:: with SMTP id m2mr6979084pgq.336.1570664677997;
 Wed, 09 Oct 2019 16:44:37 -0700 (PDT)
Date:   Wed,  9 Oct 2019 16:44:20 -0700
In-Reply-To: <cover.1570663470.git.jonathantanmy@google.com>
Message-Id: <0f0ffe71c5df9129a04546b8e3ed13a3ece1b9b1.1570663470.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 4/6] index-pack: calculate {ref,ofs}_{first,last} early
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever we make a struct base_data, immediately calculate its delta
children. This eliminates confusion as to when the
{ref,ofs}_{first,last} fields are initialized.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 125 +++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 64 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 35f7f9e52b..17997834ec 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -33,12 +33,15 @@ struct object_stat {
 };
 
 struct base_data {
+	/* Initialized by make_base(). */
 	struct base_data *base;
 	struct object_entry *obj;
-	void *data;
-	unsigned long size;
 	int ref_first, ref_last;
 	int ofs_first, ofs_last;
+
+	/* Not initialized by make_base(). */
+	void *data;
+	unsigned long size;
 };
 
 struct thread_local {
@@ -362,14 +365,6 @@ static void set_thread_data(struct thread_local *data)
 		pthread_setspecific(key, data);
 }
 
-static struct base_data *alloc_base_data(void)
-{
-	struct base_data *base = xcalloc(1, sizeof(struct base_data));
-	base->ref_last = -1;
-	base->ofs_last = -1;
-	return base;
-}
-
 static void free_base_data(struct base_data *c)
 {
 	if (c->data) {
@@ -406,19 +401,6 @@ static void prune_base_data(struct base_data *youngest_child)
 	free(ancestry);
 }
 
-static void link_base_data(struct base_data *base, struct base_data *c)
-{
-	c->base = base;
-	if (c->data)
-		get_thread_data()->base_cache_used += c->size;
-	prune_base_data(c);
-}
-
-static void unlink_base_data(struct base_data *c)
-{
-	free_base_data(c);
-}
-
 static int is_delta_type(enum object_type type)
 {
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
@@ -928,10 +910,25 @@ static void *get_base_data(struct base_data *c)
 	return c->data;
 }
 
-static void resolve_delta(struct object_entry *delta_obj,
-			  struct base_data *base, struct base_data *result)
+static struct base_data *make_base(struct object_entry *obj,
+				   struct base_data *parent)
 {
-	void *base_data, *delta_data;
+	struct base_data *base = xcalloc(1, sizeof(struct base_data));
+	base->base = parent;
+	base->obj = obj;
+	find_ref_delta_children(&obj->idx.oid,
+				&base->ref_first, &base->ref_last);
+	find_ofs_delta_children(obj->idx.offset,
+				&base->ofs_first, &base->ofs_last);
+	return base;
+}
+
+static struct base_data *resolve_delta(struct object_entry *delta_obj,
+				       struct base_data *base)
+{
+	void *base_data, *delta_data, *result_data;
+	struct base_data *result;
+	unsigned long result_size;
 
 	if (show_stat) {
 		int i = delta_obj - objects;
@@ -945,19 +942,31 @@ static void resolve_delta(struct object_entry *delta_obj,
 	}
 	delta_data = get_data_from_pack(delta_obj);
 	base_data = get_base_data(base);
-	result->obj = delta_obj;
-	result->data = patch_delta(base_data, base->size,
-				   delta_data, delta_obj->size, &result->size);
+	result_data = patch_delta(base_data, base->size,
+				  delta_data, delta_obj->size, &result_size);
 	free(delta_data);
-	if (!result->data)
+	if (!result_data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
-	hash_object_file(result->data, result->size,
+	hash_object_file(result_data, result_size,
 			 type_name(delta_obj->real_type), &delta_obj->idx.oid);
-	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
+	sha1_object(result_data, NULL, result_size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
+
+	result = make_base(delta_obj, base);
+	if (result->ref_last == -1 && result->ofs_last == -1) {
+		free(result_data);
+	} else {
+		result->data = result_data;
+		result->size = result_size;
+		get_thread_data()->base_cache_used += result->size;
+		prune_base_data(result);
+	}
+
 	counter_lock();
 	nr_resolved_deltas++;
 	counter_unlock();
+
+	return result;
 }
 
 /*
@@ -983,30 +992,15 @@ static int compare_and_swap_type(signed char *type,
 static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 						  struct base_data *prev_base)
 {
-	if (base->ref_last == -1 && base->ofs_last == -1) {
-		find_ref_delta_children(&base->obj->idx.oid,
-					&base->ref_first, &base->ref_last);
-
-		find_ofs_delta_children(base->obj->idx.offset,
-					&base->ofs_first, &base->ofs_last);
-
-		if (base->ref_last == -1 && base->ofs_last == -1) {
-			free(base->data);
-			return NULL;
-		}
-
-		link_base_data(prev_base, base);
-	}
-
 	if (base->ref_first <= base->ref_last) {
 		struct object_entry *child = objects + ref_deltas[base->ref_first].obj_no;
-		struct base_data *result = alloc_base_data();
+		struct base_data *result;
 
 		if (!compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
 					   base->obj->real_type))
 			BUG("child->real_type != OBJ_REF_DELTA");
 
-		resolve_delta(child, base, result);
+		result = resolve_delta(child, base);
 		if (base->ref_first == base->ref_last && base->ofs_last == -1)
 			free_base_data(base);
 
@@ -1016,11 +1010,11 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 
 	if (base->ofs_first <= base->ofs_last) {
 		struct object_entry *child = objects + ofs_deltas[base->ofs_first].obj_no;
-		struct base_data *result = alloc_base_data();
+		struct base_data *result;
 
 		assert(child->real_type == OBJ_OFS_DELTA);
 		child->real_type = base->obj->real_type;
-		resolve_delta(child, base, result);
+		result = resolve_delta(child, base);
 		if (base->ofs_first == base->ofs_last)
 			free_base_data(base);
 
@@ -1028,7 +1022,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 		return result;
 	}
 
-	unlink_base_data(base);
+	free_base_data(base);
 	return NULL;
 }
 
@@ -1071,9 +1065,8 @@ static int compare_ref_delta_entry(const void *a, const void *b)
 
 static void resolve_base(struct object_entry *obj)
 {
-	struct base_data *base_obj = alloc_base_data();
-	base_obj->obj = obj;
-	base_obj->data = NULL;
+	struct base_data *base_obj = make_base(obj, NULL);
+
 	find_unresolved_deltas(base_obj);
 }
 
@@ -1367,21 +1360,25 @@ static void fix_unresolved_deltas(struct hashfile *f)
 	for (i = 0; i < nr_ref_deltas; i++) {
 		struct ref_delta_entry *d = sorted_by_pos[i];
 		enum object_type type;
-		struct base_data *base_obj = alloc_base_data();
+		struct base_data *base;
+		void *data;
+		unsigned long size;
+		struct object_entry *obj;
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
-		base_obj->data = read_object_file(&d->oid, &type,
-						  &base_obj->size);
-		if (!base_obj->data)
+		data = read_object_file(&d->oid, &type, &size);
+		if (!data)
 			continue;
 
-		if (check_object_signature(&d->oid, base_obj->data,
-				base_obj->size, type_name(type)))
+		if (check_object_signature(&d->oid, data,
+					   size, type_name(type)))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
-		base_obj->obj = append_obj_to_pack(f, d->oid.hash,
-					base_obj->data, base_obj->size, type);
-		find_unresolved_deltas(base_obj);
+		obj = append_obj_to_pack(f, d->oid.hash, data, size, type);
+		base = make_base(obj, NULL);
+		base->data = data;
+		base->size = size;
+		find_unresolved_deltas(base);
 		display_progress(progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
-- 
2.23.0.581.g78d2f28ef7-goog

