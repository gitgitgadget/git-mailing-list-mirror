From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/8] gitweb: Push formatting diff lines to print_diff_chunk()
Date: Sat, 11 Feb 2012 08:29:45 -0800 (PST)
Message-ID: <m3bop5tjt6.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-5-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 17:29:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwFpi-0007Zn-Hn
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 17:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab2BKQ3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 11:29:48 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47230 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab2BKQ3r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 11:29:47 -0500
Received: by eaah12 with SMTP id h12so1240772eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 08:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=2wer3B1L2SwO0ADN9z6PwqArxOBkZxh8Pyrcje+yS/w=;
        b=Uh4bZeI0cTcAbG96PHW78zUGLJq0x1/k37DX0Z5pYK9ryPmBWFEXw5XWU5C7YTCj43
         s60/TEZEBs8BdBQS1Y4FetPot+xecqMcWXOiEa7nMpdduxMuynIP17GvrfeTJJO1zTuf
         IyouMubn45EAl3L9sPijaTNCpcZqwZQL3tTvo=
Received: by 10.213.7.20 with SMTP id b20mr815433ebb.73.1328977785824;
        Sat, 11 Feb 2012 08:29:45 -0800 (PST)
Received: from localhost.localdomain (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id n58sm37081752een.10.2012.02.11.08.29.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 08:29:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1BGTgil016324;
	Sat, 11 Feb 2012 17:29:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1BGTgDP016321;
	Sat, 11 Feb 2012 17:29:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328865494-24415-5-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190518>

Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Now git_patchset_body() only calls diff_line_class() (removed from
> process_diff_line()). The latter function is renamed to
> format_diff_line() and is called from print_diff_chunk().
>=20
> This is a pure code movement, needed for processing raw diff lines in
> the accumulator in print_diff_chunk(). No behavior change is intended=
 by
> this change.

Well, this is not "pure code movement" per se; it is meant to be
refactoring that doesn't change gitweb output nor behavior.

If I understand correctly the change is from

  read
  format
  accumulate
  print
=20
to

  read
  accumulate
  format
  print

Isn't it?

As a note I would add also that process_diff_line got renamed to
format_diff_line, and its output changed to returning only
HTML-formatted line, which bringg it in line with other format_*
subroutines.

> Signed-off-by: Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com>

I think it is a good change even without subsequent patches.

  Acked-by: Jakub Nar=EAbski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   25 ++++++++++++-------------
>  1 files changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d2f75c4..cae9dfa 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2320,12 +2320,9 @@ sub format_cc_diff_chunk_header {
>  }
> =20
>  # process patch (diff) line (not to be used for diff headers),
> -# returning class and HTML-formatted (but not wrapped) line
> -sub process_diff_line {
> -	my $line =3D shift;
> -	my ($from, $to) =3D @_;
> -
> -	my $diff_class =3D diff_line_class($line, $from, $to);
> +# returning HTML-formatted (but not wrapped) line
> +sub format_diff_line {
> +	my ($line, $diff_class, $from, $to) =3D @_;
> =20
>  	chomp $line;
>  	$line =3D untabify($line);
> @@ -2343,7 +2340,7 @@ sub process_diff_line {
>  	$diff_classes .=3D " $diff_class" if ($diff_class);
>  	$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
> =20
> -	return $diff_class, $line;
> +	return $line;
>  }
> =20
>  # Generates undef or something like "_snapshot_" or "snapshot (_tbz2=
_ _zip_)",
> @@ -4934,7 +4931,7 @@ sub print_diff_lines {
>  }
> =20
>  sub print_diff_chunk {
> -	my ($diff_style, $is_combined, @chunk) =3D @_;
> +	my ($diff_style, $is_combined, $from, $to, @chunk) =3D @_;
>  	my (@ctx, @rem, @add);
>  	my $prev_class =3D '';
> =20
> @@ -4954,6 +4951,8 @@ sub print_diff_chunk {
>  	foreach my $line_info (@chunk) {
>  		my ($class, $line) =3D @$line_info;
> =20
> +		$line =3D format_diff_line($line, $class, $from, $to);
> +
>  		# print chunk headers
>  		if ($class && $class eq 'chunk_header') {
>  			print $line;
> @@ -5107,19 +5106,19 @@ sub git_patchset_body {
> =20
>  			next PATCH if ($patch_line =3D~ m/^diff /);
> =20
> -			my ($class, $line) =3D process_diff_line($patch_line, \%from, \%t=
o);
> +			my $class =3D diff_line_class($patch_line, \%from, \%to);
> =20
>  			if ($class eq 'chunk_header') {
> -				print_diff_chunk($diff_style, $is_combined, @chunk);
> -				@chunk =3D ( [ $class, $line ] );
> +				print_diff_chunk($diff_style, $is_combined, \%from, \%to, @chunk=
);
> +				@chunk =3D ( [ $class, $patch_line ] );
>  			} else {
> -				push @chunk, [ $class, $line ];
> +				push @chunk, [ $class, $patch_line ];
>  			}
>  		}
> =20
>  	} continue {
>  		if (@chunk) {
> -			print_diff_chunk($diff_style, $is_combined, @chunk);
> +			print_diff_chunk($diff_style, $is_combined, \%from, \%to, @chunk)=
;
>  			@chunk =3D ();
>  		}
>  		print "</div>\n"; # class=3D"patch"
> --=20
> 1.7.3.4
>=20

Nice!

--=20
Jakub Nar=EAbski
