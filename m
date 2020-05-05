Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C828DC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976A22078C
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgEEQv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:51:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:37958 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729119AbgEEQv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:51:26 -0400
Received: (qmail 13437 invoked by uid 109); 5 May 2020 16:51:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 May 2020 16:51:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31519 invoked by uid 111); 5 May 2020 16:51:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 May 2020 12:51:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 May 2020 12:51:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] CI: limit GitHub Actions to designated branches
Message-ID: <20200505165125.GC64077@coredump.intra.peff.net>
References: <cover.1588607262.git.congdanhqx@gmail.com>
 <cover.1588695295.git.congdanhqx@gmail.com>
 <a4c6f687c0a8ce55863a19a1c4048438f02803b5.1588695295.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4c6f687c0a8ce55863a19a1c4048438f02803b5.1588695295.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 11:26:40PM +0700, Đoàn Trần Công Danh wrote:

> -on: [push, pull_request]
> +on:
> +  pull_request:
> +  push:
> +    branches:
> +      - maint
> +      - master
> +      - next
> +      - jch
> +      - pu
> +      - 'for-ci**'

Should this be "for-ci/**", or are we intending for "for-ci-foo" to
work? I'd suspect anybody who uses this would use a full directory
namespace in a refspec (like "refs/heads/*:refs/heads/for-ci/*"). It
might be simpler conceptually to only support that.

> +    tags:
> +      - '**'
> +      - '!**wip**'

IMHO this "wip" match is going too far. That was the name in the example
I used, but really it could have been anything. I think we should
either:

  - just build all tags; it usually takes special effort to push them up
    anyway, so a one-off "just mark this spot" tag likely wouldn't get
    pushed anyway

  - just build v[0-9]*, which would catch actual releases

-Peff
