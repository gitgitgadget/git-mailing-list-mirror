Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F57C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjATWMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjATWMf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:12:35 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD98B36442
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:12:33 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-15eec491b40so7777128fac.12
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etzT1McAHxL0/TAqb5q14RcEMlLYzKPbcSEbsSLm/sE=;
        b=hgRTDoZrvzexINzX2YvwgJqqb2oXYJ4O1zhz/WVhNeL6tKQTrL7HRWDsIxphalkZN3
         Xhu1AYjtvTPxpWbCXCGdzbUy28M8ShJEQUWzJHMxJu2q3xTKSiKHXPQOcdKjtbdap2pk
         +LWQYBafZ46GK9b2dMAt4yydTOIQJc8gNqFraUp+M0saazDHwT5TX48bTzrgiGAyYXJP
         WYIupSepErM4BcF91MGCZf0onXvSFSiIs7PuiOMO8NsYPYIRlk6Iizv4QpWVz7NmsScd
         Mb3CPHMfbIcElUae4uzARqySmUnyDVLo/IWRrzuGIHR6A3eTDj2yqPoqiUIBkJ48WRCw
         4K0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etzT1McAHxL0/TAqb5q14RcEMlLYzKPbcSEbsSLm/sE=;
        b=1AXCXZhj65dCscC/aAoq2hOZa+kgLD0tzQX2qzoehVbnpR8X4aHGYUPrwIY21m+41+
         a9SmNcjP11RASV8RRW0+qMAcifwNKAQpdySmnVzCQgiwLVp/Rv8ncyfX1gikLzFASUZy
         V9tz+vmYIrL5Spti7VGkfdgLHxmXNKYRCTJto9SPrIuED+s13T8fj3vm8VF3dwmWXwUu
         IYaB/1Ue/Ch7NQsfC+RxLuAg3kIX92/L8q7dNPFcvcsTWKm+6j3+p51Iqy8qoNRQ5WKR
         AsxhMVEeXvXNh7z5XNaX6vce/hRu/5ARGNv5V+FOu/Hfj2fPBnJvUeGUB+CPOKse8zAj
         zdNw==
X-Gm-Message-State: AFqh2ko0TeWslvhncU9rHo0pX30mH0Gj3gEUAUFPvvQvM4Dc6cyBSOo+
        lOf1oZ4QR1hxR3CAwLh1Ezj7vhp/Qpn5ZLUUpvwruBiMcak=
X-Google-Smtp-Source: AMrXdXuzIF/z9L9qkMxksezhMl+TobrY0JOEp+bjW0yItFo3fbYROr7f3n8xJ4dQY/0UPfgRSlKC+k4XBoJPpuFKDk0=
X-Received: by 2002:a05:6870:bc01:b0:15f:33b4:879b with SMTP id
 oa1-20020a056870bc0100b0015f33b4879bmr1097296oab.59.1674252752356; Fri, 20
 Jan 2023 14:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20230119055325.1013-1-carenas@gmail.com> <20230120113553.24655-1-carenas@gmail.com>
 <8f24fc3c-c30f-dc70-5a94-5ee4ed3de102@dunelm.org.uk>
In-Reply-To: <8f24fc3c-c30f-dc70-5a94-5ee4ed3de102@dunelm.org.uk>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 20 Jan 2023 14:12:21 -0800
Message-ID: <CAPUEspjuXSncRxo5DMj1pA5zcYvn4Y6epdijYL6HJRGhk_6q7g@mail.gmail.com>
Subject: Re: [PATCH v4] checkout/switch: disallow checking out same branch in
 multiple worktrees
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Jinwook Jeong <vustthat@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 7:08 AM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>
> On 20/01/2023 11:35, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > Commands `git switch -C` and `git checkout -B` neglect to check whether
> > the provided branch is already checked out in some other worktree, as
> > shown by the following:
> >
> >    $ git worktree list
> >    .../foo    beefb00f [main]
> >    $ git worktree add ../other
> >    Preparing worktree (new branch 'other')
> >    HEAD is now at beefb00f first
> >    $ cd ../other
> >    $ git switch -C main
> >    Switched to and reset branch 'main'
> >    $ git worktree list
> >    .../foo    beefb00f [main]
> >    .../other  beefb00f [main]
> >
> > Fix this problem by teaching `git switch -C` and `git checkout -B` to
> > check whether the branch in question is already checked out elsewhere.
> >
> > Unlike what it is done for `git switch` and `git checkout`, that have
> > an historical exception to ignore other worktrees if the branch to
> > check is the current one (as required when called as part of other
> > tools), the logic implemented is more strict and will require the user
> > to invoke the command with `--ignore-other-worktrees` to explicitly
> > indicate they want the risky behaviour.
> >
> > This matches the current behaviour of `git branch -f` and is safer; for
> > more details see the tests in t2400.
>
> As I said before, it would be much easier for everyone else to
> understand the changes if you wrote out what they were rather than
> saying "look at the tests". I do appreciate the improved test
> descriptions though - thanks for that.

