Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B53BC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8FE61154
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348023AbhIHJnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:43:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:41594 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347717AbhIHJni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:43:38 -0400
Received: (qmail 22995 invoked by uid 109); 8 Sep 2021 09:42:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Sep 2021 09:42:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25067 invoked by uid 111); 8 Sep 2021 09:42:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Sep 2021 05:42:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Sep 2021 05:42:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] hash-object: prefix_filename() returns allocated memory
 these days
Message-ID: <YTiFhNryAxCobH+m@coredump.intra.peff.net>
References: <xmqqsfyg82b5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfyg82b5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 03:10:22PM -0700, Junio C Hamano wrote:

> Back when a1be47e4 (hash-object: fix buffer reuse with --path in a
> subdirectory, 2017-03-20) was written, the prefix_filename() helper
> used a static piece of memory to the caller, making the caller
> responsible for copying it, if it wants to keep it across another
> call to the same function.  Two callers of the prefix_filename() in
> hash-object were made to xstrdup() the value obtained from it.
> 
> But in the same series, when e4da43b1 (prefix_filename: return newly
> allocated string, 2017-03-20) changed the rule to gave the caller
> possession of the memory, we forgot to revert one of the xstrdup()
> changes, allowing the returned value to leak.

Good catch. The patch looks obviously correct to me.

-Peff
