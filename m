Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848AFC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 10:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiBCKm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 05:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiBCKmz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 05:42:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D455CC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 02:42:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so1539971wmb.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 02:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yLCdvYT0Njkf7al/XvrKA/UH2G+7FQWWQzGr72MZg/o=;
        b=pj3fCOsJgb8mNsP/L8DnKuMcNt+E1bxJRtYcS+8erY0UMJsHhJqaMws2ajryIn11lN
         irDmr4MhU+5kzGG1XtJn3ybkvDZiCON565STlFgZSoI3435SubH+MYra3Nsaa1i46Ojk
         InCHr9vDW1+EN7L0G6FaP1QmuCts3mjMw/P6zXLWwrfqA5vHj2iN0tj7QJ0HIgSNJuBX
         74K/SMmcIG5iYXmLWKc//DfhVIYXVPJ9grmuirnF7AtD1jv6KgYZqw+a0wpAK0Gi7MTB
         w/dQUw0Wfsk85wME3KNnUHDSfKXfILnIth6S7v4UFLHVSEEvoG4EiMhFYINA+so7D0M3
         dkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yLCdvYT0Njkf7al/XvrKA/UH2G+7FQWWQzGr72MZg/o=;
        b=3+pcBd6tG9SQ1wThmq0pFcH2AriPrluptha0JeS1ApV4/pshd4LLd9pDrMKlAQunqV
         brY9TOewAsErvipujZj5aq1uNY4+SVPSWjr+90ttgpdtUhPXwlo61AjTmVPUhtblUKP2
         qMLZKMhPWZYN8UHQA+n+U7hjdLsKcTUcwpcFhcs9o9n1JURfolCLSIrvdsigXQWLbJVA
         tL8FGVg+RWkFFkQK392t+H2j+3+Lxxre1nd5lXADWf9HqvHtpx+mPZ6yruP/KB+ZoHlz
         4Ac5B13MGu4Pfn2rwmlpUlk8QfgLVX5GGKGLVtvEQELGts8iKV/D3Dbfc8xTDYhnO1jN
         kDkg==
X-Gm-Message-State: AOAM533NLNLFkMWQOX1nncHMfurjTcaLIn2Fp4ik5EEp9AZBvX/aNekE
        WNf5gWu2WITY2Zww2RzHook=
X-Google-Smtp-Source: ABdhPJyCd8wVh8WdwdmoLnQZKal+huoZCjxWtn+dAkKwk8lom1+LRQrE442x+1BasQl0oW3S8POlnQ==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr10082833wml.136.1643884972716;
        Thu, 03 Feb 2022 02:42:52 -0800 (PST)
Received: from gmail.com (91.141.39.161.wireless.dyn.drei.com. [91.141.39.161])
        by smtp.gmail.com with ESMTPSA id n13sm7412968wms.8.2022.02.03.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 02:42:51 -0800 (PST)
Date:   Thu, 3 Feb 2022 11:42:41 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
Message-ID: <20220203104241.yvfragan6ucecfjl@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
 <xmqqy22tx8t1.fsf@gitster.g>
 <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
 <xmqqh79hvsgn.fsf@gitster.g>
 <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 02, 2022 at 04:18:39PM -0800, Elijah Newren wrote:
> On Wed, Feb 2, 2022 at 2:01 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > Yes, you are reading right.  I think the cherry-pick/rebase
> > > replacement actually deserves a separate command from what merges
> > > should use; replaying a sequence of commits just has a number of UI
> > > differences and abilities that I think pull it in a different
> > > direction.
> >
> > I completely disagree.  Each individual step in a sequence of
> > replaying commits in order (or in reverse order) should be
> > scriptable as a single merge-tree that takes "apply the change to go
> > from A^ to A on X".  Sequencing and placing UI around it is a job
> > for the script that drives merge-tree.
> 
> Adding such an ability to merge-tree would be trivial -- it basically
> involves just two things: (1) accepting one extra argument, and (2)
> calling merge_incore_nonrecursive() instead of
> merge_incore_recursive().
> 
> However, I think forking a subprocess for every merge of a series of
> commits is a completely unreasonable overhead, so even if we provide
> such an option to merge-tree, I still want a separate plumbing-ish
> tool that does non-worktree/non-index replaying of commits which is
> not written as a driver of merge-tree.  That other tool should just
> call merge_incore_nonrecursive() directly.  And such a tool, since it
> should handle an arbitrary number of commits, should certainly be able
> to handle just one commit.  From that angle, it feels like adding
> another mode to merge-tree would just be a partial duplication of the
> other tool.

I wonder how the UI of a tool that does non-worktree/non-index cherry-picks
will look like.  I'd expect it to produce the same output as merge-tree,
except cherry-pick should probably output a commit OID, not a tree.

Maybe we want a unified command that produces commits from any sequence of
merge/cherry-pick/revert/reword steps. The obvious UI would use something
like the rebase-todo list as input.  For example:

	$ echo '
	pick commit1
	reword commit2	# edit commit message in $GIT_EDITOR
	merge commit3 -m "log message"
	' | git create-commit commit0
	<OID of final commit>

we start from commit0 and apply steps one-by-one. Obviously, one unsolved
problem is how to pass parameters like commit messages if no editor should
be invoked (my sketch uses -m).
If any of the steps fails when merging merge, then we get the tree with
conflicts

	$ echo '
	pick commit1
	pick commit2
	pick commit-that-does-not-apply
	' | git create-commit commit0
	<OID of commit after step 2>
	<OID of toplevel tree after failed merge>
	<Conflicted file info>
	<Informational messages>

Replaying a series of commits might look like this:

	$ echo 'pick commit1 ^commit0' | git create-commit new-base

I'm concluding that this is a difficult UI problem, and having a merge-tree
command that accepts a "common ancestor" parameter could make it easier
to experiment.  Of course that depends on who is experimenting.

> 
> However, if the other tool doesn't obviate the need for this
> additional mode (perhaps it ends up being forced to be too
> porcelain-ish insteading of plumbing-ish?), or folks really just want
> another merge-tree mode, I'm happy to add one along with the tool I
> submit later.  Does that sound reasonable to you, or is there
> something you're still objecting to that I've missed?
