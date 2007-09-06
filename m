From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH 1/2] git-commit: Disallow unchanged tree in non-merge mode
Date: Thu, 6 Sep 2007 14:16:48 +0400
Message-ID: <20070906101648.GD6665@basalt.office.altlinux.org>
References: <20070905234941.GA643@nomad.office.altlinux.org> <20070906022539.GG18160@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 12:17:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITEQ0-0007zp-3k
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 12:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbXIFKQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 06:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbXIFKQw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 06:16:52 -0400
Received: from vhq.altlinux.org ([194.107.17.3]:35336 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbXIFKQv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 06:16:51 -0400
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id BC4F51B5801C;
	Thu,  6 Sep 2007 14:16:49 +0400 (MSD)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id C478DB0D92; Thu,  6 Sep 2007 14:16:48 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20070906022539.GG18160@spearce.org>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57857>


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2007 at 10:25:39PM -0400, Shawn O. Pearce wrote:
> "Dmitry V. Levin" <ldv@altlinux.org> wrote:
> > Do not commit an unchanged tree in non-merge mode.
>=20
> A laudable goal.  git-gui also does this.  Turns out the other
> checks within git-gui prevent the user from ever getting that far.
> I probably should remove the empty tree check as it costs CPU time
> to get the old tree.  But I'd rather have the safety check.
> =20
> > The idea is that amend should not commit an unchanged tree,
> > one should just remove the top commit using git-reset instead.
>=20
> NO.  `git commit --amend` is *often* used for fixing the commit
> message.

You see, my proposed change does not affect this usage case at all.

> Or adding additional detail.

If that "additional" detail just undoes the latest commit, why should
"git commit --amend" welcome such thing?  I did not get your pint here.

> Forcing the user to do
> a `git reset --soft HEAD^ && git commit --amend` just because
> you don't want git-commit to make an "empty commit" (which it
> doesn't usually like to do now anyway!) is a major step back
> in functionality.

I suppose that helping users to avoid doing really stupid things
does not look as a major step back in functionality, just otherwise.

> > +		current_tree=3D"$(git cat-file commit "$current${amend:+^}" 2>/dev/n=
ull |
> > +				sed -e '/^tree \+/!d' -e 's///' -e q)"
>=20
> The better way to get the old tree would be this:
>=20
> 		current_tree=3D"$(git rev-parse "$current${amend:+^}^{tree}" 2>/dev/null
>=20
> as it avoids the tool from needing to know about the internal
> representation of a commit object.  It also avoids an entire
> fork+exec of a sed process.

Agreed.

> > +		if test "$tree" =3D "$current_tree"
> > +		then
> > +			echo >&2 "nothing to commit${amend:+ (use \"git reset HEAD^\" to re=
move the top commit)}"
>=20
> That message is a bad idea.  Doing a mixed mode reset will also
> reset the index, causing the user to lose any changes that had
> already been staged.  This may actually be difficult for him/her to
> recover from if they have used `git add -i` or git-gui to stage only
> certain hunks of files, or if their working tree has been further
> modified after the commit but they want to go back and amend the
> message only of the prior commit.

Would "git reset --soft HEAD^" advice be better than first one?
Could you suggest a better message, please?


--=20
ldv

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG39OQfKvmrJ41Nh4RAgG8AKDI4vsdtA31IZTywhmLoBBtSBYdYwCeJVje
su23IYy/36pOPEymFeMSBN0=
=BDXe
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
