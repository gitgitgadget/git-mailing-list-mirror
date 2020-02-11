Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE75C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3018220870
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 20:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgBKUAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:00:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:57880 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727955AbgBKUAp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 15:00:45 -0500
Received: (qmail 9499 invoked by uid 109); 11 Feb 2020 20:00:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 20:00:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1564 invoked by uid 111); 11 Feb 2020 20:09:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 15:09:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 15:00:44 -0500
From:   Jeff King <peff@peff.net>
To:     Steve Keller <keller.steve@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Develop a patch series with git?
Message-ID: <20200211200044.GG2127797@coredump.intra.peff.net>
References: <trinity-f39d7ed5-e4c9-45fe-944c-b5cb101cfdcd-1581412940557@3c-app-gmx-bap62>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <trinity-f39d7ed5-e4c9-45fe-944c-b5cb101cfdcd-1581412940557@3c-app-gmx-bap62>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 10:22:20AM +0100, Steve Keller wrote:

> I wonder how git supports developing a series of small patches.  In my
> usual development I go back and forth along a series of patches before
> I can commit them all.  I use quilt for that.
> 
> Say I want to add feature FOO and start a patch "FOO" editing some
> source file.  In the process of doing so I realize that I need an
> extension of some function to base my patch on, so I do "quilt pop" to
> undo patch FOO and insert a new patch BAR and then re-apply FOO by
> calling quilt push.  No I can use the new extension from BAR in my
> current patch FOO.  The patch series often contains quite a number of
> patches and I push, pop, and edit these patches quite often.  Only
> when everything is done I use git commit all the patches into the
> repository.
> 
> My question is whether there is git functionality to replace quilt.
> Or is the combination of quilt and git common?

Another responder mentioned "rebase -i", which is the most direct
equivalent. But on a smaller scale, also look at "git add -p", which
lets you selectively stage hunks for commit.

So quite often my flow is something like:

  1. Messy writing and refactoring, while I get a handle on what my
     changes are going to be.

  2. "git add -p" to pull out some hunks related to refactoring, then
     "git commit" to give it a rough commit message.

  3. Repeat step 2 (with maybe some more step 1 in between) as necessary
     until you have a sequence of rough patches.

  4. Revisit each patch individually with "rebase -i", possibly
     re-ordering, fixing bugs, fleshing out commit messages, etc.
     Another useful tool here is:

       git rebase -x "make test"

     which makes sure that the intermediate steps are all correct.

-Peff
