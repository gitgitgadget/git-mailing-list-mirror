Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39EBC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65C261053
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhHTSBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 14:01:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:53444 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235172AbhHTSBT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 14:01:19 -0400
Received: (qmail 23404 invoked by uid 109); 20 Aug 2021 18:00:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Aug 2021 18:00:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6967 invoked by uid 111); 20 Aug 2021 18:00:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Aug 2021 14:00:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Aug 2021 14:00:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathon Anderson <janderson@acesquality.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: Git Modifying DLL
Message-ID: <YR/tyHWQ6+2sP2iA@coredump.intra.peff.net>
References: <CAG83euoGmVUUBh00wAEX1muZogNPOQUV6+ppL8x8qCaDnzTbDw@mail.gmail.com>
 <010f01d79525$f10a1f60$d31e5e20$@nexbridge.com>
 <CAG83euo2B4QFU_S6Yqd3UACWq63p=L+T30CwzT52D8H=S5pRVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG83euo2B4QFU_S6Yqd3UACWq63p=L+T30CwzT52D8H=S5pRVg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 01:21:03PM -0500, Jonathon Anderson wrote:

> I had not. I tested that and it worked. I assumed that git would
> automatically treat dll files as binary. Thanks for the help!

Git doesn't know about any file extensions by default. Its default "is
it binary" test looks for NUL bytes in the first 8k or so of the file.
I'd expect your DLL would probably have such a NUL byte.

Is it possible you have other .gitattributes set which are confusing
things?

You might try:

  git check-attr --all <path>

or:

  git ls-files --stdin | git check-attr --stdin --all

-Peff
