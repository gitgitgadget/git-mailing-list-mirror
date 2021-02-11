Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C45C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 11:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C01364DCD
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 11:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhBKLVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 06:21:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:57620 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhBKLSp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 06:18:45 -0500
Received: (qmail 5345 invoked by uid 109); 11 Feb 2021 11:18:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Feb 2021 11:18:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32107 invoked by uid 111); 11 Feb 2021 11:18:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Feb 2021 06:18:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Feb 2021 06:18:01 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t1500: ensure current --since= behavior remains
Message-ID: <YCUSaXCg8Abg+vGs@coredump.intra.peff.net>
References: <20210210215543.18960-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210215543.18960-1-e@80x24.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 09:55:43PM +0000, Eric Wong wrote:

> This behavior of git-rev-parse is observed since git 1.8.3.1
> at least(*), and likely earlier versions.
> 
> At least one git-reliant project in-the-wild relies on this
> current behavior of git-rev-parse being able to handle multiple
> --since= arguments without squeezing identical results together.
> So add a test to prevent the potential for regression in
> downstream projects.

I had to read this a few times to understand what "this behavior" meant.
It is just: when given multiple --since options, output a --max-age for
each of them, even though internally, Git's revision traversal will only
use one (in the usual last-one-wins fashion).

I'm not sure if I was just being dense, or if this could be spelled out
more clearly. :)

Out of curiosity, why does the other project want that? From your
mention of libgit2's git__date_parse(), I assume it's something that
wants to parse approxidates into timestamps in a script. Maybe we ought
to provide a more direct and robust way of doing that. We have a similar
need in t0006, but we use a test-helper program for it.

(I have no problem in the meantime with this patch, though; any new
method for accomplishing this would want to give other projects time to
adapt to its use).

-Peff
