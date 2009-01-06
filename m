From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Tue, 06 Jan 2009 12:17:12 +0100
Message-ID: <20090106111712.GB30766@artemis.corp>
References: <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="jho1yZJdad60DJr+";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 12:34:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKACx-00036M-NS
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 12:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbZAFLdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 06:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbZAFLdS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 06:33:18 -0500
Received: from pan.madism.org ([88.191.52.104]:43865 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbZAFLdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 06:33:17 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 2EEF83BC1E;
	Tue,  6 Jan 2009 12:33:14 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 195B6374D2; Tue,  6 Jan 2009 12:17:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104677>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On jeu, jan 01, 2009 at 04:38:09 +0000, Johannes Schindelin wrote:
>=20
> Nothing fancy, really, just a straight-forward implementation of the
> heavily under-documented and under-analyzed paience diff algorithm.

Btw, what is the status of this series ? I see it neither in pu nor in
next. And I would gladly see it included in git.

On jeu, jan 01, 2009 at 07:45:21 +0000, Linus Torvalds wrote:
>=20
>=20
> On Thu, 1 Jan 2009, Johannes Schindelin wrote:
> >=20
> > Nothing fancy, really, just a straight-forward implementation of the
> > heavily under-documented and under-analyzed paience diff algorithm.
>=20
> Exactly because the patience diff is so under-documented, could you=20
> perhaps give a few examples of how it differs in the result, and why it's=
=20
> so wonderful? Yes, yes, I can google, and no, no, nothing useful shows up=
=20
> except for *totally* content-free fanboisms.=20
>=20
> So could we have some actual real data on it?

For example, look at the following (shamelessly stolen from the real
life example http://glandium.org/blog/?p=3D120).

With orig.mk reading:
  ] include $(DEPTH)/config/autoconf.mk
  ]=20
  ] include $(topsrcdir)/config/rules.mk
  ]=20
  ] libs::
  ]        $(INSTALL) $(srcdir)/nsKillAll.js $(DIST)/bin/components
  ]=20
  ] clean::
  ]        rm -f $(DIST)/bin/components/nsKillAll.js

With patched.mk reading:
  ] include $(DEPTH)/config/autoconf.mk
  ]=20
  ] EXTRA_COMPONENTS =3D nsKillAll.js
  ]=20
  ] include $(topsrcdir)/config/rules.mk
  ]=20
  ] clean::
  ]        rm -f $(DIST)/bin/components/nsKillAll.js

You get:

Normal git diff                                    | patience diff
---------------------------------------------------+-----------------------=
-------------------
 include $(DEPTH)/config/autoconf.mk               |  include $(DEPTH)/conf=
ig/autoconf.mk
                                                   |
-include $(topsrcdir)/config/rules.mk              | +EXTRA_COMPONENTS =3D =
nsKillAll.js
+EXTRA_COMPONENTS =3D nsKillAll.js                   | +
                                                   |  include $(topsrcdir)/=
config/rules.mk
-libs::                                            |
-       $(INSTALL) $(srcdir)/...                   | -libs::
+include $(topsrcdir)/config/rules.mk              | -       $(INSTALL) $(s=
rcdir)/...
                                                   | -
 clean::                                           |  clean::
        rm -f $(DIST)/bin/components/nsKillAll.js  |         rm -f $(DIST)/=
bin/components/nsKillAll.js



I've checked in many projects I have under git, the differences between
git log -p and git log -p --patience. The patience algorithm is really
really more readable with it involves code moves with changes in the
moved sections. If the section you move across is smaller than the moved
ones, the patience algorithm will show the moved code as removed where
it was and added where it now is, changes included. The current diff
will rather move the smaller invariend section you move across and
present mangled diffs involving the function prototypes making it less
than readable.

Of course, moving code _and_ modifying it at the same time is rather bad
style. BUt (1) it happens and the fact it's bad style is a bad argument
to not show a decent diff of it (2) if you construct diffs of a range of
commits it happens a lot.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkljPbgACgkQvGr7W6Hudhz+0ACgpcSyKocN9+BPwENOo+zr/0T9
kW0An3CfUM11dmCgZVsVSRlH4v2dqTeL
=E81R
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
