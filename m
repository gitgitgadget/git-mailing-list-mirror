Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C4EC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiBPQbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:31:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiBPQbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:31:09 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959842AED8A
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:30:55 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p14so450968ejf.11
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k+sdNVR3qvwZ+O4e8iDzCsA+VsVZ7bLQ/TZHAJW1F+0=;
        b=Da3JgUQ4d2v6Kpj7HF/UyecVp7IAUrN/6LEdsDxXiHd7AreduNL5s8Gjrp1H4XzotP
         JkbtMYUUCXAC9syg+Zlpv0JobFSk6/sc2MZEKbTtYvrmbVlvX/2pzsKkeQ/hTdWMZL77
         3I0Yc1DQjI486aLWDUMyYHJPBdrFF5oSraiwHXnOfY9AjRuup1s903+skgG4/c+4ARXf
         WiSVeAApI/x7ZTKyAs7cMc6IMSKiikfHu7o2zU+yRvUYmsrz1TarwRjJAGgABmJzG1ms
         Tka63W1HnGSLikQSVyMXiGmX9Ead/NnXyh+PcA/8qYos4k4ipvAJUOpq8pMrD8tuBulj
         RhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k+sdNVR3qvwZ+O4e8iDzCsA+VsVZ7bLQ/TZHAJW1F+0=;
        b=vvgbx/P0a+J130wkQsFRLPi09Hrsr0p6EG8RFSG1EMq5H1QOmeSLzSZb/Px5fXJdYy
         9mL1SqRfCUV5f8FlFjfczO0GjEQvgeBnWmBogtPb7uEiksObqrgAlzjzHYRB+Ami5eZ3
         oHduIxUeXspRwW7dhGIVhjErLz670My/qJB5KgV75LlgX+jNnQob61m4DeP1pXuUsgj1
         8e7AhiDqKjoWwK2km8gOVYEZYc0e0hbTBYl9/UDOcCRMAy7XF8BzLZkbKjn8LULSmMpJ
         0BdoOMCwXgLpTO4KkcPmKLwb4l6kn8pqtVB54rRFx8MdNpcIgfV+y8S+dSVfpmuHuiUp
         h/zg==
X-Gm-Message-State: AOAM5307YWWlSe9O2akRRE9q1bT94p3lXv3rtmn74TjOe9kSs66LCD9H
        BkzLHid6lCAo6KzDHju77XJy7S8P8Mg/4CUYmNZymt/CybM=
X-Google-Smtp-Source: ABdhPJwSfJraVZ6m+3qX565QT+17QrcbsFyao5S83rKPXawiiQJtr5Y+1gUrQ+WRZO/K7icu13vqspr/UtYzelNAgwE=
X-Received: by 2002:a17:906:350d:b0:6b9:5871:8f34 with SMTP id
 r13-20020a170906350d00b006b958718f34mr2927581eja.493.1645029054066; Wed, 16
 Feb 2022 08:30:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com> <05ac964e630a2e72eebaa1818a8807cd7a7d4f7e.1642175983.git.gitgitgadget@gmail.com>
 <220216.86fsojup82.gmgdl@evledraar.gmail.com>
