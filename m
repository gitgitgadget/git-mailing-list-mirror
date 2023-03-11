Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF941C678D5
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 03:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCKD1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 22:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCKD1J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 22:27:09 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A56128003
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 19:27:07 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536c02eea4dso135251617b3.4
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 19:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678505226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYsImI8uDBa8u4cdQI0LW3ZiAlNrWEAjNIAXQKyhKvk=;
        b=L7S52vHCSh+XN0J3/VBeqI2h3HqHtv3wm8PxDgw17Fn0QGR22uUlvm9aYPlp2ALk86
         /lGIrIYKW672JUGPa0UnryUt2L6UgMjcoA0AU2hKVhqFmp0gn0cZ7p3+M5EWMrgsI4qM
         UF4TGxtmf+RRCFNoBLCfMINUJxZXD5Zxzud5lI232nhxLen7NqCtTwrOBQQ0zebuXCTz
         fnCRSJbxK8EQLbK1rV+UEzfn0guly+m+fkaHdXZMMjk9AYIBQHw4mVp5C6yXr29uZ635
         qjmdhXgNhnXDVLE0BJeDZBNlsetNVtFJbXoDoYzJVqY4KgmEiv2e7GMQKbbyPjowiAvG
         U2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678505226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYsImI8uDBa8u4cdQI0LW3ZiAlNrWEAjNIAXQKyhKvk=;
        b=uEHuLlXr0SQSv47SD93G2ZZMFCBHIxAfOq4h1rx6aikk3e+awxFTfTI/ykgzngtEVM
         QTeaNfyC/G5UPwhwgdr1iRLEmoPA0ZFLpY4uMRNQCbZswCv3+u0C3s1rRMhJHdk5B53a
         NHurRG3qAtQHhgX963EjtOCA3DmnFzl0YLgK62zvilY9Q3me6Zi75BD6GoF24MuHR5t7
         PYR4YwguLsoYDSekVvVJJwESEtjBGzPr15IqyYoSoaoGAynQaiTXYBTGrsRPTg++7X1y
         4yAQMxu7SzqCpJcGZJSpSrwHrBmtNCqpLhmcTEgAOEiovUq9n3qLH3/io27/4CG6Clxq
         uA6w==
X-Gm-Message-State: AO0yUKV4FzX21zqpUmWOsZO9xiXKStoNxvATWla+X4KFycrSwltQ7Qv9
        GGubHaRLfiWZsjEry2U3e1AqeU4dpZkaxCYZ/5LBXRZO+H4=
X-Google-Smtp-Source: AK7set8gZQs7Xs9r7G24gGevIR0Lig6LqoSozkl5FwFejMfXltpozf23jDl2ajObnDeHP9QweTerkLHMJ/CNFNBSRR0=
X-Received: by 2002:a81:b288:0:b0:52e:ee55:a81e with SMTP id
 q130-20020a81b288000000b0052eee55a81emr17762285ywh.7.1678505226364; Fri, 10
 Mar 2023 19:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20230310214515.39154-1-felipe.contreras@gmail.com> <xmqq7cvoywzx.fsf@gitster.g>
In-Reply-To: <xmqq7cvoywzx.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 10 Mar 2023 21:26:54 -0600
Message-ID: <CAMP44s0CBum1JZyP57NinikWSXg9KuGBKDAoozmnen1akvGMDA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Support for tail (branch point) experiment
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 6:04=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > This is *not* meant a serious proposal, it's just an exploration of an
> > idea.
>
> It is easy to explain and understand the benefit of keeping a
> separate pointer to the bottom [*] of the branch on top of which the
> history leading to the commit at the tip of the branch has been
> built, but the devil is in the details of how such a bottom pointer
> will be maintained.
>
>     side note: below, I use "bottom" because for me it is the most
>     natural term to refer to the starting end of the range of
>     commits.  In the context of this topic, readers can replace any
>     "bottom" they see with "tail", if they prefer.

Perhaps @{base} would be better (I think that was my original name).
Mercurial has an experimental feature called "topics", and that's the
name they use for the starting point of a topic.

> In a sense, this is very similar to the idea of "notes".  It is easy
> to explain and understand that a bag of objects, in which additional
> data can be associated with an object name, can be used to keep
> track of extra data on commits (and other objects) after they are
> created without invalidating their object name.  As long as they are
> copied/moved when a commit is used to create another copy of it.
> The "notes" are automatically copied across "rebasing", which is one
> of the many details that makes the "notes" usable, but cherry-pick
> that does not honor notes.rewriteRef sometimes leads to frustration.

I implemented that in 2014 [1].

There's no actual reason for that to not work in 2023 if we wanted.

But this is an argument in favor of @{base} (or whatever): even if
notes are not perfect, they still can be useful in certain situations,
and it's certainly better than not having that information. Similarly,
@{base} doesn't have to be perfect in the first iteration, the natural
points in which it's updated can be implemented later, by just
existing it would provide some potentially useful information to the
user, which is better than nothing.

> Creation of a new branch with "git branch" would be an obvious point
> to add such a bottom pointer, and "git rebase" is a good point to
> update such a bottom pointer.  But there are many other ways that
> people update their branches, depending on the workflow, and
> guessing when to update the bottom pointer and trying to be complete
> with the heuristics will lead to the same "no, we do not know all
> users' workflows" that made approaches based on reflog parsing
> etc. fail to solve the "where did the branch start?" puzzle.
>
> And I think what is sketched in these RFC patches can be a good
> starting point for a solution that strikes a good balance.  "git
> rebase", which is the most common way to mangle branches, is taught
> to update the bottom pointer automatically.
>
> Giving users an explicit way to set the bottom when manipulating
> branches would help those who mangle their branches with something
> other than "git rebase" in the most trivial form.  I suspect that is
> still missing in this RFC?

