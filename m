Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 447E1202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 21:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbdJSVKo (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:10:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:58324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753447AbdJSVKn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:10:43 -0400
Received: (qmail 4605 invoked by uid 109); 19 Oct 2017 21:10:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 21:10:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12586 invoked by uid 111); 19 Oct 2017 21:10:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:10:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 17:10:41 -0400
Date:   Thu, 19 Oct 2017 17:10:41 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH 1/5] t4015: refactor --color-moved whitespace test
Message-ID: <20171019211041.yfzlwcxhqb7uwqgh@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
 <20171019202403.7srcpos5xlsvmqrl@sigill.intra.peff.net>
 <CAGZ79kahYb5=BEvr0io-bSJ+JaOfViicyghH4CtRErqmtAXU-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kahYb5=BEvr0io-bSJ+JaOfViicyghH4CtRErqmtAXU-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 01:56:55PM -0700, Stefan Beller wrote:

> On Thu, Oct 19, 2017 at 1:24 PM, Jeff King <peff@peff.net> wrote:
> 
> >
> > +test_expect_success 'clean up whitespace-test colors' '
> > +       git config --unset color.diff.oldMoved &&
> > +       git config --unset color.diff.newMoved
> > +'
> 
> This could be part of the previous test as
> 
>   test_config color.diff.oldMoved "magenta" &&
>   test_config color.diff.newMoved "cyan" &&
> 
> in the beginning. (That way we also do not pollute the setup,
> but keeping it test local).

It used to be in the previous test as test_config, but part of the setup
refactoring is to keep these common bits across several tests.  Hence we
"git config" in the setup step, and we must "git config --unset" here in
the cleanup. There's only the one test between setup/cleanup right now,
but the point is to add more.

The other alternative (besides repeating ourselves) would be to put all
those common bits into a function and call the function at the top of
each test.

-Peff
