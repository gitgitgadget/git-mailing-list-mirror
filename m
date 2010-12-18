From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] builtin/rm.c: Use ALLOC_GROW instead of alloc_nr and xrealloc.
Date: Sat, 18 Dec 2010 21:03:05 -0200
Message-ID: <AANLkTimLy0uE980GFfaVJt19XuhZDO2OLRbEgs=oyY=2@mail.gmail.com>
References: <ffd7b63f3ef5e409775a0d730691efdaf4e41592.1292291262.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 19 00:03:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU5o4-0002GM-E6
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 00:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195Ab0LRXDK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Dec 2010 18:03:10 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:39453 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188Ab0LRXDJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Dec 2010 18:03:09 -0500
Received: by bwz16 with SMTP id 16so2202443bwz.4
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 15:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uJj0U6Z8Kcr4bRDi+wKvdcMf1I7EKla3LlzODtLgNZ4=;
        b=F8DFV0OLR3MUzPkiL+Bf6mwvaIt/kHnOc2Vp5uHJ63vvUtEUdDnYD2qQOv5WaDUmZ3
         clgbafRXn3Mfkc+8POmhGDT1C3IfJoQr/VwiChIHE8UCwotJdnYt1HtR5571R0HyTDk3
         +Vm5xrcHEgpxMqTTQxMCWdiqldvKzRjeo7/+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D/+MZAddDD0JD8B2XFWmEeU5Kqtx9YxsFjJD4HpnUhXVNSfzeiFfKAsdmWJggQlYPa
         Uu0JjB8Cu092A1V5Aeg5wXqqB26GFOXf7f+IKGSr4Wb5nvANJIU+9NX8TBEhIVf87wAx
         Lhi0vGXPdmbyoRoqGoGRf5Kcv5h8h1sBkf+O8=
Received: by 10.204.59.76 with SMTP id k12mr2071330bkh.70.1292713386009; Sat,
 18 Dec 2010 15:03:06 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Sat, 18 Dec 2010 15:03:05 -0800 (PST)
In-Reply-To: <ffd7b63f3ef5e409775a0d730691efdaf4e41592.1292291262.git.tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163945>

On Mon, Dec 13, 2010 at 11:48 PM, Thiago Farina <tfransosi@gmail.com> w=
rote:
> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> ---
> =C2=A0builtin/rm.c | =C2=A0 =C2=A05 +----
> =C2=A01 files changed, 1 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index c7b7bb3..faeedfc 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -22,10 +22,7 @@ static struct {
>
> =C2=A0static void add_list(const char *name)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 if (list.nr >=3D list.alloc) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list.alloc =3D all=
oc_nr(list.alloc);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list.name =3D xrea=
lloc(list.name, list.alloc * sizeof(const char *));
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 ALLOC_GROW(list.name, list.nr + 1, list.alloc)=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0list.name[list.nr++] =3D name;
> =C2=A0}
>

+Jonathan, he might Ack this.
