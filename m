Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9602047A
	for <e@80x24.org>; Fri, 11 Nov 2016 20:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936177AbcKKU1P (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 15:27:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:42002 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935973AbcKKU1N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 15:27:13 -0500
Received: (qmail 30796 invoked by uid 109); 11 Nov 2016 20:27:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 20:27:12 +0000
Received: (qmail 16909 invoked by uid 111); 11 Nov 2016 20:27:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 15:27:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2016 15:27:10 -0500
Date:   Fri, 11 Nov 2016 15:27:10 -0500
From:   Jeff King <peff@peff.net>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        git <git@vger.kernel.org>, me@ttaylorr.com
Subject: Re: [RFC] Add way to make Git credentials accessible from
 clean/smudge filter
Message-ID: <20161111202710.7zpalypsnorqeclq@sigill.intra.peff.net>
References: <4C8C5650-7221-4F62-A9CC-81AE01EF6DC7@gmail.com>
 <vpqoa1n1qom.fsf@anie.imag.fr>
 <20161110160809.2gvf67rlnvounulf@sigill.intra.peff.net>
 <77603924-3552-4146-9C9E-A106CFA96D7A@gmail.com>
 <20161111093122.osbdwmze5x5t742v@sigill.intra.peff.net>
 <4060C484-B42E-42AB-BB42-4753373F0E7F@gmail.com>
 <1478894572.12153.1.camel@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1478894572.12153.1.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 09:02:52PM +0100, Dennis Kaarsemaker wrote:

> > > Are you sure about that? If I do:
> > > 
> > >  echo url=https://example.com/repo.git |
> > >  git credential fill
> > > 
> > > I get prompted for a username and password.
> > 
> > 
> > Hm.. either I don't understand you or I expressed myself unclear. 
> > 
> > Let's say a user runs:
> > 
> > $ git clone https://myrepo.git
> > 
> > If no credential helper is setup, then Git asks the user for credentials.
> > Afterwards Git starts downloading stuff. At some point Git will run my
> > smudge filter on some files and in my case the smudge filter needs the
> > Git credentials. AFAIK, the smudge filter has no way to get the credentials 
> > from Git at this point - not even by invoking "git credential". 
> > Is this correct?
> 
> I think that's correct, but the same argument goes both ways: unless I
> use a credential helper, or explicitely give a filter application my
> credentials, I don't want a helper to be able to get to those
> credentials. I'd consider that a security bug.

Yeah, agreed. They are logically two separate operations, so I think it
is a feature that they do not implicitly share credentials.

I think the only place where we implicitly share credentials is when
serving an HTTP fetch or push requires multiple HTTP requests. And there
it seems pretty sane to do so.

-Peff
