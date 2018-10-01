Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB46B1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 19:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeJBCAw (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 22:00:52 -0400
Received: from mout.web.de ([212.227.17.12]:57841 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeJBCAw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 22:00:52 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgfJz-1gL01c10UR-00Nz1l; Mon, 01
 Oct 2018 21:15:55 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgfJz-1gL01c10UR-00Nz1l; Mon, 01
 Oct 2018 21:15:55 +0200
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <20180811170248.GC27393@sigill.intra.peff.net>
 <20180811172350.GA2689@sigill.intra.peff.net>
 <f69e08d7-b29d-a9b7-b6d4-5294c4379133@web.de>
 <6065f3e5-f831-802f-9adc-099de99405fc@web.de>
 <20180814015842.GA27055@sigill.intra.peff.net>
 <030bac66-eeb4-7bc9-8f27-1e6b4124fd76@web.de>
 <20180827230314.GB10402@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9e2440cc-39a6-f51b-9aee-8536020ed033@web.de>
Date:   Mon, 1 Oct 2018 21:15:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180827230314.GB10402@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f2lyu0IywrKFLwiZXzlMFnr1lcGo0KcOYPHb5KmwTmr4gAW9CyZ
 kIWUZShog+XNZOTbS2FRM7eyiO7La6EAjb+eHZ8hD8ZJ8xIR5YZsidvA8QU/Uel+hmgaOVx
 L1R3yzYNf/pZcCteeJSSDl+jkXc6b5FXBPFsuroDtDp4ssNewzVGaK6raF53FDdD1qi6wAm
 Z+QuSYDt7nLLtEbVpiJ4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DyZoj9yoXRc=:ynDFxIBQPgWFgnydiYh2oq
 pXMBWC2QpBt7rPOEgGKk2NenhsbNjzkeqpNawLWnAcZy4YmpHjBitYEYrHJd4vPxKFoKcCP7c
 vSncM+ls3nCp7p3c2NWe1Ic86Deyd10a03xb+kd4CGJjmAqCjsH4neKA58MYq9jSM7KDe+T6F
 Qku0o0e2VZ09XTypworjBkeYo+R0ouosRdk8jqH1xZUnXBAqSjU52Q93IoJraAjFgKDuLus2v
 JoD2hk2Is/e3iVhZEjsws+6etcGR3LR2TASas+u7LQmEyDmF8VRtwW2zZgymPddF1XuXm5KUD
 M4Nf3xBxefSZtN6/UDipK4q2XEQQazJfcCcPGUAQrY1XgZ0/mjf3PLiT21dfSaEgBwJN3X4S1
 vJGM1CcLDKgx5cOz2DZcV4H1KIcZ1rwt3Lz4p6V4XrvrNET5IWPoKU7uV5V6RxV54FOyQG3Le
 DeXED4esjLvpBVCLqQiA2u04ku+hmuAmmNCBepzli7qur/PGVb+0q/sXNkT73eDeFvh6n+jvF
 ZhCA0c4ouK1riNyk6231kE6xqj/hjeVjuidVwXwgACxIwzGMmbQSzZg2GMenqM5DNx1qbmrmN
 Tldzh39DGjgluWCNA9+JybK3CmuhMVvQacQr2FcIDChzn0RbeWsw0XSttFRorEJDa2lXvlxng
 NIcg2zhsWaEJHhWbb54xWf75rsGnYxktQ/iuH6+Chm0Wkt6MvdBi6ofFhjHvje/EXYjf8ufPH
 Fjt4BWQ6OctF7z1bQ5QjXokBErlKXx2qg1l+CiI8EgtAHuvBA/480uUPDSvyJt2DbhqAIR55P
 yCYjMV8Rung3C5F4sMhrsCsK3ND/4oY+sExfJOvuSM7jS4zOrg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.08.2018 um 01:03 schrieb Jeff King:
> On Sun, Aug 26, 2018 at 01:37:41PM +0200, René Scharfe wrote:
>> So it seems worth it.
> 
> Hmm, that really does. Which is a shame, because I hoped that one day we
> could get rid of the nasty macro-infestation that is khash.h. But it
> really is a lot faster than the alternatives.

Well, we only compare it to hashmap.c here.  There might be better
implementations out there.  Hash tables in plain old C seem to be much
harder to find than e.g. in C++, though.

And then there are several possible variations that affect
performance -- perhaps hashmap.c could be improved by using open
addressing, maybe with Robin Hood hashing, and/or by offering better
support for sets, and/or by having a few macros to allow type
specialization.

But I like how khash.h is both already in the tree and also really easy
to deploy, as it's just a single header file.  It's a tasty low-hanging
fruit.

> Do you want to pick up this topic and carry it forward?

Well, I tried to simplify the implementation as much as possible and
ended up doing the opposite of what I wrote earlier.  Hmm.

The patch below postpones struct allocation until cleanup time, which is
a bit weird.  We can't avoid it fully without reimplementing kh_destroy,
but we can use structs supplied by callers for basically all other
operations.  That avoids NULL checks, and the main benefits of that are
simplicity and safety; performance is not much better without them.

This patch doesn't provide a _count (or _is_empty) method.  It would be
cleaner to have one added as the first step and just change its
implementation when switching to khash, but it's harder than expected
with hashmap.c; doing that later (if at all) is easier.

Using sha1hash instead of open-coding it may seem a bit anachronistic,
but is the best way to document the usage of that pattern (i.e. to
truncate a SHA1 hash to get a shorter one for a hash table).

-- >8 --
Subject: [PATCH] oidset: use khash

Reimplement struct oidset using khash.h in order to reduce its memory
footprint and make it faster.

This is straight-forward, except for oidset_clear(), which needs to
allocate a kh_oid_t on the heap in order to be able to feed it to
kh_destroy_oid() for release it.  Alternatively we could open-code the
relevant parts of the latter, but that would be a layering violation.

Performance of a command that mainly checks for duplicate objects
using an oidset, with master and Clang 6.0.1:

$ cmd="./git-cat-file --batch-all-objects --unordered --buffer --batch-check='%(objectname)'"

$ /usr/bin/time $cmd >/dev/null
0.22user 0.03system 0:00.25elapsed 99%CPU (0avgtext+0avgdata 48484maxresident)k
0inputs+0outputs (0major+11204minor)pagefaults 0swaps

$ hyperfine "$cmd"
Benchmark #1: ./git-cat-file --batch-all-objects --unordered --buffer --batch-check='%(objectname)'

  Time (mean ± σ):     250.0 ms ±   6.0 ms    [User: 225.9 ms, System: 23.6 ms]

  Range (min … max):   242.0 ms … 261.1 ms

And with this patch:

$ /usr/bin/time $cmd >/dev/null
0.14user 0.00system 0:00.15elapsed 100%CPU (0avgtext+0avgdata 41396maxresident)k
0inputs+0outputs (0major+8318minor)pagefaults 0swaps

$ hyperfine "$cmd"
Benchmark #1: ./git-cat-file --batch-all-objects --unordered --buffer --batch-check='%(objectname)'

  Time (mean ± σ):     151.9 ms ±   4.9 ms    [User: 130.5 ms, System: 21.2 ms]

  Range (min … max):   148.2 ms … 170.4 ms

Initial-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 fetch-pack.c |  2 +-
 oidset.c     | 36 ++++++++++++++----------------------
 oidset.h     | 36 ++++++++++++++++++++++++++++--------
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 75047a4b2a..a839315726 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -536,7 +536,7 @@ static int tip_oids_contain(struct oidset *tip_oids,
 	 * add to "newlist" between calls, the additions will always be for
 	 * oids that are already in the set.
 	 */
-	if (!tip_oids->map.map.tablesize) {
+	if (!tip_oids->set.n_buckets) {
 		add_refs_to_oidset(tip_oids, unmatched);
 		add_refs_to_oidset(tip_oids, newlist);
 	}
diff --git a/oidset.c b/oidset.c
index 454c54f933..d15b2b7a89 100644
--- a/oidset.c
+++ b/oidset.c
@@ -3,38 +3,30 @@
 
 int oidset_contains(const struct oidset *set, const struct object_id *oid)
 {
-	if (!set->map.map.tablesize)
-		return 0;
-	return !!oidmap_get(&set->map, oid);
+	khiter_t pos = kh_get_oid(&set->set, *oid);
+	return pos != kh_end(&set->set);
 }
 
 int oidset_insert(struct oidset *set, const struct object_id *oid)
 {
-	struct oidmap_entry *entry;
-
-	if (!set->map.map.tablesize)
-		oidmap_init(&set->map, 0);
-	else if (oidset_contains(set, oid))
-		return 1;
-
-	entry = xmalloc(sizeof(*entry));
-	oidcpy(&entry->oid, oid);
-
-	oidmap_put(&set->map, entry);
-	return 0;
+	int added;
+	kh_put_oid(&set->set, *oid, &added);
+	return !added;
 }
 
 int oidset_remove(struct oidset *set, const struct object_id *oid)
 {
-	struct oidmap_entry *entry;
-
-	entry = oidmap_remove(&set->map, oid);
-	free(entry);
-
-	return (entry != NULL);
+	khiter_t pos = kh_get_oid(&set->set, *oid);
+	if (pos == kh_end(&set->set))
+		return 0;
+	kh_del_oid(&set->set, pos);
+	return 1;
 }
 
 void oidset_clear(struct oidset *set)
 {
-	oidmap_free(&set->map, 1);
+	kh_oid_t *to_free = kh_init_oid();
+	*to_free = set->set;
+	kh_destroy_oid(to_free);
+	oidset_init(set, 0);
 }
diff --git a/oidset.h b/oidset.h
index 40ec5f87fe..4b90540cd4 100644
--- a/oidset.h
+++ b/oidset.h
@@ -1,7 +1,8 @@
 #ifndef OIDSET_H
 #define OIDSET_H
 
-#include "oidmap.h"
+#include "hashmap.h"
+#include "khash.h"
 
 /**
  * This API is similar to sha1-array, in that it maintains a set of object ids
@@ -15,19 +16,33 @@
  *      table overhead.
  */
 
+static inline unsigned int oid_hash(struct object_id oid)
+{
+	return sha1hash(oid.hash);
+}
+
+static inline int oid_equal(struct object_id a, struct object_id b)
+{
+	return oideq(&a, &b);
+}
+
+KHASH_INIT(oid, struct object_id, int, 0, oid_hash, oid_equal)
+
 /**
  * A single oidset; should be zero-initialized (or use OIDSET_INIT).
  */
 struct oidset {
-	struct oidmap map;
+	kh_oid_t set;
 };
 
-#define OIDSET_INIT { OIDMAP_INIT }
+#define OIDSET_INIT { { 0 } }
 
 
 static inline void oidset_init(struct oidset *set, size_t initial_size)
 {
-	oidmap_init(&set->map, initial_size);
+	memset(&set->set, 0, sizeof(set->set));
+	if (initial_size)
+		kh_resize_oid(&set->set, initial_size);
 }
 
 /**
@@ -58,19 +73,24 @@ int oidset_remove(struct oidset *set, const struct object_id *oid);
 void oidset_clear(struct oidset *set);
 
 struct oidset_iter {
-	struct oidmap_iter m_iter;
+	kh_oid_t *set;
+	khiter_t iter;
 };
 
 static inline void oidset_iter_init(struct oidset *set,
 				    struct oidset_iter *iter)
 {
-	oidmap_iter_init(&set->map, &iter->m_iter);
+	iter->set = &set->set;
+	iter->iter = kh_begin(iter->set);
 }
 
 static inline struct object_id *oidset_iter_next(struct oidset_iter *iter)
 {
-	struct oidmap_entry *e = oidmap_iter_next(&iter->m_iter);
-	return e ? &e->oid : NULL;
+	for (; iter->iter != kh_end(iter->set); iter->iter++) {
+		if (kh_exist(iter->set, iter->iter))
+			return &kh_key(iter->set, iter->iter++);
+	}
+	return NULL;
 }
 
 static inline struct object_id *oidset_iter_first(struct oidset *set,
-- 
2.19.0
