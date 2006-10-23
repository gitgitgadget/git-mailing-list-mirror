From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories
 and ranges
Date: Mon, 23 Oct 2006 12:27:49 -0700
Message-ID: <453D17B5.6070203@freedesktop.org>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net> <453C96C9.4010005@freedesktop.org> <Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1677C839D8C83DE6CE31C07B"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 21:28:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc5Sm-00009X-T8
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 21:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWJWT1x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 15:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWJWT1x
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 15:27:53 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:26278 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965052AbWJWT1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 15:27:52 -0400
Received: (qmail 25645 invoked from network); 23 Oct 2006 19:27:51 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.121]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <torvalds@osdl.org>; 23 Oct 2006 19:27:51 -0000
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29866>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1677C839D8C83DE6CE31C07B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
>=20
> On Mon, 23 Oct 2006, Josh Triplett wrote:
>>> I wonder if using "git-log --full-history -- $project" to let the cor=
e=20
>>> side omit commits that do not change the $project (but still give you=
=20
>>> all merged branches) would have made your job any easier?
>> I don't think it would.  We still need to know what commit to use as t=
he
>> parent of any given commit, so we don't want commits in the log output=

>> with parents that don't exist in the log output.  And rewriting parent=
s
>> in git-log based on which revisions change the specified subdirectory
>> seems like a bad idea.
>=20
> Umm.. You didn't realize that git log already _does_ exactly that?

No, I didn't, primarily because the git log output I've scrutinized most
carefully came from git log --pretty=3Draw, which doesn't rewrite parents=

even when pointed at a subdirectory.

> You need to rewrite the parents in order to get a nice and readable=20
> history, which in turn is needed for any visualizer. So git has long do=
ne=20
> the parent rewriting in order to be able to do things like
>=20
> 	gitk drivers/char
>=20
> on the kernel.
>
> And yes, that's done by the core revision parsing code, so when you do
>=20
> 	git log --full-history --parents -- $project
>=20
> you do get the rewritten parent output (of course, it's not actually=20
> _simplified_, so you get a fair amount of duplicate parents etc which=20
> you'd still have to simplify and which don't do anything at all).
>=20
> Without the "--full-history", you get a simplified history, but it's=20
> likely to be _too_ simplified for your use, since it will not only=20
> collapse multiple identical parents, it will also totally _remove_ pare=
nts=20
> that don't introduce any new content.

Considering that git-split does exactly that (remove parents that don't
introduce new content, assuming they changed things outside the
subtree), that might actually work for us.  I just checked, and the
output of "git log --parents -- $project" on one of my repositories
seems to show the same sequence of commits as git log --parents on the
head commit printed by git-split $project (apart from the rewritten
sha1s), including elimination of irrelevant merges.

> So there are multiple levels of history simplification, and right now t=
he=20
> internal git revision parser only gives you two choices: "none"=20
> (--full-history) and "extreme" (which is the default when you give a se=
t=20
> of filenames).=20

I don't think we need any middle ground here; why might we want less
simplification?

- Josh Triplett



--------------enig1677C839D8C83DE6CE31C07B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFPRe1GJuZRtD+evsRAnWqAJ4w2+kLTZQl+TVUuUzKACKvxHu09wCfaHiN
UPbC4ydg6b8gyt0iDKdZ2zQ=
=zHZP
-----END PGP SIGNATURE-----

--------------enig1677C839D8C83DE6CE31C07B--
