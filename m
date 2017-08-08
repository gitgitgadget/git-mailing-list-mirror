Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EEF41F991
	for <e@80x24.org>; Tue,  8 Aug 2017 07:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbdHHHZN (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 03:25:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:60020 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751880AbdHHHZN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 03:25:13 -0400
Received: (qmail 4839 invoked by uid 109); 8 Aug 2017 07:25:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 07:25:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13599 invoked by uid 111); 8 Aug 2017 07:25:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 03:25:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Aug 2017 03:25:10 -0400
Date:   Tue, 8 Aug 2017 03:25:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC] imap-send: escape backslash in password
Message-ID: <20170808072510.leb525df4hmbwcvo@sigill.intra.peff.net>
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
 <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
 <87bmnvktee.fsf@linux-m68k.org>
 <20170804202255.3oia7ivsoa6vu4me@sigill.intra.peff.net>
 <xmqq3797t4kq.fsf@gitster.mtv.corp.google.com>
 <20170804212231.pl3uipcsujflcuha@sigill.intra.peff.net>
 <xmqqzibcqhy9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzibcqhy9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 06, 2017 at 06:34:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That is fine by me. AFAIK, we already build the curl support by default
> > when a sufficiently-advanced version of curl is available. So if there
> > were feature-parity problems hopefully somebody would have reported it.
> >
> > I think the deprecation here can be relatively fast because we're not
> > actually dropping support for any feature. We're just requiring that
> > they install curl to get the same functionality (which might be
> > inconvenient, but it's a heck of a lot less inconvenient than "there's
> > no way to do what you want anymore").
> 
> Yeah, as long as imap-supporting libcurl is not too recent and are
> available everywhere, we should be OK.

I think we're not quite ready to switch to curl based on comments in the
nearby thread. But just for reference, since I started looking into
this...

The defines in the Makefile turn on USE_CURL_FOR_IMAP_SEND want curl
7.34.0. That's only from 2013, which is probably recent enough that it
may cause a problem (I had originally thought it was a few years older,
but I forgot the curl version hex encoding; 072200 is 7.34.0).

For comparison, nothing older than curl 7.19.4 will work for building
Git since v2.12.0, as we added some unconditional uses of CURLPROTO_*
there. Nobody seems to have noticed or complained. I pointed this out a
few months ago[1] and suggested we clean up some of the more antiquated
#if blocks in http.c that don't even build. There was some complaint
that we should keep even these ancient versions working, but the
compile error is still in "master".

So it's not clear to me that anybody cares about going that far back
(which is mid-2009), but I'd guess that 2013 might cause some problems.

[1] https://public-inbox.org/git/20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net/
    if you're curious (you were offline for a while at that time, I
    think).
