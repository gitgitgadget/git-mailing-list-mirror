From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v6 1/4] submodule: add get_submodule_config helper funtion
Date: Mon, 03 Dec 2012 19:17:17 -0500
Message-ID: <20121204001717.GA17375@odin.tremily.us>
References: <7vr4n6q3qm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 01:18:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfgD6-0000PN-2P
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 01:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab2LDARn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 19:17:43 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:35156 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab2LDARm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 19:17:42 -0500
Received: from odin.tremily.us ([unknown] [72.68.87.188])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEH009IKCSTCC50@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 03 Dec 2012 18:17:23 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 751CC6E56DB; Mon,
 03 Dec 2012 19:17:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354580237; bh=QeAO8LXjzskYCwZ9m1j3s+cvM6tnRWl1jCmzdi/dD/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=aVpkz8qXNtzlT+uMF2eGCefEbFs82yj11BjUvpA7pg7+kgNgQRmbWIg/4yYQQIXfn
 n9dZsOjLPf4Ze2csfqSdhPlUdvN763hOPvJPgyRVm0Aqu5ptubx0eV+MAXIdkdbvxq
 mAT1IBcAv85ODrBCsZyfgTYc8Nzb7pJRDmiG1oEE=
Content-disposition: inline
In-reply-to: <7vr4n6q3qm.fsf@alter.siamese.dyndns.org>
 <7vehj7q6gr.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211064>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2012 at 11:30:12AM -0800, Junio C Hamano wrote:
> > +get_submodule_config()
> > +{
>=20
> style (see CodingGuidelines):
>=20
> 	get_submodule_config ()	{

Will fix.  I was generally just copying the surrounding code.

> > +	name=3D"$1"
> > +	option=3D"$2"
> > +	default=3D"$3"
> > +	value=3D$(git config submodule."$name"."$option")
>=20
> This will get unwieldy quickly once we have submodule.$name.$var
> that takes a boolean option, as there are different ways to spell
> boolean and "git config --bool" is the way to ask for canonicalized
> "true" or "false".
>=20
> If we never query any boolean via this helper function, it is
> obviously not an issue, though.

We do in my submodule.<name>.active branch, and I adjusted the
function in

  submodule: add submodule.<name>.active [1]

to add additional options passed through to `git config`.  You do have
to pick a default to use the extra options though.  If that becomes a
problem, I'd suggest extending git config itself to add a file above
or below the usual series of files.  Then get_submodule_config could
be

  git config --bottom-file .gitmodules submodule."$name"."$option"

or something, without needing a separate shell function.

On Mon, Dec 03, 2012 at 12:29:05PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>=20
> > As an example to make this clearer:
> >
> >   $ cat .gitmodules
> >   [submodule "sub1"]
> >     path =3D sub1
> >     url =3D git://example.com/sub1.git
> >     remote =3D remote1
> >     branch =3D branch1
> >     update-source =3D submodule-upstream
> >     update =3D rebase
> >   [submodule "sub2"]
> >   ...
>=20
> Maybe it is just me but that "remote =3D remote1" sticks out like a
> sore thumb.
>=20
> If you are showing the .gitmodules file to be shared as hints to
> project participants, why does it even need to have both URL and
> remote1?

The remote name will probably only ever get configured locally in
=2Egit/config.  I put it in (as a separate patch) mostly because Phil
suggested something like it:

On Thu, Nov 29, 2012 at 10:27:19PM -0500, W. Trevor King wrote:
> On Thu, Nov 29, 2012 at 08:11:20PM -0500, Phil Hord wrote:
> > I've always felt that the "origin" defaults are broken and are simply
> > being ignored because most users do not trip over them.  But ISTR that
> > submodule commands use the remote indicated by the superproject's
> > current remote-tracking configuration, with a fallback to 'origin' if
> > there is none.  Sort of a "best effort" algorithm, I think.  Am I
> > remembering that wrong?
>
> The current code uses a bare "git-fetch".  I'm not sure what that
> defaults to if you're on a detached head.  If it bothers you, I'm fine
> adding the submodule.<name>.remote option in v6.

and I hadn't heard any comments against it.  I'm not really attached
to that patch though, so feel free to leave it out (unless Phil chimes
in with stronger motivation?).

On Mon, Dec 03, 2012 at 12:29:05PM -0800, Junio C Hamano wrote:
> But I do not see any reason to require or even suggest any local
> nickname that is to be used to call the remote.  It really is a
> local matter.  Why should .gitmodules have "remote =3D ..." line?

The idea for configuring it at all probably goes something like =E2=80=9CI
don't like where upstream (origin) is taking this submodule.  I want
to follow *my* upstream, but I've called it something besides origin.
Look, a submodule.<name>.remote option!  Now I don't have to rename
my-remote=E2=86=92origin=E2=86=92original-remote.=E2=80=9D  I don't think t=
his will come up
all that often.

> On the other hand, if you meant the above as an excerpt from
> $GIT_DIR/config, it also does not make sense.  At that point, the
> participant own the file and updating url to point at whatever
> different repository without changing the remote name is sufficient.

Unless they still want to keep an the origin remote to track the
original submodule upstream.  Maybe they'll want to switch back to
following that remote later.  As I hinted at above, if they have
remotes `alice`, `bob`, etc., it's easier to flip between them by
configuring submodule.<name>.remote

  $ git config submodule.submod.remote alice

than it is to reconfigure the submodule's origin:

  $ cd submod
  $ git remote rename origin charlie
  $ git remote rename alice origin

> It looks way over-engineered for unclear/dubious benefit.

I'm not going to push for submodule.<name>.remote.  Drop at will.

Cheers,
Trevor

[1]: https://github.com/wking/git/commit/fbe2d8419902700a6b0b40defaa5801811=
b887f7#L0R288

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQvUEKAAoJEEUbTsx0l5OM77sP/07QLruwXPktqETMlZl+iArv
cWtIFXA1MvLClXGFGR/b5zVG9aVoz+zaprt3tTAEvRC4biIirB+0pNMA2hzUfzUz
CCMG02PRN7NskYpWGAtPtqtuhWhtRIiOpGhfFbtR9IdK+aSefUCsxdl0ZzV+d2lg
JJM5T7ktBsJj3mdymQqN8vfXCNosoWQ9E684GMT7qHfzfgNaAFjiZ7UZPpBxdcVK
tYEn9MfkSOkJzZrI0HcZ1A8mb/7mPJKi1XIPHhW6QFJSg02AngJPGUqno//hUwzT
xhzzH8bTb9LGS8NqW3KsyV/vZR+uPc+WmgYCJcTpzG0WaAhQr4UMDb/Sng1V9y0l
LgIxZH/7NkjOSx02U+mWt/KYg9PUtjmyMb3iFSqpujSm+ewSPXfv4eJdjylBNu5Y
ic/uF8CB2wu5KrFU4q9z0Z1y1go5Pt3rP8HP4LsMMXsaXecntUK6t65K8c4leYfz
/RnbMSTT77exmguV41VGwTHNwlSoH2ZVw8nKY1be4VflPBaBEsJY4+rWrxN1v5Ez
D5i6HnpfjxVgaePre3jVZoJ2jwkKZaufX6uZF7gxH1P4nd6AWhybQUGlGvdOpQpf
MOytMpn24GinHfcbA9DvexakFYC/gPMe1EMx2n5Ogl2/5pyKQFFGRcUznXPCrCl7
cjn2k/TMWdajTvD1yrsU
=kcfo
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
