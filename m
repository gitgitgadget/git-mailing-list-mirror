Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0571202BB
	for <e@80x24.org>; Fri, 15 Mar 2019 06:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfCOGWu (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 02:22:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:52010 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727151AbfCOGWu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 02:22:50 -0400
Received: (qmail 16098 invoked by uid 109); 15 Mar 2019 06:22:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 06:22:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29626 invoked by uid 111); 15 Mar 2019 06:21:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Mar 2019 02:21:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Mar 2019 02:21:33 -0400
Date:   Fri, 15 Mar 2019 02:21:33 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/2] enable bitmap hash-cache by default
Message-ID: <20190315062133.GA13385@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <20190314160256.GA1573@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190314160256.GA1573@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 12:02:56PM -0400, Jeff King wrote:

> On Thu, Mar 14, 2019 at 09:12:54AM +0000, Eric Wong wrote:
> 
> > > The reason it defaults to off is for on-disk compatibility with JGit.
> > 
> > Right.  Our documentation seems to indicate JGit just warns (but
> > doesn't fall over), so maybe that can be considered separately.
> 
> I think it was a hard error in the beginning, but they changed it pretty
> soon after we added more flags. So it might be reasonable to just enable
> it by default (but it wouldn't hurt to double check the behavior).
> 
> I tried running t5310 (which does a back-and-forth with jgit) using this
> patch:

I dug up the actual JGit change, and it was indeed from 2014. So here's
a more complete series to handle that. There's a minor performance
mystery in the second patch, but I think it might be OK to proceed even
without solving it.

Conceptually these go on top of your patch, but they could be applied
separately.

  [1/2]: t5310: correctly remove bitmaps for jgit test
  [2/2]: pack-objects: default to writing bitmap hash-cache

 Documentation/config/pack.txt      | 4 +---
 builtin/pack-objects.c             | 2 +-
 t/perf/p5310-pack-bitmaps.sh       | 3 +--
 t/perf/p5311-pack-bitmaps-fetch.sh | 1 -
 t/t5310-pack-bitmaps.sh            | 5 ++---
 5 files changed, 5 insertions(+), 10 deletions(-)

-Peff
