Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF90DC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10D361002
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhFUUQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFUUQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:16:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D2C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:14:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id nb6so30711424ejc.10
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YUvuImzhRta6TibkAkbRO7+IGjuBVE8EXKyyWAxerFM=;
        b=tk1VUoj/sADh+MEyy8jJUDAxUUB8mrmzf/i2kLzKS7S5eW27OrZFmr4bbC6Mtl8fdy
         rH3gLH9cEoeSMSYhPV0kPdpOGTt0OlKP0FIBBBgXR9ftiuIhZEtk4mCtzIPyYyxiIQhe
         Qo0cvS6Rgm8kTK8KZANsSUmRZGbatsVw+cLHZ2aRLZgtleNo5+JHz1z4QHsitibXY9fG
         5ZTp+0+DCVyqGmjSYKWrL0v1hFlyy2/Ekhv00eIK++3boJfjXJCQKRhvoWxITWqbSCQS
         RvfTN4tyExTTHv0yQ2EbLNSlNB2aO8bixe01A4O6/HRa7HYofWY2WI0HqscAaBIOnl2F
         Cbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YUvuImzhRta6TibkAkbRO7+IGjuBVE8EXKyyWAxerFM=;
        b=AmM22PTYarfK5Y/Uo6g+Q8WrjNclPSngjuI+nmCjCWCUPO9MrLEDz0eNZZm+/UX+8g
         8+JDOSAMGOWUDpOaz9Pu/UWnD87/6dLGZWH4RjAhUZncxdWu9IcSK5sv7hnkMQnNxco8
         dx7u/OBqfFztjDnookByPGGFM7mohDj7wZ8ivt4dlq6wIr7ZFe7hv7/Ec70JKuLpMGzo
         97Sa4WbnPz88os+6p/TgH22CqcIhqMT/XTPOuAMuaHrPRW7LNdUrdZMPSc0EdI8Vz0as
         zCltfFf6R8Jc+r+kOxD/QspJqbMn1KY5A6xufXOGjXU1VJeYq2ctZrB4+Ow0yw83Ko2X
         NALw==
X-Gm-Message-State: AOAM533oP776n7ePQ/6ATgVIEZanJjPjNRj+Kxp0D24eEfFmzUBaxdPn
        5aoFJ1ZEPABzFceDB/EIybU=
X-Google-Smtp-Source: ABdhPJxbfa6TVzltu6hGyIj7O99ZXWevWLYCuMkQGMvpXXaGIeqel+RTh9YfYcL2uOwg6m9V1IW2PQ==
X-Received: by 2002:a17:906:39d7:: with SMTP id i23mr26613644eje.121.1624306460031;
        Mon, 21 Jun 2021 13:14:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jy6sm2219135ejc.21.2021.06.21.13.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:14:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
Date:   Mon, 21 Jun 2021 22:08:50 +0200
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-5-szeder.dev@gmail.com>
 <87a6nk41wy.fsf@evledraar.gmail.com>
 <f580c5c6-304c-24f4-535c-35025b6b4a80@web.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <f580c5c6-304c-24f4-535c-35025b6b4a80@web.de>
Message-ID: <87h7hr2cx0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Ren=C3=A9 Scharfe wrote:

> Am 21.06.21 um 00:13 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Sun, Jun 20 2021, SZEDER G=C3=A1bor wrote:
>>
>>> The final value of the counter of the "Scanning merged commits"
>>> progress line is always one less than its expected total, e.g.:
>>>
>>>   Scanning merged commits:  83% (5/6), done.
>>>
>>> This happens because while iterating over an array the loop variable
>>> is passed to display_progress() as-is, but while C arrays (and thus
>>> the loop variable) start at 0 and end at N-1, the progress counter
>>> must end at N.  This causes the failures of the tests
>>> 'fetch.writeCommitGraph' and 'fetch.writeCommitGraph with submodules'
>>> in 't5510-fetch.sh' when run with GIT_TEST_CHECK_PROGRESS=3D1.
>>>
>>> Fix this by passing 'i + 1' to display_progress(), like most other
>>> callsites do.
>>>
>>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>> ---
>>>  commit-graph.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/commit-graph.c b/commit-graph.c
>>> index 2bcb4e0f89..3181906368 100644
>>> --- a/commit-graph.c
>>> +++ b/commit-graph.c
>>> @@ -2096,7 +2096,7 @@ static void sort_and_scan_merged_commits(struct w=
rite_commit_graph_context *ctx)
>>>
>>>  	ctx->num_extra_edges =3D 0;
>>>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>>> -		display_progress(ctx->progress, i);
>>> +		display_progress(ctx->progress, i + 1);
>>>
>>>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>>>  			  &ctx->commits.list[i]->object.oid)) {
>>
>> I think this fix makes sense, but FWIW there's a large thread starting
>> at [1] where Ren=C3=A9 disagrees with me, and thinks the fix for this so=
rt of
>> thing would be to display_progress(..., i + 1) at the end of that
>> for-loop, or just before the stop_progress().
>>
>> I don't agree, but just noting the disagreement, and that if that
>> argument wins then a patch like this would involve changing the other
>> 20-some calls to display_progress() in commit-graph.c to work
>> differently (and to be more complex, we'd need to deal with loop
>> break/continue etc.).
>>
>> 1. https://lore.kernel.org/git/patch-2.2-042f598826-20210607T144206Z-ava=
rab@gmail.com/
>
> *sigh*  (And sorry, =C3=86var.)
>
> Before an item is done, it should be reported as not done.  After an
> item is done, it should be reported as done.  One loop iteration
> finishes one item.  Thus the number of items to report at the bottom of
> the loop is one higher than at the top.  i is the correct number to
> report at the top of a zero-based loop, i+1 at the bottom.
>
> There is another place: In the loop header.  It's a weird place for a
> function call, but it gets triggered before, between and after all
> items, just as we need it:
>
> 	for (i =3D 0; display_progress(ctx->progress), i < ctx->commits.nr; i++)=
 {
>
> We could hide this unseemly sight in a macro:
>
>   #define progress_foreach(index, count, progress) \
>   for (index =3D 0; display_progress(progress, index), index < count; ind=
ex++)

Anyone with more time than sense can go and read over our linked back &
forth thread where we're disagreeing on that point :). I think the pattern
in commit-graph.c makes sense, you don't.

Anyway, aside from that. I think, and I really would be advocating this
too, even if our respective positions were reversed, that *in this case*
it makes sense to just take something like SZEDER's patch here
as-is. Because in that file there's some dozen occurrences of that exact
pattern.

Let's just bring this one case in line with the rest, if we then want to
argue that one or the other use of the progress.c API is wrong as a
general thing, I think it makes more sense to discuss that as some
follow-up series that changes these various API uses en-masse than
holding back isolated fixes that leave the state of the progress bar it
!=3D 100%.
