Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16BB41F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 04:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755949AbcIWEsB (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 00:48:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:47028 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755125AbcIWEsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 00:48:00 -0400
Received: (qmail 28488 invoked by uid 109); 23 Sep 2016 04:48:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 04:48:00 +0000
Received: (qmail 14666 invoked by uid 111); 23 Sep 2016 04:48:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 00:48:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2016 00:47:57 -0400
Date:   Fri, 23 Sep 2016 00:47:57 -0400
From:   Jeff King <peff@peff.net>
To:     Anatoly Borodin <anatoly.borodin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug? Short command line options
Message-ID: <20160923044757.7pwwzkqzkb2fqa7l@sigill.intra.peff.net>
References: <ns19t4$s0t$1@blaine.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ns19t4$s0t$1@blaine.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 07:03:00PM +0000, Anatoly Borodin wrote:

> is there a good reason why
> 
> 	git fetch -vpnf
> 
> works like
> 
> 	git fetch -v -p -n -f
> 
> and
> 	
> 	git commit -avem msg
> 
> works like
> 
> 	git commit -a -v -e -m msg
> 
> etc etc, but
> 
> 	git log -wWp
> 
> says
> 
> 	fatal: unrecognized argument: -wWp

Yes. The reason is that the arguments to git-log are passed to the
revision.c parser, which predates our parse_options() infrastructure,
and does not understand bundled options.

It could be updated to use parse_options(), but nobody has done so yet.

-Peff
