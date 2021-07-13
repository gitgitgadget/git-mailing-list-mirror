Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F9C07E9A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA2061002
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhGMAiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 20:38:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:47350 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhGMAiR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 20:38:17 -0400
Received: (qmail 25808 invoked by uid 109); 13 Jul 2021 00:35:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 00:35:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3974 invoked by uid 111); 13 Jul 2021 00:35:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 20:35:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 20:35:25 -0400
From:   Jeff King <peff@peff.net>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     git@vger.kernel.org
Subject: Re: git interpret-trailers: behavior with input without trailing
 newline
Message-ID: <YOzfzQsuDOeL8VY9@coredump.intra.peff.net>
References: <CCNOOVFJVMLC.7L79PCH59K1C@arch-vps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CCNOOVFJVMLC.7L79PCH59K1C@arch-vps>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 08, 2021 at 10:33:46AM +0000, Luca Weiss wrote:

> I'm investigating a behavior with git interpret-trailers where when
> the input does not end with a newline, git appends the trailer
> directly without a newline; and on running the same command again it
> doesn't detect the previous trailer anymore.
> 
> I've whipped up a quick PoC in form of a new test case in the existing
> test cases of git.

In general, I think commit message inputs should have trailing newlines,
as they'd generally be coming from actual commits, or piped through
git-stripspace to clean things up.

That said, the behavior you're seeing does seem like a bug to me. I
don't think it was intended, and it would be nice to fix it, if you're
up for it. It might be as simple as conditionally adding a newline after
we read the input in trailers.c:read_input_file(). (IMHO even if we do
not end up adding a trailer, normalizing the whitespace in this way
would be a fine behavior for the command).

-Peff
