Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B681F856
	for <e@80x24.org>; Thu,  8 Sep 2016 20:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753883AbcIHUIY (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 16:08:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:40376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753816AbcIHUIX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 16:08:23 -0400
Received: (qmail 14723 invoked by uid 109); 8 Sep 2016 20:08:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 20:08:23 +0000
Received: (qmail 17950 invoked by uid 111); 8 Sep 2016 20:08:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 16:08:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 16:08:20 -0400
Date:   Thu, 8 Sep 2016 16:08:20 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before
 email signature
Message-ID: <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net>
References: <20160908011200.qzvbdt4wjwiji4h5@x>
 <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
 <20160908185408.5qtfnztjbastlrtw@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160908185408.5qtfnztjbastlrtw@x>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 11:54:08AM -0700, Josh Triplett wrote:

> > your problem description
> > looks perfect.  I am still not sure if the code does a reasonable
> > thing in MIME case, though.
> 
> It *looks* correct to me.

Hmm. It looks correct to me, too; we stick it just after the patch, so
with "--attach" it is part of the text/x-patch, which is reasonable.

But looking at the results of "--attach" from _before_ your patch, it
looks totally broken. The "base" information comes _after the final
delimiter of the multipart/mixed. Most mailers would just throw it away
when decoding the multipart, I think.

So this is actually fixing a bug, and you could probably add a test
(though I am not sure we have anything in git that actually parses
multipart messages _or_ that carefully consumes the base-commit info, so
it might be hard to test in practice).

-Peff
