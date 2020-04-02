Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A981BC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7FC2078B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDkyDfUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389957AbgDBQ61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:58:27 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:37067 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389933AbgDBQ61 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 12:58:27 -0400
Received: by mail-ot1-f52.google.com with SMTP id g23so4180651otq.4
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TeDlSIr1nRXmRjTI9c7A2TdLw3Oc2CVbyGNX6BnZ7vA=;
        b=aDkyDfUzD6ZwI6vxAuNIxthtFaQw1yfanMqbH5p+UhlshIX6a+5XEvSoUUWwr6Y9tq
         2XMIOolsaCX6sDx1pWc0qUMnScBmWN76aO1Ml60Ek25e2EtgLz+pG+SJqNqaHAfW1Ibd
         RNeuQUc/42fwq4FttGk3aA98/5Kg/i8lc3wJA6jg9hTpz4JJ/Snb2cHDPaSf/DueBKJh
         MiFdPUVYT2xEx2aOo+nf3zHTcfDLM27eWJgcf/ngoQscZrjmt56GFLyCeqUyS9/e/8za
         pSwRg8KpdM8TFhRbZSHUPnsHN87TWrhIdSrrvo2SJqNTnDiEDL+PA5Ocgo93cKgWb5nt
         27RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TeDlSIr1nRXmRjTI9c7A2TdLw3Oc2CVbyGNX6BnZ7vA=;
        b=MnJYpkAP8Tp1vaFUbi1lggNz1DvLOfytQ+I8Ux03dy2vZGyivEZjiaGT6kHcAmPVyS
         Enhl+N4BlW2564LGQCUSwnWwGIvz772dfaT8mWseIN4a3YZh35462WJ7BG78eN37FlE0
         8w4BMjQolX7bEcChbypyX4h5zczDdaiXKZXFtbfRZwx4Gda6ftho/t4ovRWXDtnEQzD7
         ePdtX8V0Juf7IC/b9aHpgCDTFBJqfSx5cOsAsbjoeNScObKdPTp10ujl7w5OWGxliqMP
         nMX26gKTBuuTC8fOHqrqbwHS5RHTBk2Js+GZE/AHbMJXAPd8z8o84T1t9/0V5+3sdPgU
         jwVA==
X-Gm-Message-State: AGi0Pub5OokQ9X3qivylM7vDU+h2yb782ZXha9vqF/lLmmYNTOSvXOaw
        8AafHJLbP85IFEsSnbCxkv2ORtqO6ewXJZXvArw=
X-Google-Smtp-Source: APiQypJS6j2C6mrq9hwVA6swL9v6wErxTk45wPcBdaGoDXofkKHrBA87/eniASihTlmg2nuzpeHOPrqyTwqoM3FPsfE=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr3248737oti.162.1585846705979;
 Thu, 02 Apr 2020 09:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <9945492E-1D97-4741-B999-F30CA561D4DE@gmail.com>
In-Reply-To: <9945492E-1D97-4741-B999-F30CA561D4DE@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 2 Apr 2020 09:58:14 -0700
Message-ID: <CABPp-BG0bFKUage5cN_2yr2DkmS04W2Z9Pg5WcROqHznV3XBdw@mail.gmail.com>
Subject: Re: git rebase backend change: post-checkout hook is not ran by
 'merge' backend
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Apr 2, 2020 at 8:57 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hello,
>
> I'm not sure if this has been reported yet (couldn't find it),
> but I noticed a behavioral difference between the merge
> and apply backends that is not mentioned in the documentation:
> The 'apply' backend will run the post-checkout hook just after
> moving HEAD to the commit we are rebasing onto;
> this does not happen with the merge backend:
>
>     $ echo "echo \"Running post-checkout hook\"" > .git/hooks/post-checkout
>     $ git checkout -b <branch1> <commit2>
>     $ git rebase upstream/master --apply
>     First, rewinding head to replay your work on top of it...
>     Running post-checkout hook
>     Applying: <commit1>
>     Applying: <commit2>
>     $ git checkout -b <branch2> <commit2>
>     Successfully rebased and updated refs/heads/<branch2>
>
> Cheers,
> Philippe.

Interesting.  We had a report about the post-commit hook, but not
about post-checkout.  From the description in the githooks manpage
it's not clear to me that either rebase backend is correct or
incorrect here, but they should at least be consistent.  Also, if
rebase should call post-checkout, should cherry-pick?  If cherry-pick
should, should commit or revert call it?  What about reset or merge?
This hook to me seems to be rather badly defined because If any
operations other than checkout/switch should call it, then you've got
various angles of weirdness if you don't include all the others too.
(Also, digging through the history, the only reason that the apply
backend called the post-checkout hook was because it was written as a
script and invoked 'git checkout'.  But then someone noticed that the
scripted version called the hook and thus ported it to the builtin.)
From another angle, maybe you could make the cutoff be only when HEAD
changes which symref it points to (meaning rebase would only call it
if you asked it to rebase a different branch than you were on), but
that has its own weirdness too.  I think this hook is really weird,
unless we restrict it to only the things already explicitly mentioned
in the githooks manpage.

In any event, I guess that means we need to update this section of the
rebase manpage:

"""
Hooks
~~~~~

The apply backend has not traditionally called the post-commit hook,
while the merge backend has.  However, this was by accident of
implementation rather than by design.  Both backends should have the
same behavior, though it is not clear which one is correct.
"""

to also mention post-checkout, note that the situation about which
backend calls this hook is reversed relative to post-commit, and again
mention it's not clear which backend is correct.

My very rough opinion of the moment is:
  * post-checkout should probably do as the manpage says, and only run
for checkout/switch plus new worktree situations (worktree add/clone).
rebase --apply should stop calling it.
  * post-commit is horribly broken; it hardcodes an assumption of
exactly one commit.  Also, it's a huge performance problem when things
want to create multiple commits.  So, let's do as the githooks manpage
suggest and call this hook from a direct "git commit" -- and _only_
from there.  Remove it from rebase, cherry-pick, revert, etc.
Normally, for consistency, I would say that merge should start calling
that hook (it only creates one commit, and "git commit" is used to
complete an interrupted merge anyway so why not uninterrupted ones),
but merge can be called by rebase --rebase-merges right now so that
pushes us back to the get it out of rebase side.  The hook is kinda
broken anyway, so maybe limit exposure?
  * Make a new post-batch-commit hook called by things that create new
commits, but only call it once per operation (e.g. rebase and
cherry-pick call it once rather than once per commit).  Have commit,
merge, and revert all call this too.  Not sure what to do about things
that change multiple refs simultaneously, e.g. fast-import (or things
like it, e.g. filter-branch).

CC'ing Jonathan and Emily since they've thought a lot about hooks, and
whom I thought might be making changes in this area[1][2].


Elijah

[1] https://lore.kernel.org/git/20200116203521.GA71299@google.com/
[2] https://lore.kernel.org/git/20200115215922.GI181522@google.com/
