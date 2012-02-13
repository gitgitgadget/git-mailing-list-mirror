From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Mon, 13 Feb 2012 19:44:50 +0100
Message-ID: <201202131944.50886.jnareb@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com> <m3y5s9rl3g.fsf@localhost.localdomain> <20120213074125.3e8793ad@mkiedrowicz.ivo.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 19:45:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx0tY-0008Me-H4
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 19:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab2BMSoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 13:44:55 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58552 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab2BMSoy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 13:44:54 -0500
Received: by eekc14 with SMTP id c14so1955732eek.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=uL97oM3SOc/ZzYybWBamuweEm8Zyk7d6rqmYr8/8Ii0=;
        b=hiQfEo9sP57nXL8jRW+0oNVHHW/gS9v8pAkLI2Y1pORxx6vPG8YY7sjbdBvnk+65ma
         HvOOKIvh3HeEVIa1TeMnzwGqFRY+4V6o3tqW9b4+3VJSLkgDk4nadj4RVbJI72NsRUqK
         iSnuAhiuMiikhblSwU+ksTQMbfckeD+/roCew=
Received: by 10.213.3.200 with SMTP id 8mr2118688ebo.69.1329158693470;
        Mon, 13 Feb 2012 10:44:53 -0800 (PST)
Received: from [192.168.1.13] (aeho143.neoplus.adsl.tpnet.pl. [79.186.196.143])
        by mx.google.com with ESMTPS id y12sm63709512eeb.11.2012.02.13.10.44.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 10:44:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120213074125.3e8793ad@mkiedrowicz.ivo.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190644>

On Mon, 13 Feb 2012, Michal Kiedrowicz wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>=20
> > Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
> >=20
> > > Reading diff output is sometimes very hard, even if it's colored,
> > > especially if lines differ only in few characters.  This is often
> > > true when a commit fixes a typo or renames some variables or
> > > functions.
> > >
> > This is certainly nice feature to have.  I think most tools that
> > implement side-by-side diff implement this too.
> >=20
> > > This commit teaches gitweb to highlight characters that are
> > > different between old and new line.  This should work in the
> > > similar manner as in Trac or GitHub.
> > >
> > Doe you have URLs with good examples of such diff refinement
> > highlighting (GNU Emacs ediff/emerge terminology) / highlighting
> > differing segments (diff-highlight terminology)?
>=20
> I haven't found *examples* on GitHub and Trac sites, but what about
> these ones:
>=20
> https://github.com/gitster/git/commit/8cad4744ee37ebec1d9491a1381ec17=
71a1ba795
> http://trac.edgewall.org/changeset/10973

Thanks.  That is what I meant by "good examples".  Perhaps they should
be put in the commit message?

BTW GitHub is closed source, but we can check what algorithm does Trac
use for diff refinement highlighting (highlighting changed portions of
diff).

> > > The code that compares lines is based on
> > > contrib/diff-highlight/diff-highlight, except that it works with
> > > multiline changes too.  It also won't highlight lines that are
> > > completely different because that would only make the output
> > > unreadable.
> > >
> > So what does it look like?  From the contrib/diff-highlight/README =
I
> > guess that it finds common prefix and common suffix, and highlights
> > the rest, which includes change. =20
>=20
> Yes.
>=20
> > It doesn't implement LCS / diff
> > algorithm like e.g. tkdiff does for its diff refinement highlightin=
g,
> > isn't it?
>=20
> I doesn't. I share the Jeff's opinion that:
> a) Jeff's approach is "good enough"
> b) LCS on bytes could be very confusing if it marked few sets of
> characters.

I wonder if we can use --diff-words for diff refinement highlighting,
i.e. LCS on words.

Anyway Jeff's approach is a bit limited, in that it would work only for
change that does not involve adding newlines, for example splitting
overly long line when changing something.

See for example line 1786 (in pre-image) in http://trac.edgewall.org/ch=
angeset/10973
=20
> > By completly different you mean that they do not have common prefix=
 or
> > common suffix (at least one of them), isn't it?

BTW. is it "at least one of prefix or suffix are non-empty" or "both pr=
efix
and suffix are non-empty"?

> Yes, but I also don't highlight lines which prefix/suffix consists on=
ly
> of whitespace (This is quite common).=20

O.K., that is quite sensible.

> I would also consider ignoring prefixes/suffixes with punctuation, li=
ke:
>=20
> 	- * I like you.
> 	+ * Alice had a little lamb.

But this patch doesn't implement this feature yet, isn't it?

Well, here is another idea: do not highlight if sum of prefix and suffi=
x
lengths are less than some threshold, e.g. 2 characters not including=20
whitespace, or some percentage with respect to total line length.

