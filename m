Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB2F1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 10:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfAUKDA (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 05:03:00 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35648 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAUKC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 05:02:59 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so14368180itp.0
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 02:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uT5rvVkZIK1IVkJn7bt5iQjMhaGO+UL7qF2kmcr88M=;
        b=nGkYpiWrfxDLe+o0qQ9uu8q8bI6z8IGP+ysPbaNQYMOgg6PKUxo5zn5xqikvqMMk3n
         g/I50NbCUGivkPKdSJ/m1UeZli+6QVKwGSH9RodR2u+wopB8T11pgD5UtRgpSX6O/x/W
         FJVXIwGviKO4x5F6ScszBmDP+qQaF5DIVM5cg9HFVjPKcSn6pEtWApoYorOWqtMQluou
         2D6YFGVSxFgsGh0Trxcunhw4PlLiGRLUX8MA/ndjzZjB0r2l71bg5Z4o0xxn9OKRmsSC
         x9nBjBd/61nKcOQxGsElz5Y+kH2eiE7FiJsbNlZXd07o1CXt35C64rfQkFG5XSeqEDBb
         8AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uT5rvVkZIK1IVkJn7bt5iQjMhaGO+UL7qF2kmcr88M=;
        b=PZjwXuV1X77qAuSqC7mVlcUCf69kvjioCmbdwz9h1L8QRXmE4r64aHyiMRPhpEv48G
         GmvNAcYIAiR3ZElbqFMNUwURG7Eo8MuGqBO3fv2RVOiMTJHMCnMc+dxV0JXXlyKg5fHS
         FxcX0QGyCTJdkBu1ySf+CJLYelQPedPXrSUgZKmB7ts5rLDsmLSD8ta9ndL1nehJzsmD
         PJT/CqEnAD/TAHZcjwtIuv3b5bA2h2NAKZBcVwxIQNzf+PmLQ9IoFBYlSYP6VdEkBz85
         m5fDyLxU2U4otVMzS4TT1gKKQCVwm+KJ4+osp27+6weg6uG+yfizw8ZKNwT0nRx1Op52
         EykA==
X-Gm-Message-State: AJcUukdLwCefDlvcVsBMT3HQMJSH4DbiKCKiTLKtzmA1Pankhqs7cezh
        Io4ZMJ7IhTqRq0mnzOHFmdnb6MbKBJGG5imzPCg=
X-Google-Smtp-Source: ALg8bN5G1OLJtO+VgLVoVaLV5ZMIbTM+Xf2UsGa3LE/qDwbDx3CjtPbyCeQy+sEgo4Ihcir4hC3qts2UZoWsIPURrpo=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr16452620ith.123.1548064978773;
 Mon, 21 Jan 2019 02:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20190119154337.6556-1-phogg@novamoon.net>
In-Reply-To: <20190119154337.6556-1-phogg@novamoon.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 21 Jan 2019 17:02:33 +0700
Message-ID: <CACsJy8AWCP+enBVVVga7jJZ-gxD=fxcushrk0D+xGSRAcZw_qg@mail.gmail.com>
Subject: Re: [PATCH v2] pack-objects: Use packing_data lock instead of read_mutex
To:     Patrick Hogg <phogg@novamoon.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 19, 2019 at 10:45 PM Patrick Hogg <phogg@novamoon.net> wrote:
>
> ac77d0c37 ("pack-objects: shrink size field in struct object_entry",
> 2018-04-14) added an extra usage of read_lock/read_unlock in the newly
> introduced oe_get_size_slow for thread safety in parallel calls to
> try_delta(). Unfortunately oe_get_size_slow is also used in serial
> code, some of which is called before the first invocation of
> ll_find_deltas. As such the read mutex is not guaranteed to be
> initialized.
>
> Resolve this by using the existing lock in packing_data which is
> initialized early in cmd_pack_objects instead of read_mutex.
> Additionally, upgrade the packing_data lock to a recursive mutex to
> make it a suitable replacement for read_mutex.
>
> Signed-off-by: Patrick Hogg <phogg@novamoon.net>
> ---
>
> As I mentioned in the prior thread I think that it will be simpler
> to simply use the existing lock in packing_data instead of moving
> read_mutex. I can go back to simply moving read_mutex to the
> packing_data struct if that that is preferable, though.

In early iterations of these changes, I think we hit high contention
when sharing the mutex [1]. I don't know if we will hit the same
performance problem again with this patch. It would be great if Elijah
with his zillion core machine could test this out. Otherwise it may be
just safer to keep the two mutexes separate.

[1] http://public-inbox.org/git/20180720052829.GA3852@sigill.intra.peff.net/

>
> I also removed the #ifndef NO_PTHREADS in prepare_packing_data around
> the initialization of &pdata->lock since I had to upgrade the lock to
> a recursive mutex. As far as I can tell init_recursive_mutex (and
> pthread_mutex_init for that matter) have that protection already so it
> appears to be redundant.
>
>  builtin/pack-objects.c | 27 ++++++++++++---------------
>  pack-objects.c         |  4 +---
>  2 files changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 411aefd68..5439b434c 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1954,9 +1954,8 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
>  }
>
>  /* Protect access to object database */
> -static pthread_mutex_t read_mutex;
> -#define read_lock()            pthread_mutex_lock(&read_mutex)
> -#define read_unlock()          pthread_mutex_unlock(&read_mutex)
> +#define pack_lock()            packing_data_lock(&to_pack)
> +#define pack_unlock()          packing_data_unlock(&to_pack)
>
>  /* Protect delta_cache_size */
>  static pthread_mutex_t cache_mutex;
> @@ -1993,11 +1992,11 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
>         unsigned long used, avail, size;
>
>         if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
> -               read_lock();
> +               pack_lock();
>                 if (oid_object_info(the_repository, &e->idx.oid, &size) < 0)
>                         die(_("unable to get size of %s"),
>                             oid_to_hex(&e->idx.oid));
> -               read_unlock();
> +               pack_unlock();
>                 return size;
>         }
>
> @@ -2005,7 +2004,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
>         if (!p)
>                 BUG("when e->type is a delta, it must belong to a pack");
>
> -       read_lock();
> +       pack_lock();
>         w_curs = NULL;
>         buf = use_pack(p, &w_curs, e->in_pack_offset, &avail);
>         used = unpack_object_header_buffer(buf, avail, &type, &size);
> @@ -2014,7 +2013,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
>                     oid_to_hex(&e->idx.oid));
>
>         unuse_pack(&w_curs);
> -       read_unlock();
> +       pack_unlock();
>         return size;
>  }
>
> @@ -2076,9 +2075,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>
>         /* Load data if not already done */
>         if (!trg->data) {
> -               read_lock();
> +               pack_lock();
>                 trg->data = read_object_file(&trg_entry->idx.oid, &type, &sz);
> -               read_unlock();
> +               pack_unlock();
>                 if (!trg->data)
>                         die(_("object %s cannot be read"),
>                             oid_to_hex(&trg_entry->idx.oid));
> @@ -2089,9 +2088,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>                 *mem_usage += sz;
>         }
>         if (!src->data) {
> -               read_lock();
> +               pack_lock();
>                 src->data = read_object_file(&src_entry->idx.oid, &type, &sz);
> -               read_unlock();
> +               pack_unlock();
>                 if (!src->data) {
>                         if (src_entry->preferred_base) {
>                                 static int warned = 0;
> @@ -2337,9 +2336,9 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
>
>  static void try_to_free_from_threads(size_t size)
>  {
> -       read_lock();
> +       pack_lock();
>         release_pack_memory(size);
> -       read_unlock();
> +       pack_unlock();
>  }
>
>  static try_to_free_t old_try_to_free_routine;
> @@ -2381,7 +2380,6 @@ static pthread_cond_t progress_cond;
>   */
>  static void init_threaded_search(void)
>  {
> -       init_recursive_mutex(&read_mutex);
>         pthread_mutex_init(&cache_mutex, NULL);
>         pthread_mutex_init(&progress_mutex, NULL);
>         pthread_cond_init(&progress_cond, NULL);
> @@ -2392,7 +2390,6 @@ static void cleanup_threaded_search(void)
>  {
>         set_try_to_free_routine(old_try_to_free_routine);
>         pthread_cond_destroy(&progress_cond);
> -       pthread_mutex_destroy(&read_mutex);
>         pthread_mutex_destroy(&cache_mutex);
>         pthread_mutex_destroy(&progress_mutex);
>  }
> diff --git a/pack-objects.c b/pack-objects.c
> index b6cdbb016..6f32a7ba0 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -148,9 +148,7 @@ void prepare_packing_data(struct packing_data *pdata)
>                                              1U << OE_SIZE_BITS);
>         pdata->oe_delta_size_limit = git_env_ulong("GIT_TEST_OE_DELTA_SIZE",
>                                                    1UL << OE_DELTA_SIZE_BITS);
> -#ifndef NO_PTHREADS
> -       pthread_mutex_init(&pdata->lock, NULL);
> -#endif
> +       init_recursive_mutex(&pdata->lock);
>  }
>
>  struct object_entry *packlist_alloc(struct packing_data *pdata,
> --
> 2.20.1.windows.1
>


-- 
Duy
