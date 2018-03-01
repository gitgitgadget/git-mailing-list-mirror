Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33E11F576
	for <e@80x24.org>; Thu,  1 Mar 2018 07:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934813AbeCAHfB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 02:35:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:42282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932243AbeCAHfB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 02:35:01 -0500
Received: (qmail 15790 invoked by uid 109); 1 Mar 2018 07:35:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Mar 2018 07:35:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12533 invoked by uid 111); 1 Mar 2018 07:35:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Mar 2018 02:35:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2018 02:34:58 -0500
Date:   Thu, 1 Mar 2018 02:34:58 -0500
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git <git@vger.kernel.org>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
Message-ID: <20180301073458.GB31079@sigill.intra.peff.net>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com>
 <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net>
 <20180228074251.GA11673@dcvr>
 <20180228074918.GA32127@sigill.intra.peff.net>
 <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 05:46:22PM +0100, demerphq wrote:

> > You're right. I cut down my example too much and dropped the necessary
> > eval magic. Try this:
> >
> > -- >8 --
> > SIG{__DIE__} = sub {
> >   CORE::die @_ if $^S || !defined($^S);
> >   print STDERR "fatal: @_";
> >   exit 128;
> > };
> 
> FWIW, this doesn't need to use CORE::die like that unless you have
> code that overrides die() or CORE::GLOBAL::die, which would be pretty
> unusual.
> 
> die() within $SIG{__DIE__} is special cased not to trigger $SIG{__DIE__} again.
> 
> Of course it doesn't hurt, but it might make a perl hacker do a double
> take why you are doing it. Maybe add a comment like
> 
> # using CORE::die to armor against overridden die()

Thanks, I agree it should just be "die". I pulled this from an old
error-handling pattern I used in some of my scripts (which _does_
override die). I screwed it up when cutting it down the first time, but
then I didn't cut enough the second. :)

-Peff
