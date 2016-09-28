Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636AD207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 06:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750789AbcI1Gyz (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 02:54:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:49284 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbcI1Gyy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 02:54:54 -0400
Received: (qmail 14024 invoked by uid 109); 28 Sep 2016 06:54:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Sep 2016 06:54:53 +0000
Received: (qmail 22856 invoked by uid 111); 28 Sep 2016 06:55:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Sep 2016 02:55:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Sep 2016 02:54:51 -0400
Date:   Wed, 28 Sep 2016 02:54:51 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        David Turner <dturner@twosigma.com>
Subject: Re: thoughts on error passing, was Re: [PATCH 2/2] fsck: handle bad
 trees like other errors
Message-ID: <20160928065451.klz4okmag3ksz3gu@sigill.intra.peff.net>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
 <1474918365-10937-3-git-send-email-novalis@novalis.org>
 <20160927052754.bs4frcfy4y7fey62@sigill.intra.peff.net>
 <1474989574.26902.7.camel@frank>
 <20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net>
 <1475017054.13103.3.camel@frank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1475017054.13103.3.camel@frank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 06:57:34PM -0400, David Turner wrote:

> >   int report_error(struct error_context *err, const char *fmt, ...)
> >   {
> >         if (err->fn) {
> >                 va_list ap;
> >                 va_start(ap, fmt);
> >                 err->fn(err->data, fmt, ap);
> >                 va_end(ap);
> >         }
> >         return -1;
> >   }
> > 
> > Then low-level functions just take a context and do:
> > 
> >   return report_error(&err, "some error: %s", foo);
> > 
> > And then the callers would pick one of a few generic error contexts:
> > 
> >   - passing NULL silences the errors
> 
> Overall, +1.
> 
> I guess I would rather have a sentinel value for silencing errors,
> because I'm worried that someone might read NULL as "don't handle the
> errors, just die".  Of course, code review would hopefully catch this,
> but even so, it would be easier to read foo(x, y, silence_errors) than
> foo(x, y, null).

Yeah, I waffled on that. If you look carefully, you'll note that
the report_error() I showed above would actually require such a
"{ NULL, NULL }" global.

I don't plan to make any patches immediately for this, but I'll let it
percolate and consider whether it makes sense to try out for a future
series.

-Peff
