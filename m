Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5E71F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeAZSXG (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:23:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:58998 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751281AbeAZSXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:23:05 -0500
Received: (qmail 15013 invoked by uid 109); 26 Jan 2018 18:23:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 18:23:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17158 invoked by uid 111); 26 Jan 2018 18:23:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Jan 2018 13:23:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2018 13:23:03 -0500
Date:   Fri, 26 Jan 2018 13:23:03 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] t5541: add 'test_i18ngrep's missing filename
 parameter
Message-ID: <20180126182303.GA27618@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180126123708.21722-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180126123708.21722-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 01:36:59PM +0100, SZEDER Gábor wrote:

> The test 'push --no-progress silences progress but not status' runs
> 'test_i18ngrep' without specifying a filename parameter.  This has
> remained unnoticed since its introduction in e304aeba2 (t5541: test
> more combinations of --progress, 2012-05-01), because that
> 'test_i18ngrep' is supposed to check that the given pattern is not
> present in its input, and of course it won't find that pattern if its
> input is empty, (as it comes from /dev/null).  This also means that
> this test could miss a potential breakage of 'git push --no-progress'.

Oof, embarrassing. Thanks for catching.

This and other errors make me wonder if test_i18ngrep ought to take an
explicit "-" for stdin, and error out if no file argument is given. That
may be overkill, though (and it's not like we wouldn't have the same
problem with regular "grep").

-Peff
