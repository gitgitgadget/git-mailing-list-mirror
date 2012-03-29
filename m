From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v2 7/8] gitweb: Highlight interesting parts of diff
Date: Thu, 29 Mar 2012 21:59:22 +0200
Message-ID: <20120329215922.606f54d4@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1332543417-19664-8-git-send-email-michal.kiedrowicz@gmail.com>
	<201203292142.21680.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 21:59:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDLVb-0008Tb-CH
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 21:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758694Ab2C2T7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 15:59:32 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:55904 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757682Ab2C2T7a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 15:59:30 -0400
Received: by wejx9 with SMTP id x9so1242353wej.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=Zg7dgqRW0tCdUvp4t0nZo7iSp7JVewF+J6bTCK1ICJc=;
        b=CJswsA3MNIwfy/mf7Gz/eP/sQNU2/MPcxZnnyDHzNxUKmf2hz27L2+vVniAYhQOJcp
         Pwm7ChGE2KZFwMQiqH+TnYesWVkmytxN23bIYlzwhN6o971UaJM51rq7DDcwDSQTik66
         bqTKBJcsLD+rhqoIgphO15eUs/pTmCIbwLYzK9lWWVnOtNFki2E6l9PICmbm+A4uT2V2
         7aUhp/DjYdjB/I63DwQZwuOMkgvbB8qgvA4fUTz1aIz79YT4K6xBMvcoiZstzhd7QHio
         93Gn8d9zFMxvcmpsiZMrzw3AJzHVqBTix4zmDA/oJa0JsBAN8JkovtWrt+IORTD/KGWk
         SiIQ==
Received: by 10.180.88.67 with SMTP id be3mr8714552wib.20.1333051169315;
        Thu, 29 Mar 2012 12:59:29 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id u9sm2206954wix.0.2012.03.29.12.59.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 12:59:28 -0700 (PDT)
In-Reply-To: <201203292142.21680.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194288>

Jakub Narebski <jnareb@gmail.com> wrote:

> On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:
>=20
> > Reading diff output is sometimes very hard, even if it's colored,
> > especially if lines differ only in few characters.  This is often t=
rue
> > when a commit fixes a typo or renames some variables or functions.
> >=20
> > This commit teaches gitweb to highlight characters that are differe=
nt
> > between old and new line with a light green/red background.  This s=
hould
> > work in the similar manner as in Trac or GitHub.
> >=20
> > The algorithm that compares lines is based on contrib/diff-highligh=
t.
> > Basically, it works by determining common prefix/suffix of correspo=
nding
> > lines and highlightning only the middle part of lines.  For more
> > information, see contrib/diff-highlight/README.
> >
> Nice description.
> =20
> > Combined diffs are not supported but a following commit will change=
 it.
> >=20
> O.K.
>=20
> > Two changes in format_diff_line() were needed to allow diff refinem=
ent
> > highlightning to work.  Firstly, format_diff_line() was taught to n=
ot
> > esc_html() line that was passed as a reference.  This was needed be=
cause
> > refining the highlight must be performed on unescaped lines and it =
uses
> > a <span> element to mark interesting parts of the line.
>=20
> Well, actually we just need to make format_diff_line to not esc_html
> passed line which is already esc_html'ed or esc_html_hl_regions'ed,
> i.e. to avoid double escaping.  Passing line as reference if it is
> to be treated as HTML is one possibility, and I think it is a good
> convention to start to use.
>=20
> >                                                         Secondly, t=
he=20
> > lines are untabified before comparing because calling untabify()
> > after inserting <span>'s could improperly convert tabs to spaces.
>=20
> Well, it is actually because untabify() must work on original text to
> work correctly, i.e. to convert tabs to spaces according to tab stops=
=2E
> It must precede esc_html'ing, and even more esc_html_hl_regions'ing.
>=20
> >=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
>=20
> Anyway this is a good change, much cleaner than previous version
>=20
>   Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

Thanks.

>=20
> > ---
> >  gitweb/gitweb.perl       |   84 ++++++++++++++++++++++++++++++++++=
++++++++----
> >  gitweb/static/gitweb.css |    8 ++++
> >  2 files changed, 85 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index db32588..872ba12 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -2426,14 +2426,14 @@ sub format_cc_diff_chunk_header {
> >  }
> > =20
> >  # process patch (diff) line (not to be used for diff headers),
> > -# returning HTML-formatted (but not wrapped) line
> > +# returning HTML-formatted (but not wrapped) line.
> > +# If the line is already esc_html()'ed, pass it as a reference.
>=20
> Errr... I think the explanation here must be in reverse:
>=20
>   +# If the line is passed as a reference, it is treated as HTML,
>   +# and not esc_html()'ed.

Yeah, I thought about that option too :).

