Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250742095B
	for <e@80x24.org>; Mon, 20 Mar 2017 18:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756614AbdCTSTZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:19:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:47899 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756814AbdCTSSv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:18:51 -0400
Received: (qmail 14098 invoked by uid 109); 20 Mar 2017 18:18:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 18:18:05 +0000
Received: (qmail 4248 invoked by uid 111); 20 Mar 2017 18:18:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 14:18:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 14:18:01 -0400
Date:   Mon, 20 Mar 2017 14:18:01 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Add configuration options for some commonly used command-line
 options
Message-ID: <20170320181801.fubiyufrsyenru4b@sigill.intra.peff.net>
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
 <vpqa88hlghm.fsf@anie.imag.fr>
 <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
 <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
 <CACsJy8CQzo9K8N3xH_HJq=NjJVOUG9wawC4Mg+UuyFRZCPBpFw@mail.gmail.com>
 <20170320173237.GA188475@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170320173237.GA188475@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 10:32:37AM -0700, Brandon Williams wrote:

> > > IIRC the consensus was that such a facility would allow commands or
> > > individual options to say "this command/option is configurable", thus
> > > of course all plumbing utilities would be unconfigurable, but
> > > porcelain scripts would be configurable by default, with some
> > > exceptions.
> > 
> > This is exactly it! It's much better than adding individual config
> > variables (less work for sure, but messier). Maybe we should promote
> > the microproject "Add configuration options for commonly used cmdline
> > options" to project. If it's too short (I'm guessing the core code
> > could be done in a month), the gsoc student can always convert more
> > config to the new way.
> 
> If in the future we did want better support for making user defaults
> (apart from aliases) for commands we could entertain creating a command
> like bash's 'command' which ignores any user defaults and executes a
> particular command in a vanilla mode.
> 
> So if the user configured 'git am' to always use the -3 option then
> running `git command am` (or something akin to that) would just run the
> vanilla 'am' command with no options.  Probably not the best idea since
> tooling would need to become aware of such a paradigm change, but its
> just a thought.

I think we've had similar proposals in the form of an environment
variable like "GIT_PLUMBING" (and your "command", which I do like
syntactically, would probably just end up setting such an environment
variable anyway).

But yeah, the sticking point is that we'd have to wait for scripts to
adopt it. Manually marking options as "safe" is tedious, but gives more
control.

If we want to follow the GIT_PLUMBING route, I think the first step
would be to introduce it now as a noop (or even a mostly-noop that just
turns off eve the "safe" options). And then we wait for N time units so
that scripts can start using it, and only then start introducing the
breaking changes.

-Peff
