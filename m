From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCH] gitweb: readme fixed regarding per user project root
 repository
Date: Mon, 29 Mar 2010 22:43:15 +0200
Message-ID: <1269895395.3392.21.camel@kheops>
References: <1269296130-2237-1-git-send-email-sylvain@abstraction.fr>
	 <1269296130-2237-2-git-send-email-sylvain@abstraction.fr>
	 <7v39zmnceq.fsf@alter.siamese.dyndns.org>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-k4rUBorfSicQ4ik06QWZ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 22:43:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwLns-0005zV-Lp
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 22:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab0C2UnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 16:43:15 -0400
Received: from lo.gmane.org ([80.91.229.12]:45679 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985Ab0C2UnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 16:43:14 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NwLnk-0005uQ-P4
	for git@vger.kernel.org; Mon, 29 Mar 2010 22:43:12 +0200
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 22:43:12 +0200
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 22:43:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
In-Reply-To: <7v39zmnceq.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143516>


--=-k4rUBorfSicQ4ik06QWZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-03-26 at 11:52 -0700, Junio C Hamano wrote:=20
> I was waiting for gitweb people to respond, but nobody seems to be
> interested so here is my take on it.
>=20
> Sylvain Rabot <sylvain@abstraction.fr> writes:
>=20
> > + the RewriteRule '/+<user>' is not working as the '+' character is
> >   replaced by a space in urls when you click on links. it is replaced b=
y '/u/<user>'
>=20
> I think the _only_ value of having this example, in addition to the next
> one that uses "http://host/user/<me>" notation, was to demonstrate that
> you do not necessarily have the actual user name and the magic token (be
> it "user" or "u") that introduces the per-user hierarchy as separate path
> components delimited with a slash.  Changing "+<me>" to "u/<me>" removes
> that only additional value from this example.
>=20
> Anybody moderately intelligent would be able to guess "u/<me>" if she
> finds "user/<me>" too long to her taste, so I would suggest updating the
> example to allow "http://host/+<user>/" but spell the rewrite rule in suc=
h
> a way that actually does work.  An alternative is to just remove it.
>=20

The problem is http://host/+user works but then, when you click on a
link you will be redirected to :

"http://host/ user?p=3Dgit/git.git;a=3Dtree"=20
-------------^

I will try to look into gitweb.perl to see if the url encoding can be
updated smoothly without breaking anything to accept the '+' otherwise I
think removing this example would be the right decision like you
suggested.

> By the way, does mod-rewrite configuration allow "~<me>" (home-directory
> expansion) when setting the environment?  You currently do:
>=20
>     E=3DGITWEB_PROJECTROOT:/home/$1/public_git/
>=20
> but if we somehow could write it like
>=20
>     E=3DGITWEB_PROJECTROOT:~$1/public_git/
>=20
> it would be more generally useful, no?

I looked and I don't think so, ~user/public_git/ is not evaluated by
apache. Maybe it possible to evaluate it in the perl side, I will look
into it also.

>=20
> > + the RewriteRule '/user/<user>' updated to allow
> >   '/user/<user>', '/user/<user>/' and '/user/<user>/gitweb.cgi'
>=20
> Please describe what you added relative to the original, not just what th=
e
> final result looks like.  "updated to allow A B C" doesn't tell the reade=
r
> "it used to redirect only A and C to gitweb request, but B wasn't
> rewritten.", which seems to be the case if I am reading your regexp
> correctly.  Describing why it is better to also rewrite B would be a good
> idea, too, if it is not obvious.

Will do.

>=20
> > + some typos fixed
> >
> > Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
>=20
> > diff --git a/gitweb/README b/gitweb/README
> > index ad6a04c..bc90f4d 100644
> > --- a/gitweb/README
> > +++ b/gitweb/README
> > @@ -347,18 +347,18 @@ something like the following in your gitweb.conf =
(or gitweb_config.perl) file:
> >    $home_link =3D "/";
> > =20
> > =20
> > -Webserver configuration with multiple projects' root
> > -----------------------------------------------------
> > +Webserver configuration with multiple project roots
> > +---------------------------------------------------
>=20
> Ok.
>=20
> > -If you want to use gitweb with several project roots you can edit your=
 apache
> > -virtual host and gitweb.conf configuration files like this :
> > +If you want to use gitweb with several project roots then you can edit=
 your
> > +apache virtual host and gitweb.conf configuration files like this :
>=20
> Ok (you might want to remove SP before colon, though).

My bad, French habit, but, according to wikipedia it is also English
"compliant" (http://en.wikipedia.org/wiki/Colon_%28punctuation%
29#Spacing). As you want.

>=20
> >  virtual host configuration :
> > =20
> >  <VirtualHost *:80>
> > -    ServerName			git.example.org
> > -    DocumentRoot		/pub/git
> > -    SetEnv				GITWEB_CONFIG	/etc/gitweb.conf
> > +    ServerName		git.example.org
> > +    DocumentRoot	/pub/git
> > +    SetEnv		GITWEB_CONFIG	/etc/gitweb.conf
>=20
> What is this reindentation for?  "Just cosmetic" is an acceptable answer
> as long as the change resulted in cosmetic improvement, but it doesn't
> seem to be cosmetic improvement, either.

That was the case, it looked better in vim.

>=20
> Thanks.


--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-k4rUBorfSicQ4ik06QWZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuxEN0ACgkQ+TklUoyVcydzCQCgpl8MJHWENIBfbQUq1EwvS/Yh
6B4AoMJQbS1iiOVSy8aEXVSuIigs/QPz
=LYdb
-----END PGP SIGNATURE-----

--=-k4rUBorfSicQ4ik06QWZ--
