Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C04FC33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 10:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D044A20CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 10:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3xH3J69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgAaKVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:21:22 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:38845 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgAaKVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 05:21:22 -0500
Received: by mail-io1-f47.google.com with SMTP id s24so7573849iog.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=48bwmy4t075DR59YdEYl6vtUq8qgP2toeD75Bn2e2l8=;
        b=K3xH3J69QF1Gt1MFXZ0oend4kb3BFRSfxxwnJ2Es/sP2JQaant9QyEtmg9Bx42iA+j
         ymiZkZ7iVl4ERYT5gxDdBYMh0MyH9ovCt8jGWE1+KN1Z86lHOPeltywc/H/yoDFTNo5c
         ppRVDR0rfh/SESSEbCAhPoUmre49IonaXBLc329nsEsH5PHPjKMtgGuQwZaYcTaiBrpC
         ROKvTzBQSlWxOGTE9LzO5S9ZCZ82yInZipkE1JI63QmKPkt8zvivgHvihV2Y0+W9hNvU
         G68uLcPKisu5/NCJbYdW96aZcoNQ86PFrVAURUDddmeOFRbuzE8JR6dz0B679lDYoh7e
         zmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=48bwmy4t075DR59YdEYl6vtUq8qgP2toeD75Bn2e2l8=;
        b=FOHOrrSTbQ4Qvcov7AP8fo5XBMIrzoIziZa2hThniWjCa3J6sLXjZXfitV3ML0PFMf
         LJP6Aj88j0pN0zKxk/1biGNGEXDIhQQw5j0+UNEz+Ap4/xA0KXURpMKqYij5jfCa/3H5
         KyMkqVlZczfN61bko/v+FKMnwFHwtbmfHVO2M8yqEAh5QFs3TMeVwxg6J6aD1h895YbN
         D9CmzQmztMappgqnnEH05WVU4riitOz6jLdS3QzVOyMumh1sbSKYnsh8zMlWW8XLq5lz
         F8LfXD+sk9OkjjQSJzw2f99xrHfo/nfbj9iTiWppGoLvVNu52j0j5LqJlebktAQn0Uq1
         OaRQ==
X-Gm-Message-State: APjAAAWfg4wamzmkGetf+gTDMJHjCriExuKfgX4QlQmVE8BHPUvVrjDh
        5AEj8nlCv6r0lP5jwU24guEFX0j+mvYeejZtJvrICA==
X-Received: by 2002:a5e:9417:: with SMTP id q23mt7405301ioj.188.1580466081636;
 Fri, 31 Jan 2020 02:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-10-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001301341100.46@tvgsbejvaqbjf.bet> <CAP8UFD3mhirdjHnT+XRq1mPzii3O+mtAMrYCy7mf4HKQZo8Acw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001311006360.46@tvgsbejvaqbjf.bet> <CAP8UFD2Crc2k7vdqxAaAvyLUqz5VdSfL6cfY110LHE2RpPRBKQ@mail.gmail.com>
 <CAN7CjDC7ijMDtJdShRB+P0d0GRYYrQXktdH2Og9XGDqJ-OZxzw@mail.gmail.com>
In-Reply-To: <CAN7CjDC7ijMDtJdShRB+P0d0GRYYrQXktdH2Og9XGDqJ-OZxzw@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Fri, 31 Jan 2020 11:21:10 +0100
Message-ID: <CAN7CjDD2rDKT6Ngg7Mfo4oDB5vxCGqhx-w5aGfC-f_thNMBKmQ@mail.gmail.com>
Subject: Fwd: [PATCH v2 09/11] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El vie., 31 ene. 2020 a las 10:15, Christian Couder
(<christian.couder@gmail.com>) escribi=C3=B3:
>
> Hi Dscho,
>
> On Fri, Jan 31, 2020 at 10:07 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 30 Jan 2020, Christian Couder wrote:
> >
> > > On Thu, Jan 30, 2020 at 2:46 PM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > On Tue, 28 Jan 2020, Miriam Rubio wrote:
> > >
> > > > > +             /* Create file BISECT_ANCESTORS_OK. */
> > > > > +             fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY,=
 0600);
> > > > > +             if (fd < 0)
> > > > > +                     warning_errno(_("could not create file '%s'=
"),
> > > > > +                                   filename);
> > > > > +             else
> > > > > +                     close(fd);
> > > > > +     }
> > > >
> > > > I wonder whether this would be easier to read:
> > > >
> > > >         if (res =3D=3D -11)
> > > >                 res =3D 0;
> > > >         else if (res)
> > > >                 ; /* error out */
> > > >         else if ((fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONL=
Y, 0600)) < 0)
> > > >                 res =3D warning_errno(_("could not create file '%s'=
"), filename);
> > > >         else
> > > >                 close(fd);
> > > >
> > > > Note: my code explicitly assigns `res =3D -1` if the file could not=
 be
> > > > created, which is technically a change in behavior, but I think it =
is
> > > > actually a bug fix.
> > >
> > > I don't think so. I think creating the BISECT_ANCESTORS_OK file is no=
t
> > > absolutely necessary. If it doesn't exist we will just check if
> > > ancestors are ok again at the next bisection step, which will take a
> > > bit of time, but which will not make us give any false result, or
> > > prevent us from continuing the bisection process.
> > >
> > > I think that it's also the reason why warning_errno(...) is used in
> > > case we could not create the file instead of error_errno(...). We jus=
t
> > > want to signal with a warning that something might be wrong because w=
e
> > > could not create the file, but not stop everything because of that.
> >
> > Thank you for this explanation, it makes sense to me.
> >
> > Maybe a code comment would be in order?
>
> Yeah, I agree it would help.
>
Noted.
Thank you both for the review!

Best,
Miriam
> Thanks for your review,
> Christian.
