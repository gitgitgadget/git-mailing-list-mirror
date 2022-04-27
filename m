Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F8AC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 15:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbiD0PmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbiD0PmK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 11:42:10 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6533365
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 08:38:57 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id m14so2054104vsp.11
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BvEZxzA8p5PeZOg6xpsm97nc6UKAhCqsDIBPq+uu+A0=;
        b=NjmVUW84Hy36/TkKO5jcrrnKd4OjNNJRp2pAzD0vCxPKAWt6d7KYAMNY1EjNbPpver
         /2QwMMrhkntGgzDbj4ZjkyIfl+WdkP9Hpz4dHe3BLdcHdkn99loQadQK4uQqeqpedqhr
         IcX7gUZXCnc/erco+KEc+mlVR6Q9p6Kh0i34BlqukE3mbuGAHYgvctxPEdMTlnCmaPTM
         hF3WS61YyYI7XGvQtH4UdjG4nj6uqaODXBw2eV8Pmx7LJuX8ZHuPqY5PjKuLenQcIlbg
         n/Cam4xlOFhsXaVv+fVtsp3HsiFmFyS154RONbUkrJfqIRZG59qbkqtnKpZxnvyRX7ZO
         Z16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BvEZxzA8p5PeZOg6xpsm97nc6UKAhCqsDIBPq+uu+A0=;
        b=OJJ3i8lkhrX6ksps3EB75PR0qJt8LHpW6XeoLt7hPDlQVXowKnQyVmCoMkXzqFdlBr
         3mP6oFoOoiPkVWdDzvUbJOpZjuR2EVhWf0VOco8f42puko9lbCw8jRzoqZ8ZVrZ482Ko
         CRQii2I+ajPn06F6oYT5W95ABn6HthuKYDDPzDEsjFLWF2sfQkhapvaY0oT0CckXrgD4
         qwlkD5toFff/aZmZeGxWlNkC9kd/cUIu+By/wIk2RkBX13plUj71/5L0Ll4oDbdzoL6a
         ydmc+rDWJJ+uqH0WKqcyzHJrYyQj4KofQMwsGpDAr3xLtXmdEnVEIfrV9y2hIV3ynriD
         PPwQ==
X-Gm-Message-State: AOAM532c303gYpjAe6XS9D+sOprYPrzFlOciqFa+B0NUROF8JfbeoLaq
        xs3U2rYl/G+a8W9FSrsB+q4azvW3xw2BT0jKUkk=
X-Google-Smtp-Source: ABdhPJwb3k1ClagaFVYrlKjCXKhOd1XbWK6lmVAaeGR4A4/PYnwJCrhlRA7p3tEhdKiyPbwU5MUuebrzEjMC/YW1hLY=
X-Received: by 2002:a67:1a02:0:b0:320:a51f:8067 with SMTP id
 a2-20020a671a02000000b00320a51f8067mr9149420vsa.38.1651073936869; Wed, 27 Apr
 2022 08:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
In-Reply-To: <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 08:38:46 -0700
Message-ID: <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 2:33 AM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
> On 27/04/2022 01:05, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 58fd813bd01..9bb0eb5087a 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -437,12 +437,48 @@ static inline int git_offset_1st_component(const =
char *path)
> >   #endif
> >
> >   #ifndef is_path_owned_by_current_user
> > +
> > +#ifdef __TANDEM
> > +#define ROOT_UID 65535
> > +#else
> > +#define ROOT_UID 0
> > +#endif
> > +
> > +/*
> > + * this helper function overrides a ROOT_UID with the one provided by
> > + * an environment variable, do not use unless the original uid is
> > + * root
> > + */
> > +static inline int extract_id_from_env(const char *env, uid_t *id)
>
> Do we really want this living in git-compat-util.h?

No; but IMHO the same applies to is_path_owned_by_current_uid(), and
as I mentioned in my original proposal refactoring this code to do so
has been punted until later since the objective here was to keep the
change as small as possible for clean backporting.

My intention with that comment was not only to warn people that might
want to reuse that helper but to indicate it was just a hack that
should be refactored ASAP.

FWIW, I still think that using atoi with a check to skip "" is
probably as safe as doing all this extra checking as no one has shown
yet a system where sizeof(uid_t) > sizeof(uint32_t), but agree with
Junio that using long instead avoids issues with the systems where
sizeof(uid_t) > sizeof(int) and unless sizeof(int) =3D=3D sizeof(long)
(ex: 32-bit Linux) which is then covered by the cast.

> > +{
> > +     const char *real_uid =3D getenv(env);
> > +
> > +     if (real_uid && *real_uid) {
> > +             char *error;
> > +             long extracted_id =3D strtol(real_uid, &error, 10);
> > +             if (!*error && LONG_MIN < extracted_id &&
> > +                             extracted_id < LONG_MAX) {
>
> strtol() returns a long so the last two checks are redundant.

The last two checks were to check for underflow or overflow and to
make sure that the bogus values this function returns in case of those
errors are not taken into consideration.

>The standard is silent on what happens to error when the value is out of
> range.

Which is why instead I was avoiding LONG_{MIN,MAX} which are
described[1] as the bogus values that will be used in that case
Agree with you that we could also add a check for >=3D0 as uid_t is
usually unsigned, but it is not warranted to be so, and that is I was
aiming for the wider possible range so we don't have to worry that
much and let it be settled to a valid value through the cast.

Carlo

[1] https://pubs.opengroup.org/onlinepubs/007904875/functions/strtol.html
