Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF9D1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeDEWky (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:40:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:55196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750726AbeDEWkx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:40:53 -0400
Received: (qmail 10150 invoked by uid 109); 5 Apr 2018 22:40:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 22:40:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20170 invoked by uid 111); 5 Apr 2018 22:41:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 18:41:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 18:40:51 -0400
Date:   Thu, 5 Apr 2018 18:40:51 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180405224051.GF29117@sigill.intra.peff.net>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1522893363.git.me@ttaylorr.com>
 <20180405020040.GC8879@syl.local>
 <CAPig+cSr744Y293qvgLG8jLHdNsGypkHU6QUQ-AcOyk=-JAbDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSr744Y293qvgLG8jLHdNsGypkHU6QUQ-AcOyk=-JAbDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 06:29:18PM -0400, Eric Sunshine wrote:

> > +ensure that the variable(s) are of the given type and convert the value to the
> > +canonical form. If no type specifier is passed, no checks or transformations are
> > +performed on the value.
> > @@ -160,30 +158,34 @@ See also <<FILES>>.
> >  --list::
> >         List all variables set in config file, along with their values.
> >
> > ---bool::
> > -       'git config' will ensure that the output is "true" or "false"
> > +--type <type>::
> > +  'git config' will ensure that any input output is valid under the given type
> > +  constraint(s), and will canonicalize outgoing values in `<type>`'s canonical
> > +  form.
> 
> In response to my question[2] about whether the typesetting "[type]"
> meant that it was optional, you responded[1] that it was not, thus
> correctly changed the typesetting to "<type>". However...

Right, "--type" without a specifier means nothing (also, I missed this
in my review, but "input output" in the quoted text?)

> > diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> > @@ -1622,4 +1623,21 @@ test_expect_success 'later legacy specifiers are given precedence' '
> > +test_expect_success '--no-type unsets type specifiers' '
> > +       echo "10" > expect &&
> > +       git config --type=bool --no-type core.number >actual &&
> > +       test_cmp expect actual
> > +'
> 
> What does --no-type mean and why is it being tested? If this is an
> explicitly supported user-facing option, should it be documented? If
> it's not meant to be user-facing, then why are we enforcing its
> presence and behavior via a test?

It would be the same as if no --type option had been given. The current
documentation says:

  If no type specifier is passed, no checks or transformations are
  performed on the value.

That's retained in the DESCRIPTION section, but it may be worth a
mention of the "--no-type" behavior in the OPTIONS section, too. I
dunno.

-Peff
