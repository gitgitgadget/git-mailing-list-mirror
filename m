Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9E5C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 05:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981C260F4A
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 05:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhIEFeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 01:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhIEFeM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 01:34:12 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2EBC061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 22:33:10 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so4411854otg.11
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 22:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJcNfd+B2DgMpX2OvOoxdpK0ZAYdzHfm53tftXouzSY=;
        b=KwtZqDMjM2l0B4O7dkQMyFBKM9mwWCrVGofJs/yyUKWf0gcJVmJE6Gf8xqYGYDIkKZ
         jmXbgQWBPfwumjM7Cys/UJqwzbFbAkblz2WAw3R9Aygy+LPaiyrpcvlS2/BWx9D+maZ7
         EPDWnrWy63pbTdHUef8qp7nWcHX3WDguAZtThiHQyK79J+xor66YWX5CWDmag5pz/YUU
         eP01DpSnj+XVtwSpyiZLqnYkf8SWfYxIbtOkgE5i+b66OdR2GO4QFDenm8MYUGvceh4B
         o0KZRIPG9x9Fx++sux0oUBMeAazyjsexWoRsbjR1emXpgxgnq1pYarNOLGxVxd5Q0NAs
         Fdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJcNfd+B2DgMpX2OvOoxdpK0ZAYdzHfm53tftXouzSY=;
        b=aquAfirukqXMEIn9OJv0pBMLmnjdY4asf07T6fEoJbga/0tix4/v+64hw/aj8hTqjL
         RHjHgzn1w3pcn5ObsrqT4U+ec8gpCWBHAOkCwP5fAFolGr5nkxihfsx0veC4lnGIBvlO
         RYFm4jQ7vE2Gm/VUfHv2wNO1IGYGitcFRKPyLZTLHo9H29L5/NHkfNvLkldwlbEKCopx
         ps+A8+YtlVM6cXHfWtsi0TLPVEITlaw++L/hcMzdXioFWPA/wZK5x7nKx3vk/4CnGROj
         ZRGyo5xEj6z/ieNFXq9EBQeLGCsI6UDj+aTu51IVQYvDGIEzJJ8zD3OKIPtVKQNGnpqU
         9uUA==
X-Gm-Message-State: AOAM533xzq7ra+gQuLv563o14UygvwYXK3vWkG+6S98oxPw0WJQtgGVV
        o6rEyR6OlgzcC8mNYUILdmol2rB1deXZYib1s2Y=
X-Google-Smtp-Source: ABdhPJxzTn8Cj+qeApETDLfA3oi+UVRQKyTA3YB9kJeRr0l8g7ARNFlmI5EFfVCQQ1gyuhr9S0uBAA80fs0Uprzc8sw=
X-Received: by 2002:a9d:7204:: with SMTP id u4mr5969024otj.276.1630819988434;
 Sat, 04 Sep 2021 22:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com> <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net> <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
 <YTNH2vMPuEW4SBMo@coredump.intra.peff.net>
