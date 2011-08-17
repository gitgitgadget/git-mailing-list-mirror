From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: terminate grepping as soon as it hits
Date: Wed, 17 Aug 2011 09:44:47 +0700
Message-ID: <CACsJy8AwZqGidC3DYEhXwgutTu3hKhCdHJgaYFA+B1c9Z2qjzA@mail.gmail.com>
References: <1313376083-24713-1-git-send-email-pclouds@gmail.com> <1313376083-24713-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 04:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtW8C-0001Qj-Fg
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 04:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab1HQCpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 22:45:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38558 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab1HQCpT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2011 22:45:19 -0400
Received: by bke11 with SMTP id 11so373830bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 19:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nloWk3tjoCeEV+GMHuPhfJOjqQoq4OUPnKMyof607FY=;
        b=iLeeo1QTpkdDgkQ+VcK9pZkzScHOB0dzqaybtGoe4HcYgoACd7si1F9PpGF99URocC
         2MQ+t5SqwyYrJ+wELl5s8kCJ527WTORCnw5sdj2OKP3chN2i65nggqMix8CmNbV/k/TE
         i3kzKwT3fhyQ0yHSvrunMLfJ/hAisOqypYBsE=
Received: by 10.205.34.130 with SMTP id ss2mr177516bkb.175.1313549117370; Tue,
 16 Aug 2011 19:45:17 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Tue, 16 Aug 2011 19:44:47 -0700 (PDT)
In-Reply-To: <1313376083-24713-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179499>

diffgrep_consume() already stops regexec() after hitting, so the value
of this series is negligible. Tay Ray Chuan seems to touch xdiff code
too and my changes are across many files. I'll drop this series.

2011/8/15 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0diffcore-pickaxe.c | =C2=A0 =C2=A06 +-----
> =C2=A01 files changed, 1 insertions(+), 5 deletions(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 12811b9..e028dd5 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -21,11 +21,7 @@ static int diffgrep_consume(void *priv, char *line=
, unsigned long len)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (line[0] !=3D '+' && line[0] !=3D '-')
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data->hit)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* NEEDSWORK:=
 we should have a way to terminate the
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* caller ear=
ly.
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Yuck -- line ought to be "const char *"=
! */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hold =3D line[len];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0line[len] =3D '\0';
> --
> 1.7.4.74.g639db
>
>



--=20
Duy
