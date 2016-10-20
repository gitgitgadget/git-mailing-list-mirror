Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B9820229
	for <e@80x24.org>; Thu, 20 Oct 2016 21:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbcJTVDF (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:03:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:60252 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755365AbcJTVDE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:03:04 -0400
Received: (qmail 2220 invoked by uid 109); 20 Oct 2016 21:03:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 21:03:04 +0000
Received: (qmail 30008 invoked by uid 111); 20 Oct 2016 21:03:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 17:03:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 17:03:01 -0400
Date:   Thu, 20 Oct 2016 17:03:01 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Drastic jump in the time required for the test suite
Message-ID: <20161020210301.fwuskzylrj6u23ja@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610201154070.3264@virtualbox>
 <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net>
 <530a3bca-e251-cb43-fb6a-e99c1e64a0a7@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <530a3bca-e251-cb43-fb6a-e99c1e64a0a7@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 10:38:23PM +0200, Johannes Sixt wrote:

> Am 20.10.2016 um 14:31 schrieb Jeff King:
> > Close to 1/3 of those processes are just invoking the bin-wrapper
> > script to set up the EXEC_PATH, etc. I imagine it would not be too hard
> > to just do that in the test script. In fact, it looks like:
> > 
> >   make prefix=/wherever install
> >   GIT_TEST_INSTALLED=/wherever/bin make test
> > 
> > might give you an immediate speedup by skipping bin-wrappers entirely.
> 
> Running the tests with --with-dashes should give you the same effect, no?

Yeah, looks like it. it still uses bin-wrappers for t/helper, but that
should be a minority of calls.

Which I think explains why I saw some test failures with the
GIT_TEST_INSTALLED above. It does not know about t/helper, but relies on
those programs being present in $GIT_BUILD_DIR. So I suspect it has been
totally broken since e6e7530d10 (test helpers: move test-* to t/helper/
subdirectory, 2016-04-13).

-Peff
