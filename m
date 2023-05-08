Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706F0C7EE2C
	for <git@archiver.kernel.org>; Mon,  8 May 2023 10:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjEHKp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 06:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjEHKpe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 06:45:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE56E2A9EE
        for <git@vger.kernel.org>; Mon,  8 May 2023 03:44:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso8489826a12.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1683542696; x=1686134696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me/NW831JyBtJwU3JI8btqe65Pq5HYOFl0PcDEVnodo=;
        b=XpHm9ICIW0nC+5z1hgArys6KJAIXeqwJOyR7sqpmZfCVXWAT6whII+j8qeawAOUNsr
         2qtWl4BFXpt8lvJ4flw3i2ziBo3Ma/1HWFPRK4SD69p7L3I/e6YgQAPRwkFEvZsOd076
         G5MSftDgYOBssUJoV04QWjQdka0d1X+5uTxPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683542696; x=1686134696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=me/NW831JyBtJwU3JI8btqe65Pq5HYOFl0PcDEVnodo=;
        b=A3g+HSbkERnajKGf66Z9laWR+Z+2/UnmWogV4wySGL28EC8ZTjMwKCmQ7CK6U2j2NK
         rUjVrMx805C0kvJLdTLVElXC0hNA573BqB6OhrLUA6XxuMr+hdb+vAfoakjtFCeWABQ0
         VTeNpHdq/LYrw7B2j7Z/rpacaaoSEsdUiLcifF4kZYnjyfed4066qAbo4AORETXG+De1
         nSwnt7mVgDEDJa+SOLRQZvztjAMIEeEU8DIO73lgGHbLxyfN/w9CiwDupGtbZfovZb5X
         QicK4GAABxopEi0gO512Acdh/jBTKzr5Z6DiowIAB6WIA71aXPN9mQ/EiZR2JEmiLW41
         CEQg==
X-Gm-Message-State: AC+VfDxfrrgpC/lRnqufCMC8Ix8Fr11guQKrjxXlLqiioW7s6rcNEXYN
        iJpPrVdAUQC2q4IxILSCexmph1MxaOUrBOKu194Gm+4pzrw96iUxv8M=
X-Google-Smtp-Source: ACHHUZ7GIgeCIxnUb8aAsXZgXZC3LsEGFbRofQUUPhldHbGo0IJXUd4Wn0LobobG3IOrIGcj24Rp2t7H+agTHz02ci8=
X-Received: by 2002:a17:906:730c:b0:969:19ca:b856 with SMTP id
 di12-20020a170906730c00b0096919cab856mr840607ejc.54.1683542696170; Mon, 08
 May 2023 03:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
 <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com> <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com>
In-Reply-To: <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 8 May 2023 12:44:45 +0200
Message-ID: <CAPMMpojDm8jHWFr8i5EC-oEKK8WBt1g3iyRvixfy1bhk8qck2g@mail.gmail.com>
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

On Sun, May 7, 2023 at 4:48=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Wed, May 3, 2023 at 10:01=E2=80=AFPM Tao Klerks <tao@klerks.biz> wrote=
:
> >
> > I believe this question was resolved later in the thread. The proposal
> > is to allow the simplest case of merge only, for resolved
> > (unconflicted) indexes only. If the change were to make sense I could
> > update this message to be clearer that none of those other operations
> > or situations are impacted by this change.
>
> As I mentioned to Junio, I understood fully that your implementation
> limited the changes to this one case.  That did not resolve my
> concerns, it merely obviated some other bigger ones that I didn't
> raise.
>
> However, making it only available via a --force override (and then
> perhaps also limiting it to just some operations), would resolve my
> concerns.
>

Hmm, I think there is confusion here.

My proposal was (and now, again, is) to add support for "--force" to
"git switch", and to keep and improve that existing support for "git
checkout" (where it is in my opinion broken during a rebase), but that
proposal was mostly-unrelated to my main goal and proposal for
supporting same-commit switches in the first place:

