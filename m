Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6FBC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C83021941
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgIPWLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:11:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:59218 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIPWLw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:11:52 -0400
Received: (qmail 26866 invoked by uid 109); 16 Sep 2020 21:11:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Sep 2020 21:11:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1054 invoked by uid 111); 16 Sep 2020 21:11:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 17:11:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 17:11:50 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/5] t3200: avoid variations of the `master` branch name
Message-ID: <20200916211150.GA617237@coredump.intra.peff.net>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
 <2f1d0a2df41f567bc1a8bc446c26e1cb8b6dc36c.1600279853.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f1d0a2df41f567bc1a8bc446c26e1cb8b6dc36c.1600279853.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 06:10:51PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> To avoid branch names with a loaded history, we already started to avoid
> using the name "master" in a couple instances.
> 
> The `t3200-branch.sh` script uses variations of this name for branches
> other than the default one. So let's change those names, as
> "lowest-hanging fruits" in the effort to use more inclusive naming
> throughout Git's source code.

A few of these are kind of odd after only this patch. E.g.:

> -test_expect_success 'git branch -M master2 master2 should work when master is checked out' '
> +test_expect_success 'git branch -M main2 main2 should work when master is checked out' '
>  	git checkout master &&
> -	git branch master2 &&
> -	git branch -M master2 master2
> +	git branch main2 &&
> +	git branch -M main2 main2
>  '

The point of "master2" is that it wasn't "master". But now "main2" is
kind of a weird name, because it has a "2" but isn't related to
anything. If we eventually move the base branch name to "main", they'll
line up again.

I'm on the fence on whether this matters. It's a temporary
inconsistency, assuming we eventually move to "main" as the default. We
_could_ push this change off to that patch, too, but it does make it
more noisy.

But it may be that the connection to "master" here is not all that
important in the first place. And so perhaps an even better patch (both
at this stage and in the long run) is to give it a more descriptive
name. If all of these could just be "branch2", "branch3", etc, then that
alone would be better than "master2", IMHO. I'm not sure if the shared
"ma" prefix matters, though (I know in some tests it does because we're
testing glob matching).

Again, I'm on the fence whether this is exploring too deeply. It's an
opportunity to improve the tests while we're changing them. But at the
same time, I doubt anybody cares too much overall, so it feels a bit
like make-work.

-Peff
