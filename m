Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9A91F516
	for <e@80x24.org>; Thu, 21 Jun 2018 17:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932964AbeFURyR (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 13:54:17 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37895 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbeFURyO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 13:54:14 -0400
Received: by mail-qk0-f195.google.com with SMTP id y4-v6so2246657qka.5
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ng7SsIEAriKWVJ9gf0NEveYZQzJVn4D+YDeTGPwLJ/g=;
        b=nV2DsiZ1q3YdAJG4CTIkPgZ3Ptwwxv+HCA/k3FGiozBUwW8oxXNwAazD32pApmOVWV
         qyG1NSpP0u1dlcVz30N6mvcIUV0A73vHko3Q/31QdQsnnQwxY4ixpog6+UnwWJ0Wh1aF
         dNz34GZ6+7Gu16xrnLcytI21x5bVYIwdwEotv4kffwU71hsjV7z3g6IHWG/5OV8jefLl
         uFksSGqyZ0TemkfUbjJT6H4FgthwduJKAItzpl3IqAB8JZCM7PoY109gICcMMOoyX2TV
         WdYLS6qawGUN7TqwBN9I7CAnYFpoFYqS4Qcus6Agcr/HyryoMeudhOsY4znYAg6deGlX
         liGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ng7SsIEAriKWVJ9gf0NEveYZQzJVn4D+YDeTGPwLJ/g=;
        b=j56AUmod7gT2xEw/1vrsfaUncIfouvN0nfh5HROIgeHo2qKg3B2V4DeuLWSRm5g+QG
         hnTMPZgZ4u5qZEeStcDjZIPltDJXExbkmw12hUXzA6GppoVZOHG/WqYfNkKDE+gfk5DM
         NUExlgVXN3wi4FwwUcgkeoWAo+uYlHsr5EPVqZi92qHeS+VSa72Qrpw1ONH0BFtdoKBc
         e4Sufn8/iiqKGvs+Yi2V43Zidknb+Ry8m0WeKWJoAL3CdmuG9lB5JrRLJrAml6+Ewipp
         vG5UEHJDATGRk8woGgI6bggRe1na3roM+5xbGvKpXjqu/6LUAO1p60Qsv822FH4e6vCl
         MuWA==
X-Gm-Message-State: APt69E2r7hV4P6lL3gB9cEEIdaZHhjDhKRyD7NiTbtx3biiLNxA1pOsu
        CW4naw8HVtTgq5MBSGzY3op07XvP
X-Google-Smtp-Source: ADUXVKIhEpXazB0XVe8p9CI5QFNi3pi1fDkNIQa2k3167YKvPPbg/yAx4f/AmZIJXDe4/q6yoKHglw==
X-Received: by 2002:a37:318f:: with SMTP id x137-v6mr21936533qkx.324.1529603653365;
        Thu, 21 Jun 2018 10:54:13 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:342c:51f1:bd43:3fe6? ([2001:4898:8010:0:1d62:51f1:bd43:3fe6])
        by smtp.gmail.com with ESMTPSA id n21-v6sm3358361qkl.34.2018.06.21.10.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:54:12 -0700 (PDT)
Subject: Re: [PATCH 11/23] midx: sort and deduplicate objects from packfiles
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-12-dstolee@microsoft.com>
 <CACsJy8CJ0GNkciHVVUm_7a_MtG5RnZSWpV_zNAwtvMR8aRq42A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dcd19f97-51de-8254-9977-56ad9a54cbb4@gmail.com>
Date:   Thu, 21 Jun 2018 13:54:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CJ0GNkciHVVUm_7a_MtG5RnZSWpV_zNAwtvMR8aRq42A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2018 1:07 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 4:06 PM Derrick Stolee <stolee@gmail.com> wrote:
>> Before writing a list of objects and their offsets to a multi-pack-index
>> (MIDX), we need to collect the list of objects contained in the
>> packfiles. There may be multiple copies of some objects, so this list
>> must be deduplicated.
> Can you just do merge-sort with a slight modification to ignore duplicates?

Are you proposing we consider a multi-way merge of the existing sorted 
lists of packfiles (skipping duplicates)? In my head, this would work 
this way:

1. Keep an array of positions within each of the pack-indexes for the 
"current lex-least OID not already in my sorted list"

2. Scan the list of P pack-indexes to find the lex-least OID among all 
candidates. Advance the position of that pack-index as we put that OID 
in the list (and advance the position of pack-indexes with duplicates).

This would have O(P * N) performance, where P is the number of packfiles 
and N is the total number of objects. This gets slightly better when 
there are duplicates; in the world where we have P identical lists of n 
objects, then N = n * P and we actually get N steps because we can 
advance the position on a duplicate value and not revisit duplicates. 
However, we do not expect duplicates in this density.

By adding some complexity to the algorithm, we could sort the 
pack-indexes in order of their lex-least OIDs, and update the order as 
we advance -- or rather use a min-heap to have access to the proper 
pack-index. This case is most likely to be valuable when updating a 
large MIDX by adding a list of smaller IDX files (which we expect to not 
be the "best" choice for most of the selections). I'm not sure the 
complexity is worth it (would need to measure!).

By concatenating the lists within the fanout values and sorting, we do 
256 sorts of size ~N/256, giving O(N * log(N/256)) performance. This 
method also has an extra array of size ~N/200 to store the batches, 
resulting in extra copies being pushed around.

You've convinced me that your approach may be better, especially in the 
typical case of adding a small number of packfiles to an existing MIDX 
file. Some work is needed to be sure it is better in general (such as 
reported cases of 5000 packfiles!). I'll leave a note to revisit this 
between v2 and v3.

>
>> It is possible to artificially get into a state where there are many
>> duplicate copies of objects. That can create high memory pressure if we
>> are to create a list of all objects before de-duplication. To reduce
>> this memory pressure without a significant performance drop,
>> automatically group objects by the first byte of their object id. Use
>> the IDX fanout tables to group the data, copy to a local array, then
>> sort.
>>
>> Copy only the de-duplicated entries. Select the duplicate based on the
>> most-recent modified time of a packfile containing the object.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   midx.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 138 insertions(+)
>>
>> diff --git a/midx.c b/midx.c
>> index 923acda72e..b20d52713c 100644
>> --- a/midx.c
>> +++ b/midx.c
>> @@ -4,6 +4,7 @@
>>   #include "csum-file.h"
>>   #include "lockfile.h"
>>   #include "object-store.h"
>> +#include "packfile.h"
>>   #include "midx.h"
>>
>>   #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
>> @@ -190,6 +191,140 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
>>          }
>>   }
>>
>> +static uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
>> +{
>> +       const uint32_t *level1_ofs = p->index_data;
>> +
>> +       if (!level1_ofs) {
>> +               if (open_pack_index(p))
>> +                       return 0;
>> +               level1_ofs = p->index_data;
>> +       }
>> +
>> +       if (p->index_version > 1) {
>> +               level1_ofs += 2;
>> +       }
>> +
>> +       return ntohl(level1_ofs[value]);
>> +}
> Maybe keep this in packfile,c, refactor fanout code in there if
> necessary, keep .idx file format info in that file instead of
> spreading out more.
>
>> +
>> +struct pack_midx_entry {
>> +       struct object_id oid;
>> +       uint32_t pack_int_id;
>> +       time_t pack_mtime;
>> +       uint64_t offset;
>> +};
>> +
>> +static int midx_oid_compare(const void *_a, const void *_b)
>> +{
>> +       struct pack_midx_entry *a = (struct pack_midx_entry *)_a;
>> +       struct pack_midx_entry *b = (struct pack_midx_entry *)_b;
> Try not to lose "const" while typecasting.
>
>> +       int cmp = oidcmp(&a->oid, &b->oid);
>> +
>> +       if (cmp)
>> +               return cmp;
>> +
>> +       if (a->pack_mtime > b->pack_mtime)
>> +               return -1;
>> +       else if (a->pack_mtime < b->pack_mtime)
>> +               return 1;
>> +
>> +       return a->pack_int_id - b->pack_int_id;
>> +}
>> +
>> +static void fill_pack_entry(uint32_t pack_int_id,
>> +                           struct packed_git *p,
>> +                           uint32_t cur_object,
>> +                           struct pack_midx_entry *entry)
>> +{
>> +       if (!nth_packed_object_oid(&entry->oid, p, cur_object))
>> +               die("failed to located object %d in packfile", cur_object);
> _()
>
>> +
>> +       entry->pack_int_id = pack_int_id;
>> +       entry->pack_mtime = p->mtime;
>> +
>> +       entry->offset = nth_packed_object_offset(p, cur_object);
>> +}
>> +
>> +/*
>> + * It is possible to artificially get into a state where there are many
>> + * duplicate copies of objects. That can create high memory pressure if
>> + * we are to create a list of all objects before de-duplication. To reduce
>> + * this memory pressure without a significant performance drop, automatically
>> + * group objects by the first byte of their object id. Use the IDX fanout
>> + * tables to group the data, copy to a local array, then sort.
>> + *
>> + * Copy only the de-duplicated entries (selected by most-recent modified time
>> + * of a packfile containing the object).
>> + */
>> +static struct pack_midx_entry *get_sorted_entries(struct packed_git **p,
>> +                                                 uint32_t *perm,
>> +                                                 uint32_t nr_packs,
>> +                                                 uint32_t *nr_objects)
>> +{
>> +       uint32_t cur_fanout, cur_pack, cur_object;
>> +       uint32_t nr_fanout, alloc_fanout, alloc_objects, total_objects = 0;
>> +       struct pack_midx_entry *entries_by_fanout = NULL;
>> +       struct pack_midx_entry *deduplicated_entries = NULL;
>> +
>> +       for (cur_pack = 0; cur_pack < nr_packs; cur_pack++) {
>> +               if (open_pack_index(p[cur_pack]))
>> +                       continue;
> Is it a big problem if you fail to open .idx for a certain pack?
> Should we error out and abort instead of continuing on? Later on in
> the second pack loop code when get_fanout return zero (failure), you
> don't seem to catch it and skip the pack.
>
>> +
>> +               total_objects += p[cur_pack]->num_objects;
>> +       }
>> +
>> +       /*
>> +        * As we de-duplicate by fanout value, we expect the fanout
>> +        * slices to be evenly distributed, with some noise. Hence,
>> +        * allocate slightly more than one 256th.
>> +        */
>> +       alloc_objects = alloc_fanout = total_objects > 3200 ? total_objects / 200 : 16;
>> +
>> +       ALLOC_ARRAY(entries_by_fanout, alloc_fanout);
>> +       ALLOC_ARRAY(deduplicated_entries, alloc_objects);
>> +       *nr_objects = 0;
>> +
>> +       for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
>> +               nr_fanout = 0;
> Keep variable scope small, declare nr_fanout here instead of at the
> top of the function.
>
>> +
>> +               for (cur_pack = 0; cur_pack < nr_packs; cur_pack++) {
>> +                       uint32_t start = 0, end;
>> +
>> +                       if (cur_fanout)
>> +                               start = get_pack_fanout(p[cur_pack], cur_fanout - 1);
>> +                       end = get_pack_fanout(p[cur_pack], cur_fanout);
>> +
>> +                       for (cur_object = start; cur_object < end; cur_object++) {
>> +                               ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
>> +                               fill_pack_entry(perm[cur_pack], p[cur_pack], cur_object, &entries_by_fanout[nr_fanout]);
>> +                               nr_fanout++;
>> +                       }
>> +               }
>> +
>> +               QSORT(entries_by_fanout, nr_fanout, midx_oid_compare);
>> +
>> +               /*
>> +                * The batch is now sorted by OID and then mtime (descending).
>> +                * Take only the first duplicate.
>> +                */
>> +               for (cur_object = 0; cur_object < nr_fanout; cur_object++) {
>> +                       if (cur_object && !oidcmp(&entries_by_fanout[cur_object - 1].oid,
>> +                                                 &entries_by_fanout[cur_object].oid))
>> +                               continue;
>> +
>> +                       ALLOC_GROW(deduplicated_entries, *nr_objects + 1, alloc_objects);
>> +                       memcpy(&deduplicated_entries[*nr_objects],
>> +                              &entries_by_fanout[cur_object],
>> +                              sizeof(struct pack_midx_entry));
>> +                       (*nr_objects)++;
>> +               }
>> +       }
>> +
>> +       FREE_AND_NULL(entries_by_fanout);
>> +       return deduplicated_entries;
>> +}
>> +
>>   static size_t write_midx_pack_lookup(struct hashfile *f,
>>                                       char **pack_names,
>>                                       uint32_t nr_packs)
>> @@ -254,6 +389,7 @@ int write_midx_file(const char *object_dir)
>>          uint64_t written = 0;
>>          uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
>>          uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
>> +       uint32_t nr_entries;
>>
>>          midx_name = get_midx_filename(object_dir);
>>          if (safe_create_leading_directories(midx_name)) {
>> @@ -312,6 +448,8 @@ int write_midx_file(const char *object_dir)
>>          ALLOC_ARRAY(pack_perm, nr_packs);
>>          sort_packs_by_name(pack_names, nr_packs, pack_perm);
>>
>> +       get_sorted_entries(packs, pack_perm, nr_packs, &nr_entries);
> Intentional ignoring return value (and temporary leaking as a result)
> should have a least a comment to acknowledge it and save reviewers
> some head scratching. Or even better, just free it now, even if you
> don't use it.
>
>> +
>>          hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
>>          f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
>>          FREE_AND_NULL(midx_name);
>> --
>> 2.18.0.rc1
>>
>

