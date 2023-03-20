Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E45C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 17:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjCTR2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjCTR1w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 13:27:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138331ACD3
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:23:11 -0700 (PDT)
Received: (qmail 18858 invoked by uid 109); 20 Mar 2023 17:16:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Mar 2023 17:16:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25127 invoked by uid 111); 20 Mar 2023 17:16:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Mar 2023 13:16:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Mar 2023 13:16:02 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     dooagain <dooagain@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: git pull output and case sensitivity.
Message-ID: <20230320171602.GB2615782@coredump.intra.peff.net>
References: <-Va6f9aA736sZCXChvTLaUUSpAq9-ooSELLBrqRSXR5zAQwT7QSRryN1SGBWQj7J_KowBmZuhDHwIwAkrFFfyelwtkXJ-ri4yLPpmDpBqBU=@protonmail.com>
 <20230319062239.w37x64knfhfapbsn@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319062239.w37x64knfhfapbsn@tb-raspi4>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2023 at 07:22:40AM +0100, Torsten Bögershausen wrote:

> On Sat, Mar 18, 2023 at 07:21:10PM +0000, dooagain wrote:
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> > I configured my git repository to ignore case by executing `git config core.ignorecase true` then I executed `git pull` multiple times.
> 
> What do you mean by "I configured my git repository" ?
> The answer is already there, so let's re-rephrase it:
> Are you working on a case-insensitive file system ?
> 
> What happens if you create a test directory, like this:
> mkdir test-case
> cd test-case
> git init
> git config --get  core.ignorecase

I think this is kind of a red herring, isn't it? The bug report is about
refs, and I don't think those really respect core.ignorecase either way,
and inconsistencies are known to happen on case-insensitive filesystems
(because the refs are sometimes case-sensitive and sometimes not
depending on whether they are packed or loose in the filesystem).

So I think this is just a known gotcha, and the path forward is probably
a new ref storage format that doesn't rely on storing names directly in
the filesystem (reftable, or some system based on packed-ref slices).

-Peff