>=20
> >  sub format_diff_line {
> >  	my ($line, $diff_class, $from, $to) =3D @_;
> > =20
> > -	chomp $line;
> > -	$line =3D untabify($line);
> > -
> > -	if ($from && $to && $line =3D~ m/^\@{2} /) {
> > +	if (ref($line)) {
> > +		$line =3D $$line;
> > +	} elsif ($from && $to && $line =3D~ m/^\@{2} /) {
> >  		$line =3D format_unidiff_chunk_header($line, $from, $to);
> >  	} elsif ($from && $to && $line =3D~ m/^\@{3}/) {
> >  		$line =3D format_cc_diff_chunk_header($line, $from, $to);
> > @@ -5054,10 +5054,80 @@ sub print_inline_diff_lines {
> >  	print foreach (@$add);
> >  }
> > =20
> > +# Format removed and added line, mark changed part and HTML-format=
 them.
> > +# Impementation is based on contrib/diff-highlight
> > +sub format_rem_add_line {
>=20
> Wouldn't a better name be format_rem_add_pair() or format_rem_add_lin=
es(),
> or format_rem_add_lines_pair()?

OK.

>=20
> > +	my ($rem, $add) =3D @_;
> > +	my @rem =3D split(//, $rem);
> > +	my @add =3D split(//, $add);
> > +	my ($esc_rem, $esc_add);
> > +	# Ignore +/- character, thus $prefix_len is set to 1.
> > +	my ($prefix_len, $suffix_len) =3D (1, 0);
>=20
> I wonder if it wouldn't be slightly cleaner to count $prefix_len from
> +/- rather than start of line.  It means
>=20
>   +	# Prefix does not count initial +/- character.
>   +	my ($prefix_len, $suffix_len) =3D (0, 0);
>=20
> Perhaps even remove initial +/- from @add and @rem.
>=20
>   +	shift @rem;
>   +	shift @add;
>=20
> Ehh... now I see that starting $prefix_len with 1 might be not so bad
> idea after all.
>=20
> > +	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
>=20
> It is not entirely true: $prefix_is_space is really $prefix_is_space_=
or_empty.
> It might be a better idea to use
>=20
>   +	my ($prefix_has_nonspace, $suffix_has_nonspace);
>=20
> using the fact that undefined value is false.
>=20
> > +
> > +	while ($prefix_len < @rem && $prefix_len < @add) {
> > +		last if ($rem[$prefix_len] ne $add[$prefix_len]);
> > +
> > +		$prefix_is_space =3D 0 if ($rem[$prefix_len] !~ /\s/);
>=20
>   +		$prefix_has_nonspace =3D 1 if ($rem[$prefix_len] =3D~ /\s/);
>=20
> > +		$prefix_len++;
> > +	}
> > +
> > +	my $shorter =3D (@rem < @add) ? @rem : @add;
> > +	while ($prefix_len + $suffix_len < $shorter) {
> > +		last if ($rem[-1 - $suffix_len] ne $add[-1 - $suffix_len]);
> > +
> > +		$suffix_is_space =3D 0 if ($rem[-1 - $suffix_len] !~ /\s/);
>=20
>   +		$suffix_has_nonspace =3D 1 if ($rem[-1 - $suffix_len] =3D~ /\s/)=
;
>=20
> > +		$suffix_len++;
> > +	}
> > +
> > +	# Mark lines that are different from each other, but have some co=
mmon
> > +	# part that isn't whitespace.  If lines are completely different,=
 don't
> > +	# mark them because that would make output unreadable, especially=
 if
> > +	# diff consists of multiple lines.
> > +	if (($prefix_len =3D=3D 1 && $suffix_len =3D=3D 0) ||
> > +	    ($prefix_is_space && $suffix_is_space)) {
>=20
> Actually ($prefix_is_space && $suffix_is_space) is enough, but crypti=
c.

Yes, you caught was I thought too but hadn't wrote explicitly.  The
first condition ($prefix_len =3D=3D 1 && $suffix_len =3D=3D 0) is redun=
dant but
makes the condition easier to understand.

> With $prefix_is_space (=3D=3D $prefix_is_space_or_empty) -> $prefix_h=
as_nonspace
> it would be
>=20
>   +	if (not ($prefix_has_nonspace || $suffix_has_nonspace)) {
>=20
> Anyway, it is not as if it is not clear enough.

I may play with this for a while to see which version looks best.

>=20
> > +		$esc_rem =3D esc_html($rem, -nbsp=3D>1);
> > +		$esc_add =3D esc_html($add, -nbsp=3D>1);
> > +	} else {
> > +		$esc_rem =3D esc_html_hl_regions($rem, 'marked', [$prefix_len, @=
rem - $suffix_len], -nbsp=3D>1);
> > +		$esc_add =3D esc_html_hl_regions($add, 'marked', [$prefix_len, @=
add - $suffix_len], -nbsp=3D>1);
>=20
>   +		$esc_rem =3D esc_html_hl_regions($rem, 'marked', [$prefix_len+1,=
 @rem+1 - $suffix_len], -nbsp=3D>1);
>   +		$esc_add =3D esc_html_hl_regions($add, 'marked', [$prefix_len+1,=
 @add+1 - $suffix_len], -nbsp=3D>1);
>=20
> So probably not worth it.
>=20
> > +	}
> > +
> > +	return format_diff_line(\$esc_rem, 'rem'),
> > +	        format_diff_line(\$esc_add, 'add');
>=20
>   +	return format_diff_line(\$esc_rem, 'rem'),
>   +	       format_diff_line(\$esc_add, 'add');
>=20
> > +}
> > +
> > +# HTML-format diff context, removed and added lines.
> > +sub format_ctx_rem_add_lines {
> > +	my ($ctx, $rem, $add, $is_combined) =3D @_;
> > +	my (@new_ctx, @new_rem, @new_add);
> > +
> > +	# Highlight if every removed line has a corresponding added line.
> > +	# Combined diffs are not supported ATM.
>=20
> ATM =3D=3D at this moment?  Please say so.

OK.

>=20
> > +	if (!$is_combined && @$add > 0 && @$add =3D=3D @$rem) {
> > +		for (my $i =3D 0; $i < @$add; $i++) {
> > +			my ($line_rem, $line_add) =3D format_rem_add_line(
> > +			        $rem->[$i], $add->[$i]);
>=20
>   +			my ($line_rem, $line_add) =3D
>   +			        format_rem_add_line($rem->[$i], $add->[$i]);
>=20
> > +			push @new_rem, $line_rem;
> > +			push @new_add, $line_add;
> > +		}
> > +	} else {
> > +		@new_rem =3D map { format_diff_line($_, 'rem') } @$rem;
> > +		@new_add =3D map { format_diff_line($_, 'add') } @$add;
> > +	}
> > +
> > +	@new_ctx =3D map { format_diff_line($_, 'ctx') } @$ctx;
> > +
> > +	return (\@new_ctx, \@new_rem, \@new_add);
> > +}
>=20
> Nice.
>=20
> > +
> >  # Print context lines and then rem/add lines.
> >  sub print_diff_lines {
> >  	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
> > =20
> > +	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add,
> > +		$is_combined);
> > +
>=20
>   +	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add,=
	$is_combined);
>   +
>=20
> Unless the line is too long.
>=20
> >  	if ($diff_style eq 'sidebyside' && !$is_combined) {
> >  		print_sidebyside_diff_lines($ctx, $rem, $add);
> >  	} else {
> > @@ -5089,11 +5159,11 @@ sub print_diff_chunk {
> >  	foreach my $line_info (@chunk) {
> >  		my ($class, $line) =3D @$line_info;
> > =20
> > -		$line =3D format_diff_line($line, $class, $from, $to);
> > +		$line =3D untabify($line);
>=20
> O.K. you move untabify() out of format_diff_line(), and must now
> ensure that caller uses it before calling format_diff_line() or=20
> format_ctx_rem_add_lines() (which uses format_diff_line() itself).
>=20
> I wonder if leaving untabify() (and chomp) in format_diff_line(),
> but not running it if passed reference, and running untabify() in
> format_ctx_rem_add_lines() wouldn't be a better, less fragile code.
>=20

I can try that.

> > =20
> >  		# print chunk headers
> >  		if ($class && $class eq 'chunk_header') {
> > -			print $line;
> > +			print format_diff_line($line, $class, $from, $to);
>=20
> O.K., only 'chunk_header' are not formatted.
>=20
> >  			next;
> >  		}
>=20
> [I have to take a look how final version of print_diff_lines() looks
>  like in this commit; the patch alone is not enough]
>=20
> Right, so we format just before printing, and print_* do formatting
> itself before printing.  Nice and clean.

Thanks.

>=20
> > =20
> > diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> > index c530355..3c4a3c9 100644
> > --- a/gitweb/static/gitweb.css
> > +++ b/gitweb/static/gitweb.css
> > @@ -438,6 +438,10 @@ div.diff.add {
> >  	color: #008800;
> >  }
> > =20
> > +div.diff.add span.marked {
> > +	background-color: #77ff77;
> > +}
> > +
> >  div.diff.from_file a.path,
> >  div.diff.from_file {
> >  	color: #aa0000;
> > @@ -447,6 +451,10 @@ div.diff.rem {
> >  	color: #cc0000;
> >  }
> > =20
> > +div.diff.rem span.marked {
> > +	background-color: #ff7777;
> > +}
> > +
> >  div.diff.chunk_header a,
> >  div.diff.chunk_header {
> >  	color: #990099;
> > --=20
>=20
> Nice styling.
>=20
