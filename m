From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] sha1_name: add get_sha1_with_context()
Date: Wed, 9 Jun 2010 02:13:37 -0400
Message-ID: <20100609061337.GA14007@coredump.intra.peff.net>
References: <1276004958-13540-1-git-send-email-clement.poulain@ensimag.imag.fr>
 <1276004958-13540-2-git-send-email-clement.poulain@ensimag.imag.fr>
 <vpqiq5t5rvd.fsf@bauges.imag.fr>
 <AANLkTinI_ghLE5U3tQ0JFmvuU8DySLFtdl03sv0uW-Ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: =?utf-8?Q?Cl=C3=A9ment?= Poulain <clement.poulain@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 08:13:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMEXw-0003VM-Mt
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 08:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab0FIGNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 02:13:46 -0400
Received: from peff.net ([208.65.91.99]:35772 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626Ab0FIGNp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 02:13:45 -0400
Received: (qmail 17691 invoked by uid 107); 9 Jun 2010 06:13:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 09 Jun 2010 02:13:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jun 2010 02:13:37 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinI_ghLE5U3tQ0JFmvuU8DySLFtdl03sv0uW-Ab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148743>

On Wed, Jun 09, 2010 at 12:30:31AM +0200, Cl=C3=A9ment Poulain wrote:

> Le 8 juin 2010 19:57, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=
=A9crit :
> > This patch produces uncompilable code for me:
> >
> > cc1: warnings being treated as errors
> > In file included from builtin.h:6,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from fast-i=
mport.c:147:
> > cache.h: In function =E2=80=98get_sha1_with_context=E2=80=99:
> > cache.h:748: error: implicit declaration of function =E2=80=98get_s=
ha1_with_context_1=E2=80=99
> >
> > Forgot to add get_sha1_with_context_1 to cache.h?
>=20
> Uh, we compiled it almost ten times on both our pc and ensibm (our
> school server), whithout any problems. Seems that we need to check ou=
r
> compilation configurations.

Note the "warnings being treated as errors". Matthieu is compiling with
-Werror (and presumably -Wall). We strive to be warning-free in git, an=
d
I think many of the developers compile with "-Wall -Werror".

> Right. But the aim was to skip one function call (see the call-stack =
below)
> _with_mode =3D> _with_mode_1 =3D> _with_context_1
> whereas:
>  _with_context =3D> _with_context_1

Perhaps that was your goal, but my goal when I suggested it was to give
us a cleaner codebase. We don't want a proliferation of get_sha1_with_*
functions. Introducing _with_context instead of _with_tree or _with_pat=
h
was meant not to make things worse. But collapsing _with_mode into
_with_context actively makes things better.

> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 orc->path[sizeof(orc->path)] =3D '\0';
> >
> > Same here.
>=20
> That's true. Stupid error, we copied this line without checking it.

Oops, that's my fault for introducing the bug in the first place (I had
originally had an snprintf and changed it to strncpy at the last
minute). :)

-Peff
