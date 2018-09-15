Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A591F404
	for <e@80x24.org>; Sat, 15 Sep 2018 10:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeIOPlB (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 11:41:01 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40527 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeIOPlB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 11:41:01 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so5575136ita.5
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWT+2eKyIS/ALBmrraUONoGtCZrNjfs8zXUabSjWK30=;
        b=MRzN9gROdhTbWrpfLV9UvKhXJxWB8Pw2Fuj9diblhecYpOABg5AQY0T/R9dhot6dDp
         2nhlLnFTnmF6mZk395BdNcOQcM2axQ7rjAUkh+6IBIP+frn0D8Xygc7s8l38sj8EYjoZ
         BsMssBHJ6ZSQKpZyHuluMUejP3pduhYdGlNmt/c69+2jnCRwz+kYBPASZzoZ/O1QTTBS
         SOXlGt2n8UfOVxzoae7B/nRf8cmCvn1ebRXiBNYRCS8vzfvYQMBCNNUe0nC/nSxs/f8M
         UWYbUGNpB1hT+l1UUgxlzTyoJrs2R0hqMwYI/jCWFTI1GJVgzo1i6Q7DBhJKNLZbEKwU
         +hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWT+2eKyIS/ALBmrraUONoGtCZrNjfs8zXUabSjWK30=;
        b=o9Wou5W3sPF8ABmQegcKMnSYQKDR33e09Jn+vo2iM0A0heN5LzTgUS/+q0ScTMnJyC
         gy96JzsKrUMs43eNiA6rTPqa+C6hky4QYDomvfS9iHj5yn5NK4BkYG5C1uN5tg34ewdU
         2rc9r5r/csljW0kXT25QreotSKfQ2Obmllmgz9nPfg8mU5BV30UXmUXdZ6CQtcF08QWe
         1Sqn3yT86Rh0TOoJakwfvYP80n0JNPJWu6JpieaTCcydRJpD0D/5VyurwlWfW9oB6urz
         ZuUPot0jeEEJMcgxj2aW8r8R7mzweayjjDBs/eSTMBj8xgl8Zqzp1O4aEhutLpEmfssl
         BeMg==
X-Gm-Message-State: APzg51DI9j991TSipg7BluKX25Z3Z7QRQ1dXF27MxFtYG8B44FKHy6cw
        eUKr3ZKOWdpQS72bM2Or/nLHM1+hfZW9Rp48/xw=
X-Google-Smtp-Source: ANB0VdZv5A/dfC3aULj0hz5poSusY0+OU8giq9torvoQE7LuTdjSMjKbn/B3f6BLHYcIdxY6tbc1t4u5uMSPQlENGcM=
X-Received: by 2002:a24:d583:: with SMTP id a125-v6mr5775121itg.91.1537006949728;
 Sat, 15 Sep 2018 03:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com> <20180912161832.55324-3-benpeart@microsoft.com>
In-Reply-To: <20180912161832.55324-3-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 15 Sep 2018 12:22:02 +0200
Message-ID: <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] read-cache: load cache extensions on a worker thread
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 6:18 PM Ben Peart <benpeart@microsoft.com> wrote:
>
> This patch helps address the CPU cost of loading the index by loading
> the cache extensions on a worker thread in parallel with loading the cache
> entries.
>
> In some cases, loading the extensions takes longer than loading the
> cache entries so this patch utilizes the new EOIE to start the thread to
> load the extensions before loading all the cache entries in parallel.
>
> This is possible because the current extensions don't access the cache
> entries in the index_state structure so are OK that they don't all exist
> yet.
>
> The CACHE_EXT_TREE, CACHE_EXT_RESOLVE_UNDO, and CACHE_EXT_UNTRACKED
> extensions don't even get a pointer to the index so don't have access to the
> cache entries.
>
> CACHE_EXT_LINK only uses the index_state to initialize the split index.
> CACHE_EXT_FSMONITOR only uses the index_state to save the fsmonitor last
> update and dirty flags.
>
> I used p0002-read-cache.sh to generate some performance data:
>
> Test w/100,000 files                Baseline         Parallel Extensions
> ---------------------------------------------------------------------------
> read_cache/discard_cache 1000 times 14.08(0.01+0.10) 9.72(0.03+0.06) -31.0%
>
> Test w/1,000,000 files              Baseline         Parallel Extensions
> ------------------------------------------------------------------------------
> read_cache/discard_cache 1000 times 202.95(0.01+0.07) 154.14(0.03+0.06) -24.1%
>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
>  Documentation/config.txt |  6 +++
>  config.c                 | 18 ++++++++
>  config.h                 |  1 +
>  read-cache.c             | 94 ++++++++++++++++++++++++++++++++--------
>  4 files changed, 102 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1c42364988..79f8296d9c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2391,6 +2391,12 @@ imap::
>         The configuration variables in the 'imap' section are described
>         in linkgit:git-imap-send[1].
>
> +index.threads::
> +       Specifies the number of threads to spawn when loading the index.
> +       This is meant to reduce index load time on multiprocessor machines.
> +       Specifying 0 or 'true' will cause Git to auto-detect the number of
> +       CPU's and set the number of threads accordingly. Defaults to 'true'.

