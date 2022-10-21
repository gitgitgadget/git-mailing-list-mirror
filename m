Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99667C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJUFim (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJUFij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:38:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD14D22E8C3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:38:29 -0700 (PDT)
Received: (qmail 10505 invoked by uid 109); 21 Oct 2022 05:38:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 05:38:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1720 invoked by uid 111); 21 Oct 2022 05:38:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 01:38:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 01:38:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 2/6] shortlog: make trailer insertion a noop when
 appropriate
Message-ID: <Y1IwVIoVsl1FVklI@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
 <7decccad7ccb39eed67bab87ed665beccf5d392f.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7decccad7ccb39eed67bab87ed665beccf5d392f.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 11:11:32PM -0400, Taylor Blau wrote:

> When there are no trailers to insert, it is natural that
> insert_records_from_trailers() should return without having done any
> work.
> 
> But instead we guard this call unnecessarily by first checking whether
> `log->groups` has the `SHORTLOG_GROUP_TRAILER` bit set.
> 
> Prepare to match a similar pattern in the future where a function which
> inserts records of a certain type does no work when no specifiers
> matching that type are given.

The patch looks good. And knowing what the rest of the series looks
like, this is clearly the right thing to do. But I wonder if the
rationale would be easier if it came at the end. Then rather than
"prepare to match a similar pattern in the future", you can just say
"it's weird that we check the bit for SHORTLOG_GROUP_TRAILER but nothing
else; let's make them consistent".

Obviously this is a minor nit, and I don't care much either way, as the
end result is the same. I just think in general that "this is bad, let's
make it better" makes commit messages easier to write than ones which
posit some hypothetical future state. ;)

-Peff
