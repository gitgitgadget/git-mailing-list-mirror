Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D521C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 08:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2803A20705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 08:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgAaIph (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:45:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:49336 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728099AbgAaIph (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 03:45:37 -0500
Received: (qmail 12902 invoked by uid 109); 31 Jan 2020 08:45:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Jan 2020 08:45:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30374 invoked by uid 111); 31 Jan 2020 08:53:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2020 03:53:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jan 2020 03:45:35 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] normalize_path_copy(): document "dst" size
 expectations
Message-ID: <20200131084535.GA2857810@coredump.intra.peff.net>
References: <20200130095155.GA839988@coredump.intra.peff.net>
 <20200130095219.GA840531@coredump.intra.peff.net>
 <20200130201247.GA26000@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130201247.GA26000@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 12:12:47PM -0800, Taylor Blau wrote:

> > @@ -1077,6 +1077,8 @@ const char *remove_leading_path(const char *in, const char *prefix)
> >
> >  /*
> >   * It is okay if dst == src, but they should not overlap otherwise.
> > + * The "dst" buffer must be at least as long as "src"; normalizing may shrink
> > + * the size of the path, but will never grow it.
> 
> Thanks for documenting this. It's quite helpful, and hopefully should
> prevent bugs like the one you alluded to in your cover letter from
> getting in in the future.

To be picky, I didn't find an actual bug around buffer lengths; the
problem was a failure to check the error code. This was just something I
happened to find confusing auditing the code.

-Peff
