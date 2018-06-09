Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C371F403
	for <e@80x24.org>; Sat,  9 Jun 2018 17:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeFIRIG (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 13:08:06 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35038 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbeFIRIF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 13:08:05 -0400
Received: by mail-oi0-f68.google.com with SMTP id e8-v6so14536363oii.2
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7q7bPeXEFj5bDyc4lAY+DkOzYDZTQu19yCgvloI7Bs=;
        b=UiffegzLBQh94Vohe5XxtA5uOZSbUZ+Nlpn8wg8hZ+H8McUQTYKqPlEINnhnkzIN6O
         nLTF3FvF0K/e178+vOaJcloFZjsEgC9UVQWBnrk+RdizPpsPijcRbZfWqArDG1UIqlm1
         pwXguwElzzjxM3NTy4CwyWCE8M3sl9VX/eRkSAf2lk9bMH57mFs0B7uL1fnP6Z1WRJEL
         kk44L85a4diX88yeRuCTC+DPw3GOuCfO1tbhrZrYiCGqEvKVE1VwH0CRHQvsubzxYDp6
         tVHSFGLIBh+wniY7GshkIemWd2HzZcEZE/yA79QOhY7kvqAnupHwct28fWJb+HWblbwB
         UGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7q7bPeXEFj5bDyc4lAY+DkOzYDZTQu19yCgvloI7Bs=;
        b=E6u3WwYxgUiRS+RjOamTqf/ZLOlaeeKl2+++xHAud37cAd5kpmO+RRDH542HuDhBJR
         NlHe/qLbMrC/xSar3mKSI70rvY2ns+rf2nMfNwkAnS69Om5awZDrSsLMIZc3PPo9NNlJ
         BaZAogGFio1nbz3Vka6OWHPn5mjzpl6yowNkTEYo+MgYlFIHf/Gro/C6WZKjm9D4Aiv8
         9JaqgjbEyn3f2zvw4x0HLncBOOQYYpEUgTE6jGZ09XN1RLReCRqL/1WlIKVQN8bqozDM
         iLpWdn5Fn0E2DP6adNFzUZLPctKd+R7sqf0S5y4VeODhahZqnJRKWCyYK4wwKxHsrAQp
         zLxw==
X-Gm-Message-State: APt69E2hldPrUrbylaVq1NBGeusW/VMQ/cYuWWro6s8NWrbPvQw5+IRw
        4j+/l4MRZ2Z8eSzDwItlhnaP4V1BNHCynm/ZgHo=
X-Google-Smtp-Source: ADUXVKKeuEaXqnVlvNNCUC8d9lirTWb7fnp9Krb43AZ9dwXyUOVpv3GXXh1HR92XRQetqOiUApO+L+qRgyS8TvMiWIs=
X-Received: by 2002:aca:52c5:: with SMTP id g188-v6mr5712048oib.228.1528564085017;
 Sat, 09 Jun 2018 10:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-12-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-12-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 19:07:38 +0200
Message-ID: <CACsJy8CJ0GNkciHVVUm_7a_MtG5RnZSWpV_zNAwtvMR8aRq42A@mail.gmail.com>
Subject: Re: [PATCH 11/23] midx: sort and deduplicate objects from packfiles
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 4:06 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Before writing a list of objects and their offsets to a multi-pack-index
> (MIDX), we need to collect the list of objects contained in the
> packfiles. There may be multiple copies of some objects, so this list
> must be deduplicated.

Can you just do merge-sort with a slight modification to ignore duplicates?

>
> It is possible to artificially get into a state where there are many
> duplicate copies of objects. That can create high memory pressure if we
> are to create a list of all objects before de-duplication. To reduce
> this memory pressure without a significant performance drop,
> automatically group objects by the first byte of their object id. Use
> the IDX fanout tables to group the data, copy to a local array, then
> sort.
>
> Copy only the de-duplicated entries. Select the duplicate based on the
> most-recent modified time of a packfile containing the object.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>
> diff --git a/midx.c b/midx.c
> index 923acda72e..b20d52713c 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -4,6 +4,7 @@
>  #include "csum-file.h"
>  #include "lockfile.h"
>  #include "object-store.h"
> +#include "packfile.h"
>  #include "midx.h"
>
>  #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
> @@ -190,6 +191,140 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
>         }
>  }
>
> +static uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
> +{
> +       const uint32_t *level1_ofs = p->index_data;
> +
> +       if (!level1_ofs) {
> +               if (open_pack_index(p))
> +                       return 0;
> +               level1_ofs = p->index_data;
> +       }
> +
> +       if (p->index_version > 1) {
> +               level1_ofs += 2;
> +       }
> +
> +       return ntohl(level1_ofs[value]);
> +}

Maybe keep this in packfile,c, refactor fanout code in there if
necessary, keep .idx file format info in that file instead of
spreading out more.

