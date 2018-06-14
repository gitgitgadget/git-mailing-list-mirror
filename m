Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742CE1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 21:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755447AbeFNVBf (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 17:01:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:45002 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755378AbeFNVBf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 17:01:35 -0400
Received: (qmail 31378 invoked by uid 109); 14 Jun 2018 21:01:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Jun 2018 21:01:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15287 invoked by uid 111); 14 Jun 2018 21:01:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 17:01:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 17:01:33 -0400
Date:   Thu, 14 Jun 2018 17:01:33 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Christian Halstrick' <christian.halstrick@gmail.com>,
        'Git' <git@vger.kernel.org>
Subject: Re: OAuth2 support in git?
Message-ID: <20180614210132.GA12460@sigill.intra.peff.net>
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
 <20180614101342.GO38834@genre.crustytoothpaste.net>
 <20180614151507.GA6933@sigill.intra.peff.net>
 <003c01d40420$bd522990$37f67cb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <003c01d40420$bd522990$37f67cb0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 04:46:10PM -0400, Randall S. Becker wrote:

> > I suspect (2) would fit in with the existing code better, as the special case
> > would mostly be limited to the manner in which we feed the credential to
> > curl. And you could probably just set a config option for "this url's auth will
> > be oauth2", and use the existing mechanisms for providing the password.
> > 
> > We'd maybe also want to allow credential helpers to say "by the way, this
> > password should be treated as a bearer token", for cases where you might
> > sometimes use oauth2 and sometimes a real password.
> 
> Be aware that there are 4 (ish) flavours of OAuth2 the last time I
> checked. It is important to know which one (or all) to implement. The
> embedded form is probably the easiest to comprehend - and the least
> implemented from my research. More common OAuth2 instances use a
> third-man website to hold session keys and authorization. That may be
> problematic for a whole bunch of us who do not play in that world.

I think Git's usage would be limited to "how do I present this token for
my requests". I don't think we'd ever recognize an oauth redirect and
try to fulfill it ourselves.  We'd rely on getting a 401 and punting all
those bits to a credential helper to do the heavy lifting.

I say that not knowing much about oauth2, of course, so maybe there
would be complications with that approach (I do know there are multiple
ways you can present a token, but we'd support whichever ones people are
interested in enough to show up and provide a patch for).

-Peff
