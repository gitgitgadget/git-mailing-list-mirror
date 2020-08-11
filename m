Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603D3C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28765206B2
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="V95zaoBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKS6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKS6m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 14:58:42 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140C8C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 11:58:42 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so10247772qtn.7
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2oFYZ8Aygnqlh8o/ToK25iOjzNUrU4hzgPk1jq5wsw4=;
        b=V95zaoBpbI9uqey5SUx+eaaMRgFFV5zlNniubox/QHSrsGdpygdldV8sCYjskR1pON
         HN+JB6/jfoSFq4dtuOmlaPmCjd/8xdL0FSP+gMNUtBd7BVd9IyeZeALUqqHnVGgB4uX/
         NJPsZlp3iFQQFcr6dO3j49ET+RhB3fYrNxgSQlRhox+J2lGfdwu/dyIC8q4qg5WLcgPg
         zcgycyGJHka3fVx6y8b59SJjd8GwJFj3KbnCqsAK0e0a6eOYjXMlyyu2xIyoD1toZBME
         9VP8yVdllEreVDxMxY5hXKUkkFC7esPbtx/IDSnBROEGAbgscSCQQ/h8cI3yrtPL+wam
         N9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2oFYZ8Aygnqlh8o/ToK25iOjzNUrU4hzgPk1jq5wsw4=;
        b=HsR1Yjs18Zh/x4vcn7SlN+SPCcwe4wWlbfjaerVlXEE3DJdsg+GGY3IN5K4SUEPNLU
         J5niY0anqY5fV9HoaFNkJWIxk3vvrdwt9MAJWQhRCETYSQet/ThCDKAefYbnAoVtgrkz
         sVdNZu1B/Qhwz+ZiYSwYdkc844pnV6RAKXqJ0ehYvUlOLpHHtW7qG0kHQKumZN/nSYj7
         wMECbKk1kvQ93hG1XxfTeHDhblUS6w8MiDbEXvrbLMT5M+vaJ0++WC2W8tAL/ZJKQB3S
         NECtSjnXlFVQmzhoRGtue7OkXh+v3KiUaYwezbNw3SyvB5KguAnwrK1hwClJha54ubvL
         CnBw==
X-Gm-Message-State: AOAM533eVVnk0H/+4ew+D2kcfuaBXxdD3CRaSCljYQQpSj9/XnR6zTnk
        KsFI6cUxbEt3vj0J0ai0tOZgZA==
X-Google-Smtp-Source: ABdhPJxPQZyF65JgiYh00lO9t0I97eyIzrCsgX6rIhxQQc85N87D4hIkJF7qEy0JRJfK4Vsrl0vbkQ==
X-Received: by 2002:ac8:35f9:: with SMTP id l54mr2685311qtb.25.1597172321219;
        Tue, 11 Aug 2020 11:58:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id x29sm19820879qtv.80.2020.08.11.11.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 11:58:40 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:58:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     aee0ae56-3395-6848-d573-27a318d72755@gmail.com, jnareb@gmail.com,
        abhishekkumar8222@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        gitgitgadget@gmail.com
Subject: Re: [PATCH v2 05/10] commit-graph: implement generation data chunk
Message-ID: <20200811185839.GA34058@syl.lan>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <cb797e20d79e9dcd3e0b953e0db3ed1defb9aa7c.1596941625.git.gitgitgadget@gmail.com>
 <aee0ae56-3395-6848-d573-27a318d72755@gmail.com>
 <20200811110316.GA3220@Abhishek-Arch>
 <3c053281-f5af-1ac8-75ef-9eb8ce4f539d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c053281-f5af-1ac8-75ef-9eb8ce4f539d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 08:27:41AM -0400, Derrick Stolee wrote:
> On 8/11/2020 7:03 AM, Abhishek Kumar wrote:
> > On Mon, Aug 10, 2020 at 12:28:10PM -0400, Derrick Stolee wrote:
> >> Patches 5-7 could perhaps be reorganized as follows:
> >>
> >>   i. commit-graph: return 64-bit generation number, as-is.
> >>
> >>  ii. Add a topo_level slab that is parsed from CDAT. Modify
> >>      compute_generation_numbers() to populate this value and modify
> >>      write_graph_chunk_data() to read this value. Simultaneously
> >>      populate the "generation" member with the same value.
> >>
> >> iii. "commit-graph: implement corrected commit date" without any GDAT
> >>      chunk interaction. Make sure the algorithm in
> >>      compute_generation_numbers() walks commits if either topo_level or
> >>      generation are unset. There is a trick here: the generation value
> >>      _is_ set if the commit is parsed from the existing commit-graph!
> >>      Is this case covered by the existing logic to not write GDAT when
> >>      writing a split commit-graph file with a base that does not have
> >>      GDAT? Note that the non-split case does not load the commit-graph
> >>      for parsing, so the interesting case is "--split-replace". Worth
> >>      a test (after we write the GDAT chunk), which you have in "commit-graph:
> >>      handle mixed generation commit chains".
> >>
> >
> > Right, so at the end of this patch we compute corrected commit dates but
> > don't write them to graph file.
> >
> > Although, writing ii. and iii. together in the same patch makes more
> > sense to me. Would it be hard to follow for someone who has no context
> > of this discussion?
>
> It is always easier to combine two patches than to split one into two.
>
> With that in mind, I recommend starting with a split version and then
> seeing how each patch looks. I think that these are "independent enough"
> ideas that justify the separate patches.
>
> >>  iv. This patch, introducing the chunk and the read/write logic.
> >>
> >>   v. Add the remaining patches.
> >>
> >> Again, this is a complicated patch-reorganization. The hope is that
> >> the end result is something that is easy to review as well as something
> >> that produces an as-sane-as-possible history for future bisecters.
> >>
> >> Perhaps other reviewers have similar feelings, or can say that I am
> >> being too picky.
> >>
> >
> > I can see how the reorganization helps us avoid a rather nasty
> > situation to be in. Should not be too hard to reorganize.
>
> I hope not. Hopefully you get some more review on this version
> before jumping in on such a big reorg (in case someone else has
> a different opinion).

I think the direction makes sense. We should avoid having the dummy
implementation of the GDAT chunk in the interim if at all possible (and
it seems like it is). What Stolee is proposing is what I'd suggest, too.

Please let us know if you need any help restructuring these patches.
Please make sure to give them a careful review since it is easy to move
a hunk into the wrong commit, or let a detail in the patch text become
out-of-date. Looking over "git log -p origin/master..HEAD" and "git
rebase -x make -j8 DEVELOPER=1 test' origin/master" never hurts ;).

> Thanks,
> -Stolee

Thanks,
Taylor
