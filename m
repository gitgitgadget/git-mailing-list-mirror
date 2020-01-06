Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2E5C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F322080A
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgAFVax (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:30:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:58266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726735AbgAFVaw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 16:30:52 -0500
Received: (qmail 3295 invoked by uid 109); 6 Jan 2020 21:30:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Jan 2020 21:30:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25317 invoked by uid 111); 6 Jan 2020 21:36:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2020 16:36:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Jan 2020 16:30:51 -0500
From:   Jeff King <peff@peff.net>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [Outreachy] Return value before or after free()?
Message-ID: <20200106213051.GD980197@coredump.intra.peff.net>
References: <CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=EjR6v6jE1mnxvUJQSF_0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=EjR6v6jE1mnxvUJQSF_0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 06, 2020 at 10:15:53PM +0100, Miriam R. wrote:

> in run-command.c file `exists_in_PATH()` function does this:
> 
> static int exists_in_PATH(const char *file)
> {
> char *r = locate_in_PATH(file);
> free(r);
> return r != NULL;
> }
> 
> I wonder if it is correct to do return r != NULL; after free(r);

It is technically undefined behavior according to the C standard, but I
think it would be hard to find an implementation where it was not
perfectly fine in practice.

Ref: http://c-faq.com/malloc/ptrafterfree.html

I'd probably leave it alone unless it is causing a problem (e.g., a
static analyzer complaining).

-Peff
