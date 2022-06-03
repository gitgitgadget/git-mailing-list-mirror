Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E229C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 07:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiFCHqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 03:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiFCHqh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 03:46:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312FF3703C
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 00:46:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c2so9083531edf.5
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhG56XCeGENnt8trduMFEVmk/zFp1vdmOUu+Fx8VhQ4=;
        b=Hl8BxgdGfmJL17FRSk7s9esiQlGM4Qdi3nZe7qMR6c2IqC0tgJ2VAQUfr+7PLYW+CJ
         2S6BKMgkdXgWqEVHWJq8Q40f7KlviqZ8kT7M9XMtfv8nqrst08UCXU8IuKWczHMQ09J2
         YX4/KptICbEoWwZOxsHiCS5uKRuKoJbaoKyuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhG56XCeGENnt8trduMFEVmk/zFp1vdmOUu+Fx8VhQ4=;
        b=c0iqszGdaUqrXuaVRE9M1zadyq6fVS/r9RGnyF4ULPgYQYB5UtMKVW2kww8N9n7Bgk
         6LOdrfXm6XQiIkssD1p2WH8lm6Mb3v3a+TIH4mW9q69ew1CmUivJEPBNYD1p3lekp4bR
         hn0IwYcPuwQodbkD8p0gtiKuDKc4TFvDIWVXTXe+ixh3NPXAJTPc3mfNVhBKJ5wGNGd4
         Axu59BU+/1iZtTloKoMk2R3EoAHaexbjMl/TbvOTQcPXxEQc4QTbR4g7xasYqC7vPwa2
         gJJYkk3V+DC+p9Sfh6hsnrhT3h5dWGLasMFkcWvD1aFrnqJqfl6RZUKCrTh35YQuSrv/
         DiQg==
X-Gm-Message-State: AOAM532ck593g8dBgFViRlu8mBGU/yTuF4HKVd4F5w70J9n1ru/G9Eyj
        SEFtuKDiSCHH4Bl+ZXz9Dn2WCVpz9EZnAAvRKoqsDyxTiC8YdA==
X-Google-Smtp-Source: ABdhPJwXOkeeqUzm3N2ZjEiU6UfiHP929EziBxevm3DqQSYTdE85Mr/x7lH6vosDvkwWkf6ZrOMPa6e3/Fd8kwXbTf8=
X-Received: by 2002:a05:6402:1857:b0:42d:bcd6:3a88 with SMTP id
 v23-20020a056402185700b0042dbcd63a88mr9417904edy.6.1654242394603; Fri, 03 Jun
 2022 00:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoj8CyhB=g0=HD2Y2w6+mkGVRsgoq6zsb5XCTt95uDELog@mail.gmail.com>
 <CABPp-BF4kD8uieZ1QWLbzejhuhaZA7rYfDR+8dGrteL_4UhkHQ@mail.gmail.com>
In-Reply-To: <CABPp-BF4kD8uieZ1QWLbzejhuhaZA7rYfDR+8dGrteL_4UhkHQ@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 3 Jun 2022 09:46:23 +0200
Message-ID: <CAPMMpoiKR1LRYO4zpJb09n3-pUzcZfpWCm_trRq=ZhTawN7aEw@mail.gmail.com>
Subject: Re: Cherry-Pick without affecting working tree / index?
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 3, 2022 at 1:52 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Jun 2, 2022 at 10:08 AM Tao Klerks <tao@klerks.biz> wrote:
> >
<snip>
> >
> > It *seems* as though I could enact something functionally equivalent
> > to a cherry-pick by first creating a (temporary) "--ours" merge commit
> > on the target branch, pretending to have merged the parent commit of
> > the cherry-pickable one, and then merging the cherry-pick commit
> > itself on top of that. The resulting tree could be used as the basis
> > for a final commit on top of the original tip of the target branch, if
> > that merge were clean, and otherwise fail saying "there are conflicts,
> > go do things properly in a working tree pls".
> >
> > I'm not sure whether this is the right way to conceive of
> > cherry-picking, however, or whether it makes more sense to conceive of
> > it as a single-commit rebase.
>
> The merge --ours stuff is going down a weird path that I don't
> recommend, but thinking of it as a single-commit rebase is good.  In
> fact, the default rebase backend was originally written by calling
> cherry-pick for each commit in question.
>

