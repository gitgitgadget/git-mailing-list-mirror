Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B28DC432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 04:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9FD20716
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 04:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W342XKA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfK3EWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 23:22:50 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:36804 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfK3EWu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 23:22:50 -0500
Received: by mail-ot1-f49.google.com with SMTP id d7so9547718otq.3
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 20:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvUht2f4b/FDxyuNTSY8uKZ/IaDlz9zjrytsG/BBoV8=;
        b=W342XKA+ZPoWbP0zVyJLT+24bb5pCwpl5yKB6oi6VnSFXoJFBYgq5apeNi9KMSRsXC
         w1sDDuPK/AqYsTk9zFN4uPpgGYA4SvSCKZ6KmU58S9dhUa+nbS0VDKLyLxZm1+UJuycP
         5w9iAO7MaIvpkWs1yBdqKdzTSaqdbOqp0zZ/0qKNSDqqfjSkBbQd98UG5SQ+Sf5Wr3RG
         j+8I2iSeWJ725fN+X0RZFsM0cePP8TGL4RPnm4fI0QlipTJc8HccdyORDyH357UY5Fil
         8JLd9Gjs1fJ6JC5EmaKO4MMeXaTAau354k0Rjj19NnYP1vGrAIsIyKasy7KBvCgBDazL
         BwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvUht2f4b/FDxyuNTSY8uKZ/IaDlz9zjrytsG/BBoV8=;
        b=BReycHmnd5dTy2dvp2WwXgHrg8FiZs4XAthLZNcO7VbrR+yoqegBxVVX22ovBmU7iC
         5HCGn81XDvt+4hcrXe87okFgmWF1dxxzNw4Zfuqrz6CHZFS0PBZJ6XStKpJTGvl8B7F2
         HeiKzPvDMgAoDeutgcPGGAgLYNIwllIRYStbToe/d31SnVBxOKCuqGy3MLUJfBc/2Bmv
         Mi6ybljYKM1MEx9lSnWa8uqc17XCp7mWFy8dM1jwSuYinOG/iXddQWoFy1lq1UatgbnK
         gB4qzadTJ3YCzh7XjGDoY+Ff3LXszVkaf7jO6wXy81cipuK5MnMfpYOAf6y95Rva0kxK
         0uHQ==
X-Gm-Message-State: APjAAAV1FR+XAbVjhf/9fGxK5bVOOWnyAbmzFLiG1y2of5JO/wuTQpdV
        P+Z44U5bbrs86/G/tb5tlXm9ezfIZutkePJY8zA=
X-Google-Smtp-Source: APXvYqwx3opuxQECigno6ncCLYJMCwIU8WWgtRxviVyT0qML2ovulQpIBTNMIUufwk6EpyJ9YpuoRgUIen1BkMaP8g0=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr2139822otq.112.1575087768492;
 Fri, 29 Nov 2019 20:22:48 -0800 (PST)
MIME-Version: 1.0
References: <CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com>
In-Reply-To: <CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 29 Nov 2019 20:22:37 -0800
Message-ID: <CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com>
Subject: Re: git-rebase produces incorrect output
To:     Pavel Roskin <plroskin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 29, 2019 at 12:24 AM Pavel Roskin <plroskin@gmail.com> wrote:
>
> Hi!
>
> I've discovered an issue with "git rebase" producing a subtly
> incorrect file. In fact, that files even compiled but failed in unit
> tests! That's so scary that I'm going to stop using "git rebase" for
> now. Fortunately, "git rebase --merge" is working correctly, so I'll
> use it. Too bad there is no option to use "--merge" by default.

Indeed.  We really should fix that, if not just make it the default
for everyone.

