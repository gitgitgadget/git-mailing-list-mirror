Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F8D201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933823AbdBVXpk (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:45:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:60348 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934354AbdBVXpi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 18:45:38 -0500
Received: (qmail 1636 invoked by uid 109); 22 Feb 2017 23:45:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 23:45:38 +0000
Received: (qmail 16537 invoked by uid 111); 22 Feb 2017 23:45:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 18:45:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 18:45:35 -0500
Date:   Wed, 22 Feb 2017 18:45:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] t: add multi-parent test of diff-tree --stdin
Message-ID: <20170222234535.h7krqqnhwiwllf4v@sigill.intra.peff.net>
References: <20170222232215.u2agozagwsyy2ooe@genre.crustytoothpaste.net>
 <20170222233838.925157-1-sandals@crustytoothpaste.net>
 <xmqqfuj5aj32.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuj5aj32.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 03:42:25PM -0800, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > We were lacking a test that covered the multi-parent case for commits.
> > Add a basic test to ensure we do not regress this behavior in the
> > future.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  t/t4013-diff-various.sh | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > It's a little bit ugly to me that this test hard-codes so many values,
> > and I'm concerned that it may be unnecessarily brittle.  However, I
> > don't have a good idea of how to perform the kind of comprehensive test
> > we need otherwise.
> 
> Hmph, perhaps the expectation can be created out of the output from
> 'git diff-tree master^ master' or something?

I had a similar thought. It may also be worth testing that:

  echo "$(git rev-parse master) $(git rev-parse other)" | git diff-tree --stdin

shows the diff between "other" and "master", and not just "master^" and
"master" (i.e., it is not clear from the test expectation that the code
actually is parsing the second parent and not accidentally ignoring it).

For completeness, it would probably make sense to test the multi-parent
case, too.

-Peff
