Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522862018E
	for <e@80x24.org>; Mon,  8 Aug 2016 19:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbcHHTzE (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 15:55:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:51395 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752521AbcHHTJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 15:09:54 -0400
Received: (qmail 25293 invoked by uid 109); 8 Aug 2016 19:09:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 19:09:53 +0000
Received: (qmail 8674 invoked by uid 111); 8 Aug 2016 19:09:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 15:09:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2016 15:09:51 -0400
Date:	Mon, 8 Aug 2016 15:09:51 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Kirill Smelkov <kirr@nexedi.com>, Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to
 respect --local, --honor-pack-keep and --incremental
Message-ID: <20160808190950.x7ld2r4n7id57nof@sigill.intra.peff.net>
References: <20160729074051.GA5987@teco.navytux.spb.ru>
 <20160729074656.23813-1-kirr@nexedi.com>
 <xmqqy44gjqv9.fsf@gitster.mtv.corp.google.com>
 <20160808123734.GA3995@teco.navytux.spb.ru>
 <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
 <xmqqpopjdqsa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpopjdqsa.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 12:06:13PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> +	if grep -qFf nonlocal-loose 1.objects; then
> >> +		echo "Non-local object present in pack generated with --local"
> >> +		return 1
> >> +	fi
> >> +'
> >
> > grep -f isn't portable. However, I think:
> >
> >   echo $objsha1 >expect &&
> >   git show-index <1.pack | cut -d' ' -f2 >actual
> >   test_cmp expect actual
> >
> > would work (if you do stick with two entries, you might need to sort
> > your "expect").
> 
> Hmph, are you sure?  "grep -f pattern_file" is in POSIX.1.

Hmm, you're right. I specifically checked my local grep.1posix manpage,
but searching for "-f" didn't turn up anything, because it's formatted
with a Unicode minus sign (U+2212). Bleh.

-Peff