In-Reply-To: <220216.86fsojup82.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 08:30:42 -0800
Message-ID: <CABPp-BEog_CBEjx3FBGdUAhjwrPPDuP54HWQssAWnGeUnr0cBg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Accelerate clear_skip_worktree_from_present_files()
 by caching
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 1:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jan 14 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> > [...]
> > +static int path_found(const char *path, const char **dirname, size_t *=
dir_len,
> > +                   int *dir_found)
> > +{
> > +     struct stat st;
> > +     char *newdir;
> > +     char *tmp;
> > +
> > +     /*
> > +      * If dirname corresponds to a directory that doesn't exist, and =
this
> > +      * path starts with dirname, then path can't exist.
> > +      */
> > +     if (!*dir_found && !memcmp(path, *dirname, *dir_len))
> > +             return 0;
> > +
> > +     /*
> > +      * If path itself exists, return 1.
> > +      */
> > +     if (!lstat(path, &st))
> > +             return 1;
> > +
> > +     /*
> > +      * Otherwise, path does not exist so we'll return 0...but we'll f=
irst
> > +      * determine some info about its parent directory so we can avoid
> > +      * lstat calls for future cache entries.
> > +      */
> > +     newdir =3D strrchr(path, '/');
> > +     if (!newdir)
> > +             return 0; /* Didn't find a parent dir; just return 0 now.=
 */
> > +
> > +     /*
> > +      * If path starts with directory (which we already lstat'ed and f=
ound),
> > +      * then no need to lstat parent directory again.
> > +      */
> > +     if (*dir_found && *dirname && memcmp(path, *dirname, *dir_len))
> > +             return 0;
>
> I really don't care/just asking, but there was a discussion on another
> topic about guarding calls to the mem*() family when n=3D0:
> https://lore.kernel.org/git/xmqq1r24gsph.fsf@gitster.g/
>
> Is this the same sort of redundancy where we could lose the "&&
> *dirname" part, or is it still important because a "\0" dirname would
> have corresponding non-0 *dir_len?

No, dirname is a char**, not a char*.  I need to make sure *dirname is
non-NULL before passing to memcmp or we get segfaults (and *dirname
will be NULL the first time it gets to this line, so the check is
critical).

> More generally ... (see below)...
>
> > +
> > +     /* Free previous dirname, and cache path's dirname */
> > +     *dirname =3D path;
> > +     *dir_len =3D newdir - path + 1;
> > +
> > +     tmp =3D xstrndup(path, *dir_len);
> > +     *dir_found =3D !lstat(tmp, &st);
>
> In most other places we're a bit more careful about lstat() error handlin=
g, e.g.:
>
>     builtin/init-db.c:              if (lstat(path->buf, &st_git)) {
>     builtin/init-db.c-                      if (errno !=3D ENOENT)
>     builtin/init-db.c-                              die_errno(_("cannot s=
tat '%s'"), path->buf);
>     builtin/init-db.c-              }
>
> Shouldn't we do the same here and at least error() on return values of
> -1 with an accompanying errno that isn't ENOENT?

If we should do that everywhere, should we have an xlstat in wrapper.[ch]?

> > +     free(tmp);
> > +
> > +     return 0;
> > +}
> > +
> >  void clear_skip_worktree_from_present_files(struct index_state *istate=
)
> >  {
> > +     const char *last_dirname =3D NULL;
> > +     size_t dir_len =3D 0;
> > +     int dir_found =3D 1;
> > +
> >       int i;
> > +
> >       if (!core_apply_sparse_checkout)
> >               return;
> >
> >  restart:
> >       for (i =3D 0; i < istate->cache_nr; i++) {
> >               struct cache_entry *ce =3D istate->cache[i];
> > -             struct stat st;
> >
> > -             if (ce_skip_worktree(ce) && !lstat(ce->name, &st)) {
> > +             if (ce_skip_worktree(ce) &&
> > +                 path_found(ce->name, &last_dirname, &dir_len, &dir_fo=
und)) {
>
> ...(continued from above) is the "path is zero" part of this even
> reachable? I tried with this on top and ran your tests (and the rest of
> t*sparse*.sh) successfully:
>
>         diff --git a/sparse-index.c b/sparse-index.c
>         index eed170cd8f7..f89c944d8cd 100644
>         --- a/sparse-index.c
>         +++ b/sparse-index.c
>         @@ -403,6 +403,7 @@ void clear_skip_worktree_from_present_files(s=
truct index_state *istate)
>                 for (i =3D 0; i < istate->cache_nr; i++) {
>                         struct cache_entry *ce =3D istate->cache[i];
>
>         +               assert(*ce->name);
>                         if (ce_skip_worktree(ce) &&
>                             path_found(ce->name, &last_dirname, &dir_len,=
 &dir_found)) {
>                                 if (S_ISSPARSEDIR(ce->ce_mode)) {
>
> I.e. isn't this undue paranoia about the cache API giving us zero-length
> paths?

Nope, not related at all, for two reasons: the code above was checking
for NULL pointers rather than NUL characters, and the argument I was
checking was last_dirname, not ce->name.
