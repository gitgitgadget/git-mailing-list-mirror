Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3273C2079E
	for <e@80x24.org>; Sat, 14 Jan 2017 07:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdANHyM (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 02:54:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:39115 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdANHyM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 02:54:12 -0500
Received: (qmail 18772 invoked by uid 109); 14 Jan 2017 07:54:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Jan 2017 07:54:11 +0000
Received: (qmail 10871 invoked by uid 111); 14 Jan 2017 07:55:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Jan 2017 02:55:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jan 2017 02:54:09 -0500
Date:   Sat, 14 Jan 2017 02:54:09 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pat Pannuto <pat.pannuto@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
Message-ID: <20170114075408.hyidkb4rzxzmm2je@sigill.intra.peff.net>
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
 <20170112055140.29877-3-pat.pannuto@gmail.com>
 <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
 <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
 <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
 <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
 <20170113024842.GA20572@starla>
 <xmqq4m12izmd.fsf@gitster.mtv.corp.google.com>
 <20170113185246.GA17441@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113185246.GA17441@starla>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 06:52:46PM +0000, Eric Wong wrote:

> > If something we _use_ from a third-party is not warnings-clean,
> > there is no easy way to squelch them if we use "-w", which is a
> > potential downside, isn't it?  I do not know how serious a problem
> > it is in practice.  I suspect that the core package we use from perl
> > distribution are supposed to be warnings-clean, but we use a handful
> > of things from outside the core and I do not know what state they
> > are in.
> 
> Yes, "-w" will trigger warnings in third party packages.
> Existing uses we have should be fine, and I think most Perl
> modules we use or would use are vigilant about being
> warnings-clean.  If we have to leave off a "-w", there should
> probably be a comment at the top stating the reason:
> 
> #!/usr/bin/perl
> # Not using "perl -w" since Foo::Bar <= X.Y.Y is not warnings-clean
> use strict;
> use warnings;
> use Foo::Bar;
> ...

Just as a devil's advocate, why do we care about warnings in third-party
modules? Or more specifically, why do _users_ who are running Git care
about them? We cannot fix them in Git. A user may report the error to
the module author, but the module author may not be responsive, or even
may not be inclined to fix the problem (because they have a particular
opinion on that warning).

In the meantime, the user is stuck with an annoying warning message
until Git is updated as you showed above. Why not just start there
preemptively, and let module authors worry about their own warnings?

-Peff
