Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E342C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 03:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiGADDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 23:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiGADDo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 23:03:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47125220FC
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 20:03:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e2so1296509edv.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GDkZtJMU997v4ep7NKWe+NfRWM88Ib100CRrJFYoqQ0=;
        b=Mi5b0UK+UC4OKOx9iuRTYUqsvOzCzN1lVoqxyzfRe6uMEAKKO7cIuHGZFhUy792d0J
         aURhHHhHwAJ4kxW3YFsuz/iXAwSW+3mA5uTB2HPEV1njtslNgGAXarpoLAlHc4ZbaeWd
         Kta8l8HufmX2fgxc70mXtq49AAi6Li/Qm2lMS8+WcxyJGCci5qum53gEskY02zdY0jmo
         aISakSzW7y9J8iFgHT7Rj6oXLTsTj/a39PoS0lEWrYr2SN8hyEsixLQe04vCNJVukcYf
         HV3Lcc4ZuC+YtrwBVPCSbCQB4nOL92ZBlxmZstKutSJTenCGb+DMuZhMv53Hp+c4A7fz
         G5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GDkZtJMU997v4ep7NKWe+NfRWM88Ib100CRrJFYoqQ0=;
        b=kqAQwWoCTGHz/KPdO3mooc32P8dBSVIJ1b0eI80odwXQUJL5vszfB+gl5ISaffT34A
         yoUTw4MloTXgXPG6JJlI1nzNaH31Fc+UmWXjcAaHPiQBiY6tbj5SHix865C3uNe5dXiV
         A+pnVZTdrDC9JzOjEbsc9XrhlaDeiEmvfFJ0pZXwly4/uC9qMiOwIxbGEwq1pi1hOwWN
         8N9+fM7EHZFWxyr1qg2gvn1435XFOCQsqYIzjqr1BZWqwoN2/uZt+fC3sjSGDsd8dzHm
         Z9xs7vMAPqfRRSFtBMm27U0qZUQacgai8P4vJpF9gig3IiKMCKMmrHAUzre4E7BR82rP
         wOaA==
X-Gm-Message-State: AJIora+mYeKJL7Y2U3rnuCblA2M8txuLj6ztL/rsc5wKa1Tm7UwGF4ax
        QpTIoqSbOZsCR8jhX7UU+18efUFEl/m495+ULcM=
X-Google-Smtp-Source: AGRyM1tn/Xe/O/JTT36WHmkZ8PT/nUufJY8A4psjWoSf1deUl91+m7RZeNRIvWVQkYNT04AguxttjEF8LkgOKQl3NgE=
X-Received: by 2002:a05:6402:27cf:b0:435:dae6:26aa with SMTP id
 c15-20020a05640227cf00b00435dae626aamr15693204ede.323.1656644621824; Thu, 30
 Jun 2022 20:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
 <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com> <da3ae38e390df8acf86e910389d1620569a95a87.1656572226.git.gitgitgadget@gmail.com>
 <220630.86letee8mz.gmgdl@evledraar.gmail.com>
