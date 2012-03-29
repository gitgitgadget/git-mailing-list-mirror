From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 7/8] gitweb: Highlight interesting parts of diff
Date: Thu, 29 Mar 2012 20:42:20 +0100
Message-ID: <201203292142.21680.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <1332543417-19664-8-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 21:42:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDLEs-0007rs-ET
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 21:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758933Ab2C2TmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 15:42:25 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:47511 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab2C2TmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 15:42:24 -0400
Received: by wejx9 with SMTP id x9so1233125wej.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 12:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=TgUOSJOz+jpHncUTu3ft7bxJsPknGs1dJitaBDCWoIs=;
        b=qOgCPc+ZXx9n8zDU6f6TkNVg5yibJy4OHn+VQUiC92lkRhIkk0kquYnAjeaFQ3UmKz
         zIFa+nN3sSWIyqKfl4oxHAZfcqML7N1ylx7OsfO2gL/EgzsqTC7f5oAH9PfH3yvbn9cA
         2iNK6/6dw1KUZRzprkPqBhfENIA3+NRZ9OQ3kvoa/TmQqiJd7vaI2SI2ieJcoZZsFaG1
         lbqrON6G9VvEEs3fb7hhxwchO99UrEmFSSYW1AiN4OOybdbzM/4R8/dKBw/O/MOp062U
         2IDyomsURL3PM83vVfU62jjIQMOKsQFcI2mcN3foKlW5hrHSZMWosjSiq0fKZQNMufyJ
         xPjg==
Received: by 10.180.88.67 with SMTP id be3mr8579748wib.20.1333050142575;
        Thu, 29 Mar 2012 12:42:22 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id fz9sm69504727wib.3.2012.03.29.12.42.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 12:42:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1332543417-19664-8-git-send-email-michal.kiedrowicz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194287>

On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:

> Reading diff output is sometimes very hard, even if it's colored,
> especially if lines differ only in few characters.  This is often tru=
e
> when a commit fixes a typo or renames some variables or functions.
>=20
> This commit teaches gitweb to highlight characters that are different
> between old and new line with a light green/red background.  This sho=
uld
> work in the similar manner as in Trac or GitHub.
>=20
> The algorithm that compares lines is based on contrib/diff-highlight.
> Basically, it works by determining common prefix/suffix of correspond=
ing
> lines and highlightning only the middle part of lines.  For more
> information, see contrib/diff-highlight/README.
>
Nice description.
=20
> Combined diffs are not supported but a following commit will change i=
t.
>=20
O.K.

> Two changes in format_diff_line() were needed to allow diff refinemen=
t
> highlightning to work.  Firstly, format_diff_line() was taught to not
> esc_html() line that was passed as a reference.  This was needed beca=
use
> refining the highlight must be performed on unescaped lines and it us=
es
> a <span> element to mark interesting parts of the line.

Well, actually we just need to make format_diff_line to not esc_html
passed line which is already esc_html'ed or esc_html_hl_regions'ed,
i.e. to avoid double escaping.  Passing line as reference if it is
to be treated as HTML is one possibility, and I think it is a good
convention to start to use.

>                                                         Secondly, the=
=20
> lines are untabified before comparing because calling untabify()
> after inserting <span>'s could improperly convert tabs to spaces.

Well, it is actually because untabify() must work on original text to
work correctly, i.e. to convert tabs to spaces according to tab stops.
It must precede esc_html'ing, and even more esc_html_hl_regions'ing.

>=20
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>

Anyway this is a good change, much cleaner than previous version

  Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl       |   84 ++++++++++++++++++++++++++++++++++++=
++++++----
>  gitweb/static/gitweb.css |    8 ++++
>  2 files changed, 85 insertions(+), 7 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index db32588..872ba12 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2426,14 +2426,14 @@ sub format_cc_diff_chunk_header {
>  }
> =20
>  # process patch (diff) line (not to be used for diff headers),
> -# returning HTML-formatted (but not wrapped) line
> +# returning HTML-formatted (but not wrapped) line.
> +# If the line is already esc_html()'ed, pass it as a reference.

Errr... I think the explanation here must be in reverse:

  +# If the line is passed as a reference, it is treated as HTML,
  +# and not esc_html()'ed.

