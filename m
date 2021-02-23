Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB28C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC1964DF5
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhBWUno (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:43:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:42290 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232176AbhBWUnl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:43:41 -0500
Received: (qmail 27378 invoked by uid 109); 23 Feb 2021 20:42:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 20:42:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4267 invoked by uid 111); 23 Feb 2021 20:42:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 15:42:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 15:42:58 -0500
From:   Jeff King <peff@peff.net>
To:     Yaron Wittenstein <yaron.wittenstein@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [QUESTION] Tracking HEAD changes?
Message-ID: <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDROhhrM5qJti1ir@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 07:38:30PM -0500, Jeff King wrote:

> On Mon, Feb 22, 2021 at 11:12:11AM +0200, Yaron Wittenstein wrote:
> 
> > Is there any possible way to track changes to HEAD using hooks?
> > 
> > Being able to listen using hooks to events such as pre-head-checkout
> > and post-head-checkout would be the best option (from my perspective).
> > 
> > To my knowledge, the only possible way to do that today is by adding a
> > file watch over the refs directory.
> 
> No, I don't think there is currently a better way.

Actually, I completely forgot about Patrick's recent ref-transaction
hook. See the "reference-transaction" section of githooks(7). They do
more than you'd need, but you should be able to write a hook that just
looks for updates to HEAD, or updates to the ref that HEAD is pointing
at.

The code was introduced in 6754159767 (refs: implement reference
transaction hook, 2020-06-19), so you'll need Git v2.28.0 or later.

-Peff
