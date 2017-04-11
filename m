Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86831FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbdDKKrs (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:47:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:59831 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753095AbdDKKrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:47:46 -0400
Received: (qmail 25398 invoked by uid 109); 11 Apr 2017 10:47:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:47:42 +0000
Received: (qmail 977 invoked by uid 111); 11 Apr 2017 10:48:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:48:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:47:40 -0400
Date:   Tue, 11 Apr 2017 06:47:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/12] PCREv2 & more
Message-ID: <20170411104739.xzhxggpufvwgr3fu@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:24:54PM +0000, Ævar Arnfjörð Bjarmason wrote:

> This adds PCRE v2 support, but as I was adding that I kept noticing
> other related problems to fix. It's all bundled up into the same
> series because much of it conflicts because it modifies the same test
> or other code. Notes on each patch below.

Overall, the series looks OK to me.

I'm not sure if it is worth all the complexity to carry pcre1/pcre2 as
run-time options. That does make it easier to do back-to-back
comparisons, but it makes the code a lot more complicated. In particular
I'm worried about subtle cases where we pcre1 turns into pcre2 (or vice
versa) by use of the aliases. That shouldn't matter to a user for
correctness, but it would throw off the benchmarking.

If we literally just added USE_LIBPCRE2 and built against one or the
other, then all the complexity would be limited to a few #ifdefs. The
big drawback AFAICT is that anybody doing timing tests would have to
recompile in between.

So I dunno. I had hoped libpcre2 would be a hands-down win on timing,
but it sounds like there's a little back-and-forth depending on the
context. Is there a ticking clock on pcre1 going away? I suspect it will
be around for many years to come, but if they'll continue optimizing
pcre2 but not pcre1, then it may make sense to hitch our wagon to the
one that upstream is actually working on.

-Peff
