Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4900C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 14:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A557E6508E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 14:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhCPOxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:53:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:37762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235775AbhCPOxV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 10:53:21 -0400
Received: (qmail 19311 invoked by uid 109); 16 Mar 2021 14:53:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Mar 2021 14:53:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28592 invoked by uid 111); 16 Mar 2021 14:53:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Mar 2021 10:53:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Mar 2021 10:53:19 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
Subject: Re: git bisect fails to handle annotated tags
Message-ID: <YFDGX4EsrvHqZgPF@coredump.intra.peff.net>
References: <878s6nz1sg.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878s6nz1sg.fsf@igel.home>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 02:05:51PM +0100, Andreas Schwab wrote:

> $ git --version
> git version 2.31.0
> $ git bisect start
> $ git bisect good v2.30.0
> $ git bisect bad v2.31.0
> 3e90d4b58f3819cfd58ac61cb8668e83d3ea0563 was both good and bad

Looks like it bisects to 27257bc466 (bisect--helper: reimplement
`bisect_state` & `bisect_head` shell functions in C, 2020-10-15), which
isn't too surprising. So it broke in v2.30, but nobody seems to have
noticed during the last cycle.

I'd guess it's just missing a call to peel the input oid.

-Peff
