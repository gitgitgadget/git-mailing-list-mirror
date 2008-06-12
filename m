From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Thu, 12 Jun 2008 08:55:24 +0200
Message-ID: <200806120855.26847.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <200806111102.31481.trast@student.ethz.ch> <20080612044932.GA25992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1678283.0LAWiV7agL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 08:56:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6gjK-0001Zl-H9
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 08:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbYFLGzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 02:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbYFLGzZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 02:55:25 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:57844 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbYFLGzY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 02:55:24 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Jun 2008 08:55:22 +0200
Received: from vpn-global-dhcp3-095.ethz.ch ([129.132.210.95]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Jun 2008 08:55:22 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <20080612044932.GA25992@sigill.intra.peff.net>
X-OriginalArrivalTime: 12 Jun 2008 06:55:22.0962 (UTC) FILETIME=[490A3320:01C8CC59]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84725>

--nextPart1678283.0LAWiV7agL
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff King wrote:
> On Wed, Jun 11, 2008 at 11:02:29AM +0200, Thomas Rast wrote:
>=20
> > +# If the patch applies cleanly, the hunk will immediately be marked
> > +# for staging as if you had answered 'y'.  (However, if you remove
> > +# everything, nothing happens.)  Otherwise, you will be asked to edit
> > +# again.
>=20
> This "however" confused me the first time I read it. I assume you mean
> that "if the diff is empty, then staging it will do nothing"? I wonder
> if that is even worth mentioning, since it seems obvious.

I wanted to make the same special case that 'recount -i' has: Deleting
everything does not "do nothing", but actually aborts the edit.  So in
rebase, deleting everything will not rebase anything (instead of
rebasing "no patches" onto wherever you said).  Along the same lines,
in the above patch deleting everything does not patch "no changes",
but aborts editing the hunk and leaves it unchanged.

Do you think that behaviour confuses users?

> > +# Do not add @ lines unless you know what you are doing.  The original
> > +# @ line will be reinserted if you remove it.
>=20
> This can probably be moved from the "every time" instructions to the
> manual, if we want to keep the size of the instructions a bit smaller.
>=20
> > +		if (diff_applies($head,
> > +				 @{$hunk}[0..$ix-1],
> > +				 $newhunk,
> > +				 @{$hunk}[$ix+1..$#{$hunk}])) {
>=20
> I'm confused here...we are feeding _all_ of the hunks to git-apply. In
> my patch, I simply fed the hunk of interest. Since we are recounting,
> shouldn't the single hunk be enough? And if it isn't, then shouldn't we
> be feeding only the hunks that are to be applied?

=46eeding it the single hunk would be enough, but doing it this way
ensures that the edited hunk cannot step on another hunk's toes,
i.e. produce a conflict that may prevent us from applying the patch at
the end of the hunk selection loop.

It's fairly unlikely of course, because the user would deliberately
have to extend the hunk beyond its current borders by adding extra
context from the original file.

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart1678283.0LAWiV7agL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBIUMheqUud07tmzP0RAuxgAJ9yy6yRmfpK7N19oKT5DfP7bWt0YQCgllpn
l6iEO7mNFQpigSNl0hfi/Sc=
=yrPL
-----END PGP SIGNATURE-----

--nextPart1678283.0LAWiV7agL--