Thanks so much for your fast feedback!

When you say "The merge --ours stuff is going down a weird path that I
don't recommend", I would love to understand better what you mean.

My testing so far is basic at best, and I had a typo (I meant "git
merge -s ours" rather than "git merge --ours"), but in principle what
I described does seem to *work* in most cases?

For example, imagine I want to cherry-pick Johannes Schindelin's
commit b44855743b1674caf3bd4f42814473771b129c48 onto current master in
Junio's repo - I can do it the simple way:

git checkout origin/master
git cherry-pick b44855743b1674caf3bd4f42814473771b129c48

Or I can do it the "the only tool I have available is merge, so I need
to play with the merge base" way:

git checkout origin/master
TARGET_COMMIT=b44855743b1674caf3bd4f42814473771b129c48
git merge $TARGET_COMMIT~1 -s ours -m whatever
git merge $TARGET_COMMIT -m whateverelse
git log --format=%B -1 $TARGET_COMMIT | \
GIT_AUTHOR_NAME="$(git log --format=%an -1 $TARGET_COMMIT)" \
GIT_AUTHOR_EMAIL="$(git log --format=%ae -1 $TARGET_COMMIT)" \
GIT_AUTHOR_DATE="$(git log --format=%at -1 $TARGET_COMMIT)" \
git commit-tree -p origin/master `git rev-parse HEAD^{tree}`
#and do something with the resulting commit, eg branch -f

One limitation here is that it doesn't work to "cherry-pick" commits
that are already in the history of the target branch (which could be
solved with a temporary shallow graft? :D ). Maybe more important is
that it's a crazy-convoluted way of doing things...

Is there something "theoretically" wrong with this way of thinking
about it, or is your concern more that this is like using a stick of
dynamite to kill a fly? (likely effective, but not recommended?)

Please note, having read the thread below, I understand you have some
hard-won experience around the use of scripting approaches for the
implementation of actual git commands - I never stated this explicitly
above, but I'm asking partially as an intellectual exercise, partially
wrt something I might implement in custom tooling for specific
workflows in a specific context. At no point am I suggesting the above
would be the right way for an official (new?) git command to do its
work.

> > Is there a relationship between
> > git-merge-tree and rebases?
>
> The patches I submitted do not have the ability for rebases to be
> built from git-merge-tree.  There's a debate over whether my series
> should be tweaked to enable it.  Peruse the thread over at
> https://lore.kernel.org/git/xmqqh78nj0q0.fsf@gitster.g/ if you want to
> read some of the discussion, as well as see discussion of how merging
> and cherry-picks/rebases are related.
>

Thanks very much! I guess it's a little late to chime in on that
thread, but for what it's worth, I agree with Junio that it would be
ideal if "merge-tree" were able to do that "gimme (arbitrary) trees
and I'll merge'em" operation - not that I would expect any official
git commands to invoke this recursively (I understand the concerns
over poor design / unnecessary complexity driven by a scripting
approach), but that would be a powerful tool for people who want to
script their own crazy use cases - eg a less-bad version of what I
outlined above, without the need for the "git merge -s ours" commit
establishing the desired merge base.

That said, I get lost in the discussion of what the right set of
commands / distribution of responsibility should be; given the *name*,
I would expect "gimme three trees and I'll give you a fourth with
conflict data" to be an operation that fits in that existing command,
and I would expect "do a server-side merge or a server-side rebase
through to a new (set of) merge or rebased commit(s)" to be separate
(new?) commands.

> > Is there an aspiration to develop "server
> > side rebase" also at some stage?
>
> Yes, already in progress and possibly usable for simple cases.
> Haven't had some time to work on it for a while (~4 months, sigh), but
> will definitely get some time in late June/early July to carry it on.
> You can check out the "replay" branch of github.com/newren/git if
> you're curious.

Thank you, will look!
