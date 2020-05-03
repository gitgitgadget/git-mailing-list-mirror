Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB07C47258
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16B02073E
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgECJzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 05:55:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:35076 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727971AbgECJzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 05:55:01 -0400
Received: (qmail 22323 invoked by uid 109); 3 May 2020 09:55:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 09:55:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4966 invoked by uid 111); 3 May 2020 09:55:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 05:55:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 05:55:00 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (April 30, 2020)
Message-ID: <20200503095500.GF170902@coredump.intra.peff.net>
References: <fda6d0db-f79e-f44e-7c2b-b60ed1794cd0@gmail.com>
 <CAFQ2z_PP9Ld+GDctV-v2CDKFamF6zKdJZ_-jhahj_fcm3wy4Hw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2005012316350.18039@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2005012316350.18039@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 12:08:41AM +0200, Johannes Schindelin wrote:

> I firmly believe that this patch series, in particular the huge patch, can
> be transformed into something that looks a lot more like git.git code, is
> a lot smaller, and is a _lot_ easier to review. Without the confidence
> such a reviewable shape provides, I would actually not trust it enough to
> put it into the hands of end-users.

I agree, and I think it's not just a question of review, but of
maintenance going forward.

We are willing to accept something like compat/regex or kwset having a
vastly differing style and avoiding our usual constructs because they
are pretty stand-alone. They are modular, battle-tested pieces of code
we've taken wholesale $from elsewhere, and we're generally able to treat
them like a black box (that usually works). We really consider them a
"vendor" solution versus a system regex.

But I don't think that's the right attitude for something as critical to
Git as ref storage, or something that is mainly being used by Git (and
so we will be the likely ones to find bugs, not some third-party use).
As much as I do laud efforts to make code that can be used
out-of-the-box by other implementations, within the git.git
implementation stability and maintainability are the _most_ important
things.

Another data point to contrast with kwset, etc, is xdiff. We also took a
stylistically-unusual vendor copy of that into our tree. And I don't
think it has worked all that well. People are hesitant to touch the
code, and it has often lagged (or completely missed out) on project-wide
cleanups like those around memory allocation, size_t overflows, etc. I'd
be even more afraid to see similar issues in something as critical as
ref storage.

-Peff
