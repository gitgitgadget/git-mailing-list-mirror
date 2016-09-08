Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0628120705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932283AbcIHSsK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:48:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:40323 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753270AbcIHSsK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:48:10 -0400
Received: (qmail 9899 invoked by uid 109); 8 Sep 2016 18:48:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 18:48:04 +0000
Received: (qmail 17386 invoked by uid 111); 8 Sep 2016 18:48:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 14:48:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 14:48:01 -0400
Date:   Thu, 8 Sep 2016 14:48:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
Message-ID: <20160908184801.6w3dplmbcdcftxfg@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de>
 <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609061613270.129229@virtualbox>
 <20160906184143.55a5zoa2mj6c2e5m@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609080933470.129229@virtualbox>
 <20160908082246.saf7vlw2xgjo7jvg@sigill.intra.peff.net>
 <xmqqa8fijpmg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8fijpmg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 09:57:43AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Between the two options for regexec_buf(), I think you have convinced me
> > that REG_STARTEND is better than just using compat/regex everywhere. I
> > do think the fallback for platforms like musl should be "use
> > compat/regex" and not doing an expensive copy (which in most cases is
> > not even necessary).
> 
> I agree with you that it would be the best approach to build
> regexec_buf() that unconditionally uses REG_STARTEND and tell people
> without REG_STARTEND to use compat/regex instead of their platform
> regex library.
> 
> The description in Makefile may want to be rephrased to clarify.
> 
> -# Define NO_REGEX if you have no or inferior regex support in your C library.
> +# Define NO_REGEX if your C library lacks regex support with REG_STARTEND
> +# feature.
> 
> The word "inferior" is not giving any useful information there.

Yeah, very much agreed (and the "#error" when we lack REG_STARTEND I
mentioned earlier may be a good hint).

-Peff
