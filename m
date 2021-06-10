Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA569C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91745611B0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFJQbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:31:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:51538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhFJQbi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:31:38 -0400
Received: (qmail 8346 invoked by uid 109); 10 Jun 2021 16:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 16:29:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31792 invoked by uid 111); 10 Jun 2021 16:29:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 12:29:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 12:29:41 -0400
From:   Jeff King <peff@peff.net>
To:     Nikita Bobko <nikitabobko@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug report] git format-patch + git am doesn't preserve original
 commit message
Message-ID: <YMI99TBbZ1zCFE1V@coredump.intra.peff.net>
References: <CAMJzOtzu-fKxtseSPQ8riTC-kfg1CphnXN=EN-rnxVo85dZvFw@mail.gmail.com>
 <YMIrkBiCpUXcUwsW@coredump.intra.peff.net>
 <CAMJzOtx9D7KthsUi7eLcmz7rszOQh8t=-VhXeOGDX1CMV1iERQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMJzOtx9D7KthsUi7eLcmz7rszOQh8t=-VhXeOGDX1CMV1iERQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 05:36:43PM +0200, Nikita Bobko wrote:

> Oh, I see, thank you, it works.
> 
> But actually, I am not sure that it's "expected" behavior. I would
> expect git to preserve original message by default without any
> additional flags. Shouldn't `--keep-non-patch` flag in `git am` be
> enabled by default then?

I'd be hesitant to change that, since it would break any communities
using other tags. I think 17635fc900 (mailinfo: -b option keeps
[bracketed] strings that is not a [PATCH] marker, 2009-07-15) has some
examples.

In your example, I think passing "-k" to both git-format-patch and
git-am is the right solution. But presumably that's a toy example. In
the real world, the person running "am" is probably not the same as the
one running format-patch (and if it is, probably something like
cherry-pick is a better solution anyway).

-Peff
