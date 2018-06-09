Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E7C1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 09:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeFIJU7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 05:20:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:39980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753178AbeFIJU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 05:20:58 -0400
Received: (qmail 27260 invoked by uid 109); 9 Jun 2018 09:20:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 09:20:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2257 invoked by uid 111); 9 Jun 2018 09:21:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 05:21:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 05:20:56 -0400
Date:   Sat, 9 Jun 2018 05:20:56 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: avoid looking at NULL blob->object
Message-ID: <20180609092056.GB6817@sigill.intra.peff.net>
References: <20180609083159.GA6158@sigill.intra.peff.net>
 <CACsJy8Cpd_0CR9F_xyQfcw0j8ceOf777KcWXLHuxY1NxmRnXqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Cpd_0CR9F_xyQfcw0j8ceOf777KcWXLHuxY1NxmRnXqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 10:45:15AM +0200, Duy Nguyen wrote:

> > It seems like we could refactor report() to just take the
> > object_id itself. But we pass the object pointer along to
> > a callback function, and indeed this ends up in
> > builtin/fsck.c's objreport() which does want to look at
> > other parts of the object (like the type).
> 
> And objreport() can handle OBJ_NONE well, which is the type given by
> lookup_unknown_object(). So yeah this looks good.

Actually, we know that we have some "real" type, because otherwise
lookup_blob() would not have returned NULL. In fact, we could actually
use lookup_object() here to find that object, knowing that it exists in
the hash. But IMHO that would be depending too much on how lookup_blob()
works. :)

-Peff
