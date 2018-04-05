Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430AE1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754103AbeDEWxX (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:53:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:55246 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752777AbeDEWxW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:53:22 -0400
Received: (qmail 10603 invoked by uid 109); 5 Apr 2018 22:53:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 22:53:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20434 invoked by uid 111); 5 Apr 2018 22:54:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 18:54:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 18:53:20 -0400
Date:   Thu, 5 Apr 2018 18:53:20 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] builtin/config: introduce `color` type specifier
Message-ID: <20180405225320.GA10913@sigill.intra.peff.net>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
 <20180405025917.GD49902@syl.local>
 <20180405223620.GD29117@sigill.intra.peff.net>
 <CAPig+cQoTQ47n13q3t5MMS+UZQR6jbFDpVSP8Z=L4qckjrsxeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQoTQ47n13q3t5MMS+UZQR6jbFDpVSP8Z=L4qckjrsxeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 06:52:29PM -0400, Eric Sunshine wrote:

> On Thu, Apr 5, 2018 at 6:36 PM, Jeff King <peff@peff.net> wrote:
> > On Wed, Apr 04, 2018 at 07:59:17PM -0700, Taylor Blau wrote:
> >> +     if (type == TYPE_COLOR) {
> >> +             char v[COLOR_MAXLEN];
> >> +             if (!git_config_color(v, key, value))
> >> +                     /*
> >> +                      * The contents of `v` now contain an ANSI escape
> >> +                      * sequence, not suitable for including within a
> >> +                      * configuration file. Treat the above as a
> >> +                      * "sanity-check", and return the given value, which we
> >> +                      * know is representable as valid color code.
> >> +                      */
> >> +                     return xstrdup(value);
> >> +             die("cannot parse color '%s'", value);
> >> +     }
> >
> > And this returns the original. Good.
> 
> It's entirely subjective, but I find this easier to read and
> understand when written like this:
> 
>     char v[COLOR_MAXLEN];
>     if (git_config_color(v, key, value))
>         die("cannot parse color '%s'", value);
> 
>     /*
>      * The contents of `v` now contain an ANSI escape
>      * sequence, not suitable for including within a
>      * configuration file. Treat the above as a
>      * "sanity-check", and return the given value, which we
>      * know is representable as valid color code.
>     */
>     return xstrdup(value);

It may be subjective, but I happen to agree with you.

-Peff
