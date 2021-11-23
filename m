Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE2CC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 00:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhKWAir (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWAiq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 19:38:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584EEC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:35:39 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so39976048eds.10
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JQUf+JPbSfWlJhnO18qHLRjAOmrBYYmBsuHlnktUrP4=;
        b=h5SFLfncOQWiHNtRWElN2SH8KVRifGY1zBZylGjT/4SeJmSx/LbegS43ZLeqkYVfLR
         sSlGS1q7utZk9cEY8T+mw3KsXq09tlmlwqstWrVle9H+j850feuB0X/08CafHBBzprc9
         +vKGBb0KnQpk8uQ0AZ9ne4x2dF88/dJ59VOvCKZOb67sy8NQiufM1GMpA4SqSjE6dRTE
         8JXV9WQNYBO4BTyOlUGT73dUazpgTWrEtogsBsL9oRD5YxKYJQqcNGE5w2n6SiGvf4m5
         P20XMQonyqaaGkyFx5Sr0GJ7X1xNK2oWppjkvOj8LCVbK3Q+KF43QuM5j7N535ShXXJr
         Ms/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JQUf+JPbSfWlJhnO18qHLRjAOmrBYYmBsuHlnktUrP4=;
        b=PZoymINk7+ilk/QYsC0lg1oJn1DzSkJ7C6MUZe1LEG2asw5Y+PThiUYawPXvXli7og
         7/AIIYmCAaAJSXze33OZ13iPJ1KYGGRq822ZeKXLRWARbc3jp+BG1F/86TAxOiQ62K54
         qHva7Z4dwGgv7mrf9C3TB5Vdu1bzyidMgZGmnddWqztzCPC7vzSEIc48fQ4zp3FBPyc7
         8FHppkG6D+JbVBr1mDs/ASOXycXXssbwt2GrbW5oXADGXN8ULRh0al6Nrb5uvffcylkA
         kqVM1VLIjCtZBHwqT3tyJ71KA4+k9RVM/wsMKthToVjQDCMaOi0yHG1acw0+/EYVzSVJ
         M9Kw==
X-Gm-Message-State: AOAM531u1/Wpau71MTX6+XG7N+bs/U5DxEUOQtEC847uquPpAVjypbBO
        U5VYNao9MFEsChPBORFBrPSBhTvqLgQqOSkdMeg=
X-Google-Smtp-Source: ABdhPJxTrJmpVjiEE8p1sz9YwEExHmPGL7G+aGBS84MB0re5sYnyAOtXgmd6HfCMUAapx6hKUMJpwsvBQQ13ftbP52o=
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr2015490ejf.341.1637627737883;
 Mon, 22 Nov 2021 16:35:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <8a69d2878c99e1b9321e57073d266cf797dc5630.1637455620.git.gitgitgadget@gmail.com>
 <150f9c88-f175-963d-2947-7ae9f3a2ef12@web.de>
In-Reply-To: <150f9c88-f175-963d-2947-7ae9f3a2ef12@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 16:35:26 -0800
Message-ID: <CABPp-BF4WtoRig=TUQa76G1sfG3uOiEZw5vk7cGbDtJNahhgnw@mail.gmail.com>
Subject: Re: [PATCH 5/8] symlinks: do not include current working directory in
 dir removal
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 12:56 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 21.11.21 um 01:46 schrieb Elijah Newren via GitGitGadget:
> > From: Elijah Newren <newren@gmail.com>
> >
> > symlinks has a pair of schedule_dir_for_removal() and
> > remove_scheduled_dirs() functions that ensure that directories made
> > empty by removing other files also themselves get removed.  However, we
> > want to exclude the current working directory and leave it around so
> > that subsequent git commands (and non-git commands) that the user runs
> > afterwards don't cause the user to get confused.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  symlinks.c           | 12 +++++++++++-
> >  t/t2501-cwd-empty.sh | 12 ++++++------
> >  2 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/symlinks.c b/symlinks.c
> > index 5232d02020c..84622bedcde 100644
> > --- a/symlinks.c
> > +++ b/symlinks.c
> > @@ -275,11 +275,18 @@ static int threaded_has_dirs_only_path(struct cac=
he_def *cache, const char *name
> >
> >  static struct strbuf removal =3D STRBUF_INIT;
> >
> > +static int cant_remove(char *dirname)
> > +{
> > +     if (the_cwd && !strcmp(dirname, the_cwd))
>
> Initializing the_cwd to an empty string would allow removing the NULL che=
ck
> everywhere.

I actually went and made this change, because although it'd add
protection to the toplevel directory (the_cwd is relative to the
toplevel), we usually want it protected.  However, dir.c's
remove_dir_recursively() can be used to remove the toplevel directory
as well and has an explicit flag for that, so I need to be able to
distinguish between uninitialized and explicitly set to the toplevel
directory.

> Is strcmp() sufficient or do we need fspathcmp() in these kinds of checks=
?
> Do we need to worry about normalizing directory separators?

Good catch, I should normalize the_cwd when I create it; I was
essentially creating it to match "prefix", but it appears that isn't
pre-emptively normalized, and instead later callers normalize any
combination of prefix plus another path.

> > +             return 1;
> > +     return rmdir(dirname);
> > +}
>
> I wouldn't expect a function of that name to actually try to remove
> the directory.  Or with that body to require a non-const dirname.
> It's used only once, perhaps inline it?

Sure.

> > +
> >  static void do_remove_scheduled_dirs(int new_len)
> >  {
> >       while (removal.len > new_len) {
> >               removal.buf[removal.len] =3D '\0';
> > -             if (rmdir(removal.buf))
> > +             if (cant_remove(removal.buf))
> >                       break;
> >               do {
> >                       removal.len--;
> > @@ -293,6 +300,9 @@ void schedule_dir_for_removal(const char *name, int=
 len)
> >  {
> >       int match_len, last_slash, i, previous_slash;
> >
> > +     if (the_cwd && !strcmp(name, the_cwd))
> > +             return; /* Do not remove the current working directory */
> > +
> >       match_len =3D last_slash =3D i =3D
> >               longest_path_match(name, len, removal.buf, removal.len,
> >                                  &previous_slash);
