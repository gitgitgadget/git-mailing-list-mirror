Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18A6A1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 18:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752245AbeAWShe (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 13:37:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:54680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752013AbeAWShd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 13:37:33 -0500
Received: (qmail 30548 invoked by uid 109); 23 Jan 2018 18:37:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 18:37:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18483 invoked by uid 111); 23 Jan 2018 18:38:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Jan 2018 13:38:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2018 13:37:31 -0500
Date:   Tue, 23 Jan 2018 13:37:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Fixes compile warning with -Wimplicit-fallthrough CFLAGS
Message-ID: <20180123183731.GA18333@sigill.intra.peff.net>
References: <1516665078-107974-1-git-send-email-gitter.spiros@gmail.com>
 <20180123000727.GB26357@sigill.intra.peff.net>
 <xmqqd120ifvu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd120ifvu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 10:33:57AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> diff --git a/apply.c b/apply.c
> >> index 321a9fa68..a22fb2881 100644
> >> --- a/apply.c
> >> +++ b/apply.c
> >> @@ -1450,7 +1450,7 @@ static void recount_diff(const char *line, int size, struct fragment *fragment)
> >>  		switch (*line) {
> >>  		case ' ': case '\n':
> >>  			newlines++;
> >> -			/* fall through */
> >> +			GIT_FALLTHROUGH;
> >
> > Ugh, the semi-colon there makes it look like it's actual code. If we go
> > this route, I wonder if it's worth hiding it inside the macro.
> 
> What?  You mean to shout in all caps without even terminating the
> line with any punctuation?  Please don't---I am sure it will break
> auto indentation people rely on from their editors.

True, that may be even worse. I just wonder if we can do something to
make it look more obviously like a non-code attribute. The actual syntax
is something like:

  [[fallthrough]];

which is pretty horrid, but at least a bit easier to see. gcc also
provides "__attribute__((fallthrough))", but I don't think it works with
clang.

I vastly prefer the comment approach if we can use it. Apparently clang
doesn't support it, but I have also not managed to get clang (either
version 4, 6, or the upcoming 7) to actually report anything via
-Wimplicit-fallthrough, either. Maybe I'm holding it wrong.

-Peff
