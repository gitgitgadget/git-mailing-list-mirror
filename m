Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11910C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 00:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C688324672
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 00:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H8DDhZxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLQAFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:05:06 -0500
Received: from mout.gmx.net ([212.227.17.20]:53425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfLQAFG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 19:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576541092;
        bh=dxvcHHf+a7R59WecFwKmeDYOII2lYdYXYN4o2Uy4MkY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H8DDhZxhMrJfhT+MUkhnA0LsAaBlbdKLAM4AC34DxVQaLCK1nfhgHXj+WxDzTp2u2
         zyylHNczg+sVUMaEu6YAXtRgoxHNsFru93AhiGnJkRKWhYaQ16DOQsX3sC/DTz+RQS
         8vfy+TRS5VueYNylG1SwoG5eOypSZ2WrMMyD1Bxg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1hlROc2vOw-00zGEW; Tue, 17
 Dec 2019 01:04:52 +0100
Date:   Tue, 17 Dec 2019 01:04:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
In-Reply-To: <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912170101230.46@tvgsbejvaqbjf.bet>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com> <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet>
 <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com> <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xt0DuSNvdeaFHc+psthuQPSBcnDDGDYX6MnuCGOdyu/+7ANpL/Q
 UjeXUZmv1HswabjFLY5VxOSYsKUgbqM/rOqojECH0sPOu6xANHCZLAP3k0hEVmEs2Aaf7AF
 U7F1oodzhOGyxnkaE4+8cmMMueTYVWUsMeQ0M0BhWfvVMOtDwBHIMVz4eBpzg1D9NaQfR8q
 NuzNBZU+PzI1QCfZLLt/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TA7J6bYdVCY=:06mAsrBtugY6mPxEtFp4dA
 uXD36I8zq/BJS1N5tp8EhFcFlduwf/sq50Lkj/0aFWtYtmSz0ik5sV8RHJOsHHzuYxJmET8zG
 6MJ2Cs+z331Ez5tT9Qy+RbV9oc2wSYLjUkYO9KrYBgC/AkvsE0wlhqhZskvz6BKb7RYpUPnZE
 HT+ahZIyo0hKUPtXQj3qp2l2cTViK8PjKygZWbScyF/TRKr0+HEhGSlWbVjpLqSy1P1299b6E
 QZMa+rWcDIUDoBco2R2QQIqdNLDkhHKKJwxXDW1WiAj7LvUJxl/kaKMpaL0sMK92IrizYenEb
 De695p8GcE0IUz7ycyFHUNT1dM1PI73/YAnTqagmwdusSJEG9eh39Mf/t2mot/2MsnnD9QS7i
 vFunXlciFuoHpcPEwrROx4BMdMqquOoJZjiSRh+r3FDu3g1dRFey1COexyYJu5XsbKusLE3Kj
 3IEpcTBfOHt/xKamDIw77uTBe1+tIK8xXiCYZuv6YpiKzcGERPjpVNkUGLVZtqxRfXeGR+ZCt
 9f79ocjVkmO8drNAMbkvbFdj/RIBWfp5atqoCaKqH/h1ODnLYPGzX3Gnk4M2x7BRzjNgjTTdx
 Dtv3mAWhY/iKkuAFu+MS8994tYxOZVs/LFVQdXb3CRKs8xOqgpukEjTk+gvMcdSaFsVJ+fxNA
 pRYhR8yONCFr3WKrTFDW6usMY5y2P2JTMGemtcJWmYoExUVCcl9bwyYXhRB8RNK9biPgrkHOt
 fPvuuTK1Go5wQjRBfr0+3psmmG6ofcS5AfNr1xou36iL5OryIDSJHs18O9RPPy0ruVmq6rTBN
 pB9dgMhXBupOrqUdCqi0chGlK+w7EWxYQPsVT1Z84kAfLOQSZnbkQFWiyibAACVD0uSVmh/u/
 acIyohoXuJccjD75KTotrawNIgnd1t2VGKn0rTeTVZATQ40lLSnRFbOTWfrYj0vwk8U374+kY
 rBMeWo/7b0kpfwe7tGWfUk14qv+SiIHXTQtvVHtznwJ3N/DwHc1y4Iari1JZcAyyWPjA0hGqw
 klI/lWOqpUxUJcV7qsDcnHxC8De0QCdIcbJWuNLbjchur0g1gjNS7sBuQ2x0jO3YzRy1gMK4+
 1id9WGv/X0zCdIi9n+eQH/RY5olnnXA+92Mj6B33TCgzfGdYxmrH/EOTKKMNo6IkXsTI+NdTJ
 Y+Tv42VhdTVUaZNLTzmfzvhiZ6DhyxQW/nCPkgl1hQKPUZSk0efQ2qnAMYNzHkAFV1RFmbRMq
 RTCxE46jJdta4TzIecHP1Y5j/s3SgPPa+baf+9QinRnECH2Q+kGtg6vgpfq8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 16 Dec 2019, Elijah Newren wrote:

> On Mon, Dec 16, 2019 at 5:51 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Sun, Dec 15, 2019 at 2:29 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Hi Elijah,
> > >
> > > I have not had time to dive deeply into this, but I know that it _do=
es_
> > > cause a ton of segmentation faults in the `shears/pu` branch (where =
all of
> > > Git for Windows' patches are rebased on top of `pu`):
> >
> > Weird.  If it's going to cause segmentation faults at all, it would
> > certainly do it all over the place, but I tested the patches on the
> > major platforms using your Azure Pipelines setup on git.git so it
> > should be good on all the platforms.  Did your shears/pu branch make
> > some other changes to the setup?

Not really.

> > > On Tue, 10 Dec 2019, Elijah Newren via GitGitGadget wrote:
> > >
> > > > diff --git a/dir.c b/dir.c
> > > > index 645b44ea64..9c71a9ac21 100644
> > > > --- a/dir.c
> > > > +++ b/dir.c
> > > > @@ -2102,37 +2102,69 @@ static int treat_leading_path(struct dir_s=
truct *dir,
> > > >                             const struct pathspec *pathspec)
> > > >  {
> > > >       struct strbuf sb =3D STRBUF_INIT;
> > > > -     int baselen, rc =3D 0;
> > > > +     int prevlen, baselen;
> > > >       const char *cp;
> > > > +     struct cached_dir cdir;
> > > > +     struct dirent de;
> > > > +     enum path_treatment state =3D path_none;
> > > > +
> > > > +     /*
> > > > +      * For each directory component of path, we are going to che=
ck whether
> > > > +      * that path is relevant given the pathspec.  For example, i=
f path is
> > > > +      *    foo/bar/baz/
> > > > +      * then we will ask treat_path() whether we should go into f=
oo, then
> > > > +      * whether we should go into bar, then whether baz is releva=
nt.
> > > > +      * Checking each is important because e.g. if path is
> > > > +      *    .git/info/
> > > > +      * then we need to check .git to know we shouldn't traverse =
it.
> > > > +      * If the return from treat_path() is:
> > > > +      *    * path_none, for any path, we return false.
> > > > +      *    * path_recurse, for all path components, we return tru=
e
> > > > +      *    * <anything else> for some intermediate component, we =
make sure
> > > > +      *        to add that path to the relevant list but return f=
alse
> > > > +      *        signifying that we shouldn't recurse into it.
> > > > +      */
> > > >
> > > >       while (len && path[len - 1] =3D=3D '/')
> > > >               len--;
> > > >       if (!len)
> > > >               return 1;
> > > > +
> > > > +     memset(&cdir, 0, sizeof(cdir));
> > > > +     memset(&de, 0, sizeof(de));
> > > > +     cdir.de =3D &de;
> > > > +     de.d_type =3D DT_DIR;
> > >
> > > So here, `de` is zeroed out, and therefore `de.d_name` is `NULL`.
> >
> > Um, yeah...didn't I have an allocation of de.d_name here?  It will
> > always have a subset of path copied into it, so an allocation of len+1
> > is plenty long enough.
>
> Actually, it looks like I looked up the definition of dirent
> previously and forgot by the time you emailed.  On linux, from
> /usr/include/bits/dirent.h:
>
> struct dirent
>   {
>     ....
>     unsigned char d_type;
>     char d_name[256];           /* We must not include limits.h! */
>   };
>
> and from compat/win32/dirent.h defines it as:
>
> struct dirent {
>         unsigned char d_type;      /* file type to prevent lstat after
> readdir */
>         char d_name[MAX_PATH * 3]; /* file name (* 3 for UTF-8 conversio=
n) */
> };
>
> and 'man dirent' on Mac OS X says it's defined as:
>
> struct dirent {
>         ...
>         _uint8_t d_type;
>         _unit8_t d_namlen;   /* length of string in d_name */
>         char    d_name[255+1];  /* name must be no longer than this */
> }
>
> so, allocating it would be incorrect and my memset would just fill
> d_name with nul characters.
>
>
> But the raises the question...what kind of segfaults are you getting?
> Can you link to any builds or post any stack traces?  Can I duplicate
> with some copy of git-for-windows on linux?

If you care to look at our very own `compat/win32/dirent.h`, you will see
this:

struct dirent {
        unsigned char d_type; /* file type to prevent lstat after readdir =
*/
        char *d_name;         /* file name */
};

And looking at
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.html, I
do not see any guarantee of that `[256]` at all:

The <dirent.h> header shall [...] define the structure dirent which shall
include the following members:

[XSI][Option Start]
ino_t  d_ino       File serial number.
[Option End]
char   d_name[]    Filename string of entry.

You will notice that not even `d_type` is guaranteed.

Ciao,
Dscho
