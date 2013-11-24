From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: gettext CTYPE for libc
Date: Sun, 24 Nov 2013 10:05:53 +0100
Message-ID: <874n72goem.fsf@linux-k42r.v.cablecom.net>
References: <52900FD6.5020202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git-malling-list <git@vger.kernel.org>
To: =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 24 10:06:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkVeL-0008CL-10
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 10:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732Ab3KXJGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 04:06:15 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:53269 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab3KXJGL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Nov 2013 04:06:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 460284D6532;
	Sun, 24 Nov 2013 10:06:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hIVrwbwEMtXE; Sun, 24 Nov 2013 10:05:54 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (dslb-188-107-175-007.pools.arcor-ip.net [188.107.175.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id CD27F4D6414;
	Sun, 24 Nov 2013 10:05:53 +0100 (CET)
In-Reply-To: <52900FD6.5020202@gmail.com> (=?utf-8?B?IlRy4bqnbiBOZ+G7jWMg?=
 =?utf-8?B?UXXDom4iJ3M=?= message of "Sat,
	23 Nov 2013 09:15:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238253>

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com> writes:

> $ git status
> fatal: Unable to read current working directory: Kh?ng c? t?p tin ho?=
c
> th? m?c nh? v?y
>
> So, somthing wrong with our charset.
[...]
> $ gettext --domain=3Dlibc "No such file or directory"
> Kh=C3=B4ng c=C3=B3 t=E1=BA=ADp tin ho=E1=BA=B7c th=C6=B0 m=E1=BB=A5c =
nh=C6=B0 v=E1=BA=ADy
>
> in git's gettext.c, it not allow CTYPE=3D"" for all domain, so we wil=
l set
> this one individually. In this ex. I set it for libc:
>
> $ git diff
> diff --git a/gettext.c b/gettext.c
> index 71e9545..abd3978 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -115,6 +115,7 @@ static void init_gettext_charset(const char *doma=
in)
>         setlocale(LC_CTYPE, "");
>         charset =3D locale_charset();
>         bind_textdomain_codeset(domain, charset);
> +       bind_textdomain_codeset("libc", charset);
>         setlocale(LC_CTYPE, "C");
>  }

Do you know why this "suddenly" broke?  The long comment in
init_gettext_charset() suggests that the *existing* code is there to
handle exactly this problem, and apparently it doesn't.  Why?  Has libc
moved the perror() strings into a separate domain in some version?

--=20
Thomas Rast
tr@thomasrast.ch
