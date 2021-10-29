Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53804C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4606101E
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhJ2Vjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:39:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:49858 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhJ2Vjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:39:46 -0400
Received: (qmail 23924 invoked by uid 109); 29 Oct 2021 21:37:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Oct 2021 21:37:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23287 invoked by uid 111); 29 Oct 2021 21:37:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Oct 2021 17:37:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Oct 2021 17:37:16 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] wrapper: remove xunsetenv()
Message-ID: <YXxpjLhiguq4HY6g@coredump.intra.peff.net>
References: <013a01d7cd092d91cb088b5610nexbridge.com>
 <20211029212705.31721-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211029212705.31721-1-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 02:27:05PM -0700, Carlo Marcelo Arenas Belón wrote:

> Platforms that are using the git compatibility layer for unsetenv
> use void as a return value for unsetenv(), so any function that checks
> for a return value will fail to build.

Good catch.

> Remove the unused wrapper function.

I don't mind removing this if nobody is using it, but doesn't your first
paragraph argue that our definition of gitunsetenv() is just wrong?
I.e., it should return an int, even if it is always "0"?

Or is it a portability question? I.e., are there platforms where
unsetenv() also returns void, in which case we must make sure nobody
ever looks at its return value (and xunsetenv() is therefore a wrong
direction)?

-Peff
