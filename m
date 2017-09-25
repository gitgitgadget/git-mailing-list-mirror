Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68BF202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 12:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbdIYM2r (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 08:28:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:49156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752129AbdIYM2r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 08:28:47 -0400
Received: (qmail 12038 invoked by uid 109); 25 Sep 2017 12:28:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 12:28:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24649 invoked by uid 111); 25 Sep 2017 12:29:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 08:29:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 08:28:44 -0400
Date:   Mon, 25 Sep 2017 08:28:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] mailinfo: don't decode invalid =XY quoted-printable
 sequences
Message-ID: <20170925122844.lwzwtp2u4dhgijrd@sigill.intra.peff.net>
References: <d48b3d67-5f03-19f3-5a32-ec7e8397c98d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d48b3d67-5f03-19f3-5a32-ec7e8397c98d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 08:04:40PM +0200, René Scharfe wrote:

> Decode =XY in quoted-printable segments only if X and Y are hexadecimal
> digits, otherwise just copy them.  That's at least better than
> interpreting negative results from hexval() as a character.

Thanks, this looks good to me overall.

I wondered if we should die() here, but walking over cruft may be more
friendly. The base64 case does the same, though it actually ignores the
bytes rather than copying them. Since this is never _supposed_ to
happen, it's hard to say what behavior would be preferable without
seeing a real-world broken case.

-Peff
