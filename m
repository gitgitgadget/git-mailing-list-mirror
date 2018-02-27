Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952751F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeB0WSL (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:18:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:39612 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751744AbeB0WSK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:18:10 -0500
Received: (qmail 10566 invoked by uid 109); 27 Feb 2018 22:18:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 22:18:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28347 invoked by uid 111); 27 Feb 2018 22:18:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 17:18:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 17:18:08 -0500
Date:   Tue, 27 Feb 2018 17:18:08 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
Message-ID: <20180227221808.GE11187@sigill.intra.peff.net>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-15-bmwill@google.com>
 <20180221145411.35b2ea84747518a499276bdd@google.com>
 <20180222181922.GD185096@google.com>
 <20180222182657.GE19035@sigill.intra.peff.net>
 <20180222112533.0d7c6023fb8e4098efedfe31@google.com>
 <20180227062128.GG65699@aiede.svl.corp.google.com>
 <xmqq8tbep02f.fsf@gitster-ct.c.googlers.com>
 <20180227220443.GB11187@sigill.intra.peff.net>
 <CAPig+cS+G-xC51n-Ud0Wbmcc-zeHBM3-5WQQAFm9gwm9LNk3Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cS+G-xC51n-Ud0Wbmcc-zeHBM3-5WQQAFm9gwm9LNk3Gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 05:10:09PM -0500, Eric Sunshine wrote:

> > That would be fine with me. Though I would love it if we could find a
> > shorter name for the associated functions. For example,
> > argv_array_pushf() can make lines quite long, and something like
> > argv_pushf() is easier to read (in my opinion). And that might work
> > because "argv" is pretty unique by itself, but "string" is not.
> >
> > Some one-word name like "strarray" might work, though I find that is not
> > quite catchy. I guess "strv" is short if you assume that people know the
> > "v" suffix means "vector".
> 
> struct strs {...};
> 
> void strs_init(struct strs *);
> void strs_push(struct strs *, const char *);
> void strs_pushf(struct strs *, const char *fmt, ...);
> void strs_pushl(struct strs *, ...);
> void strs_pushv(struct strs *, const char **);
> void strs_pop(struct strs *);
> void strs_clear(struct strs *);
> const char **strs_detach(struct strs *);
> 
> ...is short, feels pretty natural, and doesn't require understanding
> "v" for "vector".

Not bad. The "v" carries the information that it _is_ a NULL-terminated
vector and not some other list-like structure (and so is suitable for
feeding to execv, etc). But that may just be obvious from looking at its
uses and documentation.

-Peff
