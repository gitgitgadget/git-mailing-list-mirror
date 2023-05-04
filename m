Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BF9C7EE21
	for <git@archiver.kernel.org>; Thu,  4 May 2023 05:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjEDFBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 01:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEDFBR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 01:01:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F251992
        for <git@vger.kernel.org>; Wed,  3 May 2023 22:01:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f3cd32799so2955266b.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 22:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1683176474; x=1685768474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpYJiiBajmMLfiFZT4wPjdyD0l1ynOKIYT0iTPjEH68=;
        b=ZKVhBs84GyOyi2OJfY+RUK/ayGdF4Stsc6JMAO5dSHdMrCbxhZ4QU1Iah73ovF1s+c
         uxTM772gGSlYltNZ6uwpj7qSnS705fvqYrW5rvoJuL3kzZ7bDC2thanZwl3KyQ87CfhD
         eyEdpK5pHLOfkLA96wLu2912YiOpB2GIKS9vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683176474; x=1685768474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpYJiiBajmMLfiFZT4wPjdyD0l1ynOKIYT0iTPjEH68=;
        b=Cibt8X5bxEff4UhJHgM9SwfBevrem0DqUPr7TZ4y7DZ8bCeUQ155/jvuGUkHXaaPJj
         zhIokCyNJkDjrerPIsc65cIGxjYCZ/BhgK8aI69eFCv0Xm06RpNMqeI+uONamfwql/9m
         NTNg2G15Aor4nEVaBC2YwX8X9F+5k1ZoU3Cc3c88N/P2z5d/w36YMTr7cs21h1CZVy0/
         TW+xA2wn9Kk8RtYLRkaIHqrckUwhlsAxxoHvNrX5GjbzoriFza07zgzKTb4pEB06ZMa3
         dP5BFAwkfQTYqSyMgHybwIE07zFyZb87pVo07pfSiC6MGW89XD3bedKFL9ZKWf/4kBD1
         BAmg==
X-Gm-Message-State: AC+VfDzFdSCiUmgMtBP1xQQLZHycZVwEjnNmOBcGaPKX0Ji8s2RlttT+
        dRRfncJtlt1SHMQwHz7BcTOpPdwlg9yXVG8DC6Q+5HDTypdS9ynBuUA87g==
X-Google-Smtp-Source: ACHHUZ5YQZ7oNfiKTUJ+F/pC9qzCrwIi53cZXM2Qa9bkMLaj8USwS5GCXTKvXUt9vAwCJmoPDC59/V1BFjHoANCLmKQ=
X-Received: by 2002:a17:907:98c:b0:953:42c0:86e7 with SMTP id
 bf12-20020a170907098c00b0095342c086e7mr5582693ejc.4.1683176473696; Wed, 03
 May 2023 22:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com> <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
In-Reply-To: <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 4 May 2023 07:01:02 +0200
Message-ID: <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
To:     Elijah Newren <newren@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2023 at 5:55=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Mon, May 1, 2023 at 11:57=E2=80=AFPM Tao Klerks via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Tao Klerks <tao@klerks.biz>
> >
> > When a "git checkout" branch-switch operation runs during a merge, the
> > in-progress merge metadata is removed. The refusal to maintain the merg=
e
> > matadata makes sense if the new commit is different to the original com=
mit,
>
> s/matadata/metadata/

Thx!

>
> > because a merge operation against a different commit could have turned =
out
> > differently / maintaining the merge relationship would be misleading. I=
t is
> > still a difficult-to-understand behavior for new users, however, as the=
y
> > would expect a switch (to a new or same-commit branch at least) to allo=
w
> > committing local changes "faithfully", as in the case of regular non-me=
rge
> > local changes.
>
> > "git switch" introduces a little more safety, by refusing to switch if =
there
>
> s/little/lot/ or s/a little//

Yep, this paragraph is straight-up wrong - safety is an entirely
separate concern from usability & meeting reasonable expectations.

>
> By the way, it was a problem that git-checkout wasn't updated to have
> the same safety that git-switch has.  We should fix that.  (It's on my
> todo list, along with adding other
> prevent-erroneous-command-while-in-middle-of-other-operation cases.)
>

