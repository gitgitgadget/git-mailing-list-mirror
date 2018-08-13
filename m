Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8151F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbeHMT6k (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:58:40 -0400
Received: from mout.web.de ([212.227.15.3]:51957 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbeHMT6k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:58:40 -0400
Received: from [192.168.178.36] ([91.20.56.63]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lx77p-1fvSc61vPF-016fAb; Mon, 13
 Aug 2018 19:15:23 +0200
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
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
Message-ID: <6065f3e5-f831-802f-9adc-099de99405fc@web.de>
Date:   Mon, 13 Aug 2018 19:15:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f69e08d7-b29d-a9b7-b6d4-5294c4379133@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VAOZ9K6E7oKOpoYSP9wn1jgHbwA5lsG08C8ZillN6E0dq+OnOff
 lm0qFAfpNe6AhWow2vxx+fiVXraDXFyerwhFbkGlmKwC8jwzl6IpRKkP7u+zrmxUjyVh1tD
 KRNj7wnLFtOtbwefc3BBstraL50R2jNcav/ulWblDm1rdv+RvBEUAw2UL2wJ5rqTc29xAzP
 PQN+0a3ICDIUe7bMF3Xew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+6GtOfkhIy0=:Wx6YN+P54lPNcyrXC0SB2s
 GwalZGx6a30hPrGcILFbTFrsDo7LfaNYSi6f6KsLY0sbnyyzbmJWq+ZzAXJZg4PdHjMRpSiDL
 hk4SSlW/iqOcJJM9SX091cE0EaooHFem6a+fh4VAX3EYGf6PQaQ1dDU+HwVu1rsAcw9krrYJC
 6MXrovssjHucyyo6U9xGfmo1s2fMH1+9QfDwgbNWnnqMllJfact7aWOW0NFsayd0NvyPRDwlV
 25ITJE0KyPCmINNYXDev2bqJ30WhFxWqCoNFSpr1pEGYI/i4atXK9ct8kpH6X4qUCDhPr98af
 gDCFbIEnYcWwb2RiiiHfnXbSq5xAr7//pWJLJ0cLLL74W4ccfkrjXBPy0mPJaB0qqVUrqj+mv
 i71J8EuK5CslS9yINUex44hYcaT0fdkX9ATHY/Oo+5UrnTAl93QcjEpUm73JXwTMgLAZDjuZs
 XRLp9fGHGQ3rl3bmydte3QyGrMuzzcBKhn61euKu+BtImAg7B8Gw4CdcwqW6CWdqCilPWqsfd
 JVR8ragdb1T8u+RhUM14EwxZUS9gK4AlsKQjiOH1yLUvPDRrI/cTyYOZ2Teyj949kMpqrJ6IR
 L/m59hoOotV1tCFSoT4iDhLpICDmcEJsht0BgTT70/Bd1unlavqWHw55AD+EXXsa74y+pMDGD
 rlExo+IALzXp2VLbBQoH00g/jmDELrfeLFgsVggAdJd/8TBoK4v1RLOqIXeNygQdC14hcxkvk
 Jfj3GuBCODFYWQVQAtUaIoXZhZ/8vPRZulpYdHzswe+Ii7a/GdWA1qEjQDu0i9E8hRXGJE7ty
 vDue7JU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.2018 um 22:59 schrieb René Scharfe:
> If the current oidset implementation is so bad, why not replace it with
> one based on oid_array? ;-)
> 
> Intuitively I'd try a hashmap with no payload and open addressing via
> sha1hash(), which should reduce memory allocations quite a bit -- no
> need to store hash codes and next pointers, only an array of object IDs
> with a fill rate of 50% or so.  Deletions are a bit awkward with that
> scheme, though; they could perhaps be implemented as insertions into a
> second hashmap.

Here's roughly what I had in mind, only with a free/occupied bitmap (or
a one-bit payload, if you will).  I tried a variant that encoded empty
slots as null_oid first, which has lower memory usage, but isn't any
faster than the current code.

# in git.git
$ hyperfine "./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'"

Before:
Benchmark #1: ./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'

   Time (mean ± σ):     269.5 ms ±  26.7 ms    [User: 247.7 ms, System: 21.4 ms]

   Range (min … max):   240.3 ms … 339.3 ms

After:
Benchmark #1: ./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'

   Time (mean ± σ):     224.2 ms ±  18.2 ms    [User: 201.7 ms, System: 22.1 ms]

   Range (min … max):   205.0 ms … 259.0 ms

So that's only slightly faster. :-|

---
  builtin/cat-file.c | 93 +++++++++++++++++++++++++++++++++++++++++++---
  1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 45992c9be9..b197cca861 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -408,10 +408,93 @@ static void batch_one_object(const char *obj_name, struct batch_options *opt,
  	batch_object_write(obj_name, opt, data);
  }
  
+struct oidset2 {
+	size_t nr, alloc;
+	struct object_id *entries;
+	uint32_t *bitmap;
+};
+
+static int is_bit_set(const uint32_t *bitmap, size_t idx)
+{
+	uint32_t mask = 1 << (idx % bitsizeof(bitmap[0]));
+	return bitmap[idx / bitsizeof(bitmap[0])] & mask;
+}
+
+static void set_bit(uint32_t *bitmap, size_t idx)
+{
+	uint32_t mask = 1 << (idx % bitsizeof(bitmap[0]));
+	bitmap[idx / bitsizeof(bitmap[0])] |= mask;
+}
+
+static void oidset2_add(struct oidset2 *set, const struct object_id *oid)
+{
+	size_t idx;
+
+	for (idx = sha1hash(oid->hash) % set->alloc;;) {
+		if (!is_bit_set(set->bitmap, idx))
+			break;
+		if (!oidcmp(&set->entries[idx], oid))
+			return;
+		if (++idx >= set->alloc)
+			idx = 0;
+	}
+	oidcpy(&set->entries[idx], oid);
+	set_bit(set->bitmap, idx);
+	set->nr++;
+}
+
+static void oidset2_grow(struct oidset2 *set)
+{
+	struct oidset2 old_set = *set;
+	size_t idx;
+
+	set->alloc = (old_set.alloc + 1000) * 3 / 2;
+	set->nr = 0;
+	set->entries = xcalloc(set->alloc, sizeof(set->entries[0]));
+	set->bitmap = xcalloc(set->alloc / 32 + 1, sizeof(set->bitmap[0]));
+	for (idx = 0; idx < old_set.alloc; idx++) {
+		if (!is_bit_set(old_set.bitmap, idx))
+			continue;
+		oidset2_add(set, &old_set.entries[idx]);
+	}
+	free(old_set.entries);
+	free(old_set.bitmap);
+}
+
+static void oidset2_insert(struct oidset2 *set, const struct object_id *oid)
+{
+	if (set->nr + 1 > set->alloc * 2 / 3)
+		oidset2_grow(set);
+	oidset2_add(set, oid);
+}
+
+static int oidset2_contains(struct oidset2 *set, const struct object_id *oid)
+{
+	size_t idx;
+
+	if (!set->nr)
+		return 0;
+	for (idx = sha1hash(oid->hash) % set->alloc;;) {
+		if (!is_bit_set(set->bitmap, idx))
+			return 0;
+		if (!oidcmp(&set->entries[idx], oid))
+			return 1;
+		if (++idx >= set->alloc)
+			idx = 0;
+	}
+}
+
+static void oidset2_clear(struct oidset2 *set)
+{
+	FREE_AND_NULL(set->entries);
+	FREE_AND_NULL(set->bitmap);
+	set->alloc = set->nr = 0;
+}
+
  struct object_cb_data {
  	struct batch_options *opt;
  	struct expand_data *expand;
-	struct oidset *seen;
+	struct oidset2 *seen;
  };
  
  static int batch_object_cb(const struct object_id *oid, void *vdata)
@@ -443,9 +526,9 @@ static int batch_unordered_object(const struct object_id *oid, void *vdata)
  {
  	struct object_cb_data *data = vdata;
  
-	if (oidset_contains(data->seen, oid))
+	if (oidset2_contains(data->seen, oid))
  		return 0;
-	oidset_insert(data->seen, oid);
+	oidset2_insert(data->seen, oid);
  
  	return batch_object_cb(oid, data);
  }
@@ -510,7 +593,7 @@ static int batch_objects(struct batch_options *opt)
  		cb.expand = &data;
  
  		if (opt->unordered) {
-			struct oidset seen = OIDSET_INIT;
+			struct oidset2 seen = { 0 };
  
  			cb.seen = &seen;
  
@@ -518,7 +601,7 @@ static int batch_objects(struct batch_options *opt)
  			for_each_packed_object(batch_unordered_packed, &cb,
  					       FOR_EACH_OBJECT_PACK_ORDER);
  
-			oidset_clear(&seen);
+			oidset2_clear(&seen);
  		} else {
  			struct oid_array sa = OID_ARRAY_INIT;
  
-- 
2.18.0
