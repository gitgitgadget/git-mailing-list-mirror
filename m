Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63C32070D
	for <e@80x24.org>; Fri,  8 Jul 2016 21:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbcGHVqm (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 17:46:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:42138 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751658AbcGHVql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 17:46:41 -0400
Received: (qmail 4905 invoked by uid 102); 8 Jul 2016 21:46:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 17:46:41 -0400
Received: (qmail 15890 invoked by uid 107); 8 Jul 2016 21:47:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 17:47:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 17:46:38 -0400
Date:	Fri, 8 Jul 2016 17:46:38 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
Message-ID: <20160708214637.GB9820@sigill.intra.peff.net>
References: <20160707011218.3690-1-sbeller@google.com>
 <20160707011218.3690-3-sbeller@google.com>
 <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
 <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com>
 <20160708175821.GA29326@google.com>
 <xmqqshvkkm86.fsf@gitster.mtv.corp.google.com>
 <CAGZ79ka8eHOx28Ja+S6DOGEOrV_ijUvi_NnjprhuzQ+3O9BAoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka8eHOx28Ja+S6DOGEOrV_ijUvi_NnjprhuzQ+3O9BAoQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 11:57:20AM -0700, Stefan Beller wrote:

> >> Sorry to butt into the conversation late, but: I am not yet convinced.
> >>
> >> Is the idea that if the push options were very large, this would save
> >> the client from the cost of sending them?
> >
> > Not really.  I have no strong opinion on the benefit of limiting
> > number/size.  Stefan limited the number/size at the receiving end
> > and made receiving end die with its message.
> 
> Jeff claimed we'd need some sort of DoS protection for this feature,
> so I considered just die-ing enough for an initial implementation.

I do not think we need to worry too much about niceties for these
limits. The point is to protect servers from malicious nonsense, like
somebody sending gigabytes of push options, or trying to overflow a
buffer in a hook with a large value. If people are seeing these in
routine use, then the limits are set too low, and this should happen
roughly as often as a BUG assertion, and IMHO should be treated roughly
the same: don't bother with translation, and don't worry about
optimizing wasted bandwidth for this case. It won't happen enough to
matter.

-Peff
