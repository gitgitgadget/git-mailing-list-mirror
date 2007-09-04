From: Jan Hudec <bulb@ucw.cz>
Subject: Re: .gitignore, .gitattributes, .gitmodules,
	.gitprecious?,.gitacls? etc.
Date: Tue, 4 Sep 2007 22:23:26 +0200
Message-ID: <20070904202326.GC3786@efreet.light.src>
References: <7vhcmmpxed.fsf@gitster.siamese.dyndns.org> <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com> <20070826100647.GH1219@pasky.or.cz> <4C603F7C51884DF8AFAEC3F6E263798D@ntdev.corp.microsoft.com> <a1bbc6950708271327x4dd948d4m8e9e35f757a7d92e@mail.gmail.com> <Pine.LNX.4.64.0708280945350.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISevv-0001Sf-I3
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 22:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbXIDUXb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 16:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbXIDUXb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 16:23:31 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:51798 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbXIDUXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 16:23:30 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 6C63757306;
	Tue,  4 Sep 2007 22:23:29 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 0flZ7mh7ybjf; Tue,  4 Sep 2007 22:23:27 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 347E157264;
	Tue,  4 Sep 2007 22:23:27 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1ISevm-0004zL-JV; Tue, 04 Sep 2007 22:23:26 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708280945350.28586@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57640>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2007 at 09:49:47 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Mon, 27 Aug 2007, Dmitry Kakurin wrote:
>=20
> > Here is the problem: we need to apply crlf attributes to a file. We
> > could have .gitattributes both in the index and in the worktree.
> > Which one do we use?
> > In general .gitattributes file could be (U)nchanged, (C)hanged, (NP)
> > NotPresent in each place.
>=20
> I do not see these cases.  You can have these cases, basically:
>=20
> - .gitattributes in worktree (then it does not matter what else we have),
> - .gitattributes not in the worktree, but in the index (then that is take=
n)
>=20
> In the latter case, there could be conflicts _in_ .gitattributes, in whic=
h=20
> case those .gitattributes are ignored.
>=20
> I do not see any problem with that.

I do.

IMNSHO it should be the other way around:
 .gitattributes in index, than index version is used.
 .gitattributes not in index, but in worktree, than that tree version is us=
ed.

Why? Because when you check out another version, the .gitattributes commited
in that version need to be applied, since it might be different from whatev=
er
is currently in the tree.

In the other direction, the tree version seems to make more sense, but in
reality it does not. If you do a partial commit of a single file, than the
index version gets into the commit, so that should better be the version us=
ed
to store the file. On the other hand if you change .gitattributes, the norm=
al
commit rules are that you need to add it for commit, so needing to add it to
make it effective goes well together with it. update-index would need to
always handle .git* before other entries to make add . and commit -a work
correctly.

The case for worktree only is for cases when you for some reason want to ha=
ve
local .gitattributes. Though I am not sure that should actually work, becau=
se
you couldn't have local .gitattributes if there is versioned version.
=2Egit/info/attributes would be better for that. Which gets us back to "alw=
ays
use .gitattributes from *index*" (and read it from tree before other files
when adding it).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3b6+Rel1vVwhjGURApdOAJwPoVDzjHYkn+V5Ow5IWozxYD28WACgpR7d
xaodvnQwxv0XFsU5ezQ/L74=
=pTSi
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
