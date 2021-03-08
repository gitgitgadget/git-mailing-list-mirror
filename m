Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8771EC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A4665288
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCHTDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:03:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:55872 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhCHTD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 14:03:26 -0500
Received: (qmail 26603 invoked by uid 109); 8 Mar 2021 19:03:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Mar 2021 19:03:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20466 invoked by uid 111); 8 Mar 2021 19:03:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Mar 2021 14:03:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 Mar 2021 14:03:24 -0500
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 2/7] reset: free instead of leaking unneeded ref
Message-ID: <YEZ0/GI9A5FWHhMG@coredump.intra.peff.net>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <a7b6b873460fe096a3441c3a8d4d766b7221f14d.1615228580.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7b6b873460fe096a3441c3a8d4d766b7221f14d.1615228580.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 06:36:15PM +0000, Andrzej Hunt via GitGitGadget wrote:

> dwim_ref() allocs a new string into ref. Instead of setting to NULL to discard
> it, we can FREE_AND_NULL.
> [...]
>  			dwim_ref(rev, strlen(rev), &dummy, &ref, 0);
>  			if (ref && !starts_with(ref, "refs/"))
> -				ref = NULL;
> +				FREE_AND_NULL(ref);

Yeah, this seems like a perfect solution for this case.

-Peff
