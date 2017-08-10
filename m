Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06697208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbdHJUFF (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:05:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:35136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752807AbdHJUFE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 16:05:04 -0400
Received: (qmail 25645 invoked by uid 109); 10 Aug 2017 20:05:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 20:05:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9116 invoked by uid 111); 10 Aug 2017 20:05:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 16:05:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 16:05:02 -0400
Date:   Thu, 10 Aug 2017 16:05:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: fatal: Out of memory, getdelim failed under NFS mounts
Message-ID: <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 09:58:37PM +0200, René Scharfe wrote:

> > So the function is returning -1 and leaving ENOMEM in errno on
> > Yaroslav's system.
> > 
> > I wonder if we are truly hitting out of memory, though.  The same
> > symptom could bee seen if getdelim() does not touch errno when it
> > returns -1, but some other system call earlier set it to ENOMEM,
> > for example.
> 
> That can happen when the end of a file is reached; getdelim() returns
> -1 and leaves errno unchanged.  So we need to set errno to 0 just
> before that call.

Good catch. That's a bug in my original conversoin of
strbuf_getwholeline().

-Peff
