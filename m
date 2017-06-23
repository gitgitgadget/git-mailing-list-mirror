Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2831220831
	for <e@80x24.org>; Fri, 23 Jun 2017 15:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbdFWPZ5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 11:25:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:50530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754565AbdFWPZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 11:25:56 -0400
Received: (qmail 28409 invoked by uid 109); 23 Jun 2017 15:25:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 15:25:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14929 invoked by uid 111); 23 Jun 2017 15:26:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 11:26:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 11:25:54 -0400
Date:   Fri, 23 Jun 2017 11:25:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param
 to bool
Message-ID: <20170623152554.jybv2vtsnjsoedoi@sigill.intra.peff.net>
References: <20170623144603.11774-1-avarab@gmail.com>
 <a2673ce4-5cf8-6b40-d4db-8e2a49518138@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2673ce4-5cf8-6b40-d4db-8e2a49518138@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 05:20:19PM +0200, René Scharfe wrote:

> > diff --git a/strbuf.c b/strbuf.c
> > index be3b9e37b1..81ff3570e2 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -786,7 +786,7 @@ char *xstrfmt(const char *fmt, ...)
> >   }
> >   void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
> > -		     int tz_offset, const char *tz_name)
> > +		     int tz_offset, const int omit_strftime_tz_name)
> 
> Why const?  And as written above, naming the parameter local would make
> it easier to understand instead of exposing an implementation detail in
> the interface.

I think calling it "local" isn't right. That's a decision the _caller_
is making about whether to pass through %Z. But the actual
implementation is more like "should the function fill tzname based on
tz?" So some name along those lines would make sense.

In which case the caller would then pass "!mode->local" for the flag.

-Peff
