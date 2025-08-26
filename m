Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E92F1FDC
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187537; cv=none; b=tqNMelX25M9u3aKspwnKY/PYcD2RVrPyYrUrYoK4T8qoX633mhC+wWCQqfkA7lxdvFKqXU9eEsWsU5pO46TSCdQhs1OIPbXbujmywjovNpmOBTTBNSI/ji45hUecmLC/5plCafTY+sU/iWkptv+AwgW3Wzd12bDxXlCdZbwCfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187537; c=relaxed/simple;
	bh=q4kTyps5lktf+sxwIG/McLcavdu2HIsq4f4+fAUValA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWs4hKZ+Uvl7tIO6O2qj4x+eCv9jBimSjwSNk19c4TijHI5P9jqZmOe9IJwlzqv9Cs10wyRkbFi3XHKtQd/DQNRWV4kDZIFEoDErUYJJhafGaPWZ5lDsIAUhmRN7xsTRIUh5MQueOvyDvLlM/dNIgDHv3886uEskQTUF2CsX89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bYRHtMgK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bYRHtMgK"
Received: (qmail 114983 invoked by uid 109); 26 Aug 2025 05:52:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=q4kTyps5lktf+sxwIG/McLcavdu2HIsq4f4+fAUValA=; b=bYRHtMgKSp0IdFkD16su+LkK8CbY8NqhguhAHspcVzQqKJ0FuviUClPJNMTnL9m2M6l3X07SEMfaWtQshBLwOj7t5beYJnHn8hLHLoZ1klbJcTs82RBmFI/we8b6EPEKHHhq59/OmUe9zo4QdMN/gEksuopRLTEHjLTM1exX8RqQN39V32J+k96tdKg+MH7QIGKxm8BXhPY0mDCepEVm8j5511iYlesW7upzEz7pslTg8XNX9UfM/2pCzi8MxD715ZnPJvoc+MjDmyrr7el/7mlpzTcVx0QoTYcUfpDChuaWloqBL07eX0xW+cjs+2nVaT9jbW+iTpjUdZnEp58bgQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Aug 2025 05:52:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 167902 invoked by uid 111); 26 Aug 2025 05:52:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Aug 2025 01:52:11 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 26 Aug 2025 01:52:10 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
Message-ID: <20250826055210.GA1031277@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
 <20250825081345.GA352784@coredump.intra.peff.net>
 <xmqqcy8jqlue.fsf@gitster.g>
 <20250826033920.GA388997@coredump.intra.peff.net>
 <20250826042607.GA995491@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826042607.GA995491@coredump.intra.peff.net>

On Tue, Aug 26, 2025 at 12:26:07AM -0400, Jeff King wrote:

> This particular case may not be representative, either. I picked it
> because it was easy to convert. But I wonder how bad it would be to put
> the object flags for a traversal into a hash. Right now those are in the
> original struct, not even in a commit-slab. So I'd guess it's an even
> bigger slowdown.

Just for fun, and because I hadn't tortured myself with coccinelle
syntax in a while, I tried removing object.flags entirely. Apply the
patch below, then:

  make SPATCH_USE_O_DEPENDENCIES= contrib/coccinelle/flags.cocci.patch
  git apply contrib/coccinelle/flags.cocci.patch

That misses a few stragglers, which I'll include fixes for below.
Anyway, the result is a system that does hash lookups for every access
of the "flags" field. I added a few helpers to do |= and &= without
doing two lookups. Probably this could go a little further with some
kind of test-and-set (e.g., you want to know if SEEN is set and if not,
set it and do some other stuff). But it gives a general idea.

I tried timing merge-base which I know will need to paint flags, using
an old commit (so that we have to walk almost down to the root). Here
are the results:

  Benchmark 1: ./git.orig merge-base HEAD 19b2860cba574
    Time (mean ± σ):      31.7 ms ±   0.7 ms    [User: 26.1 ms, System: 5.5 ms]
    Range (min … max):    30.5 ms …  34.0 ms    89 runs
  
  Benchmark 2: ./git.hash merge-base HEAD 19b2860cba574
    Time (mean ± σ):      39.7 ms ±   0.7 ms    [User: 33.9 ms, System: 5.8 ms]
    Range (min … max):    38.5 ms …  42.6 ms    75 runs
  
  Summary
    ./git.orig merge-base HEAD 19b2860cba574 ran
      1.25 ± 0.03 times faster than ./git.hash merge-base HEAD 19b2860cba574

