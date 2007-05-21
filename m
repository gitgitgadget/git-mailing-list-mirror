From: Jan Hudec <bulb@ucw.cz>
Subject: Re: sbuild (or whatever) integration
Date: Mon, 21 May 2007 20:15:05 +0200
Message-ID: <20070521181505.GA5082@efreet.light.src>
References: <87sl9t6jhr.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon May 21 20:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqCQ0-0003u8-KE
	for gcvg-git@gmane.org; Mon, 21 May 2007 20:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759590AbXEUSP2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 14:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759550AbXEUSP2
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 14:15:28 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:2635 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756631AbXEUSP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 14:15:26 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.480340;
	Mon, 21 May 2007 20:15:06 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HqCPR-0001Sc-SL; Mon, 21 May 2007 20:15:05 +0200
Content-Disposition: inline
In-Reply-To: <87sl9t6jhr.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48035>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2007 at 15:17:04 +0200, Florian Weimer wrote:
> I'd like to build something that integrates a Debian autobuilder
> (sbuilder probably) with GIT.  The intent is to get rid of a
> designated integrator (our team is of a size where this seems a
> reasonable thing to do[1]) and ensure predictable builds, independent
> of what developers happen to have installed on their local
> workstations.

That's definitely a useful and reasonable thing to do.

> Basically, what I want to do is this:
>=20
>   1. Perform a checkout from a specific branch.
>=20
>   2. Synthesize a new version number that is bigger than the previous
>      one.  (This needs to keep a bit of extra-repository state.  At
>      this stage, it's probably a good idea to ensure that the previous
>      commit built on this branch is an ancestor of the current HEAD.)
>=20
>   3. Generate a fake Debian changelog entry giving the HEAD commit and
>      the branch name, using the generated version number.
>=20
>   4. Build the whole thing in a controlled environment.
>=20
>   5. Store the build log for later review.
>=20
>   6. If the build was successful, transfer the packages to some
>      repository (based on the branch that was used).

I don't think there is actually too much code that would be common for
various git users. It has some code common for Debian developers, either
using Git or even other version control:

1. This is one or at most few commands in a script or makefile, so not much
   room for generic stuff there.
2. This is something big conitnuous integration suites have complex system =
to
   solve, just to hide the fact that it's worth few lines of perl. However:
    - You might want to make up something Debian specific. Something like
      looking at latest entry in debian/changelog (that would be the last
      release) and adding an extra number to that.
    - Alternatively you could use git describe to get the version number of
      last release. Since it's fast-forward only, next build is always from
      descendant of previous, so you might even use git-describe output
      directly.
3. This is mostly Debian-specific. If you remember commit id of previous
   build -- or leave the entries in debian/changelog around -- you can put
   the short log in the entry, but that's single git command once you have
   the respective version ids.
4. These are Debian-specific commands, but would be the same for every Debi=
an
   package.
5. This is mainly issue of sbuild setup, no?
6. Again, sbuild -- and therefore Debian -- specific (but reusable in
   Debian).

IMHO generic tools won't help you much, because every other command is Debi=
an
specific.

What *CAN* help you is the script in
    /usr/share/doc/git-core/contrib/continuous
that will make sure the package is built whenever there are some new changes
on the branch while not doing unnecessary work.

There are actually even big projects with web interface and stuff to do this
kind of thing, but they don't actually cover your steps above except 1 and =
2.
1 is trivial and for 2 you have to tell it how to create those numbers
anyway, so it won't buy you much. IMHO the git contrib/continuous scripts c=
an
do the same for you with much less overhead.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUeGpRel1vVwhjGURAkWuAJ4mZAJax4hZuJwSNdveKJl8rqS6ygCeNGDW
hC61SWv9sZy7blFqqAPr/Q0=
=MU6N
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