Yes, we would want a way to update the base manually, just like with
@{upstream}.

> Of course other things on the consuming side may be missing, like
> send-email or format-patch, but they are a lot more trivial to add and
> will be useful.  As long as the bottom pointer is properly maintained,
> that is.

Yes, but that can be done later. If @{base} is useful and updated in a
good enough manner, users are obviously going to want it used in tools
like `git send-email`, but even before that, just being able to do
`@{base}..` is useful (even if manually).

> A few of the things that I often do to mangle my branches are
> listed.  Some of them are not application of "git rebase" in the
> trivial form:
>
>  * I have a patch series (single strand of pearls).  I update on
>    top of the updated upstream:
>
>     $ git rebase -i --onto master @{bottom}
>     $ git range-diff @{bottom}@{1}..@{1} @{bottom}..HEAD
>
>    No, this is not what "I often do" yet, but I hope to see become
>    doable.  Rebase the current branch from its bottom on top of the
>    master, and then take the range diff between the old branch
>    (i.e. @{bottom} refers to the bottom pointer, but because it is
>    implemented as a ref, its reflog knows what the previous value of
>    it was---@{bottom}@{1}..@{1} would be the range of commits on the
>    branch before I did the above rebase) and the new one.

That would work only if the last update was a rebase. To make it work
reliably we would need some sort of branchlog.

Personally I have a similar use case, but I want to use range-diff
mainly before sending a patch series. What my tool `git send-series`
does is store for example `refs/sent/test-aggregate/v2` and
`refs/sent/test-aggregate/v2-tail`. Conceptually this is v2 of the
patch series.

>  * I have 7 patch series (single strand of pearls).  I only need to
>    touch the top 3.
>
>     $ git rebase -i HEAD~3
>     $ git range-diff @{1}...
>
>    In this case, I am not updating the bottom to HEAD~3 and reducing
>    the branch into 3-patch series.  I am keeping the bottom of the
>    branch, and the commits that happen to be updated are only the
>    topmost 3.

Right, maybe the base should be updated only when --onto is supplied,
or perhaps even a new --base option so it's clear the user wants the
new behavior.

>  * In the same situation, but the top 3 in the original are so bad
>    that I am better off redoing them from scratch, taking advantage
>    of new features in 'master'.
>
>     $ git checkout --detach master
>     ... work on detached HEAD ...
>     ... first pick the bottom commits ...
>     $ git cherry-pick master..@{-1}~3
>     ... still working on detached HEAD ...
>     ... redo the topmost commits from scratch ...
>     $ git range-diff master..@{-1} master..
>     $ git checkout -B @{-1}
>
>    I do not mind "checkout -B" *not* learning any trick to
>    automatically update the bottom pointer for the branch to
>    'master' in this case, but I should be able to manually update
>    the bottom of the branch easily.  Something like "git checkout -B
>    @{-1} --set-bottom=3Dmaster" might be acceptable here.

Yes, something like that would be needed.

One obvious use case for me is "show me the current branch", as in
`git log @{base}..@`. Because `git log` is very efficient that's
usually not necessary, but I often launch `gitk`, and it's annoying
that it tried to load *all* the commits reachable, wasting resources
and polluting the view, which is why I started developing a tool that
essentially did `gitk $1@{u}..$1`, but that quickly becomes complex if
upstream isn't configured. With my tool I can do `git vs` (show the
current branch visually), or `git ls` (show the current branch on the
command line).

Weirdly enough, Mercurial's new topic extension has a command that
shows precisely that `hg stack` shows only the commits on the current
topic (starting from a base).

And this reminds me of the previous discussion: What actually is a branch? =
[2]

If we can agree that `branch@{base}..branch` semantically is
*something* (whatever you want to call it), then it might make sense
to have a way to refer to it, for example `branch^b` or `branch+`.

Then interesting combinations immediately become obvious, for example your:

    git range-diff @{bottom}@{1}..@{1} @@{bottom}..@

Becomes:

    git range-diff @{1}+ @+

Then if we expand that we can see that @{base} should be an operation
on @{1} (@{1}@{base}), not the other way around.

> IOW, I do not mind if maintenance of the bottom of the branch is not
> always automatic (and prone to heuristic making an incorrect guess).
> But I think we should make sure it is easy for the user to assist
> the tool to maintain it correctly [*].
>
>     Side note: and that is what I find "frustrating" in the "notes"
>     world.  "notes" can be copied after cherry-pick manually, but
>     that is a very tedious process, and at some point, being "merely
>     possible" stops to have much value, unless it is "easily
>     doable".

Agreed. Similarly, I did not start to use @{upstream} until it was easy to =
use.

But again: @{upstream} was not easy to use at the start, and @{base}
doesn't have to be either.

I think the important thing to not forget is that this is useful
information, and many would argue git is missing it.

Cheers.

[1] https://lore.kernel.org/git/1398307491-21314-13-git-send-email-felipe.c=
ontreras@gmail.com/
[2] https://lore.kernel.org/git/60e61bbd7a37d_3030aa2081a@natae.notmuch/

--=20
Felipe Contreras
