Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AAE20986
	for <e@80x24.org>; Thu, 29 Sep 2016 09:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933513AbcI2JWS (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 05:22:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49817 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932622AbcI2JWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 05:22:07 -0400
Received: (qmail 13163 invoked by uid 109); 29 Sep 2016 09:22:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 09:22:06 +0000
Received: (qmail 32363 invoked by uid 111); 29 Sep 2016 09:22:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 05:22:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 05:22:04 -0400
Date:   Thu, 29 Sep 2016 05:22:04 -0400
From:   Jeff King <peff@peff.net>
To:     Lukas Fleischer <lfleischer@lfos.de>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12
 hexdigits
Message-ID: <20160929092204.eod2cvtrqg5whu6h@sigill.intra.peff.net>
References: <20160928233047.14313-5-gitster@pobox.com>
 <20160929024400.22605-1-szeder@ira.uka.de>
 <147512682170.7989.11263315726387435240@typhoon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <147512682170.7989.11263315726387435240@typhoon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 07:27:01AM +0200, Lukas Fleischer wrote:

> > Sure, users working on smaller repos are free to reset core.abbrev to
> > its original value.  I don't have any numbers, of course, but I
> > suspect that there are many more smaller repos out there that this
> > change will affect disadvantageously, than there are large repos for
> > which it's beneficial.
> 
> I know this suggestion comes a bit late but would it make sense to let
> the repository owner overwrite the core.abbrev setting?
> 
> One possible way to implement this would be adding .gitconfig support to
> repositories with a very limited set of whitelisted variables allowed in
> there (could be core.abbrev only to begin with). Or some entirely
> separate mechanism like .gitignore.

The suggestion for versioned repository-level config comes up from time
to time; you can find other instances in the list archive. Usually the
biggest issue is that usually nobody comes up with a good example of
something that the project would actually want to set. Setting
"core.abbrev" at least seems plausible.

Though...

> With such a mechanism, we could keep the default of 7 which works fine
> for most projects. Linus could bump the default to 12 for linux.git. If
> some users are not happy with that, they can still overwrite it in their
> local Git config. Anybody starting a project could change the initial
> value to a suitable value in one of the first commits -- provided they
> already have an idea how much the project will grow. That way, hashes
> will be "long enough" even for early commits, before any heuristics
> could guess that the project would become large.

I wonder if in practice we would do just as well to size default_abbrev
dynamically based on the number of objects. That doesn't help projects
which are just starting, but will eventually grow gigantic.  But I doubt
that most projects would have the foresight to preemptively set
core.abbrev. And that would at least reduce the impact as the project
_does_ get big.

-Peff
