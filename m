Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9DFC4332B
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBA0235F8
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 13:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbhAMNF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:05:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:54656 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbhAMNF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 08:05:56 -0500
Received: (qmail 22396 invoked by uid 109); 13 Jan 2021 13:05:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 13:05:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29645 invoked by uid 111); 13 Jan 2021 13:05:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 08:05:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 08:05:15 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 18/20] pack-revindex: remove unused
 'find_revindex_position()'
Message-ID: <X/7wCy92mGPZB9PM@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <d60411d524656f4680ac578765b2a8704325a060.1610129796.git.me@ttaylorr.com>
 <X/1st6SrJXysoejt@coredump.intra.peff.net>
 <X/3VfteeF3Ok2C+S@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/3VfteeF3Ok2C+S@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 11:59:42AM -0500, Taylor Blau wrote:

> > I notice these are signed ints, but we've taken care to use uint32_t
> > elsewhere for positions. Shouldn't these be uint32_t, also (or at least
> > unsigned)?
> 
> I'll let both of these be an raw unsigned, since the midpoint is already
> labeled as an unsigned.

Yeah, I found that existing code doubly weird, since "mi" must by
definition be bounded by "lo" and "hi". :)

Looks like the bug was introduced in 92e5c77c37 (revindex: export new
APIs, 2013-10-24), which hacked up the existing loop into a new
function. We should have caught it then (back then we were a lot less
careful about types, IMHO).

Also, the subject line of that commit is giving me deja vu. ;)

-Peff
