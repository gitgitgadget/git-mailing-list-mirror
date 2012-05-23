From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/6] sha1_loose_object_info: do not complain out loud
 on non-existent objects
Date: Wed, 23 May 2012 21:24:12 +0700
Message-ID: <CACsJy8A5Xv8_KY2z4eQvm2e=3e=KjDJyVM+-d0dmXntHJ-6efg@mail.gmail.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
 <1337782191-10091-1-git-send-email-pclouds@gmail.com> <1337782191-10091-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 16:24:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXCUc-0000Ub-KW
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 16:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547Ab2EWOYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 10:24:45 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44413 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab2EWOYo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 10:24:44 -0400
Received: by wibhj8 with SMTP id hj8so4667111wib.1
        for <git@vger.kernel.org>; Wed, 23 May 2012 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pX+xKDHRgiNBBTvniq+zL1UH/bBkRepIkZNr01gmQlw=;
        b=aw9+oPC36qmUgD74zuz+ChQS9janhDLNawk9YimHejOvKg2owA+4bgjXYHDcCnPxTF
         EJnb49K/DCljcFXOvt2Ow+UpSaLnok/6MLt3NJKVb5S/FCw+rVsZk9NN4zr/fs4meVS7
         MKYTMsYu22hIYuIMnGGrfVmNu6W8nfunalRNxZvmdibONSVAePyuOLFTTvKHRSMTpYn6
         AYLtrH8hmIipfRmPuxorwyVQmwWuWvtROkWwZSN+RJAtL6sB3LC/dp7oxVMsfETbbGTx
         ruwkxTyRHBBkmpvHg6xh5HBVarLXy9KTtEQ5RamGQx1p5PRQPpodEiTL7+fmtKyJ8UUn
         2P9g==
Received: by 10.180.95.100 with SMTP id dj4mr25474836wib.17.1337783083128;
 Wed, 23 May 2012 07:24:43 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Wed, 23 May 2012 07:24:12 -0700 (PDT)
In-Reply-To: <1337782191-10091-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198292>

On Wed, May 23, 2012 at 9:09 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0makes sense to me, but I might have overlooked something

while it's still making sense for me, i think it's more logical  to
move the check to the caller, where "entry in pack?" check is also
done.

>
> =C2=A0sha1_file.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 3c4f165..520b41e 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2133,6 +2133,8 @@ static int sha1_loose_object_info(const unsigne=
d char *sha1, unsigned long *size
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git_zstream stream;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char hdr[32];
>
> + =C2=A0 =C2=A0 =C2=A0 if (!has_loose_object(sha1))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0map =3D map_sha1_file(sha1, &mapsize);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!map)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error("=
unable to find %s", sha1_to_hex(sha1));
> --
> 1.7.10.2.549.g9354186
>



--=20
Duy
