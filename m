Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90D9C433E2
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAD620758
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="yp3fgHiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgGMTWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgGMTWx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:22:53 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46538C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:22:53 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i3so10875043qtq.13
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HBJFySI9yJbOAil86avcecTkjfTOdzx7kOu8zAky6Q4=;
        b=yp3fgHiJbkuAlhzs2cydBxLndfE5cBrYOR5Try2P09E9qcCpCMUDH80BrWcHva7dXn
         xtjH7O1ObkT7yFNMk7SiLa7d5S2Vat6DHil/9J5v9RJ4Z70WH2JlCH6NDchaJokT1bc2
         tVbLHLzSDoHpnf4YzGOtdXHwEbv5zpv955V2RXDN/SfS487jz6+xbmsX/AvRg5yugAlf
         UdDgb9veH57FdpSmuAQldgiW9jM5MNh4j+zmzQwSaXslDDjV8wPkZ+6n6+aleopwX2pq
         +b3FrCUwdmUPU8bly0MsGLMekoukkbDtds/Yls8wcn/EUsuzdW9G70mlUPDm/lhiPeRK
         mCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HBJFySI9yJbOAil86avcecTkjfTOdzx7kOu8zAky6Q4=;
        b=VIqYhpc5FDdimJeT9alRsTP0v9nhSFIYlZpeY3xVVY9NzVzd0sIFy13ZIPQ6TyqVNb
         24iwGJ+gqDNg9m942vaazRELOGwWKNq9GHksVLME9GnppA/7cD+vydW2V26f5r7fDSxs
         zB1FNqq6ZMjd+Y0tpr8mnQFBvwgG3zmI7VjVBZphYezlYSnNI5toFP75QtqDOxVjF0uw
         XKLunaWq8EeTsK7RVZujPpa+xpe+QKYDCZEVd0/PGu9JaypWJXJLwSoWeorVTz25U3Jk
         4l4A6bo761i35IyR6yU99qamBEspIcy4jikvC/S8zmIpcWwMsdRzDei6RPt4s63m9RQO
         ZQrg==
X-Gm-Message-State: AOAM530qeJOdaUje1xb71Lk/yewcXM/wdo0eMphQbs1Cq64THjHbMo/Q
        azP444LdGb+CB0yKnr7Vv/6SbA==
X-Google-Smtp-Source: ABdhPJxQOXQmIN0R33V1w8PXU6pWTdk1nQ/W514X8UXNtjphTI8sYre3zcylKkBFhUOtFAl8O+7fSA==
X-Received: by 2002:ac8:431b:: with SMTP id z27mr954095qtm.5.1594668172414;
        Mon, 13 Jul 2020 12:22:52 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7dfb:38dc:7c85:86a3])
        by smtp.gmail.com with ESMTPSA id y23sm20363520qkj.25.2020.07.13.12.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:22:51 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:22:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     peff@peff.net, dstolee@microsoft.com, git@vger.kernel.org,
        me@ttaylorr.com
Subject: Re: [PATCH 3/3] commit-graph: respect 'core.useBloomFilters'
Message-ID: <20200713192250.GB77607@syl.lan>
References: <CAL3xRKdZyE+9r-bPTDo_Fiz=nT_Y7uve+rvBqQZxjL-DYMGYpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL3xRKdZyE+9r-bPTDo_Fiz=nT_Y7uve+rvBqQZxjL-DYMGYpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 01, 2020 at 11:58:53AM +0200, Son Luong Ngoc wrote:
> Hi folks,
>
> On Tue, 30 Jun 2020 15:33:40 -0400, Jeff King wrote:
>
> > > > It might even be worth considering whether "changed paths" needs more
> > > > context (or would if we add new features in the future). On a "git
> > > > commit-graph write" command-line it is perfectly clear, but would
> > > > core.commitGraphChangedPaths be worth it? It's definitely more specific,
> > > > but it's also way more ugly. ;)
> > >
> > > Here's a third option what about 'graph.readChangedPaths'. I think that
> > > Stolee and I discussed a new top-level 'graph' section, since we now
> > > have a few commit-graph-related configuration variables in 'core'.
> >
> > Yes, I like that even better. Probably "graph" is sufficiently specific
> > within Git's context, though I guess it _could_ bring to mind "git log
> > --graph". So many overloaded terms. :)
>
> I would suggest using 'commitgraph.readChangedPaths' as I was planning on
> implementing the same config in [1] but never got around to it.
>
> From an end-user perspective, not server admin, 'graph' is very much
> correlated to 'git log --graph'.

Do users really correlate the top-level 'graph.*' configuration with
options *just* related to 'git log --graph'? I find this unlikely, but I
would welcome the opinions of others, too.

> Using 'commitgraph' instead of core could also help us enabling more config
> down the line that equate to the current options in 'git commit-graph write'.
>
> I.e. something like 'commitgraph.writeSplit' might be desirable to tune the
> behavior of 'gc.writeCommitGraph' to use '--split=replace' strategy.
>
> ---
>
> @Taylor: Thanks a lot for implementing this.
>
> On Tue, 30 Jun 2020 13:17:36 -0400, Taylor Blau wrote:
>
> > We're planning on using these patches as part of a two-phase roll-out of
> > changed-path Bloom filters, where the first phase conditions whether or
> > not repositories *write* Bloom filters, and the second phase (controlled
> > via the new 'core.useBloomFilters') controls whether repositories *read*
> > their Bloom filters.
>
> Could you elaborate a bit more on the 'two-phase roll-out' mentioned here?

Sure. What I am referring to is the ability to control independently
which repositories write Bloom filters during commit-graph generation
(via some background jobs, the details of which are unimportant), and
which repositories read Bloom filters when, for eg. running 'git log' or
similar.

This allows us to quickly recover from any sort of bug in, say, 'git
log's use of Bloom filters without having to drop the (otherwise
correct) Bloom filters from disk. In other words, it allows us to
pretend that they are not there.

> I was looking for a way to verify whether a commit-graph chain has been
> written with Bloom filter (and force it to rewrite if not) but there seems
> to be no straightforward way?

No, 'git commit-graph verify' does not deal with Bloom filters for now.
It may be worthwhile to add that functionality, though.

> Do we need to implement a flag in 'git commit-graph verify' to check
> for Bloom filter existence?

Checking for existence would be one thing. More helpful would be
regenerating those Bloom filters and checking that we get the same
result. Allowing the caller to specify which one would be helpful, too.

Thanks.

> [1]: https://github.com/gitgitgadget/git/pull/633
>
> Regards,
> Son Luong.

Thanks,
Taylor
