Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC30E1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 19:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeICXig (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 19:38:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55523 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbeICXif (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 19:38:35 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so2168869itj.5
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 12:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wnMkWYOJORJQUfchqDR0XY4kPAt74fPro2Qy03ywqQ=;
        b=sBRLf2xIwtSj/ywN/ANP2Gi5Ldfs7OZhJ8QdFo8yDaR4R5qDq20gt0EZEDcVu1NAVy
         HBZT/+X5zm0HARdxX3y18o8fa4GFtSZyb6I50oUQEEsoeiKCnJJChj6lFAk/1xPLdl8i
         1XLQJYo8peoZHz+9LpB0VeNI50T888kPZF5gRjr5x+iAgt5Phn9lZLkMwEJ/2bb2Xtds
         FmfcR90CJq0kW8fMuhFm48wdC/An8a5SG6vW8tf7QXcOnzLlCMhpU7dW8xG/7Mki+ggy
         AK6JIheCTPFSHzLSc/a3kBsKKWDlUZpMY1QPwukYRLpXmbT+x6jMouv+dilFrZZDCXDb
         S5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wnMkWYOJORJQUfchqDR0XY4kPAt74fPro2Qy03ywqQ=;
        b=AmvhncdLFgIe8WXtwYCUnAcJ8XJRdp/uKkdpbJzkmxrf8RWHi6S//0+oVDbaiK47sG
         d5o0U7mJ+UmGvGNMUaSMGZcLjPB4gZrj0lAvpUXJSIegWNzFC4nRfwZ6Kjdj1mzqc7iA
         BqAKpfQDAiPrxg4K2gtADSPbjb74iQETp+OSGkEUt6sdhOftaYg8kY8kQPLlZQZRGxXq
         0BjBJXzWrM5f+enoMiz20TsHG7/aeuGbScAb9GFaCi+oAWr88p+0Fy5F+3ZxyFVvq1va
         wk8aU3kbcX28ORLIFGCgUml8v4ENEdibgO8SlRFlOnVmvbFtVR/oLCqdGbXwgU6K2TVO
         JV6A==
X-Gm-Message-State: APzg51A2QWZb/+MzCYGD06pnT7LUt3ab+f0vbyemS1aPJYBPVPROH+7N
        I6NGHv6dyWxz+9Jod9bR7zonVwDbPXFfrp0/8XQ=
X-Google-Smtp-Source: ANB0VdZ2UolQN/QNhmWJx8DXUbi9vd31XDmEvSlqm6ZVMYwHTpQFweYP1v0qdyK1i/rmpZxQnPHFJkNzOPjWUZAayWY=
X-Received: by 2002:a02:270f:: with SMTP id g15-v6mr19622815jaa.94.1536002221602;
 Mon, 03 Sep 2018 12:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180829152500.46640-1-benpeart@microsoft.com> <20180829152500.46640-2-benpeart@microsoft.com>
In-Reply-To: <20180829152500.46640-2-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 3 Sep 2018 21:16:35 +0200
Message-ID: <CACsJy8BK5a1DgY4o5Xxrdjyg1QYxW-kCPNmAXkdudCD78O7dTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] read-cache: speed up index load through parallelization
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 5:25 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
> diff --git a/read-cache.c b/read-cache.c
> index 7b1354d759..c30346388a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1889,16 +1889,229 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
>         return ondisk_size + entries * per_entry;
>  }
>
> +/*
> + * A helper function that will load the specified range of cache entries
> + * from the memory mapped file and add them to the given index.
> + */
> +static unsigned long load_cache_entry_block(struct index_state *istate,
> +                       struct mem_pool *ce_mem_pool, int offset, int nr, void *mmap,
> +                       unsigned long start_offset, struct strbuf *previous_name)
> +{
> +       int i;
> +       unsigned long src_offset = start_offset;
> +
> +       for (i = offset; i < offset + nr; i++) {

It may be micro optimization, but since we're looping a lot and can't
trust the compiler to optimize this, maybe just calculate this upper
limit and store in a local variable to make it clear the upper limit
is known, no point of recalculating it at every iteration.

> +               struct ondisk_cache_entry *disk_ce;
> +               struct cache_entry *ce;
> +               unsigned long consumed;
> +
> +               disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
> +               ce = create_from_disk(ce_mem_pool, disk_ce, &consumed, previous_name);
> +               set_index_entry(istate, i, ce);
> +
> +               src_offset += consumed;
> +       }
> +       return src_offset - start_offset;
> +}
> +
> +static unsigned long load_all_cache_entries(struct index_state *istate,
> +                       void *mmap, size_t mmap_size, unsigned long src_offset)
> +{
> +       struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> +       unsigned long consumed;
> +
> +       if (istate->version == 4) {
> +               previous_name = &previous_name_buf;
> +               mem_pool_init(&istate->ce_mem_pool,
> +                             estimate_cache_size_from_compressed(istate->cache_nr));
> +       } else {
> +               previous_name = NULL;
> +               mem_pool_init(&istate->ce_mem_pool,
> +                             estimate_cache_size(mmap_size, istate->cache_nr));
> +       }
> +
> +       consumed = load_cache_entry_block(istate, istate->ce_mem_pool,
> +                                       0, istate->cache_nr, mmap, src_offset, previous_name);
> +       strbuf_release(&previous_name_buf);
> +       return consumed;
> +}
> +
> +#ifdef NO_PTHREADS
> +
> +#define load_cache_entries load_all_cache_entries
> +
> +#else
> +
> +#include "thread-utils.h"

