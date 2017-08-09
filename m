Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8644D208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbdHIVts (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:49:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:33898 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752247AbdHIVtr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:49:47 -0400
Received: (qmail 29790 invoked by uid 109); 9 Aug 2017 21:49:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 21:49:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31621 invoked by uid 111); 9 Aug 2017 21:50:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 17:50:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 17:49:45 -0400
Date:   Wed, 9 Aug 2017 17:49:45 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] http: drop support for curl < 7.16.0
Message-ID: <20170809214945.jx2tqbs72g5hwsau@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net>
 <xmqq1sok7i82.fsf@gitster.mtv.corp.google.com>
 <38dfdc54-65ea-694a-4b72-fe0006a008cf@suse.de>
 <20170809211734.dcyo2gppznzk6kng@sigill.intra.peff.net>
 <7468c434-88ca-48de-0bda-894baf8020f2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7468c434-88ca-48de-0bda-894baf8020f2@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 11:29:30PM +0200, Nicolas Morey-Chaisemartin wrote:

> > But the #ifdef above says 071700, which is 7.23.0. I wonder if we just
> > got it wrong back then (maybe hex confusion with 7.17.0?). I have a
> > build setup for old versions of curl, so I'll double-check that 7.19.4
> > builds with KEYPASSWD. And dig in the history to see if there's any
> > comment on this mismatch.
>
> It seems to be a decimal/hex issue:
> docs/libcurl/symbols-in-versions:153:CURLOPT_KEYPASSWD               7.17.0
> 
> I guess it should still work because it is now defined like this:
> curl.h:#define CURLOPT_SSLKEYPASSWD CURLOPT_KEYPASSWD
> 
> If I'm not mistaken on cpp behaviour it means CURLOPT_KEYPASSWD is
> evaluated to CURLOPT_SSLKEYPASSWD (git define) which is evaluated into
> CURLOPT_KEYPASSWD (curl define).
>
> It should stop here as CURLOPT_KEYPASSWD was not a defined macro when
> the curl one was evaluated.  It might be worth cleaning though,
> specially it wouldn't work anymore if the git macro is ever moved
> before the curl include.

Hmph. That makes me think the original should have just been using
CURLOPT_SSLKEYPASSWD through the code, if curl was providing
a backwards-compatible macro. But it won't matter either way if we just
get rid of it. :)

Thanks for digging up the curl history.

-Peff
