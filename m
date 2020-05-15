Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CBEC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 20:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448A1205CB
	for <git@archiver.kernel.org>; Fri, 15 May 2020 20:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEOU4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 16:56:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:48220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726179AbgEOU4e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 16:56:34 -0400
Received: (qmail 28041 invoked by uid 109); 15 May 2020 20:56:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 20:56:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15991 invoked by uid 111); 15 May 2020 20:56:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 16:56:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 16:56:32 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/6] pkt-line: extern packet_length()
Message-ID: <20200515205632.GB115445@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <891a39c853ce3669b6167dc9ad8a2328e4321a9e.1589393036.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <891a39c853ce3669b6167dc9ad8a2328e4321a9e.1589393036.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 02:04:56PM -0400, Denton Liu wrote:

> +/*
> + * Reads a packetized line and returns the length header of the packet.
> + */
> +int packet_length(const char *linelen);

If this is becoming public, I think we need to talk a bit more about:

  - what is linelen; it's not a NUL-terminated string, which I would
    have expected from the prototype. It must be at least 4 chars, and
    doesn't need terminated.

  - what happens on error; it looks like we return -1

I think the prototype would be more clear to me as:

  int packet_length(const char *line, size_t len)
  {
	if (len < 4)
		return -1;
  }

which makes it clear that this is a sized buffer. But since nobody
should ever be passing anything except "4", it may be overkill. I'd be
happy enough with a comment.

-Peff