In-Reply-To: <YTNH2vMPuEW4SBMo@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 4 Sep 2021 22:32:57 -0700
Message-ID: <CABPp-BFyR19ch71W10oJDFuRX1OHzQ3si971pMn6dPtHKxJDXQ@mail.gmail.com>
Subject: Re: Aborting 'rebase main feat' removes unversioned files
To:     Jeff King <peff@peff.net>
Cc:     Fedor Biryukov <fedor.birjukov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 4, 2021 at 3:19 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Sep 04, 2021 at 11:51:19AM +0200, Fedor Biryukov wrote:
>
> > There is no way this could be the intended behavior, but the good news
> > is that I cannot reproduce it...
> > Looks like it occurs only in one git version (2.31.0.windows.1, IIRC).
> > And it does not occur in the latest git version: git version 2.33.0.windows.2.
>
> I think it is a bug, and it seems to reproduce easily for me (with both
> the current tip of master, and with v2.33.0). Here's the recipe you
> showed, with a little debugging at the end:
>
>   set -x
>   git init repo
>   cd repo
>   git commit -m base --allow-empty
>   git checkout -b feat
>   echo feat >readme.txt
>   git add readme.txt
>   git commit -m txt=feat
>   git checkout main
>   echo precious >readme.txt
>
>   cat readme.txt
>   git checkout feat
>   cat readme.txt
>   git rebase main feat
>   cat readme.txt
>
> This produces:
>
>   + cat readme.txt
>   precious
>   + git checkout feat
>   error: The following untracked working tree files would be overwritten by checkout:
>         readme.txt
>   Please move or remove them before you switch branches.
>   Aborting
>   + cat readme.txt
>   precious
>   + git rebase main feat
>   Current branch feat is up to date.
>   + cat readme.txt
>   feat
>
> So git-checkout was not willing to overwrite the untracked content, but
> rebase was happy to obliterate it.
>
> It does the right thing in very old versions. Bisecting, it looks like
> the problem arrived in 5541bd5b8f (rebase: default to using the builtin
> rebase, 2018-08-08). So the bug is in the conversion from the legacy
> shell script to C (which makes sense; the shell version was just calling
> "git checkout", which we know does the right thing).
>
> -Peff

Turns out this is quite a mess.  It's also related to the "don't
remove empty working directories" discussion we had earlier this
week[1], because we assumed all relevant codepaths correctly avoided
deleting untracked files and directories in the way.  But they don't.
And rebase isn't the only offender, because this is buried in
unpack_trees.  In fact, it traces back to (and before)
    fcc387db9b ("read-tree -m -u: do not overwrite or remove untracked
working tree files.", 2006-05-17)
which has additional commentary over at
https://lore.kernel.org/git/7v8xp1jc9h.fsf_-_@assigned-by-dhcp.cox.net/.
It appears that before this time, git happily nuked untracked files
and considered them expendable, in basically all cases.  However, this
patch continued considering them as expendable whenever opts->reset
was true.  There wasn't much comment about it at the time for the
reasoning of how opts->reset was handled, though trying to read
between the lines perhaps Junio was trying to limit the backward
compatibility concerns of introducing new errors to fewer code paths?
Anyway, Junio did mention `read-tree --reset` explicitly, but this
opts->reset usage also occurs in am, checkout, reset -- and anything
that calls the reset_head() function including: rebase, stash,
sequencer.c, and add-patch.c.

So, then...should we preserve untracked (and non-ignored) files in all
these cases?  This rebase case seems clear, but others might be less
clear.  For example, should "git reset --hard" nuke untracked files
(what if it's a directory of untracked files getting nuked just to
place a single file in the location of the directory)?  The
documentation isn't explicit, but after reading it I would assume that
untracked files should be preserved.  Since we've had bugs in "git
reset --hard" before, such as requiring two invocations in order to
clear out unmerged entries (see [2] and [3]), that also suggests that
this is just another bug in the same area.  But the bug has been
around so long that people might be expecting it; our testsuite has
several cases that incidentally do.  Granted, it's better to throw an
error and require explicit extra steps than to nuke potentially
important work, but some folks might be unhappy with a change here.
Similarly with "git checkout -f".

And stash.c, which operates in that edge case area has tests with
files nuked from the cache without nuking it from the working tree
(causing the working tree file to be considered untracked), and then
attempts to have multiple tests operate on that kind of case.  Those
cases look a bit buggy to me for other reasons (I'm still digging),
but those bugs are kind of hidden by the untracked file nuking bugs,
so fixing the latter requires fixing the former.  And stash.c is a
mess of shelling out to subcommands.  Ick.

I have some partial patches, but don't know if I'll have anything to
post until I figure out the stash mess...

[1] https://lore.kernel.org/git/YS8eEtwQvF7TaLCb@coredump.intra.peff.net/
[2] 25c200a700 ("t1015: demonstrate directory/file conflict recovery
failures", 2018-07-31)
[3] ad3762042a ("read-cache: fix directory/file conflict handling in
read_index_unmerged()", 2018-07-31)
