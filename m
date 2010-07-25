From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/WIP] git-svn: tweak log format to match "svn log" output
Date: Sun, 25 Jul 2010 08:40:57 +0000
Message-ID: <20100725084057.GA23621@dcvr.yhbt.net>
References: <20100423134611.GA3440@merkur.sol.de> <20100426132710.GA9930@progeny.tock> <20100427112656.GB16323@merkur.sol.de> <20100725023114.GB18606@burratino> <20100725081057.GA22373@dcvr.yhbt.net> <20100725083708.GB22213@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Seidel <jensseidel@users.sf.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 10:41:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocwlc-0005L8-Lz
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 10:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290Ab0GYIk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 04:40:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59679 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab0GYIk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 04:40:58 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F591F44B;
	Sun, 25 Jul 2010 08:40:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100725083708.GB22213@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151713>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Wong wrote:
>=20
> > @@ -5646,8 +5644,8 @@ sub show_commit_normal {
> > =20
> >  	if ($can_localize) {
> >  		my $d =3D Locale::gettext->domain("subversion");
> > -		$sing_fmt =3D $d->nget(" | %d line", " | %d lines", 1);
> > -		$plur_fmt =3D $d->nget(" | %d line", " | %d lines", 10);
> > +		$sing_fmt =3D $d->nget($sing_fmt, $plur_fmt, 1);
> > +		$plur_fmt =3D $d->nget($sing_fmt, $plur_fmt, 10);
>=20
> This change gives me pause: wouldn=E2=80=99t it be a problem in
> non-English locales, where $sing_fmt changes before it is
> used to set $plur_fmt?
>=20
> Of course there is no problem because the code is equivalent to
>=20
> 		$sing_fmt =3D $d->get($sing_fmt);
> 		$plur_fmt =3D $d->get($plur_fmt);
>=20
> (or at least Locale::gettext is advertised to work that way.)
>=20
> diff --git i/git-svn.perl w/git-svn.perl
> index 5252722..75e7165 100755
> --- i/git-svn.perl
> +++ w/git-svn.perl
> @@ -5644,8 +5644,8 @@ sub show_commit_normal {
> =20
>  	if ($can_localize) {
>  		my $d =3D Locale::gettext->domain("subversion");
> -		$sing_fmt =3D $d->nget($sing_fmt, $plur_fmt, 1);
> -		$plur_fmt =3D $d->nget($sing_fmt, $plur_fmt, 10);
> +		$sing_fmt =3D $d->get($sing_fmt);
> +		$plur_fmt =3D $d->get($plur_fmt);
>  	}
>  	if (my $l =3D $c->{l}) {
>  		while ($l->[$#$l] eq "\n" && $#$l > 0

Thanks Jonathan, that looks much better.  I'll squash that on top
Jens' first patch.

--=20
Eric Wong
