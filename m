Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F191F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389281AbfAOTOD (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:14:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:37254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729645AbfAOTOB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:14:01 -0500
Received: (qmail 24162 invoked by uid 109); 15 Jan 2019 19:14:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Jan 2019 19:14:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12437 invoked by uid 111); 15 Jan 2019 19:14:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 15 Jan 2019 14:14:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2019 14:13:59 -0500
Date:   Tue, 15 Jan 2019 14:13:59 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] getenv() timing fixes
Message-ID: <20190115191359.GC4886@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
 <87va2u3yeu.fsf@evledraar.gmail.com>
 <CAGZ79kZrcC=SBrBR_4JDWu4Odgz-Uf7LrusiKNe6tgs02JeAMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZrcC=SBrBR_4JDWu4Odgz-Uf7LrusiKNe6tgs02JeAMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 12, 2019 at 10:51:42AM -0800, Stefan Beller wrote:

> > I wonder, and not as "you should do this" feedback on this series, just
> 
> There is a getenv_safe() in environment.c, but I guess a xgetenv() that
> takes the same parameters as getenv() is better for ease of use.

Yes, but it punts on the memory ownership by stuffing everything into an
argv_array. That saves a few lines if you're going to ask for five
variables, but for a single variable it's no better than:

  char *foo = getenv_safe("FOO");

  ...use foo...

  free(foo);

-Peff