>  sub format_diff_line {
>  	my ($line, $diff_class, $from, $to) =3D @_;
> =20
> -	chomp $line;
> -	$line =3D untabify($line);
> -
> -	if ($from && $to && $line =3D~ m/^\@{2} /) {
> +	if (ref($line)) {
> +		$line =3D $$line;
> +	} elsif ($from && $to && $line =3D~ m/^\@{2} /) {
>  		$line =3D format_unidiff_chunk_header($line, $from, $to);
>  	} elsif ($from && $to && $line =3D~ m/^\@{3}/) {
>  		$line =3D format_cc_diff_chunk_header($line, $from, $to);
> @@ -5054,10 +5054,80 @@ sub print_inline_diff_lines {
>  	print foreach (@$add);
>  }
> =20
> +# Format removed and added line, mark changed part and HTML-format t=
hem.
> +# Impementation is based on contrib/diff-highlight
> +sub format_rem_add_line {

Wouldn't a better name be format_rem_add_pair() or format_rem_add_lines=
(),
or format_rem_add_lines_pair()?

> +	my ($rem, $add) =3D @_;
> +	my @rem =3D split(//, $rem);
> +	my @add =3D split(//, $add);
> +	my ($esc_rem, $esc_add);
> +	# Ignore +/- character, thus $prefix_len is set to 1.
> +	my ($prefix_len, $suffix_len) =3D (1, 0);

I wonder if it wouldn't be slightly cleaner to count $prefix_len from
+/- rather than start of line.  It means

  +	# Prefix does not count initial +/- character.
  +	my ($prefix_len, $suffix_len) =3D (0, 0);

Perhaps even remove initial +/- from @add and @rem.

  +	shift @rem;
  +	shift @add;

Ehh... now I see that starting $prefix_len with 1 might be not so bad
idea after all.

> +	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);

It is not entirely true: $prefix_is_space is really $prefix_is_space_or=
_empty.
It might be a better idea to use

  +	my ($prefix_has_nonspace, $suffix_has_nonspace);

using the fact that undefined value is false.

> +
> +	while ($prefix_len < @rem && $prefix_len < @add) {
> +		last if ($rem[$prefix_len] ne $add[$prefix_len]);
> +
> +		$prefix_is_space =3D 0 if ($rem[$prefix_len] !~ /\s/);

  +		$prefix_has_nonspace =3D 1 if ($rem[$prefix_len] =3D~ /\s/);

> +		$prefix_len++;
> +	}
> +
> +	my $shorter =3D (@rem < @add) ? @rem : @add;
> +	while ($prefix_len + $suffix_len < $shorter) {
> +		last if ($rem[-1 - $suffix_len] ne $add[-1 - $suffix_len]);
> +
> +		$suffix_is_space =3D 0 if ($rem[-1 - $suffix_len] !~ /\s/);

  +		$suffix_has_nonspace =3D 1 if ($rem[-1 - $suffix_len] =3D~ /\s/);

> +		$suffix_len++;
> +	}
> +
> +	# Mark lines that are different from each other, but have some comm=
on
> +	# part that isn't whitespace.  If lines are completely different, d=
on't
> +	# mark them because that would make output unreadable, especially i=
f
> +	# diff consists of multiple lines.
> +	if (($prefix_len =3D=3D 1 && $suffix_len =3D=3D 0) ||
> +	    ($prefix_is_space && $suffix_is_space)) {

Actually ($prefix_is_space && $suffix_is_space) is enough, but cryptic.
With $prefix_is_space (=3D=3D $prefix_is_space_or_empty) -> $prefix_has=
_nonspace
it would be

  +	if (not ($prefix_has_nonspace || $suffix_has_nonspace)) {

Anyway, it is not as if it is not clear enough.

> +		$esc_rem =3D esc_html($rem, -nbsp=3D>1);
> +		$esc_add =3D esc_html($add, -nbsp=3D>1);
> +	} else {
> +		$esc_rem =3D esc_html_hl_regions($rem, 'marked', [$prefix_len, @re=
m - $suffix_len], -nbsp=3D>1);
> +		$esc_add =3D esc_html_hl_regions($add, 'marked', [$prefix_len, @ad=
d - $suffix_len], -nbsp=3D>1);

  +		$esc_rem =3D esc_html_hl_regions($rem, 'marked', [$prefix_len+1, @=
rem+1 - $suffix_len], -nbsp=3D>1);
  +		$esc_add =3D esc_html_hl_regions($add, 'marked', [$prefix_len+1, @=
add+1 - $suffix_len], -nbsp=3D>1);

So probably not worth it.

> +	}
> +
> +	return format_diff_line(\$esc_rem, 'rem'),
> +	        format_diff_line(\$esc_add, 'add');

  +	return format_diff_line(\$esc_rem, 'rem'),
  +	       format_diff_line(\$esc_add, 'add');

> +}
> +
> +# HTML-format diff context, removed and added lines.
> +sub format_ctx_rem_add_lines {
> +	my ($ctx, $rem, $add, $is_combined) =3D @_;
> +	my (@new_ctx, @new_rem, @new_add);
> +
> +	# Highlight if every removed line has a corresponding added line.
> +	# Combined diffs are not supported ATM.

ATM =3D=3D at this moment?  Please say so.

> +	if (!$is_combined && @$add > 0 && @$add =3D=3D @$rem) {
> +		for (my $i =3D 0; $i < @$add; $i++) {
> +			my ($line_rem, $line_add) =3D format_rem_add_line(
> +			        $rem->[$i], $add->[$i]);

  +			my ($line_rem, $line_add) =3D
  +			        format_rem_add_line($rem->[$i], $add->[$i]);

> +			push @new_rem, $line_rem;
> +			push @new_add, $line_add;
> +		}
> +	} else {
> +		@new_rem =3D map { format_diff_line($_, 'rem') } @$rem;
> +		@new_add =3D map { format_diff_line($_, 'add') } @$add;
> +	}
> +
> +	@new_ctx =3D map { format_diff_line($_, 'ctx') } @$ctx;
> +
> +	return (\@new_ctx, \@new_rem, \@new_add);
> +}

Nice.

> +
>  # Print context lines and then rem/add lines.
>  sub print_diff_lines {
>  	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
> =20
> +	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add,
> +		$is_combined);
> +

  +	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add,	$=
is_combined);
  +

Unless the line is too long.

>  	if ($diff_style eq 'sidebyside' && !$is_combined) {
>  		print_sidebyside_diff_lines($ctx, $rem, $add);
>  	} else {
> @@ -5089,11 +5159,11 @@ sub print_diff_chunk {
>  	foreach my $line_info (@chunk) {
>  		my ($class, $line) =3D @$line_info;
> =20
> -		$line =3D format_diff_line($line, $class, $from, $to);
> +		$line =3D untabify($line);

O.K. you move untabify() out of format_diff_line(), and must now
ensure that caller uses it before calling format_diff_line() or=20
format_ctx_rem_add_lines() (which uses format_diff_line() itself).

I wonder if leaving untabify() (and chomp) in format_diff_line(),
but not running it if passed reference, and running untabify() in
format_ctx_rem_add_lines() wouldn't be a better, less fragile code.

> =20
>  		# print chunk headers
>  		if ($class && $class eq 'chunk_header') {
> -			print $line;
> +			print format_diff_line($line, $class, $from, $to);

O.K., only 'chunk_header' are not formatted.

>  			next;
>  		}

[I have to take a look how final version of print_diff_lines() looks
 like in this commit; the patch alone is not enough]

Right, so we format just before printing, and print_* do formatting
itself before printing.  Nice and clean.

> =20
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index c530355..3c4a3c9 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -438,6 +438,10 @@ div.diff.add {
>  	color: #008800;
>  }
> =20
> +div.diff.add span.marked {
> +	background-color: #77ff77;
> +}
> +
>  div.diff.from_file a.path,
>  div.diff.from_file {
>  	color: #aa0000;
> @@ -447,6 +451,10 @@ div.diff.rem {
>  	color: #cc0000;
>  }
> =20
> +div.diff.rem span.marked {
> +	background-color: #ff7777;
> +}
> +
>  div.diff.chunk_header a,
>  div.diff.chunk_header {
>  	color: #990099;
> --=20

Nice styling.

--=20
Jakub Narebski
Poland
