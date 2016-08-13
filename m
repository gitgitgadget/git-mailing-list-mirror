Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD1A1FD99
	for <e@80x24.org>; Sat, 13 Aug 2016 11:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbcHMLOx (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 07:14:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:54722 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752262AbcHMLOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 07:14:52 -0400
Received: (qmail 9453 invoked by uid 109); 13 Aug 2016 11:14:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 11:14:51 +0000
Received: (qmail 2204 invoked by uid 111); 13 Aug 2016 11:14:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 07:14:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Aug 2016 07:14:49 -0400
Date:	Sat, 13 Aug 2016 07:14:49 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Message-ID: <20160813111449.vkoo3fmlfd65loh5@sigill.intra.peff.net>
References: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com>
 <20160812224255.GA16250@dcvr>
 <20160813081012.p46i4jcvkkfqch7m@sigill.intra.peff.net>
 <20160813090432.GA25565@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160813090432.GA25565@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 09:04:32AM +0000, Eric Wong wrote:

> > Is there an easy way to get _just_ the list of message-ids you are
> > storing (I know I can download the whole archive, but it's big)?
> 
> XHDR (or HDR) over NNTP should do it (that's how I checked
> against gmane):
> --------8<-----
> use Net::NNTP;
> my $nntp = Net::NNTP->new($ENV{NNTPSERVER} || 'news.public-inbox.org');
> my ($num, $first, $last) = $nntp->group('inbox.comp.version-control.git');
> my $batch = 10000;
> my $i;
> for ($i = $first; $i < $last; $i += $batch) {
> 	my $j = $i + $batch - 1;
> 	$j = $last if $j > $last;
> 	my $num2mid = $nntp->xhdr('Message-ID', "$i-$j");
> 	for my $n ($i..$j) {
> 		defined(my $mid = $num2mid->{$n}) or next;
> 		print "$mid\n";
> 	}
> }

Thanks, that's perfect.

I collected the message-ids from my archive. Interestingly, I had a
dozen or so that did not have message-ids at all. I think most of them
are from patches that put the "From " line in the body, like this one:

  http://public-inbox.org/git/20070311033833.GB10781@spearce.org/

and then they got corrupted on a round-trip through one of the bad mbox
formats (probably downloading from gmane, I'd guess; the export there
uses mbox, and I use maildir myself, so it probably got split badly
years ago). Anyway, public-inbox seems to get this case right, which is
good.

I had several hundred message ids that you didn't. About half of them
were spam or other junk. I weeded them out manually (mostly by picking
through the subjects, so possibly there's some error). The end result is
279 messages that I think are legitimate that you don't have.

I'll send them to you off-list, as the mbox is about 300K, which the
list will reject.

-Peff
