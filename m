Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E969C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819402063A
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgF2Sp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:45:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:45226 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbgF2SpY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:45:24 -0400
Received: (qmail 3795 invoked by uid 109); 29 Jun 2020 18:45:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jun 2020 18:45:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15321 invoked by uid 111); 29 Jun 2020 18:45:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jun 2020 14:45:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jun 2020 14:45:22 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@yhbt.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: `seen' datapoint [
Message-ID: <20200629184522.GA1248738@coredump.intra.peff.net>
References: <xmqqimfid2l1.fsf@gitster.c.googlers.com>
 <20200628192227.GA20227@dcvr>
 <xmqqy2o6fyxl.fsf@gitster.c.googlers.com>
 <20200629020427.GA8153@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629020427.GA8153@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 29, 2020 at 02:04:27AM +0000, Eric Wong wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Wong <e@yhbt.net> writes:
> > 
> > > So I had receive.denyNonFastforwards=true set, and a
> > > special cases for `pu':
> > >
> > > 	fetch = +refs/heads/pu:refs/remotes/origin/pu
> > 
> > Hmph.  I thought receive.denyNonFastforwards was for pushing into
> > the repository, so it is a bit puzzling that you bring up "only
> > updates to fetch into 'pu' is allowed to be forced" like this.
> > Such an arrangement would let you know when 'next' got rewound,
> > which is another plus ;-)
> 
> Yeah, I can't recall when I started using denyNonFastforwards;
> but it was probably a paranoid thing to ensure I'd notice if
> `master' got rewound.

It definitely wouldn't do that, though. :) I suspect you dropped the "+"
from your refspec around the same time (which would do what you expect).

> > Do you have a separate "fetch" refspec for each of the ones you are
> > interested in?
> 
> Nope, I use the catch-all as you describe below
> 
> > Or "remote.origin.fetch = refs/heads/*:refs/remotes/origin/*" which
> > serves as the default catch-all (which overlaps with the "pu can be
> > fast forwarded" you showed---I don't recall how we designed such a
> > set-up to work offhand, so I am a bit curious) works as a natural
> > "require fast-forward in general, but a more specific rule about
> > 'pu' allows non-fast-forward updates"?
> 
> I only have `+' entries for `next' and `seen',
> the catch-all provides the rest.
> 
> 	fetch = +refs/heads/seen:refs/remotes/origin/seen
> 	fetch = +refs/heads/next:refs/remotes/origin/next
> 	fetch = refs/heads/*:refs/remotes/origin/*

I think you probably configured (or modified) that catch-all yourself.
Both "git remote add" and "git clone" use a "+" in the refspecs they
configure.

-Peff
