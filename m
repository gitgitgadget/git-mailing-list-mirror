From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Thu, 5 Jun 2008 09:53:54 +0200
Message-ID: <200806050954.13244.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <200806010241.51464.trast@student.ethz.ch> <20080605014618.GA27381@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2052203.MnVotOE9WS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 09:54:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4AIv-0002vw-BB
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 09:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbYFEHxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 03:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbYFEHxo
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 03:53:44 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:40028 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbYFEHxn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 03:53:43 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Jun 2008 09:53:42 +0200
Received: from vpn-global-dhcp3-023.ethz.ch ([129.132.210.23]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Jun 2008 09:53:41 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <20080605014618.GA27381@sigill.intra.peff.net>
X-OriginalArrivalTime: 05 Jun 2008 07:53:41.0874 (UTC) FILETIME=[45A98D20:01C8C6E1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83874>

--nextPart2052203.MnVotOE9WS
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff King wrote:
>=20
> But that being said, I think your approach is much more powerful, since
> you are allowing arbitrary editing of the hunk (as much as that is
> possible).
[...]
> So perhaps manual hunk editing is simply something for advanced users
> who are comfortable with the patch format.

I'll think about this for a while.  Somehow I don't like the idea of
editing the actual patch _contents_ for the user, meaning that what
the user needs to edit his patch into is not what we are going to
apply.

On the other hand it would be just as powerful.  Manually splitting a
hunk is, in the general case, only possible in "my" scheme.  However,
to make any difference, you later have to answer 'n' to some of the
sub-hunks.  So in "your" scheme, you could just have deleted the lines
in question.

Of course, manually editing the '+' lines or even introducing new
stuff into the patch is not possible, but then you should probably
have edited the actual file contents, not the patch.  (The working
directory will still have the old version, so if you commit after add
=2Dp, it will appear to undo part of the last commit.)

Then again, if this is just about editor convenience, maybe make a
macro that toggles between '-'/'+' and ' '/'#', respectively?  (Which
makes me wonder if it would be useful to keep the '#' lines, minus the
help message, around until the final git-apply in case you change your
mind and re-edit.)

> > +# Empty lines and lines starting with # will be removed.
>=20
> What about lines starting with characters besides -, +, space, or @?
> They will normally be ignored by diff.

Diff doesn't really have a say in this, does it?  And looking in
builtin-apply.c:

	switch (first) {  // line 1858 as of v1.5.6-rc1-122-g3859f95
	case '\n':
		/* Newer GNU diff, empty context line */
		// actual work snipped
		break;
	// cases ' ', '+', '-' also covered
	default:
		if (apply_verbosely)
			error("invalid start of line: '%c'", first);
		return -1;

so it appears invalid lines are actually not ignored, but abort hunk
processing.  While the error checking will be handled by apply
=2D-check, I don't think it would be a good idea to silently drop all
other lines from the edit, as they probably indicate user error.

On the other hand, this also shows that dropping empty lines is
wrong...

>  - Minor fixups and style comments. All of my style comments are "I
>    would have done it as..." and not "Oh God, this is horrible" so I
>    don't think any block acceptance.

=46rom a Perl POV, they probably _are_ horrible.  I'm just not used to
the idioms, and tend to fall for semantic differences to Python as
well.

Thank you for the very thorough review!  I'll improve the patch
accordingly.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch




--nextPart2052203.MnVotOE9WS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBIR5ulqUud07tmzP0RAv7dAJ932hvCk3inY0SjnpjS4bY1h7fE9QCgh4Qw
RC4b5P5xSr8yrBIdpO7i1kI=
=QVBk
-----END PGP SIGNATURE-----

--nextPart2052203.MnVotOE9WS--
