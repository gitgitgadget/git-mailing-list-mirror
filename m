From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 1/4] sha1_name: creating context cache
Date: Sun, 06 Jun 2010 17:56:41 +0200
Message-ID: <vpqpr045f46.fsf@bauges.imag.fr>
References: <1275823848-7151-1-git-send-email-clement.poulain@ensimag.imag.fr>
	<1275823848-7151-2-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org, drizzd@aon.at,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: =?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 06 18:00:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLIGw-0004Ft-V7
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 18:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757973Ab0FFQAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 12:00:19 -0400
Received: from imag.imag.fr ([129.88.30.1]:64415 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757058Ab0FFQAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 12:00:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o56FugQI013824
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Jun 2010 17:56:42 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OLIDK-0001l4-3w; Sun, 06 Jun 2010 17:56:42 +0200
In-Reply-To: <1275823848-7151-2-git-send-email-clement.poulain@ensimag.imag.fr>
 (=?iso-8859-1?Q?=22Cl=E9ment?= Poulain"'s message of "Sun\,  6 Jun 2010
 13\:30\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 06 Jun 2010 17:56:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148522>

Cl=E9ment Poulain <clement.poulain@ensimag.imag.fr> writes:

> This cache keeps the global context for the last sha1 looked up, espe=
cially its pathname. The textconv is indeed defined by the diff driver,=
 which is associated with a pathname, not a blob

Please, wrap your message to make it fit in 80 characters (M-q under
Emacs can help). This applies to the cover email too, but is
particularly important for this one, since it'll become the commit
message if the patch is accepted.

> diff --git a/cache.h b/cache.h
> index 0f4263c..26a1faf 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -730,6 +730,14 @@ static inline unsigned int hexval(unsigned char =
c)
>  #define MINIMUM_ABBREV 4
>  #define DEFAULT_ABBREV 7
> =20
> +struct object_resolve_context {
> +	unsigned char tree[20];
> +	char path[PATH_MAX];
> +	unsigned mode;
> +};
> +extern struct object_resolve_context object_context;

Is it really a good idea to make this a global variable? As I
understand it, the semantics of this variable is that it contains
information on the last sha1 name parsed (BTW, you probably want to
add a comment here explaining that). Wouldn't it be more robust to
have this value returned by the function doing the parsing?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
