Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hkb+0NXS"
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E31110
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 04:13:00 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cf8720c6b7so6195825ad.0
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 04:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700741580; x=1701346380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yQCWgrwekKTxYbnXcReY+Ir+g+cuc2MboP+EQ4bY4Kw=;
        b=Hkb+0NXSbCoAD5VMy3JJQgMV9ytC0t19mkmyCozLdDX03uuIidbbYePar7Ny4tXvKG
         okK9/sCUw+vVxT2dhYeNRckU2ukqTTbPfdhVpSXcnpKArH9zJH+0DbsWHBe0XToC76iu
         pr1LiV6JY3UyVfzE7BJWaX5/pFZH8Xlxs1BqWg8fksFIyS45VvsrGmtvOUNCUXvBxLnE
         rWJqZsTgbcKIxOBIZVGma8gme8PxOMj71qCo6c3cZz4siHzksItGLffxOeMRYwtLeCba
         j3U5fhrD9DsRduEQXEIh4T50uDn+L+gCsuPgqbBZiUQvx3lQxVGtyWK2Ywx2+/UvYMq7
         V/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700741580; x=1701346380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQCWgrwekKTxYbnXcReY+Ir+g+cuc2MboP+EQ4bY4Kw=;
        b=kNq0qW7RAXsOzxk5cPGx6IQURDBNrEdmnjOe5WFHsIIcQyIN+nQomPlblZ783X3I3r
         wiKyaar1efXTME8cOScwaw73yWj//UbknE9QXmmfDay1N+U9EGc5LBrarbIarUdw+z5O
         uiLs9eG0/ngfZQx6Qs3FJsW5+Y/5TnKXqxkx+8e1nkyMnBZKt8xbe952ZhieQ7wOQryw
         gzBaqNwM+TjDJks9JebXq4G3rEhU0dceoOfFUiNhtpJpIlu/2g11TtPhR9oCRo2lzqSi
         SCsvJFRR6ePivkQTIJn9Sg00vVRcebmoTa1KqSOugq4L+JL7Y44uDiipHD1OU21b77U/
         u9EA==
X-Gm-Message-State: AOJu0YzRqppHv5BzspfH/bcjSNey4iT0G3VTnoDlhUHmfmlUWkDteWrO
	oNYOlYvT7f0zCqioGx/c7EfG9trnJiW/VEaVZw8WPd1jwdw=
X-Google-Smtp-Source: AGHT+IGv5CJ58aJdHptYsB4dy+3Ma0PBxTfHT+baJY++DmwG/5Iph5xiJwHZde/Sy+KGbnTVyN4Nw+y+/9qmTiGKvKM=
X-Received: by 2002:a17:90b:3803:b0:283:2fad:4a01 with SMTP id
 mq3-20020a17090b380300b002832fad4a01mr5272807pjb.46.1700741580102; Thu, 23
 Nov 2023 04:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
 <xmqqjzq9cl70.fsf@gitster.g>
In-Reply-To: <xmqqjzq9cl70.fsf@gitster.g>
From: Willem Verstraeten <willem.verstraeten@gmail.com>
Date: Thu, 23 Nov 2023 13:12:46 +0100
Message-ID: <CAGX9RpHOOu71LJa_Z_29b6hwy7s_+oxGv0U1kdt+CJ_Ztg1iSw@mail.gmail.com>
Subject: Re: git checkout -B <branch> lets you checkout a branch that is
 already checked out in another worktree Inbox
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >     git checkout -f main origin/main #also reports a fatal error, as expected
>
> This is expected because origin/main is taken as pathspec, and it is
> a request to checkout the paths that match the pathspec out of the
> named tree-ish (i.e., "main"), even when these paths have local
> changes, but you do not have paths that match "origin/main".  The
> failure is not because "main" is checked out elsewhere.
>

My mistake: I meant to do `git branch -f main origin/main`, as
documented for `git checkout -B main origin/main`

