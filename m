Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE22C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EF320728
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgEOSrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:47:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:48086 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726248AbgEOSrR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:47:17 -0400
Received: (qmail 26277 invoked by uid 109); 15 May 2020 18:47:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 18:47:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14374 invoked by uid 111); 15 May 2020 18:47:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 14:47:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 14:47:16 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 00/13] upload-pack: use 'struct upload_pack_data'
 thoroughly, part 1
Message-ID: <20200515184716.GM3692649@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 12:04:41PM +0200, Christian Couder wrote:

> In the thread started by:
> 
> https://lore.kernel.org/git/20200507095829.16894-1-chriscool@tuxfamily.org/
> 
> which led to the following bug fix commit:
> 
> 08450ef791 (upload-pack: clear filter_options for each v2 fetch
> command, 2020-05-08)
> 
> it was agreed that having many static variables in 'upload-pack.c',
> while upload_pack_v2() is called more than once per process, is very
> bug prone and messy, and that a good way forward would be to use
> 'struct upload_pack_data' thoroughly, especially in upload_pack()
> where it isn't used yet.
> 
> This patch series is the first part of an effort in this direction.

Thanks for following up on this! I think all of the patches here are
moving in a good direction. I think there's a philosophical question
about whether some of the functions should be taking the minimum set of
fields from upload_pack_data, or just the whole struct. But seeing the
opportunities for cleanup near the end, especially around little flags,
I think passing the big struct around (like you've done here) is
probably the best choice.

> While there are still a lot of static variables at the top of
> 'upload-pack.c' after this patch series, it does a lot of ground work
> and a number of cleanups.

Yeah, I think all of use_thin_pack, use_ofs_delta, etc, should be easy
conversions on top (and will really give us the payoff).

-Peff
