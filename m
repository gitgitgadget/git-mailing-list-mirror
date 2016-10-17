Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC13B2098B
	for <e@80x24.org>; Mon, 17 Oct 2016 02:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbcJQCSc (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 22:18:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:58221 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932533AbcJQCS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 22:18:29 -0400
Received: (qmail 21378 invoked by uid 109); 17 Oct 2016 02:18:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Oct 2016 02:18:27 +0000
Received: (qmail 26170 invoked by uid 111); 17 Oct 2016 02:18:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Oct 2016 22:18:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Oct 2016 22:18:25 -0400
Date:   Sun, 16 Oct 2016 22:18:25 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] convert: mark a file-local symbol static
Message-ID: <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
 <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
 <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
 <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
 <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2016 at 02:37:58AM +0100, Ramsay Jones wrote:

> Hmm, well, you have to remember that 'make clean' sometimes
> doesn't make clean. Ever since the Makefile was changed to only
> remove $(OBJECTS), rather than *.o xdiff/*.o etc., you have to
> remember to 'make clean' _before_ you switch branches. Otherwise,
> you risk leaving some objects laying around. Since the script
> runs 'nm' on all objects it finds, any stale ones can cause problems.
> (Of course, I almost always forget, so I frequently have to manually
> check for and remove stale objects!)

Gross. I would not be opposed to a Makefile rule that outputs the
correct set of OBJECTS so this (or other) scripts could build on it.

IIRC, BSD make has an option to do this "make -V OBJECTS" or something,
but I don't thnk there's an easy way to do so.

Or, since it seems to find useful results quite frequently, maybe it
would be worth including the script inside git (and triggering it with
an optional Makefile rule). It sounds like we'd need a way to annotate
known false positives, but if it were in common use, it would be easier
to get people to keep that list up to date.

-Peff
