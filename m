Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC670ECAAD2
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 02:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiH3CwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 22:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiH3CwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 22:52:12 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7396061D41
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:52:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a15so7512988qko.4
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=kW0GFNXjoUjw3ZTQD1wxqqqqeUD9OOXurSNeQroj+4c=;
        b=evvS77L95s+M+0zwEy2739eq/jcEdfsU5QISd4hsJMRSKr7MHPcsvav39LvzgGwpeE
         g4TTqj4LjSxTcnHParNCprfQiveZbyENXSYDK/7NyjYKxRGy4JULdcBMCnPK8YiSN1DC
         wTqqfkbgZiPaNOIYd9oHpcsVWlkGDzcP0J+mQWDXkHMxGfuYDJq5VUCWKLXlQOL6LHmZ
         yURGHjyYSZqQU2XR3lvLiR2dv5qYkQydwTxQNiD7KCHRZu4QpBOImQIRT0jxBzOZz6oG
         FyY0k2zr8IPTkqMgRzYQcQFAO3y4bNBj6RCN5nT4TqVLkVKTBly9pSgstFUSiFBhYpkO
         lCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=kW0GFNXjoUjw3ZTQD1wxqqqqeUD9OOXurSNeQroj+4c=;
        b=UCm2ovgUg/JUT5VClf/RdaytRpy48p/sTaPNvaH5rrhNmG4iiEylALULqd2qgS36aA
         sas5c0oQxxqmTUq8osLtEEm28ob+XB9502verLiL5sNWZvi6TrCOa4+m1g/rHE5SEndr
         bMRALy1iFjBXBi0RWOL/90Yf+MAZ8xfUy5Ay/biBZaTrg0Ivp925f4ZFR0MBwzE+Ccf1
         YTjrQLDxGnUIAipl07R25dgcSkePxUUPig8siUWFQIKLLn7kEYxno3ljgelxX6FVDH75
         kDUtw3U8k2ZR5IZj6/A8RqYwaXcHEYkUirLsR52VlhStpQdKdGD5kSJeBrhZdEXT85sZ
         9vig==
X-Gm-Message-State: ACgBeo1YPiTTidCIOpkB7OiUttp0yEXbj0POlNffnNCTBBTMdpP4cPcg
        ffA+DfWwa/fs5ZhANC4AHxm4cYFVVbwN16aBpl8bFJ96bRk=
X-Google-Smtp-Source: AA6agR40Hrj37vIkbNaNI3dysAXu6g73mjD6Kz5Hk56CYy4QHzMxhpyyDXb0jAfYZ0tZFS/3NFF5ZcNoT873UPZ0jSk=
X-Received: by 2002:a05:620a:205d:b0:6bb:2393:b610 with SMTP id
 d29-20020a05620a205d00b006bb2393b610mr10670729qka.413.1661827930545; Mon, 29
 Aug 2022 19:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <43cf2a1d-058a-fd79-befe-7d9bc62581ed@gmail.com>
 <CABPp-BEkC8xEkNa+hyKFKhO=cbBZqNqGWehqxbRzE6-BVR27NQ@mail.gmail.com> <b19c7090-109c-8988-56cf-4f8887de3845@gmail.com>
