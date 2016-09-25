Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5CE1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 20:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759526AbcIYURQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 16:17:16 -0400
Received: from ikke.info ([178.21.113.177]:38138 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756166AbcIYURP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 16:17:15 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 116164400AA; Sun, 25 Sep 2016 22:17:13 +0200 (CEST)
Date:   Sun, 25 Sep 2016 22:17:13 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Swift Geek <swiftgeek@gmail.com>
Subject: Re: [PATCH v2 2/2] mailinfo: unescape quoted-pair in header fields
Message-ID: <20160925201713.GA6937@ikke.info>
References: <20160916210204.31282-1-me@ikke.info>
 <20160919185440.18234-3-me@ikke.info>
 <20160921110934.f6eu2dz6i2mlpa45@sigill.intra.peff.net>
 <xmqq60pn37gs.fsf@gitster.mtv.corp.google.com>
 <20160923041540.5fvl6ytp2tvcflsk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160923041540.5fvl6ytp2tvcflsk@sigill.intra.peff.net>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2016 at 12:15:41AM -0400, Jeff King wrote:
> On Thu, Sep 22, 2016 at 03:17:23PM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > On Mon, Sep 19, 2016 at 08:54:40PM +0200, Kevin Daudt wrote:
> > >
> > >> + ...
> > >> +	while ((c = *in++) != 0) {
> > >> +		if (take_next_literally) {
> > >> +			take_next_literally = 0;
> > >> +		} else {
> > >> [...]
> > >> +		}
> > >> +
> > >> +		strbuf_addch(line, c);
> > >> +	}
> > >> +}
> > >
> > > It needs to `free(in)` at the end of the function.
> > 
> > Ehh, in has been incremented and is pointing at the terminating NUL
> > there, so it would be more like
> > 
> > 	char *to_free, *in;
> > 
> >         to_free = strbuf_detach(line, NULL);
> >         in = to_free;
> > 	...
> >         while ((c = *in++)) {
> >         	...
> > 	}
> >         free(to_free);
> > 
> > I would think ;-).
> 
> Oops, yes. It is beginning to make the "strbuf_swap()" look less
> convoluted. :)
> 

I've switched to strbuf_swap now, much better. I've implemented
recursive parsing without looking at what you provided, just to see what
I'd came up with. Though I've not implemented a recursive descent
parser, but it might suffice.

I'm sending the patches now.

