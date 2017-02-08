Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7631FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 19:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdBHTKV (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 14:10:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:51684 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbdBHTJp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 14:09:45 -0500
Received: (qmail 20915 invoked by uid 109); 8 Feb 2017 19:09:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 19:09:01 +0000
Received: (qmail 18170 invoked by uid 111); 8 Feb 2017 19:09:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 14:09:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 14:08:58 -0500
Date:   Wed, 8 Feb 2017 14:08:58 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
Message-ID: <20170208190858.rjoqehbhyizlwg5q@sigill.intra.peff.net>
References: <1481922331.28176.11.camel@frank>
 <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
 <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
 <1486515795.1938.45.camel@novalis.org>
 <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
 <1486542299.1938.47.camel@novalis.org>
 <CACsJy8C4DO-GYREUhED3YU_WetoTZaB3MUq1kGfRjA3e-FOLYQ@mail.gmail.com>
 <xmqqtw84wpag.fsf@gitster.mtv.corp.google.com>
 <1486580742.1938.52.camel@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1486580742.1938.52.camel@novalis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2017 at 02:05:42PM -0500, David Turner wrote:

> On Wed, 2017-02-08 at 09:44 -0800, Junio C Hamano wrote:
> > Duy Nguyen <pclouds@gmail.com> writes:
> > 
> > > On second thought, perhaps gc.autoDetach should default to false if
> > > there's no tty, since its main point it to stop breaking interactive
> > > usage. That would make the server side happy (no tty there).
> > 
> > Sounds like an idea, but wouldn't that keep the end-user coming over
> > the network waiting after accepting a push until the GC completes, I
> > wonder.  If an impatient user disconnects, would that end up killing
> > an ongoing GC?  etc.
> 
> Regardless, it's impolite to keep the user waiting. So, I think we
> should just not write the "too many unreachable loose objects" message
> if auto-gc is on.  Does that sound OK?

I thought the point of that message was to prevent auto-gc from kicking
in over and over again due to objects that won't actually get pruned.

I wonder if you'd want to either bump the auto-gc object limit, or
possibly reduce the gc.pruneExpire limit to keep this situation from
coming up in the first place (or at least mitigating the amount of time
it's the case).

-Peff
