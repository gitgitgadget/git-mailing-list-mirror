Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A011C1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 14:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeCNOux (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 10:50:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:56176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751381AbeCNOuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 10:50:52 -0400
Received: (qmail 20669 invoked by uid 109); 14 Mar 2018 14:50:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Mar 2018 14:50:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1093 invoked by uid 111); 14 Mar 2018 14:51:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Mar 2018 10:51:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Mar 2018 10:50:50 -0400
Date:   Wed, 14 Mar 2018 10:50:50 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Running some tests with -x fails
Message-ID: <20180314145050.GA15531@sigill.intra.peff.net>
References: <CAP8UFD29eFPfiW2PjOr4evjB2X=yDWULOgUx2NRM83Mt0FDXUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD29eFPfiW2PjOr4evjB2X=yDWULOgUx2NRM83Mt0FDXUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 14, 2018 at 03:30:30PM +0100, Christian Couder wrote:

> I don't know if this is well known already, but when when I run some
> tests using -x on master they consistently fail (while they
> consistently pass without -x).
> 
> For example:
> 
> ./t5500-fetch-pack.sh -x
> 
> gives: # failed 3 among 353 test(s)
> 
> ./t0008-ignores.sh -x
> 
> gives: # failed 208 among 394 test(s)
> 
> Are we interested in trying to fix those failures or are we ok with them?

This is known; the issue is tests that run shell functions or subshells
and capture their stderr (which then get polluted by "-x" output). You
can either:

  - run the tests with bash, which uses BASH_XTRACEFD to send output
    directly to the terminal (see TEST_SHELL_PATH in recent versions)

  - try 'next'; Gábor has done some work recently to clean up tests so
    that this works even with non-bash shells. See the sg/test-x and
    sg/cvs-tests-with-x topics.

-Peff