In-Reply-To: <b19c7090-109c-8988-56cf-4f8887de3845@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Aug 2022 19:51:59 -0700
Message-ID: <CABPp-BGxN=9f4ODeRsX5TMuKRujCuhmRxCm4br43HNqm3Vmanw@mail.gmail.com>
Subject: Re: Bug in 'git log --remerge-diff' when used with '--find-object'
 and '--submodule=log|diff'
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2022 at 9:36 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Elijah,
>
> Le 2022-08-24 =C3=A0 03:36, Elijah Newren a =C3=A9crit :
> > Hi Philippe,
> >
> > On Mon, Aug 22, 2022 at 4:58 PM Philippe Blain
> > <levraiphilippeblain@gmail.com> wrote:
> >>
> >> Hi Elijah,
> >>
> >> I found two bugs in '--remerge-diff' when combined with both '--find-o=
bject' and
> >> '--submodule=3Dlog|diff'. I don't know if they have the same cause.
> >>
> >> When using these flags together, *all* 2-parents merge commits are sho=
wn (even in a repo with
> >> no submodule!)
> >>
> >> Moreover, for merges with conflicted paths, all conflicted paths are s=
hown as "(new submodule)",
> >> even if they are not a submodule (in fact, even when no submodule is p=
resent
> >> in the repository!).
> >>
> >> This artificial example reproduces the bug:
> >>
> >> ```bash
> >> #!/bin/bash
> >>
> >> set -euEo pipefail
> >>
> >> repo=3Drepro
> >> rm -rf $repo
> >>
> >> TEST_AUTHOR_LOCALNAME=3Dauthor
> >> TEST_AUTHOR_DOMAIN=3Dexample.com
> >> GIT_AUTHOR_EMAIL=3D${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
> >> GIT_AUTHOR_NAME=3D'A U Thor'
> >> GIT_AUTHOR_DATE=3D'1112354055 +0200'
> >> TEST_COMMITTER_LOCALNAME=3Dcommitter
> >> TEST_COMMITTER_DOMAIN=3Dexample.com
> >> GIT_COMMITTER_EMAIL=3D${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOM=
AIN}
> >> GIT_COMMITTER_NAME=3D'C O Mitter'
> >> GIT_COMMITTER_DATE=3D'1112354055 +0200'
> >> export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
> >> export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
> >> export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> >> export HOME=3D
> >>
> >> git -c init.defaultBranch=3Dunimportant init $repo
> >> cd $repo
> >> echo i>file
> >> git add file
> >> git commit -m file
> >> git checkout -b side
> >> echo s>>file2
> >> git add file2
> >> git commit -am side
> >> git checkout -
> >> echo m >>file
> >> git commit -am main
> >> git merge side -m clean
> >> git checkout side
> >> echo c>>file
> >> git add file
> >> git commit -am side2
> >> git checkout -
> >> echo cc>>file
> >> git commit -am main2
> >> git merge side || true
> >> printf 'i\nm' > file
> >> git commit -am conflicted
> >> # look for a dummy object
> >> git log --oneline --diff-merges=3Dr --submodule=3Dlog --find-object=3D=
2c042ac4213768e55791098110d2ef2ef845881a
> >> # same output with --submodule=3Ddiff
> >> ```
> >>
> >> This is the output I get from the 'git log' call:
> >>
> >> b4f1be9 (HEAD -> unimportant) conflicted
> >> Submodule file 0000000...0000000 (new submodule)
> >> a4ef223 clean
> >>
> >> Notice both merges are shown despite none of them changing the number =
of occurences of
> >> 2c042ac4213768e55791098110d2ef2ef845881a, which does not even exist in=
 this repository,
