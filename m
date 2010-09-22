From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] diff: add a special SYMLINK user-diff driver
Date: Tue, 21 Sep 2010 20:30:49 -0400
Message-ID: <20100922003049.GA23931@sigill.intra.peff.net>
References: <20100921205914.GA1166@sigill.intra.peff.net>
 <20100921211303.GB1188@sigill.intra.peff.net>
 <AANLkTi=zSPegcPNY8jr4S5qeXWHrxuC+0SY-h5EhyA+6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 02:31:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyDEi-0001LY-3E
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 02:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0IVAay convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 20:30:54 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60867 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab0IVAax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 20:30:53 -0400
Received: (qmail 14221 invoked by uid 111); 22 Sep 2010 00:30:51 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 22 Sep 2010 00:30:51 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Sep 2010 20:30:49 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=zSPegcPNY8jr4S5qeXWHrxuC+0SY-h5EhyA+6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156775>

On Wed, Sep 22, 2010 at 12:12:30AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> 2010/9/21 Jeff King <peff@peff.net>:
> > +However, it may happen that you do want to change the diff paramet=
ers
> > +specifically for symlinks. You can do that by configuring the spec=
ial
> > +"SYMLINK" diff driver. For example, to add a newline to the end of
> > +the symlink contents (and suppress the usual "no newline at end of=
 file"
> > +warning), you could configure:
> > +
> > +-----------------------------
> > +[diff "SYMLINK"]
> > + =C2=A0 =C2=A0 =C2=A0 textconv =3D perl -pe 's/$/\n/'
> > +-----------------------------
>=20
> That'll turn every \n in the stream into \n\n, not add a newline to
> the end of the file. Don't you mean:
>=20
>     perl -0666 -pe 's/$/\n/'

Yeah, it will add a newline to the end of file, but it will also double
existing newlines. I wanted something short and clear so the reader
could understand what was going on, and symlink paths don't generally
contain an extra newline.

Just "perl -0pe 's/$/\n/'" would work, as symlink targets can't possibl=
y
have embedded NULs.

But:

> Or, more efficiently:
>=20
>     perl -ple 'END { print }'

That one is even more readable, IMHO. But it isn't right. :)
The automatic line-handling actually adds the missing newline, so I
think it would have to be:

  perl -ple ''

-Peff
