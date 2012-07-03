From: Jeff King <peff@peff.net>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Tue, 3 Jul 2012 01:14:26 -0400
Message-ID: <20120703051426.GA12965@sigill.intra.peff.net>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
 <20120702215736.GA5790@sigill.intra.peff.net>
 <m2vci5n5r5.fsf@igel.home>
 <20120703032345.GA7143@sigill.intra.peff.net>
 <CACsJy8AmCo82YxHA_6+rkbuJOjOG-HqCgjoP2tz753SXH5w8_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 07:14:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlvRe-0000xo-DY
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 07:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab2GCFOb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jul 2012 01:14:31 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52031
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab2GCFO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 01:14:29 -0400
Received: (qmail 18108 invoked by uid 107); 3 Jul 2012 05:14:36 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 01:14:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 01:14:26 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8AmCo82YxHA_6+rkbuJOjOG-HqCgjoP2tz753SXH5w8_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200897>

On Tue, Jul 03, 2012 at 11:25:16AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Jul 3, 2012 at 10:45 AM, Jeff King <peff@peff.net> wrote:
> > On Tue, Jul 03, 2012 at 12:43:42AM +0200, Andreas Schwab wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >>
> >> > It's very odd for pread to report ENOENT (since it is always ope=
rating
> >> > on an already-opened file descriptor).
> >>
> >> It doesn't, but gettext will clobber errno:
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D pread(pack_=
fd, inbuf, n, from);
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n < 0)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 die_errno(_("cannot pread pack file"));
> >>
> >> There is nothing that saves errno. =C2=A0This isn't limited to i18=
n though,
> >> any function call in the arguments may potentially clobber errno.
> >
> > That's horribly lame of gettext. I don't expect arbitrary functions=
 to
> > save errno, but when the entire purpose of a function is to be a
> > non-intrusive wrapper to massage messages to the user, it seems kin=
d of
> > evil to overwrite errno. Isn't the whole point of calling it "_" th=
at
> > you don't want to or have to notice it?
>=20
> Agreed.

Hmm. According to gettext(3):

  ERRORS
         errno is not modified.

And googling for "gettext" and "errno" reveals several bugfixes in GNU
gettext to make sure that gettext preserves errno. I wonder if there ar=
e
systems where that is not the case, though; I don't know what non-GNU
gettext implementations are in common use these days. I'd still be
curious to hear what platform the server is for this bug report.

-Peff
