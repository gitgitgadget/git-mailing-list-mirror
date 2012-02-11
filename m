From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 2/8] gitweb: Use print_diff_chunk() for both
 side-by-side and inline diffs
Date: Sun, 12 Feb 2012 00:16:24 +0100
Message-ID: <20120212001624.4083c3b6@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-3-git-send-email-michal.kiedrowicz@gmail.com>
	<m3k43ttlh9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 00:16:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwMBI-0008Q1-Iy
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 00:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab2BKXQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 18:16:30 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61561 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab2BKXQa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 18:16:30 -0500
Received: by eaah12 with SMTP id h12so1344881eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 15:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=aVifWbqeka2TMwIn6mYlM7nWDrWl/SRN4JZSRqMbBKo=;
        b=LieWDgz7+OiCZIloa6ahRO7+hISXZl5Ll6IawTowTL/bgnoXDF7+zAlptAYHc4+MAx
         7tZDyIB3FM56x6heFWjGyunQEI99mfQS0sTsGL0+iuCygaUX/xgI0gzKx12lRFO27AzY
         EmBUJNQe6VLU81KMXJ5UqZuY7897hSq+ZeHVU=
Received: by 10.14.94.134 with SMTP id n6mr3533393eef.63.1329002188756;
        Sat, 11 Feb 2012 15:16:28 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n58sm41119846een.10.2012.02.11.15.16.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 15:16:28 -0800 (PST)
In-Reply-To: <m3k43ttlh9.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190539>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > This renames print_sidebyside_diff_chunk() to print_diff_chunk() an=
d
> > makes use of it for both side-by-side and inline diffs. Now diff li=
nes
> > are always accumulated before they are printed. This opens the
> > possibility to preprocess diff output before it's printed.
> >=20
> > The new function print_inline_diff_lines() could reorder diff lines=
=2E
>=20
> I think you meant here "if left as is", isn't it?

Yes.

> > It first prints all context lines, then all removed lines and
> > finally all added lines. If the diff output consisted of mixed adde=
d
> > and removed lines, gitweb would reorder these lines. This is
> > especially true for combined diff output, for example:
> >=20
> > 	 - removed line for first parent
> > 	 + added line for first parent
> > 	  -removed line for second parent
> > 	 ++added line for both parents
> >=20
> > would be rendered as:
> >=20
> > 	- removed line for first parent
> > 	 -removed line for second parent
> > 	+ added line for first parent
> > 	++added line for both parents
>=20
> This is not "is especially true"; it can happen (though: can it
> really?)=20

Yeah. See
http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff;h=3D5de89d3abfca9=
8b0dfd0280d28576940c913d60d=20


> in combined diff output; in ordinary diff you would always
> have context or end/beginning of chunk between added and removed
> lines.

OK, I'll reword this part of the commit message.
>=20
> >=20
> > To prevent gitweb from reordering lines, print_diff_chunk() calls
> > print_diff_lines() as soon as it detects that both added and remove=
d
> > lines are present and there was a class change.
>=20
> You really should mention, in my opinion, that this change is
> preparation for diff refinement highlighting (higlighting the
> differing segments).
>=20
> Otherwise I don't see the reason for it: ordinary diff didn't need th=
e
> fancy stuff with accumulating then printing, and could be send
> straightly to output.  This adds complexity for non-sidebyside diff,
> unnecessary if not for diff refinement highlighting.

I completely agree with that. This patch doesn't makes sense without
later patches.

