From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add possibility to store configuration in
 ~/.config/git/config file
Date: Sat, 26 May 2012 17:54:05 -0400
Message-ID: <20120526215405.GC29463@sigill.intra.peff.net>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
 <20120525203056.GC4364@sigill.intra.peff.net>
 <7vd35sq7fx.fsf@alter.siamese.dyndns.org>
 <20120525214406.GA10064@sigill.intra.peff.net>
 <CACsJy8BD_=6PtQeuDGEt2mee9tMWZB1hL2obu2f2KUmAENTEzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 23:54:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYOw9-0003iV-Py
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 23:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab2EZVyI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 17:54:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56814
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404Ab2EZVyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 17:54:07 -0400
Received: (qmail 24590 invoked by uid 107); 26 May 2012 21:54:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 May 2012 17:54:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 May 2012 17:54:05 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BD_=6PtQeuDGEt2mee9tMWZB1hL2obu2f2KUmAENTEzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198571>

On Sat, May 26, 2012 at 05:15:13PM +0700, Nguyen Thai Ngoc Duy wrote:

> > So I consider it the lesser of two evils. The rule is much simpler:=
 "old
> > versions of git do not know about this new location". Which is
> > unavoidable, and easier to explain than "Old versions of git do not=
 know
> > about this location. New versions do, but will sometimes ignore
> > depending on whether this other file exists, which might have been
> > created by an old version".
>=20
> We could amend Junio's version a bit:
>=20
>  - if both versions exist, warn loudly (optionally refuse to work) an=
d
> suggest to symlink .gitconfig to .config/git/config

Yeah, that might help. At the same time, it is not necessarily an error
condition (e.g., if I track my ~/.config directory, but want to put
one-offs in ~/.gitconfig. On the other hand, you can set that up
manually with include.path =3D ~/.some-not-tracked-file, so maybe it is
not a use case worth worrying about).

> > =C2=A01. Start reading from the XDG location in addition to the old
> > =C2=A0 =C2=A0 location. Always write to the old location.
> >
> > =C2=A02. Wait N time units until everybody reasonable has a version=
 that
> > =C2=A0 =C2=A0 does (1).
> >
> > =C2=A03. Start writing to the XDG location by default. Keep reading=
 from the
> > =C2=A0 =C2=A0 old version for compatibility.
>=20
> Hang on.. this "by default" is only for Linux, or for every other OS =
too?

Sorry, I overstated a bit. It would be _safe_ to do step 3 like that
after waiting N time units, but we could also do something much less
drastic (like only writing to it when it exists, or when ~/.gitconfig
does not exist, or whatever). And no, I wouldn't think following XDG on
non-Linux machines would make much sense if no other programs on that
platform do so (I don't know what OS X is like, but I can imagine nobod=
y
uses XDG paths on Windows).

-Peff
