From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/4] textconv: support for cat_file
Date: Tue, 08 Jun 2010 20:12:18 +0200
Message-ID: <vpq7hm95r7h.fsf@bauges.imag.fr>
References: <1276004958-13540-1-git-send-email-clement.poulain@ensimag.imag.fr>
	<1276004958-13540-2-git-send-email-clement.poulain@ensimag.imag.fr>
	<1276004958-13540-3-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: =?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 08 20:15:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM3L6-0006lV-Ki
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 20:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753Ab0FHSPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 14:15:47 -0400
Received: from imag.imag.fr ([129.88.30.1]:37341 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954Ab0FHSPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 14:15:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o58ICJgG029608
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 8 Jun 2010 20:12:19 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OM3Hf-0006kE-0a; Tue, 08 Jun 2010 20:12:19 +0200
In-Reply-To: <1276004958-13540-3-git-send-email-clement.poulain@ensimag.imag.fr>
 (=?iso-8859-1?Q?=22Cl=E9ment?= Poulain"'s message of "Tue\,  8 Jun 2010
 15\:49\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 08 Jun 2010 20:12:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148699>

Cl=E9ment Poulain <clement.poulain@ensimag.imag.fr> writes:

> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -9,6 +9,7 @@
> +	struct object_context obj_context =3D OBJECT_CONTEXT_INIT;
> =20
> -	if (get_sha1(obj_name, sha1))
> +	if (get_sha1_with_context(obj_name, sha1, &obj_context))

Do you really need to initialize obj_context here? I'd say the
semantics of get_sha1_with_context should be "give me a pointer to an
object_context, and I'll fill it in with the object context, whatever
be its initial value", just like

int i;
scanf("%d", &i);

doesn't require i to be initialized.

> +	case 'c':
> +		if (!obj_context.path)
> +			die("git cat-file --textconv %s: <object> must be <sha1:path>",
> +			    obj_name);

obj_context.path is an array contained in the struct. It is always
non-null. Just tried:

$ ./git cat-file --textconv 99f036302a7e6d884369d1d3f4ce428e437cbccd | =
head
fatal: git cat-file --textconv: unable to run textconv on 99f036302a7e6=
d884369d1d3f4ce428e437cbccd

you want to check that obj_context.path contains an empty string.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
