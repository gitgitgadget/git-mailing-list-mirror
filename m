From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: having to pull twice
Date: Sun, 28 Sep 2008 17:11:35 +0200
Message-ID: <20080928151135.GF23137@genesis.frugalware.org>
References: <fb6605670809241758r186eef51sc6ed6d334a64495d@mail.gmail.com> <200809250905.09646.trast@student.ethz.ch> <20080925232525.GP23137@genesis.frugalware.org> <200809271616.32082.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CSNFvL6ilyiKL/Hs"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Michael P. Soulier" <msoulier@digitaltorque.ca>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Sep 28 17:12:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjxx1-00009q-Jl
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 17:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYI1PLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 11:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbYI1PLi
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 11:11:38 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35980 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbYI1PLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 11:11:37 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3B39C580B9;
	Sun, 28 Sep 2008 17:11:36 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 863B84465E;
	Sun, 28 Sep 2008 17:11:35 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 505A311901A1; Sun, 28 Sep 2008 17:11:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809271616.32082.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96973>


--CSNFvL6ilyiKL/Hs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2008 at 04:16:29PM +0200, Thomas Rast <trast@student.ethz.c=
h> wrote:
> * Setup:
>=20
>   mkdir $temp_repo
>   cd $temp_repo
>   git init
>   echo foo > foo
>   git add foo
>   git commit -m initial
>   echo a > foo
>   git commit -m a foo
>   git checkout -b side HEAD^
>   echo b > foo
>   git commit -m b foo
>   git checkout master

Oh, the racy git problem. ;-)

$ git reset --hard; touch foo; git merge side
HEAD is now at 5bafc63 a
Auto-merging foo
CONFLICT (content): Merge conflict in foo
Automatic merge failed; fix conflicts and then commit the result.

$ git reset --hard; sleep 1; touch foo;git merge side
HEAD is now at 5bafc63 a
error: Entry 'foo' not uptodate. Cannot merge.
fatal: merging of trees 86de5e13286a8449a8a706a58e63be6781770b12 and 9ee610=
433fb8854e497d62c648a612b5deb090cf failed

Thanks for the reproducer, I'll write a proper testcase for this and try to
provide a fix for it as well.

--CSNFvL6ilyiKL/Hs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjfnqcACgkQe81tAgORUJbc7ACfWt9JtlSOCu5B2utRsM27Z/Oh
RvsAn2m9EoG92ZBbQzQIDdR6Ghl33CGH
=96aI
-----END PGP SIGNATURE-----

--CSNFvL6ilyiKL/Hs--