And here's a rev-list which needs to set SEEN on a lot of objects (but
also has to actually inflate a lot of trees, too):

  $ hyperfine -L v orig,hash './git.{v} rev-list --objects --all'
  Benchmark 1: ./git.orig rev-list --objects --all
    Time (mean ± σ):      2.875 s ±  0.050 s    [User: 2.799 s, System: 0.075 s]
    Range (min … max):    2.803 s …  2.973 s    10 runs
  
  Benchmark 2: ./git.hash rev-list --objects --all
    Time (mean ± σ):      5.547 s ±  0.069 s    [User: 5.477 s, System: 0.070 s]
    Range (min … max):    5.396 s …  5.671 s    10 runs
  
  Summary
    ./git.orig rev-list --objects --all ran
      1.93 ± 0.04 times faster than ./git.hash rev-list --objects --all


I expected the merge-base to fare much worse, since it's otherwise
mostly just pulling commit data from the commit-graph file and walking
the pointers. But I guess we check a lot of SEEN flags for rev-list.

Anyway, I think the numbers there demonstrate that it's probably not
that interesting a direction. I'm a little curious how a slab would
fare. It shouldn't be _too_ hard to slot it in with a similar API (the
real work was adjusting all the callers via cocci). But I'm not sure I
have the stomach to waste more time on this. ;)

Patches below for reference. This is the one that rips out the flags
field:

---
 contrib/coccinelle/flags.cocci | 59 ++++++++++++++++++++++++++++++++++
 object.c                       |  5 ++-
 object.h                       | 29 ++++++++++++++++-
 3 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100644 contrib/coccinelle/flags.cocci

diff --git a/contrib/coccinelle/flags.cocci b/contrib/coccinelle/flags.cocci
new file mode 100644
index 0000000000..5dae0054d6
--- /dev/null
+++ b/contrib/coccinelle/flags.cocci
@@ -0,0 +1,59 @@
+@@
+struct object *OBJPTR;
+expression FLAGS;
+@@
+- OBJPTR->flags |= FLAGS
++ objflags_set(OBJPTR, FLAGS)
+
+@@
+struct object *OBJPTR;
+expression FLAGS;
+@@
+- OBJPTR->flags &= FLAGS
++ objflags_clear(OBJPTR, FLAGS)
+
+@@
+struct object *OBJPTR;
+@@
+- OBJPTR->flags
++ objflags_get(OBJPTR)
+
+@@
+expression TYPEDOBJ;
+expression FLAGS;
+@@
+- TYPEDOBJ->object.flags |= FLAGS
++ objflags_set(&TYPEDOBJ->object, FLAGS)
+
+@@
+expression TYPEDOBJ;
+expression FLAGS;
+@@
+- TYPEDOBJ->object.flags &= FLAGS
++ objflags_clear(&TYPEDOBJ->object, FLAGS)
+
+@@
+expression TYPEDOBJ;
+@@
+- TYPEDOBJ->object.flags
++ objflags_get(&TYPEDOBJ->object)
+
+@@
+struct object_array_entry *ENTRY;
+expression FLAGS;
+@@
+- ENTRY->item->flags |= FLAGS
++ objflags_set(ENTRY->item, FLAGS)
+
+@@
+struct object_array_entry *ENTRY;
+expression FLAGS;
+@@
+- ENTRY->item->flags &= FLAGS
++ objflags_clear(ENTRY->item, FLAGS)
+
+@@
+struct object_array_entry *ENTRY;
+@@
+- ENTRY->item->flags
++ objflags_get(ENTRY->item)
diff --git a/object.c b/object.c
index c1553ee433..679aadbd7b 100644
--- a/object.c
+++ b/object.c
@@ -14,6 +14,9 @@
 #include "alloc.h"
 #include "commit-graph.h"
 
