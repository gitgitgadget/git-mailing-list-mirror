Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA42FC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862BA2168B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375948AbgJWIe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:34:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:40282 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S375765AbgJWIe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 04:34:26 -0400
Received: (qmail 27455 invoked by uid 109); 23 Oct 2020 08:34:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 08:34:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18078 invoked by uid 111); 23 Oct 2020 08:34:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 04:34:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 04:34:24 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] sideband: add defense against packets missing a
 band designator
Message-ID: <20201023083424.GD4012156@coredump.intra.peff.net>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
 <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
 <c61e560451c4d7f101a23acec69117ddac563330.1603136143.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c61e560451c4d7f101a23acec69117ddac563330.1603136143.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 07:35:42PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> While there is currently no instance of code producing this type of
> packet, if the `demultiplex_sideband()` would receive a packet whose
> payload is not only empty but even misses the band designator, it would
> mistake it for a flush packet.
> 
> Let's defend against such a bug in the future.

That seems reasonable, but I'm not sure if these ought to be BUG()s.
Isn't it an indication that the other side sent us bogus input? That
likely is a bug on the other end, but I think it should be a die(), just
as we would produce for any other malformed protocol input.

-Peff
