Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFAE203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 18:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073AbcGZSrv (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 14:47:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:49400 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752356AbcGZSru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 14:47:50 -0400
Received: (qmail 6174 invoked by uid 102); 26 Jul 2016 18:47:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 14:47:50 -0400
Received: (qmail 9782 invoked by uid 107); 26 Jul 2016 18:48:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 14:48:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2016 14:47:46 -0400
Date:	Tue, 26 Jul 2016 14:47:46 -0400
From:	Jeff King <peff@peff.net>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] date: document and test "raw-local" mode
Message-ID: <20160726184746.GA678@sigill.intra.peff.net>
References: <20160722195105.GA19542@sigill.intra.peff.net>
 <20160722195144.GE19648@sigill.intra.peff.net>
 <579343C9.1040902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <579343C9.1040902@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 23, 2016 at 12:15:37PM +0200, Jakub Narębski wrote:

> > diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> > index 5d1de06..3ec75d4 100644
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -725,8 +725,8 @@ include::pretty-options.txt[]
> >  	`iso-local`), the user's local time zone is used instead.
> >  +
> >  `--date=relative` shows dates relative to the current time,
> > -e.g. ``2 hours ago''. The `-local` option cannot be used with
> > -`--raw` or `--relative`.
> > +e.g. ``2 hours ago''. The `-local` option has no effect for
> > +`--relative`.
> 
> Do I understand it correctly: --relative is a short form for more
> generic --date=relative (which probably should be spelled 
> --date-format=relative), and that --date=relative-local is the
> same as --date=relative, that is *-local suffix does not change
> how date is formatted?
> 
> Because I don't think you can say --relative-local ("The `-local`
> option has no effect on `--relative`"), can you?

All correct. There is no --relative-local because "--relative" is a
historical artifact. We could support --foo for every --date=foo, but I
don't think there is a reason to do so (and reasons not to, like
avoiding cluttering the option space).

> > -`--date=raw` shows the date in the internal raw Git format `%s %z` format.
> > +`--date=raw` shows the date in the internal raw Git format `%s %z`
> > +format. Note that the `-local` option does not affect the
> > +seconds-since-epoch value (which is always measured in UTC), but does
> > +switch the accompanying timezone value.
> 
> Which is correct, logical, and next to useless, I think.

This was discussed in the earlier review. It's basically only useful if
you are feeding the output to another script which will format the date
and want to change what that script shows.

> BTW. one kind of format that Git does not support (I think) is the
> varying kind, where the precision changes with the distance from now,
> so that we can get most precision in limited width.  That's what
> `ls --long` does:
> 
>  * 'Jun 29 16:47' for dates falling in current year (more precision)
>  * 'Nov 23  2015' for dates outside (less precision, same width)
> 
> Many other programs switch from relative to absolute time when date
> in question is far in the past that relative is not very good.

Yes, this was discussed on the list not too long ago. I think it would
be useful, but is obviously orthogonal to this series.

-Peff
