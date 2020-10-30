Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1724AC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C309320724
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJ3OoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:44:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:42554 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3OoT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 10:44:19 -0400
Received: (qmail 7375 invoked by uid 109); 30 Oct 2020 14:44:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 14:44:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21794 invoked by uid 111); 30 Oct 2020 14:44:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 10:44:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 10:44:18 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 09/10] strmap: add a strset sub-type
Message-ID: <20201030144418.GI3277724@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <490d3a42add2cc5f0d30db8f2351614294e00121.1602549650.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <490d3a42add2cc5f0d30db8f2351614294e00121.1602549650.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 12:40:49AM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Similar to adding strintmap for special-casing a string -> int mapping,
> add a strset type for cases where we really are only interested in using
> strmap for storing a set rather than a mapping.  In this case, we'll
> always just store NULL for the value but the different struct type makes
> it clearer than code comments how a variable is intended to be used.
> 
> The difference in usage also results in some differences in API: a few
> things that aren't necessary or meaningful are dropped (namely, the
> free_util argument to *_clear(), and the *_get() function), and
> strset_add() is chosen as the API instead of strset_put().

That all makes sense.

We're wasting 8 bytes of NULL pointer for each entry, but it's unlikely
to be all that important. If we later find a case where we think it
matters, we can always refactor the type not to depend on strmap.

I'd want a strset_check_and_add() to match what I used recently in
shortlog.h. Maybe strset_contains_and_add() would be a better name to
match the individual functions here. I dunno (it actually seems
clunkier).

-Peff
