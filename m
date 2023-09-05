Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B8CCA1018
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjIEQoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349328AbjIEQVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 12:21:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4820D1BCC
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 09:18:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso769651766b.1
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1693930261; x=1694535061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtRrjSbeeslRhVyNu5hXFDOCNvWpNn+EbkEOctKt5Pc=;
        b=Lw+ArrRHMJTvOEWkJEL/7HJU2o/nCK6hTgpOTVq9dBWWE/0mjrqaDqoB8YFZamLtba
         PwR7xxGA2IisWFTh2kga69+jDSHVK9MmbSklcpsY3Qt2OmRoDU4YVwirjezJsccCKKEb
         /EXwPBlqoJoe2mYaWjmxz35HeLco1/Yr7dik0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693930261; x=1694535061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtRrjSbeeslRhVyNu5hXFDOCNvWpNn+EbkEOctKt5Pc=;
        b=ZFXNQESlDfgKZU6GMda6kE2PtbDu4kr1cqy0+7dGhCFOQtH/HiQweTo++S3UFZPxc/
         gyc2fd7R3LgVJLrV8NWx65yEuq3V8kH2C5Sxa4vCmrKVK5xaEn+eTMgV6ApyAciqZxEP
         JIf0pbI6RTYz6BnUQ89H2eHQ2F6k2/vF6Yz4pLsHkY5dlhXuuWuRYPbGL0/LWORwcg+f
         BCnUtsQnxIXbWWfOk0Rm8g/FEMZAB8PQq5lbs2i31Bk9C3qUbaY5YgIcdU6DEWBK7r9L
         9xA2BwBJa+dhd09Tw4q0X68wI7JO1271ZrpbDGihVFqQx9zC6nHJZgG3zIOGEe6FUzsn
         fIDA==
X-Gm-Message-State: AOJu0Yz0ro4WoSTGh31aUo/gdM3oPHU4tP3dXsbN0uG3DR++TGv1KmzP
        7NQBoSoXZiGXsxTO8mArGqwnOJfuvCGR80+Z56Da3g==
X-Google-Smtp-Source: AGHT+IE+xgnbS6VLi7j4/z8aOldTd2u0Bg1mQM9b3fl37q5dY2/o1TLDrUxvf3G43k/uCYLs1ZemRejFDZtFtfpOse4=
X-Received: by 2002:a17:907:97c6:b0:9a5:962c:cb6c with SMTP id
 js6-20020a17090797c600b009a5962ccb6cmr276121ejc.31.1693930260880; Tue, 05 Sep
 2023 09:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <CAPig+cTeQDMpWQ-zCf6i9H-yhrdCndX6gs67sypuqmHZZcHm7w@mail.gmail.com>
In-Reply-To: <CAPig+cTeQDMpWQ-zCf6i9H-yhrdCndX6gs67sypuqmHZZcHm7w@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 5 Sep 2023 18:10:50 +0200
Message-ID: <CAPMMpog3o=DtOrC9L6ED42XkegdObkh3rGm617q4u2oofBC1TA@mail.gmail.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2023 at 2:26=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Mon, Sep 4, 2023 at 10:41=E2=80=AFAM Tao Klerks <tao@klerks.biz> wrote=
:
> >
> > One problem that we found users to have, early on when we introduced
> > worktrees, was that it was not obvious to users that there was (or why
> > there was) a "main" worktree, containing the actual ".git" repo, and
> > "subsidiary" worktrees, in the same directory location. Git by default
> > makes worktrees *subfolders* of the initial/main worktree/folder, but
>
> This is not accurate. There is no default location for new worktrees;
> git-worktree creates the new worktree at the location specified by the
> user:
>
>     git worktree add [<options>] <path> [<commit>]
>
> where <path> -- the only mandatory argument -- specifies the location.
>

Right - I know you *can* create worktrees in the "parent path", and
now that I revisit the doc I see there are even a couple examples that
do exactly that - but whenever I've talked with people who've tried
"git worktree add" independently, they ended up with the nested
worktrees and wondering why things work this weird way.

The idea that the "most trivial" example of creating a worktree would
be "git worktree add ../my_new_worktree" is, I believe, very
non-obvious.

The other thing that is I believe is non-obvious, in the current
solution, is that *if* you end up placing multiple worktrees at the
same level, *and* you end up using them "interchangeably" as you
presumably would in some or most scenarios, even though their *usage*
is identical, their "importance", or "lifetime" is very much not.

>
> It indeed was designed to work this way. It is perfectly legitimate to
> create worktrees attached to a bare repository[1].
>

Awesome, thx for confirming!

> in a bare repository
> scenario, the term "main worktree" refers to the bare repository, not
> to the "blessed" worktree containing the ".git/" directory (since
> there is no such worktree in this case).

Noted, thank you. We have been using the word "repository" vs worktree
- the (main) GITDIR is the repo, the worktrees are all just worktrees.
There is no "main worktree" in the way we talk about things, although
clearly the official nomenclature doesn't square with that, which I
might need to address at some point.


> Worktrees appear to be a red-herring. It's possible to reproduce this
> error without them. For instance:
>
>     % git clone --bare --filter=3Dblob:none
> https://github.com/ksylor/ohshitgit dangit_shared.git
>     % git clone dangit_shared.git foop
>     % cd foop
>     % echo nothing >nothing
>     % git add nothing
>     % git commit -m nothing
>     fatal: unable to read dbbb0682a7690b62ccf51b2a8648fa71ac671348
>     % git push origin master
>     % cd ../dangit_shared.git
>     % git gc
>     ...
>     warning: Failed to write bitmap index. Packfile doesn't have full
> closure (object bf86ed1b2602ac3a8d4724bcdf6707b156673aac is missing)
>     fatal: failed to write bitmap index
>     fatal: failed to run repack
>

Hmm, I don't really understand what happened there, but it looks to me
like you went *much* further off the beaten path by cloning from a
partial clone. Afaik that's hard-not-supported...?

>
> The former, meaning that your setup should be supported. Citing
> documentation for `core.bare`:
>
>     If true this repository is assumed to be bare and has no working
>     directory associated with it. If this is the case a number of
>     commands that require a working directory will be disabled, such
>     as git-add(1) or git-merge(1).
>

Thanks again!

>
> `--separate-git-dir` predates multiple-worktree support by several
> years and is distinct in purpose from --bare and multiple-worktrees
> (in fact, a couple somewhat recent fixes [2,3] were needed to prevent
> --separate-git-dir from breaking worktree administrative data). My
> understand from scanning history is that --separate-git-dir was
> introduced in aid of submodule support and perhaps other use-cases.

OK, so if it is legitimate as-is... why doesn't it set
"core.worktree"? At least that way there'd be a solid two-way
reference like with "git worktree" worktrees.

Or is the *point* of the submodule and/or other use-cases that the
gitdir can't "know" its worktree??

> git-new-workdir predates git-worktree by quite a few years and, as I
> understand it, remains in-tree because it fills a niche not entirely
> filled by git-worktree.

OK, I'll keep my nose out of this one entirely either way, thx :)
