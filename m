Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2D1C20D09
	for <e@80x24.org>; Mon, 17 Apr 2017 01:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757254AbdDQBhl (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 21:37:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:34558 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757177AbdDQBhj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 21:37:39 -0400
Received: (qmail 13454 invoked by uid 109); 17 Apr 2017 01:37:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Apr 2017 01:37:37 +0000
Received: (qmail 20368 invoked by uid 111); 17 Apr 2017 01:37:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 21:37:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Apr 2017 21:37:33 -0400
Date:   Sun, 16 Apr 2017 21:37:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] server-info: avoid calling fclose(3) twice in
 update_info_file()
Message-ID: <20170417013733.ga362sz67n7vbt32@sigill.intra.peff.net>
References: <137d732f-7a23-8a8a-9f2b-7f16bb361c5a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <137d732f-7a23-8a8a-9f2b-7f16bb361c5a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 16, 2017 at 06:55:58PM +0200, René Scharfe wrote:

> If an error occurs when or after closing the stream we call fclose(3)
> again in the error handler.  The second call can exhibit undefined
> behavior, so make sure to call fclose(3) at most once.

Yikes. Good catch.

> Also avoid
> calling close(2) after fd has been successfully associated with the
> stream, as fclose(3) has become responsible for doing that beyond
> this point.

Yeah, the "else if" in the error-code was supposed to handle that, but
it comes back when you fix the double-fclose by setting fp to NULL.

So the whole thing looks good to me. Thanks for cleaning up my mess.

-Peff
