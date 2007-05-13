From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/2] git-svn: fix segfaults due to initial SVN pool being cleared
Date: Sun, 13 May 2007 17:05:30 +0200
Message-ID: <20070513150530.GA29082@artemis>
References: <11790434841909-git-send-email-normalperson@yhbt.net> <11790434862131-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="h31gzZEtNLTqOjlF";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 13 19:44:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnI6x-0000LX-Vo
	for gcvg-git@gmane.org; Sun, 13 May 2007 19:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbXEMRnt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 13:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbXEMRnt
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 13:43:49 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:49805 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686AbXEMRns (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 13:43:48 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 7EE71186F2;
	Sun, 13 May 2007 19:43:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 299AB16229; Sun, 13 May 2007 17:05:31 +0200 (CEST)
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11790434862131-git-send-email-normalperson@yhbt.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47153>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 13, 2007 at 01:04:44AM -0700, Eric Wong wrote:
> Some parts of SVN always seem to use it, even if the SVN::Ra
> object we're using is no longer used and we've created a new one
> in its place.  It's also true that only one SVN::Ra connection
> can exist at once...  Using SVN::Pool->new_default when the
> SVN::Ra object is created doesn't seem to help very much,
> either...
>=20
> Hopefully this fixes all segfault problems users have been
> experiencing over the past few months.
>=20
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  git-svn.perl |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index ee69598..5352470 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2904,7 +2904,6 @@ sub new {
>  	my ($class, $url) =3D @_;
>  	$url =3D~ s!/+$!!;
>  	return $RA if ($RA && $RA->{url} eq $url);
> -	$RA->{pool}->clear if $RA;
> =20
>  	SVN::_Core::svn_config_ensure($config_dir, undef);
>  	my ($baton, $callbacks) =3D SVN::Core::auth_open_helper([
> --=20
> 1.5.2.rc3.18.gf0c86

  I confirm it fixes every segfault I was able to reproduce with any
prior version :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGRyk6vGr7W6HudhwRAgsHAKCiVxfZxbHSttW1+WOLFGyBlgGY8ACfYP1w
gU3eTmj92xHvVO9u0h1fx6I=
=vfDv
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
