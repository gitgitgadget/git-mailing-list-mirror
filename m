From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Sat, 11 Feb 2012 15:45:29 -0800 (PST)
Message-ID: <m3y5s9rl3g.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 00:45:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwMdL-0001Ud-RR
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 00:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab2BKXpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 18:45:31 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54650 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab2BKXpa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 18:45:30 -0500
Received: by eaah12 with SMTP id h12so1349823eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 15:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=antQ6IMaA7S4XfEiB2RXqklYuqqr924yivXPeJmJNZc=;
        b=LuuOk1IulXfr1+apdPZs1DTfAedZIsCeQdd/ECi4xG6qkxfwKxMXMjWOpteEM9imqy
         25Ljc/ISTRkyRmYkAShpSDB+et9KrHp+erNc8qrDxjyBgD/i9mQ4zEr1U2jydUHOxCgk
         3N8ZYddK7zI/BKzaHw8/SuW92SU2A39SUxKo8=
Received: by 10.213.105.71 with SMTP id s7mr1816263ebo.23.1329003929382;
        Sat, 11 Feb 2012 15:45:29 -0800 (PST)
Received: from localhost.localdomain (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id z47sm41392735eeh.9.2012.02.11.15.45.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 15:45:29 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1BNj330021819;
	Sun, 12 Feb 2012 00:45:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1BNiqsO021816;
	Sun, 12 Feb 2012 00:44:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190546>

Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Reading diff output is sometimes very hard, even if it's colored,
> especially if lines differ only in few characters.  This is often tru=
e
> when a commit fixes a typo or renames some variables or functions.
>
This is certainly nice feature to have.  I think most tools that
implement side-by-side diff implement this too.

> This commit teaches gitweb to highlight characters that are different
> between old and new line.  This should work in the similar manner as =
in
> Trac or GitHub.
>
Doe you have URLs with good examples of such diff refinement
highlighting (GNU Emacs ediff/emerge terminology) / highlighting
differing segments (diff-highlight terminology)?
=20
> The code that compares lines is based on
> contrib/diff-highlight/diff-highlight, except that it works with
> multiline changes too.  It also won't highlight lines that are
> completely different because that would only make the output unreadab=
le.
>
So what does it look like?  From the contrib/diff-highlight/README I
guess that it finds common prefix and common suffix, and highlights
the rest, which includes change.  It doesn't implement LCS / diff
algorithm like e.g. tkdiff does for its diff refinement highlighting,
isn't it?

By completly different you mean that they do not have common prefix or
common suffix (at least one of them), isn't it?

> Combined diffs are not supported but a following commit will change i=
t.
>=20
O.K.

> Signed-off-by: Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>  gitweb/gitweb.perl |   82 ++++++++++++++++++++++++++++++++++++++++++=
++++++---
>  1 files changed, 77 insertions(+), 5 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index db61553..1a5b454 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2322,7 +2322,7 @@ sub format_cc_diff_chunk_header {
>  # wrap patch (diff) line into a <div> (not to be used for diff heade=
rs),
>  # the line must be esc_html()'ed
>  sub format_diff_line {
> -	my ($line, $diff_class, $from, $to) =3D @_;
> +	my ($line, $diff_class) =3D @_;

Why that change?

> =20
>  	my $diff_classes =3D "diff";
>  	$diff_classes .=3D " $diff_class" if ($diff_class);
> @@ -4923,14 +4923,85 @@ sub print_inline_diff_lines {
>  	print foreach (@$add);
>  }
> =20
> +# Highlight characters from $prefix to $suffix and escape HTML.
> +# $str is a reference to the array of characters.
> +sub esc_html_mark_range {
> +	my ($str, $prefix, $suffix) =3D @_;
> +
> +	# Don't generate empty <span> element.
> +	if ($prefix =3D=3D $suffix + 1) {
> +		return esc_html(join('', @$str), -nbsp=3D>1);
> +	}
> +
> +	my $before =3D join('', @{$str}[0..($prefix - 1)]);
> +	my $marked =3D join('', @{$str}[$prefix..$suffix]);
> +	my $after =3D join('', @{$str}[($suffix + 1)..$#{$str}]);

Eeeeeek!  First you split into letters, in caller at that, then join?
Why not pass striung ($str suggests string not array of characters),
and use substr instead?

[Please disregard this and the next paragraph at first reading]

> +
> +	return esc_html($before, -nbsp=3D>1) .
> +		$cgi->span({-class=3D>'marked'}, esc_html($marked, -nbsp=3D>1)) .
> +		esc_html($after,-nbsp=3D>1);
> +}

Anyway I have send to git mailing list a patch series, which in one of
patches adds esc_html_match_hl($str, $regexp) to highlight matches in
a string.  Your esc_html_mark_range(), after a generalization, could
be used as underlying "engine".

Something like this, perhaps (untested):

   # Highlight selected fragments of string, using given CSS class,
   # and escape HTML.  It is assumed that fragments do not overlap.
   # Regions are passed as list of pairs (array references).
   sub esc_html_hl {
        my ($str, $css_class, @sel) =3D @_;
        return esc_html($str) unless @sel;
  =20
        my $out =3D '';
        my $pos =3D 0;
  =20
        for my $s (@sel) {
                $out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
                        if ($s->[0] - $pos > 0);
                $out .=3D $cgi->span({-class =3D> $css_class},
                                   esc_html(substr($str, $s->[0], $s->[=
1] - $s->[0])));

                $pos =3D $m->[1];
        }
        $out .=3D esc_html(substr($str, $pos))
                if ($pos < length($str));
  =20
        return $out;
   }

> +
> +# Format removed and added line, mark changed part and HTML-format t=
hem.

You should probably ad here that this code is taken from
diff-highlight in contrib area, isn't it?

> +sub format_rem_add_line {
> +	my ($rem, $add) =3D @_;
> +	my @r =3D split(//, $rem);
> +	my @a =3D split(//, $add);
> +	my ($esc_rem, $esc_add);
> +	my ($prefix, $suffix_rem, $suffix_add) =3D (1, $#r, $#a);

It is not as much $prefix, as $prefix_len, isn't it?  Shouldn't
$prefix / $prefix_len start from 0, not from 1?

> +	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
> +
> +	while ($prefix < @r && $prefix < @a) {
> +		last if ($r[$prefix] ne $a[$prefix]);
> +
> +		$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s/);
> +		$prefix++;
> +	}

Ah, I see that it is easier to find common prefix by treating string
as array of characters.

Though I wonder if it wouldn't be easier to use trick of XOR-ing two
strings (see "Bitwise String Operators" in perlop(1)):

        my $xor =3D "$rem" ^ "$add";

and finding starting sequence of "\0", which denote common prefix.


Though this and the following is a nice implementation of
algorithm... as it would be implemented in C.  Nevermind, it might be
good enough...

> +
> +	while ($suffix_rem >=3D $prefix && $suffix_add >=3D $prefix) {
> +		last if ($r[$suffix_rem] ne $a[$suffix_add]);
> +
> +		$suffix_is_space =3D 0 if ($r[$suffix_rem] !~ /\s/);
> +		$suffix_rem--;
> +		$suffix_add--;
> +	}

BTW., perhaps using single negative $suffix_len instead of separate
$suffix_rem_pos and $suffix_add_pos would make code simpler and easier
to understand?

> +
> +	# Mark lines that are different from each other, but have some comm=
on
> +	# part that isn't whitespace.  If lines are completely different, d=
on't
> +	# mark them because that would make output unreadable, especially i=
f
> +	# diff consists of multiple lines.
> +	if (($prefix =3D=3D 1 && $suffix_rem =3D=3D $#r && $suffix_add =3D=3D=
 $#a)
> +		|| ($prefix_is_space && $suffix_is_space)) {

Micronit about style: in gitweb we put boolean operator at the end of
continued line, not at beginning of next one.

So this would be:

  +	if (($prefix =3D=3D 1 && $suffix_rem =3D=3D $#r && $suffix_add =3D=3D=
 $#a) ||
  +	    ($prefix_is_space && $suffix_is_space)) {

> +		$esc_rem =3D esc_html($rem);
> +		$esc_add =3D esc_html($add);
> +	} else {
> +		$esc_rem =3D esc_html_mark_range(\@r, $prefix, $suffix_rem);
> +		$esc_add =3D esc_html_mark_range(\@a, $prefix, $suffix_add);
> +	}
> +
> +	return format_diff_line($esc_rem, 'rem'),
> +		format_diff_line($esc_add, 'add');

Please use spaces to align.

> +}
> +
>  # HTML-format diff context, removed and added lines.
>  sub format_ctx_rem_add_lines {
> -	my ($ctx, $rem, $add) =3D @_;
> +	my ($ctx, $rem, $add, $is_combined) =3D @_;
>  	my (@new_ctx, @new_rem, @new_add);
> +	my $num_add_lines =3D @$add;

Why is this temporary variable needed?  If you are not sure that =3D=3D
operator enforces scalar context on both arguments you can always
write

  scalar @$add =3D=3D scalar @$rem

> +
> +	if (!$is_combined && $num_add_lines > 0 && $num_add_lines =3D=3D @$=
rem) {
> +		for (my $i =3D 0; $i < $num_add_lines; $i++) {
> +			my ($line_rem, $line_add) =3D format_rem_add_line(
> +				$rem->[$i], $add->[$i]);
> +			push @new_rem, $line_rem;
> +			push @new_add, $line_add;

The original contrib/diff-highlight works only for single changed line
(single removed and single added).  You make this code work also for
the case where number of aded lines is equal to the number of removed
lines, and assume that subsequent changed lines in preimage
correcponds to subsequent changed lines in postimage, which is not
always true:

   -foo
   -bar
   +baz
   +fooo

This is not described in commit message, I think.

> +		}
> +	} else {
> +		@new_rem =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'rem=
') } @$rem;
> +		@new_add =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'add=
') } @$add;
> +	}
> =20
>  	@new_ctx =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'ctx'=
) } @$ctx;
> -	@new_rem =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'rem'=
) } @$rem;
> -	@new_add =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'add'=
) } @$add;
> =20
>  	return (\@new_ctx, \@new_rem, \@new_add);
>  }
> @@ -4939,7 +5010,8 @@ sub format_ctx_rem_add_lines {
>  sub print_diff_lines {
>  	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
> =20
> -	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add);
> +	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add,
> +		$is_combined);

O.K., now the code depends on $is_combined

--=20
Jakub Nar=EAbski
