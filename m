From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 1/2] config.mak.uname: Darwin: define NO_GETTEXT for
 OS X 10.9 and later
Date: Tue, 24 Nov 2015 15:34:53 -0500
Message-ID: <20151124203453.GB7174@sigill.intra.peff.net>
References: <1448267108-55652-1-git-send-email-larsxschneider@gmail.com>
 <1448267108-55652-2-git-send-email-larsxschneider@gmail.com>
 <5652FF18.20602@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 24 21:35:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1KIl-0005lq-G5
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 21:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbbKXUe5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 15:34:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:33388 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753520AbbKXUe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 15:34:56 -0500
Received: (qmail 21150 invoked by uid 102); 24 Nov 2015 20:34:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 14:34:55 -0600
Received: (qmail 17982 invoked by uid 107); 24 Nov 2015 20:34:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 15:34:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 15:34:53 -0500
Content-Disposition: inline
In-Reply-To: <5652FF18.20602@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281625>

On Mon, Nov 23, 2015 at 12:57:12PM +0100, Torsten B=C3=B6gershausen wro=
te:

> >+	# MacOS 10.7 Lion and higher
> >  	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -g=
e 11 && echo 1),1)
> >  		HAVE_GETDELIM =3D YesPlease
> >  	endif
> >+	# MacOS 10.9 Mavericks and higher
> >+	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge=
 13 && echo 1),1)
> >+		NO_GETTEXT =3D YesPlease
> >+	endif
> >  	NO_MEMMEM =3D YesPlease
> >  	USE_ST_TIMESPEC =3D YesPlease
> >  	HAVE_DEV_TTY =3D YesPlease
> Unless I'm wrong, no Mac OS X had libintl.h, and the "unwritten agree=
ment
> (?)" was
> that either
> a) libintl ist installed in some way (fink, mac ports, brew, other wa=
ys)
> or
> b) people use
> NO_GETTEXT=3Dyes make
>=20
> Doesn't this patch close the door for b), making it impossible to bui=
ld Git
> against libintl ?

I think the right way to do (b) is:

  make NO_GETTEXT=3DYes

which will override anything we do in config.mak.uname (and likewise,
anything from autoconf will override it, if we have a test there).

Still, it will be a surprise to packagers in (a), who assume that
installing libintl and then building git is enough to have gettext
support (now they would actively need to override NO_GETTEXT).

-Peff
