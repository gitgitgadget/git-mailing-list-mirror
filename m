Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F5AC33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682BF207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgAGLIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:08:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:58846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727273AbgAGLIv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 06:08:51 -0500
Received: (qmail 11143 invoked by uid 109); 7 Jan 2020 11:08:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 11:08:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28982 invoked by uid 111); 7 Jan 2020 11:14:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 06:14:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 06:08:50 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "Miriam R." <mirucam@gmail.com>
Subject: Re: [PATCH] run-command: avoid undefined behavior in exists_in_PATH
Message-ID: <20200107110850.GB1073219@coredump.intra.peff.net>
References: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
 <20200107020425.GG92456@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107020425.GG92456@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 06, 2020 at 06:04:25PM -0800, Jonathan Nieder wrote:

> -- >8 --
> Subject: run-command: let caller pass in buffer to locate_in_PATH
> 
> Instead of returning a buffer that the caller is responsible for
> freeing, use a strbuf output parameter to record the path to the
> searched-for program.
> 
> This makes ownership a little easier to reason about, since the owning
> code declares the buffer.  It's a good habit to follow because it
> allows buffer reuse when calling such a function in a loop.
> 
> It also allows the caller exists_in_PATH that does not care about the
> path to the command to be slightly simplified, by allowing a NULL
> output parameter that means that locate_in_PATH should take care of
> allocating and freeing its temporary buffer.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  run-command.c | 51 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 22 deletions(-)

I dunno. Now the rules inside locate_in_PATH() are more complicated, and
we have an unusual boolean return from the function.

I admit I don't overly care either way, as there are literally two
callers (and not likely to be more). So I'd probably just leave it
alone, but I'm not opposed to the patch if people think it's a good
idea.

-Peff
