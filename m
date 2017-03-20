Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21F420323
	for <e@80x24.org>; Mon, 20 Mar 2017 03:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbdCTDot (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 23:44:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:47321 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdCTDos (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 23:44:48 -0400
Received: (qmail 22770 invoked by uid 109); 20 Mar 2017 03:44:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 03:44:47 +0000
Received: (qmail 29081 invoked by uid 111); 20 Mar 2017 03:45:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Mar 2017 23:45:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Mar 2017 23:44:43 -0400
Date:   Sun, 19 Mar 2017 23:44:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 3/8] tag: Change  misleading --list <pattern>
 documentation
Message-ID: <20170320034443.wq2uf4yabsxh2nji@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com>
 <20170318103256.27141-4-avarab@gmail.com>
 <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 11:43:47AM -0700, Junio C Hamano wrote:

> > +test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
> > +	git tag -l -l >actual &&
> > +	test_cmp expect actual &&
> > +	git tag --list --list >actual &&
> > +	test_cmp expect actual &&
> > +	git tag --list -l --list >actual &&
> > +	test_cmp expect actual
> > +'
> 
> OK.  I do not care too deeply about this one, but somebody may want
> to tighten up the command line parsing to detect conflicting or
> duplicated cmdmode as an error in the future, and at that time this
> will require updating.  I am not sure if we want to promise that
> giving multiple -l will keep working.

I think it's expected to work under the usual last-one-wins option
parsing. A more subtle case is that:

  git tag -l -d foo

would override "-l" with "-d". That's reasonable under the same rule as
long as the user knows that the two are mode-selectors. I don't think we
make that explicit in the documentation, though, so perhaps it isn't
something users should rely on.

-Peff