In-Reply-To: <220630.86letee8mz.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jun 2022 20:03:30 -0700
Message-ID: <CABPp-BHmuDx0+JBbar3jZRWFxFruaxSWkohy=BzOsqBUZENyvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] merge-ort: fix issue with dual rename and add/add conflict
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 3:41 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jun 30 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > There is code in both merge-recursive and merge-ort for avoiding doubly
> > transitive renames (i.e. one side renames directory A/ -> B/, and the
> > other side renames directory B/ -> C/), because this combination would
> > otherwise make a mess for new files added to A/ on the first side and
> > wondering which directory they end up in -- especially if there were
> > even more renames such as the first side renaming C/ -> D/.  In such
> > cases, it just turns "off" directory rename detection for the higher
> > order transitive cases.
> >
> > The testcases added in t6423 a couple commits ago are slightly differen=
t
> > but similar in principle.  They involve a similar case of paired
> > renaming but instead of A/ -> B/ and B/ -> C/, the second side renames
> > a leading directory of B/ to C/.  And both sides add a new file
> > somewhere under the directory that the other side will rename.  While
> > the new files added start within different directories and thus could
> > logically end up within different directories, it is weird for a file
> > on one side to end up where the other one started and not move along
> > with it.  So, let's just turn off directory rename detection in this
> > case as well.
> >
> > Another way to look at this is that if the source name involved in a
> > directory rename on one side is the target name of a directory rename
> > operation for a file from the other side, then we avoid the doubly
> > transitive rename.  (More concretely, if a directory rename on side D
> > wants to rename a file on side E from OLD_NAME -> NEW_NAME, and side D
> > already had a file named NEW_NAME, and a directory rename on side E
> > wants to rename side D's NEW_NAME -> NEWER_NAME, then we turn off the
> > directory rename detection for NEW_NAME to prevent the
> > NEW_NAME -> NEWER_NAME rename, and instead end up with an add/add
> > conflict on NEW_NAME.)
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c                         | 7 +++++++
> >  t/t6423-merge-rename-directories.sh | 4 ++--
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index fa6667de18c..17db4c30e5b 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -2292,9 +2292,16 @@ static char *check_for_directory_rename(struct m=
erge_options *opt,
> >       struct strmap_entry *rename_info;
> >       struct strmap_entry *otherinfo =3D NULL;
> >       const char *new_dir;
> > +     int other_side =3D 3 - side_index;
> >
> > +     /*
> > +      * Cases where we don't have or don't want a directory rename for
> > +      * this path, so we return NULL.
> > +      */
> >       if (strmap_empty(dir_renames))
> >               return new_path;
> > +     if (strmap_get(&collisions[other_side], path))
> > +             return new_path;
>
> I realize from looking at merge-recursive.c that this is carrying
> forward some legacy debt

...which was introduced by me as well...

> , but I find this code and the need for a
> comment more complex than it needs to. On top of master this will work
> just as well:
>
>         diff --git a/merge-ort.c b/merge-ort.c
>         index b5015b9afd4..f5a02b1ff6f 100644
>         --- a/merge-ort.c
>         +++ b/merge-ort.c
>         @@ -2268,16 +2268,16 @@ static char *check_for_directory_rename(s=
truct merge_options *opt,
>                                                 struct strmap *collisions=
,
>                                                 int *clean_merge)
>          {
>         -       char *new_path =3D NULL;
>         +       char *new_path;
>                 struct strmap_entry *rename_info;
>                 struct strmap_entry *otherinfo =3D NULL;
>                 const char *new_dir;
>
>                 if (strmap_empty(dir_renames))
>         -               return new_path;
>         +               return NULL;
>                 rename_info =3D check_dir_renamed(path, dir_renames);
>                 if (!rename_info)
>         -               return new_path;
>         +               return NULL;
>                 /* old_dir =3D rename_info->key; */
>                 new_dir =3D rename_info->value;

You know, while making this patch series I was asking myself, "Why
didn't I just explicitly return NULL here?"  I don't know why I did it
this way, but it now seems slightly odd to me too.  I decided to not
fix it up and just provide a more targeted fix, but since it tripped
you up, I'm happy to add this as a preparatory cleanup.

> I.e. we're really just making the reader squint to see that we're
> actually returning NULL here, it's only later that we have an actual
> "new path".
>
> Wouldn't sticking that earlier in this series be an improvement? The
> reason you need to explain "so we return NULL" is because we're carrying
> forward this oddity, but if we just don't initialize it and return NULL
> instead...

I still think the comment makes sense to add, other than the "so we
return NULL" bit, even after this change.  But yeah, we can strike the
"so we return NULL" part of it after this cleanup.

> If you want to keep this pretty much as-is I think you should add a \n
> before the (not seen in your context) "old_dir" comment seen in the
> context here above, to make it visually clear that your new comment is
> referring to these chains of returns. That could also be made clearer
> with (again, on top of master, and could be combined with the above):
>
>         diff --git a/merge-ort.c b/merge-ort.c
>         index b5015b9afd4..a418f81a3eb 100644
>         --- a/merge-ort.c
>         +++ b/merge-ort.c
>         @@ -2278,8 +2278,6 @@ static char *check_for_directory_rename(str=
uct merge_options *opt,
>                 rename_info =3D check_dir_renamed(path, dir_renames);
>                 if (!rename_info)
>                         return new_path;
>         -       /* old_dir =3D rename_info->key; */
>         -       new_dir =3D rename_info->value;
>
>                 /*
>                  * This next part is a little weird.  We do not want to d=
o an
>         @@ -2305,6 +2303,7 @@ static char *check_for_directory_rename(str=
uct merge_options *opt,
>                  * As it turns out, this also prevents N-way transient re=
name
>                  * confusion; See testcases 9c and 9d of t6043.
>                  */
>         +       new_dir =3D rename_info->value; /* old_dir =3D rename_inf=
o->key; */
>                 otherinfo =3D strmap_get_entry(dir_rename_exclusions, new=
_dir);
>                 if (otherinfo) {
>                         path_msg(opt, rename_info->key, 1,

Sure, seems fine.
