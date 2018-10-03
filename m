Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A6B51F453
	for <e@80x24.org>; Wed,  3 Oct 2018 13:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeJCUFK (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 16:05:10 -0400
Received: from mout.web.de ([212.227.15.4]:50289 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJCUFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 16:05:10 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2MZY-1fonDq0vem-00s35j; Wed, 03
 Oct 2018 15:16:42 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2MZY-1fonDq0vem-00s35j; Wed, 03
 Oct 2018 15:16:42 +0200
Subject: [PATCH v2 2/2] oidset: use khash
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5efe6695-2e82-786c-1170-7874978cb534@web.de>
Date:   Wed, 3 Oct 2018 15:16:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SV8Z+r+7R/TPj8O1Hakv8BurIJxbfDwnH6S0FjH1TUJYkl+mF40
 jjRZeMkOpi9qP3FgAO6z4ASadQQYVz7ifyIA/Z1+mBbt4W1ELCfxDOeOktRAxv1WyC2//UJ
 mi+J1i2KdZS5xuYLXLsXwALSvTgsKs1sJ5p7rgelKL/vJP4kAAsqFMZX7/L66Y4DJkbWTT+
 EXHfcg8cqL+oegR8+cBLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b+LhKZvYbTU=:uDbgVKZ/u7XoEjevwjIodz
 tuuzm5UzRplpUE475ghomOtYLd4u4z+xRN5LfD2B124TIo8BIgBiMHq1qL46FLKi9I9h3cwTe
 Do9Cdo3I9oXOz2S9T/7Zjxih+dYzUgHQYsLCA4KHYz0U1RELWZp9Ilx+/3zFpecOKhdfCIGrt
 gdIlR5+Bc1kXkkQQU1IW/dO0tRTeGPxMaFkzLhTv3Yogp7/5DDatv8WPtQHRuWo8Xkl6myYPP
 O9yD2gIJjFJdfavrxP4bW1N06WCBjsN1pu6UNUc82kH7GZ9Eb8AsCoHkNqvwNUnuTRsV7v1Eg
 z08hHmVEqcFCdN56OBjblfWJMDRIDXcjfziOWpt2+a7YVb9RZPBTZ0+ZHrkWuE5y//4peMyzY
 e/8zu+K929NRjXwGa/ZMnt4ek94DixRSaN4z1/Lq3VTIlT2/4+5TaZAa6biyXQDGIbsgHFXi1
 FQhNPWNYZ5tqKN8vBAo+mnqyrFjBB6PPzcVuMg3C5FU6gOaAghWl1878VTBjOPZV3wI40RzCU
 DVZmFjHoqo7CjhHgTYTX0O+c/kUpDNtex9S6QUk0AZ/fakxtQBaCGvwKgudXv5XD7Z05mMLbt
 HnFnepWXdO7ZBVwA0STvRTMuhAAIW0FVVgC1siufMJE72Pdh8qC6YJMVUV61FDGpNeZPLhAzG
 0/iRdreHbA8iLhiwoCXhqvcHQAJAe1sL5FcO7qhlCYjZ8Ug0zwmp1f8/seLriFU5S0j+q5kYh
 wt2vDvVn2Xy95JU7KkgzpMSz6At6UEYKukRcJqpPge6AtkVnlO+LYXooWWNu7Wtu5pfdHrCkw
 lXpXkIMi1hQ0THpl6uNqH4hxpxG3qnHWzySukDzfZWtzVVqf5Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement oidset using khash.h in order to reduce its memory footprint
and make it faster.

Performance of a command that mainly checks for duplicate objects using
an oidset, with master and Clang 6.0.1:

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
 oidset.c     | 34 ++++++++++++----------------------
 oidset.h     | 36 ++++++++++++++++++++++++++++--------
 3 files changed, 41 insertions(+), 31 deletions(-)

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
index 454c54f933..9836d427ef 100644
--- a/oidset.c
+++ b/oidset.c
@@ -3,38 +3,28 @@
 
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
+	kh_release_oid(&set->set);
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

