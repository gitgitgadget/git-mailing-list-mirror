From: Pierre Habouzit <madcoder@artemis.madism.org>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 22:40:39 +0200
Message-ID: <20080723204039.GB18160@artemis.madism.org>
References: <20080723130518.GA17462@elte.hu> <alpine.LFD.1.10.0807231027030.4754@woody.linux-foundation.org> <20080723190920.GG20614@artemis.madism.org> <20080723202722.GA18160@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="QKdGvSO+nmPlgiQ/";
	protocol="application/pgp-signature"; micalg=SHA1
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 22:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLl9e-000723-A7
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 22:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbYGWUkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 16:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbYGWUkn
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 16:40:43 -0400
Received: from pan.madism.org ([88.191.52.104]:33025 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754402AbYGWUkm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 16:40:42 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AEDE73A7AB;
	Wed, 23 Jul 2008 22:40:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DEBB8C1E7; Wed, 23 Jul 2008 22:40:39 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@artemis.madism.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080723202722.GA18160@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89769>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On mer, jui 23, 2008 at 08:27:22 +0000, Pierre Habouzit wrote:
> On Wed, Jul 23, 2008 at 07:09:20PM +0000, Pierre Habouzit wrote:
> > On Wed, Jul 23, 2008 at 05:59:01PM +0000, Linus Torvalds wrote:
> > > In fact, the two top entries in a profile look roughly like:
> > >=20
> > > 	102161   70.2727  libz.so.1.2.3            libz.so.1.2.3            =
(no symbols)
> > > 	7685      5.2862  git                      git                      =
find_pack_entry_one
> > > 	...
> > >=20
> > > ie 70% of the time is just purely unpacking the data, and another 5% =
is=20
> > > just finding it. We could perhaps improve on it, but not a whole lot.
> >=20
> >   Well there is an easy way though, that could reduce that: using
> > adaptative compression. I proposed a patch once upon a time, that set
> > the compression strengh to 0 for "small" objects with a configurable
> > cut-off. If you do that, most trees, commits messages and so on aren't
> > compressed, and it will reduce (with IIRC a 5-liner) this time quite
> > dramatically.
> >=20
> >   I could maybe resurect it to see if for people that do the kind of
> > things Ingo does it helps. By setting the cut-off at 1k, I had packs
> > being less than 1% bigger IIRC. I'll try to find it again and run your
> > tests with it to see how much it helps.
>=20
>   Unsurprisingly with a 1024o cutoff, the numbers are (first run is
> forced cold-cache with /proc/.../drop_caches, second is the best run of 5=
):
>=20
> default git:
>=20
>     3.10user 0.16system 0:08.10elapsed 40%CPU (0avgtext+0avgdata 0maxresi=
dent)k
>     116152inputs+0outputs (671major+35286minor)pagefaults 0swaps
>=20
>     2.01user 0.11system 0:02.12elapsed 99%CPU (0avgtext+0avgdata 0maxresi=
dent)k
>     0inputs+0outputs (0major+35958minor)pagefaults 0swaps
>=20
> With a 1024k cutoff:
>=20
>     1.16user 0.13system 0:08.29elapsed 15%CPU (0avgtext+0avgdata 0maxresi=
dent)k
>     154208inputs+0outputs (947major+39777minor)pagefaults 0swaps
>=20
>     0.76user 0.06system 0:00.82elapsed 100%CPU (0avgtext+0avgdata 0maxres=
ident)k
>     0inputs+0outputs (0major+40724minor)pagefaults 0swaps

With a 512o cutoff:

    1.49user 0.17system 0:07.50elapsed 22%CPU (0avgtext+0avgdata 0maxreside=
nt)k
    127648inputs+0outputs (780major+36687minor)pagefaults 0swaps

    1.54user 0.07system 0:01.61elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
    0inputs+0outputs (0major+37467minor)pagefaults 0swaps


What I bench, I see I forgot to mention, is: git merge v2.6.14. And
the respective pack sizes:

    214M  .git-0/objects/pack/pack-bfeec11abed1ec6d046bc954b94d70ba81716356=
=2Epack
    225M  .git-512/objects/pack/pack-bfeec11abed1ec6d046bc954b94d70ba817163=
56.pack
    243M  .git-1024/objects/pack/pack-bfeec11abed1ec6d046bc954b94d70ba81716=
356.pack

=2Egit-0 is cheating because it was generated with a way deeper window and
memory window that the other ones, but it allow to give rough
impressions.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHl0cACgkQvGr7W6HudhynigCdFpjOBaQUUGOSKeAKPLoVoxq6
AX4An3vBtQ5ysaxzbl6WlAvS4dZyyrl2
=vZDw
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
