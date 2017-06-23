Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C4320282
	for <e@80x24.org>; Fri, 23 Jun 2017 16:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbdFWQhO (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 12:37:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50626 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751488AbdFWQhN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 12:37:13 -0400
Received: (qmail 32725 invoked by uid 109); 23 Jun 2017 16:37:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 16:37:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15916 invoked by uid 111); 23 Jun 2017 16:37:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 12:37:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 12:37:11 -0400
Date:   Fri, 23 Jun 2017 12:37:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param
 to bool
Message-ID: <20170623163711.a3necnsqmroguuib@sigill.intra.peff.net>
References: <20170623144603.11774-1-avarab@gmail.com>
 <20170623145102.h7rt6zaqajfzuhsk@sigill.intra.peff.net>
 <8760fmka8t.fsf@gmail.com>
 <20170623152344.gdk4haizpziwryrd@sigill.intra.peff.net>
 <2e0773c3-b742-a211-d9cb-64da58cf9e0d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e0773c3-b742-a211-d9cb-64da58cf9e0d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 06:23:10PM +0200, René Scharfe wrote:

> > > I have a WIP patch (which may not make it on-list, depending) playing
> > > with the idea I proposed in
> > > CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com which
> > > just inserts the custom TZ name based on the offset inside that `if
> > > (omit_strftime_tz_name)` branch.
> > 
> > OK. I'd assumed that would all happen outside of strbuf_addftime(). But
> > if it happens inside, then I agree a flag is better.
> 
> Oh, so the interface that was meant to allow better time zone names
> without having to make strbuf_addftime() even bigger than it already is
> turns out to be too ugly for its purpose?  I'm sorry. :(

I haven't seen Ævar's patch, but I agree that if the caller did:

  if (mode->local)
	tzname = NULL; /* let strftime handle it */
  else
	tzname = fake_tz_from_offset(tz);
  ...
  strbuf_addftime(&buf, fmt, tm, tz, tzname);

that would be pretty clean (and what I was expecting with the "I'd
assumed" above).

-Peff
