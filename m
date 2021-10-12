Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AA0C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FF0610A2
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhJLVla (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:41:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:38086 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233650AbhJLVl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 17:41:28 -0400
Received: (qmail 1747 invoked by uid 109); 12 Oct 2021 21:39:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 21:39:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18052 invoked by uid 111); 12 Oct 2021 21:39:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 17:39:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 17:39:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [External Mail]Re: why git is so slow for a tiny git push?
Message-ID: <YWYAjRfLsDtc1Dkm@coredump.intra.peff.net>
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
 <YWRr9g32cMlIc37V@coredump.intra.peff.net>
 <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
 <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
 <d8abab7fb5184a94a9e9e5b7c1f28695@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8abab7fb5184a94a9e9e5b7c1f28695@xiaomi.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 09:08:08AM +0000, 程洋 wrote:

> Jesus. It works for me. After disable writebitmap, time cost decrease
> from 33 seconds to 0.9 seconds.
> 
> But now it turns out that, remote side takes 13 seconds to receive the
> pack,  since git receive-pack is triggered automatically from remote
> side, is there anyway to enable GIT_TRACE2_PERF on server side?

For the environment variable, it depends on your protocol. If you can
push over ssh (and the other side lets you execute arbitrary commands),
then:

  git push --receive-pack='GIT_TRACE2_PERF=/tmp/foo.trace git-receive-pack'

Otherwise, you can look at setting the trace2.perfTarget config option
on the server side. I haven't played with it myself before.

-Peff