A same-commit switch (*without* --force) serves the use-case of
*completing a merge on another branch*. This is, as far as I can tell
only *useful* for merges:
 * during a rebase, switching in the middle (to the same commit,
without --force) won't achieve anything useful; your rebase is still
in progress, any previously rebased commits in the sequence are lost,
and if you continue the rebase you'll end up with a very strange and
likely-surprising partial rebase state)
 * during a cherry-pick, it's just "not very useful" - it's not bad
like rebase, because in-progress cherry-pick metadata is destroyed
 * during am, and bisect I'm not sure, I haven't tested yet.

The reason this in-progress is *valuable* for merges (in a way that it
is not for those other states) is that the merge metadata not only
says what you're in the middle of, but also contains additional useful
information about what you've done so far, which you want to have be a
part of what you commit in the end - the identity of the commit you
were merging in.

Supporting switch with --force, and having it implicitly destroy
in-progress operation metadata, has value in that it makes it easier
to break backwards compatibility of "git checkout" without impacting
users' or tests' workflows; it helps make a change to make checkout
safer; but it does not help with my other (/main?) objective of making
it easy and intuitive to switch to another same-commit branch, to be
able to commit your in-progress merge on another branch and avoid
committing it where you started.

Hence, if/when we add support for same-commit switching during merge
(and potentially other operations, if that makes sense), it should
*not* take "--force", which has a substantially different purpose and
meaning.

> > > My first gut guess is that switching with conflicts would be just as
> > > safe as this is, and any users who likes your change is going to
> > > complain if we don't allow it during conflicts.
> >
> > In principle I believe so too, I just haven't checked whether the
> > tree-merge process attempts to do anything for a same-commit switch,
> > and if it does, whether the presence of conflict data "bothers" it in
> > any way / causes it to do the wrong thing, eg remove it.
> >
> > If verifying this and opening up the "pending conflicts" case meets
> > the consistency itch, I'm happy to explore this area and (try to)
> > expand the scope of the fix/exemption.
>
> If this behavior is behind a `--force` flag rather than the default
> behavior, then I think there's much more leniency for a partial
> solution.

But if it were behind "--force", it wouldn't work :)

