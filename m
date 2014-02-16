From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] reset: optionally setup worktree and refresh index on --mixed
Date: Sat, 15 Feb 2014 21:29:32 -0500
Message-ID: <CAPig+cTFxwnAA807rAaRfU6HZWthZFxUKzaKoLmPBVs+v4pMSQ@mail.gmail.com>
References: <1392455661-20665-1-git-send-email-pclouds@gmail.com>
	<1392517683-29518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	patrick@parcs.ath.cx
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 03:29:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WErU9-0007VP-Sv
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 03:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbaBPC3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 21:29:34 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:56766 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbaBPC3d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 21:29:33 -0500
Received: by mail-yh0-f52.google.com with SMTP id a41so13093516yho.11
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 18:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Vzs6LLOGmz353/hRsSN0dAU7KBY0LKO2eorw7lV+Hh0=;
        b=Eie0cZm5Aat6g/Ixr271WX/Ny7K3Y4WZgzfQy0V5EbYzxBFjI/v1QCoXLUbV5dym5i
         s92s57VOYw089JXt2vmiF0C3MRss19KDGVBcRr7ZoLkDwWiJahY67GGviclc4R2itpcR
         EamY609ZPpqa6N6EmXPMiDI/APbnMgjjZuTaBUr6EI3638VVhbgwkQuYv/QHMg37JqDd
         0jwz99aoa8t3fBT7g48e7RHYtIo0LsahK3z+xE6QFgNjGGalvhZYieAHl2vgzc1wIfrY
         uZz2J3KGABiaUh9uYmvBUpO44+mSU3Nkauphgtqg0KTY7uzUc/cX8XOMm+GrFZ8cCMbS
         N8IQ==
X-Received: by 10.236.123.193 with SMTP id v41mr7222171yhh.68.1392517772924;
 Sat, 15 Feb 2014 18:29:32 -0800 (PST)
Received: by 10.170.189.143 with HTTP; Sat, 15 Feb 2014 18:29:32 -0800 (PST)
In-Reply-To: <1392517683-29518-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: nKUNvanb52wlW1fRA3c0BQqWjhM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242207>

On Sat, Feb 15, 2014 at 9:28 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Refreshing index requires work tree. So we have to options: always se=
t

s/to/two/

> up work tree (and refuse to reset if failing to do so), or make
> refreshing index optional.
>
> As refreshing index is not the main task, it makes more sense to make
> it optional.
>
> Reported-by: Patrick Palka <patrick@parcs.ath.cx>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/reset.c  |  7 ++++---
>  t/t7102-reset.sh | 11 +++++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 6004803..a991344 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -320,7 +320,7 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
>         if (reset_type =3D=3D NONE)
>                 reset_type =3D MIXED; /* by default */
>
> -       if (reset_type !=3D SOFT && reset_type !=3D MIXED)
> +       if (reset_type !=3D SOFT && (reset_type !=3D MIXED || get_git=
_work_tree()))
>                 setup_work_tree();
>
>         if (reset_type =3D=3D MIXED && is_bare_repository())
> @@ -340,8 +340,9 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
>                         int flags =3D quiet ? REFRESH_QUIET : REFRESH=
_IN_PORCELAIN;
>                         if (read_from_tree(&pathspec, sha1))
>                                 return 1;
> -                       refresh_index(&the_index, flags, NULL, NULL,
> -                                     _("Unstaged changes after reset=
:"));
> +                       if (get_git_work_tree())
> +                               refresh_index(&the_index, flags, NULL=
, NULL,
> +                                             _("Unstaged changes aft=
er reset:"));
>                 } else {
>                         int err =3D reset_index(sha1, reset_type, qui=
et);
>                         if (reset_type =3D=3D KEEP && !err)
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
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
