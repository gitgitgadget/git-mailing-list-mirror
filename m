Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792BC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 03:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838712078A
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 03:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="1WuFg5Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394015AbgJPDSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 23:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394007AbgJPDSt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 23:18:49 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2780C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 20:18:48 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t12so1113154ilh.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 20:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A8zYVkPWY8ZVue6hcR7zikCL3fOu5uJBxyGupuuTGoE=;
        b=1WuFg5ZkIp7JLZAOYhBHjG3bEgvUU7F2oyKVjoKrQeFbDFXyl9NPE4gSm/Hk1LHiSP
         huKfJI9K1n8OBgbYuRJ64jTMDKOPHFDXDw58kK3O06z/2LSnruKvhC2mTbRp/1i8FX+r
         /9UrDVuedhCRxJqHu5I+dxSzP+hVsFcub4t4JUD4eHBV88RCF6T905IIwBJS5pylx+OS
         vC3bntCUn0mrOaB0LtDT4TReRf4p+aJ574a6d/YeSB1KEui2KsHpxzjl6qL+m89orlia
         1tivV3iHnlia3SdenKAGSLOjaJkgNnd2ebXTxHtY68niR1MmyHom7A3QN0phf7dFn5/r
         viag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A8zYVkPWY8ZVue6hcR7zikCL3fOu5uJBxyGupuuTGoE=;
        b=cHAOvxy+JjpgfMXV0BpSGQr9wz7ipMn13l7yTKyoi5zlbpOqOtsde3XwPK7hBW200g
         QAF/usALy/f1mKjs0AdT3xH/QmdqGO3PFHDgKbiqfIYdhYb3eUQJfvnEynF9gXvdyZUC
         YhBj2JPY+VUR0/w5S5ham/uvawxnCES8NKYqfCRHp0J/9h7Q0ktwtarRoLNHvYPArP5s
         P21Qud2KP+cL3eOTaXdPQXCpZ7Pjn0QzCexn4rtnqOjrf6sN6NUDY01H/jD8wiZyA/ZN
         pdXywPzrV7ultlAk3OAAo+0KpysL5LSZLtKwhWjTSjyQVslpjDh0oxqT99a4fp6X0Ngt
         O8LQ==
X-Gm-Message-State: AOAM532IM2yJfArxJPrH5NkY7bcN0OXnus3SIW/Vkdn6k5ltZVDGGvrz
        vM35cWmbOj6CxNkf1PSLAlXz9g==
X-Google-Smtp-Source: ABdhPJw25iuGgaVrhAYF2IZAVQCNV1+IXr8R1WzuxuLm4T6QEOIPwQsmuYa9MTCrtiiyI3FiKdxrGg==
X-Received: by 2002:a05:6e02:1392:: with SMTP id d18mr1224526ilo.196.1602818328068;
        Thu, 15 Oct 2020 20:18:48 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f8a1:4f77:4a56:23a7])
        by smtp.gmail.com with ESMTPSA id p4sm886538ilg.79.2020.10.15.20.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 20:18:46 -0700 (PDT)
Date:   Thu, 15 Oct 2020 23:18:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/10] commit-graph: persist existence of changed-paths
Message-ID: <20201016031844.GA2181783@nand.local>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
 <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
 <f1e3a8516ebd58b283166a5374843f5cb3332d08.1593610050.git.gitgitgadget@gmail.com>
 <20201015132147.GB24954@szeder.dev>
 <20201015214111.GA2176154@nand.local>
 <103404f0-a164-2550-4730-6b8773d3ca1f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <103404f0-a164-2550-4730-6b8773d3ca1f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 10:18:47PM -0400, Derrick Stolee wrote:
> On 10/15/2020 5:41 PM, Taylor Blau wrote:
> > So, we need to be more aggressively checking the Bloom filter settings
> > in any layer we want to reuse a Bloom filter out of before reusing it
> > verbatim in the current layer. The patch below the scissors line is
> > sufficient to do that, and it causes the third test to start passing.
>
> I think there are three things we should keep in mind:
>
> 1. Incompatible Bloom filter settings between layers should be seen
>    as _inconsistent data_ as Git should not be writing incremental
>    commit-graph files with inconsistent Bloom filter settings. Thus,
>    when reading the commit-graph chain we should prevent incompatible
>    filters from being used. One way to do this is to notice different
>    settings and completely disable Bloom filters. The other way would
>    be to take the settings from the first layer with filters and then
>    clear the chunk_bloom_indexes and chunk_bloom_data fields for the
>    layers that don't agree. This fits with an expectation that lower
>    layers are larger, so more filters can be used in that situation.

Sure; I'd be fine with only allowing filters computed with the settings
present in the lowest or largest layer in the event that multiple layers
exist with incompatible settings.

I'm trying to point us towards a direction of not optimizing too far
along a direction that we're unlikely to take, while also trying to do
something relatively non-invasive to make it possible for a version of
Git to change the default Bloom settings. That is, if a user is writing
split commit-graphs, and we change the default Bloom settings, they
shouldn't have to recompute or merge down all of their Bloom filters.

If that's something that we never think is going to happen, I'm fine
with not thinking too hard about it. But, I also don't want to paint
ourselves into a corner, so I think something like the patch I wrote in
the email that you're replying to actually may be worth pursuing
further. I dunno. Definitely after 2.29, though.

> 2. We should be sure that Git will not agree to write incompatible
>    settings between layers of a commit-graph chain. Even more, it
>    should definitely not re-use filters when merging layers with
>    incompatible filter values. The strategy above to ignore Bloom
>    filters in incompatible upper layers is enough of a guard against
>    the "merge layers" situation.

Yeah, this would be fine with me.

> 3. Allowing users (or future Git developers) to adjust the default
>    Bloom filter settings is one that is good to do for future-proofing,
>    but not one that I expect to be widely used (any gains here are
>    minuscule compared to the results already achieved with the defaults).
>    On top of that, including incompatible settings across layers is even
>    less likely to be a real use case. We should not be straining to make
>    the code even worse for this imaginary scenario.

Right, I think we're pretty much in agreement here. Doing something easy
to make sure that we don't run into a wall seems to make sense, but I
think modifying the revision walk machinery to keep track of multiple
Bloom keys computed with different settings corresponding to the set of
Bloom filter settings in commit-graph layers is probably too far in that
direction.

For what it's worth, I was mainly talking about it to say that it would
be more effort than it's probably worth to do. There's also nothing that
we're currently discussing that would prevent us from taking that same
direction up in six months from now.

Thanks,
Taylor
