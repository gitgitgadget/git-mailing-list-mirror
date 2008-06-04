From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: How do I control the automated commit message on a merge?
Date: Wed, 4 Jun 2008 09:33:17 +0200
Message-ID: <20080604073317.GA7752@leksak.fem-net>
References: <bd2cb52a0806031455r151303achf0424b5320bf2f07@mail.gmail.com> <alpine.DEB.1.00.0806032350170.13507@racer.site.net> <bd2cb52a0806031705x7cc153bsc00e1a0198d6e7b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Cc: git@vger.kernel.org
To: Marvin Fraeman <marvin.fraeman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 09:34:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3nVd-0005IT-Ao
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 09:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbYFDHdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 03:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYFDHdU
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 03:33:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:33035 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751495AbYFDHdT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 03:33:19 -0400
Received: (qmail invoked by alias); 04 Jun 2008 07:33:18 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp035) with SMTP; 04 Jun 2008 09:33:18 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/SRo4vtaTSKkE6soFL2bwAiCtgKtC7OyWi1ZqL5d
	EYW3DA4wK9dZ5U
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K3nUj-00033G-CM; Wed, 04 Jun 2008 09:33:17 +0200
Content-Disposition: inline
In-Reply-To: <bd2cb52a0806031705x7cc153bsc00e1a0198d6e7b5@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83753>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> >> when Git does a merge (no conflicts), it auto-generates a commit messa=
ge
> >> like:
> >>
> >>         Merge branch 'master' of  /path/to/other/repo
> >>
> >> How can I change this so my required string gets written at the
> >> beginning of the commit message.
> >
> > s/./?/
>=20
> Where do I do the substitution in this case?

In the question that you sent to the list ;-)
(But something like s/\./?/ makes more sense.)

The real answer of Johannes to your question was only:
> You might be happy with a post-merge hook amending the commit with a
> completely different message.

Meaning, you should put something like
 #!/bin/sh
 git commit -m "This is my new commit message." --amend
or better:
 #!/bin/sh
 git commit --amend -m "$(git cat-file commit HEAD |
 	sed -e '1,/^$/d;s/^/YOUR SIMPLE STATIC STRING HERE\n\n/')"
into .git/hooks/post-merge (and make it executable).
YOUR SIMPLE STATIC STRING HERE is the new first line.
Replace the \n\n by a space to get someting like
"YOUR SIMPLE STATIC STRING HERE Merge foo into HEAD."

> Also, having the prepare-commit-msg hook add text had the side-effect
> that in my normal commits, the message was always accepted, even when
> I wanted to abort (vi using :q!).

Let the commit-msg hook add the text afterwards.

Or remove the prepared commit message in vi and then press :x (or :wq),
because commit aborts on an *empty* commit message and not on=20
an unchanged commit message.

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIRkU9bt3SB/zFBA8RArVlAKCSP455bkoqfh0PBox3CvZEKFJdcgCgqWgI
TktH2K/64xXZqiSpSwHUWMU=
=j0Lv
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
