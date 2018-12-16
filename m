Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47901F405
	for <e@80x24.org>; Sun, 16 Dec 2018 10:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeLPKpA (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 05:45:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:43244 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729811AbeLPKpA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 05:45:00 -0500
Received: (qmail 24155 invoked by uid 109); 16 Dec 2018 10:45:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Dec 2018 10:45:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22325 invoked by uid 111); 16 Dec 2018 10:44:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Dec 2018 05:44:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2018 05:44:58 -0500
Date:   Sun, 16 Dec 2018 05:44:58 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] A few Asciidoctor-fixes
Message-ID: <20181216104458.GC13704@sigill.intra.peff.net>
References: <20181215112742.1475882-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181215112742.1475882-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 15, 2018 at 12:27:38PM +0100, Martin Ågren wrote:

> I have (ab)used doc-diff to try to find instances where Asciidoctor and
> Asciidoc render our documentation differently. (See [1] for details on
> the hack.) This series fixes the differences that somehow stood out in
> the diff. Many smaller differences remain.

I think the relevant bits from [1] are:

 * Use `make --always-make ... install-man` in doc-diff.
 * ./doc-diff -f HEAD HEAD # note -f
 * Add empty commit and tweak config.mak
 * ./doc-diff HEAD^ HEAD # note no -f

To make this easier, it would make sense to me to:

  - teach doc-diff a flag for marking one or both of the endpoints to be
    built with asciidoctor versus asciidoc

  - mark the asciidoc/asciidoctor in the directory name. That name
    serves as a cache key for avoiding re-doing the work, you should be
    able to just:

      ./doc-diff --asciidoctor HEAD HEAD

    and actually build and compare what you want.

  - it sounds from "make --always-make" that our Makefile does not
    properly rebuild when we switch from asciidoc to asciidoctor. That
    might be nice to fix with a mechanism similar to the GIT-BUILD-FLAGS
    we use in the top-level Makefile.

-Peff
