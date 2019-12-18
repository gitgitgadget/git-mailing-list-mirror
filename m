Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61F4C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 20:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C7F21D7D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 20:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLRUMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:12:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:49678 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726699AbfLRUMm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 15:12:42 -0500
Received: (qmail 18967 invoked by uid 109); 18 Dec 2019 20:12:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Dec 2019 20:12:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31686 invoked by uid 111); 18 Dec 2019 20:17:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Dec 2019 15:17:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Dec 2019 15:12:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH RESEND] t4015: improve coverage of function context test
Message-ID: <20191218201241.GA6452@coredump.intra.peff.net>
References: <fedd48bd-28e8-ccc8-ae50-42d9b2ea1c16@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fedd48bd-28e8-ccc8-ae50-42d9b2ea1c16@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 07:05:54PM +0100, René Scharfe wrote:

> Include an actual function line in the test files to check if context is
> expanded to include the whole function, and add an ignored change before
> function context to check if that one stays hidden, while the originally
> ignored change within function context is shown.
>
> [...]
>  test_expect_success 'combine --ignore-blank-lines with --function-context' '
> -	test_write_lines 1 "" 2 3 4 5 >a &&
> -	test_write_lines 1    2 3 4   >b &&
> +	test_write_lines    1 2 3 "" function 1 2 3 4 5 "" 6 7 8 9 >a &&
> +	test_write_lines "" 1 2 3 "" function 1 2 3 4 5    6 7 8   >b &&

I'm a little mixed on this one. This _is_ a much better test of how the
two features should be have together. But I think the reason the
original was so short was that it was added when fixing a bug where we'd
iterate off the beginning of list of lines, which now no longer happens.

Maybe we should cover both cases in two separate tests?

I'd also suggest using "a b c" for the first three lines to avoid
confusion (I don't think it's important that they're the same as the
lines inside the "function").

-Peff
