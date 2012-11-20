From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 15/13] compat/fnmatch: fix off-by-one character class's
 length check
Date: Tue, 20 Nov 2012 08:06:05 +0100
Message-ID: <50AB2BDD.5030707@viscovery.net>
References: <5096D76F.5090907@kdbg.org> <1352628837-5784-1-git-send-email-pclouds@gmail.com> <1352628837-5784-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 08:06:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TahuZ-0000J7-1D
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 08:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab2KTHGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2012 02:06:08 -0500
Received: from so.liwest.at ([212.33.55.13]:15649 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab2KTHGH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2012 02:06:07 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TahuH-0002LY-N3; Tue, 20 Nov 2012 08:06:06 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 775641660F;
	Tue, 20 Nov 2012 08:06:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <1352628837-5784-2-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210081>

Am 11/11/2012 11:13, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> Character class "xdigit" is the only one that hits 6 character limit
> defined by CHAR_CLASS_MAX_LENGTH. All other character classes are 5
> character long and therefore never caught by this.
>=20
> This should make xdigit tests in t3070 pass on Windows.
>=20
> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I tested with Linux (removing the ifdef __LIBC in fnmatch.c) but I
>  think this should get an ACK from someone who actually uses it on
>  Windows.

Works well here on Windows.

This does not affect Windows alone, but all platforms that fall back to
compat/fnmatch. It's perhaps worth its own topic branch.

>  We may want to tell upstream (who?) about this if they haven't fixed
>  it already.
>=20
>  compat/fnmatch/fnmatch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
> index 9473aed..0ff1d27 100644
> --- a/compat/fnmatch/fnmatch.c
> +++ b/compat/fnmatch/fnmatch.c
> @@ -345,7 +345,7 @@ internal_fnmatch (pattern, string, no_leading_per=
iod, flags)
> =20
>  		    for (;;)
>  		      {
> -			if (c1 =3D=3D CHAR_CLASS_MAX_LENGTH)
> +			if (c1 > CHAR_CLASS_MAX_LENGTH)
>  			  /* The name is too long and therefore the pattern
>  			     is ill-formed.  */
>  			  return FNM_NOMATCH;
>=20

-- Hannes
