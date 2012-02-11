From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 4/8] gitweb: Push formatting diff lines to
 print_diff_chunk()
Date: Sun, 12 Feb 2012 00:30:54 +0100
Message-ID: <20120212003054.63255bea@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-5-git-send-email-michal.kiedrowicz@gmail.com>
	<m3bop5tjt6.fsf@localhost.localdomain>
	<20120212002025.214b3fb3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 00:31:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwMPK-0000w7-2J
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 00:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab2BKXbA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 18:31:00 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59869 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab2BKXbA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 18:31:00 -0500
Received: by eaah12 with SMTP id h12so1347366eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 15:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=00Jnl64eAuAcZw+IspuaT82RN1wgt6MNnMbrF67cO1c=;
        b=nwSVg5ZWXrDI2X7GzVytruDoB36ChrbDW6YuTXM6lLcPulz0G7X3HtEGaEQ1WLhadi
         RFvvELsGvuNy32LwnYnZoThXJSN2aESqcfItfA7CVFXrwAWdyakmmK8ml8ttzoNiqysY
         I4MjtHHB424X3xk5fh3xFP3IPqO+WxxNpk7Yc=
Received: by 10.14.95.8 with SMTP id o8mr3569503eef.111.1329003058616;
        Sat, 11 Feb 2012 15:30:58 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id v51sm41331841eef.2.2012.02.11.15.30.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 15:30:58 -0800 (PST)
In-Reply-To: <20120212002025.214b3fb3@gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190541>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> wrote:

> Jakub Narebski <jnareb@gmail.com> wrote:
>=20
> > Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
> >=20
> > > Now git_patchset_body() only calls diff_line_class() (removed fro=
m
> > > process_diff_line()). The latter function is renamed to
> > > format_diff_line() and is called from print_diff_chunk().
> > >=20
> > > This is a pure code movement, needed for processing raw diff line=
s in
> > > the accumulator in print_diff_chunk(). No behavior change is inte=
nded by
> > > this change.
> >=20
> > Well, this is not "pure code movement" per se; it is meant to be
> > refactoring that doesn't change gitweb output nor behavior.
> >=20
> > If I understand correctly the change is from
> >=20
> >   read
> >   format
> >   accumulate
> >   print
> > =20
> > to
> >=20
> >   read
> >   accumulate
> >   format
> >   print
> >=20
> > Isn't it?
>=20
> Yeah, this is what I meant :).

Minor correction: The order *does* change, in the sense that first a
chunk is read, then (in print_diff_chunk) formatted and printed,
but in print_diff_chunk() the order remains:

	read line
	format
	put into accumulator
	print
>=20
> >=20
> > As a note I would add also that process_diff_line got renamed to
> > format_diff_line,=20
>=20
> I thought I wrote that ("The latter function is renamed...")?
>=20
> > and its output changed to returning only
> > HTML-formatted line, which bringg it in line with other format_*
> > subroutines.
> >=20
>=20
> OK.
>=20
> > > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.co=
m>
> >=20
> > I think it is a good change even without subsequent patches.
> >=20
> >   Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> >=20
>=20
> Thanks.
>=20
> > > ---
> > >  gitweb/gitweb.perl |   25 ++++++++++++-------------
> > >  1 files changed, 12 insertions(+), 13 deletions(-)
> > >=20
> > > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > > index d2f75c4..cae9dfa 100755
> > > --- a/gitweb/gitweb.perl
> > > +++ b/gitweb/gitweb.perl
> > > @@ -2320,12 +2320,9 @@ sub format_cc_diff_chunk_header {
> > >  }
> > > =20
> > >  # process patch (diff) line (not to be used for diff headers),
> > > -# returning class and HTML-formatted (but not wrapped) line
> > > -sub process_diff_line {
> > > -	my $line =3D shift;
> > > -	my ($from, $to) =3D @_;
> > > -
> > > -	my $diff_class =3D diff_line_class($line, $from, $to);
> > > +# returning HTML-formatted (but not wrapped) line
> > > +sub format_diff_line {
> > > +	my ($line, $diff_class, $from, $to) =3D @_;
> > > =20
> > >  	chomp $line;
> > >  	$line =3D untabify($line);
> > > @@ -2343,7 +2340,7 @@ sub process_diff_line {
> > >  	$diff_classes .=3D " $diff_class" if ($diff_class);
> > >  	$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
> > > =20
> > > -	return $diff_class, $line;
> > > +	return $line;
> > >  }
> > > =20
> > >  # Generates undef or something like "_snapshot_" or "snapshot (_=
tbz2_ _zip_)",
> > > @@ -4934,7 +4931,7 @@ sub print_diff_lines {
> > >  }
> > > =20
> > >  sub print_diff_chunk {
> > > -	my ($diff_style, $is_combined, @chunk) =3D @_;
> > > +	my ($diff_style, $is_combined, $from, $to, @chunk) =3D @_;
> > >  	my (@ctx, @rem, @add);
> > >  	my $prev_class =3D '';
> > > =20
> > > @@ -4954,6 +4951,8 @@ sub print_diff_chunk {
> > >  	foreach my $line_info (@chunk) {
> > >  		my ($class, $line) =3D @$line_info;
> > > =20
> > > +		$line =3D format_diff_line($line, $class, $from, $to);
> > > +
> > >  		# print chunk headers
> > >  		if ($class && $class eq 'chunk_header') {
> > >  			print $line;
> > > @@ -5107,19 +5106,19 @@ sub git_patchset_body {
> > > =20
> > >  			next PATCH if ($patch_line =3D~ m/^diff /);
> > > =20
> > > -			my ($class, $line) =3D process_diff_line($patch_line, \%from,=
 \%to);
> > > +			my $class =3D diff_line_class($patch_line, \%from, \%to);
> > > =20
> > >  			if ($class eq 'chunk_header') {
> > > -				print_diff_chunk($diff_style, $is_combined, @chunk);
> > > -				@chunk =3D ( [ $class, $line ] );
> > > +				print_diff_chunk($diff_style, $is_combined, \%from, \%to, @c=
hunk);
> > > +				@chunk =3D ( [ $class, $patch_line ] );
> > >  			} else {
> > > -				push @chunk, [ $class, $line ];
> > > +				push @chunk, [ $class, $patch_line ];
> > >  			}
> > >  		}
> > > =20
> > >  	} continue {
> > >  		if (@chunk) {
> > > -			print_diff_chunk($diff_style, $is_combined, @chunk);
> > > +			print_diff_chunk($diff_style, $is_combined, \%from, \%to, @ch=
unk);
> > >  			@chunk =3D ();
> > >  		}
> > >  		print "</div>\n"; # class=3D"patch"
> > > --=20
> > > 1.7.3.4
> > >=20
> >=20
> > Nice!
> >=20