So, for completeness' sake, this is my revised reproduction scenario
that actually demonstrates the problem I have:

    ~/temp> git clone https://github.com/servo/pathfinder.git primary
    Cloning into 'primary'...
    ....

    ~/temp> cd primary

    ~/temp/primary> git worktree add -b metal ../secondary origin/metal
    Preparing worktree (new branch 'metal')
    branch 'metal' set up to track 'origin/metal'.
    HEAD is now at 1cdcc209 wip

    ~/temp/primary> cd ..\secondary\

    ~/temp/secondary> git checkout main
    fatal: 'main' is already used by worktree at ../primary'

    ~/temp/secondary> git branch -f main origin/main
    fatal: cannot force update the branch 'main' used by worktree at
'../primary'

    ~/temp/secondary> git checkout -B main origin/main
    Switched to and reset branch 'main'
    branch 'main' set up to track 'origin/main'.
    Your branch is up to date with 'origin/main'.

I would expect that last `git checkout -B ...` to fail with a similar
error as the `git branch -f ...` command right before that, since the
documentation for `git checkout -B <branch> <start-point>` states that
it is the atomic equivalent of `git branch -f <branch> <start-point> ;
git checkout <branch>`


> I guess we could change the behaviour so that
>
>     git checkout -B <branch> [<start-point>]
>
> fails when <branch> is an existing branch that is in use in another
> worktree, and allow "-f" to be used to override the safety, i.e.,
>
>     git checkout -f -B <branch> [<start-point>]

I would be very much in favor of that, indeed.

However, as you noted in your follow-up mail, the
--ignore-other-worktrees option would be better suited than the -f
flag.

> It turns out that for some reason "-f" is not how we decided to
> override this one---there is "--ignore-other-worktrees" option.

This means it would look like this then, if you decide to tackle this?

    ~/temp/secondary> git checkout -B metal origin/metal
    fatal: cannot force update the branch 'main' used by worktree at
'../primary'

    ~/temp/secondary> git checkout --ignore-other-worktrees -B metal
origin/metal
    Switched to and reset branch 'metal'
    branch 'metal' set up to track 'origin/metal'.
    Your branch is up to date with 'origin/metal'.

My thoughts as an experienced user, though not an experienced
contributor, admittedly :)

Kind regards,
Willem Verstraeten

On Thu, 23 Nov 2023 at 02:28, Junio C Hamano <gitster@pobox.com> wrote:
>
> Willem Verstraeten <willem.verstraeten@gmail.com> writes:
>
> >     git checkout -b main #reports a fatal error, as expected
>
> This is expected because "main" already exists, not because "main"
> is checked out elsewhere.
>
> >     git checkout -f main origin/main #also reports a fatal error, as expected
>
> This is expected because origin/main is taken as pathspec, and it is
> a request to checkout the paths that match the pathspec out of the
> named tree-ish (i.e., "main"), even when these paths have local
> changes, but you do not have paths that match "origin/main".  The
> failure is not because "main" is checked out elsewhere.
>
> A slight variant of the command
>
>     git checkout -f -b main origin/main
>
> still fails for the same reason as the first of your examples above.
>
> It is a tangent, but I suspect this failure may be a bit unexpected.
> In this example, "-f"orce could be overriding the usual failure from
> "-b" to switch to a branch that already exists, but that is what
> "-B" does, and "-f -b" does not work as a synonym for "-B".
>
> In any case, these example you marked "fail as expected" do fail as
> expected, but they fail for reasons that have nothing to do with the
> protection of branches that are used in other worktrees.
>
> >     git checkout -B main origin/main # ----> this succeeds, which is
> > unexpected <----
>
> I agree this may be undesirable.
>
> But it makes sort of sense, because "-B" is a forced form of "-b"
> (i.e., it tells git: even when "-b" would fail, take necessary
> measures to make it work), and we can view that it is part of
> "forcing" to override the protection over branches that are used
> elsewhere.
>
> I guess we could change the behaviour so that
>
>     git checkout -B <branch> [<start-point>]
>
> fails when <branch> is an existing branch that is in use in another
> worktree, and allow "-f" to be used to override the safety, i.e.,
>
>     git checkout -f -B <branch> [<start-point>]
>
> would allow the <branch> to be repointed to <start-point> (or HEAD)
> even when it is used elsewhere.
>
> Thoughts, whether they agree or disagree with what I just said, by
> other experienced contributors are very much welcome, before I can
> say "patches welcome" ;-).
>
> Willem, thanks for raising the issue.
>
>
>