This surprises me because the difference in "safety" is very
explicitly expressed and implemented in an option
"can_switch_when_in_progress", which is driven purely by "checkout vs
switch", and determines whether the validations in
die_if_some_operation_in_progress() apply - dying on merge, am, rebase
cherry-pick, or revert.

If we are comfortable changing the behavior of branch checkout to be
safe-and-limiting like switch, then that should be almost as simple as
removing that condition. The wrinkle is that I believe "--force"
should still be allowed at least in the cases where it is safe
(whereas currently switch does *not* allow even --force if a merge is
in progress, and this proposed patch accidentally "fixed" that for the
same-commit case only).

> > is a merge in progress - or a number of other operations such as rebase=
,
> > cherry-pick, or "git am". This is less of a nasty surprise than the mer=
ge
> > metadata/state being silently discarded, but is still not very helpful,=
 when
> > a user has a complex merge resolved, and wishes to commit it to a new b=
ranch
> > for testing.
>
> I'm worried this is likely to lead us into confusing UI mismatches,
> and makes it harder to understand the appropriate rules of what can
> and cannot be done.  A very simple "no switching branches in the
> middle of operations" is a very simple rule, and saves users from lots
> of headaches.

I'm not convinced a simple rule that prevents a natural majority-case
workflow is better than a complex rule that allows one majority-case
workflow while prohibiting others.

My claim, which I understand is quite tenuous, is that the situation
where you find yourself legitimately thinking "wow, I just did a lot
of work, but I'm not sure it's *right*. I should test it on a new
branch *before* committing to this branch" is significantly more
likely to arise with "git merge", where what you are merging in is
often others' work, in a single step, than with those other commands.

(ignoring rebase, which may be as common, but is a completely
different workflow, where "let me save it on a new branch before I
share with others" doesn't make as much sense; in most workflows you
don't rebase shared branches)

It makes sense to say that prohibiting something that will hurt you
saves you a headache, but I think we agree that changing to a
same-commit branch during a resolved-index merge as enabled here *does
not* hurt you. And the only reasonable alternative (committing the the
original branch, *then* creating a new testing branch, and resetting
the original branch) is very non-obvious.

>
> Granted, expert users may understand that with the commit being the
> same, there is no issue.  But expert users can use `git update-ref` to
> tweak HEAD, or edit .git/HEAD directly, and accept the consequences.
> Why do we need to confuse the UI for the sake of expert users who
> already have an escape hatch?

Expert users are not the targeted audience of these changes. Users
used to the natural git pattern of "I have some local uncommitted
changes, I'm not quite sure about them, so let me create a new branch
and commit them there, so I can validate them properly, and then I'll
bring them to the original branch" are.

>
> More importantly, though...
>
> > Change the behavior of "git switch" and "git checkout" to no longer del=
ete
> > merge metadata, nor prohibit the switch, if a merge is in progress and =
the
> > commit being switched to is the same commit the HEAD was previously set=
 to.
>
> Even if there are conflicts?  For rebases, cherry-picks, ams, and
> reverts too?  (Does allowing this during rebases and whatnot mean that
> --abort becomes really funny?  Does it mean that some commits are
> applied to one branch, and all commits are applied to another?  What
> about autostashes?  Does it interact weirdly with --update-refs?
> etc.)

I believe this question was resolved later in the thread. The proposal
is to allow the simplest case of merge only, for resolved
(unconflicted) indexes only. If the change were to make sense I could
update this message to be clearer that none of those other operations
or situations are impacted by this change.

>
> I think this change is premature unless it discusses all these cases,
> because UI backward-compatibility requirements means we can't rip this
> out later if we add it, and any change here is going to lead to
> questions about either inconsistencies in the UI for other operations
> (why can't I also switch branches if there are conflicts?  why can't I
> also switch branches to a same-commit branch during a rebase?) or
> crazy problems we've introduced (`git rebase --abort` only aborted
> changes to one of the branches I modified??  Which of the three
> branches -- the one I started on, the one I was rebasing, or the one I
> switched to in the middle -- is my autostash now found on??) by
> opening this can of worms.
>

