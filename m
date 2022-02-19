Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F15C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 16:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbiBSQna (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 11:43:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiBSQn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 11:43:29 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712945F4DD
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:43:09 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bg10so22339516ejb.4
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6OGUlBz+AptJjmMz37BRjaC8vLcLLtI2bBRXCgrlng=;
        b=PPNUL5t+FQR9C+mvOZnRsJrt7IT5q8l7Nn6QanvFPiJwX1Hh7V3vhVUxHK71MH59rW
         bXeaaUiSBW/aOd/a5ySOc3MU0U9XYERXbpNOPWWTOS/EBiCXDyIXVkvKjhoQQAxguMdU
         /dqCXuUJdqt9+QkTF+rBLoB6bJCqPM+B7/EuZlTBen/vROm6x8GjpQfTxC/e/KoLA4Ry
         p89rM0eX70fLWxXf6yfl6cekeeGoNR+u90Q3tJIuH3/8KK8YE1qg4mbUSxANAxXpmB78
         6mQb1v262YPx6SexzLOHzmpO9jugiY4csyyEk+gCcyAYux/An8sr5sfsspsJpztgw1rc
         jcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6OGUlBz+AptJjmMz37BRjaC8vLcLLtI2bBRXCgrlng=;
        b=yGI56JqCA+GgXPzUUFKcwDDhXiSePR7CdZvOIRPm8htfDlABRGd370w26xPNZeSLOP
         mRa4oBbUGU3kPOzbfLVY9iTNfeo1VzetJjyGP+I9UXpxH/M5FcQ2qI5lDYysBM2U7dpq
         O3FD/mYypYEj93APJ22nA7kVUX2sGWl+9sssHHT/ntgHm4K3mi1X+ZvgFQDxnJ63b7vz
         EXNM5IngIIHQwI7L06lTuUHQLtnTLvFFH4WLrQbnFIB64o3s9UhecUoJ0jrQqwehDJdB
         CvTEepW1bPcNGmId/T1RnTD8seazoOC9U23vusbOKLDEv3EGdrcuEJAh10HAIjIMAc2C
         xRJA==
X-Gm-Message-State: AOAM531dXL4l1jA34Ygbn6Qod+cHQJnqeQI6FWM0RdNcykD2gvhaQKjk
        H1Myc5vAUIGsIVnQHwTraYCgwM03ZCnKw+V3pv0=
X-Google-Smtp-Source: ABdhPJw4pS6CHaGkEuVEUu8XJioIL2HDa8z3FqVZUrYUkCmFgRU7t50zNkOq8EqOxZJly1WSHMcGDE6cGSVktNwn1DE=
X-Received: by 2002:a17:906:350d:b0:6b9:5871:8f34 with SMTP id
 r13-20020a170906350d00b006b958718f34mr10291806eja.493.1645288987713; Sat, 19
 Feb 2022 08:43:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com> <11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com>
 <YhBCsg2DCEd9FXjE@google.com>
In-Reply-To: <YhBCsg2DCEd9FXjE@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 19 Feb 2022 08:42:56 -0800
Message-ID: <CABPp-BHU4VYXF8kNvZEwBLu2BYP2Q1c9dYMW_8QfNmvGjB1ZOA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] repo_read_index: clear SKIP_WORKTREE bit from
 files present in worktree
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 18, 2022 at 5:07 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> (cc-ing Jonathan Tan, Jose Lopes, and Jeff Hostetler, vfs experts)
> Hi Elijah,
>
> Elijah Newren wrote[1]:
>
> > The fix is short (~30 lines), but the description is not.  Sorry.
> >
> > There is a set of problems caused by files in what I'll refer to as the
> > "present-despite-SKIP_WORKTREE" state.  This commit aims to not just fix
> > these problems, but remove the entire class as a possibility -- for
> > those using sparse checkouts.  But first, we need to understand the
> > problems this class presents.  A quick outline:
> >
> >    * Problems
> >      * User facing issues
> >      * Problem space complexity
> >      * Maintenance and code correctness challenges
> >    * SKIP_WORKTREE expectations in Git
> >    * Suggested solution
> >    * Pros/Cons of suggested solution
> >    * Notes on testcase modifications
>
> Thanks for a clear explanation!  This is very helpful.
>
> > === User facing issues ===
> >
> > There are various ways for users to get files to be present in the
> > working copy despite having the SKIP_WORKTREE bit set for that file in
> > the index.  This may come from:
> >   * various git commands not really supporting the SKIP_WORKTREE bit[1,2]
> >   * users grabbing files from elsewhere and writing them to the worktree
> >     (perhaps even cached in their editor)
> >   * users attempting to "abort" a sparse-checkout operation with a
> >     not-so-early Ctrl+C (updating $GIT_DIR/info/sparse-checkout and the
> >     working tree is not atomic)[3].
> >
> > Once users have present-despite-SKIP_WORKTREE files, any modifications
> > users make to these files will be ignored, possibly to users' confusion.
> [...]
> > The suggests a simple solution: present-despite-SKIP_WORKTREE files
> > should not exist, for those using sparse-checkouts.
>
> This patch just reached "next", so at $DAYJOB a test for our vfsd[2]
> noticed this change.  The trick behind a Git-based virtual filesystem
> is typically:
>
> - since we control the filesystem, we can pretend all files are
>   already present.  On access, we obtain the file content from the git
>   object store.  On write, we update the sparse-checkout pattern so
>   that Git knows to start tracking the file.
>
> - by keeping the sparse-checkout pattern narrow, we minimize the time
>   commands like "git status" need to spend looking for changes in
>   unmodified files.  Controlling the filesystem means we don't need to
>   worry about changes to files that don't match that pattern (since
>   any modification would also trigger a sparse-checkout pattern
>   update).

