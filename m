Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6B0C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F7C20782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgKDUN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:13:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:47826 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731230AbgKDUN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:13:28 -0500
Received: (qmail 11216 invoked by uid 109); 4 Nov 2020 20:13:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 20:13:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14653 invoked by uid 111); 4 Nov 2020 20:13:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 15:13:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 15:13:27 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 07/13] strmap: add more utility functions
Message-ID: <20201104201327.GA3629238@coredump.intra.peff.net>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
 <42633b8d03008a159bc42bde319f50e87ddb00f6.1604343314.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42633b8d03008a159bc42bde319f50e87ddb00f6.1604343314.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 02, 2020 at 06:55:07PM +0000, Elijah Newren via GitGitGadget wrote:

> +/*
> + * iterate through @map using @iter, @var is a pointer to a type strmap_entry
> + */
> +#define strmap_for_each_entry(mystrmap, iter, var)	\
> +	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, 0); \
> +		var; \
> +		var = hashmap_iter_next_entry_offset(iter, 0))
> +

I think this resolves my offset question from the last round. But I
wonder if you tried:

  #define strmap_for_each_entry(mystrmap, iter, var) \
	hashmap_for_each_entry(&(mystrmap)->map, iter, var, ent)

which is a bit more abstract and should function the same (I think; I
didn't try it).

-Peff
