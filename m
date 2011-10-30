From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: add a feature to show side-by-side diff
Date: Sun, 30 Oct 2011 11:56:39 -0700 (PDT)
Message-ID: <m3sjma48ce.fsf@localhost.localdomain>
References: <CAFo4x0L4BAKnCDa1uEK0Rskd9kTsR-94D4mkYKnLGqVDnuyuBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 19:56:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKaYu-0007oS-Sb
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 19:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998Ab1J3S4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Oct 2011 14:56:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49914 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab1J3S4m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2011 14:56:42 -0400
Received: by faan17 with SMTP id n17so4961557faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=aNFPJ2ClsPRQ8feYSKKhYubunTQHafxHhLhOFCyGDmQ=;
        b=e3fCT9UkIjZS9HrBPzCr5E1S1FaAGa9LFnvuulvg0A2kjx8Em8+L9MBYk5Pk/tlowj
         2qsCP/xYOblcyhfc2+zKIkYwY+LdsV8ZgjAq4ZkkAfd2Dt7S0HL0zu6zp5W9c5Q3GFLX
         e9PA+Klw4m7l7YtaEoVASKO6LZXOtv8rQLFMM=
Received: by 10.223.14.3 with SMTP id e3mr23937931faa.25.1320001001122;
        Sun, 30 Oct 2011 11:56:41 -0700 (PDT)
Received: from localhost.localdomain (abvr36.neoplus.adsl.tpnet.pl. [83.8.215.36])
        by mx.google.com with ESMTPS id a21sm32981258fao.18.2011.10.30.11.56.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 11:56:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9UIuDmm011280;
	Sun, 30 Oct 2011 19:56:23 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9UIu2fj011276;
	Sun, 30 Oct 2011 19:56:02 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAFo4x0L4BAKnCDa1uEK0Rskd9kTsR-94D4mkYKnLGqVDnuyuBA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184476>

Those are additional comments, most of which I have come about when
rewriting this series and testing it.

There are to complement existing comments in other post(s).

Kato Kazuyoshi <kato.kazuyoshi@gmail.com> writes:

> ---
>  gitweb/gitweb.perl       |   81 ++++++++++++++++++++++++++++++++++++=
+++++----
>  gitweb/static/gitweb.css |   15 ++++++++
>  2 files changed, 88 insertions(+), 8 deletions(-)

No tests.
=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 095adda..dca09dc 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -757,6 +757,7 @@ our @cgi_param_mapping =3D (
>  	extra_options =3D> "opt",
>  	search_use_regexp =3D> "sr",
>  	ctag =3D> "by_tag",
> +	diff_style =3D> "ds",
>  	# this must be last entry (for manipulation from JavaScript)
>  	javascript =3D> "js"
>  );

Alternate solution would be to use 'extra_options' ("opt") for
that... though current use of it in gitweb seems to suggest that it is
more about passing extra options to underlying git commands; and "git
diff" doesn't support '--side-by-side' like GNU diff does, (yet?).

So currently I favor neither.

> @@ -1072,6 +1073,8 @@ sub evaluate_and_validate_params {
>  		}
>  		$search_regexp =3D $search_use_regexp ? $searchtext : quotemeta $s=
earchtext;
>  	}
> +
> +	$input_params{diff_style} ||=3D 'inline';
>  }

Hmmm... similar option 'order' ("o") had default value set in action
subroutine.  I wonder if it wouldn't be better to do the same also in
this situation.

> @@ -2276,7 +2279,7 @@ sub format_diff_line {
>  		}
>  		$line =3D "<span class=3D\"chunk_info\">@@ $from_text $to_text @@<=
/span>" .
>  		        "<span class=3D\"section\">" . esc_html($section, -nbsp=3D=
>1) .
> "</span>";
> -		return "$div_open$line</div>\n";
> +		return $diff_class, "$div_open$line</div>\n";
>  	} elsif ($from && $to && $line =3D~ m/^\@{3}/) {
>  		my ($prefix, $ranges, $section) =3D $line =3D~ m/^(\@+) (.*?) \@+(=
=2E*)$/;
>  		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $t=
o_nlines);

This subroutine no longer *format* line to be printed, isn't it?