Don't include files in a middle of a file.

> +
> +/*
> +* Mostly randomly chosen maximum thread counts: we
> +* cap the parallelism to online_cpus() threads, and we want
> +* to have at least 7500 cache entries per thread for it to
> +* be worth starting a thread.
> +*/
> +#define THREAD_COST            (7500)

Isn't 7500 a bit too low? I'm still basing on webkit.git,  and 7500
entries take about 1.2ms on average. 100k files would take about 16ms
and may be more reasonable (still too low in my opinion).

> +
> +struct load_cache_entries_thread_data
> +{
> +       pthread_t pthread;
> +       struct index_state *istate;
> +       struct mem_pool *ce_mem_pool;
> +       int offset, nr;
> +       void *mmap;
> +       unsigned long start_offset;
> +       struct strbuf previous_name_buf;
> +       struct strbuf *previous_name;
> +       unsigned long consumed; /* return # of bytes in index file processed */
> +};
> +
> +/*
> +* A thread proc to run the load_cache_entries() computation
> +* across multiple background threads.
> +*/
> +static void *load_cache_entries_thread(void *_data)
> +{
> +       struct load_cache_entries_thread_data *p = _data;
> +
> +       p->consumed += load_cache_entry_block(p->istate, p->ce_mem_pool,
> +               p->offset, p->nr, p->mmap, p->start_offset, p->previous_name);
> +       return NULL;
> +}
> +
> +static unsigned long load_cache_entries(struct index_state *istate,
> +                       void *mmap, size_t mmap_size, unsigned long src_offset)
> +{
> +       struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> +       struct load_cache_entries_thread_data *data;
> +       int nr_threads, cpus, ce_per_thread;
> +       unsigned long consumed;
> +       int i, thread;
> +
> +       nr_threads = git_config_get_index_threads();
> +       if (!nr_threads) {
> +               cpus = online_cpus();
> +               nr_threads = istate->cache_nr / THREAD_COST;
> +               if (nr_threads > cpus)
> +                       nr_threads = cpus;
> +       }
> +
> +       /* enable testing with fewer than default minimum of entries */
> +       if ((istate->cache_nr > 1) && (nr_threads < 2) && git_env_bool("GIT_INDEX_THREADS_TEST", 0))
> +               nr_threads = 2;

Please don't add more '()' than necessary. It's just harder to read.
Maybe break that "if" into two lines since it's getting long.

> +
> +       if (nr_threads < 2)
> +               return load_all_cache_entries(istate, mmap, mmap_size, src_offset);
> +
> +       /* a little sanity checking */
> +       if (istate->name_hash_initialized)
> +               die("the name hash isn't thread safe");
> +
> +       mem_pool_init(&istate->ce_mem_pool, 0);
> +       if (istate->version == 4)
> +               previous_name = &previous_name_buf;
> +       else
> +               previous_name = NULL;
> +
> +       ce_per_thread = DIV_ROUND_UP(istate->cache_nr, nr_threads);
> +       data = xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data));
> +
> +       /*
> +        * Loop through index entries starting a thread for every ce_per_thread
> +        * entries. Exit the loop when we've created the final thread (no need
> +        * to parse the remaining entries.
> +        */
> +       consumed = thread = 0;
> +       for (i = 0; ; i++) {
> +               struct ondisk_cache_entry *ondisk;
> +               const char *name;
> +               unsigned int flags;
> +
> +               /*
> +                * we've reached the beginning of a block of cache entries,
> +                * kick off a thread to process them
> +                */
> +               if (0 == i % ce_per_thread) {

I don't get why people keep putting constants in reversed order like
this. Perhaps in the old days, it helps catch "a = 0" mistakes, but
compilers nowadays are smart enough to complain about that and this is
just hard to read.

> +                       struct load_cache_entries_thread_data *p = &data[thread];
> +
> +                       p->istate = istate;
> +                       p->offset = i;
> +                       p->nr = ce_per_thread < istate->cache_nr - i ? ce_per_thread : istate->cache_nr - i;
> +
> +                       /* create a mem_pool for each thread */
> +                       if (istate->version == 4)
> +                               mem_pool_init(&p->ce_mem_pool,
> +                                                 estimate_cache_size_from_compressed(p->nr));
> +                       else
> +                               mem_pool_init(&p->ce_mem_pool,
> +                                                 estimate_cache_size(mmap_size, p->nr));
> +
> +                       p->mmap = mmap;
> +                       p->start_offset = src_offset;
> +                       if (previous_name) {
> +                               strbuf_addbuf(&p->previous_name_buf, previous_name);
> +                               p->previous_name = &p->previous_name_buf;
> +                       }
> +
> +                       if (pthread_create(&p->pthread, NULL, load_cache_entries_thread, p))
> +                               die("unable to create load_cache_entries_thread");
> +
> +                       /* exit the loop when we've created the last thread */
> +                       if (++thread == nr_threads)
> +                               break;

I still think it's better to have an extension to avoid looping
through like this. How much time does this "for (i = 0; ; i++)" loop
cost? The first thread can't start until you've scanned to the second
block, when you have zillion of entries and about 4 cores, that could
be significant delay. Unless you break smaller blocks and have one
thread handles multiple blocks, but then you pay the cost for
synchronization. Other threads may overlap a bit, but starting all
threads at the same time would benefit more. You also can't start
loading the extensions until you've scanned through all this.

> +               }
> +
> +               ondisk = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
> +
> +               /* On-disk flags are just 16 bits */
> +               flags = get_be16(&ondisk->flags);
> +
> +               if (flags & CE_EXTENDED) {
> +                       struct ondisk_cache_entry_extended *ondisk2;
> +                       ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
> +                       name = ondisk2->name;
> +               } else
> +                       name = ondisk->name;
> +
> +               if (!previous_name) {
> +                       size_t len;
> +
> +                       /* v3 and earlier */
> +                       len = flags & CE_NAMEMASK;
> +                       if (len == CE_NAMEMASK)
> +                               len = strlen(name);
> +                       src_offset += (flags & CE_EXTENDED) ?
> +                               ondisk_cache_entry_extended_size(len) :
> +                               ondisk_cache_entry_size(len);
> +               } else
> +                       src_offset += (name - ((char *)ondisk)) + expand_name_field(previous_name, name);
> +       }
> +
> +       for (i = 0; i < nr_threads; i++) {
> +               struct load_cache_entries_thread_data *p = data + i;
> +               if (pthread_join(p->pthread, NULL))
> +                       die("unable to join load_cache_entries_thread");

_()

> +               mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
> +               strbuf_release(&p->previous_name_buf);
> +               consumed += p->consumed;
> +       }
> +
> +       free(data);
> +       strbuf_release(&previous_name_buf);
> +
> +       return consumed;
> +}
> +
> +#endif
> +
-- 
Duy
