Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A57A20248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfB1VaS (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:30:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:33496 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728113AbfB1VaS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:30:18 -0500
Received: (qmail 31256 invoked by uid 109); 28 Feb 2019 21:30:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 21:30:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23932 invoked by uid 111); 28 Feb 2019 21:30:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 16:30:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 16:30:15 -0500
Date:   Thu, 28 Feb 2019 16:30:15 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 09/20] ref-filter: make expand_data global
Message-ID: <20190228213015.GI12723@sigill.intra.peff.net>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
 <0102016915f49a58-dc12f07d-00e6-42be-812b-3072d33910d3-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102016915f49a58-dc12f07d-00e6-42be-812b-3072d33910d3-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 04:05:45PM +0000, Olga Telezhnaya wrote:

> Put struct expand_data into global scope to reuse it
> in cat-file.

So this is the payoff for moving all those things out of expand_data.
Instead of just replicating the bits it needs in ref-filter, we're
making it globally available.

At this point in the series, I'm still unconvinced that this is the
right direction, but I haven't read all the way to the end yet.

This probably needs a better name. In the context of cat-file,
expand_data is the data struct we feed to strbuf_expand(). But in the
global namespace of all of Git, it needs a more descriptive name.

This likely goes away (or becomes private to ref-filter.c) in the end,
but it probably needs a different name there, too. We're not calling
strbuf_expand() from there.

-Peff
