Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673A6C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416CC20721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgEDQXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:23:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:35980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729207AbgEDQXM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:23:12 -0400
Received: (qmail 31846 invoked by uid 109); 4 May 2020 16:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 16:23:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18449 invoked by uid 111); 4 May 2020 16:23:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 12:23:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 12:23:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200504162311.GE12842@coredump.intra.peff.net>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 10:49:31PM +0700, Đoàn Trần Công Danh wrote:

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index fd4df939b5..ea43b03092 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -1,6 +1,18 @@
>  name: CI/PR
>  
> -on: [push, pull_request]
> +on:
> +  pull_request:
> +    branches:
> +      - '**'

Doing "**" here makes sense to catch everything (it would be even better
if we could just say "everything with a pull request" by omitting the
branch filter entirely, but maybe that's not possible).

> +    tags:
> +      - '*'

Would we want that here, too? I guess nobody is likely to push
"foo/v1.2.3".

Or on the flip side, would we want to tighten this? If I push a tag
"wip", I probably don't want it built. Probably the right rule is
"annotated tags only", but I suspect that's not possible.

> +  push:
> +    branches:
> +      - maint
> +      - master
> +      - next
> +      - jch
> +      - pu

What happened to "for-ci" (presumably "for-ci/**")?

-Peff
