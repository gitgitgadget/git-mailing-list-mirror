Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C2EC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42FDE2078D
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="v4Br4chj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgFKBHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgFKBHX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 21:07:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086EBC08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 18:07:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so1914159pfe.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 18:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AXC8/nSBrDkH36ffwVLQZOnew0NkZvzFQwtuoIC/Iv4=;
        b=v4Br4chjcK93YxZqs9M5y5mdGXMI7FWxZkWYVJ1cp898GrZb1lX/rWgKOzN1+GXWyc
         jefUODJFb/is70Nz4bL2TAcq326+yGSZieQYXx83yWxZXqiE5ZfgFxS03/eAqCg5Nk1a
         QGHVBFYaolOloTJ9TcoPxdqfINvlQZtUIYSip6zLRrCbqmmBTrdGysSizS0EaSZHcSJN
         BCvtbGulk7Lr8p50AyHBQXEp42+0fE58kpi3Bov/pTsqljsL8oaP2+2xtKqmhGEoTmRW
         nRfROsyzxesfd4mrej6b1qP56QNvDzIxHOW6dvrmbru5HAC/BewDvRzllSc39Kd2li7P
         ++KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXC8/nSBrDkH36ffwVLQZOnew0NkZvzFQwtuoIC/Iv4=;
        b=uRGqvlXsBFaU5UhaM7EpfUAiWnStrPnsICB2+Xo6U9uvdUrMgsp/sv19xcKmACsuJK
         cc0gSee+j4MgOsZ/SR3+OWaJvH4W6sSRglZ8anKii2cVyKux89xFKzid8DFGanfxI+A5
         YmuSoEOD/5KU6AezILD5LHho6o/rmCGXJ3+qX2zDcqz0bHnXR/aJVX7UTVIFptUMPL2+
         Y7BsePRh5Sh7RbX1ul782ng3E6SuAp0uMR9hb1E8dxEqZmfkl7RFc52X/MoZIM8+tGVY
         owLaQ9ej0vTw7sufSUlGSLRbVkftelEBjLANpDZoTYqPC0/v0atxLoX/bhgO7sRltedO
         4I8g==
X-Gm-Message-State: AOAM532+8Eo1pMHzNlF3dfXric2hCeQRKGjz2EY76B/CPzbNYZNkSIJa
        2W4Gw55ABrP2q2REc6H29RIfPA==
X-Google-Smtp-Source: ABdhPJyOTkICN4YqO6sBY9KVZKZwN4tZKj26B6Ouv61zvM8mNqCBCXzCiZKiaCYuSB7zFey8iigQIQ==
X-Received: by 2002:a62:27c6:: with SMTP id n189mr5195386pfn.277.1591837642232;
        Wed, 10 Jun 2020 18:07:22 -0700 (PDT)
Received: from localhost ([63.239.199.7])
        by smtp.gmail.com with ESMTPSA id n1sm1154969pfd.156.2020.06.10.18.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:07:21 -0700 (PDT)
Date:   Wed, 10 Jun 2020 19:07:20 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
Message-ID: <20200611010720.GA21728@syl.local>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes (and Dan)

On Wed, Jun 10, 2020 at 09:19:21PM +0000, Johannes Schindelin via GitGitGadget wrote:
> A growing number of open source projects aims to avoid the branch name
> master due to its negative connotation. See [1] for an existing discussion
> on this. The links [2], [3], and [4] describe community-driven ways for
> users to rename their default branches or use template edits to set a new
> default branch name.
>
> [1]
> https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com/
>
> [2] https://twitter.com/mislav/status/1270388510684598272
>
> [3]
> https://www.hanselman.com/blog/EasilyRenameYourGitDefaultBranchFromMasterToMain.aspx
>
> [4] https://github.com/ethomson/retarget_prs
>
> By necessity, existing repositories require a lot of manual work to move
> away from that branch name, but it should be much easier for new
> repositories.

This is (somewhat) orthogonal to the topic here, but I wonder if we
could be doing anything to make this easier for users.

Could servers remember that a branch has ``moved'' and alert users as
such when they pull? Even better, it would be nice if this alert from
the server could allow clients to automatically rename their refs
appropriately so that this transition is as easy as possible, even for
existing repositories.

