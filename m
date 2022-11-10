Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C0C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 21:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKJVu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 16:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiKJVuy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 16:50:54 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F99E51C09
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 13:50:53 -0800 (PST)
Received: (qmail 25664 invoked by uid 109); 10 Nov 2022 21:50:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Nov 2022 21:50:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30084 invoked by uid 111); 10 Nov 2022 21:50:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Nov 2022 16:50:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Nov 2022 16:50:52 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] http: redact curl h2h3 headers in info
Message-ID: <Y21yPIDmwB53e+aj@coredump.intra.peff.net>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <Y2xnUyEoCFmbPtUI@nand.local>
 <kl6lpmdu3dl5.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lpmdu3dl5.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 09:48:38AM -0800, Glen Choo wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >>      * How could we set up end-to-end tests to ensure that we're testing
> >>        this against affected versions of curl? To avoid regressions, I'd
> >>        also prefer to test against future versions of curl too.
> >
> > Does that necessarily matter? We want to make sure that we don't see
> > sensitive headers from the h2h3 module with any version of cURL, no?
> 
> It would help, but it might not be worth setting up infrastructure for
> just this use case alone. Given the various platforms running tests
> against the Git codebase, we probably get close to a representative
> sample of the population with enough time.
> 
> I think it would be more important to have tests against HTTP/2.0. If we
> did, we probably would have already caught this, e.g.
> t/t5551-http-fetch-smart.sh:'GIT_TRACE_CURL redacts auth details' and
> friends.

There's some discussion in b66c77a64e (http: match headers
case-insensitively when redacting, 2021-09-22) about testing with
HTTP/2. Which ironically is basically this exact same bug in a different
form. ;)

The short answer is that it's do-able, but probably there are some
headaches to make it work portably.

I agree with you that trying various curl versions isn't worth doing. If
enough people/platforms run Git's suite, one of them will eventually
see the problem.

-Peff
