From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Stupid quoting...
Date: Sun, 24 Jun 2007 08:50:08 +0200
Message-ID: <20070624065008.GA6979@efreet.light.src>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <f51irh$shq$1@sea.gmane.org> <86ir9l1ylc.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706190156110.4059@racer.site> <86sl8owfqj.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706191048570.4059@racer.site> <86645kutow.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706200307070.4059@racer.site> <7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 08:50:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2LvU-0005DC-3H
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 08:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbXFXGuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 02:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbXFXGuQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 02:50:16 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:53427 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676AbXFXGuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 02:50:15 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5073E576CD;
	Sun, 24 Jun 2007 08:50:13 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I2LvE-0006t5-Pb; Sun, 24 Jun 2007 08:50:08 +0200
Content-Disposition: inline
In-Reply-To: <7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50770>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2007 at 23:19:39 -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> >> I don't see our discourse leading anywhere: the points have been made.
> >
> > I would really, really, really like to see a solution. Alas, I cannot=
=20
> > think of one, other than _forcing_ the developers to use ASCII-only=20
> > filenames.
> >
> > Note that there is no convention yet in Git to state which encoding you=
r=20
> > filenames are supposed to use. And in fact, we already had a fine examp=
le=20
> > in git.git why this is particularly difficult. MacOSX is too clever to =
be=20
> > true, in that it gladly takes filenames in one encoding, but reads thos=
e=20
> > filenames out in _another_ encoding. Thus, a "git add <filename>" can w=
ell=20
> > end up in git-status saying that a file was deleted, and another file=
=20
> > (actually the same, but in a different encoding) is untracked.

I saw bazaar folks discussing this MacOSX issue. Basically in MacOSX
filenames are *unicode* strings (just as they are in Windows, btw). Unicode,
for compatibility reasons allows expressing many characters in multiple for=
ms
-- composed and decomposed. For example '=C3=A1' can be expressed as '\u00e=
1'
('\xc3\xa1' in utf-8) or as 'a\u0301' ('a\xcc\x81' in utf-8).

MaxOSX opts to, in accord with unicode standard, treat such representations
as equal and it does so by normalizing all filenames to one form. I don't
know whether it uses compatibility normalization and I believe it uses the
decomposed form (which makes the issue immediately obvious, because most
programs work in composed form).

> By the way, the pathname quoting done by "diff" does not even
> attempt to tackle that.  I already explained why in the thread
> so I would not repeat myself.
>=20
> Having said that, the absolute minimum that needs to be quoted
> are double-quote (because it is used by quoting as agreed with
> GNU diff/patch maintainer), backslash (used to introduce C-like
> quoting), newline and horizontal tab (makes "patch" confused, as
> it would make it ambiguous where the pathname ends), so I am not
> opposed to a patch that introduces a new mode, probably on by
> default _unless_ we are generating --format=3Demail, that does not
> quote high byte values.  That would solve "My UTF-8 filenames
> are unreadable on my terminal" problem.

IMHO it should be the default even for email format. Most projects that use
non-ascii filenames probably have all members using same locale. And for
such group, it will just work. Also usually the file names, content and
commit messages will usually be in the same (though project-specific)
encoding, so if charset in content-type is set to that, people with differe=
nt
locale able to represent the same characters will still see the names
correctly. For other people, the MUA will probably print some escape anyway
(it will not screw up the terminal -- it usually knows what it can safely
pass to it).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGfhQgRel1vVwhjGURAqmPAJ40NVtuKcHtIr237riHeD0QZQa1SACg1iZy
olkeeA449AOf32KfTZk9m8Y=
=PT9b
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
