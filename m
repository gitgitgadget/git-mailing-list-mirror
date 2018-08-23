Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4EA21F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeHXAFM (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:05:12 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40008 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeHXAFM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:05:12 -0400
Received: by mail-qk0-f193.google.com with SMTP id c126-v6so4514323qkd.7
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=elVfqDr6OhuLiJcNqshhbCYQWzWExrjQGCJhLGHk2ZQ=;
        b=WeDamWfcNUl08V0o0MPh7csEL4MUsq6+Zq9ZRqiMGN4Tb9UQcL1SYlkmlxDCeRXLqS
         mcZUOTDlPJmmOBAgoa5khZkUcL+fdKr93h1b51IaUTBT248MXcud/XuuFfjUU7fey7+L
         4+3f2O+jqFvU1LuacByZA8lyP6fv5SzoAGaDgUr1/yzqj5TJTWKmV6zZfPPDy5iGLV1p
         mou5IlGegh31OLDDk/mahZeyl64xUNynOYlHx2xVvhI55nAOBiRvW9Nhv7AR3io1KwAo
         eTpXuS4y9yI1TH+WQfzNlpYVs9pZYe2T6wYWwJrkxlv30q4sH2X9IzEKKAx2Etrgxa5v
         27Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=elVfqDr6OhuLiJcNqshhbCYQWzWExrjQGCJhLGHk2ZQ=;
        b=OO+q6js+OmGXWdvNg07z3UVBVW2t8Ut2CP+iR+ubME9BW5d1yv8ErzU+D0pPvg5EWR
         otc42t5nVNZ2477TAnh3Ki85T96w4kUWJ80WgEkvWoZX11WkZkQ+59ldTIHfnuEI4EV7
         eBo1SHoYRt3+NXWnD3pmNSHvuVqmKyt6RjaTiGuVNy6kjFmPNNqJLjLl5Qk4Iv17Oskv
         fKpJqWVOwsHI84NChUsqH4sLBcKWGMP93NPvdDcpHgrkaPIP7vv88R8EAd84JOpqqCGk
         DK7x7V9r/cbul+E9H+QtOfo1cEQkmGIUXy11qkn5wVrDPNwUJqUdWuFBGYKg+7rUBRNX
         KDXA==
X-Gm-Message-State: AOUpUlGbwIWBulgBueym7UFoegLcaKtf0b1SQF0BB1u66shvSBqOBWLb
        h3zV/GX++uCSKK6JAseUoF40PYbx
X-Google-Smtp-Source: AA+uWPxlgCKFX1l9ol2sMO7wIPomZIucWXlpEA8TIXQgAA3T2WDdSalFNSbHmAOLMihuXiYmun1JEA==
X-Received: by 2002:a37:28a2:: with SMTP id o34-v6mr32400274qko.333.1535056430181;
        Thu, 23 Aug 2018 13:33:50 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f2-v6sm2871560qkm.51.2018.08.23.13.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:33:49 -0700 (PDT)
Subject: Re: [PATCH v1] read-cache: speed up index load through
 parallelization
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <xmqqin41hs8x.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <4c70ea50-5b43-8696-3c46-cf3d658a0ef8@gmail.com>
Date:   Thu, 23 Aug 2018 16:33:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqin41hs8x.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/23/2018 2:06 PM, Junio C Hamano wrote:
> Ben Peart <Ben.Peart@microsoft.com> writes:
> 
>> This patch helps address the CPU cost of loading the index by creating
>> multiple threads to divide the work of loading and converting the cache
>> entries across all available CPU cores.
> 
> Nice.
> 
>> +int git_config_get_fast_index(void)
>> +{
>> +	int val;
>> +
>> +	if (!git_config_get_maybe_bool("core.fastindex", &val))
>> +		return val;
>> +
>> +	if (getenv("GIT_FASTINDEX_TEST"))
>> +		return 1;
> 
> It probably makes sense to use git_env_bool() to be consistent,
> which allows GIT_FASTINDEX_TEST=0 to turn it off after this becomes
> the default.
> 
>> diff --git a/read-cache.c b/read-cache.c
>> index 7b1354d759..0fa7e1a04c 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -24,6 +24,10 @@
>>   #include "utf8.h"
>>   #include "fsmonitor.h"
>>   
>> +#ifndef min
>> +#define min(a,b) (((a) < (b)) ? (a) : (b))
>> +#endif
> 
> Let's lose this, which is used only once, even though it could be
> used elsewhere but not used (e.g. threads vs cpus near the beginning
> of load_cache_entries()).
> 

I didn't have it, then added it to make it trivial to see what was 
actually happening.  I can switch back.

>> +static unsigned long load_cache_entry_block(struct index_state *istate, struct mem_pool *ce_mem_pool, int offset, int nr, void *mmap, unsigned long start_offset, struct strbuf *previous_name)
> 
> Wrap and possibly add comment before the function to describe what
> it does and what its parameters mean?
> 
>> +{
>> +	int i;
>> +	unsigned long src_offset = start_offset;
>> +
>> +	for (i = offset; i < offset + nr; i++) {
>> +		struct ondisk_cache_entry *disk_ce;
>> +		struct cache_entry *ce;
>> +		unsigned long consumed;
>> +
>> +		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
>> +		ce = create_from_disk(ce_mem_pool, disk_ce, &consumed, previous_name);
>> +		set_index_entry(istate, i, ce);
>> +
>> +		src_offset += consumed;
>> +	}
>> +	return src_offset - start_offset;
>> +}
> 
> OK.
> 
>> +static unsigned long load_all_cache_entries(struct index_state *istate, void *mmap, size_t mmap_size, unsigned long src_offset)
>> +{
> 
> (following aloud) This "all" variant is "one thread does all", iow,
> unthreaded version.  Makes sense.
> 
>> +	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>> +	unsigned long consumed;
>> +
>> +	if (istate->version == 4) {
>> +		previous_name = &previous_name_buf;
>> +		mem_pool_init(&istate->ce_mem_pool,
>> +			      estimate_cache_size_from_compressed(istate->cache_nr));
>> +	} else {
>> +		previous_name = NULL;
>> +		mem_pool_init(&istate->ce_mem_pool,
>> +			      estimate_cache_size(mmap_size, istate->cache_nr));
>> +	}
> 
> I count there are three instances of "if version 4 use the strbuf
> for name-buf, otherwise..." in this patch, which made me wonder if
> we can make them shared more and/or if it makes sense to attempt to
> do so.
> 

Actually, they are all different and all required.  One sets it up for 
the "do it all on one thread" path.  One sets it up for each thread. The 
last one is used by the primary thread when scanning for blocks to hand 
off to the child threads.

>> +	consumed = load_cache_entry_block(istate, istate->ce_mem_pool, 0, istate->cache_nr, mmap, src_offset, previous_name);
>> +	strbuf_release(&previous_name_buf);
>> +	return consumed;
>> +}
>> +
>> +#ifdef NO_PTHREADS
>> +
>> +#define load_cache_entries load_all_cache_entries
>> +
>> +#else
>> +
>> +#include "thread-utils.h"
>> +
>> +/*
>> +* Mostly randomly chosen maximum thread counts: we
>> +* cap the parallelism to online_cpus() threads, and we want
>> +* to have at least 7500 cache entries per thread for it to
>> +* be worth starting a thread.
>> +*/
>> +#define THREAD_COST		(7500)
>> +
>> +struct load_cache_entries_thread_data
>> +{
>> +	pthread_t pthread;
>> +	struct index_state *istate;
>> +	struct mem_pool *ce_mem_pool;
>> +	int offset, nr;
>> +	void *mmap;
>> +	unsigned long start_offset;
>> +	struct strbuf previous_name_buf;
>> +	struct strbuf *previous_name;
>> +	unsigned long consumed;	/* return # of bytes in index file processed */
>> +};
>> +
>> +/*
>> +* A thread proc to run the load_cache_entries() computation
>> +* across multiple background threads.
>> +*/
>> +static void *load_cache_entries_thread(void *_data)
>> +{
>> +	struct load_cache_entries_thread_data *p = _data;
>> +
>> +	p->consumed += load_cache_entry_block(p->istate, p->ce_mem_pool, p->offset, p->nr, p->mmap, p->start_offset, p->previous_name);
>> +	return NULL;
>> +}
> 
> (following aloud) And the threaded version chews the block of ce's
> given to each thread.  Makes sense.
> 
>> +static unsigned long load_cache_entries(struct index_state *istate, void *mmap, size_t mmap_size, unsigned long src_offset)
>> +{
>> +	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>> +	struct load_cache_entries_thread_data *data;
>> +	int threads, cpus, thread_nr;
>> +	unsigned long consumed;
>> +	int i, thread;
>> +
>> +	cpus = online_cpus();
>> +	threads = istate->cache_nr / THREAD_COST;
>> +	if (threads > cpus)
>> +		threads = cpus;
> 
> No other caller of online_cpus() is prepared to deal with faulty
> return from the function (e.g. 0 or negative), so it is perfectly
> fine for this caller to trust it would return at least 1.  OK.
> 
> Not using min() and it still is very readable ;-).
> 
>> +	/* enable testing with fewer than default minimum of entries */
>> +	if ((istate->cache_nr > 1) && (threads < 2) && getenv("GIT_FASTINDEX_TEST"))
>> +		threads = 2;
> 
> Another good place to use git_env_bool().
> 
>> +	if (threads < 2 || !git_config_get_fast_index())
>> +		return load_all_cache_entries(istate, mmap, mmap_size, src_offset);
> 
> config_get_fast_index() can return -1 to signal "no strong
> preference either way".  A caller that negates the value without
> paying special attention to negative return makes the reader wonder
> if the code is buggy or actively interpreting "do not care" as "I do
> not mind if you use it" (it is the latter in this case).
> 
> I actually think git_config_get_fast_index() is a helper that does a
> bit too little.  Perhaps the above two if() statements can be
> combined into a single call to
> 
> 	threads = use_fast_index(istate);
> 	if (threads < 2)
> 		return load_all_cache_entries(...);
> 
> and let it call online_cpus(), determination of thread-count taking
> THREADS_COST into account, and also reading the configuration
> variable?  The configuration variable might even want to say how
> many threads it wants to cap us at maximum in the future.
> 

I reworked this a bit.

git_config_get_parallel_read_index() still just deals with the config 
value (I had to read it this way as in some code paths, the global 
config settings in environment.c haven't been read yet).

All the logic about whether to use threads and how many to use is 
centralized here along with the environment variable to override the 
default behavior.

>> +	mem_pool_init(&istate->ce_mem_pool, 0);
>> +	if (istate->version == 4)
>> +		previous_name = &previous_name_buf;
>> +	else
>> +		previous_name = NULL;
>> +
>> +	thread_nr = (istate->cache_nr + threads - 1) / threads;
> 
> (following aloud) threads is the number of threads that we are going
> to spawn.  thread_nr is not any number about threads---it is number
> of cache entries each thread will work on.  The latter is
> confusingly named.
> 
> ce_per_thread perhaps?
> 

Sure

> As the division is rounded up, among "threads" threads, we know we
> will cover all "cache_nr" cache entries.  The last thread may handle
> fewer than "thread_nr" entries, or even just a single entry in the
> worst case.
> 

It's divided by the number of threads so will only be up to 1 less than 
the other threads.  Given the minimum # of entries per thread is 7500, 
you'd never end up with just a single entry (unless using the 
GIT_PARALLELREADINDEX_TEST override).

> When cache_nr == 1 and FASTINDEX_TEST tells us to use threads == 2,
> then thread_nr = (1 + 2 - 1) / 2 = 1.
> 
> The first one in the loop is given (offset, nr) = (0, 1) in the loop
> The second one is given (offset, nr) = (1, 0) in the loop.  Two
> questions come to mind:
> 
>   - Is load_cache_entries_thread() prepared to be given offset that
>     is beyond the end of istate->cache[] and become a no-op?
> 
>   - Does the next loop even terminate without running beyond the end
>     of istate->cache[]?
> 
>> +	data = xcalloc(threads, sizeof(struct load_cache_entries_thread_data));
>> +
>> +	/* loop through index entries starting a thread for every thread_nr entries */
>> +	consumed = thread = 0;
>> +	for (i = 0; ; i++) {
> 
> Uncapped for() loop makes readers a bit nervous.
> An extra "i < istate->cache_nr" would not hurt, perhaps?
> 

We don't need or want to run through _all_ the entries, only to the 
first entry of the last block.  I'd prefer to leave that extra test out 
as it implies that we are going to loop through them all. I'll add a 
comment to make it more obvious what is happening.

>> +		struct ondisk_cache_entry *ondisk;
>> +		const char *name;
>> +		unsigned int flags;
>> +
>> +		/* we've reached the begining of a block of cache entries, kick off a thread to process them */
>> +		if (0 == i % thread_nr) {
>> +			struct load_cache_entries_thread_data *p = &data[thread];
>> +
>> +			p->istate = istate;
>> +			p->offset = i;
>> +			p->nr = min(thread_nr, istate->cache_nr - i);
> 
> (following aloud) p->nr is the number of entries this thread will
> work on.
> 
>> +			/* create a mem_pool for each thread */
>> +			if (istate->version == 4)
>> +				mem_pool_init(&p->ce_mem_pool,
>> +						  estimate_cache_size_from_compressed(p->nr));
>> +			else
>> +				mem_pool_init(&p->ce_mem_pool,
>> +						  estimate_cache_size(mmap_size, p->nr));
>> +
>> +			p->mmap = mmap;
>> +			p->start_offset = src_offset;
>> +			if (previous_name) {
>> +				strbuf_addbuf(&p->previous_name_buf, previous_name);
>> +				p->previous_name = &p->previous_name_buf;
>> +			}
>> +
>> +			if (pthread_create(&p->pthread, NULL, load_cache_entries_thread, p))
>> +				die("unable to create load_cache_entries_thread");
>> +			if (++thread == threads || p->nr != thread_nr)
>> +				break;
>> +		}
>> +
>> +		ondisk = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
>> +
>> +		/* On-disk flags are just 16 bits */
>> +		flags = get_be16(&ondisk->flags);
>> +
>> +		if (flags & CE_EXTENDED) {
>> +			struct ondisk_cache_entry_extended *ondisk2;
>> +			ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
>> +			name = ondisk2->name;
>> +		} else
>> +			name = ondisk->name;
>> +
>> +		if (!previous_name) {
>> +			size_t len;
>> +
>> +			/* v3 and earlier */
>> +			len = flags & CE_NAMEMASK;
>> +			if (len == CE_NAMEMASK)
>> +				len = strlen(name);
>> +			src_offset += (flags & CE_EXTENDED) ?
>> +				ondisk_cache_entry_extended_size(len) :
>> +				ondisk_cache_entry_size(len);
>> +		} else
>> +			src_offset += (name - ((char *)ondisk)) + expand_name_field(previous_name, name);
> 
> Nice to see this done without a new index extension that records
> offsets, so that we can load existing index files in parallel.
> 

Yes, I prefer this simpler model as well.  I wasn't sure it would 
produce a significant improvement given the primary thread still has to 
run through the variable length cache entries but was pleasantly surprised.

The recent mem_pool changes really helped as well as it removed all 
thread contention in the heap that was happening before.

>> +	}
>> +
>> +	for (i = 0; i < threads; i++) {
>> +		struct load_cache_entries_thread_data *p = data + i;
>> +		if (pthread_join(p->pthread, NULL))
>> +			die("unable to join load_cache_entries_thread");
>> +		mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
>> +		strbuf_release(&p->previous_name_buf);
>> +		consumed += p->consumed;
>> +	}
>> +
>> +	free(data);
>> +	strbuf_release(&previous_name_buf);
>> +
>> +	return consumed;
>> +}
>> +
>> +#endif
