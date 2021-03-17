Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C8C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEC364F2A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhCQSDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhCQSDg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:03:36 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AC8C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:03:36 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso2633694ott.13
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4K9X5TlnmvhPD1QB+VFU7/x6H7VddyRv2pp2+1GOVa8=;
        b=I0/X9EUbSX8r2fTqOjlz/nokwFB+x1UBOHA6yw5JVOCmJh5oRXy3+pUe2Yxrju6Vmk
         5LEOC+pnEfs1pGnJE/J01MrEppjpCiUt0p5fsSkHIYTcv5d3zUJbTg7TFoc0kVQNrpTC
         ugggtDN0ke/38HwZYV+cllCf2S3T9hg2/+LGZ8K6L8NoVluc1pQ9FCpbG58gR/4mdLzM
         3y7KqHetn0eChqjrY9febNMNY0mn47ib/IpF2WKlZUAVRuwG+XckNXzyAz6GOKw/cXLk
         i+UIEqv4awscE2b1C4esZGahPkMFGU4JNEQ4S5qKDyysHtEfii5zOjf37oKbqaEn2NUQ
         6Qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4K9X5TlnmvhPD1QB+VFU7/x6H7VddyRv2pp2+1GOVa8=;
        b=kx8JlgsBn0c6m3d3iydu50RMtZLbePSsx07HxMEHveoIujJfJw8zsTS6mYSOLA9bz+
         raz6ywFuvc/cnNtquJ5tu6iFbKQh7NNjxkvbxjta7gCAbV1B2Ps+lwPLU3LZZPPbFmbs
         LyYLQ4CnbAdNwaQ99dFaLL9w56U0SDKWH+TLK7pkwjtel3tM4FyKKinPykiQnjnYP+t/
         IzjVYTW8fgjPIe9LN2JX4qQtL9PB2opWx0b8ZMBCx3OK81Px2X40zJ1CUwgT2+QE7OXq
         GmdusA0tuHcyXOMc1ezB0GsO7LK2dJM0j1+6P1d44E8cs68YCgtRLp4Eiw1ft+1dfjD9
         semQ==
X-Gm-Message-State: AOAM5335RFTWaUu4DynxAeogOhz0kgLJQHbaLJhByeWBz0NIkiqivdGZ
        RoHctX3dKNmxRQjmIWNOVQEtmhHAw2QNWgEfD9A=
X-Google-Smtp-Source: ABdhPJwhdt2uLxy8hUHI1bpHEzzq3x+NyKjK8fJ6wIneyVdmB9H+yUD8wSOqK5vAMxDZl6/1HU0RW2riOO7a1cjFwu4=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr4331565otf.345.1616004215634;
 Wed, 17 Mar 2021 11:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 11:03:24 -0700
Message-ID: <CABPp-BGfkPscpro=W5vcRHD5cV6pddYpvHLLzMWjL9WLaxyu3w@mail.gmail.com>
Subject: Re: [PATCH 00/27] Sparse Index: API protections
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Here is the second patch series submission coming out of the sparse-index
> RFC [1].
>
> [1]
> https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.com/
>
> This is based on v3 of the format series [2].
>
> [2]
> https://lore.kernel.org/git/pull.883.v3.git.1615912983.gitgitgadget@gmail.com/
>
> The point of this series is to insert protections for the consumers of the
> in-memory index. We mark certain regions of code as needing a full index, so
> we call ensure_full_index() to expand a sparse index to a full one, if
> necessary. These protections are inserted file-by-file in every loop over
> all cache entries. Well, "most" loops, because some are going to be handled
> in the very next series so I leave them out.
>
> Many callers use index_name_pos() to find a path by name. In these cases, we
> can check if that position resolves to a sparse directory instance. In those
> cases, we just expand to a full index and run the search again.
>
> The last few patches deal with the name-hash hashtable for doing O(1)
> lookups.
>
> These protections don't do much right now, since the previous series created
> the_repository->settings.command_requires_full_index to guard all index
> reads and writes to ensure the in-memory copy is full for commands that have
> not been tested with the sparse index yet.
>
> However, after this series is complete, we now have a straight-forward plan
> for making commands "sparse aware" one-by-one:
>
>  1. Disable settings.command_requires_full_index to allow an in-memory
>     sparse-index.
>  2. Run versions of that command under a debugger, breaking on
>     ensure_full_index().
>  3. Examine the call stack to determine the context of that expansion, then
>     implement the proper behavior in those locations.
>  4. Add tests to ensure we are checking this logic in the presence of sparse
>     directory entries.

I started reading the series, then noticed I didn't like the first few
additions of ensure_full_index().  The first was because I thought it
just wasn't needed as per a few lines of code later, but the more
important one that stuck out to me was another where if the
ensure_full_index() call is needed to avoid the code blowing up, then
the code has a good chance that it is doing something inherently wrong
in a sparse-checkout/sparse-index anyway.

So I guess that brings me to the question I asked in 07/27 -- is the
presence of ensure_full_index() a note that the code needs to be later
audited and tweaked to work with sparse-indexes?  If so, then good,
this series may make sense.  However, will that always be the case?
If we think some of these will be left in the code, is there a plan to
annotate each one that has been audited and determined that it needs
to stay?  If not, then each ensure_full_index() might or might not
have been audited for correctness and it becomes a pain to know what's
left to fix.  If the plan is that these are to be audited, and to be
marked if they are truly deemed necessary, then the series makes sense
to me.  If not, then I'm confused about something with the series and
need some help with the goals and plans.

If I'm confused about the goals and the plans, then my reviews will
probably be less than helpful, so I'll suspend reading the series
until I understand the plan a little better.
