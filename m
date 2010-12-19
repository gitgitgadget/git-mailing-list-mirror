From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH v2] builtin/rm.c: Use ALLOC_GROW instead of alloc_nr and xrealloc.
Date: Sun, 19 Dec 2010 09:58:19 -0200
Message-ID: <AANLkTim-zv6WZZ_DErnoNBhgJw3DnC0jHSH-Mg2CzkhV@mail.gmail.com>
References: <AANLkTim4GE0mnCBqz6QubpL6g9Bz5U-jHoOw=_MR5-1j@mail.gmail.com>
	<97af5e0255d234e3a7ec5df1e387bec39ed94206.1292759580.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 19 12:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUHuZ-0001Es-J6
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 12:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432Ab0LSL6W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Dec 2010 06:58:22 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:32942 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab0LSL6V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Dec 2010 06:58:21 -0500
Received: by bwz16 with SMTP id 16so2459945bwz.4
        for <git@vger.kernel.org>; Sun, 19 Dec 2010 03:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=usBvLZEFWsjgrwEaLo0rsmqlYFXDWeGvcnAflo+3Se4=;
        b=Ts3LnpTYkCaQ7oYo0CrrSj9R/6/RZu7Igm8oS5PdCddKQrqpVwnR3yRoU7ab88HZLE
         f3AwZjMQJLL8QGbeYTl6Q1SqMU19885fuQcvn7cvJ8CgPtM/bNYQhrkzxpJuP049pciK
         VxA4GHGbv0SG6l6Or23ATyqcUpOPH4eeUQUt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vwzarp6Nl13HV2yIOlvdPygeR71X2+m1Q6DxCJ70orQSn9BI5fCDt5QvZ/Gs5B3v9L
         Byfr9bLhB6rS/iZE9/r/XWPiNNMd8EMcwfsAB0ZQBLESLzfb4Uh62x4n87G6kjPRfiYt
         rla39n203RREOGJYJmCpVwfPA72CV6OkE3SEs=
Received: by 10.204.64.139 with SMTP id e11mr2494084bki.97.1292759899759; Sun,
 19 Dec 2010 03:58:19 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Sun, 19 Dec 2010 03:58:19 -0800 (PST)
In-Reply-To: <97af5e0255d234e3a7ec5df1e387bec39ed94206.1292759580.git.tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163956>

=46orgot to copy Jonathan when using 'git send-email'. Now copying him.

On Sun, Dec 19, 2010 at 9:56 AM, Thiago Farina <tfransosi@gmail.com> wr=
ote:
> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> ---
> =C2=A0Changes from v1:
> =C2=A0- Remove the add_list function since it's used only once per Ng=
uyen Thai Ngoc Duy
> =C2=A0 review.
>
> =C2=A0builtin/rm.c | =C2=A0 12 ++----------
> =C2=A01 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index c7b7bb3..ff491d7 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -20,15 +20,6 @@ static struct {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char **name;
> =C2=A0} list;
>
> -static void add_list(const char *name)
> -{
> - =C2=A0 =C2=A0 =C2=A0 if (list.nr >=3D list.alloc) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list.alloc =3D all=
oc_nr(list.alloc);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list.name =3D xrea=
lloc(list.name, list.alloc * sizeof(const char *));
> - =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 list.name[list.nr++] =3D name;
> -}
> -
> =C2=A0static int check_local_mod(unsigned char *head, int index_only)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> @@ -182,7 +173,8 @@ int cmd_rm(int argc, const char **argv, const cha=
r *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cache_e=
ntry *ce =3D active_cache[i];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!match_pat=
hspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_list(ce->name)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(list.na=
me, list.nr + 1, list.alloc);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list.name[list.nr+=
+] =3D ce->name;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pathspec) {
> --
> 1.7.3.2.343.g7d43d
>
>
