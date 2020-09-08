Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA23C2BC11
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77242145D
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QcKaLynV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgIHTt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbgIHTsw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:48:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52324C061795
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 12:48:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s3so157124ybi.18
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nojDSosNK3fk9/Ttz8oIEPQVNcGaJNLyPfASgErRs9Q=;
        b=QcKaLynVrKSSXJl8VIL4KbipS3N4pdTt6WJhqyyMlCYjBhVMM/4YcdhnL899Ejr/6j
         qYZ6lwwpzO5D/1MRFB+V6jN/bY5Rkm9GtvSJFDGlLku8NT5Kknm+BUTG0ZFmp9a4InKb
         xgw9nfEDxRG7rjFCkk9DHIJP/Kam95UUg2azmgQS4d6U/aLRvF+ZjNiBMVFG7Icf6es+
         u30uc83+gBIu3vy0erB8YvZzXg50MV1XQwQYKP3xX/Vuj/AbYL1V16QGyJRx9uaR2OKU
         WZKIaFsnVE3rbBsGXCIHc+6vIvCoY+nRpCQ4HnbPm2UMAvNMmb1k0KjJNhO7uaaCfxVp
         Cy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nojDSosNK3fk9/Ttz8oIEPQVNcGaJNLyPfASgErRs9Q=;
        b=S9+xV9qxixb4a490vU4mhybdvCk/Nr0DFqtwtj+yKSx845brZs55IaSuzyNweZvlxJ
         u2Nnd/B+mCPl7aHR+9ynIgUOLmeTdGl8+r9LAEMGtCcmFgPyqorvN6Jvn+0oHISTVdAa
         4GUV7Oh8HzpxSDAizI5aqLil/YNEQSkFPAKc36gRtaFg/8rY1mWm6ySERyDlXFJtgwQe
         D3M3+QKAA58j8OzkwpJ4hESW/uVUFwWw02tNHijcuL/OBEYY+UUtZQn0+xQFc/KAxtEs
         /O6J3Mwcc5rnwi2sARsYbREgE2vyoRmRbMKeussB9GDT5oPrUXHptmjoOXy7cLwopYFb
         KDGQ==
X-Gm-Message-State: AOAM533GjOsZvURc20wHkP1T9xIvaUJBB4d60NFAed2NnosPS6Yb3AoV
        TRj4dETb5c+ItqwmaPbju3L0p+TpLbLU3infj0M1TbZQ5n/SI/KeOd1+ANsBe39IO9ga4RyxbMs
        RTPVtGp99daRHM8o7QBUORETzjufpbyTDeXuyTJNMHu2HXTckbwqYCnd0hVtYyu4otk2AVxkwoC
        1c
X-Google-Smtp-Source: ABdhPJzX5wyvg3cPLw5M+zpAgMX/WJ4HXj3wlFE3oKFWZnIFep9vZ28YPXZyCmeDERFg2lt30FrvhBa19DRo1/LjR9tb
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ca85:: with SMTP id
 a127mr730560ybg.113.1599594530376; Tue, 08 Sep 2020 12:48:50 -0700 (PDT)
Date:   Tue,  8 Sep 2020 12:48:33 -0700
In-Reply-To: <cover.1599594441.git.jonathantanmy@google.com>
Message-Id: <cb0b3738dd0bc018e7f2677ca3b172364bf18961.1599594441.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com> <cover.1599594441.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 5/7] index-pack: calculate {ref,ofs}_{first,last} early
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is refactoring 2 of 2 to simplify struct base_data.

Whenever we make a struct base_data, immediately calculate its delta
children. This eliminates confusion as to when the
{ref,ofs}_{first,last} fields are initialized.

Before this patch, the delta children were calculated at the last
possible moment. This allowed the members of struct base_data to be
populated in any order, superficially useful when we have the object
contents before the struct object_entry. But this makes reasoning about
the state of struct base_data more complicated, hence this patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 123 +++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 63 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c8db464557..94d0f53b03 100644
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
@@ -929,10 +911,25 @@ static void *get_base_data(struct base_data *c)
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
@@ -946,19 +943,31 @@ static void resolve_delta(struct object_entry *delta_obj,
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
-	hash_object_file(the_hash_algo, result->data, result->size,
+	hash_object_file(the_hash_algo, result_data, result_size,
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
@@ -984,24 +993,9 @@ static int compare_and_swap_type(signed char *type,
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
@@ -1009,7 +1003,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 			    (uintmax_t)child->idx.offset,
 			    oid_to_hex(&base->obj->idx.oid));
 
-		resolve_delta(child, base, result);
+		result = resolve_delta(child, base);
 		if (base->ref_first == base->ref_last && base->ofs_last == -1)
 			free_base_data(base);
 
@@ -1019,11 +1013,11 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 
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
 
@@ -1031,7 +1025,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 		return result;
 	}
 
-	unlink_base_data(base);
+	free_base_data(base);
 	return NULL;
 }
 
@@ -1074,9 +1068,8 @@ static int compare_ref_delta_entry(const void *a, const void *b)
 
 static void resolve_base(struct object_entry *obj)
 {
-	struct base_data *base_obj = alloc_base_data();
-	base_obj->obj = obj;
-	base_obj->data = NULL;
+	struct base_data *base_obj = make_base(obj, NULL);
+
 	find_unresolved_deltas(base_obj);
 }
 
@@ -1369,22 +1362,26 @@ static void fix_unresolved_deltas(struct hashfile *f)
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
 
 		if (check_object_signature(the_repository, &d->oid,
-					   base_obj->data, base_obj->size,
+					   data, size,
 					   type_name(type)))
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
2.28.0.526.ge36021eeef-goog

