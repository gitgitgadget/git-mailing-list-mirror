Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9075CC2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7804120776
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDXFyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:54:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:38460 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725823AbgDXFyS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 01:54:18 -0400
Received: (qmail 19989 invoked by uid 109); 24 Apr 2020 05:54:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Apr 2020 05:54:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23464 invoked by uid 111); 24 Apr 2020 06:05:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Apr 2020 02:05:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Apr 2020 01:54:17 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] progress.c: silence cgcc suggestion about internal
 linkage
Message-ID: <20200424055417.GH1648190@coredump.intra.peff.net>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <dddf2d402702a616e04e7e446e31e0c6697d8c49.1587648870.git.congdanhqx@gmail.com>
 <cbe8fcac-d7d5-8db2-cf69-6f04136337c9@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbe8fcac-d7d5-8db2-cf69-6f04136337c9@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 01:58:51AM +0100, Ramsay Jones wrote:

> > +extern int progress_testing; /* to silence sparse: internal linkage */
> >  int progress_testing;
> > +extern uint64_t progress_test_ns; /* to silence sparse: internal linkage */
> >  uint64_t progress_test_ns = 0;
> >  void progress_test_force_update(void); /* To silence -Wmissing-prototypes */
> >  void progress_test_force_update(void)
> 
> My preference would be to add these extern declarations to the
> progress.h header file, with a note that they are only used by
> the 't/helper/test-progress.c' test helper. (Also, remove the
> extern declarations from test-progress.c, of course).

I came here to say the same thing.

As a bonus, it would catch any changes to the types in the future
(rather than just segfaulting when test-progress.c attempts to use an
out-of-date type).

-Peff