+static kh_obj_flags_t objflags_data;
+kh_obj_flags_t *objflags = &objflags_data;
+
 unsigned int get_max_object_index(const struct repository *repo)
 {
 	return repo->parsed_objects->obj_hash_size;
@@ -149,7 +152,7 @@ void *create_object(struct repository *r, const struct object_id *oid, void *o)
 	struct object *obj = o;
 
 	obj->parsed = 0;
-	obj->flags = 0;
+	/* flags default to 0 via flags hash */
 	oidcpy(&obj->oid, oid);
 
 	if (r->parsed_objects->obj_hash_size - 1 <= r->parsed_objects->nr_objs * 2)
diff --git a/object.h b/object.h
index 14718051f2..50d1d0e65f 100644
--- a/object.h
+++ b/object.h
@@ -159,7 +159,6 @@ static inline unsigned int canon_mode(unsigned int mode)
 struct object {
 	unsigned parsed : 1;
 	unsigned type : TYPE_BITS;
-	unsigned flags : FLAG_BITS;
 	struct object_id oid;
 };
 
@@ -369,5 +368,33 @@ static inline value_type name##_get(kh_##name##_t *map, const struct object *obj
 }
 
 OBJHASH_INIT(obj_timestamp, timestamp_t, 0);
+OBJHASH_INIT(obj_flags, unsigned, 0);
+
+extern kh_obj_flags_t *objflags;
+
+static inline unsigned objflags_get(const struct object *obj)
+{
+	return obj_flags_get(objflags, obj);
+}
+
+static inline void objflags_set(const struct object *obj, unsigned flags)
+{
+	int hash_ret;
+	khiter_t pos = kh_put_obj_flags(objflags, obj, &hash_ret);
+	if (!hash_ret)
+		kh_value(objflags, pos) |= flags;
+	else
+		kh_value(objflags, pos) = flags;
+}
+
+static inline void objflags_clear(const struct object *obj, unsigned flags)
+{
+	int hash_ret;
+	khiter_t pos = kh_put_obj_flags(objflags, obj, &hash_ret);
+	if (!hash_ret)
+		kh_value(objflags, pos) &= flags;
+	else
+		kh_value(objflags, pos) = 0;
+}
 
 #endif /* OBJECT_H */

And then this one gives you the fixups on top of applying the cocci
patch:

---
 builtin/describe.c |  5 +++--
 builtin/fsck.c     |  2 +-
 builtin/log.c      | 10 +++++-----
 commit-graph.c     |  2 +-
 commit-reach.c     |  2 +-
 http-push.c        |  2 +-
 range-diff.c       |  2 +-
 reflog.c           |  6 +++---
 revision.c         |  4 ++--
 9 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b9ebdb9a3d..aeb3b3344f 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -290,7 +290,7 @@ static bool all_have_flag(const struct lazy_queue *queue, unsigned flag)
 {
 	for (size_t i = queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) {
 		struct commit *commit = queue->queue.array[i].data;
-		if (!(commit->object.flags & flag))
+		if (!(objflags_get(&commit->object) & flag))
 			return false;
 	}
 	return true;
@@ -398,7 +398,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		have_util = 1;
 	}
 
-	objflags_get(&cmit->object) = SEEN;
+	/* weird, this assigns SEEN instead of OR-ing it? */
+	obj_flags_put(objflags, &cmit->object, SEEN);
 	lazy_queue_put(&queue, cmit);
 	while (!lazy_queue_empty(&queue)) {
 		struct commit *c = lazy_queue_get(&queue);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index c2a3df8c1d..c5d5a4ea75 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -214,7 +214,7 @@ static int mark_used(struct object *obj, enum object_type type UNUSED,
 {
 	if (!obj)
 		return 1;
-	obj->flags |= USED;
+	objflags_set(obj, USED);
 	return 0;
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 9ceeace9c3..34ba1ff782 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1164,8 +1164,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	/* given a range a..b get all patch ids for b..a */
 	repo_init_revisions(the_repository, &check_rev, rev->prefix);
 	check_rev.max_parents = 1;
-	objflags_get(o1) ^= UNINTERESTING;
-	objflags_get(o2) ^= UNINTERESTING;
+	obj_flags_put(objflags, o1, objflags_get(o1) ^ UNINTERESTING);
+	obj_flags_put(objflags, o2, objflags_get(o2) ^ UNINTERESTING);
 	add_pending_object(&check_rev, o1, "o1");
 	add_pending_object(&check_rev, o2, "o2");
 	if (prepare_revision_walk(&check_rev))
@@ -1178,8 +1178,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	/* reset for next revision walk */
 	clear_commit_marks(c1, SEEN | UNINTERESTING | SHOWN | ADDED);
 	clear_commit_marks(c2, SEEN | UNINTERESTING | SHOWN | ADDED);
-	objflags_get(o1) = flags1;
-	objflags_get(o2) = flags2;
+	obj_flags_put(objflags, o1, flags1);
+	obj_flags_put(objflags, o2, flags2);
 }
 
 static void gen_message_id(struct rev_info *info, const char *base)
@@ -2224,7 +2224,7 @@ int cmd_format_patch(int argc,
 			 * origin" that prepares what the origin side still
 			 * does not have.
 			 */
-			rev.pending.objects[0].item->flags |= UNINTERESTING;
+			objflags_set(rev.pending.objects[0].item, UNINTERESTING);
 			add_head_to_pending(&rev);
 			check_head = 1;
 		}
diff --git a/commit-graph.c b/commit-graph.c
index 89a48171e4..a29f716523 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1568,7 +1568,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 		commit = lookup_commit(ctx->r, &ctx->oids.oid[i]);
 
 		if (commit)
-			commit->object.flags &= ~REACHABLE;
+			objflags_clear(&commit->object, ~REACHABLE);
 	}
 	stop_progress(&ctx->progress);
 }
