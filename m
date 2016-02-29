From: Jeff King <peff@peff.net>
Subject: Re: Compiler warning under cygwin/mingw (was: fix for 50a6c8e)
Date: Mon, 29 Feb 2016 05:47:08 -0500
Message-ID: <20160229104708.GA17042@sigill.intra.peff.net>
References: <56D3E56A.5010608@web.de>
 <20160229092816.GA23910@sigill.intra.peff.net>
 <56D415C6.2040203@web.de>
 <20160229100258.GC2950@sigill.intra.peff.net>
 <56D4203B.1030708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 29 11:47:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaLME-0004XF-1p
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 11:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbcB2KrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 05:47:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:51285 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752180AbcB2KrM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 05:47:12 -0500
Received: (qmail 12619 invoked by uid 102); 29 Feb 2016 10:47:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 05:47:11 -0500
Received: (qmail 24688 invoked by uid 107); 29 Feb 2016 10:47:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 05:47:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 05:47:08 -0500
Content-Disposition: inline
In-Reply-To: <56D4203B.1030708@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287822>

On Mon, Feb 29, 2016 at 11:40:59AM +0100, Torsten B=C3=B6gershausen wro=
te:

> That compiles OK, thanks.
>=20
> Sorry for high-jacking this thread, but while compiling under CYGWIN,
> found one warning:
>=20
>    LINK git-credential-store.exe
>     CC daemon.o
> daemon.c: In function =E2=80=98drop_privileges=E2=80=99:
> daemon.c:1136:15: warning: implicit declaration of function =E2=80=98=
initgroups=E2=80=99
> [-Wimplicit-function-declaration]
>   if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||

Interesting that it doesn't later complain in the link step. :)

You should probably be compiling with the NO_INITGROUPS knob on that
platform.

> t9115 doesn't pass,  NTFS doesn't like the non-UTF filenames, it seam=
s.
> Probably the same problem as under Mac OS /HFS+-
> -----------------------

No comment from me on that one.

> And MINGW is not happy for other reasons:
>=20
> builtin/rev-parse.c: In function 'cmd_rev_parse':
> builtin/rev-parse.c:775:12: warning: implicit declaration of function
> 'realpath' [-Wimplicit-function-declaration]
>        if (!realpath(gitdir, absolute_path))
>             ^

I guess you're building "pu"; that is only in sg/completion-updates. I
don't know if our custom real_path() would suffice there. You might wan=
t
to ping the author. The patch is:

  http://article.gmane.org/gmane.comp.version-control.git/287462

-Peff
