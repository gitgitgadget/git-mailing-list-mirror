From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] wt-status: correct and simplify check for detached HEAD
Date: Wed, 25 Nov 2015 17:21:04 +0100
Message-ID: <vpqvb8qt5hr.fsf@anie.imag.fr>
References: <563D2DE7.1030005@web.de>
	<20151124213601.GB29185@sigill.intra.peff.net>
	<56551A11.9030809@web.de>
	<20151125091503.GA1779@sigill.intra.peff.net>
	<5655C14A.1060308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 17:21:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1coz-0000bs-VI
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 17:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbbKYQVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2015 11:21:23 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47993 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbbKYQVW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 11:21:22 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tAPGL30V021678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 25 Nov 2015 17:21:03 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tAPGL4iV000809;
	Wed, 25 Nov 2015 17:21:04 +0100
In-Reply-To: <5655C14A.1060308@web.de> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of "Wed, 25
	Nov 2015 15:10:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 25 Nov 2015 17:21:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tAPGL30V021678
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1449073268.64908@OPISdmFSTOL6ZT4u2SZPPA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281718>

Ren=E9 Scharfe <l.s.r@web.de> writes:

> diff --git a/wt-status.c b/wt-status.c
> index 435fc28..ced53dd 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1317,15 +1317,14 @@ static int grab_1st_switch(unsigned char *osh=
a1, unsigned char *nsha1,
>  	target +=3D strlen(" to ");
>  	strbuf_reset(&cb->buf);
>  	hashcpy(cb->nsha1, nsha1);
> -	for (end =3D target; *end && *end !=3D '\n'; end++)
> -		;
> -	if (!memcmp(target, "HEAD", end - target)) {
> +	end =3D strchrnul(target, '\n');
> +	strbuf_add(&cb->buf, target, end - target);
> +	if (!strcmp(cb->buf.buf, "HEAD")) {
>  		/* HEAD is relative. Resolve it to the right reflog entry. */
> +		strbuf_reset(&cb->buf);
>  		strbuf_addstr(&cb->buf,
>  			      find_unique_abbrev(nsha1, DEFAULT_ABBREV));
> -		return 1;
>  	}
> -	strbuf_add(&cb->buf, target, end - target);
>  	return 1;
>  }

Indeed, the code is much simpler like this than with the previous
attempts. Looks all right to me.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
