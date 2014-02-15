From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] reset: setup worktree on --mixed
Date: Sat, 15 Feb 2014 16:38:49 +0700
Message-ID: <CACsJy8AChRw30Vb1ivn7HR2+MDgH5ZcGLgzugSrjaJhE=mHqXQ@mail.gmail.com>
References: <CA+C-WL_x=+OPn4Ec-6Y13w1+dd5G5v8W6=i15WH47pyP3ggjuw@mail.gmail.com>
 <1392455661-20665-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, patrick@parcs.ath.cx,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 10:39:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEbih-0007dP-EQ
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 10:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbaBOJjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 04:39:23 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:55409 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbaBOJjU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 04:39:20 -0500
Received: by mail-qc0-f171.google.com with SMTP id n7so21518399qcx.16
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 01:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2v2VIC+CSCjG7kAioOCTTUJVXVz2yv7NNRV/QwYMTII=;
        b=Om+9bPMCYHPyOfvXHY6wth3HvNyCNvREmeSCfpzsIWz3tNg9/5GqMiM7sJxJ87fMvr
         d+fD9/+g/+4DtTN6zKBVSLjZeLqZmT9aeo5asGMJ8tcM2H/UrS7bNAtGRuWnrBorfZ6D
         azN2ulha9edQYDpp3sOFN7tRA2CcHoW4Vi2E4+mEuFaJ5AqmXdtVM2SlIh7YkuYMuI2v
         CGloIda3sf+vEiXZV7HXiCsB20LjeztLjQBPXbUem0WTylcaFbMasj7Tq3oI1l3TUTxo
         cLZzlMKuslK9A8qf9OE4jhxWk0fIBARNX60KWsAL5yd4ivL3qObYISJw7hdTImCQVAOe
         l96g==
X-Received: by 10.224.11.196 with SMTP id u4mr21033587qau.4.1392457159420;
 Sat, 15 Feb 2014 01:39:19 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 15 Feb 2014 01:38:49 -0800 (PST)
In-Reply-To: <1392455661-20665-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242183>

On Sat, Feb 15, 2014 at 4:14 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> --mixed does mainly two things: read_from_tree(), which does not
> require a worktree, and refresh_index(), which does.

=2E. and I should have run the entire test suite before sending this. I=
t
breaks t7103.5 (reset --mixed in bare repository). That test seems
wrong though, in my opinon..

>
> Reported-by: Patrick Palka <patrick@parcs.ath.cx>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/reset.c  |  2 +-
>  t/t7102-reset.sh | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 6004803..9928c28 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -320,7 +320,7 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
>         if (reset_type =3D=3D NONE)
>                 reset_type =3D MIXED; /* by default */
>
> -       if (reset_type !=3D SOFT && reset_type !=3D MIXED)
> +       if (reset_type !=3D SOFT)
>                 setup_work_tree();
>
>         if (reset_type =3D=3D MIXED && is_bare_repository())
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 8d4b50d..ee117e2 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -535,4 +535,15 @@ test_expect_success 'reset with paths accepts tr=
ee' '
>         git diff HEAD --exit-code
>  '
>
> +test_expect_success 'reset --mixed sets up work tree' '
> +       git init mixed_worktree &&
> +       (
> +               cd mixed_worktree &&
> +               test_commit dummy
> +       ) &&
> +       : >expect &&
> +       git --git-dir=3Dmixed_worktree/.git --work-tree=3Dmixed_workt=
ree reset >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 1.8.5.2.240.g8478abd
>



--=20
Duy
