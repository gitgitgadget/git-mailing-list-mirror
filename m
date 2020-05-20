Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA0C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 13:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083DC207D3
	for <git@archiver.kernel.org>; Wed, 20 May 2020 13:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRSOyfVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgETNi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETNi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 09:38:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2548C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 06:38:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cx22so1301855pjb.1
        for <git@vger.kernel.org>; Wed, 20 May 2020 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=BfLiFc2+gkO4h5OwoHadO28OBh7X+JjeiaX+C6H0Cks=;
        b=VRSOyfVm7/WfXMtSCRfB4ggMsO85C3500Ec5/IJqmNvLQid6gsOmjEXBK4mKSiVAFO
         MyflJVkY31yTAEzYChDiSHFM+wDneoNload/oyca71YPqIoer9sj/JiQ69ppIbMGyHMq
         W0TBr0a9YSdFqhyqhofLT2B3HI7nlypAiecXBJn6lu9/noOFDjOIe6e9LPbApSd+IOCs
         DHWB6ryyhgZ3+GJTwUGArSx5LRs/KGW8i5wRVo3t7kBmYfse/ypj4cVB1IQ07zON2pM1
         DVlYNrc2lpZNGcn4Y2pOuupezd+oajZO6GVN1FWwY1I4K3oee65bmdlSZBExz6GbGTfS
         S31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=BfLiFc2+gkO4h5OwoHadO28OBh7X+JjeiaX+C6H0Cks=;
        b=HzUsNTqKW0fEJWE2qq/AyP1Pr1xhycjyeLhZFUP8apTdea1pG+2HD/ZJ3vsRSWz/EF
         gNEWUtWKnflrIQ5n/OybUVfkLmXi1gYPXAMkcWdhz2b0ilPBo/3XRtjQO9uVv1QpbbYs
         GzTVkmjJxKRs/vNbauzMU+uVdXt5lp4mn/qf73iIWu4fE+Bx2LjfvtCU6KSM2YmaLCo9
         DtAu4mcRh3bULvJP6/iqaY2NYtRHV4ywJD55XNIvwije2mmad5lohfiVPtz1pLJrSZWC
         xpsgYPLEZDertmicgNJFKeCDM6IaJlQiXjxgXxgtuwsi42MhyJFpgWlxBu8NWhutYBng
         0kww==
X-Gm-Message-State: AOAM5322KWqYx3paMnSnUYVWqw46gTYQ9qVj0xVkxqJ8x1nyJZJhdCRI
        RHhHZr9CzLS87sgxpS4dk0QtQqE42XersQ==
X-Google-Smtp-Source: ABdhPJzKK66aIOuzJ4wZIF4vnikN95Z0n64a1tbI3h/85Rs934YTEZrYZFgkRrrQUIptmaBOM9wSNQ==
X-Received: by 2002:a17:902:7488:: with SMTP id h8mr4771032pll.128.1589981905924;
        Wed, 20 May 2020 06:38:25 -0700 (PDT)
Received: from konoha ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id x20sm2266294pfc.211.2020.05.20.06.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 06:38:24 -0700 (PDT)
Date:   Wed, 20 May 2020 19:08:20 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     jonathanmueller.dev@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: Bug: git worktree remove and overwritten directory
Message-ID: <20200520133820.GA15133@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89526b3a-297d-591d-6e12-48580d697ed5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jonathan!

> And both `git worktree remove .` and `git worktree remove ../test2`
> report an error `fatal: '../test2' is a main working tree`. I had to
> manually remove the corresponding folder from `.git/worktree` to get rid
> of it. The issue is especially annoying, because you can't check out
> `some-branch` anymore (as it's already checked out in the worktree).

If you refer to the documentation of `git worktree` you may find this:

    Multiple checkout in general is still experimental, and the support
    for submodules is incomplete. It is NOT recommended to make multiple
    checkouts of a superproject.

Alright, so if you were to do a checkout to `some-branch` even if you
never deleted anything, you won't be able to perform this action because
it's not possible, therefore *this* thing is not a bug. Why can't you
perform this you ask? Because this is the point of the whole command. If
you were allowed to checkout, then you would be able to have two
different copies of the same thing at one instant of time, which is
something we don't want.

Moving on, one may say, "I am technically in the same repo only, its
just that the folder names are changed, so I can technically do a
checkout now because my worktree is gone right?". No, we cannot,
because: technicalities. You see, that when you create a worktree,
you add an entry in `$GIT_DIR/worktrees/` that `test2` is a registered
worktree by you. Now if one does the mischief you did by renaming `test`
to `test2`, you confuse the system as to what exactly is going on. It
still thinks that we are on `test2`, but in fact we are on `test`.
Hence, the dual nature we have here. Please refer to this for more detail:
https://git-scm.com/docs/git-worktree#_details

Now, if you delete the `$GIT_DIR/worktrees/` folder (proceeding
further), you will be able to checkout to `some-branch` because the
confusion is gone now as Git is not aware of any worktrees you ever
created.

Therefore the final set of commands to overcome this will be:
    git init test
    cd test
    git commit --allow-empty -m"Initial commit"
    git branch some-branch
    git worktree add ../test2 some-branch
    cd ../
    rm -rf test2
    mv test test2
    rm -rf .git/worktrees
    git checkout some-branch
    ... we can checkout successfully now :)

Now, I can be wrong in some places in my explanation, but this is what
I could infer from the problem.

So, coming to the ultimate question:
    Is this a bug?
I don't really think so. Why you ask? Because this is the way things
should have functioned. It is more of a vulnerability.
You may want to refer to this:
https://stackoverflow.com/a/402944/10751129

But again, this doesn't mean that it can't be fixed.
Thanks to you I got introduced to a new git command (git worktree) :)

Regards,
Shourya Shukla