> >> and also that the conflicted merge shows 'file' as "new submodule".
> >
> > Thanks for the report, and the steps to reproduce.  Very helpful.
> >
> > After some digging, it appears the remerge-diff headers are
> > misinterpreted by the submodule code.  They transform what would have
> > been the following output:
> >
> >     b4f1be9 (HEAD -> unimportant) conflicted
> >     diff --git a/file b/file
> >     remerge CONFLICT (content): Merge conflict in file
> >     a4ef223 clean
> >
> > into what you saw, namely
> >
> >     b4f1be9 (HEAD -> unimportant) conflicted
> >     Submodule file 0000000...0000000 (new submodule)
> >     a4ef223 clean
> >
> > We can recover the intended remerge-diff header with the following simp=
le patch:
> >
> > diff --git a/diff.c b/diff.c
> > index 974626a621..be23f66057 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -3429,14 +3429,16 @@ static void builtin_diff(const char *name_a,
> >
> >         if (o->submodule_format =3D=3D DIFF_SUBMODULE_LOG &&
> >             (!one->mode || S_ISGITLINK(one->mode)) &&
> > -           (!two->mode || S_ISGITLINK(two->mode))) {
> > +           (!two->mode || S_ISGITLINK(two->mode)) &&
> > +           (one->mode || two->mode)) {
> >                 show_submodule_diff_summary(o, one->path ? one->path :
> > two->path,
> >                                 &one->oid, &two->oid,
> >                                 two->dirty_submodule);
> >                 return;
> >         } else if (o->submodule_format =3D=3D DIFF_SUBMODULE_INLINE_DIF=
F &&
> >                    (!one->mode || S_ISGITLINK(one->mode)) &&
> > -                  (!two->mode || S_ISGITLINK(two->mode))) {
> > +                  (!two->mode || S_ISGITLINK(two->mode)) &&
> > +                  (one->mode || two->mode)) {
> >                 show_submodule_inline_diff(o, one->path ? one->path : t=
wo->path,
> >                                 &one->oid, &two->oid,
> >                                 two->dirty_submodule);
> >
> > In other words, when we have information about something other than a
> > submodule, don't attempt to treat it as information about a submodule.
>
> Thanks for digging into this.
> From what I understand in the case of a remerge-diff, both modes are all-=
zero, and this is
> not expected by the submodule diff code. Were you planning to submit a pr=
oper
> patch ? I could get to it eventually, but not before mid/end of September=
...

I intend to submit a proper patch; I've just been busy.

> >
> > Now, whether the remerge-diff header should be shown is an interesting
> > one -- it's a carry on to the discussion in the thread at [1], and
> > isn't simple to answer.
> > [1] https://lore.kernel.org/git/CABPp-BHjU+wDXNnf-rsGy86GvOFWH6qVLPEfAA=
2JDfLFRU4WSA@mail.gmail.com/
>
> Thanks for a link to a very interesting discussion! However I'm not exact=
ly sure
> what you meant here.

I'm just saying there are special cases where it's difficult to
determine whether to include the "remerge CONFLICT" diff headers.  For
basic cases, they are obviously wanted when running under
"--remerge-diff" since that mode was designed to show that kind of
information.  I think below you were trying to get at the fact that
remerge headers will often be accompanied by one or more diff hunks
which show content changes in the relevant file...and implying that if
there are no such diff hunks (because other flags caused those to be
filtered out), then the remerge header should also be omitted.
Unfortunately such a strategy would only work if we could replace
"often" with "always" in that last sentence.  We can't do so; there
are cases where remerge headers are accompanied by zero diff hunks and
those headers need to be shown despite there being zero related diff
hunks.  (A pretty common example: imagine a simple modify/delete
conflict resolved in favor of keeping the modified file.  The
resulting file recorded in the merge commit exactly matches the
auto-merged one so there are no diff hunks to show, but a `git show
--remerge-diff $MERGE_COMMIT` should definitely show the modify/delete
conflict header since the merge was conflicted and the user did work
to resolve it.)  In fact, my first implementation of "git show
--remerge-diff" did only include the remerge headers when the diff for
the corresponding file was non-empty, but I almost immediately noted
several examples in my initial testing where doing so was causing
important information to be incorrectly filtered out.

[...]
> Because if I do add '-p', (in my reproducer) I still do not get any diff =
content. But if I remove
> '--find-object', then I do...

--remerge-diff turns on -p implicitly, so adding an explicit '-p' is
not a useful test here.

--find-object does some filtering, but how is the portion of the code
responsible for adding the remerge headers supposed to know whether
such filtering has happened and if it's relevant to any conflict
headers that it needs to add?  I'm not sure how much information about
the command line flags or what filtering happened is available at that
point in the code.  And, as noted above, the lack of diff hunks is not
a usable criteria for judging whether to include the header.

> > As for the first bug, the showing of any 2-parent commits, yes that's
> > true.  But it's not limited to remerge-diff; you can change
> > --diff-merges=3Dr to --diff-merges=3Dc or --diff-merges=3Dcc and see th=
e
> > same thing.  I'm not sure if that means that my looking at the
> > do_diff_combined() logic when developing the do_remerge_diff()
> > function meant I copied a bug, or if I independently came up with it
> > on my own.  But, for now, I need some sleep.  Just thought I'd give
> > you an update on what I have found so far, though.
> >
>
> Yes, I had noticed that I had the same behaviour with --cc or -c, I forgo=
t to mention it.
> With 'separate' or 'first-parent', though, no commits are shown (as expec=
ted).
> To be clear, this behaviour is independent of the use of '--submodule=3Ds=
hort|log|diff'.

Yep, the modes that treat merges as actual merges instead of
pretending they are regular commits are precisely the modes which
exhibit this behavior.  I'll have to dig into why.