> +
> +struct pack_midx_entry {
> +       struct object_id oid;
> +       uint32_t pack_int_id;
> +       time_t pack_mtime;
> +       uint64_t offset;
> +};
> +
> +static int midx_oid_compare(const void *_a, const void *_b)
> +{
> +       struct pack_midx_entry *a = (struct pack_midx_entry *)_a;
> +       struct pack_midx_entry *b = (struct pack_midx_entry *)_b;

Try not to lose "const" while typecasting.

> +       int cmp = oidcmp(&a->oid, &b->oid);
> +
> +       if (cmp)
> +               return cmp;
> +
> +       if (a->pack_mtime > b->pack_mtime)
> +               return -1;
> +       else if (a->pack_mtime < b->pack_mtime)
> +               return 1;
> +
> +       return a->pack_int_id - b->pack_int_id;
> +}
> +
> +static void fill_pack_entry(uint32_t pack_int_id,
> +                           struct packed_git *p,
> +                           uint32_t cur_object,
> +                           struct pack_midx_entry *entry)
> +{
> +       if (!nth_packed_object_oid(&entry->oid, p, cur_object))
> +               die("failed to located object %d in packfile", cur_object);

_()

> +
> +       entry->pack_int_id = pack_int_id;
> +       entry->pack_mtime = p->mtime;
> +
> +       entry->offset = nth_packed_object_offset(p, cur_object);
> +}
> +
> +/*
> + * It is possible to artificially get into a state where there are many
> + * duplicate copies of objects. That can create high memory pressure if
> + * we are to create a list of all objects before de-duplication. To reduce
> + * this memory pressure without a significant performance drop, automatically
> + * group objects by the first byte of their object id. Use the IDX fanout
> + * tables to group the data, copy to a local array, then sort.
> + *
> + * Copy only the de-duplicated entries (selected by most-recent modified time
> + * of a packfile containing the object).
> + */
> +static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
> +                                                 uint32_t *perm,
> +                                                 uint32_t nr_packs,
> +                                                 uint32_t *nr_objects)
> +{
> +       uint32_t cur_fanout, cur_pack, cur_object;
> +       uint32_t nr_fanout, alloc_fanout, alloc_objects, total_objects = 0;
> +       struct pack_midx_entry *entries_by_fanout = NULL;
> +       struct pack_midx_entry *deduplicated_entries = NULL;
> +
> +       for (cur_pack = 0; cur_pack < nr_packs; cur_pack++) {
> +               if (open_pack_index(p[cur_pack]))
> +                       continue;

Is it a big problem if you fail to open .idx for a certain pack?
Should we error out and abort instead of continuing on? Later on in
the second pack loop code when get_fanout return zero (failure), you
don't seem to catch it and skip the pack.

> +
> +               total_objects += p[cur_pack]->num_objects;
> +       }
> +
> +       /*
> +        * As we de-duplicate by fanout value, we expect the fanout
> +        * slices to be evenly distributed, with some noise. Hence,
> +        * allocate slightly more than one 256th.
> +        */
> +       alloc_objects = alloc_fanout = total_objects > 3200 ? total_objects / 200 : 16;
> +
> +       ALLOC_ARRAY(entries_by_fanout, alloc_fanout);
> +       ALLOC_ARRAY(deduplicated_entries, alloc_objects);
> +       *nr_objects = 0;
> +
> +       for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
> +               nr_fanout = 0;

Keep variable scope small, declare nr_fanout here instead of at the
top of the function.

> +
> +               for (cur_pack = 0; cur_pack < nr_packs; cur_pack++) {
> +                       uint32_t start = 0, end;
> +
> +                       if (cur_fanout)
> +                               start = get_pack_fanout(p[cur_pack], cur_fanout - 1);
> +                       end = get_pack_fanout(p[cur_pack], cur_fanout);
> +
> +                       for (cur_object = start; cur_object < end; cur_object++) {
> +                               ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
> +                               fill_pack_entry(perm[cur_pack], p[cur_pack], cur_object, &entries_by_fanout[nr_fanout]);
> +                               nr_fanout++;
> +                       }
> +               }
> +
> +               QSORT(entries_by_fanout, nr_fanout, midx_oid_compare);
> +
> +               /*
> +                * The batch is now sorted by OID and then mtime (descending).
> +                * Take only the first duplicate.
> +                */
> +               for (cur_object = 0; cur_object < nr_fanout; cur_object++) {
> +                       if (cur_object && !oidcmp(&entries_by_fanout[cur_object - 1].oid,
> +                                                 &entries_by_fanout[cur_object].oid))
> +                               continue;
> +
> +                       ALLOC_GROW(deduplicated_entries, *nr_objects + 1, alloc_objects);
> +                       memcpy(&deduplicated_entries[*nr_objects],
> +                              &entries_by_fanout[cur_object],
> +                              sizeof(struct pack_midx_entry));
> +                       (*nr_objects)++;
> +               }
> +       }
> +
> +       FREE_AND_NULL(entries_by_fanout);
> +       return deduplicated_entries;
> +}
> +
>  static size_t write_midx_pack_lookup(struct hashfile *f,
>                                      char **pack_names,
>                                      uint32_t nr_packs)
> @@ -254,6 +389,7 @@ int write_midx_file(const char *object_dir)
>         uint64_t written = 0;
>         uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
>         uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
> +       uint32_t nr_entries;
>
>         midx_name = get_midx_filename(object_dir);
>         if (safe_create_leading_directories(midx_name)) {
> @@ -312,6 +448,8 @@ int write_midx_file(const char *object_dir)
>         ALLOC_ARRAY(pack_perm, nr_packs);
>         sort_packs_by_name(pack_names, nr_packs, pack_perm);
>
> +       get_sorted_entries(packs, pack_perm, nr_packs, &nr_entries);

Intentional ignoring return value (and temporary leaking as a result)
should have a least a comment to acknowledge it and save reviewers
some head scratching. Or even better, just free it now, even if you
don't use it.

> +
>         hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
>         f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
>         FREE_AND_NULL(midx_name);
> --
> 2.18.0.rc1
>


-- 
Duy
