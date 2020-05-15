Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC4CC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C831720657
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEOSNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:13:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:47882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726023AbgEOSNU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:13:20 -0400
Received: (qmail 25836 invoked by uid 109); 15 May 2020 18:13:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 18:13:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14017 invoked by uid 111); 15 May 2020 18:13:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 14:13:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 14:13:19 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 04/13] upload-pack: use 'struct upload_pack_data' in
 upload_pack()
Message-ID: <20200515181319.GD3692649@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200515100454.14486-5-chriscool@tuxfamily.org>
 <fac9a9f1-7ee6-5138-9a9e-94e742b69f2c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fac9a9f1-7ee6-5138-9a9e-94e742b69f2c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 06:30:23AM -0400, Derrick Stolee wrote:

> The control flow below was hard to parse from the diff because
> a whitespace line split up the "-" lines and the "+" lines.
> I reorder them here:

Using "-w" improves it a bit, because the packet_reader_init() becomes
an anchor. But sadly the rest is hard to follow because of adding
"data." to each variable reference.

I hoped --patience or --histogram might do better, but they don't. I
think breaking it into a block like you did is the simplest way to see
it.

> The major change is that the "options->advertise_refs" case
> now clears the data when before it did not. This seems like
> a good change to make.

Yeah, I think so, too. It looks like we were simply leaking the filter
options before. I think we still leak the symref list, but it looks like
that will get moved into upload_pack_data in a later patch, too.

So still looking good so far.

-Peff
