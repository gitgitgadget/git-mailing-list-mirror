Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94069C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF8664EB6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhBXErK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:47:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:42666 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhBXErJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:47:09 -0500
Received: (qmail 28959 invoked by uid 109); 24 Feb 2021 04:46:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Feb 2021 04:46:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8822 invoked by uid 111); 24 Feb 2021 04:46:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 23:46:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 23:46:28 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH] wrapper: add workaround for open() returning EINTR
Message-ID: <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net>
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 11:43:16PM -0500, Jeff King wrote:

> The workaround here is enabled all the time, without a Makefile knob,
> since it's a complete noop if open() never returns EINTR. I did push it
> into its own compat/ source file, though, since it has to #undef our
> macro redirection. Putting it in a file with other code risks confusion
> if more code is added after that #undef.

Whoops, sorry, I had a last-minute change of heart here and just stuck
it in wrapper.c with a bit of preprocessor magic to guard it. It felt
weird having compat/open.c, when the rest of compat/ is always
conditional on Makefile knobs. But I'm happy to go the other way if
anybody feels strongly.

-Peff
