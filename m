Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BADE1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbeGTScp (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:32:45 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38594 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387855AbeGTScp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:32:45 -0400
Received: by mail-ua0-f195.google.com with SMTP id o11-v6so7970097uak.5
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Esc/Nw2XggCTn0d2WMF79UOnelYg298kbmp3AqOWo6o=;
        b=Zh3bIZv9Sj8sqVCzDGUo3PApvvj97kuBPu7M3OXVHI4thxg5jrOgVG49koyoXMvRob
         k9+c5g3zhlDWJulGA/sYPbDrfWnn3jjj91WteB0Fqoq4BLra6RBxJpTNVC+UWqLMBAc0
         c/1LotrzuaUjOy7GVvq35BaTDKv6PPsN9OtiwzokIW5YdlUnlACgX9Dl6urHQERY99E+
         XK3mdqJUdyhL1yEUBq7FZi9yp7X1czFs6TdlwWyBj4wjj5l5CsxKkAgN2y1GxvS4S+k+
         CpZqgeUb8vUgTwADYKqJQcqQEOGQ6k7E8IB25A0uoesC1ikl8B89pEstAH3m/W9p/jWH
         8XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Esc/Nw2XggCTn0d2WMF79UOnelYg298kbmp3AqOWo6o=;
        b=HPqOlHtZEYLjttXPdVXTzwxzxstIjYqyEfGt32FagHJOqAgvs7jqdpVOCZfu1G2S65
         eITWrRRpCSG/TaslsKH4k8Jzb4GcTT+OU04ny0nLGyq0Cin6VEHaZFi5qQyBSkVoZetM
         Dv66zUWrthdTOOIwgSTTW8avs/eWhcDMlnLZQJu0k3I/Y5+79HMZVjPJvMQ7vbcKs7kS
         DY2Nm5vK0LoT+x3xdhuSSBaXtAGrINwrfcGG9oiD2YaM58rhTUUWsDHMweYdwpHnB85W
         M8nGTagxBMCYdX9pKswGjnaWyJueRpozB36hoknb6Cz8LyLfu8TnRTH3vNsWk0GfXQbr
         kgHg==
X-Gm-Message-State: AOUpUlFCeuVcokIjDfc082S9iFqplEOSAhUsoCBSu5hwiFgyTfjszmEj
        qBwUn0i1zhwbVfh0yQ5wRto7FL/WOwDkX4ek/qXmyg==
X-Google-Smtp-Source: AAOMgpd5r3CEB9GQJfMIwwnS5QxZEj1x4wxG6Eh5T8phinrVymqRvXsX4xcsl/16QnEses7tQWXC6ETGBU2Xa+ge9eU=
X-Received: by 2002:a9f:3666:: with SMTP id s35-v6mr2161602uad.94.1532108605536;
 Fri, 20 Jul 2018 10:43:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 10:43:25
 -0700 (PDT)
In-Reply-To: <20180720153943.575-1-pclouds@gmail.com>
References: <20180718225110.17639-1-newren@gmail.com> <20180720153943.575-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jul 2018 10:43:25 -0700
Message-ID: <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 8:39 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Let's start with some background about oe_delta_size() and
> oe_set_delta_size(). If you already know, skip the next paragraph.
>
> These two are added in 0aca34e826 (pack-objects: shrink delta_size
> field in struct object_entry - 2018-04-14) to help reduce 'struct
> object_entry' size. The delta size field in this struct is reduced to
> only contain max 2MB. So if any new delta is produced and larger than

I think you mean 1MB?

$ git grep OE_DELTA_SIZE_BITS v2.18.0
v2.18.0:builtin/pack-objects.c: if (delta_size >=3D (1U << OE_DELTA_SIZE_BI=
TS)) {
v2.18.0:pack-objects.h:#define OE_DELTA_SIZE_BITS       20
v2.18.0:pack-objects.h: unsigned delta_size_:OE_DELTA_SIZE_BITS; /*
delta data size (uncompressed) */

In https://public-inbox.org/git/20180719151640.GA24997@duynguyen.home/,
you bumped this to 21, which may be where you got the 2MB figure?
Your 2MB figure also appears on the next line and a few other places
in the commit message.

> 2MB, it's dropped because we can't really save such a large size
> anywhere. Fallback is provided in case existingpackfiles already have

Missing space: s/existingpackfiles/existing packfiles/

> large deltas, then we can retrieve it from the pack.
>
> While this should help small machines repacking large repos (i.e. less

Maybe change "repacking large repos" to "repacking large repos without
large deltas"?

> memory pressure), dropping large deltas during the delta selection
> process could end up with worse pack files. And if existing packfiles
> already have >2MB delta and pack-objects is instructed to not reuse
> deltas, all of them will be dropped on the floor, and the resulting
> pack would be definitely bigger.
>
> There is also a regression in terms of CPU/IO if we have large on-disk
> deltas because fallback code needs to parse the pack every time the
> delta size is needed and just access to the mmap'd pack data is enough
> for extra page faults when memory is under pressure.
>
> Both of these issues were reported on the mailing list. Here's some
> numbers for comparison.
>
>     Version  Pack (MB)  MaxRSS(kB)  Time (s)
>     -------  ---------  ----------  --------
>      2.17.0     5498     43513628    2494.85
>      2.18.0    10531     40449596    4168.94
>
> This patch provides a better fallback that is
>
> - cheaper in terms of cpu and io because we won't have to read
>   existing pack files as much
>
> - better in terms of pack size because the pack heuristics is back to
>   2.17.0 time, we do not drop large deltas at all
>
> If we encounter any delta (on-disk or created during try_delta phase)
> that is larger than the 2MB limit, we stop using delta_size_ field for
> this because it can't contain such size anyway. A new array of delta
> size is dynamically allocated and can hold all the deltas that 2.17.0
> can [1]. All current delta sizes are migrated over.
>
> With this, we do not have to drop deltas in try_delta() anymore. Of
> course the downside is we use slightly more memory, even compared to
> 2.17.0. But since this is considered an uncommon case, a bit more
> memory consumption should not be a problem.

Out of curiosity, would it be possible to use the delta_size_ field
for deltas that are small enough, and only use an external data
structure (perhaps a hash rather than an array) for the few deltas
that are large?

> Delta size limit is also raised from 2MB to 32 MB to better cover
> common case and avoid that extra memory consumption (99.999% deltas in
> this reported repo are under 12MB). Other fields are shuffled around
> to keep this struct packed tight. We don't use more memory in common
> case even with this limit update.
>
> A note about thread synchronization. Since this code can be run in
> parallel during delta searching phase, we need a mutex. The realloc
> part in packlist_alloc() is not protected because it only happens
> during the object counting phase, which is always single-threaded.
>
> The locking in oe_delta_size() could also be dropped if we make sure
> the pack->delta_size pointer assignment in oe_set_delta_size() is
> atomic. But let's keep the lock for now to be on the safe side. Lock
> contention should not be that high for this lock.
>
> [1] With a small tweak. 2.17.0 on 64-bit linux can hold 2^64 byte
>     deltas, which is absolutely insane. But windows builds, even
>     64-bit version, only hold 2^32. So reducing it to 2^32 should be
>     quite safe.
>
> Reported-by: Elijah Newren <newren@gmail.com>
> Helped-by: Elijah Newren <newren@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  I'm optimistic that the slowness on linux repo is lock contention
>  (because if it's not then I have no clue what is). So let's start
>  doing proper patches.

I'll be testing this shortly...

>
>  If we want a quick fix for 2.18.1. I suggest bumping up
>  OE_DELTA_SIZE_BITS like Elijah did in his second option. I don't
>  think it's safe to fast track this patch.

Okay, I'll submit that with a proper commit message then.  Since you
also bump OE_DELTA_SIZE_BITS in your patch (though to a different
value), it'll require a conflict resolution when merging maint into
master, but at least the change won't silently leak through.

>  builtin/pack-objects.c    |  6 ++--
>  ci/run-build-and-tests.sh |  1 +
>  pack-objects.c            | 21 ++++++++++++
>  pack-objects.h            | 68 +++++++++++++++++++++++++++++++--------
>  t/README                  |  4 +++
>  5 files changed, 82 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ebc8cefb53..3bc182b1b6 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2023,10 +2023,6 @@ static int try_delta(struct unpacked *trg, struct =
unpacked *src,
>         delta_buf =3D create_delta(src->index, trg->data, trg_size, &delt=
a_size, max_size);
>         if (!delta_buf)
>                 return 0;
> -       if (delta_size >=3D (1U << OE_DELTA_SIZE_BITS)) {
> -               free(delta_buf);
> -               return 0;
> -       }
>
>         if (DELTA(trg_entry)) {
>                 /* Prefer only shallower same-sized deltas. */
> @@ -2278,6 +2274,8 @@ static void init_threaded_search(void)
>         pthread_mutex_init(&cache_mutex, NULL);
>         pthread_mutex_init(&progress_mutex, NULL);
>         pthread_cond_init(&progress_cond, NULL);
> +       pthread_mutex_init(&to_pack.lock, NULL);
> +       to_pack.lock_initialized =3D 1;
>         old_try_to_free_routine =3D set_try_to_free_routine(try_to_free_f=
rom_threads);
>  }
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 4b04c75b7f..2a5bff4a1c 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -14,6 +14,7 @@ then
>         export GIT_TEST_SPLIT_INDEX=3Dyes
>         export GIT_TEST_FULL_IN_PACK_ARRAY=3Dtrue
>         export GIT_TEST_OE_SIZE=3D10
> +       export GIT_TEST_OE_DELTA_SIZE=3D5
>         make --quiet test
>  fi
>
> diff --git a/pack-objects.c b/pack-objects.c
> index 92708522e7..eef344b7c1 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -88,6 +88,23 @@ struct object_entry *packlist_find(struct packing_data=
 *pdata,
>         return &pdata->objects[pdata->index[i] - 1];
>  }
>
> +uint32_t *new_delta_size_array(struct packing_data *pack)
> +{
> +       uint32_t *delta_size;
> +       uint32_t i;
> +
> +       /*
> +        * nr_alloc, not nr_objects to align with realloc() strategy in
> +        * packlist_alloc()
> +        */
> +       ALLOC_ARRAY(delta_size, pack->nr_alloc);
> +
> +       for (i =3D 0; i < pack->nr_objects; i++)
> +               delta_size[i] =3D pack->objects[i].delta_size_;
> +
> +       return delta_size;
> +}
> +
>  static void prepare_in_pack_by_idx(struct packing_data *pdata)
>  {
>         struct packed_git **mapping, *p;
> @@ -146,6 +163,8 @@ void prepare_packing_data(struct packing_data *pdata)
>
>         pdata->oe_size_limit =3D git_env_ulong("GIT_TEST_OE_SIZE",
>                                              1U << OE_SIZE_BITS);
> +       pdata->oe_delta_size_limit =3D git_env_ulong("GIT_TEST_OE_DELTA_S=
IZE",
> +                                                  1U << OE_DELTA_SIZE_BI=
TS);

Perhaps 1UL instead of 1U, in case the user specifies the value of 32?
 I know that flag is meant for testing smaller values, but since 32
was the first value I tried for OE_DELTA_SIZE_BITS when debugging my
issue maybe it makes sense to allow it?

>  }
>
>  struct object_entry *packlist_alloc(struct packing_data *pdata,
> @@ -160,6 +179,8 @@ struct object_entry *packlist_alloc(struct packing_da=
ta *pdata,
>
>                 if (!pdata->in_pack_by_idx)
>                         REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
> +               if (pdata->delta_size)
> +                       REALLOC_ARRAY(pdata->delta_size, pdata->nr_alloc)=
;
>         }
>
>         new_entry =3D pdata->objects + pdata->nr_objects++;
> diff --git a/pack-objects.h b/pack-objects.h
> index edf74dabdd..9f977ae800 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -2,6 +2,7 @@
>  #define PACK_OBJECTS_H
>
>  #include "object-store.h"
> +#include "thread-utils.h"
>
>  #define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
>
> @@ -14,7 +15,7 @@
>   * above this limit. Don't lower it too much.
>   */
>  #define OE_SIZE_BITS           31
> -#define OE_DELTA_SIZE_BITS     20
> +#define OE_DELTA_SIZE_BITS     24
>
>  /*
>   * State flags for depth-first search used for analyzing delta cycles.
> @@ -93,12 +94,12 @@ struct object_entry {
>                                      * uses the same base as me
>                                      */
>         unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (unco=
mpressed) */
> -       unsigned delta_size_valid:1;
> +       unsigned char in_pack_header_size;
>         unsigned in_pack_idx:OE_IN_PACK_BITS;   /* already in pack */
>         unsigned z_delta_size:OE_Z_DELTA_BITS;
>         unsigned type_valid:1;
> -       unsigned type_:TYPE_BITS;
>         unsigned no_try_delta:1;
> +       unsigned type_:TYPE_BITS;
>         unsigned in_pack_type:TYPE_BITS; /* could be delta */
>         unsigned preferred_base:1; /*
>                                     * we do not pack this, but is availab=
le
> @@ -108,17 +109,16 @@ struct object_entry {
>         unsigned tagged:1; /* near the very tip of refs */
>         unsigned filled:1; /* assigned write-order */
>         unsigned dfs_state:OE_DFS_STATE_BITS;
> -       unsigned char in_pack_header_size;
>         unsigned depth:OE_DEPTH_BITS;
>
>         /*
>          * pahole results on 64-bit linux (gcc and clang)
>          *
> -        *   size: 80, bit_padding: 20 bits, holes: 8 bits
> +        *   size: 80, bit_padding: 9 bits
>          *
>          * and on 32-bit (gcc)
>          *
> -        *   size: 76, bit_padding: 20 bits, holes: 8 bits
> +        *   size: 76, bit_padding: 9 bits
>          */
>  };
>
> @@ -130,6 +130,7 @@ struct packing_data {
>         uint32_t index_size;
>
>         unsigned int *in_pack_pos;
> +       uint32_t *delta_size;
>
>         /*
>          * Only one of these can be non-NULL and they have different
> @@ -140,10 +141,32 @@ struct packing_data {
>         struct packed_git **in_pack_by_idx;
>         struct packed_git **in_pack;
>
> +#ifndef NO_PTHREADS
> +       int lock_initialized;
> +       pthread_mutex_t lock;
> +#endif
> +
>         uintmax_t oe_size_limit;
> +       uintmax_t oe_delta_size_limit;
>  };
>
>  void prepare_packing_data(struct packing_data *pdata);
> +
> +static inline void packing_data_lock(struct packing_data *pdata)
> +{
> +#ifndef NO_PTHREADS
> +       if (pdata->lock_initialized)
> +               pthread_mutex_lock(&pdata->lock);
> +#endif
> +}
> +static inline void packing_data_unlock(struct packing_data *pdata)
> +{
> +#ifndef NO_PTHREADS
> +       if (pdata->lock_initialized)
> +               pthread_mutex_unlock(&pdata->lock);
> +#endif
> +}
> +
>  struct object_entry *packlist_alloc(struct packing_data *pdata,
>                                     const unsigned char *sha1,
>                                     uint32_t index_pos);
> @@ -330,20 +353,37 @@ static inline void oe_set_size(struct packing_data =
*pack,
>  static inline unsigned long oe_delta_size(struct packing_data *pack,
>                                           const struct object_entry *e)
>  {
> -       if (e->delta_size_valid)
> -               return e->delta_size_;
> -       return oe_size(pack, e);
> +       unsigned long size;
> +
> +       packing_data_lock(pack);
> +       if (pack->delta_size)
> +               size =3D pack->delta_size[e - pack->objects];
> +       else
> +               size =3D e->delta_size_;
> +       packing_data_unlock(pack);
> +       return size;
>  }
>
> +uint32_t *new_delta_size_array(struct packing_data *pdata);
>  static inline void oe_set_delta_size(struct packing_data *pack,
>                                      struct object_entry *e,
>                                      unsigned long size)
>  {
> -       e->delta_size_ =3D size;
> -       e->delta_size_valid =3D e->delta_size_ =3D=3D size;
> -       if (!e->delta_size_valid && size !=3D oe_size(pack, e))
> -               BUG("this can only happen in check_object() "
> -                   "where delta size is the same as entry size");
> +       packing_data_lock(pack);
> +       if (!pack->delta_size && size < pack->oe_delta_size_limit) {
> +               packing_data_unlock(pack);
> +               e->delta_size_ =3D size;
> +               return;
> +       }
> +       /*
> +        * We have had at least one delta size exceeding OE_DELTA_SIZE_BI=
TS
> +        * limit. delta_size_ will not be used anymore. All delta sizes a=
re
> +        * now from the delta_size[] array.
> +        */
> +       if (!pack->delta_size)
> +               pack->delta_size =3D new_delta_size_array(pack);
> +       pack->delta_size[e - pack->objects] =3D size;
> +       packing_data_unlock(pack);
>  }
>
>  #endif
> diff --git a/t/README b/t/README
> index 8373a27fea..9028b47d92 100644
> --- a/t/README
> +++ b/t/README
> @@ -315,6 +315,10 @@ packs on demand. This normally only happens when the=
 object size is
>  over 2GB. This variable forces the code path on any object larger than
>  <n> bytes.
>
> +GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncomon pack-objects code
> +path where deltas larger than this limit require extra memory
> +allocation for bookkeeping.
> +
>  Naming Tests
>  ------------
>
> --
> 2.18.0.rc2.476.g39500d3211

Missing the 2.18.0 tag?  ;-)
