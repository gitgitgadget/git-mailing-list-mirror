Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD025C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A6C2067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHXUMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:12:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:39122 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXUMP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 16:12:15 -0400
Received: (qmail 23607 invoked by uid 109); 24 Aug 2020 20:12:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2020 20:12:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17051 invoked by uid 111); 24 Aug 2020 20:12:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2020 16:12:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Aug 2020 16:12:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Ori Bernstein <ori@eigenstate.org>, git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
Message-ID: <20200824201208.GA706849@coredump.intra.peff.net>
References: <20200823005236.10386-1-ori@eigenstate.org>
 <20200823031151.10985-1-ori@eigenstate.org>
 <672843a1-b98c-7567-a078-a2dacd4b7074@web.de>
 <20200823134144.d57c80322f479eb554bab9d1@eigenstate.org>
 <ef92391d-09ef-4c27-e6dd-ec7b907174fa@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef92391d-09ef-4c27-e6dd-ec7b907174fa@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 24, 2020 at 06:06:27PM +0200, René Scharfe wrote:

> > Is there anything you'd like me to do in this patch, other than fixing
> > the typo?
> 
> Please explain in the commit message why 10000 is a good choice for that
> new limit, and what users who happen to exceed it can do to regain
> access to their packed data.

I think it may be worth making this a configurable value
(core.maxDeltaDepth or something). Nobody would generally need to tweak
it, but it would give an escape hatch for getting people out of a broken
situation ("git -c core.maxDeltaDepth=50000 repack" or similar).

-Peff
