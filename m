From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 3/4] git-submodule update: Add --branch option
Date: Tue, 27 Nov 2012 15:21:03 -0500
Message-ID: <20121127202103.GD15213@odin.tremily.us>
References: <cover.1353962698.git.wking@tremily.us>
 <95edff1c97c513c555652014f9c2bbf61c8e7560.1353962698.git.wking@tremily.us>
 <20121127185142.GB4185@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=NklN7DEeGtkPCoo3
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:21:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdReu-0006Ib-Lj
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 21:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172Ab2K0UVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 15:21:16 -0500
Received: from vms173009pub.verizon.net ([206.46.173.9]:47278 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474Ab2K0UVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 15:21:15 -0500
Received: from odin.tremily.us ([unknown] [72.76.144.216])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME500ELKXV3ZJB0@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 27 Nov 2012 14:21:06 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 4CA946E0CD6; Tue,
 27 Nov 2012 15:21:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354047663; bh=zQtUG5oUufPvkYU3pgNqpjkl+GM6DLgHSh511fWf278=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HQYXkBuoEd676uQCTT8ilya85pzE/uQq/CVUPlTOvXJP7+wOd93aBGh8HIPDuwfto
 rwKg927r/wpWSbIpKhDAWekqe6CQT/aeW3eZGdY9Or8dE2DO5cDZFHFFaVmkhi3lyX
 zBZcRBbmZoTiMIlnxiZNctS2Th2K5g8DGFEGUOfk=
Content-disposition: inline
In-reply-to: <20121127185142.GB4185@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210589>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2012 at 07:51:42PM +0100, Heiko Voigt wrote:
> On Mon, Nov 26, 2012 at 04:00:18PM -0500, W. Trevor King wrote:
> >  -b::
> >  --branch::
> > -	Branch of repository to add as submodule.
> > +	When used with the add command, gives the branch of repository to
> > +	add as submodule.
> > ++
> > +When used with the update command, checks out a branch named
> > +`submodule.<name>.branch` (as set by `--local-branch`) pointing at the
> > +current HEAD SHA-1.  This is useful for commands like `update
> > +--rebase` that do not work on detached heads.
>=20
> Since you are reusing this option for update it further convinces me
> that reusing it for add makes sense and simplifies the logic for users.
>=20
> I think an optional argument for --branch would be nice in the update
> case:
>=20
> 	$ git submodule update --branch=3Dmaster
>=20
> would then allow a user that has not configured anything (except the
> branch tracking info in the submodule of course) to pull all submodules
> master branches.

Sounds good to me.  Remember that this is checking the branch and
pointing it at $sha1 (preparing for the pull), not pulling remote
branches.  The pull happens in a later

  $ git submodules foreach 'git pull'

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index c51b6ae..28eb4b1 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -627,7 +631,7 @@ Maybe you want to use 'update --init'?")"
> >  			die "$(eval_gettext "Unable to find current revision in submodule p=
ath '\$sm_path'")"
> >  		fi
> > =20
> > -		if test "$subsha1" !=3D "$sha1" -o -n "$force"
> > +		if test "$subsha1" !=3D "$sha1" -o -n "$force" -o "$update_module" =
=3D "branch"
>=20
> As said before I think separating your code from the current update
> logic will simplify the handling below.

This felt less invasive (it avoids duplicating the recursion logic),
but I don't mind breaking it into a separate function/block.

> >  			must_die_on_failure=3D
> >  			case "$update_module" in
> >  			rebase)
> >  				command=3D"git rebase"
> > -				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodule =
path '\$sm_path'")"
> > +				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodule =
path '\$sm_path'")"=09
> >  				say_msg=3D"$(eval_gettext "Submodule path '\$sm_path': rebased int=
o '\$sha1'")"
> > -				must_die_on_failure=3Dyes
> > +			must_die_on_failure=3Dyes
>=20
> Please always cleanup whitespace changes.

Oops, sloppy me.  Will fix.

> >  			then
> > -				die_with_status 2 "$die_msg"
> > -			else
> > -				err=3D"${err};$die_msg"
> > -				continue
> > +				if (clear_local_git_env; cd "$sm_path" &&
> > +					git branch -f "$branch" "$sha1" &&
> > +					git checkout "$branch")
>=20
> You wrote in earlier emails that you wanted to protect the user from
> non-fastforward changes. So I would expect a
>=20
> 	$ git pull --ff-only

I'm not pulling here, I'm doing a regular `submodule update`, and
after that's done I checkout the branch pointing at the $sha1 to which
the branch was just updated.  All the submodule-state-clobbering
caveats of a usual `submodule update` still apply to this new
`submodule update --branch`, and I'm fine with that.

> BTW, I am more and more convinced that an automatically manufactured
> commit on update with --branch should be the default.

Again, there's nothing to update.  The pull happens in a separate
step.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQtSCtAAoJEEUbTsx0l5OMcIEQALEzwOyRiWmRdH3O6x6omt8I
SCd0QnP9O79vVD+CI6WdFrHi+9tfNzyzoJolTxWojZK0RMpDO+GqICCGMo7KkjjQ
rxB+bC5C6XexyjhTbOGYzvgf6EIwB6ELWa5yDSwA2geQ6t3jm21CC+nLhg0fY32K
TIW5adiAiU8+kr4g22QgtKJM4sddZuNJTxyx2O1O0xVZ+QaWFmIRRXhJeWtaJEUg
6sUJ3ugcjl82vZLIowicJGeaKe3qH8U3k/8O575Ysj9HGksc0b+tH5WaKBzfKlb+
tHRL+NujFKzS4eHdzT+o73E99uS2iagbTAYW3+l9tjzLyOx/yFZThu6CpMILZgGq
awTneQOrjayqpMU2Fg+jsrmTa2VxopQFU7SCxjU+mLx6fPEBSQ/uwc7MbLMkO3dQ
iNH1pHTi7Y0KZK7IciBwNP3sDkA4dB5JZ1lxiQHsVY8IXZ1Dd/P0oH0vNVcOCI21
UG9G135u2WGaVSMDNnymQjCWNaL+Kh7PuMrK1S/l3ePjljQmzNe52iwOw4+wOsEO
FsV6wLzZX6hcRaxvLBaBJ4sgpEJzkkaHQizz/dhj0jcSn9TbxkS9I118TGQWNIJD
AuUb94IQimg+nvZkWynxBsM3orw90PaVOmteVqlyOhAlwwHNjYZytehnSg2CgtOP
hNPHKjSF2TUMEVy344u+
=rnZy
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