Sorry for the headache.

Let me try to restate the problem I'm solving, then attempt to put
your above situation into my own words, to verify I'm understanding...

So the primary challenge I was trying to address with this patch
series, was that keeping the filesystem and the "sparsity" state
in-sync was just *difficult*.  Things like checkout-index or even
diff+apply will write to the working tree without even thinking about
updating the sparsity state in the index to match.  And that's only
looking at Git-related commands.  People can write new copies of files
manually in a myriad of ways.  Detecting and handling that
inconsistent state between the working tree and index wasn't as easy
as it looked.

One way to solve this problem would be to have a vfs, where any time
someone writes to a file, you update the index to clear the
SKIP_WORKTREE bit for the written file.  Sounds like you have such a
thing. (...or close to it, since you'd update the sparsity patterns,
and the tooling to check mismatches of sparsity patterns and the index
state are good and those get updated nicely.  We just struggle to have
something that correctly updates between index and working tree
mismatches of sparsity state).  So, that basically means you wouldn't
benefit from this change.

But for those of us without some kind of vfs that detects writes and
auto-updates either the sparsity patterns or the SKIP_WORKTREE bit in
the index, we want something that will manually check the working tree
to see if files have been written and update the index accordingly.

And, of course, you're trying to do more than just detect
inconsistencies -- you want the vfs to fully control the sparsity
patterns and expand them based on dynamic file accesses by the user.
That dynamic bit doesn't play well with the non-vfs workaround.


Does that sound right?

> If I understand the intent behind this change correctly, it's
> incompatible with that trick.  How would you recommend handling that?
> In the not too far away future, I'd expect something like the "VFS
> projection hook" to handle this use case, but in the meantime, I would
> expect this change to break VFS for Git performance.  A few options:

Side note: I thought Microsoft's vfs was first named GVFS and then
based on naming collisions renamed to VFS for Git.  Sounds like you
have something that is probably a bit different, but which you are
also calling VFS for Git?  Is there some potential confusion here, or
are you banking on Microsoft eventually dropping their project?  Or
that you'll both keep your projects internal and not share them so the
naming collision doesn't matter?  Just curious...

>  a. We could guard it with a config option.  It would still be a
>     regression for VFS for Git users, but they'd be able to use the
>     config option to restore the expected behavior.  (Or
>     alternatively, such a config option could be disabled by default,
>     but I suspect that would defeat the purpose described for the
>     patch.)
>
>  b. We could distinguish between the vfsd and the "interrupted and
>     forgot to update SKIP_WORKTREE bits in the index" cases somehow.
>     This sounds complex.
>
>  c. Something else?
>
> (b) and (c) aren't sounding obviously good, so (a) seems tempting.
> What do you think?

Yeah, I'm having a hard time coming up with a way that either the VFS
could recognize these special Git present-despite-skip-worktree checks
and treat them differently, or having Git recognize that it is running
under a special VFS that likes to aggressively and automagically
expand the sparsity patterns.  So (a) seems tempting to me too.

Got any name suggestions?  core.avoidPresentDespiteSkipWorktreeCheck
(defaulting to false)?  core.sparsityConsistencyCheck (defaulting to
true)?

Did your team want to implement that on top of
en/present-despite-skipped since you can verify if it works for you,
or did you want me to take a stab at it?  Should be a pretty simple
change.

> Thanks,
> Jonathan
>
> [1] https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/
> [2] see
> https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/
> for what I mean by "vfsd"
