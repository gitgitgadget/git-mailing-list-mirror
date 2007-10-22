From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add some fancy colors in the test library when terminal  supports it.
Date: Mon, 22 Oct 2007 13:24:01 +0200
Message-ID: <20071022112401.GE32763@artemis.corp>
References: <20071022081341.GC32763@artemis.corp> <471C6510.8010300@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="E13BgyNx05feLLmH";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 13:24:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjvON-0005kw-8o
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 13:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXJVLYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 07:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbXJVLYG
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 07:24:06 -0400
Received: from pan.madism.org ([88.191.52.104]:57922 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbXJVLYF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 07:24:05 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D25E926165;
	Mon, 22 Oct 2007 13:24:02 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 168CF3CC233; Mon, 22 Oct 2007 13:24:02 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <471C6510.8010300@viscovery.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61990>


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2007 at 08:53:36AM +0000, Johannes Sixt wrote:
> Pierre Habouzit schrieb:
> >Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> >---
> >Maybe this is just me, but I don't find the output of the test-suite
> >easy to watch while scrolling. This puts some colors in proper places.
> >  * end-test summaries are in green or red depending on the sucess of
> >    the tests.
> >  * errors are in red.
> >  * skipped tests and other things that tests `say` are in brown (now
> >    you can _see_ that your testsuite skips some tests on purpose, I
> >    only noticed recently that I missed part of the environment for
> >    proper testing).
> >I'm not 100% sure the test to see if terminal supports color is correct,=
=20
> >and
> >people using emacs shell buffer or alike tools may have better ideas on=
=20
> >how to
> >make it.
> >and yes, I know that it "depends" upon tput, but if tput isn't=20
> >available, the
> >    [ "x$TERM" !=3D "xdumb" ] && tput hpa 60 >/dev/null 2>&1 && tput set=
af=20
> >1 >/dev/null 2>&1
> >expression will fail, and color will be disabled.
> > t/test-lib.sh |   32 ++++++++++++++++++++++----------
> > 1 files changed, 22 insertions(+), 10 deletions(-)
> >diff --git a/t/test-lib.sh b/t/test-lib.sh
> >index cc1253c..c6521c0 100644
> >--- a/t/test-lib.sh
> >+++ b/t/test-lib.sh
> >@@ -59,14 +59,24 @@ esac
> > # '
> > # . ./test-lib.sh
> > +[ "x$TERM" !=3D "xdumb" ] && tput hpa 60 >/dev/null 2>&1 && tput setaf=
 1=20
> >>/dev/null 2>&1
> >+nocolor=3D$?
>=20
> test "x$TERM" !=3D "xdumb" &&
> 	tput hpa 60 >/dev/null 2>&1 &&
> 	tput setaf 1 >/dev/null 2>&1 &&
> 	color=3Dt
>=20
> BTW, doesn't tput fail if stdout/stderr is not a terminal, like above?
>=20
> >+
> >+say_color () {
> >+	[ "$nocolor" =3D 0 ] &&  [ "$1" !=3D '-1' ] && tput setaf "$1"
> >+	shift
> >+	echo "* $*"
> >+	tput op
> >+}
>=20
> What if tput is not available, like on Windows? How about this (at the=20
> end of the file, so it can obey --no-color):

  I answered to it already in my first mail: if tput isn't available,
the command fails, and $? is non 0. and nocolor is set. Or color isn't
set to 't' for your proposal.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHHIhRvGr7W6HudhwRApoEAJ0ZoxwYppdYzLNkMxMt4kvZqjq/3wCaAvoM
BD2Rt/V8Hux192Xxh4yg2tE=
=rGnJ
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