> @@ -4828,8 +4831,32 @@ sub git_difftree_body {
>  	print "</table>\n";
>  }
>=20
> +sub format_diff_chunk {

Name: it is not about diff chunk (or hunk), but about a block of lines
in a chunk; in this case block of change lines (rem / add).  Also, it
is not about generic diff, only about sidebyside one.

BTW. I think it would be better if this subroutine also managed
context lines.

> +	my @chunk =3D @_;
> +
> +	my $first_class =3D $chunk[0]->[0];

Style: You can use simply $chunk[0][0] here.  perlref(1) says:

  "The arrow is optional between brackets subscripts, [...]"=20

> +	my @partial =3D map { $_->[1] } grep { $_->[0] eq $first_class } @c=
hunk;
> +
> +	if (scalar @partial < scalar @chunk) {

Style: you can write simply

  +	if (@partial < @chunk) {

> +		return join '', ("<div class=3D'chunk'><div class=3D'old'>",
> +		             @partial,
> +		             "</div>",
> +		             "<div class=3D'new'>",
> +		             (map {
> +		                 $_->[1];
> +		             } @chunk[scalar @partial..scalar @chunk-1]),
> +		             "</div></div>");
> +	} else {
> +		return join '', ("<div class=3D'chunk'><div class=3D'",
> +		             ($first_class eq 'add' ? 'new' : 'old'),
> +		             "'>",
> +		             @partial,
> +		             "</div></div>");
> +	}
> +}

Anyway this code is not very clear.  You rely on the fact that if
there are two classes, then they are "rem" first, and "add" second.

Also, it is I think overly complicated.

> +
>  sub git_patchset_body {
> -	my ($fd, $difftree, $hash, @hash_parents) =3D @_;
> +	my ($fd, $is_inline, $difftree, $hash, @hash_parents) =3D @_;

Rather than passing $is_inline, I think it would be better to pass
$diff_style (with default value filled in)

>  	my ($hash_parent) =3D $hash_parents[0];
>=20
>  	my $is_combined =3D (@hash_parents > 1);
> @@ -4940,12 +4967,31 @@ sub git_patchset_body {
>=20
>  		# the patch itself
>  	LINE:
> +		my @chunk;
>  		while ($patch_line =3D <$fd>) {
>  			chomp $patch_line;
>=20
>  			next PATCH if ($patch_line =3D~ m/^diff /);

Here is a bug.  If patchset consists of more than one patch, if
not-last patches have change that does not have trailing context lines
(changed, added or removed lines at the end of file), then the last
block will be lost (@chunk can be non-empty here).

>=20
> -			print format_diff_line($patch_line, \%from, \%to);
> +			my ($class, $line) =3D format_diff_line($patch_line, \%from, \%to=
);
> +			if ($is_inline) {

That is wrong to test for.  You should test if you can use
side-by-side diff, not if you use default output. =20

Especially that diff can be combined diff of a merge commit, which
cannot be represented as 2-sided side-by-side diff; for such diff
gitweb needs to use inline diff.

> +				print $line;
> +			} elsif ($class eq 'add' || $class eq 'rem') {
> +				push @chunk, [ $class, $line ];
> +			} else {
> +				if (@chunk) {
> +					print format_diff_chunk(@chunk);
> +					@chunk =3D ();
> +				} elsif ($class eq 'chunk_header') {
> +					print $line;
> +				} else {
> +					print '<div class=3D"chunk"><div class=3D"old">',
> +					      $line,
> +					      '</div><div class=3D"new">',
> +					      $line,
> +					      '</div></div>';

All of this should in my opinion be done in format_diff_chunk(), not
in caller.  This also introduces a bit of inconsistency in that
added/removed lines are in single block and context lines are each in
its own block.

Additionally you forgot about incomplete lines here, which can apply
either to added lines, removed lines, both of added and removed lines,
and to context lines.  Your code generates incorrect info in the case
if incomplete line is either removed line only, or added line only.

[Nb. I have to check my code yet again.]

> +sub diff_nav {
> +	my ($style) =3D @_;
> +
> +	my %pairs =3D (inline =3D> 'inline', 'sidebyside' =3D> 'side by sid=
e');
> +	join '', ($cgi->start_form({ method =3D> 'get' }),
> +	          $cgi->hidden('p'),
> +	          $cgi->hidden('a'),
> +	          $cgi->hidden('h'),
> +	          $cgi->hidden('hp'),
> +	          $cgi->hidden('hb'),
> +	          $cgi->hidden('hpb'),
> +	          $cgi->popup_menu('ds', [keys %pairs], $style, \%pairs),
> +	          $cgi->submit('change'),
> +	          $cgi->end_form);
> +}

What about 'f' and 'fp' for "blobdiff" view?

> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 7d88509..dc84db2 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -618,6 +618,21 @@ div.remote {
>  	cursor: pointer;
>  }
>=20
> +/* side-by-side diff */
> +div.chunk {
> +	overflow: hidden;
> +}
> +
> +div.chunk div.old {
> +	float: left;
> +	width: 50%;
> +	overflow: hidden;
> +}
> +
> +div.chunk div.new {
> +	margin-left: 50%;
> +	width: 50%;
> +}

Nice trick of composing CSS layout... though I wonder if there is
perhaps a better solution.

Anyway, I think this addition should be put near style for div.diff
etc.

--=20
Jakub Nar=EAbski
