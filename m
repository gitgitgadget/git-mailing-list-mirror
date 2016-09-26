Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFEB21F4F8
	for <e@80x24.org>; Mon, 26 Sep 2016 05:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbcIZFCc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 01:02:32 -0400
Received: from ikke.info ([178.21.113.177]:56378 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751346AbcIZFCc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 01:02:32 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 613124400AA; Mon, 26 Sep 2016 07:02:30 +0200 (CEST)
Date:   Mon, 26 Sep 2016 07:02:30 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>
Subject: Re: [PATCH v2 2/2] mailinfo: unescape quoted-pair in header fields
Message-ID: <20160926050230.GA19089@ikke.info>
References: <20160916210204.31282-1-me@ikke.info>
 <20160919185440.18234-3-me@ikke.info>
 <20160921110934.f6eu2dz6i2mlpa45@sigill.intra.peff.net>
 <xmqq60pn37gs.fsf@gitster.mtv.corp.google.com>
 <20160923041540.5fvl6ytp2tvcflsk@sigill.intra.peff.net>
 <20160925201713.GA6937@ikke.info>
 <0b6cbc53-e058-f064-59e8-b73203f3e400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b6cbc53-e058-f064-59e8-b73203f3e400@gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 12:38:42AM +0200, Jakub Narębski wrote:
> W dniu 25.09.2016 o 22:17, Kevin Daudt pisze:
> > On Fri, Sep 23, 2016 at 12:15:41AM -0400, Jeff King wrote:
> 
> >> Oops, yes. It is beginning to make the "strbuf_swap()" look less
> >> convoluted. :)
> >>
> > 
> > I've switched to strbuf_swap now, much better. I've implemented
> > recursive parsing without looking at what you provided, just to see what
> > I'd came up with. Though I've not implemented a recursive descent
> > parser, but it might suffice.
> 
> I think you can implement a parser handling proper nesting of parens
> without recursion.
> 
> Though... what is the definition in the RFC?

This part describes comments.

    ccontent        =       ctext / quoted-pair / comment

    comment         =       "(" *([FWS] ccontent) [FWS] ")"

    CFWS            =       *([FWS] comment) (([FWS] comment) / FWS)

So each comment can itself also contain a comment.

This could be done without recursion by keeping a count of how many open
parens we have encountered.

Kevin
