Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7587C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE24420758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgERQE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 12:04:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:49690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727777AbgERQE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 12:04:26 -0400
Received: (qmail 20317 invoked by uid 109); 18 May 2020 16:04:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 May 2020 16:04:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3436 invoked by uid 111); 18 May 2020 16:04:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 12:04:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 12:04:25 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/7] pkt-line: extern packet_length()
Message-ID: <20200518160425.GA42240@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
 <c2b9d033bb774d3bccb572802c3ae114cad8d830.1589816719.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2b9d033bb774d3bccb572802c3ae114cad8d830.1589816719.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 11:47:21AM -0400, Denton Liu wrote:

> In a future commit, we will be manually processing packets and we will
> need to access the length header. In order to simplify this, extern
> packet_length() so that the logic can be reused.
> 
> Change the function parameter from a `const char *` to
> `const char linelen[4]`. Even though these two types behave identically
> as function parameters, use the array notation to semantically indicate
> exactly what this function is expecting as an argument.

OK. I double-checked that we will not run into any problems with passing
pointers or arrays of other sizes (sadly compilers would not tell us if
we passed a too-small array, but at least it's documented for humans).

> +/*
> + * Convert a four hex digit packet line length header into its numeric
> + * representation. linelen should not be null-terminated.

Minor nit, but it is perfectly fine if there is a NUL. Maybe "linelen
does not need to be..."?

-Peff
