Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9C071F424
	for <e@80x24.org>; Sun, 22 Apr 2018 12:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeDVMjA (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 08:39:00 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:46324 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeDVMi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 08:38:57 -0400
Received: by mail-ot0-f176.google.com with SMTP id v64-v6so14331176otb.13
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fhEHe9Xo+vbYcSJyGchyRbSmd/yBp7Tb9mhQeK1/9Sc=;
        b=tlrt9AH1zwfX/NtRJktLfZJyKZC2d6KAteNb8sTTc0F1P3FGO/dEoxOMNpVQACqo/9
         S3uhxzzrMDAS0rG7Mj3vgVBAdL+mxUkK7dj4/yotor310LOJIWxY64SHZMrb0q2KRdG0
         OGCA+u5HoNxCg+KzYssNZXoxJJmXf3OuRQIZcPoUDTa4xg/+jgpwVMEHjad0wuJoAl8R
         pfdwvNzsmAIH5/GO6awSc6ZyRCfCQrk0BbRAjSesZRIF3uO9qXO3/lBHAdd7Opa7wGPC
         rwlSATJeAShjlBvuRDXw1qWXmO1agXlwb/1n5j+b6AlEwaTnYKbssyYyke8Qi4QDQq6m
         S3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fhEHe9Xo+vbYcSJyGchyRbSmd/yBp7Tb9mhQeK1/9Sc=;
        b=UxZSxNDXOCm0C88oEqzwD5nGRB3gZKyo7X9b9+53kuPi8bbueefFvG3MegIGof7vi0
         O2pDSVbFTSSLjIQndtBZnA4ffcN71+HJxxKaoDjtfavo6OBzCemWPjeuEOX842+35byz
         e29SdRwD6eowRMUM4xAcW1DVq3UanC6JnZiudAz3ebS73OmxY+fF7yZoD5p901SIl0IJ
         5FIJbNDFE5zmuuCNX6/wnnMGlhwn16zAbL/Qjm0ELdDhXjbwCL0I9fhFLv3EOTgrZCFm
         vBBXF9C1DyZwYrDLPuclJQES7eq0c+DknLJuqd/zhYmuB3gymWIIbqPjUGT2/9ubbVvS
         YTNw==
X-Gm-Message-State: ALQs6tC2dMcHgU8DPjf40UUhocu8SS69H/pHdn45Xb38RB4m+fvpGjZ/
        k1ZGbJWVsoTppTyRW9mykMimHnphahWqlQkKMCw=
X-Google-Smtp-Source: AIpwx4/O8A1XYrkpssOdsSj+DOSGHlJMfU8FLKBKrpKRIPBYAfnOfIqdkMZDrn8FxPSKBGY4dtfTaQfKiVsOwwy8/b8=
X-Received: by 2002:a9d:369b:: with SMTP id h27-v6mr11859372otc.173.1524400736655;
 Sun, 22 Apr 2018 05:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sun, 22 Apr 2018 05:38:26 -0700 (PDT)
In-Reply-To: <20180421193736.12722-1-newren@gmail.com>
References: <20180420122355.21416-1-szeder.dev@gmail.com> <20180421193736.12722-1-newren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Apr 2018 14:38:26 +0200
Message-ID: <CACsJy8D4OYphLG5vStr+M9qkiqyH_LR517M-JOPS2wJeTFNGRg@mail.gmail.com>
Subject: Re: [RFC PATCH v10 32.5/36] unpack_trees: fix memory corruption with
 split_index when src != dst
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 9:37 PM, Elijah Newren <newren@gmail.com> wrote:
> Currently, all callers of unpack_trees() set o->src_index == o->dst_index.
> Since we create a temporary index in o->result, then discard o->dst_index
> and overwrite it with o->result, when o->src_index == o->dst_index it is
> safe to just reuse o->src_index's split_index for o->result.  However,
> o->src_index and o->dst_index are specified separately in order to allow
> callers to have these be different.  In such a case, reusing
> o->src_index's split_index for o->result will cause the split_index to be
> shared.  If either index then has entries replaced or removed, it will
> result in the other index referring to free()'d memory.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>
> I still haven't wrapped my head around the split_index stuff entirely, so
> it's possible that
>
>   - the performance optimization isn't even valid when src == dst.  Could
>     the original index be different enough from the result that we don't
>     want its split_index?

This really depends on the use case of course. But when git checkout
is used for switching branches, unpack-trees will be used and unless
you switch between to vastly different branches, the updated entries
may be small compared to the entire index that sharing is still good.
If the result index is so different that it results in a huge index
file anyway, I believe we have code to recreate a new shared index to
keep its size down next time.

>   - there's a better, more performant fix or there is some way to actually
>     share a split_index between two independent index_state objects.

A cleaner way of doing this would be something to the line [1]

    move_index_extensions(&o->result, o->dst_index);

near the end of this function. This could be where we compare the
result index with the source index's shared file and see if it's worth
keeping the shared index or not. Shared index is designed to work with
huge index files though, any operations that go through all index
entries will usually not be cheap. But at least it's safer.

> However, with this fix, all the tests pass both normally and under
> GIT_TEST_SPLIT_INDEX=DareISayYes.  Without this patch, when
> GIT_TEST_SPLIT_INDEX is set, my directory rename detection series will fail
> several tests, as reported by SZEDER.

Yes, the change looks good.

[1] To me the second parameter should be src_index, not dst_index.
We're copying entries from _source_ index to "result" and we should
also copy extensions from the source index. That line happens to work
only when dst_index is the same as src_index, which is the common use
case so far.

>  unpack-trees.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 79fd97074e..b670415d4c 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1284,9 +1284,20 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>         o->result.timestamp.sec = o->src_index->timestamp.sec;
>         o->result.timestamp.nsec = o->src_index->timestamp.nsec;
>         o->result.version = o->src_index->version;
> -       o->result.split_index = o->src_index->split_index;
> -       if (o->result.split_index)
> +       if (!o->src_index->split_index) {
> +               o->result.split_index = NULL;
> +       } else if (o->src_index == o->dst_index) {
> +               /*
> +                * o->dst_index (and thus o->src_index) will be discarded
> +                * and overwritten with o->result at the end of this function,
> +                * so just use src_index's split_index to avoid having to
> +                * create a new one.
> +                */
> +               o->result.split_index = o->src_index->split_index;
>                 o->result.split_index->refcount++;
> +       } else {
> +               o->result.split_index = init_split_index(&o->result);
> +       }
>         hashcpy(o->result.sha1, o->src_index->sha1);
>         o->merge_size = len;
>         mark_all_ce_unused(o->src_index);
> --
> 2.17.0.296.gaac25b4b81
>



-- 
Duy
