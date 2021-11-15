Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C1C4332F
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3693261BF5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349655AbhKOV1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:27:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:59350 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348839AbhKOVLk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 16:11:40 -0500
Received: (qmail 14200 invoked by uid 109); 15 Nov 2021 21:08:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Nov 2021 21:08:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18364 invoked by uid 111); 15 Nov 2021 21:08:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Nov 2021 16:08:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Nov 2021 16:08:38 -0500
From:   Jeff King <peff@peff.net>
To:     andre_pohlmann@posteo.de
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: bug or a general misunderstanding
Message-ID: <YZLMVk3ULURAelQ2@coredump.intra.peff.net>
References: <0bb0056a59cda294d416762d7f8a9c47@posteo.de>
 <nycvar.QRO.7.76.6.2111101545000.21127@tvgsbejvaqbjf.bet>
 <3dd24fb6153cf8d67b74c6cea1a4a734@posteo.de>
 <YY2MXSZXIRSDLQCu@camp.crustytoothpaste.net>
 <468f30fbff6f1fcf708c484c19c287b7@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <468f30fbff6f1fcf708c484c19c287b7@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 10:56:00AM +0000, andre_pohlmann@posteo.de wrote:

> Starting from the relevant branch
> 
> git branch TEST_1
> git checkout TEST_1
> git status

OK, so TEST_1 points at something. We don't know what, but from below,
it sounds like the BBV branch.

> then
> 
> git checkout BBV ---- that is the original Branch
> git branch TEST_2 ff2c8952 ---- the commit to check out from

OK, so now TEST_2 is created from ff2c8952. But from the details you've
given, we don't know what relationship that has to what was on BBV, or
any other commit.

> git checkout TEST_2
> git status

And now it's our HEAD, though I don't think that matters, because...

> git branch --contains 48c8756e ---- the commit with the specific code

...this is asking which branches contain 48c8756e, and doesn't care
about HEAD at all.

> the result is that only TEST_1 is shown, not TEST_2.
> It looks to me like the commit is missing.

I can't say if this is a bug or not, without knowing the relationship
between 48c8756e and ff2c8952. Have you tried something like:

  git log --oneline --graph 48c8756e...ff2c8952

That should show you whether one is an ancestor of the other.

-Peff
