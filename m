From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Wed, 2 Jul 2008 09:00:24 +0200
Message-ID: <200807020900.28690.trast@student.ethz.ch>
References: <20080701101114.GA6379@sigill.intra.peff.net> <1214912674-9443-1-git-send-email-trast@student.ethz.ch> <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1622687.jEf3brCbC7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 09:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDwL6-0006De-Jd
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 09:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759407AbYGBHAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 03:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759005AbYGBHAR
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 03:00:17 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:23185 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757896AbYGBHAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 03:00:16 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 09:00:15 +0200
Received: from cx-public-docking-1-071.ethz.ch ([129.132.149.71]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 09:00:14 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 02 Jul 2008 07:00:14.0907 (UTC) FILETIME=[475078B0:01C8DC11]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87091>

--nextPart1622687.jEf3brCbC7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
>=20
> People with minimum Perl installation should still be able to use "add -i"
> as long as they do not use 'e' subcommand, shouldn't they?  Shouldn't we
> do something like:
[...]
> and disable 'e' subcommand unless $can_use_temp?

I can just call the temporary editing file something constant, like
the commit message already is.  I don't care much about that point,
and honestly assumed File::Temp came with every Perl (it's in
perl-base here).

> > +# To remove '-' lines, make them ' ' lines (context).
> > +# To remove '+' lines, delete them.
> > +# Lines starting with # will be removed.
>=20
> Don't you want to say "Do not touch lines that begin with ' '"?

Why?  You can make them '-' instead if you really want to :-)

> > +	# Reinsert the first hunk header if the user accidentally deleted it
>=20
> Hmm, perhaps not even giving the "@@ ... @@" lines to the editor would be
> a more robust solution?

I originally left it there because Emacs automatically recounts the
header, and it also reminds the user of the function the hunk applies
to.

> > +	open $fh, '| git apply --recount --cached --check';
>=20
> Have to wonder where the potential error message would go, and if it would
> confuse the end users...

To the terminal.  If we eat that error message, the user gets
absolutely no indication as to _what_ might be wrong with the edited
patch, so I kind of deliberately left it there.

Then again the message from git-apply is not exactly transparent
either.

> I recall that the original "add--interactive" carefully counted numbers in
> hunks it reassembles (as it can let you split and then you can choose to
> use both parts, which requires it to merge overlapping hunks back), but if
> you are going to use --recount anyway, perhaps we can discard that logic?

We briefly talked about that[1], but Jeff thought it should be a
separate patch, and I agree.  Can't sneakily rip out two dozen lines
of otherwise unrelated code in my feature patch, can I?

> It may make the patch application less robust, though.  I dunno.

I've become convinced it can't, apart from making it less likely to
trip over bugs in the script itself of course.

> An alternative, and probably more robust, approach would be to recount
> what we have in @{$mode->{TEXT}}, after letting the user edit some of
> them, so that "add--interactive" still knows what it is doing after
> applying your patch without having to rely on "apply --recount".

You lost me here.  Why recount the mode part?

If you mean the _hunk_ headers, that's what the first three versions
of this patch did, at the expense of a lot of code complication (and
now that git-apply implements --recount, actually _duplication_).

=2D Thomas


[1] http://article.gmane.org/gmane.comp.version-control.git/84698

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart1622687.jEf3brCbC7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhrJ4wACgkQqUud07tmzP3UJgCghf0n3COhxRY3bVdk3FRHU8mF
izwAoIcpXWv3kvv7GJUD8cNkwWPmM/6y
=DN/f
-----END PGP SIGNATURE-----

--nextPart1622687.jEf3brCbC7--
