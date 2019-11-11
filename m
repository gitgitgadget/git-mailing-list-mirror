Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B608A1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 08:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfKKIKs (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 03:10:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:44268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726768AbfKKIKs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 03:10:48 -0500
Received: (qmail 17659 invoked by uid 109); 11 Nov 2019 08:10:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 08:10:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3783 invoked by uid 111); 11 Nov 2019 08:14:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 03:14:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 03:10:47 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 2/3] bundle-create: progress output control
Message-ID: <20191111081047.GA17861@sigill.intra.peff.net>
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
 <20191110204126.30553-1-robbat2@gentoo.org>
 <20191110204126.30553-2-robbat2@gentoo.org>
 <20191111040750.GB6379@sigill.intra.peff.net>
 <robbat2-20191111T065646-317702456Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <robbat2-20191111T065646-317702456Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 07:28:55AM +0000, Robin H. Johnson wrote:

> > Do we need all four of these?
> I copied the exact set of messages from git-pack-objects, and I do think
> the same set makes sense specifically to mirror pack-objects for the
> moment.

I'm not sure I agree. In what situation would anybody use "git bundle
create --all-progress-implied", for example? Literally no other Git
command except pack-objects has "--all-progress" or
"--all-progress-implied" (even ones which call pack-objects under the
hood to print the progress!), and the presence of the latter in
pack-objects is due to a backwards-compatibility thing in the early days
(where --all-progress did too many things, but we could no longer change
it). I think it would be a mistake to spread it further.

> I think there is a lot of room to improve the behavior here, but at the
> risk of breaking backwards compatibility on the existing options, I
> think this older set of options should consistent between this and
> pack-objects.

But now is the moment where we can do what we want without breaking
compatibility (since there aren't any progress options for git-bundle at
all yet).

I guess another way of thinking about it: why is "pack-objects" the
model for how its progress options should work, and not "send-pack"?
git-bundle is much closer to the latter in how users will invoke it.

> > Just saying "--no-progress" would do what you want right now. I could
> > understand the desire for a general "--quiet" flag that implies
> > "--no-progress", and shuts off any other non-progress chatter as well.
> > There isn't any now, but it could be a future proofing thing (plus
> > having a "-q" option is standard). But I think we should document it
> > that way from the outset (though I notice you probably just lifted this
> > from pack-objects, IMHO it should be more clear, too).
> Willing to do later series to add --no-progress to this &

You already added --no-progress (and it's already there in
pack-objects). It comes for free with OPT_SET_INT("progress").

-Peff
