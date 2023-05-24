Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28186C77B7A
	for <git@archiver.kernel.org>; Wed, 24 May 2023 09:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjEXJeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 05:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEXJeF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 05:34:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D7493
        for <git@vger.kernel.org>; Wed, 24 May 2023 02:34:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f7377c86aso115600866b.1
        for <git@vger.kernel.org>; Wed, 24 May 2023 02:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1684920841; x=1687512841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGaiwKOqe9qS9e0/RAHkQZfMsI+Lz5tQfWIl4OC67dA=;
        b=YDyXW6TVVGmuoXdIrb6eFPOx2WJ2RWcE1TRHohJ5c6cDigiT5Qv0IrkX1DYKGKJNwc
         pLsKMzQw041BYr1rvMVNPggbVISiGArYosBByJYmZnRHD2WmXIXDWq1hvyhN+edkCm++
         frSRmdw/g21bhpyHVYjFM3p1qmr/52oG2qWK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684920841; x=1687512841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGaiwKOqe9qS9e0/RAHkQZfMsI+Lz5tQfWIl4OC67dA=;
        b=DKb/RzC7kxRwg4qXZKZHuU1iuCf/aKwpq8V1+7DQRKLFOlXsTbtpZzwYROjBC0wIvd
         HfcnqzhEUTu9v/q/lt8jATlkl1WBaiusXpP+WLvQvOToJ+2nZavLTbnBeNSmbFjUGqWY
         lQzdanh/S64xwntxrHrSDRpTP0iWP1JgabU6a030EdnxHLcY2u93K7FmPOzT/mA64IFU
         D+Yc+1NEbGMgJfX6Eq54IOURtYgnKMnowj/VhVLCMo9L1O77nxVBUCxPijoEanmRu320
         YNM0NXrKF75mdCPcRpUft1Mt8tp5WwdBzc8S4vAFv0Zaei4J1WvM/SqW25K3CGIyZpbp
         IbAw==
X-Gm-Message-State: AC+VfDzsqggHLiOEsdFeGOf2d/dnNN2DDCwLQ0VwhYq2dJpGMjjpE5jv
        x/j54ivGUgsKEPElFrwUui5bUCTJcGYXJfURuu8mKQ==
X-Google-Smtp-Source: ACHHUZ4+tNRN2PkR/SUBiaeOLCB8zgKIGirbpF6ZnUFUlS0jyms4PT8NSJ0UiNwoTG2ewtOvVAIuG6Zbne42dde9xmY=
X-Received: by 2002:a17:907:843:b0:953:5ff7:774a with SMTP id
 ww3-20020a170907084300b009535ff7774amr15372159ejb.17.1684920841555; Wed, 24
 May 2023 02:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
 <CAPMMpojV1Ts=OKM0FbBHU6=EB5RKNxHucX-8VQmYoQBNefKpqQ@mail.gmail.com> <xmqqjzwyh9tp.fsf@gitster.g>
In-Reply-To: <xmqqjzwyh9tp.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 24 May 2023 11:33:49 +0200
Message-ID: <CAPMMpoic_+RATwS46=Bd2K4+D_5yEw9RQFGR075Bs4aQJUjtsQ@mail.gmail.com>
Subject: Re: [PATCH] cherry-pick: refuse cherry-pick sequence if index is dirty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2023 at 2:06=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > The current implementation of this patch is far too restrictive. It
> > doesn't break any tests (and maybe I should add one now that I know),
> > but it's doing the wrong thing.
>
> I am ambivalent.  What do we want to see in a multi-pick sequence
> that is different from rebase?

