From: Pierre Habouzit <madcoder@artemis.madism.org>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 21:09:20 +0200
Message-ID: <20080723190920.GG20614@artemis.madism.org>
References: <20080723130518.GA17462@elte.hu> <alpine.LFD.1.10.0807231027030.4754@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="0rSojgWGcpz+ezC3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjjI-0000tJ-8n
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbYGWTJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbYGWTJX
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:09:23 -0400
Received: from pan.madism.org ([88.191.52.104]:45695 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbYGWTJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:09:22 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 53E833A791;
	Wed, 23 Jul 2008 21:09:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4ED50451BC8; Wed, 23 Jul 2008 21:09:20 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@artemis.madism.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807231027030.4754@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89745>


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 05:59:01PM +0000, Linus Torvalds wrote:
> In fact, the two top entries in a profile look roughly like:
>=20
> 	102161   70.2727  libz.so.1.2.3            libz.so.1.2.3            (no =
symbols)
> 	7685      5.2862  git                      git                      find=
_pack_entry_one
> 	...
>=20
> ie 70% of the time is just purely unpacking the data, and another 5% is=
=20
> just finding it. We could perhaps improve on it, but not a whole lot.

  Well there is an easy way though, that could reduce that: using
adaptative compression. I proposed a patch once upon a time, that set
the compression strengh to 0 for "small" objects with a configurable
cut-off. If you do that, most trees, commits messages and so on aren't
compressed, and it will reduce (with IIRC a 5-liner) this time quite
dramatically.

  I could maybe resurect it to see if for people that do the kind of
things Ingo does it helps. By setting the cut-off at 1k, I had packs
being less than 1% bigger IIRC. I'll try to find it again and run your
tests with it to see how much it helps.

  [ Of course, it doesn't invalidate the rest of your mail about being
    more clever with git-merge, but still, we could reduce this 70% of
    zlib time quite a lot with that ]

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHgeAACgkQvGr7W6Hudhy+6QCffTcbiOmR7F1BtfRrhCF3yYNN
FPEAn0CP3F/AYOAfm1h6aIII+FDGxUwT
=eNLb
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
