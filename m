From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add a simple option parser.
Date: Sat, 13 Oct 2007 22:54:04 +0200
Message-ID: <20071013205404.GK7110@artemis.corp>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <1192282153-26684-2-git-send-email-madcoder@debian.org> <20071013191655.GA2875@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="J2pR2RtFp0tAjF3C";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 22:54:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igo03-0006mL-Of
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbXJMUyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756529AbXJMUyI
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:54:08 -0400
Received: from pan.madism.org ([88.191.52.104]:47422 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757115AbXJMUyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:54:07 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CBEAF24D2C;
	Sat, 13 Oct 2007 22:54:04 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6EFA83A0A56; Sat, 13 Oct 2007 22:54:04 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071013191655.GA2875@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60778>


--J2pR2RtFp0tAjF3C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2007 at 07:16:55PM +0000, Alex Riesen wrote:
> Pierre Habouzit, Sat, Oct 13, 2007 15:29:03 +0200:
> > [...]
>=20
> "const struct option *opts"?
>=20
> Why not "const char *const *usagestr"? Especially if you change
> "usagestr" (the pointer itself) later. "[]" is sometimes a hint that
> the pointer itself should not be changed, being an array.
>=20
> And you want make opts const.

  Ok.

> BTW, it does not "make" usage. It calls the usage() or prints a usage
> description. "make" implies it creates the "usage", which according to
> the prototype is later nowhere to be found.

  Yes this has been spotted and fixed already.

>=20
> > +{
> > +	struct strbuf sb;
> > +
> > +	strbuf_init(&sb, 4096);
> > +	do {
> > +		strbuf_addstr(&sb, *usagestr++);
> > +		strbuf_addch(&sb, '\n');
> > +	} while (*usagestr);
>=20
> This will crash for empty usagestr, like  "{ NULL }". Was it
> deliberately? (I'd make it deliberately, if I were you. I'd even used
> cnt of opts, to force people to document all options).

  Yes this is intentional, there should be at least on string in the
usagestr array.


> > +     strbuf_addf(&sb, "\n%*s%s\n", USAGE_OPTS_WIDTH + USAGE_GAP, "",
> > +		    opts->help);
> ....
> > +	usage(sb.buf);
>=20
> BTW, if you just printed the usage message out (it is about usage of a
> program, isn't it?) and called exit() everyone would be just as happy.
> And you wouldn't have to include strbuf (it is the only use of it),
> less code, too. It'd make simplier to stea^Wcopy your implementation,
> which I like :)

  the reason is that usage() is a wrapper around a callback, and I
suppose it's used by some GUI's or anything like that.

  FWIW you can rework the .c like this:

  pos =3D 0; /* and not pos =3D sb.len */

  replace the strbuf_add* by the equivalents:
  pos +=3D printf("....");

  and tada, you're done.


  Note that in the most recent version, I also deal with a
OPTION_CALLBACK that passes the value to a callback.

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--J2pR2RtFp0tAjF3C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHETBsvGr7W6HudhwRAq86AKCh1xs+78rTwK2WosgdnSBbiv47mwCglv8R
5T9AS9BjcTZ31WEU0OQz2wU=
=pJwd
-----END PGP SIGNATURE-----

--J2pR2RtFp0tAjF3C--
