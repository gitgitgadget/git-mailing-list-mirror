Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9958C38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 20:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJUURK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJUURI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 16:17:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0242F29F100
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 13:17:07 -0700 (PDT)
Received: (qmail 14144 invoked by uid 109); 21 Oct 2022 20:17:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 20:17:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15445 invoked by uid 111); 21 Oct 2022 20:17:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 16:17:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 16:17:06 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] config: require at least one digit when parsing
 numbers
Message-ID: <Y1L+Qv+cs1bjqjK9@coredump.intra.peff.net>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 01:45:13PM +0000, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> If the input to strtoimax() or strtoumax() does not contain any digits
> then they return zero and set `end` to point to the start of the input
> string.  git_parse_[un]signed() do not check `end` and so fail to return
> an error and instead return a value of zero if the input string is a
> valid units factor without any digits (e.g "k").

This one is easier to test than the last. Just:

  git config --int --default='m' some.key

works. And even playing devil's advocate, I can't think of a case where
anybody would rely on the current behavior.

-Peff
