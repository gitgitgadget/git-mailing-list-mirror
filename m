Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E5920401
	for <e@80x24.org>; Tue, 13 Jun 2017 11:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdFML2w (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 07:28:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:38987 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbdFML2w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 07:28:52 -0400
Received: (qmail 29346 invoked by uid 109); 13 Jun 2017 11:28:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 11:28:51 +0000
Received: (qmail 23548 invoked by uid 111); 13 Jun 2017 11:28:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 07:28:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jun 2017 07:28:50 -0400
Date:   Tue, 13 Jun 2017 07:28:50 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] config: report correct line number upon error
Message-ID: <20170613112849.vvgmwnxlrfztyf5x@sigill.intra.peff.net>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
 <291e8b643990aee04654b34c6f953387c3c030d4.1496951503.git.johannes.schindelin@gmx.de>
 <20170610090424.zibu4sgd2lr7ghfk@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1706131256400.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706131256400.171564@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 01:02:49PM +0200, Johannes Schindelin wrote:

> > +test_expect_success 'invalid path' '
> > +	echo "[bool]var" >invalid &&
> > +	test_must_fail git config -f invalid --path bool.var 2>actual &&
> > +	test_i18ngrep "line 1" actual
> > +'
> > +
> >  test_expect_success 'invalid stdin config' '
> >  	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
> >  	test_i18ngrep "bad config line 1 in standard input" output
> > 
> > which currently reports "line 2" instead of line 1.
> 
> Mmmmkay.
> 
> I am always reluctant to add *even more* stuff to the test suite, in
> particular since my patch series implicitly changes t1308 to test for this
> very thing.

If there's another test that covers this, I'm happy to use that. I just
didn't notice it.

> > > +	if (!ret)
> > > +		cf->linenr++;
> > >  	return ret;
> > >  }
> > 
> > I think this should be "if (ret < 0)". The caller only considers it an
> > error if get_value() returns a negative number. As you have it here, I
> > think a config callback which returned a positive number would end up
> > with nonsense line numbers.
> 
> I think you are half-correct: it should be `if (ret >= 0)` (the linenr
> needs to be modified back in case of success, not in case of failure, in
> case of failure there will be some reporting going on that needs the same
> line number as `fn()` had seen).

Oops, right.

-Peff
