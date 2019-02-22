Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4017720248
	for <e@80x24.org>; Fri, 22 Feb 2019 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfBVP33 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 10:29:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:54506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726214AbfBVP32 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 10:29:28 -0500
Received: (qmail 1823 invoked by uid 109); 22 Feb 2019 15:29:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 15:29:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28914 invoked by uid 111); 22 Feb 2019 15:29:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 10:29:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 10:29:26 -0500
Date:   Fri, 22 Feb 2019 10:29:26 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v2 6/6] Makefile: allow for combining DEVELOPER=1 and
 CFLAGS="..."
Message-ID: <20190222152926.GC21524@sigill.intra.peff.net>
References: <20190222105658.26831-1-avarab@gmail.com>
 <20190222144127.32248-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222144127.32248-7-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 03:41:27PM +0100, Ævar Arnfjörð Bjarmason wrote:

> So let's introduce a "DEVELOPER_CFLAGS" variable in config.mak.dev and
> add it to ALL_CFLAGS. Before this the ALL_CFLAGS variable
> would (basically, there's some nuance we won't go into) be set to:

Yeah, I definitely think this is the right direction, and the patch
looks good to me.

> Examples of things that weren't possible before, but are now:
> 
>     # Use -O0 instead of -O2 for less painful debuggng
>     DEVELOPER=1 CFLAGS="-O0 -g"

Sort an aside, but in my config.mak I have:

  O=0
  CFLAGS = -g -O$(O)

which lets me do "make O=2", which is nice and short. I wonder if other
people would want that, too.

(I default to -O0 because 99% of my compiles are for development and
debugging, so the compile being fast is more important than the build
result being fast; for perf testing or daily use, I use O=2).

> So we could have gotten away with the much smaller change of changing
> "CFLAGS" in config.mak.dev to "DEVELOPER_CFLAGS" and adding that to
> ALL_CFLAGS earlier in the Makefile "before" the config.mak.*
> includes. But I think it's more readable to use variables "after"
> they're included.

I think the reordering does make things more readable overall. And it
may be more sensible if config.mak uses any ":=" assignments.

-Peff
