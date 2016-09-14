Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19121FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 19:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933151AbcINTSE (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 15:18:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:43297 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933122AbcINTSD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 15:18:03 -0400
Received: (qmail 6864 invoked by uid 109); 14 Sep 2016 19:18:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 19:18:02 +0000
Received: (qmail 2412 invoked by uid 111); 14 Sep 2016 19:18:13 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 15:18:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 12:17:59 -0700
Date:   Wed, 14 Sep 2016 12:17:59 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
Message-ID: <20160914191759.5unwaq2eequ4pifr@sigill.intra.peff.net>
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
 <20160913234612.22806-1-me@ikke.info>
 <20160913234612.22806-2-me@ikke.info>
 <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
 <20160914050919.qhv2gxzjyj5ydpub@sigill.intra.peff.net>
 <xmqqmvjbrpp4.fsf@gitster.mtv.corp.google.com>
 <20160914160308.GB26893@ikke.info>
 <xmqqoa3qqsw9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa3qqsw9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 10:43:18AM -0700, Junio C Hamano wrote:

> I think we can go either way and it does not matter all that much if
> "mailinfo" changes its output or the reader of "mailinfo" output
> changes its input--we will either be munging data read from "From:"
> when producing the "Author:" line, or taking the "Author:" output by
> mailinfo and removing the quotes.

Yeah, that was the part I was wondering about in my original response.
What is the output of mailinfo _supposed_ to be, and do we consider that
at all public (i.e., are there are other tools besides "git am" that
build on mailinfo)?

At least "am" already does some quote-stripping, so any de-quoting added
in mailinfo is potentially a regression (if we indeed care about keeping
the output stable).

But if we are OK with that, it seems to me that mailinfo is the best
place to do the de-quoting, because then its output is well-defined:
everything after "Author:" up to the newline is the name. Whereas if the
cleanup of the value is split across mailinfo and its reader, then it is
hard to know which side is responsible for which part. mailinfo handles
whitespace unfolding, certainly. What other rfc2822 things does it
handle? What are the rules for dequoting its output?

I'll admit I don't care _too_ much. This is a remote corner of the code
that I hope never to have to look at. I'm mostly just describing how the
problem space makes sense to _me_, and how I would write it if starting
from scratch.

-Peff
