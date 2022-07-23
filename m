Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9948C433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 00:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiGWA2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 20:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGWA2b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 20:28:31 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB64D10A
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 17:28:30 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id b21so4622925qte.12
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YYeLe9kIXXW15uc3IjmFeQHInhv0ENiE0EzrmXlg5wg=;
        b=TydS5hU9m60r3ffko8/T/NStZDV4a9aaFH4Cz7ZU1Bfn2v/bBaqrO/w8nME8l60+8W
         UlLDbJT6AQcXXiwKOnubsdLLyMjUSbnvLCBOhdIAiiC0kp8mFPbJuGgJcUWDW7hkYYtF
         S8Efq6i7BdwANGGfIubprVq12jUb3XXAqV86B6N0QmapfSEZxgX7oFY0L6EN/q7mQ0jG
         r4kfSKFE5oqumOhvtCO5Vyfl8gGKO8ONzUxWNVzW4Ngjw0gc/9z4XzA9K/cKZSw5eyaH
         Q45ligmoaXmOvguzZ5ulmefu/jOuiOHQBI4P6BAXOU58nkrg2Z+RgFCMBEmtfU7TbOK8
         mDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YYeLe9kIXXW15uc3IjmFeQHInhv0ENiE0EzrmXlg5wg=;
        b=Z2yqfBpOBI7cLeD81oIA4+CRgnzY3Ky5ogNLQaW81bblzVMmpLY6lCKdKF+9d2oVzF
         bzo8tX+2SEvqI8BdOJV1Ju+e8IS+QZf8sMCFNkPkSJRxmRfvVke837Yxglp0LAFEP+Nt
         vSfBI+sIYaC++PcZPBLd1MlBfJa+7crzdtvdl4HuvBJPTtS8HVz9k/iY0c5zyGbfrvkM
         poaHdrK6sinBrp8DoHWt17ry5BNsLDDOPY+ps2V7W7nlUo5aIFurSK+hA/ZUI2jBqbbZ
         QNtQIj5nki+VXeoBxI2PpDBSN0GCMIjzNl8nS6L4Mpycsj7Ww3NxVK55vh55URoloIM4
         LbnQ==
X-Gm-Message-State: AJIora+nwaBniG+Fu0vs6G1qr5rNsDJMeYGkxFjvwmr8b/dRDiirZbgv
        d8j3/XSbiQr4FcPYv599hRszzHGG5QhgzO46OLo=
X-Google-Smtp-Source: AGRyM1u6JD8ysGtUYj3SZLIoVSzphAh/Z54Ktq4gIcFmyE4da8H3vU4klzUB0TV/WrtOTUx4FJb5Z1DzgmJDmByoBsY=
X-Received: by 2002:a05:622a:412:b0:31e:daba:4fc9 with SMTP id
 n18-20020a05622a041200b0031edaba4fc9mr2320376qtx.541.1658536109016; Fri, 22
 Jul 2022 17:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com> <b79f44e54b9611fa2b10a4e1cb666992d006951c.1658466942.git.gitgitgadget@gmail.com>
 <220722.86sfmts9vr.gmgdl@evledraar.gmail.com>
