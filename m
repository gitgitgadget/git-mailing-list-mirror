Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82E6A1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 13:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757436AbcIGNGx (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 09:06:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:54742 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757224AbcIGNGw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 09:06:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M0tr1-1avAdW0dbz-00v5QZ; Wed, 07 Sep 2016 15:06:37
 +0200
Date:   Wed, 7 Sep 2016 15:06:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [RFC/PATCH 0/2] more patch-id speedups
In-Reply-To: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609071453240.129229@virtualbox>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VAEZ+oFaz6XkumhYM5JF1RsuIaXPTTAHqakkEoHXLQ46+kk21CG
 UwBHiMkWkbIl9wq9Nty9Zmz4ZthhdUoFQya2Hs4Tp+5G5shwUn9IuLo1CxKTQzBbNE6g2I4
 sp5rI2i2tYJu71a0e9kPb+Fc+ozO26iVZuSmXuaXDvZ2N+ct7Sv1E1iyaBz2G+MXIU0WUge
 e5H0wfr8N83Oh3Gi6Edmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R/QjJlrW5xs=:Q1819EU+SkS8wFr0nvc6+p
 ON2jzLpbNxB8QwovEGGu+leMm/retj7zZSbrDnR4hzMr48nlJ3/OXs+2aR+smMdTy4QXM8IqI
 Z8lvS/kKThsYyzYBZphuUacFI4RwW4YqEyyBBczhe94cd/cDyIOUC6gvLUiATRGRwYtWDIweR
 y9JSvvSG39RTLA5VP+Inny9+X4Cs7FCP+GuSlui1XMPAr/Wf5Oe6KWHUobH46XgAzdAyJVOZY
 uiSog4FQoBPHk1fwO+XlTIvYmmkgjNeRNNNtWsIs5UqVoRMH2lodP91FXz1sy4p7wey1WuEdM
 V9pVc1K4NlpCFLENjU+0aNFt/rhce9VTXlcA2EhD+uaJ1RNL+VhpJtodXFhtxbS/v5gnU/Zaa
 V/51/QQfVCEvxflT6lttDF9rSJbJfDVVfs4fCaD9wdgkxTdCXUG8RGPOQgAAZYFiNnTjjV/o8
 pnjVJY1c2pb+y9RMLgajTdKYHpCWXNKZJv1Q1gPQYKpukJ0r5/knMC1eJn7rs5xVSY9NMf/4q
 nFd7jVOgTdgd8e0L7x7se+Ft8ZYmCN1JJjWDiaDUE2hjuV/PqF7bHjPdMoXy3pze4MrNe+Iz6
 /8bsEUfnTOcfz3mDQWmklp6h1++bWcgBmplODcbbufPTmhnlpmgTowbeMVWPDXm74ddceRTyW
 ImBNwNA8liVK7FLdCetkyzwOt+IaOAEj6s2j2EuImXIjpBU91u2sEtt1okJpxLc40ZTSN+X3J
 917mDxHQ5oIujav+tKxWGm7zltXUzDVKiv6S4WkmPImNfvBxTJU/t4J9l506ql+nuW5xJZ2gr
 X86qGjt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 7 Sep 2016, Jeff King wrote:

> Michael and I found a case where the "format-patch --cherry-pick A...B"
> command for a rebase took over 7 minutes to run with git v2.9.3. Yikes.
> 
> Switching to v2.10 dropped that to a bit over 3 minutes (due to the
> kw/patch-ids-optim topic). Better, but not great.

I agree: not great, but better...

> The culprit turned out to be merge commits; the patch-id code will
> happily diff a merge against its first parent, and ignore the rest. This
> _seems_ like a bad idea, but maybe there is something clever going on
> that I don't know about. I couldn't find anything useful in the history,
> and given that this code was adapted from rebase, my guess is that it
> was never really intended to handle merge commits in the first place (of
> course we weren't trying to rebase merge commits; but it has to generate
> patch-ids for everything that happened on "A" to compare against).
> 
> Dropping the computation of the merge commits got it down to about 4
> seconds. I also noticed that it was doing rename detection (which also
> seems like a bad idea). Disabling renames dropped another half second or
> so.

That makes for a really nice improvement!

> This is marked as "RFC" because I don't feel entirely confident that I'm
> not missing some clever need for these options. But in both cases my gut
> feeling is that they are simply unintended effects that nobody ever
> noticed, because it would be very rare that they would affect the
> output. And that if they _did_ affect the output, they would probably be
> doing the wrong thing.

Given that the patch ID is *wrong* for merge commits (it only looks at the
first parent, so each "-s ours" merge will have the same patch ID!), I
would say that we can get away with re-defining the patch ID of merge
commits.

The only case where it might change things that I can think of would be a
`git rebase --preserve-merges`: it would probably have worked *by chance*
before (or not, in case of "-s ours" merges), and now it would try to pick
the merge commits even if rebased versions were already merged upstream.

If I read the --preserve-merges code correctly, that would result in the
merge commit's parents to be 'rewritten' to HEAD. And as both parents
would be rewritten to HEAD, they would be condensed into a single new
parent, resulting in a cherry-pick that fails (because it tries to
cherry-pick a merge commit without any -n option).

Of course, what we could do is to introduce a modifier, e.g.
--cherry-pick=first-parent, that would trigger the old behavior and would
be asked-for in the --preserve-merges mode.

But quite frankly, personally I would not worry about it *that* much. As
you pointed out, the patch ID for merge commits is incorrect to begin
with, and we may just redeclare all merge commits to be incomparable to
one another when it comes to patch IDs.

In short: I would be fine with the change of behavior.

Ciao,
Dscho
