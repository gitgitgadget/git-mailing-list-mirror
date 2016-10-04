Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511FC20986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbcJDVvn (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:51:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:52466 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbcJDVvn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:51:43 -0400
Received: (qmail 22961 invoked by uid 109); 4 Oct 2016 21:51:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 21:51:42 +0000
Received: (qmail 11288 invoked by uid 111); 4 Oct 2016 21:51:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 17:51:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 17:51:39 -0400
Date:   Tue, 4 Oct 2016 17:51:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 12/18] alternates: use a separate scratch space
Message-ID: <20161004215139.pi4xomnxzctb46vc@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203551.tmqp5rll6nqkewxz@sigill.intra.peff.net>
 <xmqqk2dnssz9.fsf@gitster.mtv.corp.google.com>
 <20161004213241.ihzkl7cohliavydg@sigill.intra.peff.net>
 <xmqq7f9nss1y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f9nss1y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 02:49:45PM -0700, Junio C Hamano wrote:

> >> It is not wrong per-se, but I am a bit surprised to see that the
> >> code keeps FLEX_ARRAY _and_ uses a separate malloc'ed area pointed
> >> at by the scratch pointer.
> >
> > Yeah, there's really no reason "path" could not become a non-flex
> > buffer. I mostly left it there out of inertia. If you have a preference,
> > I'm happy to change it.
> 
> My preference, before reaching the end of the series, actually was
> to overallocate just once and point with *scratch into path[] beyond
> the end of the fixed "where is the object directory?" string.
> 
> Of course, that would not mesh very well with the plan this series
> had after this step to use strbuf for keeping scratch ;-)  And the
> end result looks fine to me.

Heh, yeah, I did not think of that (because I had the strbuf end-game in
mind the whole time). I agree that would be nicer if we were keeping the
raw buffer, if only because one could free the whole thing in one shot
(OTOH, we do not ever free these structs at all :) ).

-Peff