In-Reply-To: <220722.86sfmts9vr.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 Jul 2022 17:28:17 -0700
Message-ID: <CABPp-BHToEDv=8W9nf4XDC8b+5=EVuc=OnoT6xCRGWxB9CKWfw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] merge-resolve: abort if index does not match HEAD
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 3:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jul 22 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > As noted in commit 9822175d2b ("Ensure index matches head before
> > invoking merge machinery, round N", 2019-08-17), we have had a very
> > long history of problems with failing to enforce the requirement that
> > index matches HEAD when starting a merge.  One of the commits
> > referenced in the long tale of issues arising from lax enforcement of
> > this requirement was commit 55f39cf755 ("merge: fix misleading
> > pre-merge check documentation", 2018-06-30), which tried to document
> > the requirement and noted there were some exceptions.  As mentioned in
> > that commit message, the `resolve` strategy was the one strategy that
> > did not have an explicit index matching HEAD check, and the reason it
> > didn't was that I wasn't able to discover any cases where the
> > implementation would fail to catch the problem and abort, and didn't
> > want to introduce unnecessary performance overhead of adding another
> > check.
> >
> > Well, today I discovered a testcase where the implementation does not
> > catch the problem and so an explicit check is needed.  Add a testcase
> > that previously would have failed, and update git-merge-resolve.sh to
> > have an explicit check.  Note that the code is copied from 3ec62ad9ff
> > ("merge-octopus: abort if index does not match HEAD", 2016-04-09), so
> > that we reuse the same message and avoid making translators need to
> > translate some new message.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/merge.c                          | 20 ++++++++++++++++++
> >  git-merge-resolve.sh                     | 10 +++++++++
> >  t/t6424-merge-unrelated-index-changes.sh | 26 ++++++++++++++++++++++++
> >  3 files changed, 56 insertions(+)
> >
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index 23170f2d2a6..13884b8e836 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -1599,6 +1599,26 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
> >                */
> >               refresh_cache(REFRESH_QUIET);
> >               if (allow_trivial && fast_forward !=3D FF_ONLY) {
> > +                     /*
> > +                      * Must first ensure that index matches HEAD befo=
re
> > +                      * attempting a trivial merge.
> > +                      */
> > +                     struct tree *head_tree =3D get_commit_tree(head_c=
ommit);
> > +                     struct strbuf sb =3D STRBUF_INIT;
> > +
> > +                     if (repo_index_has_changes(the_repository, head_t=
ree,
> > +                                                &sb)) {
> > +                             struct strbuf err =3D STRBUF_INIT;
> > +                             strbuf_addstr(&err, "error: ");
> > +                             strbuf_addf(&err, _("Your local changes t=
o the following files would be overwritten by merge:\n  %s"),
> > +                                         sb.buf);
> > +                             strbuf_addch(&err, '\n');
>
> At first glance I was expecting this to construct an error message to
> emit it somewhere else that stderr, so I wondered if you couldn't use
> the "error_routine" facility to avoid re-inventing "error: " etc.,
> but...
>
> > +                             fputs(err.buf, stderr);
>
> ...we emit it to stderr anyway...?
>
> > +                             strbuf_release(&err);
> > +                             strbuf_release(&sb);
> > +                             return -1;
> > +                     }
> > +

UGH!  I fixed the other one of these in my reroll yesterday[1].  I
_knew_ I had copied that code somewhere else, but for some reason I
thought it was in a different series and went searching for it.  Don't
know why I couldn't remember that it was in the same series, and I'm
not sure how I missed it when I went looking.  I mean, I know I was
tired yesterday, but that's still kinda bad.

Anyway, thanks for catching; I'll fix this one too.

[1] https://lore.kernel.org/git/xmqqsfmulb6w.fsf@gitster.g/

> >                       /* See if it is really trivial. */
> >                       git_committer_info(IDENT_STRICT);
> >                       printf(_("Trying really trivial in-index merge...=
\n"));
> > diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
> > index 343fe7bccd0..77e93121bf8 100755
> > --- a/git-merge-resolve.sh
> > +++ b/git-merge-resolve.sh
> > @@ -5,6 +5,16 @@
> >  #
> >  # Resolve two trees, using enhanced multi-base read-tree.
> >
> > +. git-sh-setup
> > +
> > +# Abort if index does not match HEAD
> > +if ! git diff-index --quiet --cached HEAD --
> > +then
> > +    gettextln "Error: Your local changes to the following files would =
be overwritten by merge"
> > +    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
> > +    exit 2
> > +fi
>
> (The "..." continued below)
>
> Just in trying to poke holes in this I made this an "exit 0", and
> neither of the tests you added failed, but the last one ("resolve &&
> recursive && ort") in the t6424*.sh will fail, is that intentional?

Nope it's not intentional.  I had tested one fix (for these
git-merge-resolve.sh changes) and verified they were good (and
necessary), then found another bug (the one fixed by the
builtin/merge.c changes) and added a test for it, and just decided to
amend it into the same commit.  Turns out the builtin/merge.c changes
mask the fix for git-merge-resolve.sh here and makes that code go
unexercised.  I'll split these two bugfixes into separate patches, and
tweak one of the two testcases to make sure it continues to exercise
the new codepath added to git-merge-resolve.sh.

> I don't know enough about the context here, but given our *.sh->C
> migration elsewhere it's a bit unfortunate to see more *.sh code added
> back.

This seems like a curious objection.  "We are trying to get rid of
shell scripts, so don't even fix bugs in any of the existing ones." ?

> We have "git merge" driving this, isn't it OK to have it make this
> check before invoking "resolve" (may be a stupid question).

Ah, I can kind of see where you're coming from now, but that seems to
me to be bending over backwards in attempting to fix a component
written in shell without actually modifying the shell.
builtin/merge.c is some glue code that can call multiple different
strategies, but isn't the place for the implementation of the
strategies themselves, and I'd hate to see us put half the
implementation in one place and half in another.  In addition, besides
the separation of concerns issue::

   * We document that users can add their own merge strategies (a
shell or executable named git-merge-$USERNAME and "git merge -s
$USERNAME" will call them)
   * git-merge-resolve and git-merge-octopus serve as examples
   * Our examples should demonstrate correct behavior and perform
documented, required steps.  This particular check is important:

    /*
     * At this point, we need a real merge.  No matter what strategy
     * we use, it would operate on the index, possibly affecting the
     * working tree, and when resolved cleanly, have the desired
     * tree in the index -- this means that the index must be in
     * sync with the head commit.  The strategies are responsible
     * to ensure this.
     */

So, even if someone were to reimplement git-merge-resolve.sh in C, and
start the deprecation process with some merge.useBuiltinResolve config
setting (similar to rebase.useBuiltin), I'd still want this shell fix
added to git-merge-resolve.sh in the meantime, both as an important
bugfix, and so that people looking for merge strategy examples who
find this script hopefully find a new enough version with this
important check included.

In general, if merge strategies do not perform this check, we have
observed that they often will either (a) discard users' staged changes
(best case) or (b) smash staged changes into the created commit and
thus create some kind of evil merge (making it look like they created
a merge normally, and then amended the merge with additional changes).

We're lucky that the way resolve was implemented, other git calls
would usually incidentally catch such issues for us without an
explicit check.  We were also lucky that the observed behavior was
'(a)' rather than '(b)' for resolve.  But the issue should still be
fixed.

> For this code in particular it:
>
>  * Uses spaces, not tabs

Yes, that's fair, but as I mentioned in the commit message, it was
copied from git-merge-octopus.sh.  So, as you say below, "so did the
older version".

>  * We lose the diff-index .. --name-only exit code (segfault), but so
>    did the older version

Um, I don't understand this objection.  I think you are referring to
the pipe to sed, but if so...who cares?  The exit code would be lost
anyway because we aren't running under errexit, and the next line of
code ignores any and all previous exit codes when it runs "exit 2".
And if you're not referring to the pipe to sed but the fact that it
unconditionally returns an exit code of 2 on the next line, then yes
that is the expected return code.  Whatever the diff-index segfault
returns would be the wrong exit status and could fool the
builtin/merge.c into doing the wrong thing.  It expects merge
strategies to return one of three exit codes: 0, 1, or 2:

    /*
     * The backend exits with 1 when conflicts are
     * left to be resolved, with 2 when it does not
     * handle the given merge at all.
     */

So, ignoring the return code from diff-index is correct behavior here.

Were you thinking this was a test script or something?

>  * I wonder if bending over backwards to emit the exact message we
>    emitted before is worth it
>
> If you just make this something like (untested):
>
>         {
>                 gettext "error: " &&
>                 gettextln "Your local..."
>         }
>
> You could re-use the translation from the *.c one (and the "error: " one
> we'll get from usage.c).
>
> That leaves "\n %s" as the difference, but we could just remove that
> from the _() and emit it unconditionally, no?

??

Copying a few lines from git-merge-octopus.sh to get the same fix it
has is "bending over backwards"?  That's what I call "doing the
easiest thing possible" (and which _also_ has the benefit of being
battle tested code), and then you describe a bunch of gymnastics as an
alternative?  I see your suggestion as running afoul of the objection
you are raising, and the code I'm adding as being a solution to that
particular objection.  So this particular flag you are raising is
confusing to me.

> >  # The first parameters up to -- are merge bases; the rest are heads.
> >  bases=3D head=3D remotes=3D sep_seen=3D
> >  for arg
> > diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-u=
nrelated-index-changes.sh
> > index b6e424a427b..f35d3182b86 100755
> > --- a/t/t6424-merge-unrelated-index-changes.sh
> > +++ b/t/t6424-merge-unrelated-index-changes.sh
> > @@ -114,6 +114,32 @@ test_expect_success 'resolve, non-trivial' '
> >       test_path_is_missing .git/MERGE_HEAD
> >  '
> >
> > +test_expect_success 'resolve, trivial, related file removed' '
> > +     git reset --hard &&
> > +     git checkout B^0 &&
> > +
> > +     git rm a &&
> > +     test_path_is_missing a &&
> > +
> > +     test_must_fail git merge -s resolve C^0 &&
> > +
> > +     test_path_is_missing a &&
> > +     test_path_is_missing .git/MERGE_HEAD
> > +'
> > +
> > +test_expect_success 'resolve, non-trivial, related file removed' '
> > +     git reset --hard &&
> > +     git checkout B^0 &&
> > +
> > +     git rm a &&
> > +     test_path_is_missing a &&
> > +
> > +     test_must_fail git merge -s resolve D^0 &&
> > +
> > +     test_path_is_missing a &&
> > +     test_path_is_missing .git/MERGE_HEAD
> > +'
> > +
> >  test_expect_success 'recursive' '
> >       git reset --hard &&
> >       git checkout B^0 &&
>
> ...I tried with this change on top, it seems to me like you'd want this
> in any case, it passes the tests both with & without the C code change,
> so can't we just use error() here?
>
>         diff --git a/builtin/merge.c b/builtin/merge.c
>         index 7fb4414ebb7..64def49734a 100644
>         --- a/builtin/merge.c
>         +++ b/builtin/merge.c
>         @@ -1621,13 +1621,8 @@ int cmd_merge(int argc, const char **argv,=
 const char *prefix)
>
>                                 if (repo_index_has_changes(the_repository=
, head_tree,
>                                                            &sb)) {
>         -                               struct strbuf err =3D STRBUF_INIT=
;
>         -                               strbuf_addstr(&err, "error: ");
>         -                               strbuf_addf(&err, _("Your local c=
hanges to the following files would be overwritten by merge:\n  %s"),
>         -                                           sb.buf);
>         -                               strbuf_addch(&err, '\n');
>         -                               fputs(err.buf, stderr);
>         -                               strbuf_release(&err);
>         +                               error(_("Your local changes to th=
e following files would be overwritten by merge:\n  %s"),
>         +                                     sb.buf);
>                                         strbuf_release(&sb);
>                                         return -1;

Yes, this is the same change suggested by Junio for patch 1 which I
should have also applied here.  Thanks for catching it!
