From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] Prepare execv_git_cmd() for removal of builtins from the filesystem
Date: Sun, 2 Dec 2007 09:48:46 +0100
Message-ID: <200712020948.47084.chriscool@tuxfamily.org>
References: <1196579005-5662-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 09:42:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IykPS-0003of-0y
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 09:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbXLBImS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 03:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbXLBImR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 03:42:17 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48875 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbXLBImR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 03:42:17 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0F0C71AB2E1;
	Sun,  2 Dec 2007 09:42:16 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id C751F1AB2D7;
	Sun,  2 Dec 2007 09:42:15 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <1196579005-5662-1-git-send-email-gitster@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66769>

Le dimanche 2 d=E9cembre 2007, Junio C Hamano a =E9crit :
> +	for (argc =3D 0; argv[argc]; argc++)
> +		; /* just counting */
> +	nargv =3D xmalloc(sizeof(*nargv) * (argc + 2));
>
> -	trace_argv_printf(argv, -1, "trace: exec:");
> +	nargv[0] =3D "git";
> +	for (argc =3D 0; argv[argc]; argc++)
> +		nargv[argc + 1] =3D argv[argc];
> +	nargv[argc + 1] =3D NULL;
> +	trace_argv_printf(nargv, -1, "trace: exec:");

Minor nit: now that the number of arguments is known, we could perhaps =
use=20
the argument count instead of -1 in trace_argv_printf, so that it is no=
t=20
computed again in quote.c:sq_quote_argv, like this:

trace_argv_printf(nargv, argc + 1, "trace: exec:");

Christian.
