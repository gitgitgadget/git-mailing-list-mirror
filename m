Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253D21F403
	for <e@80x24.org>; Tue, 12 Jun 2018 09:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933163AbeFLJvY (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 05:51:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:42266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932639AbeFLJvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 05:51:23 -0400
Received: (qmail 26379 invoked by uid 109); 12 Jun 2018 09:51:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Jun 2018 09:51:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22284 invoked by uid 111); 12 Jun 2018 09:51:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Jun 2018 05:51:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2018 05:51:21 -0400
Date:   Tue, 12 Jun 2018 05:51:21 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: avoid looking at NULL blob->object
Message-ID: <20180612095121.GA27181@sigill.intra.peff.net>
References: <20180609083159.GA6158@sigill.intra.peff.net>
 <CAN0heSqHRpOerHV8tgA-ntU6QvYQMxgrXPCPsrVcHLKUSwANXQ@mail.gmail.com>
 <20180609092135.GC6817@sigill.intra.peff.net>
 <CAN0heSqkcZ5KBpaq7R45A7wPxQ3F=6PKeHqwAQztdJyz31Vdwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqkcZ5KBpaq7R45A7wPxQ3F=6PKeHqwAQztdJyz31Vdwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 03:44:30PM +0200, Martin Ågren wrote:

> On 9 June 2018 at 11:21, Jeff King <peff@peff.net> wrote:
> > On Sat, Jun 09, 2018 at 10:50:36AM +0200, Martin Ågren wrote:
> >
> >> On 9 June 2018 at 10:32, Jeff King <peff@peff.net> wrote:
> >> > Except it _does_ do one non-trivial thing, which is call the
> >> > report() function, which wants us to pass a pointer to a
> >> > "struct object". Which we don't have (we have only a "struct
> >> > object_id"). So we erroneously passed the NULL object, which
> >>
> >> s/passed/dereferenced/? Probably doesn't affect the fix though.
> >
> > Well, we passed it, and then that function dereferenced it. :)
> >
> > I'm going to re-roll for the minor bits that Eric pointed out, so I'll
> > try to word this better.
> 
> My bad. I somehow thought we get into trouble already before we call
> `report()`. Well, we do, since we have undefined behavior. But for all
> practical purposes `&blob->object` and `blob` are the same
> (NULL-)pointer so we only crash after we call `report()`.
> 
> Anyway, obviously no need to do anything about this in a v3.

Ah, yeah, I didn't really think of it that way. But certainly you are
right that the moment we look at &blob->object, we are invoking
undefined behavior according to the standard.  Hopefully the wording
tweak I made covers both ways of thinking about it. :)

-Peff