Apologies on that, I tried to come up with something that would
describe the change of behaviour other than the paragraph above and
couldn't come out with a better explanation except reading the tests
(which I know is complicated by the fact they are interlinked).

The behaviour I am changing is also not documented (other than by the
test) and might have been added as a quirk to keep the scripted rebase
and bisect going when confronted with branches that were checked out
in multiple worktrees, and as such might had not be intended for
`switch`, and might not be needed anymore either.

Using`checkout` for simplicity, but also applies to `switch`,

  % git worktree list
  .../base  6a45aba [main]
  % git worktree add -f ../other main
  Preparing worktree (checking out 'main')
  HEAD is now at 6a45aba init
  % cd ../other
  % git checkout main
  Already on 'main'
  % git checkout -B main
  fatal: 'main' is already checked out at '.../base'
  % git checkout --ignore-other-worktrees -B main
  Already on 'main'

The change of behaviour only applies to -B and it actually matches the
documentation better.

> > @@ -1533,13 +1534,13 @@ static int checkout_branch(struct checkout_opts=
 *opts,
> >       if (!opts->can_switch_when_in_progress)
> >               die_if_some_operation_in_progress();
> >
> > -     if (new_branch_info->path && !opts->force_detach && !opts->new_br=
anch &&
> > -         !opts->ignore_other_worktrees) {
> > +     if (!opts->ignore_other_worktrees && !opts->force_detach &&
> > +         check_branch_path && ref_exists(check_branch_path)) {
>
> I think check_branch_path is NULL if opts->ignore_other_worktrees is set
> so we could maybe lose "!opts->ignore_other_worktrees" here (or possibly
> below where you set check_branch_path).

opts->ignore_other_worktrees was kept from the original expression;
you are correct that is not needed anymore, but I thought it didn't
hurt and made the code intention clearer (meaning it is obvious to
anyone new to the code that this code will be skipped if that flag is
set), would using an assert or a comment be a better option?

> >       /*
> >        * Extract branch name from command line arguments, so
> >        * all that is left is pathspecs.
> > @@ -1741,6 +1751,9 @@ static int checkout_main(int argc, const char **a=
rgv, const char *prefix,
> >                                            new_branch_info, opts, &rev)=
;
> >               argv +=3D n;
> >               argc -=3D n;
> > +
> > +             if (!opts->ignore_other_worktrees && !check_branch_path &=
& new_branch_info->path)
> > +                     check_branch_path =3D xstrdup(new_branch_info->pa=
th);
>
> I'm a bit confused what this is doing.

The branch we are interested in might come from 2 places, either it is
a parameter to -b, which was picked up before, or it is the argument
to the command itself, which was detected above.

If both are provided, we want to make sure to use the one from -b, or
will have the bug you sharply spotted before, which was frankly
embarrassing.

> > diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> > index d587e0b20d..7ab7e87440 100755
> > @@ -133,17 +136,34 @@ test_expect_success SYMLINKS 'die the same branch=
 is already checked out (symlin
> >       test_must_fail git -C here checkout newmain
> >   '
> >
> > -test_expect_success 'not die the same branch is already checked out' '
> > +test_expect_success 'allow creating multiple worktrees for same branch=
 with force' '
> > +     git worktree add --force anothernewmain newmain
> > +'
> > +
> > +test_expect_success 'allow checkout/reset from the conflicted branch' =
'
>
> I'm not sure what "the conflicted branch" means (it reminds we of merge
> conflicts).

by "conflicted" I meant one that is checked out in more than one worktree

> Is this just testing that "checkout -b/B <branch>
> <start-point>" works?

yes, but most importantly that we chose the right branch to check if
both are provided and <start-point> is also a branch

> >       (
> >               cd here &&
> > -             git worktree add --force anothernewmain newmain
> > +             git checkout -b conflictedmain newmain &&
> > +             git checkout -B conflictedmain newmain &&
> > +             git switch -C conflictedmain newmain
> > +     )
> > +'
> > +
> > +test_expect_success 'and not die on re-checking out current branch eve=
n if conflicted' '
>
> I think 'allow re-checking out ...' would be clearer, again I'm not sure
> what's conflicted here.

ok

> > +     (
> > +             cd there &&
> > +             git checkout newmain &&
> > +             git switch newmain
> >       )
> >   '
> >
> > -test_expect_success 'not die on re-checking out current branch' '
> > +test_expect_failure 'unless using force without --ignore-other-worktre=
es' '
>
> This test passes for me - what's the reason for changing from
> test_expect_success to test_expect_failure?

It also works for me, and for Junio, but somehow it didn't in the last
runs from the CI and you could reproduce locally by going to the tree
created above in the example I provided and doing:

  % cd ../base
  % git checkout -B main

which should fail after finding that main is already checked out in
`other`, but does not because when looking at the worktrees would
first find the current one and not die, never aware there is another
worktree with that same branch.

the bug is the same one that Rub=C3=A9n is trying to address for rebase and
that you commented on as well and that was mentioned before in this
thread:

  https://lore.kernel.org/git/eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.co=
m/

Carlo
