Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA4C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 14:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381599AbiFQO0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 10:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382737AbiFQO0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 10:26:37 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B39F52500
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 07:26:36 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id b13so2067198vko.4
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9P/LGyoxp7q1+FKC7Mt3zoCpT5Q54CNMGdjJ9cBqSKI=;
        b=lqa8jwqHpK1+JkFSiz4jjBdmnx8/jBCeEKGNh7r1ZnNGuUQ6sZBUztpEBgnuzniWJ0
         BtocppIlFC1bsmCX7thuCnfqf4a2eNDNDp7aObYPwVc70Jo/DEMJwdsjeEvcfuvrE+uh
         tInb34YIkwhzbL0xZpxMI4Km8MvLA96T9HIgv1+nUl/8limRP02vmYZYnqlrrVPNgZvl
         W5y0w13eev9dEMPJ2xOHoWFmX5VozEg+jYQzHqpJQB7GiASFe5f5kmcz5EK3YwWvdQ8l
         MdYqs91LgsUerprrCzIo/16lpiW1sN7bwvOMruVXu23cDsFJ1IVbzMOSFJVgm1ipYdbK
         kMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9P/LGyoxp7q1+FKC7Mt3zoCpT5Q54CNMGdjJ9cBqSKI=;
        b=mu1m7JI86qGfitCsUpFUwXB29h8d3260+zQ32xA4xfy83TVa2DgJZtz730YID5ggH7
         /v+6Wy5fbUvZeyPJAmZicl8gkqXqAlqT1fH8YEuUXK7vF5toQaBlcEXnwiIoaufAacxQ
         bb44jATYltPVRC9rlcbvfPkmH+smUS5ZFkJfP7g3iB0DRuSpHak05YBBeNloC5rnxtF2
         GRTMowyRP1+KJZc3J5XpHLgYmnIJCgmI+7MW2Hb/7JBWeMvotC7rt6OrSQOqEquuHgan
         6iiWRer5rGKjvcQdXQXvg49aTEPtI3eZJIJIMHXL59vGPXKC/IJjPojBph9uej1oQ+Dg
         sjTg==
X-Gm-Message-State: AJIora9ztfzANrfSElaE2CCMZ7JKtZ8v9B8YAbrFWKEn0CD65bniJT1Y
        9/e0Dj5q65h10CDVh6MisYJvqOaLd9FQECcTWpvNZ1xW
X-Google-Smtp-Source: AGRyM1t5XzsoZ4RzWuTT78RWbzvIXk93ZMA2TKYfHxJLl8mzR9mOXGav59Arw8/0XvX0WFsidw00kxSGYU+sQM8Jd4Q=
X-Received: by 2002:a1f:1d82:0:b0:35d:e310:b03b with SMTP id
 d124-20020a1f1d82000000b0035de310b03bmr4870300vkd.39.1655475995548; Fri, 17
 Jun 2022 07:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220510174616.18629-1-carenas@gmail.com> <20220513010020.55361-1-carenas@gmail.com>
 <20220513010020.55361-5-carenas@gmail.com> <nycvar.QRO.7.76.6.2206151557510.349@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2206151557510.349@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 17 Jun 2022 07:26:37 -0700
Message-ID: <CAPUEspgrkVywKOAQz1ffyntaAXaw6=WnNNBZRhNRBHRH8nYUHQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] git-compat-util: allow root to access both
 SUDO_UID and root owned
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 7:03 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Thu, 12 May 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index e7cbfa65c9a..0a5a4ee7a9a 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -420,9 +420,10 @@ static inline int git_offset_1st_component(const c=
har *path)
> >   * maybe provide you with a patch that would prevent this issue again
> >   * in the future.
> >   */
> > -static inline void extract_id_from_env(const char *env, uid_t *id)
> > +static inline int id_from_env_matches(const char *env, uid_t id)
>
> I agree somewhat with Gab=C3=B3r's concern that this patch tries to do to=
o many
> things at once, including this rename.
>
> We have a recent history of introducing so many regressions that `.1`
> releases have become the norm rather than the exception, and from where I
> sit, the reason is squarely with the uptick in refactoring (including
> renames like this one).
>
> So unless the refactoring is done to any other end than for refactoring's
> own sake (which is really not a good reason), I see it as problematic.

I couldn't agree more with that sentiment, but in this case the
refactoring was done to clean up the recently introduced function
which was indeed too ugly (some would say on purpose) and replacing it
with not only better looking code, but also a cleaner interface.

I would think that in this specific case an exemption could be
granted, but it is also true that while this code is almost a month
old, it hasn't got the review it will require to be merged so late in
the release cycle without raising the concerns you both fairly put
forward.

> >  {
> >       const char *real_uid =3D getenv(env);
> > +     int matches =3D 0;
> >
> >       /* discard anything empty to avoid a more complex check below */
> >       if (real_uid && *real_uid) {
> > @@ -432,9 +433,10 @@ static inline void extract_id_from_env(const char =
*env, uid_t *id)
> >               errno =3D 0;
> >               /* silent overflow errors could trigger a bug here */
> >               env_id =3D strtoul(real_uid, &endptr, 10);
> > -             if (!*endptr && !errno)
> > -                     *id =3D env_id;
> > +             if (!*endptr && !errno && (uid_t)env_id =3D=3D id)
> > +                     matches =3D 1;
> >       }
> > +     return matches;
> >  }
> >
> >  static inline int is_path_owned_by_current_uid(const char *path)
> > @@ -446,10 +448,13 @@ static inline int is_path_owned_by_current_uid(co=
nst char *path)
> >               return 0;
> >
> >       euid =3D geteuid();
> > +     if (st.st_uid =3D=3D euid)
> > +             return 1;
> > +
> >       if (euid =3D=3D ROOT_UID)
> > -             extract_id_from_env("SUDO_UID", &euid);
> > +             return id_from_env_matches("SUDO_UID", st.st_uid);
>
> A much shorter, much more obvious patch would look like this:
>
> -       if (euid =3D=3D ROOT_UID)
> +       if (st.st_uid !=3D euid && euid =3D=3D ROOT_UID && )
>                 extract_id_from_env("SUDO_UID", &euid);
>
> It accomplishes the same goal, but is eminently easier to review. For
> regression fixes, I much prefer the safety and confidence that comes with
> that.

will reroll with your suggestion, thanks again for your helpful
review, and apologies again to everyone for not cleaning it up earlier
in the cycle.

IMHO the alternative (which will be releasing with the regression)
might be worse than releasing with this version so we ought to do
something before RC1.

Carlo

Carlo
