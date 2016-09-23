Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BADB207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 04:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933339AbcIWEPr (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 00:15:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:47003 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932127AbcIWEPo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 00:15:44 -0400
Received: (qmail 26284 invoked by uid 109); 23 Sep 2016 04:15:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 04:15:44 +0000
Received: (qmail 14430 invoked by uid 111); 23 Sep 2016 04:15:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 00:15:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2016 00:15:41 -0400
Date:   Fri, 23 Sep 2016 00:15:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Swift Geek <swiftgeek@gmail.com>
Subject: Re: [PATCH v2 2/2] mailinfo: unescape quoted-pair in header fields
Message-ID: <20160923041540.5fvl6ytp2tvcflsk@sigill.intra.peff.net>
References: <20160916210204.31282-1-me@ikke.info>
 <20160919185440.18234-3-me@ikke.info>
 <20160921110934.f6eu2dz6i2mlpa45@sigill.intra.peff.net>
 <xmqq60pn37gs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60pn37gs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 03:17:23PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Sep 19, 2016 at 08:54:40PM +0200, Kevin Daudt wrote:
> >
> >> + ...
> >> +	while ((c = *in++) != 0) {
> >> +		if (take_next_literally) {
> >> +			take_next_literally = 0;
> >> +		} else {
> >> [...]
> >> +		}
> >> +
> >> +		strbuf_addch(line, c);
> >> +	}
> >> +}
> >
> > It needs to `free(in)` at the end of the function.
> 
> Ehh, in has been incremented and is pointing at the terminating NUL
> there, so it would be more like
> 
> 	char *to_free, *in;
> 
>         to_free = strbuf_detach(line, NULL);
>         in = to_free;
> 	...
>         while ((c = *in++)) {
>         	...
> 	}
>         free(to_free);
> 
> I would think ;-).

Oops, yes. It is beginning to make the "strbuf_swap()" look less
convoluted. :)

-Peff
