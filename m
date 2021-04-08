Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C07FC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 00:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDB961182
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 00:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhDHAfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 20:35:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:44118 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhDHAfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 20:35:32 -0400
Received: (qmail 19117 invoked by uid 109); 8 Apr 2021 00:35:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Apr 2021 00:35:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27062 invoked by uid 111); 8 Apr 2021 00:35:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 20:35:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 20:35:20 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     rafaeloliveira.cs@gmail.com, szeder.dev@gmail.com,
        git@vger.kernel.org
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
Message-ID: <YG5PyJHqk/BjeD84@coredump.intra.peff.net>
References: <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
 <20210408000242.2465219-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210408000242.2465219-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 05:02:41PM -0700, Jonathan Tan wrote:

> It seems to me that this would work. The only part I was confused about
> is "packtmp", but that is just the pack directory plus a specific
> prefix, so "pack-objects" will indeed see that packfile as being part of
> the repository - no problem.
> 
> repack_promisor_objects() might be able to be refactored to provide the
> names in a format that we want, but looking at it, I don't think it's
> possible (it just uses "packtmp", so we have the same "packtmp"
> problem).

Yeah, that was the refactoring I alluded to. I think the earlier code
should keep the ".tmp-%d" portion in a separate string, and then
construct packtmp from that. And then we don't have to try to recover it
from the concatenated string.

-Peff
