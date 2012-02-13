From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Mon, 13 Feb 2012 07:41:25 +0100
Message-ID: <20120213074125.3e8793ad@mkiedrowicz.ivo.pl>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
	<m3y5s9rl3g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 07:41:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwpbU-0007jr-Qi
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 07:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277Ab2BMGlb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 01:41:31 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61282 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab2BMGla convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 01:41:30 -0500
Received: by eekc14 with SMTP id c14so1742928eek.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 22:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=J4se6IFD+NXTgYRnONBetQzJ5CfL45kwmlNwDxXpYzU=;
        b=poPD8yKbY73zidjEfAfypEmIY9WBI9I4MeSgAetWiTIJLOUOHC80FirQj2hb7UK876
         XY3WPB14gBAbXoLySf0PcGeKicodKs0K15RQmu7trgCeShvKSHQ8iyORjXaH+DRm8ny6
         lkLd5gF6rEvV1PAszTBG+XoD1mc3ufc2ekMv0=
Received: by 10.213.105.197 with SMTP id u5mr1766546ebo.92.1329115288803;
        Sun, 12 Feb 2012 22:41:28 -0800 (PST)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id n56sm57706702eeh.6.2012.02.12.22.41.28
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Feb 2012 22:41:28 -0800 (PST)
In-Reply-To: <m3y5s9rl3g.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190611>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > Reading diff output is sometimes very hard, even if it's colored,
> > especially if lines differ only in few characters.  This is often
> > true when a commit fixes a typo or renames some variables or
> > functions.
> >
> This is certainly nice feature to have.  I think most tools that
> implement side-by-side diff implement this too.
>=20
> > This commit teaches gitweb to highlight characters that are
> > different between old and new line.  This should work in the
> > similar manner as in Trac or GitHub.
> >
> Doe you have URLs with good examples of such diff refinement
> highlighting (GNU Emacs ediff/emerge terminology) / highlighting
> differing segments (diff-highlight terminology)?

I haven't found *examples* on GitHub and Trac sites, but what about
these ones:

https://github.com/gitster/git/commit/8cad4744ee37ebec1d9491a1381ec1771=
a1ba795
http://trac.edgewall.org/changeset/10973

> =20
> > The code that compares lines is based on
> > contrib/diff-highlight/diff-highlight, except that it works with
> > multiline changes too.  It also won't highlight lines that are
> > completely different because that would only make the output
> > unreadable.
> >
> So what does it look like?  From the contrib/diff-highlight/README I
> guess that it finds common prefix and common suffix, and highlights
> the rest, which includes change. =20

Yes.

> It doesn't implement LCS / diff
> algorithm like e.g. tkdiff does for its diff refinement highlighting,
> isn't it?
>=20

I doesn't. I share the Jeff's opinion that:
a) Jeff's approach is "good enough"
b) LCS on bytes could be very confusing if it marked few sets of
characters.

> By completly different you mean that they do not have common prefix o=
r
> common suffix (at least one of them), isn't it?

Yes, but I also don't highlight lines which prefix/suffix consists only
of whitespace (This is quite common). I would also consider ignoring
prefixes/suffixes with punctuation, like:

	- * I like you.
	+ * Alice had a little lamb.