My argument is that making things a little better is better than not
making them better at all (although yes, of course, ideally we would
also cover those other cases long-term, if they make logical sense). I
understand that's easy for me to say of course, as the dilletante who
pops in to make a tiny change and leaves the team on the hook to
resolve the edge-cases / address broader consistency in the long term.

> My first gut guess is that switching with conflicts would be just as
> safe as this is, and any users who likes your change is going to
> complain if we don't allow it during conflicts.

In principle I believe so too, I just haven't checked whether the
tree-merge process attempts to do anything for a same-commit switch,
and if it does, whether the presence of conflict data "bothers" it in
any way / causes it to do the wrong thing, eg remove it.

If verifying this and opening up the "pending conflicts" case meets
the consistency itch, I'm happy to explore this area and (try to)
expand the scope of the fix/exemption.

> But I think it'd take
> a fair amount of work to figure out if it's safe during
> rebase/cherry-pick/am/revert (is it only okay on the very first patch
> of a series?  And only if non-interactive?  And only without
> --autostash and --update-refs?  etc.), and whether the ending set of
> rules feels horribly inconsistent or feels fine to support.

I agree this gets complicated - I haven't thought or explored through
most of these, but I have confirmed that switching branch in the
middle of a *rebase* is very confusing: your rebase continues on the
new HEAD, as you continue to commit, your rebased commits get
committed to the branch you switched to, but at the end when you
*complete* the rebase, the original ref you were rebasing still ends
up being pointed to the new HEAD - so you end up with *both* the
branch you were rebasing, and the branch you switched to along the
way, pointing to the same head commit.

I understand how that works in terms of git's internal logic, but as a
user of rebase, if I tried to switch (to a new branch) in the middle,
I would be intending to say "I got scared of the changes I'm making
here, I want the that is ref pointed to the new commit graph at the
end of the process to be this new ref, instead of the ref I originally
started on".

Supporting that usecase, for rebase, sounds to me like it should be
done by something completely different to "git switch". The most
helpful behavior I can think of here would be that a "git switch"
attempt would say "cannot switch branch in the middle of a rebase. to
continue your rebase and create a new branch, use 'git rebase
--make-new-branch NEWBRANCHNAME" instead of 'git switch'"

>
> > Also add a warning when the merge metadata is deleted (in case of a
> > "git checkout" to another commit) to let the user know the merge state
> > was lost, and that "git switch" would prevent this.
>
> If we're touching this area, we should employ the right fix rather
> than a half measure.  As I mentioned above, this should be an error
> with the operation prevented -- just like switch behaves.
>

My understanding, given the code organization, was that we wanted to
preserve current (funky) behavior for backwards-compatibility
purposes. If we're comfortable changing behavior here, I am happy to
change the patch (while keeping/allowing the --force exemption, which
*should* still destroy the merge state).

> > Also add a warning when the merge metadata is preserved (same commit),
> > to let the user know the commit message prepared for the merge may stil=
l
> > refer to the previous branch.
>
> So, it's not entirely safe even when the commit of the target branch
> matches HEAD?  Is that perhaps reason to just leave this for expert
> users to use the update-refs workaround?
>

It is *safe*, it's just that one aspect of the outcome is *potentially
confusing*. You really did do the merge on the original branch. The
merge message is the same as it would be if you committed, created a
new branch, and reset the original branch.

(and just to note - the reasonable workaround is to commit the merge
on the current "wrong" branch, create the other branch, and then reset
the original branch, as Chris Torek shows on StackOverflow; not to
teach people all about update-refs)


Thanks so much for taking the time to go through all this!

Please let me know whether you would be comfortable with a patch that:
* Fixed checkout to be more restrictive (except still allowing --force
at least on a merging state)
* More explicitly noted that we are relaxing things for merge only,
none of the other in-progress states that currently prevent switch
* Also worked with outstanding conflicts in the index (verifying that
this is safe)

Thanks,
Tao
