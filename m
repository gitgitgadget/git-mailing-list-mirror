From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libxdiff and patience diff
Date: Tue, 04 Nov 2008 17:15:48 +0100
Message-ID: <20081104161548.GB21842@artemis.corp>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0811041650510.24407@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="XWOWbaMNXpFDWE00";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: davidel@xmailserver.org, Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 04 17:17:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxOb2-00048Z-7W
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 17:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172AbYKDQPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 11:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756159AbYKDQPx
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 11:15:53 -0500
Received: from pan.madism.org ([88.191.52.104]:54826 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756146AbYKDQPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 11:15:52 -0500
Received: from madism.org (unknown [213.223.38.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 685703BFF4;
	Tue,  4 Nov 2008 17:15:50 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id AFC61384EA; Tue,  4 Nov 2008 17:15:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811041650510.24407@pacific.mpi-cbg.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100084>


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2008 at 03:57:44PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 4 Nov 2008, Pierre Habouzit wrote:
>=20
> > The nasty thing about the patience diff is that it still needs the usual
> > diff algorithm once it has split the file into chunks separated by
> > "unique lines".
>=20
> Actually, it should try to apply patience diff again in those chunks,=20
> separately.

yes it's what I do, but this has a fixed point as soon as you don't find
unique lines between the new found ones, or that that space is "empty".
E.g. you could have the two following hunks:

File A       File B
1            2
2            1
1            2
2            1
1            2
2
1

The simple leading/trailing reduction will do nothing, and you don't
have any shared unique lines, on that you must apply the usual diff
algorithm.

> > So you cannot make really independant stuff. What I could do is put mos=
t=20
> > of the xpatience diff into xpatience.c but it would still have to use=
=20
> > some functions from xdiffi.c that are currently private, so it messes=
=20
> > somehow the files more than it's worth IMHO.
>=20
> I think it is better that you use the stuff from xdiffi.c through a well=
=20
> defined interface, i.e. _not_ mess up the code by mingling it together=20
> with the code in xdiffi.c.  The code is hard enough to read already.

Hmmm. I'll see to that later, once I have something that works.

> Oh, BTW, "ha" is a hash of the lines which is used to make the line=20
> matching more performant.  You will see a lot of "ha" comparisons before=
=20
> actually calling xdl_recmatch() for that reason.  Incidentally, this is=
=20
> also the hash that I'd use for the hash multi-set I was referring to.

Yeah, that's what I assumed it would be.

> Oh, and I am not sure that it is worth your time trying to get it to run=
=20
> with the linear list, since you cannot reuse that code afterwards, and=20
> have to spend the same amount of time to redo it with the hash set.

Having the linear list (actually an array) work would show me I hook at
the proper place. Replacing a data structure doesn't makes me afraid
because I've split the functions properly.

> I am awfully short on time, so it will take some days until I can review=
=20
> what you have already, unfortunately.

NP, it was just in case, because I'm horribly stuck with that code right
now ;)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkQdTQACgkQvGr7W6HudhyLJACeI373TEtWtyZaf+V0ZHVqaeBG
qxUAn1o+t4KU+3T4yg3Af1tMaae+L2JI
=3x/T
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
