Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E20E1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 15:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765568AbdDSPKK (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 11:10:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:36107 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765312AbdDSPKH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 11:10:07 -0400
Received: (qmail 13379 invoked by uid 109); 19 Apr 2017 15:10:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Apr 2017 15:10:07 +0000
Received: (qmail 23787 invoked by uid 111); 19 Apr 2017 15:10:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Apr 2017 11:10:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Apr 2017 11:10:05 -0400
Date:   Wed, 19 Apr 2017 11:10:05 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH] parse-options: disallow double-negations of options
 starting with no-
Message-ID: <20170419151005.wolvxiacjqxoqrq3@sigill.intra.peff.net>
References: <20170419090820.20279-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170419090820.20279-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 02:08:20AM -0700, Jacob Keller wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Many options can be negated by prefixing the option with "no-", for
> example "--3way" can be prefixed with "--no-3way" to disable it. Since
> 0f1930c58754 ("parse-options: allow positivation of options
> starting, with no-", 2012-02-25) we have also had support to negate
> options which start with "no-" by using the positive wording.
> 
> This leads to the confusing (and non-documented) case that you can still
> prefix options beginning with "no-" by a second "no-" to negate them.
> That is, we allow "no-no-hardlinks" to negate the "no-hardlinks" option.
> 
> This can be confusing to the user so lets just disallow the
> double-negative forms. If the long_name begins with "no-" then we simply
> don't allow the regular negation format, and only allow the option to be
> negated by the positive form.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> I started going about implementing an OPT_NEGBOOL as suggested by Peff,
> but realized this might just be simpler, and we already support the
> positive format for the negation, so we don't lose expressiveness. We
> *might* want to tie this to an option flag instead so that it only kicks
> in if the option specifically requests it. Thoughts?

Yeah, if we are going to do anything, this is the right thing to do.

I am on the fence on whether it actually needs addressing or not. Sure,
--no-no-foo looks silly, but if the only way it happens is that the user
typed it, it doesn't seem so bad to me to respect it. I am tempted to
say we should support arbitrary levels of "no-" parsing as an easter
egg, but that is probably silly. :)

So I am fine with this patch, or without it.

-Peff
