Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B341F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbcHLQ2b (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:28:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:54283 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752372AbcHLQ2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:28:30 -0400
Received: (qmail 6878 invoked by uid 109); 12 Aug 2016 16:28:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Aug 2016 16:28:28 +0000
Received: (qmail 21055 invoked by uid 111); 12 Aug 2016 16:28:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Aug 2016 12:28:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Aug 2016 12:28:25 -0400
Date:	Fri, 12 Aug 2016 12:28:25 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCHv3] checkout: do not mention detach advice for explicit
 --detach option
Message-ID: <20160812162825.omk23srrbx6ofizc@sigill.intra.peff.net>
References: <20160812153744.15045-1-sbeller@google.com>
 <20160812154331.y2z6pv2w6cwsdsqw@sigill.intra.peff.net>
 <CAGZ79kaOHdLrPownWdnZQSEzG6P6-iZqx2xu3MEG51DZU1U+Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaOHdLrPownWdnZQSEzG6P6-iZqx2xu3MEG51DZU1U+Cg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 08:51:43AM -0700, Stefan Beller wrote:

> > Hmm. Using "!test_cmp" seems weird to me, just because it would falsely
> > claim success if something else unexpected changes. Our usual method for
> > making sure some particular output does not appear is "test_i18ngrep"
> > with a liberal pattern.
> 
> and I advanced the liberal a bit more. ;)
> So maybe we'd be looking that no 'detached HEAD' occurs?
> 
>     test_i18ngrep ! "'detached HEAD'" actual

I was thinking maybe "advice:" to look for any advice, but at this point
we are guessing about what might change in the future.

> I think testing that we do not give out advice (i.e. behave the same as if
> not giving out advice) is best tested to just compare the output to
> the output of "git -c advice.detachedHead=false ...", which is what I do here.
> This seems to be future proof to me no matter how we reword the advice or
> the actual message on checkout?

Yeah, I guess that is reasonable. I thought at first you were comparing
more distinct commands, but if only the one thing is changing, that
seems reasonable.

You may also want to grab stderr, too (I'm actually surprised advice
goes to stdout and not stderr, and that is something that seems
plausible to change in the future).

-Peff
