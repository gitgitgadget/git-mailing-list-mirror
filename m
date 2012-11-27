From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 0/4] git-submodule add: Add --local-branch option
Date: Tue, 27 Nov 2012 14:01:05 -0500
Message-ID: <20121127190105.GQ10656@odin.tremily.us>
References: <20121127183125.GA4185@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=213E7WwkW+nU62+Y
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:01:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdRLt-0005Pw-4M
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 21:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab2K0UBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 15:01:38 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:14242 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab2K0UBh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 15:01:37 -0500
X-Greylist: delayed 3609 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2012 15:01:37 EST
Received: from odin.tremily.us ([unknown] [72.76.144.216])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME500G7NU5T9B70@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 27 Nov 2012 13:01:07 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 3FB1D6E0BBE; Tue,
 27 Nov 2012 14:01:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354042865; bh=hAc3dXptyGEtdvsc5N75f5ZpLSPwV0HonUhCa8mlYmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=eL21bI1T9lX4scEfmofsDXXnsWDz6l85hxXM5IxuHpKG7EsBoNfVRCmxbEmAWiUJe
 KtGKa5Ubjd48i3EvlcjGgbUsy7uj8tyNIP+ih96Bnv+T6LIUJ76Z46VUuB96HNXlHs
 n//oSkKw62npXPANyQFv7Hn9YnhSFgsbsRCPAJgs=
Content-disposition: inline
In-reply-to: <20121127183125.GA4185@book.hvoigt.net>
 <20121123175402.GH2806@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210588>


--213E7WwkW+nU62+Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2012 at 07:31:25PM +0100, Heiko Voigt wrote:
> On Mon, Nov 26, 2012 at 04:00:15PM -0500, W. Trevor King wrote:
> > From: "W. Trevor King" <wking@tremily.us>
> >=20
> > On Fri, Nov 23, 2012 at 12:54:02PM -0500, W. Trevor King wrote:
> > > We could add
> > >
> > >   $ git submodule update --branch
> > >
> > > to checkout the gitlinked SHA1 as submodule.<name>.branch in each of
> > > the submodules, leaving the submodules on the .gitmodules-configured
> > > branch.  Effectively (for each submodule):
> > >
> > >   $ git branch -f $branch $sha1
> > >   $ git checkout $branch
> >=20
> > I haven't gotten any feedback on this as an idea, but perhaps someone
> > will comment on it as a patch series ;).
>=20
> I am not sure I understand you correctly. You are suggesting that the
> branch option as an alias for the registered SHA1 in the superproject?
>=20
> I though the goal of your series was that you want to track submodules
> branch which come from the remote side?

That's what I'd initially thought, but when I went to implement
`update --pull`, I realized that

  $ git submodule foreach 'git checkout $(git config --file $toplevel/.gitm=
odules submodule.$name.branch) && =E2=80=A6'

is using submodule.<name>.branch as the local branch name.  The remote
branch name was actually setup in .git/modules/<name>/config during
the initial "clone -b <branch> =E2=80=A6".

The v4 series leaves the remote branch amigious, but it helps you
point the local branch at the right hash so that future calls to

  $ git submodule foreach 'git pull'

can use the branch's .git/modules/<name>/config settings.

> I would think more of some convention like:
>=20
> 	$ git checkout -t origin/$branch
>=20
> when first initialising the submodule with e.g.
>=20
> 	$ git submodule update --init --branch
>=20
> Then later calls of
>=20
> 	$ git submodule update --branch
>=20
> would have a branch configured to pull from. I imagine that results in
> a similar behavior gerrit is doing on the server side?

That sounds like it's doing pretty much the same thing.  Can you think
of a test that would distinguish it from my current v4 implementation?

> > Changes since v3:
> >=20
> > * --record=3D??? is now --local-branch=3D???
> > * Dropped patches 2 ($submodule_ export) and 3 (motivating documentatio=
n)
> > * Added local git-config overrides of .gitmodules' submodule.<name>.bra=
nch
> > * Added `submodule update --branch`
>=20
> I would prefer if we could squash all these commits together into one
> since it seems to me one logical step, using the new variable for update
> belongs together with its configuration on initialization.
>=20
> How about reusing the -b|--branch option for add? Since we only change
> the behavior when submodule.$name.update is set to branch it seems
> reasonable to me. Opinions?

That was the approach I used in v1, but people were concerned that we
would be stomping on previously unclaimed config space.  Since noone
has pointed out other uses besides Gerrit's very similar case, I'm not
sure if that is still an issue.

> > Because you need to recurse through submodules for `update --branch`
> > even if "$subsha1" =3D=3D "$sha1", I had to amend the conditional
> > controlling that block.  This broke one of the existing tests, which I
> > "fixed" in patch 4.  I think a proper fix would involve rewriting
> >=20
> >   (clear_local_git_env; cd "$sm_path" &&
> >    ( (rev=3D$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
> >     test -z "$rev") || git-fetch)) ||
> >   die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
> >=20
> > but I'm not familiar enough with rev-list to want to dig into that
> > yet.  If feedback for the earlier three patches is positive, I'll work
> > up a clean fix and resubmit.
>=20
> You probably need to separate your handling here. The comparison of the
> currently checked out sha1 and the recorded sha1 is an optimization
> which skips unnecessary fetching in case the submodules commits are
> already correct. This code snippet checks whether the to be checked out
> sha1 is already local and also skips the fetch if it is. We should not
> break that.

Agreed.  However, determining if the target $sha1 is local should have
nothing to do with the current checked out $subsha1.

Thanks for the feedback!
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--213E7WwkW+nU62+Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQtQ3vAAoJEEUbTsx0l5OMZR4P/2zItl1zZssi0ZLuKyaOdut9
LsdQsYhrpEucosKSzjiYnhZ4nm1zw1B54MSQG4EtEMLVsk5RytcAyf/UH/ZvPA8e
ggnabppmaAD2v+OWbBATbHQ/JYj1asKRmFTM21d1SMCyiqMwmZBC+jWOA3M0pOE1
YEf+NCRPHB24S/etOU8AUoFLoPk63sBN3s57gGl4k16SikWxcCijAOJPkcBB43PR
J21guOjLtv9knn7/Glnw4EvY8cq2mK2IDM1ficmu8OZCIqjPI/DdvqHZAjIJuY/2
LFlhBxWGqw5OEMPRnEOY+Gicp15aHzD1bg7kVdQwdXJnMr0gsO/iOw4ZUrOqoWOO
q8ssgQaB7JzBXp54wwqJTK/L3xHzMNcPjb0pq4JFvZRGonUz5hg/K4YnNL4PFMC1
KqWsiYQxvT17ExwI15N2jX2u2BfbaS2rhxlC/7H3DZT+ZwjtpW0C/g41ODJP9w92
Iphin7yw5BFG3FHTme6Kf+TsFrKRUfMkRzo3pc3U6KQ3hGCBB56rtgw7c2v1mgib
wNTbb4FtM3gSz3U0OYocUcTVn94faj02Xuj+M/ZZDuKfMjGEPFUOet5bPJiTyVuF
l4fGErVJkCiOnd4viBlixMuJWIapeEyh6Pv+IhTfi8bB0vMT3M4Nup7QqqgMU1zP
WSe3//7DqZkBg23FE+C3
=ndTW
-----END PGP SIGNATURE-----

--213E7WwkW+nU62+Y--
