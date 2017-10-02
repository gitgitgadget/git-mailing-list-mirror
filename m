Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0160D202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdJBFS6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:18:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:57066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751162AbdJBFS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:18:58 -0400
Received: (qmail 6162 invoked by uid 109); 2 Oct 2017 05:18:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:18:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25274 invoked by uid 111); 2 Oct 2017 05:19:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:19:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:18:56 -0400
Date:   Mon, 2 Oct 2017 01:18:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: use strbuf_add() to add a buffer to a strbuf
Message-ID: <20171002051855.f3g2sz32ysjd6xu4@sigill.intra.peff.net>
References: <85605bc6-2e91-7132-ce63-f6e08a08a768@web.de>
 <223ef0c8-dac2-747b-41c8-3bad62f4c274@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <223ef0c8-dac2-747b-41c8-3bad62f4c274@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:54:14PM +0200, René Scharfe wrote:

> This is shorter, easier and makes the intent clearer.
> 
> Patch generated with Coccinelle and contrib/coccinelle/strbuf.cocci.

Technically this behaves differently if there is a NUL embedded in the
string. I'd expect that to be unlikely in most cases. And when it is
possible, I'd venture to say that the new behavior is likely to be the
correct one.

This case is fine (and any embedded NUL would be cut off by setenv
anyway).  As a general transformation, this is not as obviously safe as
many of the others.  But since we eyeball the output of coccinelle
anyway, it should be fine (and any code which is _relying_ on that
behavior really ought to be rewritten in a less subtle way).

-Peff
