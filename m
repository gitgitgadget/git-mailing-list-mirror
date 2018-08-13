Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3A2F1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbeHMT6k (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:58:40 -0400
Received: from mout.web.de ([212.227.15.4]:42069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbeHMT6k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:58:40 -0400
Received: from [192.168.178.36] ([91.20.56.63]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdEmn-1gFDS43wJt-00iWjQ; Mon, 13
 Aug 2018 19:15:22 +0200
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8c5b2783-a08b-4ea4-3d69-8ae80582b5e3@web.de>
Date:   Mon, 13 Aug 2018 19:15:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180811172350.GA2689@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wK2L6K4muDiAdq3WH3l8aGm5atwyp6FGGW0m3C/UyjqW8O5rGCV
 FQ0ixtU7auXQ1Yk6bvEqsKbzne8PF9giMEOf6TZItYD/7iZFNLLI5+5boxOOy/QjEPN13Tl
 KelfRiECmdH4NMB8lpp8SY4Zuai5vOf/aT2STNii4as5w1TZoE7L4vk03qi65t5Gab4UiwU
 88RaW9UMnNSvpqmHm2yZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wlhHrA/Jd5o=:cxngqsH8II6nKIfzt5T9wq
 OekWFsw9h1IUFs6qizuODd1WqnPOVZnCBesUEocIpuygEBe5tCeCOh37vv/P3xU9ShHdWa0JZ
 H9ZTDKSfUL89sMGjSkB066kIYco3eGWkZvBl3RTYP0MnJdr0MG4uGeMZfv6ilScstgW7VHwtE
 wyFT8UcUO6/m/xWcx+R/HOMv/s0BH4d6B/oc9C7BiwsFn84IeyW8H9/7koV9dLYnN5LL5RIKc
 aJTGCvXdA7Nv++q0snx9xEzuQT4Q5InTT3In5+WLwD/05Lica+C6XTjg0rSFFgnbkFrpdSTOj
 FvR7gMxy/IAFZYL9WiwiBntD+0/MxvC3Mx92K8tVZutlYpyN0qGPVnPPnmrOkxoWPgfYRPYSo
 oXxON1UUomgvwIU/+wpYMVHTHKCkV47KwxA50Ooo3L5lN9aXOWkhLeaF3QgZjgGOGJqbqdBBh
 +PjZ04dVBiCIecA4B32UAlTK5BUvUvsUwXBoK2rd6GDq70oK/F7S3BMXXPs/aprS5Kao5YCP9
 HBwFNN2R6h17tt97J6QAO6cqrgqnnwzLfD5Ht7ejYFJubB0VNWskMuzyQOYPNeEGNhiKuXfsN
 iU24ZbYaqCgfS0gyg1FdUWjFHyirM/FD9oKcz57DOoBQenT65Gj49zIA42AviOJNvIMZ8MOby
 Uc0fD/0UK2O4oJcVkiNGVbWzLip6swYQHPI/eLFhTpneikDRQIHrs+7FKYdzuvfemOhDKE7WJ
 ULJdj0n4XfNeUdsuJYBjcrGQGpqfjmdHG9dl5ucCMFAXYX9OYAb2Dakz92DakIGtIxt6xnh9r
 EtTEhiD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.2018 um 19:23 schrieb Jeff King:
> On Sat, Aug 11, 2018 at 01:02:48PM -0400, Jeff King wrote:
> 
>>    - we could probably improve the speed of oidset. Two things I notice
>>      about its implementation:
>>
>>        - it has to malloc for each entry, which I suspect is the main
>> 	bottleneck. We could probably pool-allocate blocks, and when
>> 	entries get removed just leave the allocations in place until we
>> 	clear(). Most callers tend to build up a set and then query it a
>> 	lot, or possibly remove items from the set until it's empty. But
>> 	my guess is that few or none want a long-lived set that they add
>> 	and remove from randomly.
>>
>>        - insertion lets you do check-and-insert as a single operation
>> 	(something I failed to notice in [1]). But it's not implemented
>> 	as efficiently as it could be, since the "contains" and "put"
>> 	operations do separate lookups. This doesn't matter for a set
>> 	that's queried a lot more, but for something like de-duping
>> 	(like I was doing in [1]) most operations are check-and-insert.
>> [...]
>> [1] https://public-inbox.org/git/20180810232457.GG19875@sigill.intra.peff.net/
>>      but note that it's buried pretty deep.
> 
> Some notes on this, based on the cat-file patch that I linked to.
> 
> Before any optimizations, my best-of-five timing for:
> 
>    git cat-file --batch-all-objects --unordered --buffer \
>                 --batch-check='%(objectname)' >/dev/null
> 
> in git.git was:
> 
>    real	0m0.434s
>    user	0m0.414s
>    sys	0m0.020s
> 
> That's enumerating every object in the repo but not doing much more than
> de-duping the names and printing them.
> 
> Applying this patch:
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 45992c9be9..04b5cda191 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -443,9 +443,8 @@ static int batch_unordered_object(const struct object_id *oid, void *vdata)
>   {
>   	struct object_cb_data *data = vdata;
>   
> -	if (oidset_contains(data->seen, oid))
> +	if (oidset_insert(data->seen, oid))
>   		return 0;
> -	oidset_insert(data->seen, oid);
>   
>   	return batch_object_cb(oid, data);
>   }
> 
> to use the single-call set-and-replace doesn't seem to help (any
> improvement is within the run-to-run noise). So a single hash lookup per
> object does not seem to be measurable. And thus teaching oidset_insert()
> to do a single hash lookup for check-and-insert is unlikely to help us.
> 
> On top of that, I tried using a pool to store the set entries:
> 
> diff --git a/oidset.c b/oidset.c
> index 454c54f933..504929f177 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -17,7 +17,10 @@ int oidset_insert(struct oidset *set, const struct object_id *oid)
>   	else if (oidset_contains(set, oid))
>   		return 1;
>   
> -	entry = xmalloc(sizeof(*entry));
> +	if (!set->pool)
> +		mem_pool_init(&set->pool, 0);
> +
> +	entry = mem_pool_alloc(set->pool, sizeof(*entry));
>   	oidcpy(&entry->oid, oid);
>   
>   	oidmap_put(&set->map, entry);
> @@ -29,12 +32,13 @@ int oidset_remove(struct oidset *set, const struct object_id *oid)
>   	struct oidmap_entry *entry;
>   
>   	entry = oidmap_remove(&set->map, oid);
> -	free(entry);
> +	/* abandon pool memory for "entry" */
>   
>   	return (entry != NULL);
>   }
>   
>   void oidset_clear(struct oidset *set)
>   {
> -	oidmap_free(&set->map, 1);
> +	oidmap_free(&set->map, 0);
> +	mem_pool_discard(set->pool, 0);
>   }
> diff --git a/oidset.h b/oidset.h
> index 40ec5f87fe..6b8b802987 100644
> --- a/oidset.h
> +++ b/oidset.h
> @@ -20,6 +20,7 @@
>    */
>   struct oidset {
>   	struct oidmap map;
> +	struct mem_pool *pool;
>   };
>   
>   #define OIDSET_INIT { OIDMAP_INIT }
> 
> That drops my best-of-five to:
> 
>    real	0m0.300s
>    user	0m0.288s
>    sys	0m0.012s
> 
> which is over a 25% speedup. So that does seem worth pursuing.
> 
> For reference, the oid_array code path for cat-file is still:
> 
>    real	0m0.161s
>    user	0m0.157s
>    sys	0m0.004s
> 
> but that's not completely apples to apples. The oidset code is also
> iterating the packfiles in a different order and generating a revidx
> (which I know is about 25ms in this repo). So a better test would
> actually swap one data structure out for the other with no other changes
> (I just happened to have this test handy, and really wanted to know
> whether the mem_pool stuff would help).

Getting sidetracked here, but the following patch helps both sides a bit:

-- >8 --
Subject: [PATCH] cat-file: reuse strbuf in batch_object_write()

Avoid allocating and then releasing memory for constructing the output
for each object by reusing the strbuf for all of them.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
# on git.git
$ hyperfine "./git-cat-file --batch-all-objects --buffer --batch-check='%(objectname)'"

Before:
Benchmark #1: ./git-cat-file --batch-all-objects --buffer --batch-check='%(objectname)'

   Time (mean ± σ):     139.3 ms ±  20.1 ms    [User: 124.2 ms, System: 14.8 ms]

   Range (min … max):   124.4 ms … 205.9 ms

After:
Benchmark #1: ./git-cat-file --batch-all-objects --buffer --batch-check='%(objectname)'

   Time (mean ± σ):     115.1 ms ±  20.6 ms    [User: 102.0 ms, System: 12.8 ms]

   Range (min … max):    99.6 ms … 198.1 ms

Test done one a small VM -- the measurements are quite noisy.

  builtin/cat-file.c | 17 +++++++++++------
  1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4a44b2404f..a979fc1f3a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -211,6 +211,12 @@ struct expand_data {
  	 * optimized out.
  	 */
  	unsigned skip_object_info : 1;
+
+	/*
+	 * Scratch space for expanded string; shared between invocations
+	 * to reduce the number of memory allocations.
+	 */
+	struct strbuf *scratch;
  };
  
  static int is_atom(const char *atom, const char *s, int slen)
@@ -340,8 +346,6 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
  static void batch_object_write(const char *obj_name, struct batch_options *opt,
  			       struct expand_data *data)
  {
-	struct strbuf buf = STRBUF_INIT;
-
  	if (!data->skip_object_info &&
  	    oid_object_info_extended(the_repository, &data->oid, &data->info,
  				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
@@ -351,10 +355,10 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
  		return;
  	}
  
-	strbuf_expand(&buf, opt->format, expand_format, data);
-	strbuf_addch(&buf, '\n');
-	batch_write(opt, buf.buf, buf.len);
-	strbuf_release(&buf);
+	strbuf_reset(data->scratch);
+	strbuf_expand(data->scratch, opt->format, expand_format, data);
+	strbuf_addch(data->scratch, '\n');
+	batch_write(opt, data->scratch->buf, data->scratch->len);
  
  	if (opt->print_contents) {
  		print_object_or_die(opt, data);
@@ -453,6 +457,7 @@ static int batch_objects(struct batch_options *opt)
  	 * object.
  	 */
  	memset(&data, 0, sizeof(data));
+	data.scratch = &buf;
  	data.mark_query = 1;
  	strbuf_expand(&buf, opt->format, expand_format, &data);
  	data.mark_query = 0;
-- 
2.18.0
