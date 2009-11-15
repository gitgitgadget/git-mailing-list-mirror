From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Check the format of more printf-type functions
Date: Sun, 15 Nov 2009 15:17:26 +0100
Message-ID: <81b0412b0911150617x5ef81b1ao9236c49d549ef8ea@mail.gmail.com>
References: <1258234393-5093-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 15:17:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9fv4-0003z9-HX
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 15:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbZKOORW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 09:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbZKOORW
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 09:17:22 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:63718 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbZKOORV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 09:17:21 -0500
Received: by fxm21 with SMTP id 21so1885388fxm.21
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 06:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D93c6ApzrNwe3jmw7MurR+n3RhbK6KZNTKukN1qEGaE=;
        b=kvRMwfP48s5KmteSf9hng2RwDJmSUhfOdfbx3d/aOpOkVfwZYzGfvp+iXVY7+uoJL1
         vhDiXqOtzd+tzuHg0vq+3GTfgPftKMffaDMJGfPscfHSRZ1+q8Rp4eQBrToWKtmxGg+j
         sY6jqOwExzKY3HnGsekd2F6EKRvsWQH1VjYAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aJ1FFMmY4h7Ea82SVFZR4mtKFJfarowCQ8wWy2GS8CPvRQLouytpYK1Cj7JNjiq2Pk
         CatlSW08/qp7BX6VPkUcPVFkEhufiHlPFtgclmPfWPQgl+PyHW/3bj1V4K++as2BjeJe
         7C/LNSOm40TAwl1gR4FLLXtiSZcOPvo/YOo2M=
Received: by 10.204.23.77 with SMTP id q13mr1807524bkb.136.1258294646528; Sun, 
	15 Nov 2009 06:17:26 -0800 (PST)
In-Reply-To: <1258234393-5093-1-git-send-email-tarmigan+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132940>

On Sat, Nov 14, 2009 at 22:33, Tarmigan Casebolt <tarmigan+git@gmail.co=
m> wrote:
> We already have these checks in many printf-type functions that have
> prototypes which are in header files. =C2=A0Add these same checks to =
some
> more prototypes in header functions and to static functions in .c
> files.
>
> cc: Miklos Vajna <vmiklos@frugalware.org>
> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
> ---
>
> Junio, please consider this for next. =C2=A0It will hopefully catch s=
ome bugs like
> the Content-Length one in http-backend.c.
>
> One extra warning is
> =C2=A0 =C2=A0CC merge-recursive.o
> merge-recursive.c: In function =E2=80=98write_tree_from_memory=E2=80=99=
:
> merge-recursive.c:218: warning: field precision should have type =E2=80=
=98int=E2=80=99, but argument 5 has type =E2=80=98size_t=E2=80=99
>
> A fix that might work in practice (because pathnames won't be longer =
than
> an int?) is:
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -215,7 +215,9 @@ struct tree *write_tree_from_memory(struct merge_=
options *o)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; =
i < active_nr; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct cache_entry *ce =3D active_cache[i];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (ce_stage(ce))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output(o, 0, "%d %.*s", ce_stage(ce=
), ce_namelen(ce), ce->name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output(o, 0, "%d %.*s", ce_stage(ce=
), (int)ce_namelen(ce), ce->name);

It'll do. The message is purely diagnostics.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ce_namelen(ce) > INT_MAX)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("A filename was too long");

That's overdoing it a little.
