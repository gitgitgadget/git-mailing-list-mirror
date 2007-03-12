From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's the best method between merging and rebasing ?
Date: Mon, 12 Mar 2007 20:42:27 +0100
Message-ID: <20070312194227.GH30489@mad.intersec.eu>
References: <200703121139.l2CBdcUL022906@localhost.localdomain> <20070312120820.GE18952@mad.intersec.eu> <200703121634.l2CGYtGx027263@localhost.localdomain> <20070312173727.GC30489@mad.intersec.eu> <200703121914.l2CJEqW0031669@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="L1c6L/cjZjI9d0Eq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:42:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqPk-00053Q-8B
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbXCLTmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbXCLTmd
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:42:33 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:59124 "EHLO mx2.intersec.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752607AbXCLTmc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:42:32 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id D0412D843B;
	Mon, 12 Mar 2007 20:42:27 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id 568D6ABD6A4; Mon, 12 Mar 2007 20:42:27 +0100 (CET)
Mail-Followup-To: Xavier Maillard <zedek@gnu.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200703121914.l2CJEqW0031669@localhost.localdomain>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42068>


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2007 at 08:14:52PM +0100, Xavier Maillard wrote:
> Hi,
>=20
>    From: Pierre Habouzit <madcoder@debian.org>
>=20
>    On Mon, Mar 12, 2007 at 05:34:55PM +0100, Xavier Maillard wrote:
>=20
>    > So it seems to be cherry-picks + rebase master on new HEAD but I
>    > am not sure at how things are doing :)
>=20
>      okay then I got this right, you don't want to rebase master on new
>    HEAD because you would keep the commits you don't want (I guess). What
>=20
>      you start from:
>=20
>    orig master -> A -> B -> C (master)
> 	       \
> 		-> D -> E -> F topic
>=20
>      let's say you want to keep A and C from master. here is what I'd do:
>=20
>      $ git checkout topic     # topic will be the new master
>      $ git cherry-pick A C    # we want to keep A and C
>=20
> Got it for this one :)
>=20
>      we now have:
>=20
>    orig master -> A -> B -> C  (master)
> 	       \
> 		-> D -> E -> F -> A' -> C' (topic)
>=20
>      $ git branch -D master
>=20
> For historical reasons, I have to keep my master around so I
> won't delete it completely. Maybe there is a way to tell that a
> branch is considered "dead" thus indicating there won't be any
> new developement onto it. I will check this.

  git branch -m does that, it renames a branch. so git branch -m master
old-master does that. it's what I said in my previous mail.

> As I have been told privately, what I want in reality is a reset
> of master onto my new HEAD.
>=20
> I think I have misunderstood reset behaviour.

  the image I use to about "reset" is that reset is placing a "cursor"
onto a specific commit. Meaning that if you reset master onto some
"commit" it makes master HEAD be that specicific commit.

  the same applies if you do : `git reset HEAD~10' in your working
checkout, it places your current HEAD onto HEAD~10. And so on.

>=20
> So this is how I end up now (from my new master branch):
>=20
> $ git cherry-pick <commits>
> $ git rebase master~NUM
> $ git reset master HEAD
>=20
> There I would need something to tell old master is dead but it is
> optionnal (a single tag will do that).
  before the master you have to:

  $ git branch -m master old-master
and instead of the reset I'd do
  $ git branch master HEAD
as you don't have any master around after the previous move.



> P.S: I have problems reading your posts, my mail buffer is full
> of =3D20 here and there

  that's probable because your MUA does not uderstands quoted printeable
properly ? It is advertised correctly in the Content-Transfer-Encodings
of my mail mimepart so it's not a problem on my end IMHO.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF9a0jvGr7W6HudhwRAvdLAJ445/9jk/gDTBsGMVv/zMETLjRm3gCfcks3
BOgz5pw+UhqYpp7O6CF/9O4=
=16X6
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
