From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/8] gitweb: Move HTML-formatting diff line back to process_diff_line()
Date: Sat, 11 Feb 2012 08:02:57 -0800 (PST)
Message-ID: <m3fwehtl1t.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-4-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 17:03:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwFPl-0001rg-QR
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 17:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963Ab2BKQDA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 11:03:00 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36496 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab2BKQC7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 11:02:59 -0500
Received: by eaah12 with SMTP id h12so1235341eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 08:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=J3cWpP6bSJqy+oEJQIh88MzJsj+EmxSY0dH0I1WmZm4=;
        b=PCntyRN8HQM+TNGrR4JftjL6aQ5d6bCa+MPxEYn8eKPMVSFnJPSLdgxVipTpYzIdEC
         l0S2fuSjSjFOewydRJXci/Mlri7wtFIKp4QEGDccZ7j0Q2yUQpIRKHs8nOhthBumWKLL
         baffLA0QudlDLSpQqmMJyVG9s1AmBzlbrXAuI=
Received: by 10.213.28.136 with SMTP id m8mr1702166ebc.29.1328976178151;
        Sat, 11 Feb 2012 08:02:58 -0800 (PST)
Received: from localhost.localdomain (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id e12sm36863447eea.5.2012.02.11.08.02.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 08:02:57 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1BG2tde016028;
	Sat, 11 Feb 2012 17:02:55 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1BG2sYw016025;
	Sat, 11 Feb 2012 17:02:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328865494-24415-4-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190517>

Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Commit 6ba1eb51b (gitweb: Add a feature to show side-by-side diff,
> 2011-10-31) for no special reason moved wrapping diff line in <div> o=
ut
> of format_diff_line(). Bring back old behavior.
>=20
> This simplifies code in git_patchset_body() and keeps formatting of a
> diff line in one place.
>=20
> The more long-term purpose of this patch is to move formatting diff
> lines down to print_diff_chunk(), to allow processing lines without
> HTML-formatting.
>=20
> This is just a refactoring patch. It's not meant to change gitweb
> output.

Gah, I don't remember why we ended with change in behavior when adding
side-by-side diff support to gitweb.
=20
> Signed-off-by: Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com>

  Acked-by: Jakub Nar=EAbski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ed63261..d2f75c4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2332,14 +2332,18 @@ sub process_diff_line {
> =20
>  	if ($from && $to && $line =3D~ m/^\@{2} /) {
>  		$line =3D format_unidiff_chunk_header($line, $from, $to);
> -		return $diff_class, $line;
> =20
>  	} elsif ($from && $to && $line =3D~ m/^\@{3}/) {
>  		$line =3D format_cc_diff_chunk_header($line, $from, $to);
> -		return $diff_class, $line;
> -
> +	} else {
> +		$line =3D esc_html($line, -nbsp=3D>1);
>  	}
> -	return $diff_class, esc_html($line, -nbsp=3D>1);
> +
> +	my $diff_classes =3D "diff";
> +	$diff_classes .=3D " $diff_class" if ($diff_class);
> +	$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
> +
> +	return $diff_class, $line;
>  }
> =20
>  # Generates undef or something like "_snapshot_" or "snapshot (_tbz2=
_ _zip_)",
> @@ -5104,9 +5108,6 @@ sub git_patchset_body {
>  			next PATCH if ($patch_line =3D~ m/^diff /);
> =20
>  			my ($class, $line) =3D process_diff_line($patch_line, \%from, \%t=
o);
> -			my $diff_classes =3D "diff";
> -			$diff_classes .=3D " $class" if ($class);
> -			$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
> =20
>  			if ($class eq 'chunk_header') {
>  				print_diff_chunk($diff_style, $is_combined, @chunk);
> --=20
> 1.7.3.4
>=20

--=20
Jakub Nar=EAbski