I'd rather this variable defaults to 0. Spawning threads have
associated cost and most projects out there are small enough that this
multi threading could just add more cost than gain. It only makes
sense to enable this on huge repos.

Wait there's no way to disable this parallel reading? Does not sound
right. And  if ordinary numbers mean the number of threads then 0
should mean no threading. Auto detection could have a new keyword,
like 'auto'.

> +
>  index.version::
>         Specify the version with which new index files should be
>         initialized.  This does not affect existing repositories.
> diff --git a/config.c b/config.c
> index 9a0b10d4bc..9bd79fb165 100644
> --- a/config.c
> +++ b/config.c
> @@ -2289,6 +2289,24 @@ int git_config_get_fsmonitor(void)
>         return 0;
>  }
>
> +/*
> + * You can disable multi-threaded code by setting index.threads
> + * to 'false' (or 1)
> + */
> +int git_config_get_index_threads(void)
> +{
> +       int is_bool, val;
> +
> +       if (!git_config_get_bool_or_int("index.threads", &is_bool, &val)) {
> +               if (is_bool)
> +                       return val ? 0 : 1;
> +               else
> +                       return val;
> +       }
> +
> +       return 0; /* auto-detect */
> +}
> +
>  NORETURN
>  void git_die_config_linenr(const char *key, const char *filename, int linenr)
>  {
> diff --git a/config.h b/config.h
> index ab46e0165d..a06027e69b 100644
> --- a/config.h
> +++ b/config.h
> @@ -250,6 +250,7 @@ extern int git_config_get_untracked_cache(void);
>  extern int git_config_get_split_index(void);
>  extern int git_config_get_max_percent_split_change(void);
>  extern int git_config_get_fsmonitor(void);
> +extern int git_config_get_index_threads(void);
>
>  /* This dies if the configured or default date is in the future */
>  extern int git_config_get_expiry(const char *key, const char **output);
> diff --git a/read-cache.c b/read-cache.c
> index 858935f123..b203eebb44 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -23,6 +23,10 @@
>  #include "split-index.h"
>  #include "utf8.h"
>  #include "fsmonitor.h"
> +#ifndef NO_PTHREADS
> +#include <pthread.h>
> +#include <thread-utils.h>
> +#endif

I don't think you're supposed to include system header files after
"cache.h". Including thread-utils.h should be enough (and it keeps the
exception of inclduing pthread.h in just one place). Please use
"pthread-utils.h" instead of <pthread-utils.h> which is usually for
system header files. And include ptherad-utils.h unconditionally.

>
>  /* Mask for the name length in ce_flags in the on-disk index */
>
> @@ -1898,6 +1902,46 @@ static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size);
>  #endif
>  static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, unsigned long offset);
>
> +struct load_index_extensions
> +{
> +#ifndef NO_PTHREADS
> +       pthread_t pthread;
> +#endif
> +       struct index_state *istate;
> +       void *mmap;
> +       size_t mmap_size;
> +       unsigned long src_offset;
> +};
> +
> +static void *load_index_extensions(void *_data)
> +{
> +       struct load_index_extensions *p = _data;
> +       unsigned long src_offset = p->src_offset;
> +
> +       while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
> +               /* After an array of active_nr index entries,
> +                * there can be arbitrary number of extended
> +                * sections, each of which is prefixed with
> +                * extension name (4-byte) and section length
> +                * in 4-byte network byte order.
> +                */
> +               uint32_t extsize;
> +               memcpy(&extsize, (char *)p->mmap + src_offset + 4, 4);
> +               extsize = ntohl(extsize);
> +               if (read_index_extension(p->istate,
> +                       (const char *)p->mmap + src_offset,
> +                       (char *)p->mmap + src_offset + 8,
> +                       extsize) < 0) {
> +                       munmap(p->mmap, p->mmap_size);
> +                       die("index file corrupt");

_()

> +               }
> +               src_offset += 8;
> +               src_offset += extsize;
> +       }
> +
> +       return NULL;
> +}
> +
>  /* remember to discard_cache() before reading a different cache! */
>  int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  {
> @@ -1908,6 +1952,11 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>         void *mmap;
>         size_t mmap_size;
>         struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> +       struct load_index_extensions p = { 0 };
> +       unsigned long extension_offset = 0;
> +#ifndef NO_PTHREADS
> +       int nr_threads;
> +#endif
>
>         if (istate->initialized)
>                 return istate->cache_nr;
> @@ -1944,6 +1993,26 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>         istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
>         istate->initialized = 1;
>
> +       p.istate = istate;
> +       p.mmap = mmap;
> +       p.mmap_size = mmap_size;
> +
> +#ifndef NO_PTHREADS
> +       nr_threads = git_config_get_index_threads();
> +       if (!nr_threads)
> +               nr_threads = online_cpus();
> +
> +       if (nr_threads >= 2) {
> +               extension_offset = read_eoie_extension(mmap, mmap_size);
> +               if (extension_offset) {
> +                       /* create a thread to load the index extensions */

Pointless comment. It's pretty clear from the pthread_create() below
thanks to good function naming. Please remove.

> +                       p.src_offset = extension_offset;
> +                       if (pthread_create(&p.pthread, NULL, load_index_extensions, &p))
> +                               die(_("unable to create load_index_extensions_thread"));
> +               }
> +       }
> +#endif
> +
>         if (istate->version == 4) {
>                 previous_name = &previous_name_buf;
>                 mem_pool_init(&istate->ce_mem_pool,
> @@ -1970,23 +2039,14 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>         istate->timestamp.sec = st.st_mtime;
>         istate->timestamp.nsec = ST_MTIME_NSEC(st);
>
> -       while (src_offset <= mmap_size - the_hash_algo->rawsz - 8) {
> -               /* After an array of active_nr index entries,
> -                * there can be arbitrary number of extended
> -                * sections, each of which is prefixed with
> -                * extension name (4-byte) and section length
> -                * in 4-byte network byte order.
> -                */
> -               uint32_t extsize;
> -               memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
> -               extsize = ntohl(extsize);
> -               if (read_index_extension(istate,
> -                                        (const char *) mmap + src_offset,
> -                                        (char *) mmap + src_offset + 8,
> -                                        extsize) < 0)
> -                       goto unmap;
> -               src_offset += 8;
> -               src_offset += extsize;
> +       /* if we created a thread, join it otherwise load the extensions on the primary thread */
> +#ifndef NO_PTHREADS
> +       if (extension_offset && pthread_join(p.pthread, NULL))
> +               die(_("unable to join load_index_extensions_thread"));

I guess the last _ is a typo and you wanted "unable to join
load_index_extensions thread". Please use die_errno() instead.

> +#endif
> +       if (!extension_offset) {
> +               p.src_offset = src_offset;
> +               load_index_extensions(&p);
>         }
>         munmap(mmap, mmap_size);
>         return istate->cache_nr;
> --
> 2.18.0.windows.1
>


-- 
Duy