>
> That said, I do still think it'd be nice to handle this case for
> consistency, so if you're willing to take a look, that'd be great.  If
> you are interested, here's a pointer: Stolee's commit 313677627a8
> ("checkout: add simple check for 'git checkout -b'", 2019-08-29) might
> be of interest here.  Essentially, when switching to a same-commit
> branch, you can short-circuit most of the work and basically just
> update HEAD.  (In his case, he was creating _and_ switching to a
> branch, and he was essentially just trying to short-circuit the
> reading and writing of the index since he knew there would be no
> changes, but the same basic logic almost certainly applies to this
> broader case -- no index changes are needed, so the existence of
> conflicts shouldn't matter.)

Will look, thx

>
> If you don't want to handle that case, though, you should probably
> think about what kind of message to give the user if they try to
> `--force` the checkout and they have conflicts.  They'd probably
> deserve a longer explanation due to the inconsistency.
>

--force implicitly and intentionally discards the conflicts.

> > > But I think it'd take
> > > a fair amount of work to figure out if it's safe during
> > > rebase/cherry-pick/am/revert (is it only okay on the very first patch
> > > of a series?  And only if non-interactive?  And only without
> > > --autostash and --update-refs?  etc.), and whether the ending set of
> > > rules feels horribly inconsistent or feels fine to support.
> >
> > I agree this gets complicated - I haven't thought or explored through
> > most of these, but I have confirmed that switching branch in the
> > middle of a *rebase* is very confusing: your rebase continues on the
> > new HEAD, as you continue to commit, your rebased commits get
> > committed to the branch you switched to, but at the end when you
> > *complete* the rebase, the original ref you were rebasing still ends
> > up being pointed to the new HEAD - so you end up with *both* the
> > branch you were rebasing, and the branch you switched to along the
> > way, pointing to the same head commit.
> >
> > I understand how that works in terms of git's internal logic, but as a
> > user of rebase, if I tried to switch (to a new branch) in the middle,
> > I would be intending to say "I got scared of the changes I'm making
> > here, I want the that is ref pointed to the new commit graph at the
> > end of the process to be this new ref, instead of the ref I originally
> > started on".
> >
> > Supporting that usecase, for rebase, sounds to me like it should be
> > done by something completely different to "git switch". The most
> > helpful behavior I can think of here would be that a "git switch"
> > attempt would say "cannot switch branch in the middle of a rebase. to
> > continue your rebase and create a new branch, use 'git rebase
> > --make-new-branch NEWBRANCHNAME" instead of 'git switch'"
>
> That all sounds reasonable.
>
> But you know someone is going to try it anyway during a
> rebase/cherry-pick/revert.  If we start letting `--force` override
> during a merge, we should do something to address that inconsistency
> for users.  It doesn't need to be something big; we could likely
> address it by just specifically checking for the `--force` case during
> a rebase/cherry-pick/revert and providing an even more detailed error
> message in that case that spells out why the operation cannot be
> `--force`d.

The behavior of "--force" is already clear - it resets your worktree
to the state of the branch you are switching to. It also (or should
but doesn't, in the case of rebase) destroys in-progress operation
state/metadata.

That said, I understand and agree that there should be a difference
between a generic error "there is an operation in progress, you need
to '--abort'" for the operation types that can and should not benefit
from a same-commit exception, and the operation(s) that do get a
same-commit exception when it doesn't apply (when you're trying to
switch commit). If the same-commit does end up behind some parameter,
there should be yet another message for a same-commit branch switch
operation when the new needed parameter is not specified.

>
> > > > Also add a warning when the merge metadata is deleted (in case of a
> > > > "git checkout" to another commit) to let the user know the merge st=
ate
> > > > was lost, and that "git switch" would prevent this.
> > >
> > > If we're touching this area, we should employ the right fix rather
> > > than a half measure.  As I mentioned above, this should be an error
> > > with the operation prevented -- just like switch behaves.
> > >
> >
> > My understanding, given the code organization, was that we wanted to
> > preserve current (funky) behavior for backwards-compatibility
> > purposes.
>
> I totally understand how you'd reach that conclusion.  I would
> probably come to the same one reading the code for the first time.
> But, as it turns out, that's not how things happened.
>
> > If we're comfortable changing behavior here, I am happy to
> > change the patch (while keeping/allowing the --force exemption, which
> > *should* still destroy the merge state).
>
> Yaay!

As suggested in my recent response to Felipe, I will create a separate
patch (series) for the git checkout safety enhancements and related
--force support enhancements.

>
> > > > Also add a warning when the merge metadata is preserved (same commi=
t),
> > > > to let the user know the commit message prepared for the merge may =
still
> > > > refer to the previous branch.
> > >
> > > So, it's not entirely safe even when the commit of the target branch
> > > matches HEAD?  Is that perhaps reason to just leave this for expert
> > > users to use the update-refs workaround?
> > >
> >
> > It is *safe*, it's just that one aspect of the outcome is *potentially
> > confusing*. You really did do the merge on the original branch. The
> > merge message is the same as it would be if you committed, created a
> > new branch, and reset the original branch.
> >
> > (and just to note - the reasonable workaround is to commit the merge
> > on the current "wrong" branch, create the other branch, and then reset
> > the original branch, as Chris Torek shows on StackOverflow; not to
> > teach people all about update-refs)
> >
> >
> > Thanks so much for taking the time to go through all this!
> >
> > Please let me know whether you would be comfortable with a patch that:
> > * Fixed checkout to be more restrictive
>
> Absolutely.
>
> > (except still allowing --force at least on a merging state)
>
> That's fine too.
>
> > * More explicitly noted that we are relaxing things for merge only,
> > none of the other in-progress states that currently prevent switch
>
> That wouldn't resolve any of my concerns; it was totally clear to me
> the first time.
>
> > * Also worked with outstanding conflicts in the index (verifying that
> > this is safe)
>
> In combination with `--force`, I think that would be very nice.

I need this to work without --force, for the reasons noted above, *but
I will split this into two patch series to avoid further confusion!*

Thanks so much for your help!
