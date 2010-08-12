From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: gitweb not friendly to firefox revived
Date: Thu, 12 Aug 2010 11:23:56 +0200
Message-ID: <20100812092356.GC9763@pengutronix.de>
References: <20100801195138.GA1980@pengutronix.de> <m3lj8qozan.fsf@localhost.localdomain> <20100803210730.GA1254@pengutronix.de> <201008032350.40117.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de,
	Stephen Boyd <bebarino@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 11:24:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjU17-00078l-8t
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 11:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326Ab0HLJX7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 05:23:59 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49725 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933317Ab0HLJX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 05:23:57 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1OjU0y-0006zW-6G; Thu, 12 Aug 2010 11:23:56 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1OjU0y-0006xC-4E; Thu, 12 Aug 2010 11:23:56 +0200
Content-Disposition: inline
In-Reply-To: <201008032350.40117.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153357>

Hello,

> Nevertheless it shows what's the problem.  Somehow (perhaps wrong
> encoding, perhaps screw up with quoted-printable and git-am, perhaps
> copy'n' paste included ANSII color codes from terminal, perhaps somet=
hing
> different altogether) you got control characters (\e =3D ESC) in $aut=
hor.
> In strict XHTML mode (with 'application/xml
>=20
> Please try the following patch
>=20
> -- >8 --
> From: Jakub Narebski <jnareb@gmail.com>
> Subject: [PATCH] gitweb: Harden format_search_author()
>=20
> Protect format_search_author against control characters in $author.
> While at it simplify it a bit, and use spaces for align.
>=20
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |   29 ++++++++++++++---------------
>  1 files changed, 14 insertions(+), 15 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8b02767..ea9c09c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1856,23 +1856,22 @@ sub format_search_author {
>  	my ($author, $searchtype, $displaytext) =3D @_;
>  	my $have_search =3D gitweb_check_feature('search');
> =20
> -	if ($have_search) {
> -		my $performed =3D "";
> -		if ($searchtype eq 'author') {
> -			$performed =3D "authored";
> -		} elsif ($searchtype eq 'committer') {
> -			$performed =3D "committed";
> -		}
> -
> -		return $cgi->a({-href =3D> href(action=3D>"search", hash=3D>$hash,
> -				searchtext=3D>$author,
> -				searchtype=3D>$searchtype), class=3D>"list",
> -				title=3D>"Search for commits $performed by $author"},
> -				$displaytext);
> +	return $displaytext unless ($have_search);
> =20
> -	} else {
> -		return $displaytext;
> +	my $performed =3D "";
> +	if ($searchtype eq 'author') {
> +		$performed =3D "authored";
> +	} elsif ($searchtype eq 'committer') {
> +		$performed =3D "committed";
>  	}
> +
> +	my $title =3D to_utf8("Search for commits $performed by $author");
> +	$title =3D~ s/[[:cntrl:]]/?/g;
> +
> +	return $cgi->a({-href =3D> href(action=3D>"search", hash=3D>$hash,
> +	                              searchtext=3D>$author, searchtype=3D>=
$searchtype),
> +	                -class=3D>"list", -title=3D>$title},
> +	               $displaytext);
>  }
Seems to do the right thing.  With Firefox I get a correct listing now
instead of the xml parse error.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
