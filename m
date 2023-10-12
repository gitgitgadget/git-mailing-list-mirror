Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308B3CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 05:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376959AbjJLFcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 01:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJLFco (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 01:32:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD25890
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 22:32:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5855333fbadso424408a12.1
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 22:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697088762; x=1697693562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpxBQaO4qfoGflil25goGHyuZSnLmDAmWHbFFp9AoIw=;
        b=Qu+CtK6sMmEnElfS7r9bbwcycCIJZPKShCFwKQ+PpOnm1mC5B5ELx3ZUbEmeA9Hj9w
         yoF4BLeWT62MQ/2Hmt+y38KODnOcZI+H2NZh2Wzm6ROMRb8kvGuw9zciFchrJf/4ksIa
         pLiLsv3cxmPMMgWrb3gjIiGP1jjM3rrUvt41W75ugVjlE2iPTonB6echVdUUYLXd/i1w
         CzyNqeB6UVvvRvT64jZDITViRmOgptfqxyVTnHQF/AsbYy7OXpjNEzfkeTq/Mw7dqcS6
         Gxu26SEr84faLHUUPvViGVb6ZrKrw7sI3Ilfyxsc7Rn4+DNP+RPkODz29P6Z06kC524A
         98ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697088762; x=1697693562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpxBQaO4qfoGflil25goGHyuZSnLmDAmWHbFFp9AoIw=;
        b=DVf02CFOgUmUWvZmyFS3DbK3oM72HkqAUtNxWLm0cOch/4F1TFyfs7FC9jCNdJcQaP
         4SzdjgjoBj3sT2Q0TJ+BBo/ejT43fu/GZtvOOC86pzpGdLZ8kuKr1bsL3CrNBkFfGJPA
         5NPNuzN04waaRtMwakjmD3XnXWcSrFDjRR01WH46p8z+7aTJ6z1W3xOpvAotyvzIpUdL
         XrjFaFiSU3CW2mZNXCVNgYjqX3Il6m5JpcpVJlK8JsuTpusB/BRKTQnJL+Lr7hCepSek
         p3MNF0sxV1P9F5ak7ZJRw47HrxeUwb8LM3MBQcZ2yGqaMyok2HtEaqNv6FGqDZRuITP/
         ItUg==
X-Gm-Message-State: AOJu0YxTw0lCElVQL6mFsZ/cbtZcbp16PEf2b30/AQnUBsSLpPwxr/LV
        Ulj5qmtcA3+P2FIu25SJWojjq4l+P52ZaPNTLFc=
X-Google-Smtp-Source: AGHT+IEUxfmRyfaDIMUXl7kY6lePGVdseECcIJR3pgKXsAdgguiZvMMB+KBT0L29Xj4Wa9RURfsIayPgIvSl/M335LY=
X-Received: by 2002:a17:90a:788e:b0:276:ae0f:57c0 with SMTP id
 x14-20020a17090a788e00b00276ae0f57c0mr20118954pjk.19.1697088762033; Wed, 11
 Oct 2023 22:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231011152424.6957-1-isokenjune@gmail.com> <20231011152424.6957-2-isokenjune@gmail.com>
 <06bc7b39-ed70-460f-b6f1-47a0c94c0538@gmail.com>
In-Reply-To: <06bc7b39-ed70-460f-b6f1-47a0c94c0538@gmail.com>
From:   Isoken Ibizugbe <isokenjune@gmail.com>
Date:   Thu, 12 Oct 2023 06:31:14 +0100
Message-ID: <CAJHH8bHNsN4BVqG8n0SDn6WkpWdgt7C0=Bbtf91usKZ1G+nCpg@mail.gmail.com>
Subject: Re: [PATCH 1/1] branch.c: ammend error messages for die()
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 7:05=E2=80=AFPM Rub=C3=A9n Justo <rjusto@gmail.com>=
 wrote:
>
> On 11-oct-2023 16:24:20, Isoken June Ibizugbe wrote:
>
> Hi Isoken,
>
> > Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
> > ---
> >  builtin/branch.c | 38 +++++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > index 2ec190b14a..a756543d64 100644
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -518,11 +518,11 @@ static void reject_rebase_or_bisect_branch(struct=
 worktree **worktrees,
> >                       continue;
> >
> >               if (is_worktree_being_rebased(wt, target))
> > -                     die(_("Branch %s is being rebased at %s"),
> > +                     die(_("branch %s is being rebased at %s"),
>
> OK.
>
> >                           target, wt->path);
> >
> >               if (is_worktree_being_bisected(wt, target))
> > -                     die(_("Branch %s is being bisected at %s"),
> > +                     die(_("branch %s is being bisected at %s"),
>
> OK.
>
> >                           target, wt->path);
> >       }
> >  }
> > @@ -578,7 +578,7 @@ static void copy_or_rename_branch(const char *oldna=
me, const char *newname, int
> >               if (ref_exists(oldref.buf))
> >                       recovery =3D 1;
> >               else
> > -                     die(_("Invalid branch name: '%s'"), oldname);
> > +                     die(_("invalid branch name: '%s'"), oldname);
>
> OK.
>
> >       }
> >
> >       for (int i =3D 0; worktrees[i]; i++) {
> > @@ -594,9 +594,9 @@ static void copy_or_rename_branch(const char *oldna=
me, const char *newname, int
> >
> >       if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf=
)) {
> >               if (oldref_usage & IS_HEAD)
> > -                     die(_("No commit on branch '%s' yet."), oldname);
> > +                     die(_("no commit on branch '%s' yet"), oldname);
> >               else
> > -                     die(_("No branch named '%s'."), oldname);
> > +                     die(_("no branch named '%s'"), oldname);
>
> OK. Both.
>
> >       }
> >
> >       /*
> > @@ -624,9 +624,9 @@ static void copy_or_rename_branch(const char *oldna=
me, const char *newname, int
> >
> >       if (!copy && !(oldref_usage & IS_ORPHAN) &&
> >           rename_ref(oldref.buf, newref.buf, logmsg.buf))
> > -             die(_("Branch rename failed"));
> > +             die(_("branch rename failed"));
> >       if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf)=
)
> > -             die(_("Branch copy failed"));
> > +             die(_("branch copy failed"));
>
> Ditto
>
> >
> >       if (recovery) {
> >               if (copy)
> > @@ -640,16 +640,16 @@ static void copy_or_rename_branch(const char *old=
name, const char *newname, int
> >       if (!copy && (oldref_usage & IS_HEAD) &&
> >           replace_each_worktree_head_symref(worktrees, oldref.buf, newr=
ef.buf,
> >                                             logmsg.buf))
> > -             die(_("Branch renamed to %s, but HEAD is not updated!"), =
newname);
> > +             die(_("branch renamed to %s, but HEAD is not updated!"), =
newname);
>
> IMO we can go further here and also remove that final "!".  But it's OK
> the way you have done it.
>
> >
> >       strbuf_release(&logmsg);
> >
> >       strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
> >       strbuf_addf(&newsection, "branch.%s", interpreted_newname);
> >       if (!copy && git_config_rename_section(oldsection.buf, newsection=
.buf) < 0)
> > -             die(_("Branch is renamed, but update of config-file faile=
d"));
> > +             die(_("branch is renamed, but update of config-file faile=
d"));
> >       if (copy && strcmp(interpreted_oldname, interpreted_newname) && g=
it_config_copy_section(oldsection.buf, newsection.buf) < 0)
> > -             die(_("Branch is copied, but update of config-file failed=
"));
> > +             die(_("branch is copied, but update of config-file failed=
"));
>
> OK, both.
>
> >       strbuf_release(&oldref);
> >       strbuf_release(&newref);
> >       strbuf_release(&oldsection);
> > @@ -773,7 +773,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
> >
> >       head =3D resolve_refdup("HEAD", 0, &head_oid, NULL);
> >       if (!head)
> > -             die(_("Failed to resolve HEAD as a valid ref."));
> > +             die(_("failed to resolve HEAD as a valid ref"));
>
> OK.
>
> >       if (!strcmp(head, "HEAD"))
> >               filter.detached =3D 1;
> >       else if (!skip_prefix(head, "refs/heads/", &head))
> > @@ -866,7 +866,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
> >
> >               if (!argc) {
> >                       if (filter.detached)
> > -                             die(_("Cannot give description to detache=
d HEAD"));
> > +                             die(_("cannot give description to detache=
d HEAD"));
>
> OK.
>
> >                       branch_name =3D head;
> >               } else if (argc =3D=3D 1) {
> >                       strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH=
_LOCAL);
> > @@ -892,7 +892,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
> >               if (!argc)
> >                       die(_("branch name required"));
> >               else if ((argc =3D=3D 1) && filter.detached)
> > -                     die(copy? _("cannot copy the current branch while=
 not on any.")
> > +                     die(copy? _("cannot copy the current branch while=
 not on any")
> >                               : _("cannot rename the current branch whi=
le not on any."));
>
> OK.  But I think you want to modify also the second message, to remove
> its full stop as well.
>
> >               else if (argc =3D=3D 1)
> >                       copy_or_rename_branch(head, argv[0], copy, copy +=
 rename > 1);
> > @@ -916,14 +916,14 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
> >               if (!branch) {
> >                       if (!argc || !strcmp(argv[0], "HEAD"))
> >                               die(_("could not set upstream of HEAD to =
%s when "
> > -                                   "it does not point to any branch.")=
,
> > +                                   "it does not point to any branch"),
>
> OK.
>
> >                                   new_upstream);
> >                       die(_("no such branch '%s'"), argv[0]);
> >               }
> >
> >               if (!ref_exists(branch->refname)) {
> >                       if (!argc || branch_checked_out(branch->refname))
> > -                             die(_("No commit on branch '%s' yet."), b=
ranch->name);
> > +                             die(_("no commit on branch '%s' yet"), br=
anch->name);
>
> OK.
>
> >                       die(_("branch '%s' does not exist"), branch->name=
);
> >               }
> >
> > @@ -946,12 +946,12 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
> >               if (!branch) {
> >                       if (!argc || !strcmp(argv[0], "HEAD"))
> >                               die(_("could not unset upstream of HEAD w=
hen "
> > -                                   "it does not point to any branch.")=
);
> > +                                   "it does not point to any branch"))=
;
> >                       die(_("no such branch '%s'"), argv[0]);
> >               }
> >
> >               if (!branch_has_merge_config(branch))
> > -                     die(_("Branch '%s' has no upstream information"),=
 branch->name);
> > +                     die(_("branch '%s' has no upstream information"),=
 branch->name);
>
> OK, both.
>
> >
> >               strbuf_reset(&buf);
> >               strbuf_addf(&buf, "branch.%s.remote", branch->name);
> > @@ -965,11 +965,11 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
> >               const char *start_name =3D argc =3D=3D 2 ? argv[1] : head=
;
> >
> >               if (filter.kind !=3D FILTER_REFS_BRANCHES)
> > -                     die(_("The -a, and -r, options to 'git branch' do=
 not take a branch name.\n"
> > +                     die(_("the -a, and -r, options to 'git branch' do=
 not take a branch name\n"
> >                                 "Did you mean to use: -a|-r --list <pat=
tern>?"));
>
> Good; the full stop removed and here that question mark is valuable.  And=
 ...
>
> >
> >               if (track =3D=3D BRANCH_TRACK_OVERRIDE)
> > -                     die(_("the '--set-upstream' option is no longer s=
upported. Please use '--track' or '--set-upstream-to' instead."));
> > +                     die(_("the '--set-upstream' option is no longer s=
upported. Please use '--track' or '--set-upstream-to' instead"));
>
> also good.  But since we're here, maybe we can break this long message, r=
emove
> the first full stop and leave the second part of the message as is, as a
> suggestion.  Like we do in the previous message, above.
>
> For your consideration, I mean something like:
>
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -969,7 +969,8 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>                                   "Did you mean to use: -a|-r --list <pat=
tern>?"));
>
>                 if (track =3D=3D BRANCH_TRACK_OVERRIDE)
> -                       die(_("the '--set-upstream' option is no longer s=
upported. Please use '--track' or '--set-upstream-to' instead."));
> +                       die(_("the '--set-upstream' option is no longer s=
upported\n"
> +                             "Please use '--track' or '--set-upstream-to=
' instead."));
>
>
> >
> >               if (recurse_submodules) {
> >                       create_branches_recursively(the_repository, branc=
h_name,
> > --
> > 2.42.0.325.g3a06386e31
> >
>
> One final comment, leaving aside my suggestions; this changes break
> some tests that you need to adjust.  Try:
>
>    $ make && (cd t; ./t3200-branch.sh -vi)
>
> Or, as Junio has already suggested in another message:
>
>    $ make test
>
> I have some unfinished work that you might find useful:
>
> https://lore.kernel.org/git/eb3c689e-efeb-4468-a10f-dd32bc0ee37b@gmail.co=
m/
Thanks for the review. I'll make the requested changes and provide an
update. I'll also make sure to run the tests you suggested and make
the necessary changes.
>
> Thank you for working on this.