> The issue was observed in git 2.23 and reproduced in today's next
> branch (2.24.0.449.g4c06f74957) on up-to-date Fedora 31 x86_64.
>
> I've created a repository that demonstrates the issue:
> https://github.com/proski/git-rebase-demo
>
> The branch names should be self-explanatory. "master" is the base,
> "branch1" and "branch2" contain one change each. If "branch1" is
> rebased on top of "branch2", the result is incorrect, saved in the
> "rebase-bad" branch. If "git rebase -m" is used, the result is
> correct, saved in the "merge-good" branch.
>
> The files in "rebase-bad" and "merge-good" have exactly the same lines
> but in a different order. Yet the changes on branch1 and branch2
> affect non-overlapping parts of the file. There should be no doubt how
> the merged code should look like.
>
> I believe the change on branch2 shifts the lines, so that the first
> change from branch1 is applies to a place below the intended location,
> and then git goes back to an earlier line to apply the next hunk. I
> can imagine that it would do the right thing in case of swapped blocks
> of code. Yet I have a real life example where it does a very wrong
> thing.
>
> Indeed, "git diff origin/branch2 origin/rebase-bad" and "git diff
> origin/branch2 origin/merge-good" both produce diffs of 9957 bytes
> long, different only in the order of the hunks.
>
> Another interesting data point - "git rebase --interactive" is working
> correctly.

Thanks for the detailed report and simple testcase.  Turns out the
--interactive isn't so interesting, because a few cycles back we
re-implemented the --merge behavior on top of the interactive
machinery so the two use the exact same engine.  Anyway, I can
duplicate the problem and noticed a few interesting things.  Since the
am-backend for rebase (the default) basically just uses diff and
apply, I tried duplicating with just those after looking at things and
noticing that it appeared to be applying patch hunks on the wrong
lines:

$ git switch branch2

$ git reset --hard origin/branch2
HEAD is now at 1331204 Change on branch 2
$ git diff -U3 origin/master origin/branch1 >diff.patch
$ git apply diff.patch
$ git diff --shortstat origin/merge-good
 1 file changed, 43 insertions(+), 43 deletions(-)
$ git diff --shortstat origin/rebase-bad

So, this reproduces your bad results.  Let's repeat with -U4:

$ git reset --hard origin/branch2
HEAD is now at 1331204 Change on branch 2
$ git diff -U4 origin/master origin/branch1 >diff.patch
$ git apply diff.patch
$ git diff --shortstat origin/merge-good
 1 file changed, 10 insertions(+), 10 deletions(-)
$ git diff --shortstat origin/rebase-bad
 1 file changed, 37 insertions(+), 37 deletions(-)

That gives us a result that matches neither merge-good nor rebase-bad,
but is closer to the good side.  Let's try again with -U5:

$ git reset --hard origin/branch2
HEAD is now at 1331204 Change on branch 2
$ git diff -U5 origin/master origin/branch1 >diff.patch
$ git apply diff.patch
$ git diff --shortstat origin/merge-good
$ git diff --shortstat origin/rebase-bad
 1 file changed, 43 insertions(+), 43 deletions(-)

Ahah!  With five lines of context, git diff & git apply can produce
the correct result.

Sadly, I tried to force this with git rebase, but -C5 only affected
the apply side and there's no option to pass to rebase to pass through
-U5 to the diff logic.  Also, although there is a diff.context config
option, git-am ignores it (Note that git_am_config() does not directly
check that value and it calls git_default_config(), not
git_diff_ui_config() or even git_diff_basic_config()).  So, it's not
possible to force the am-based rebase to get the right answer
currently even if you figure out what the problem is.

The merge-based rebase, by contrast, essentially benfits from having
the entire files of each version accessible so it automatically gets
it right.


So, to summarize here:
  * you have a case where the default 3 lines of context mess stuff
up; but rebase --merge works great
  * am doesn't have a -U option, and ignores the diff.context setting,
making it impossible to force the am backend to work on your case
and also:
  * rebase doesn't have an option to use the merge/interactive backend
by default (nor an --am option to override it)
Also,
  * The performance of the merge/interactive backend is slightly
better than the am-backend
(https://public-inbox.org/git/CABPp-BF=ev03WgODk6TMQmuNoatg2kiEe5DR__gJ0OTVqHSnfQ@mail.gmail.com/)
and will be getting better
  * The merge/interactive backend supports many more options than the
am-backend, though the am one still has a few the merge backend
doesn't.  Once the ra/rebase-i-more-options topic merges, --whitespace
will be the only consequential option that the am-backend supports
that the merge/interactive-backend doesn't.  (There's also -C, but as
noted above, the merge/interactive backend already have access to the
full file).

Maybe we should just switch the default, for everyone?  (And provide
an --am option to override it and a config setting to get the old
default?)
