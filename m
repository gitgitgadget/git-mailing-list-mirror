Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0C21F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeAZSri (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:47:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:59080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751378AbeAZSri (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:47:38 -0500
Received: (qmail 16235 invoked by uid 109); 26 Jan 2018 18:47:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 18:47:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17460 invoked by uid 111); 26 Jan 2018 18:48:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Jan 2018 13:48:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2018 13:47:36 -0500
Date:   Fri, 26 Jan 2018 13:47:36 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/10] t: make sure that 'test_i18ngrep' got enough
 parameters
Message-ID: <20180126184736.GF27618@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180126123708.21722-10-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180126123708.21722-10-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 01:37:07PM +0100, SZEDER Gábor wrote:

> Two of the previous patches in this series fixed two bogus
> 'test_i18ngrep' invocations that had neither a filename parameter not
> anything piped into their standard input, yet both managed to remain
> unnoticed for years.  A third similarly bogus invocation is currently
> lurking in 'pu' for a couple of weeks now.

Hrm. At first I thought this was redundant with the stdin thing in the
previous one. But that is only checking "did you _try_ to use stdin".
This is checking "did you accidentally use stdin, which was empty".

But I think maybe it's the opposite; the other one is redundant with
this one, since it would be hard to convince grep to read from stdin
anyway with this.

> Note that this is not quite perfect, as it doesn't account for any
> 'grep --options' given as parameters.  However, doing so would be far
> too complicated, considering that patters can start with dashes as
> well, and in the majority of the cases we don't use any such options
> anyway.

Yeah, I agree this would help most cases, but not hurt in others. I do
think Junio's "see if the final argument is a file" approach seems like
it would cover us pretty accurately, though, without having to get too
intimate with grep options.

-Peff
