Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF910C4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 11:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBA320732
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 11:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2JxqTZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCVLor (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:44:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36612 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgCVLor (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 07:44:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id b18so12988419edu.3
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=by5CTss6ovnY7iyW2ocXrX/pPp692IUkO85mx2KK2Gk=;
        b=o2JxqTZ4nK28YHmumu5uRXoldf2/Lc+u7tqcF+yfFcL9IkfJ0lomk6MMrIwKd/hjvC
         wmwmqRbA+WH9f8vOY9Dcqu3xuiWm98kvJqn+s+2bhXTjoDp+LRGUDZbmSsd2Rkz/HERz
         q4DcwqIR3lbf6E773wQvZIUrC81kHYiqKPFnEuMZM7dtcbq0Rrig1xPplnitLPB2yyQM
         Blc22UA0FIHFRyWlIehKJq7Hkk/hJT65ksAwFye8Gi1VChjcjdBeUwqNgCgA/9rvuaRM
         m4TjO3D5VTG3I2mbq3QZ6TnTi80/JfuLrMqJUQBs9B3/nCEwyY2V2osyFNwT32TYKiOi
         YGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=by5CTss6ovnY7iyW2ocXrX/pPp692IUkO85mx2KK2Gk=;
        b=h5hPcm8OSajHRkiYSt0mjW9lGFEVNrW69ilDRiLbdXT5hrl7z579FBNtJ54v8OYXCN
         ew4cz+DWQCGivg7lO7HcZJLgMbrqXg2NFTOnkix6pKaIULAtt/y7YOCRPJ5jBefeiJTz
         A2ciBEYdKZa/xwPuf6fTFHon9Qtvv4kiLCHYBB5NtRUs2p56wG333cE34DbbuQAtrJ1J
         aEI6qHlZbPs4KztGIU9MmXNhx8KQl140ordp9jnKaXYBxdJzuRP1jF9Li0NRkmpGVCgM
         Xrext/uK3TsCRTaBp9UPXI//knTcFL2OIXA0zueVs4eBza6/ptMZ3wn0hPnXrcPNlmnl
         SZjg==
X-Gm-Message-State: ANhLgQ0EeV300nBayjI0Gc0q1W5FvRYYhAwWFwgFdleV47rXmh8Yk12T
        HXmzMt3q9VuS5J6S0ikMAk0krn7WpqAQdM47ZJs=
X-Google-Smtp-Source: ADFU+vtq/Zcz4Z1f7ZKIgNyZk4NAtCMIM4cd5EzLW1ZrSpTdhFAvWdjSRE/UuIydXb+QHpm2sN1nmxg8r19My7j5Tu0=
X-Received: by 2002:a05:6402:1757:: with SMTP id v23mr16351203edx.384.1584877484670;
 Sun, 22 Mar 2020 04:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <CANPdQv+tCnfy_csM8EwuqAYBtgkJ3RhRvo+ALbzO=BcZA7qJtg@mail.gmail.com>
 <20200322073105.zh2tqycu2fgydf3e@tb-raspi4>
In-Reply-To: <20200322073105.zh2tqycu2fgydf3e@tb-raspi4>
From:   =?UTF-8?Q?Andr=C3=A1s_Kucsma?= <andras.kucsma@gmail.com>
Date:   Sun, 22 Mar 2020 12:44:33 +0100
Message-ID: <CANPdQvK4LRZ2b_K0QuWErxNcc2wpW0W4zvmj3HzKDnOvgBNHfw@mail.gmail.com>
Subject: Re: GIT_ASKPASS absolute path detection bug on Windows
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 8:31 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Sat, Mar 21, 2020 at 12:42:50PM +0100, Andr=C3=A1s Kucsma wrote:
> > Hi All,
> >
> > I believe to have found an issue regarding properly executing the
> > GIT_ASKPASS binary. I'm using Windows Server 2019, with git 2.21.0
> > installed using cygwin.
> >
> > ## To reproduce:
> >
> > Assume you have the askpass binary at C:\askpass.bat. In CMD the
> > following commands reproduce the issue:
> >
> > C:\> set GIT_ASKPASS=3DC:\askpass.bat
> > C:\> git clone https://<private_repository>.git
> > Cloning into '<private_repository>'...
> > error: cannot run C:\askpass.bat: No such file or directory
> > [... proceeds to interactively ask for username and password ...]
> >
> > On the other hand, if we change the GIT_ASKPASS environment variable
> > slightly, so that there is a forward slash (/) instead of a backslash
> > (\), things work as expected:
> >
> > C:\> set GIT_ASKPASS=3DC:/askpass.bat
> > C:\> git clone https://<private_repository>.git
> > Cloning into '<private_repository>'...
> > [... success ...]
> >
> > ## Some context:
> >
> > The source of the problem, is that if git doesn't find a forward slash
> > anywhere in the path, it assumes it is not a real path and has to look
> > for the binary using the PATH environment variable. See in
> > prepare_cmd():
> > https://github.com/git/git/blob/98cedd0233e/run-command.c#L429-L439
> >
> > You can see that the "cannot run" error message is printed here, just
> > after prepare_cmd() returned -1:
> > https://github.com/git/git/blob/98cedd0233e/run-command.c#L749-L753
> >
> > I believe this was introduced in late 2018 around git v2.19.2,
> > although I did not actually bisect the issue:
> > https://github.com/git/git/commit/321fd823897#diff-7577a5178f8cdc0f719e=
580577889f04R401-R415
> >
> >
> > I hope I'm sharing this bug at the right forum. Please direct me to
> > the proper place if not.
>
> Yes, you came to the rigth place.
> Thanks for the report and the detailed analysis.
>
> A quick fix, and a begin of a patch, could be to use
> has_dos_drive_prefix() which will look for C: and will therefore even wor=
k
> with C:\
>
>         /*
>          * If there are no '/' characters in the command then perform a p=
ath
>          * lookup and use the resolved path as the command to exec.  If t=
here
>          * are '/' characters, we have exec attempt to invoke the command
>          * directly.
>          */
>         if ((!strchr(out->argv[1], '/')) ||
>             (has_dos_drive_prefix(out->argv[1]))) {
>                 char *program =3D locate_in_PATH(out->argv[1]);
> []
>
> If you want to play around with the code a little bit, and send us a "git=
 diff",
> we can convert that into a patch.
>
> Wellcome to the Git community.
>
> >
> > Thank you,
> > Andras

Thanks Torsten!

I believe it is not enough to test only for the drive specifier, as
GIT_ASKPASS has to work with relative paths as well:
C:\SomeDirectory> set GIT_ASKPASS=3D.\SomeOtherDirectory\askpass.bat
C:\SomeDirectory> git clone https://<some_private_repository>.git

My proposal patch is to take advantage of find_last_dir_sep function's
OS specific directory separator knowledge.
I posted the diff below, which is also available on github here:
https://github.com/git/git/compare/maint...r0mai:fix-prepare_cmd-windows-ma=
int

diff --git a/run-command.c b/run-command.c
index f5e1149f9b..9fcc12ebf9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -421,12 +421,12 @@ static int prepare_cmd(struct argv_array *out,
const struct child_process *cmd)
     }

     /*
-     * If there are no '/' characters in the command then perform a path
-     * lookup and use the resolved path as the command to exec.  If there
-     * are '/' characters, we have exec attempt to invoke the command
-     * directly.
+     * If there are no dir separator characters in the command then perfor=
m
+     * a path lookup and use the resolved path as the command to exec. If
+     * there are dir separator characters, we have exec attempt to invoke
+     * the command directly.
      */
-    if (!strchr(out->argv[1], '/')) {
+    if (find_last_dir_sep(out->argv[1]) =3D=3D NULL) {
         char *program =3D locate_in_PATH(out->argv[1]);
         if (program) {
             free((char *)out->argv[1]);