I would argue there are primarily three things that are different:
1. The checkout of the new base (and checkout of the original in an "--abor=
t")
2. The support for and/or more-common expectation of "messing" with
commits as you go, eg squash, edit
3. The (partial) support for rebasing/recreating merge commits

I'm not sure to what extent any of these justify having tighter
restrictions on when we allow a rebase to start, though.

> A single-step cherry-pick can fail
> safely before it touches the index or the working tree files, but if
> two-step cherry-pick, whose first step succeeds, finds that it
> cannot safely carry out its second step without clobbering the local
> changes made to the working tree files, what should happen?  Are we
> OK if we stopped in the state just after the first step has already
> been done?

This is the current behavior: it stops before the specific pick that
is going to affect local unstaged changes, or if there are *any*
staged changes (in which case it stops as it's about to do the first
pick - the first time this check runs). The reasoning for this
behavior, as I understand it, is that the "--abort" strategy,
intending to "undo whatever I started doing here, including a conflict
resolution", resets the index. So as long as there is nothing you want
to keep in the index, and as long as we know that any previous picks
haven't impacted any files with unstaged changes, we're good.

The bug that I want to fix is that we only end up checking whether
there are changes in the index *after* we've already committed to
resetting the index upon later "--abort". It's a kind of catch-22:
we've detected that aborting would destroy your work, so we leave you
in a state where the most obvious thing to do is abort, so we destroy
your work... Of course, if you understand what's going on you can
choose to "--quit" and *not* lose your work... but this is completely
antithetical to the general intent of "--abort".

There's another, smaller flaw here I think, common to Merge,
Single-Cherry-Pick, and Sequence-Cherry-Pick, which is that *if* you
start with unstaged changes, and you end up in a conflict resolution
or "--no-commit" pause, and you then "git add" your unstaged changes
during that pause/resolution, and you *then* later "--abort"... then
your originally-unstaged changes are destroyed by the "--abort" - so
it has *not* taken you back to where you were before the operation
started. This is, to me as a user, non-obvious, and could potentially
lead to data loss. The only way I see to fix that, is to have *all* of
these operations refuse to operate on dirty worktrees altogether -
like rebase already does.

I suspect this level of "strictness" would be welcome to newcomers,
and less welcome to existing experienced users.

>
> My (tentative) answer to that question is "yes", but the recovery
> options of "cherry-pick" may want to work differently from what we
> have seen them traditionally do.  Namely, the user accepts that the
> first step is already done, and stopping "cherry-pick", be it called
> "--abort" or something else, should just remove the sequencer state
> and behave as if the single-pick cherry-pick on the first step only
> has just finished and leave such a state in the index and the
> working tree.

This behavior exists, and is called "--quit", right?

The semantics as I understand it are:
--quit: I know what I'm doing, just remove any "ongoing operation"
metadata and let me work with the current index and worktree.
--abort: This was a bad idea, please take me back to where I was
before I started this operation (without losing any work I had
ongoing, pls!)

>  If that is what we are going to do, then it would
> make sense to adopt the same safety semantics we use for "git merge"
> and "git checkout" to ensure only that the index is clean, relying
> on the unpack-trees machinery that stops before clobbering a locally
> modified working tree files.

Yep

> But if we are to aim for "all-or-none"
> semantics people expect from aborting "git rebase", I suspect that
> it would be way too complicated to allow random changes in the
> working tree files that we may only discover to be problems after
> starting the sequence of replaying commits one-by-one, and "too
> restrictive" check may be justified.

I don't think I understand this argument. If we want to support both
sets of semantics, then that's exactly what "--quit" and "--abort"
achieve, right? (as long as we check for the dirty index *before*
committing to destroying the index in case of "--abort")

>  To put it differently, if it
> is too restrictive for multi-pick, then we would want to loosen it
> for "git rebase" as well, as the issues are likely to be the same.

My argument for only changing "sequence-cherry-pick" here, and having
it (continue to) use the index-safety-only semantics of
single-cherry-pick and merge, is that *this is not a change in
cabability* - it is only a bugfix. Switching to the worktree-safety
semantics of rebase would be a substantial change in behavior beyond
the bugfix.

I, personally, would prefer to see the worktree-safety semantics of
rebase be used in *all* these operations, so I could no longer shoot
myself in the foot by starting a merge, accidentally staging some
previously-unstaged changes during conflict resolution, and then
losing those changes by "--abort"ing. But I expect that this kind of
change would need to be behind a config option of some sort, trading
off safety against low friction.

I could imagine a setting like "core.OperationWorktreeSafety", with
settings "default" (current behavior - rebase disallows dirty
worktrees, the others disallow dirty index), "strict" (all behave like
current rebase) and "lax" (all behave like merge).

As discussed elsewhere, I would also like to (have an option to) treat
untracked files as "worktree dirtiness"/unstaged changes in exactly
the same way as changes to tracked files - but that's another topic :)

I'll prepare a v2 with index-safety-only for sequence-cherry-pick for
now, please let me know if a (better-named)
"core.OperationWorktreeSafety" option is something that you'd be
interested in / that would make sense to you.

Thanks!