> This patch series allows overriding the branch name being used for new
> repositories' main branch. The main way to do this is the new
> core.defaultBranchName config option. This first patch was contributed by
> newcomer Dan Goodman-Wilson. Thanks for the contribution!

Welcome, Dan! This is a fantastic first contribution, and I would be
honored to help and move this forward in anyway that I can.

I should note that I am technically "out of office" (which normally
wouldn't mean much, but this time means that I am on a road-trip, and so
am only at my computer infrequently). I am catching up on just a few
emails here, but I'll be able to help out more (and would be honored to
do so) once I am really back next Monday.

> The other patches follow other places where "master" is hard-coded and use
> the new git_default_branch_name() method to consume the config option before
> falling back to "master".
>
> The last patch updates documentation only after the config option is ready
> to apply to all of these scenarios.
>
> This series DOES NOT change the default automatically, but only provides an
> opt-in mechanism for interested users. It also presents a way forward for
> such a transition, if and when we decide to do so. Specifically, the new
> GIT_TEST_DEFAULT_BRANCH_NAME environment variable could be used to update
> test scripts on an individual basis instead of all-at-once.

Provided that the eventual plan is to seriously evaluate a name other
than "master", I think that this is a good way forward that clears the
way for us to make this change easily, without forcing us to come to a
conclusion on what name will replace "master" today.

For what it's worth, I am completely in favor of abandoning this term.
My colleagues at GitHub (as has been mentioned previously on the list)
are in favor of this as well, and it is my understanding that other
providers feel similarly.

I would be in favor of any non-offensive name that we can reach
consensus on. "trunk" sounds nice to me, but I think that it may cause
problems for non-native English speakers, so perhaps "main" or
"default" would suffice (maybe "main" is better, since it retains muscle
memory for the first two characters without being offensive--at least,
as far as I can tell. If I am wrong, please correct me and we should
consider something else).

All of that said, I can't emphasize enough how little I care about
*what* name we replace "master" with, so long as it is (1) replaced with
a non-offensive term, (2) that that change is done uniformly throughout
the "Git Ecosystem" and (3) that the community can reach consensus on
the new term in a respectful, appropriate, and considerate way. I only
provided a few suggestions to get the conversation flowing, although I
suspect that my help isn't needed there.

> Don Goodman-Wilson (1):
>   init: allow overriding the default branch name for new repositories
>
> Johannes Schindelin (8):
>   remote: respect `core.defaultBranchName`
>   send-pack/transport-helper: respect `core.defaultBranchName`
>   testsvn: respect `core.defaultBranchName`
>   submodule: use the (possibly overridden) default branch name
>   clone: learn about the possibly-configured default branch name
>   fmt-merge-msg: learn about the possibly-configured default branch name
>   fast-export: respect the possibly-overridden default branch name
>   Document how the default branch name can be overridden
>
>  Documentation/config/core.txt |  4 ++++
>  builtin/clone.c               | 14 +++++++++++---
>  builtin/fast-export.c         | 10 +++++++---
>  builtin/init-db.c             |  8 +++++---
>  builtin/submodule--helper.c   | 10 ++++++++--
>  fmt-merge-msg.c               |  6 ++++--
>  refs.c                        | 34 ++++++++++++++++++++++++++++++++++
>  refs.h                        |  6 ++++++
>  remote-testsvn.c              | 11 ++++++++---
>  remote.c                      | 12 ++++++++----
>  send-pack.c                   |  6 +++++-
>  t/README                      |  4 ++++
>  t/t0001-init.sh               | 20 ++++++++++++++++++++
>  t/t5609-clone-branch.sh       |  9 +++++++++
>  t/t6200-fmt-merge-msg.sh      |  8 ++++++++
>  transport-helper.c            |  6 +++++-
>  16 files changed, 146 insertions(+), 22 deletions(-)
>
>
> base-commit: 0313f36c6ebecb3bffe6f15cf25a4883100f0214
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-656%2Fdscho%2Fdefault-branch-name-option-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-656/dscho/default-branch-name-option-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/656
> --
> gitgitgadget

Thanks,
Taylor
