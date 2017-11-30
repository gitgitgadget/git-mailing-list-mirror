Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D723320A40
	for <e@80x24.org>; Thu, 30 Nov 2017 03:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbdK3D2f (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 22:28:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:44050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753369AbdK3D2e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 22:28:34 -0500
Received: (qmail 8549 invoked by uid 109); 30 Nov 2017 03:28:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Nov 2017 03:28:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24656 invoked by uid 111); 30 Nov 2017 03:28:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 29 Nov 2017 22:28:53 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Nov 2017 22:28:32 -0500
Date:   Wed, 29 Nov 2017 22:28:32 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Doron Behar <doron.behar@gmail.com>, git@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: Re: imap-send with gmail: curl_easy_perform() failed: URL using
 bad/illegal format or missing URL
Message-ID: <20171130032832.GA25577@sigill.intra.peff.net>
References: <20171129171301.l3coiflkfyy533yz@NUC.localdomain>
 <20171130020445.GF15098@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130020445.GF15098@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 29, 2017 at 06:04:45PM -0800, Jonathan Nieder wrote:

> > Password for 'imaps://doron.behar@gmail.com@imap.gmail.com':
> > sending 3 messages
> > curl_easy_perform() failed: URL using bad/illegal format or missing URL
> > ```
> 
> Thanks for reporting this.  I suspect this is related to
> v2.15.0-rc0~63^2 (imap-send: use curl by default when possible,
> 2017-09-14) --- e.g. perhaps our custom IMAP code was doing some
> escaping on the username that libcurl does not do.
> 
> "man git imap-send" says this is a recommended configuration, so I
> don't think it's a configuration error.
> 
> What platform are you on?  What version of libcurl are you using?

All good thoughts/questions. I have two suggestions to add:

 1. As an immediate work-around, running "imap-send --no-curl" may work. 
    That will at least get this case working while we debug.

 2. Setting GIT_TRACE_CURL=1 may dump more verbose information. But one
    caveat: if you get as far as authenticating, then the trace will
    contain your password. We redact HTTP auth from the trace output,
    but not imap ones.

-Peff
