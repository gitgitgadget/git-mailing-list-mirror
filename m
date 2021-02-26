Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D97C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EE164E09
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhBZGEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 01:04:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:45508 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhBZGEY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 01:04:24 -0500
Received: (qmail 11847 invoked by uid 109); 26 Feb 2021 06:03:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 06:03:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16341 invoked by uid 111); 26 Feb 2021 06:03:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 01:03:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 01:03:43 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] githooks.txt: Clarify documentation on
 reference-transaction hook
Message-ID: <YDiPP3Ml73igpT7Q@coredump.intra.peff.net>
References: <c30d41de55b8991a09e1d550e853f582b5394dee.1614232040.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c30d41de55b8991a09e1d550e853f582b5394dee.1614232040.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 06:50:12AM +0100, Patrick Steinhardt wrote:

> The reference-transaction hook doesn't clearly document its scope and
> what values it receives as input. Document it to make it less surprising
> and clearly delimit its (current) scope.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> 
> I've been postponing doing this simple doc update for far too long, but
> here it finally is. It simply clarifies its current workings and
> limitations without changing anything. This is not supposed to be a "We
> don't want it to ever cover symrefs", but rather to avoid confusion.

I think that's a good step forward. We might want to say "does not cover
symbolic references (but that may change in the future)" to make it
clear that nothing is definite.

OTOH, I suspect adding them would require a change to the hook's stdin
format, so it is not like a hook could be written in a way to magically
handle them if things change in the future.

> @@ -492,6 +493,13 @@ receives on standard input a line of the format:
>  
>    <old-value> SP <new-value> SP <ref-name> LF
>  
> +where `<old-value>` is the old object name passed into the reference
> +transaction, `<new-value>` is the new object name to be stored in the
> +ref and `<ref-name>` is the full name of the ref. When force updating
> +the reference regardless of its current value or when the reference is
> +to be created anew, `<old-value>` is 40 `0`. To distinguish these cases,
> +you can inspect the current value of `<ref-name>` via `git rev-parse`.

We should probably avoid saying "40" here. Maybe "all zeroes" or
something.

-Peff
