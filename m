From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's the best method between merging and rebasing ?
Date: Mon, 12 Mar 2007 18:37:27 +0100
Message-ID: <20070312173727.GC30489@mad.intersec.eu>
References: <200703121139.l2CBdcUL022906@localhost.localdomain> <20070312120820.GE18952@mad.intersec.eu> <200703121634.l2CGYtGx027263@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Bn2rw/3z4jIqBvZU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 18:37:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQoSr-0005qu-TD
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 18:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbXCLRhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 13:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbXCLRhj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 13:37:39 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:46239 "EHLO mx2.intersec.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751894AbXCLRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 13:37:38 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id BCEF8D8A15;
	Mon, 12 Mar 2007 18:37:27 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id 5DB79ABD5C6; Mon, 12 Mar 2007 18:37:27 +0100 (CET)
Mail-Followup-To: Xavier Maillard <zedek@gnu.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200703121634.l2CGYtGx027263@localhost.localdomain>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42045>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2007 at 05:34:55PM +0100, Xavier Maillard wrote:
>    From: Pierre Habouzit <madcoder@debian.org>
>=20
>    On Mon, Mar 12, 2007 at 12:39:38PM +0100, Xavier Maillard wrote:
>    > Hi,
>=20
>    > Say I have a project in this state:
>=20
>    > orig master -> A -> B -> C -> HEAD
>=20
>    > I want to make A diverging from the original branch so I would be
>    > at this state :
>=20
>    > orig master -> A -> B -> C -> HEAD
>    >      	    \
>    > 	             -> D -> E -> F ->
>=20
>    > I want master to be at  HEAD of the new branch and I want to pick
>    > commits here and there from the original master branch.
>=20
>      I'm not sure I get this right, but if I understand you correctly, I'd
>    say that you could branch your master into a old-master branch.
>=20
> What I am tryin to explain is that I want to get rid of the old
> master branch and pick commits from it here and there (that's
> what is called cherry-pick I guess).
>=20
> So in the end I will end with:
>=20
> -> D -> E -> F -> several commits from old master -> HEAD (of new master)
>=20
> So it seems to be cherry-picks + rebase master on new HEAD but I
> am not sure at how things are doing :)

  okay then I got this right, you don't want to rebase master on new
HEAD because you would keep the commits you don't want (I guess). What

  you start from:

orig master -> A -> B -> C (master)
      	    \
             -> D -> E -> F topic

  let's say you want to keep A and C from master. here is what I'd do:

  $ git checkout topic     # topic will be the new master
  $ git cherry-pick A C    # we want to keep A and C

  we now have:

orig master -> A -> B -> C  (master)
      	    \
             -> D -> E -> F -> A' -> C' (topic)

  $ git branch -D master       # we don't want to keep master anymore
  $ git branch -m topic master # rename topic branch into master

  The last step will loose B completely, so if you want to keep it, you
want to keep an old master HEAD around so that references to that branch
remain somwhere. You could git branch -m master old-master at step 3
rather than deleting it in that case.

  But beware that if you do that, as you basically rewrote master's
history, if anyone fetchs from your master, you will f**k up his branch,
because you rewrote history. In that case I think you have to commit a
reverse patch for B (and all the other patches you want to remove) and
then merge topic into master. Your call :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF9Y/XvGr7W6HudhwRAkrmAJ9K8LK2LqU7CAgDoBGSnMTd7tjjMwCfaxYL
AS8rzjTc/MeRFuRKmVc2sSY=
=KjmK
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