> =20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
> >  gitweb/gitweb.perl |   53 +++++++++++++++++++++++++++++++++++++---=
-----------
> >  1 files changed, 38 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 1247607..ed63261 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -4908,9 +4908,31 @@ sub print_sidebyside_diff_lines {
> >  	}
> >  }
> > =20
> > -sub print_sidebyside_diff_chunk {
> > -	my @chunk =3D @_;
> > +# Print context lines and then rem/add lines in inline manner.
> > +sub print_inline_diff_lines {
> > +	my ($ctx, $rem, $add) =3D @_;
> > +
> > +	print foreach (@$ctx);
> > +	print foreach (@$rem);
> > +	print foreach (@$add);
> > +}
> > +
> > +# Print context lines and then rem/add lines.
> > +sub print_diff_lines {
> > +	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
> > +
> > +	if ($diff_style eq 'sidebyside' && !$is_combined) {
> > +		print_sidebyside_diff_lines($ctx, $rem, $add);
> > +	} else {
> > +		# default 'inline' style and unknown styles
> > +		print_inline_diff_lines($ctx, $rem, $add);
> > +	}
> > +}
>=20
> That looks nice.
>=20
> BTW. I didn't examine the final code, but what happens for binary
> diffs that git supports?  Is it handled outside print_diff_chunk()?

Good question. Will check.

>=20
> > +
> > +sub print_diff_chunk {
> > +	my ($diff_style, $is_combined, @chunk) =3D @_;
> >  	my (@ctx, @rem, @add);
> > +	my $prev_class =3D '';
>=20
> Is $prev_class here class of previous chunk fragment or _previous cla=
ss_
> (i.e. always different from $class), or is it class of previous line?
> It is not obvious here, from variable name.  Better name or at least
> a comment would be appreciated.
>=20

It's a class of previous line.

> > =20
> >  	return unless @chunk;
> > =20
> > @@ -4935,9 +4957,13 @@ sub print_sidebyside_diff_chunk {
> >  		}
> > =20
> >  		## print from accumulator when have some add/rem lines or end
> > -		# of chunk (flush context lines)
> > -		if (((@rem || @add) && $class eq 'ctx') || !$class) {
> > -			print_sidebyside_diff_lines(\@ctx, \@rem, \@add);
> > +		# of chunk (flush context lines), or when have add and rem
> > +		# lines and new block is reached (otherwise add/rem lines could
> > +		# be reordered)
> > +		if (((@rem || @add) && $class eq 'ctx') || !$class ||
> > +				(@rem && @add && $class ne $prev_class)) {
>=20
> We usually use tabs to align, but spaces to indent in gitweb, so it
> would be
>=20
> > +		if (((@rem || @add) && $class eq 'ctx') || !$class ||
> > +		    (@rem && @add && $class ne $prev_class)) {
>=20

OK.

> Anyway, this conditional gets ridicously complicated.  I wonder if we
> could simplify it.
>=20
> If we allow printing context together widh added/removed lines, and
> not as soon as possible, perhaps good conditional would be: class
> changed, and accumulator for current class is full:
>=20
> > +		if ($class ne $prev_class && @{ $acc{$class} }) {
>=20
> Or something like that, where
>=20
>         my %acc =3D (ctx =3D> \@ctx, add =3D> \@add, rem =3D> \@rem);
>=20
> If we want to print context as soon as possible, like it was before
> 1st patch in this series, we could uuse the following conditional
>=20
> > +		if ($class ne $prev_class &&=20
> > +                 ($prev_class eq 'ctx' || @{ $acc{$class} })) {
>=20
> Perhaps with "scalar @{ $acc{$class} }" if it would make things more
> clear.
>=20
> Though probably to avoid "Use of uninitialized value in string ne"
> we would probably have to use empty string instead of undefined
> value for "no class" case, i.e. beginning or end of chunk.
>

OK, I'll try to work out something.
=20
> > +			print_diff_lines(\@ctx, \@rem, \@add, $diff_style,
> > +					$is_combined);
> >  			@ctx =3D @rem =3D @add =3D ();
> >  		}
> > =20
> > @@ -4954,6 +4980,8 @@ sub print_sidebyside_diff_chunk {
> >  		if ($class eq 'ctx') {
> >  			push @ctx, $line;
> >  		}
> > +
> > +		$prev_class =3D $class;
> >  	}
> >  }
> [...] =20
>=20
