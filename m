Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC0C1FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 06:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750771AbdFNGCX (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 02:02:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:39712 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbdFNGCX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 02:02:23 -0400
Received: (qmail 767 invoked by uid 109); 14 Jun 2017 06:02:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 06:02:23 +0000
Received: (qmail 8578 invoked by uid 111); 14 Jun 2017 06:02:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 02:02:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 02:02:20 -0400
Date:   Wed, 14 Jun 2017 02:02:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] alias_lookup(): optionally return top-level
 directory
Message-ID: <20170614060220.pjb26zqgbtbtpxpy@sigill.intra.peff.net>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
 <aa6601bbfa50c728b7820e0a2991da76288509a5.1496951503.git.johannes.schindelin@gmx.de>
 <20170610101813.n26wmxcueicecptz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1706131319130.171564@virtualbox>
 <alpine.DEB.2.21.1.1706131339320.171564@virtualbox>
 <20170613114254.oo6r6oqwtchvjuim@sigill.intra.peff.net>
 <xmqqefun96y6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefun96y6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 09:40:49AM -0700, Junio C Hamano wrote:

> >> It is really tempting to avoid the extra strbuf, but then the error
> >> message would change from
> >> 
> >> 	error: missing value for 'alias.br'
> >> 
> >> to
> >> 
> >> 	error: missing value for 'br'
> >> 
> >> which is of course no good at all.
> >> 
> >> And since I already have to keep that strbuf, I'll simply keep the
> >> config_key_is_valid() guard, too (because why not).
> >
> > Oof, yeah, that is definitely worse. I'm fine with keeping both parts.
> 
> When you replace Dscho's "compare 'var' with 'alias.br' that is in
> strbuf naively with the "skip-prefix and compare with br" without
> changing anything else, i.e.
> 
>     if (skip_prefix(var, "alias.", &key) && !strcmp(key, data->key))
> 	return git_config_string((const char **)&data->v, key, value);
> 
> it would cause the "br" to be fed to git_config_string() and result
> in problem reported for "br", not "alias.br".  
> 
> But this can be trivially fixed by passing "var" instead of "key" to
> git_config_string(), no?  Am I mistaken?

Right, I wasn't thinking. That is a perfectly good solution, and matches
the usual mechanism in other config callbacks.

-Peff
