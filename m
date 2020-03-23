Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E4C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4202072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ot8ZtQZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCWSNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:13:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42888 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCWSNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:13:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id b21so17365039edy.9
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P73XtoWN4NcH+jyxXApjeVRI7XInRELE49ZfN2tJwrs=;
        b=ot8ZtQZtYEAvgIZ7WGMtQheBDQ47CUoTMQUmSaMfLykQKItE1XFp+VwSo6MKt3kIEb
         Vtzi6g2IWsr0hSq0//WZSA44O0YIE6uMQLmYuSyi1lt/wWbuPlMsjpykjrXEAmz7ACIZ
         y8fo/Z3XwrqU7NdraGYElIPusxvHr4VJlPaC07r4aW/TZsYG14DiK7XmmJmhlXYGF4Er
         hiYntdO4EvUAorbppk7QvRjJdTr5GMgC2ifiIORuk2XI7CiRgcJ2v/IOiSp6+ce/WkzZ
         Vy8Dd0j1lPtcitbZfEGJZnZh5tOp0q9Xv86iwz5gxZqFtLr1/m0Pe+yaoRsAmd2CIiSY
         katA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P73XtoWN4NcH+jyxXApjeVRI7XInRELE49ZfN2tJwrs=;
        b=a1JthhUIO90EAYdyJSAL1s6oX8iW7rzOhyvn3WxhjhTpuJ/SZ42luR6dUUXyjbCOBH
         mX/PH6xwOBhgvYgUBE8e8crj2/TmIakegdzJFI//gnberqiAkQ/xejvaMzRlgOgZoNlw
         wySiXJ6Ts9RPsXsqfFeYtcELeK3Mt+yqLOlXBi7EF6hge47glmW+JvXRJ4Y5egyMphpG
         /eBHn0AVaX9zTJV6X7qtDZTAbHOFnCVlEm+Pgk18Rcb+AOnYVSzhKmw/HEISN90SVOO8
         QTEYOs4eSbO5GzpYacj6HA7dfqdpF7I03Lun0b728X7Q3OB0zGdsM7VyG3Bux+70W5cp
         G5pA==
X-Gm-Message-State: ANhLgQ33yCsbhIMUHJQJa2n73hWu7LRsfe/QyD7y1+GMQjywdnXNMbEM
        M1zyoJJYru46U3gKQYXv2hVXnhZ0ozBJn3hGSGBkVwdn
X-Google-Smtp-Source: ADFU+vsrLb11D6Fqh857rAht8C4/FtELQRm9WjjNs2wraWxLTzSQNz6cGlhNs8/0Y5FRSSV1m50/DQaUJsXo1A47MMg=
X-Received: by 2002:a05:6402:2214:: with SMTP id cq20mr8196875edb.16.1584987213922;
 Mon, 23 Mar 2020 11:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <CANPdQv+tCnfy_csM8EwuqAYBtgkJ3RhRvo+ALbzO=BcZA7qJtg@mail.gmail.com>
 <20200322073105.zh2tqycu2fgydf3e@tb-raspi4> <CANPdQvK4LRZ2b_K0QuWErxNcc2wpW0W4zvmj3HzKDnOvgBNHfw@mail.gmail.com>
 <20200323165821.xk2kdw6tw5e3yqsy@tb-raspi4>
In-Reply-To: <20200323165821.xk2kdw6tw5e3yqsy@tb-raspi4>
From:   =?UTF-8?Q?Andr=C3=A1s_Kucsma?= <andras.kucsma@gmail.com>
Date:   Mon, 23 Mar 2020 19:13:22 +0100
Message-ID: <CANPdQvJSKmJ104qNia9+Pnq0Tqi=pEMxAARpMYF40hbKiRh+Ww@mail.gmail.com>
Subject: Re: GIT_ASKPASS absolute path detection bug on Windows
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Torsten!
I submitted it as https://github.com/gitgitgadget/git/pull/587
I believe someone has to /allow me to be able to submit it.