>=20
> > Combined diffs are not supported but a following commit will change
> > it.
> >=20
> O.K.
>=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
> >  gitweb/gitweb.perl |   82
> > ++++++++++++++++++++++++++++++++++++++++++++++++--- 1 files
> > changed, 77 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index db61553..1a5b454 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -2322,7 +2322,7 @@ sub format_cc_diff_chunk_header {
> >  # wrap patch (diff) line into a <div> (not to be used for diff
> > headers), # the line must be esc_html()'ed
> >  sub format_diff_line {
> > -	my ($line, $diff_class, $from, $to) =3D @_;
> > +	my ($line, $diff_class) =3D @_;
>=20
> Why that change?

I think it fallout from previous patch where format_diff_line() stopped
using $from and $to. Will fix that.

>=20
> > =20
> >  	my $diff_classes =3D "diff";
> >  	$diff_classes .=3D " $diff_class" if ($diff_class);
> > @@ -4923,14 +4923,85 @@ sub print_inline_diff_lines {
> >  	print foreach (@$add);
> >  }
> > =20
> > +# Highlight characters from $prefix to $suffix and escape HTML.
> > +# $str is a reference to the array of characters.
> > +sub esc_html_mark_range {
> > +	my ($str, $prefix, $suffix) =3D @_;
> > +
> > +	# Don't generate empty <span> element.
> > +	if ($prefix =3D=3D $suffix + 1) {
> > +		return esc_html(join('', @$str), -nbsp=3D>1);
> > +	}
> > +
> > +	my $before =3D join('', @{$str}[0..($prefix - 1)]);
> > +	my $marked =3D join('', @{$str}[$prefix..$suffix]);
> > +	my $after =3D join('', @{$str}[($suffix + 1)..$#{$str}]);
>=20
> Eeeeeek!  First you split into letters, in caller at that, then join?
> Why not pass striung ($str suggests string not array of characters),
> and use substr instead?
>=20
> [Please disregard this and the next paragraph at first reading]

I will rename $str to something more self describing.

>=20
> > +
> > +	return esc_html($before, -nbsp=3D>1) .
> > +		$cgi->span({-class=3D>'marked'}, esc_html($marked,
> > -nbsp=3D>1)) .
> > +		esc_html($after,-nbsp=3D>1);
> > +}
>=20
> Anyway I have send to git mailing list a patch series, which in one o=
f
> patches adds esc_html_match_hl($str, $regexp) to highlight matches in
> a string.  Your esc_html_mark_range(), after a generalization, could
> be used as underlying "engine".
>=20
> Something like this, perhaps (untested):
>=20
>    # Highlight selected fragments of string, using given CSS class,
>    # and escape HTML.  It is assumed that fragments do not overlap.
>    # Regions are passed as list of pairs (array references).
>    sub esc_html_hl {
>         my ($str, $css_class, @sel) =3D @_;
>         return esc_html($str) unless @sel;
>   =20
>         my $out =3D '';
>         my $pos =3D 0;
>   =20
>         for my $s (@sel) {
>                 $out .=3D esc_html(substr($str, $pos, $s->[0] - $pos)=
)
>                         if ($s->[0] - $pos > 0);
>                 $out .=3D $cgi->span({-class =3D> $css_class},
>                                    esc_html(substr($str, $s->[0],
> $s->[1] - $s->[0])));
>=20
>                 $pos =3D $m->[1];
>         }
>         $out .=3D esc_html(substr($str, $pos))
>                 if ($pos < length($str));
>   =20
>         return $out;
>    }
>=20
> > +
> > +# Format removed and added line, mark changed part and HTML-format
> > them.
>=20
> You should probably ad here that this code is taken from
> diff-highlight in contrib area, isn't it?

True.

>=20
> > +sub format_rem_add_line {
> > +	my ($rem, $add) =3D @_;
> > +	my @r =3D split(//, $rem);
> > +	my @a =3D split(//, $add);
> > +	my ($esc_rem, $esc_add);
> > +	my ($prefix, $suffix_rem, $suffix_add) =3D (1, $#r, $#a);
>=20
> It is not as much $prefix, as $prefix_len, isn't it? =20

Yes.

> Shouldn't
> $prefix / $prefix_len start from 0, not from 1?

It starts from 1 because it skips first +/-. It should become obvious
after reading the comment from last patch :).

+	# In combined diff we must ignore two +/- characters.
+	$prefix =3D 2 if ($is_combined);
+

>=20
> > +	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
> > +
> > +	while ($prefix < @r && $prefix < @a) {
> > +		last if ($r[$prefix] ne $a[$prefix]);
> > +
> > +		$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s/);
> > +		$prefix++;
> > +	}
>=20
> Ah, I see that it is easier to find common prefix by treating string
> as array of characters.
>=20
> Though I wonder if it wouldn't be easier to use trick of XOR-ing two
> strings (see "Bitwise String Operators" in perlop(1)):
>=20
>         my $xor =3D "$rem" ^ "$add";
>=20
> and finding starting sequence of "\0", which denote common prefix.
>=20
>=20
> Though this and the following is a nice implementation of
> algorithm... as it would be implemented in C.  Nevermind, it might be
> good enough...

The splitting and comparing by characters is taken from diff-highlight.
I don't think it's worth changing here.

>=20
> > +
> > +	while ($suffix_rem >=3D $prefix && $suffix_add >=3D $prefix) {
> > +		last if ($r[$suffix_rem] ne $a[$suffix_add]);
> > +
> > +		$suffix_is_space =3D 0 if ($r[$suffix_rem] !~ /\s/);
> > +		$suffix_rem--;
> > +		$suffix_add--;
> > +	}
>=20
> BTW., perhaps using single negative $suffix_len instead of separate
> $suffix_rem_pos and $suffix_add_pos would make code simpler and easie=
r
> to understand?

I'll try that.

>=20
> > +
> > +	# Mark lines that are different from each other, but have
> > some common
> > +	# part that isn't whitespace.  If lines are completely
> > different, don't
> > +	# mark them because that would make output unreadable,
> > especially if
> > +	# diff consists of multiple lines.
> > +	if (($prefix =3D=3D 1 && $suffix_rem =3D=3D $#r && $suffix_add =3D=
=3D
> > $#a)
> > +		|| ($prefix_is_space && $suffix_is_space)) {
>=20
> Micronit about style: in gitweb we put boolean operator at the end of
> continued line, not at beginning of next one.
>=20
> So this would be:
>=20
>   +	if (($prefix =3D=3D 1 && $suffix_rem =3D=3D $#r && $suffix_add =3D=
=3D
> $#a) ||
>   +	    ($prefix_is_space && $suffix_is_space)) {
>=20

OK

> > +		$esc_rem =3D esc_html($rem);
> > +		$esc_add =3D esc_html($add);
> > +	} else {
> > +		$esc_rem =3D esc_html_mark_range(\@r, $prefix,
> > $suffix_rem);
> > +		$esc_add =3D esc_html_mark_range(\@a, $prefix,
> > $suffix_add);
> > +	}
> > +
> > +	return format_diff_line($esc_rem, 'rem'),
> > +		format_diff_line($esc_add, 'add');
>=20
> Please use spaces to align.

OK

>=20
> > +}
> > +
> >  # HTML-format diff context, removed and added lines.
> >  sub format_ctx_rem_add_lines {
> > -	my ($ctx, $rem, $add) =3D @_;
> > +	my ($ctx, $rem, $add, $is_combined) =3D @_;
> >  	my (@new_ctx, @new_rem, @new_add);
> > +	my $num_add_lines =3D @$add;
>=20
> Why is this temporary variable needed?  If you are not sure that =3D=3D
> operator enforces scalar context on both arguments you can always
> write
>=20
>   scalar @$add =3D=3D scalar @$rem
>=20

You read my mind.

> > +
> > +	if (!$is_combined && $num_add_lines > 0 && $num_add_lines
> > =3D=3D @$rem) {
> > +		for (my $i =3D 0; $i < $num_add_lines; $i++) {
> > +			my ($line_rem, $line_add) =3D
> > format_rem_add_line(
> > +				$rem->[$i], $add->[$i]);
> > +			push @new_rem, $line_rem;
> > +			push @new_add, $line_add;
>=20
> The original contrib/diff-highlight works only for single changed lin=
e
> (single removed and single added).  You make this code work also for
> the case where number of aded lines is equal to the number of removed
> lines, and assume that subsequent changed lines in preimage
> correcponds to subsequent changed lines in postimage, which is not
> always true:
>=20
>    -foo
>    -bar
>    +baz
>    +fooo
>=20
> This is not described in commit message, I think.

True. Note that in this particular case nothing should be highlighted
because corresponding lines don't have common prefix/suffix.

>=20
> > +		}
> > +	} else {
> > +		@new_rem =3D map { format_diff_line(esc_html($_,
> > -nbsp=3D>1), 'rem') } @$rem;
> > +		@new_add =3D map { format_diff_line(esc_html($_,
> > -nbsp=3D>1), 'add') } @$add;
> > +	}
> > =20
> >  	@new_ctx =3D map { format_diff_line(esc_html($_, -nbsp=3D>1),
> > 'ctx') } @$ctx;
> > -	@new_rem =3D map { format_diff_line(esc_html($_, -nbsp=3D>1),
> > 'rem') } @$rem;
> > -	@new_add =3D map { format_diff_line(esc_html($_, -nbsp=3D>1),
> > 'add') } @$add;=20
> >  	return (\@new_ctx, \@new_rem, \@new_add);
> >  }
> > @@ -4939,7 +5010,8 @@ sub format_ctx_rem_add_lines {
> >  sub print_diff_lines {
> >  	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
> > =20
> > -	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem,
> > $add);
> > +	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem,
> > $add,
> > +		$is_combined);
>=20
> O.K., now the code depends on $is_combined
>=20
