Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDDE21FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbcLAU0G (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:50144 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751468AbcLAU0F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:05 -0500
Received: (qmail 14621 invoked by uid 109); 1 Dec 2016 20:26:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 20:26:05 +0000
Received: (qmail 3449 invoked by uid 111); 1 Dec 2016 20:26:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 15:26:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 15:26:03 -0500
Date:   Thu, 1 Dec 2016 15:26:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] compat: add qsort_s()
Message-ID: <20161201202602.sfs6ycmh32ib5ed7@sigill.intra.peff.net>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
 <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
 <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
 <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
 <xmqqy3zz8kmq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3zz8kmq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 12:22:37PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Eh, wait.  BSD and Microsoft have paramters reordered in the
> > callback comparison function.  I suspect that would not fly very
> > well.
> 
> Hmm.  We could do it like this, which may not be too bad.

Heh. Exactly, but I was too lazy to write it out in my other email. :)

The no-cost version would be more like:

#ifdef APPLE_QSORT_R
#define DECLARE_CMP(func) int func(void *data, const void *va, const void *vb)
#else
#define DECLARE_CMP(func) int func(const void *va, const void *vb, void *data)
#endif

and then:

  DECLARE_CMP(foocmp);
  ...

  DECLARE_CMP(foocmp)
  {
	const struct foo *a = va, *b = vb;
	... etc ...
  }

-Peff