On Mon, Mar 23, 2020 at 5:58 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Sun, Mar 22, 2020 at 12:44:33PM +0100, Andr=C3=A1s Kucsma wrote:
> > On Sun, Mar 22, 2020 at 8:31 AM Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> > >
> > > On Sat, Mar 21, 2020 at 12:42:50PM +0100, Andr=C3=A1s Kucsma wrote:
> > > > Hi All,
> > > >
> > > > I believe to have found an issue regarding properly executing the
> > > > GIT_ASKPASS binary. I'm using Windows Server 2019, with git 2.21.0
> > > > installed using cygwin.
> > > >
> > > > ## To reproduce:
> > > >
> > > > Assume you have the askpass binary at C:\askpass.bat. In CMD the
> > > > following commands reproduce the issue:
> > > >
> > > > C:\> set GIT_ASKPASS=3DC:\askpass.bat
> > > > C:\> git clone https://<private_repository>.git
> > > > Cloning into '<private_repository>'...
> > > > error: cannot run C:\askpass.bat: No such file or directory
> > > > [... proceeds to interactively ask for username and password ...]
> > > >
> > > > On the other hand, if we change the GIT_ASKPASS environment variabl=
e
> > > > slightly, so that there is a forward slash (/) instead of a backsla=
sh
> > > > (\), things work as expected:
> > > >
> > > > C:\> set GIT_ASKPASS=3DC:/askpass.bat
> > > > C:\> git clone https://<private_repository>.git
> > > > Cloning into '<private_repository>'...
> > > > [... success ...]
> > > >
> > > > ## Some context:
> > > >
> > > > The source of the problem, is that if git doesn't find a forward sl=
ash
> > > > anywhere in the path, it assumes it is not a real path and has to l=
ook
> > > > for the binary using the PATH environment variable. See in
> > > > prepare_cmd():
> > > > https://github.com/git/git/blob/98cedd0233e/run-command.c#L429-L439
> > > >
> > > > You can see that the "cannot run" error message is printed here, ju=
st
> > > > after prepare_cmd() returned -1:
> > > > https://github.com/git/git/blob/98cedd0233e/run-command.c#L749-L753
> > > >
> > > > I believe this was introduced in late 2018 around git v2.19.2,
> > > > although I did not actually bisect the issue:
> > > > https://github.com/git/git/commit/321fd823897#diff-7577a5178f8cdc0f=
719e580577889f04R401-R415
> > > >
> > > >
> > > > I hope I'm sharing this bug at the right forum. Please direct me to
> > > > the proper place if not.
> > >
> > > Yes, you came to the rigth place.
> > > Thanks for the report and the detailed analysis.
> > >
> > > A quick fix, and a begin of a patch, could be to use
> > > has_dos_drive_prefix() which will look for C: and will therefore even=
 work
> > > with C:\
> > >
> > >         /*
> > >          * If there are no '/' characters in the command then perform=
 a path
> > >          * lookup and use the resolved path as the command to exec.  =
If there
> > >          * are '/' characters, we have exec attempt to invoke the com=
mand
> > >          * directly.
> > >          */
> > >         if ((!strchr(out->argv[1], '/')) ||
> > >             (has_dos_drive_prefix(out->argv[1]))) {
> > >                 char *program =3D locate_in_PATH(out->argv[1]);
> > > []
> > >
> > > If you want to play around with the code a little bit, and send us a =
"git diff",
> > > we can convert that into a patch.
> > >
> > > Wellcome to the Git community.
> > >
> > > >
> > > > Thank you,
> > > > Andras
> >
> > Thanks Torsten!
> >
> > I believe it is not enough to test only for the drive specifier, as
> > GIT_ASKPASS has to work with relative paths as well:
> > C:\SomeDirectory> set GIT_ASKPASS=3D.\SomeOtherDirectory\askpass.bat
> > C:\SomeDirectory> git clone https://<some_private_repository>.git
> >
> > My proposal patch is to take advantage of find_last_dir_sep function's
> > OS specific directory separator knowledge.
> > I posted the diff below, which is also available on github here:
> > https://github.com/git/git/compare/maint...r0mai:fix-prepare_cmd-window=
s-maint
> >
> > diff --git a/run-command.c b/run-command.c
> > index f5e1149f9b..9fcc12ebf9 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -421,12 +421,12 @@ static int prepare_cmd(struct argv_array *out,
> > const struct child_process *cmd)
> >      }
> >
> >      /*
> > -     * If there are no '/' characters in the command then perform a pa=
th
> > -     * lookup and use the resolved path as the command to exec.  If th=
ere
> > -     * are '/' characters, we have exec attempt to invoke the command
> > -     * directly.
> > +     * If there are no dir separator characters in the command then pe=
rform
> > +     * a path lookup and use the resolved path as the command to exec.=
 If
> > +     * there are dir separator characters, we have exec attempt to inv=
oke
> > +     * the command directly.
> >       */
> > -    if (!strchr(out->argv[1], '/')) {
> > +    if (find_last_dir_sep(out->argv[1]) =3D=3D NULL) {
> >          char *program =3D locate_in_PATH(out->argv[1]);
> >          if (program) {
> >              free((char *)out->argv[1]);
>
> Andr=C3=A1s,
> The patch looks good to me.
> If you want, you can submit it here to the list,
> either with git send-mail
>
> or may be
>
> https://gitgitgadget.github.io/
>
> And please don't forget to sign-off the patch