diff --git a/commit-reach.c b/commit-reach.c
index 329c61d559..3189aee0db 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -812,7 +812,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 			 * leave a note to ourselves not to worry about
 			 * this object anymore.
 			 */
-			from->objects[i].item->flags |= assign_flag;
+			objflags_set(from->objects[i].item, assign_flag);
 			continue;
 		}
 
diff --git a/http-push.c b/http-push.c
index 0706929cac..5d7635988e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1377,7 +1377,7 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 	while (objects) {
 		struct object_list *next = objects->next;
 
-		if (!(objects->item->flags & UNINTERESTING))
+		if (!(objflags_get(objects->item) & UNINTERESTING))
 			count += add_send_request(objects->item, lock);
 
 		free(objects);
diff --git a/range-diff.c b/range-diff.c
index 8a2dcbee32..2774720615 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -611,7 +611,7 @@ int is_range_diff_range(const char *arg)
 	repo_init_revisions(the_repository, &revs, NULL);
 	if (setup_revisions(3, argv, &revs, NULL) == 1) {
 		for (i = 0; i < revs.pending.nr; i++)
-			if (revs.pending.objects[i].item->flags & UNINTERESTING)
+			if (objflags_get(revs.pending.objects[i].item) & UNINTERESTING)
 				negative++;
 			else
 				positive++;
diff --git a/reflog.c b/reflog.c
index 879e802228..ff99a8353c 100644
--- a/reflog.c
+++ b/reflog.c
@@ -244,12 +244,12 @@ static int commit_is_complete(struct commit *commit)
 		if (!is_incomplete) {
 			/* mark all found commits as complete, iow SEEN */
 			for (i = 0; i < found.nr; i++)
-				found.objects[i].item->flags |= SEEN;
+				objflags_set(found.objects[i].item, SEEN);
 		}
 	}
 	/* clear flags from the objects we traversed */
 	for (i = 0; i < found.nr; i++)
-		found.objects[i].item->flags &= ~STUDYING;
+		objflags_clear(found.objects[i].item, ~STUDYING);
 	if (is_incomplete)
 		objflags_set(&commit->object, INCOMPLETE);
 	else {
@@ -262,7 +262,7 @@ static int commit_is_complete(struct commit *commit)
 		 * we have seen during this process are complete.
 		 */
 		for (i = 0; i < found.nr; i++)
-			found.objects[i].item->flags |= SEEN;
+			objflags_set(found.objects[i].item, SEEN);
 	}
 	/* free object arrays */
 	object_array_clear(&study);
diff --git a/revision.c b/revision.c
index 90e3ee30d5..4fd4b96eb1 100644
--- a/revision.c
+++ b/revision.c
@@ -3656,10 +3656,10 @@ static void trace2_topo_walk_statistics_atexit(void)
 
 static inline void test_flag_and_insert(struct prio_queue *q, struct commit *c, int flag)
 {
-	if (c->object.flags & flag)
+	if (objflags_get(&c->object) & flag)
 		return;
 
-	c->object.flags |= flag;
+	objflags_set(&c->object, flag);
 	prio_queue_put(q, c);
 }
 
-- 
2.51.0.382.g68ff637df6


