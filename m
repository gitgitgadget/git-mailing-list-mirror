Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53AB71F621
	for <e@80x24.org>; Wed, 27 Jul 2016 19:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757862AbcG0T5H (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 15:57:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:50094 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757365AbcG0T5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 15:57:06 -0400
Received: (qmail 5572 invoked by uid 102); 27 Jul 2016 19:57:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 15:57:07 -0400
Received: (qmail 20337 invoked by uid 107); 27 Jul 2016 19:57:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 15:57:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 15:57:03 -0400
Date:	Wed, 27 Jul 2016 15:57:03 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 5/6] date: document and test "raw-local" mode
Message-ID: <20160727195703.GA8141@sigill.intra.peff.net>
References: <20160722195105.GA19542@sigill.intra.peff.net>
 <20160722195144.GE19648@sigill.intra.peff.net>
 <579343C9.1040902@gmail.com>
 <20160726184746.GA678@sigill.intra.peff.net>
 <5798AA7C.6050107@gmail.com>
 <20160727134441.GB14928@sigill.intra.peff.net>
 <xmqq37mux3mz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37mux3mz.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 12:49:40PM -0700, Junio C Hamano wrote:

> > @@ -746,7 +746,10 @@ format, often found in email messages.
> >  +
> >  `--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
> >  +
> > -`--date=raw` shows the date in the internal raw Git format `%s %z` format.
> > +`--date=raw` shows the date in the internal raw Git format `%s %z`
> > +format. Note that the `-local` option does not affect the
> > +seconds-since-epoch value (which is always measured in UTC), but does
> > +switch the accompanying timezone value.
> 
> Not your fault, but "internal raw Git format X format" sounds a bit
> clunky.

Yeah, I also noticed that while writing the original, but it just
crossed over my line of "if I fix everything I don't like, this series
will never get out the door". :)

> 	shows the date in `%s %z` format (seconds since 1970-01-01
> 	00:00:00 UTC, space, timezone as sign and four digits)
>         
> or something like that?  I suspect %s is not a POSIX-kosher strftime
> conversion specifier, so from that point of view, perhaps making the
> text the authoritative description and demote the format string as a
> comment to help those who know strfmt, i.e.
> 
> 	shows the date as seconds since 1970-01-01 00:00:00 UTC,
> 	space, timezone as sign and four digits (i.e. as if the
> 	timestamp were formatted with `strftime("%s %z")`).

Yeah, I think referring to "%s %z" is pretty bad, as it's meaningless to
people who don't know strftime() off the top of their head, and %s isn't
even portable.

The second option you've shown here is much better, and I think this is
worth fixing (and it should be in a new patch, and can go on top of the
others).

I'm not sure if it's worth calling out more clearly what the timezone
means, since the epoch seconds are in UTC, as you noted here. The
follow-on sentence explains what "-local" does, but not what it means in
the non-local variant.

-Peff