> > > +# Highlight characters from $prefix to $suffix and escape HTML.
> > > +# $str is a reference to the array of characters.
> > > +sub esc_html_mark_range {
> > > +	my ($str, $prefix, $suffix) =3D @_;
> > > +
> > > +	# Don't generate empty <span> element.
> > > +	if ($prefix =3D=3D $suffix + 1) {
> > > +		return esc_html(join('', @$str), -nbsp=3D>1);
> > > +	}
> > > +
> > > +	my $before =3D join('', @{$str}[0..($prefix - 1)]);
> > > +	my $marked =3D join('', @{$str}[$prefix..$suffix]);
> > > +	my $after  =3D join('', @{$str}[($suffix + 1)..$#{$str}]);

It would be nicer with 'part' from List::MoreUtils... but that module
is unfortunately not in core.

> > Eeeeeek!  First you split into letters, in caller at that, then joi=
n?
> > Why not pass striung ($str suggests string not array of characters)=
,
> > and use substr instead?
> >=20
> > [Please disregard this and the next paragraph at first reading]
>=20
> I will rename $str to something more self describing.

Please do.

BTW. don't you assume here that both common prefix and common suffix
are non-empty?
=20
[...]
> > > +
> > > +# Format removed and added line, mark changed part and HTML-form=
at
> > > them.
> >=20
> > You should probably add here that this code is taken from
> > diff-highlight in contrib area, isn't it?
>=20
> True.

And perhaps not the changes from diff-highlight, unless you meant to
send them upstream for inclusion.

> > > +sub format_rem_add_line {
> > > +	my ($rem, $add) =3D @_;
> > > +	my @r =3D split(//, $rem);
> > > +	my @a =3D split(//, $add);

BTW the name of variable can be just @add and @rem.

> > > +	my ($esc_rem, $esc_add);
> > > +	my ($prefix, $suffix_rem, $suffix_add) =3D (1, $#r, $#a);
> >=20
> > It is not as much $prefix, as $prefix_len, isn't it? =20
>=20
> Yes.
>=20
> > Shouldn't
> > $prefix / $prefix_len start from 0, not from 1?
>=20
> It starts from 1 because it skips first +/-. It should become obvious
> after reading the comment from last patch :).
>=20
> +	# In combined diff we must ignore two +/- characters.
> +	$prefix =3D 2 if ($is_combined);

Anyway comment about that fact would be nice.
=20
> > > +	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
> > > +
> > > +	while ($prefix < @r && $prefix < @a) {
> > > +		last if ($r[$prefix] ne $a[$prefix]);
> > > +
> > > +		$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s/);
> > > +		$prefix++;
> > > +	}
> >=20
> > Ah, I see that it is easier to find common prefix by treating strin=
g
> > as array of characters.
> >=20
> > Though I wonder if it wouldn't be easier to use trick of XOR-ing tw=
o
> > strings (see "Bitwise String Operators" in perlop(1)):
> >=20
> >         my $xor =3D "$rem" ^ "$add";
> >=20
> > and finding starting sequence of "\0", which denote common prefix.
> >=20
> >=20
> > Though this and the following is a nice implementation of
> > algorithm... as it would be implemented in C.  Nevermind, it might =
be
> > good enough...
>=20
> The splitting and comparing by characters is taken from diff-highligh=
t.
> I don't think it's worth changing here.

You are right.

I'll try to come with hacky algorithm using string bitwise xor and rege=
xp,
and benchmark it comparing to your C-like solution, but it can be left =
for
later (simple is better than clever, usually).
=20
> > > +	while ($suffix_rem >=3D $prefix && $suffix_add >=3D $prefix) {
> > > +		last if ($r[$suffix_rem] ne $a[$suffix_add]);
> > > +
> > > +		$suffix_is_space =3D 0 if ($r[$suffix_rem] !~ /\s/);
> > > +		$suffix_rem--;
> > > +		$suffix_add--;
> > > +	}
> >=20
> > BTW., perhaps using single negative $suffix_len instead of separate
> > $suffix_rem_pos and $suffix_add_pos would make code simpler and eas=
ier
> > to understand?
>=20
> I'll try that.

I think this should just work, and it would be one variable less to
track.
=20
> > >  # HTML-format diff context, removed and added lines.
> > >  sub format_ctx_rem_add_lines {
> > > -	my ($ctx, $rem, $add) =3D @_;
> > > +	my ($ctx, $rem, $add, $is_combined) =3D @_;
> > >  	my (@new_ctx, @new_rem, @new_add);
> > > +	my $num_add_lines =3D @$add;
> >=20
> > Why is this temporary variable needed?  If you are not sure that =3D=
=3D
> > operator enforces scalar context on both arguments you can always
> > write
> >=20
> >   scalar @$add =3D=3D scalar @$rem
>=20
> You read my mind.

BTW. the same comment applies to patch adding support for highlighting
changed part in combined diff.
=20
> > The original contrib/diff-highlight works only for single changed l=
ine
> > (single removed and single added).  You make this code work also fo=
r
> > the case where number of aded lines is equal to the number of remov=
ed
> > lines, and assume that subsequent changed lines in preimage
> > correcponds to subsequent changed lines in postimage, [...]
[...]
> > This is not described in commit message, I think.

--=20
Jakub Narebski
Poland
