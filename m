Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546D7C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F120520731
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgKWTOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:14:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57235 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729288AbgKWTOA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:14:00 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANJDtlb027500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 14:13:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1CE8A420136; Mon, 23 Nov 2020 14:13:55 -0500 (EST)
Date:   Mon, 23 Nov 2020 14:13:55 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     =?iso-8859-1?B?Vu10?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
Message-ID: <20201123191355.GA132317@mit.edu>
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 10:59:13AM -0700, Alex Henrie wrote:
> 
> Hi Vit, as the message explains, you can use `git config --global
> pull.rebase false` to permanently silence the warning for all of your
> repositories. The idea is that in a future version of Git, users will
> not be allowed to pull at all without specifying a reconciliation
> strategy. This will prevent users (novices in particular) from
> accidentally creating messes by merging branches that should have been
> rebased instead.
> 
> Personally, I would rather have pull.rebase be true by default (and
> I'm sure many others would like that too), but there are so many users
> who really do want to merge that it's not reasonable to make rebasing
> the default. The most reasonable solution is to ask the user to be
> explicit about what they want and not make assumptions.

It's really going to depend on your workflow.  If your repository is
used as a building point by other repositories, and you pull from the
upstream repo, rebasing may cause a massive headache for your
downstream "sub-maintainers" (assuming that you are a subsystem
maintainer).

If your repository is effectively a leaf repo, then rebasing may be
harmless, although there are still who don't like rebasing because it
invalidates your previous testing.  My personal preference is to do a
git fetch, followed by a git merge --ff-only, and if that errors out,
then I know I need to take a bit more care before deciding what to do
next.

But everyone's workflow varies, which is why creating a default is
going to controversial no matter what the default might be.

Cheers,

					- Ted
