From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v7 2/3] submodule update: add --remote for submodule's
 upstream changes
Date: Wed, 12 Dec 2012 18:02:17 -0500
Message-ID: <20121212230217.GB7729@odin.tremily.us>
References: <20121204001717.GA17375@odin.tremily.us>
 <cover.1355251862.git.wking@tremily.us>
 <64d109da03c521303ad87b8370bf09ab28a5c09f.1355251862.git.wking@tremily.us>
 <CABURp0oLmSjiZAOJxEzwSmL+jimpVj8DcDi-odPTzCpCcyH8yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:02:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TivKF-00067c-0S
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab2LLXCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:02:33 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:56599 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab2LLXCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:02:32 -0500
Received: from odin.tremily.us ([unknown] [72.68.110.234])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEX006A8XBUY200@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 12 Dec 2012 17:02:21 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 0279B71CC2D; Wed,
 12 Dec 2012 18:02:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1355353338; bh=X5H+8Ew/z/zirmuvNbKd9gwUg8EjXFnizMha7e7MyBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T4jx2bQVfKwvSfFEEyICN7hRhXfndcSfCW4MO+/+YtjdHUvlBDHxZT3LEEva+Wue/
 oc+uAgf64U6ilKl6UFUxBH39ThKDujSWNHpHETd+9SyfjOXv4R8ws5JFYGIxUjrjnw
 KOWbxevXiyiAh/4G0USixJDu9J9S8xcqu9N5lzrE=
Content-disposition: inline
In-reply-to: <CABURp0oLmSjiZAOJxEzwSmL+jimpVj8DcDi-odPTzCpCcyH8yA@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211410>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 12:43:23PM -0500, Phil Hord wrote:
> On Tue, Dec 11, 2012 at 1:58 PM, W. Trevor King <wking@tremily.us> wrote:
> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
> > =E2=80=A6
> > +--remote::
> > [snip some --remote documentation]
> > +In order to ensure a current tracking branch state, `update --remote`
> > +fetches the submodule's remote repository before calculating the
> > +SHA-1.  This makes `submodule update --remote --merge` similar to
> > +running `git pull` in the submodule.  If you don't want to fetch (for
> > +something closer to `git merge`), you should use `submodule update
> > +--remote --no-fetch --merge`.
>=20
> I assume the same can be said for 'submodue update --remote --rebase',
> right?

Yes.

> I wonder if this can be made merge/rebase-agnostic.  Is it still
> true if I word it like this?:
>=20
>    In order to ensure a current tracking branch state, `update --remote`
>    fetches the submodule's remote repository before calculating the
>    SHA-1.  If you don't want to fetch, you should use `submodule update
>     --remote --no-fetch`.

Works for me.  Will change in v8 (which I'll base on 'master').

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index f969f28..1395079 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -8,7 +8,8 @@ dashless=3D$(basename "$0" | sed -e 's/-/ /')
> >  USAGE=3D"[--quiet] add [-b branch] [-f|--force] [--reference <reposito=
ry>] [--] <repository> [<path>]
> >     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path=
>...]
> >     or: $dashless [--quiet] init [--] [<path>...]
> > -   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force=
] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path=
>...]
> > +   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] =
[-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] =
[--] [<path>...]
> > +ges
>=20
> I think there's an unintentionally added line here with "ges".

That is embarrassing :p.  Will fix in v8.

> > +               if test -n "$remote"
> > +               then
> > +                       if test -z "$nofetch"
> > +                       then
> > +                               # Fetch remote before determining track=
ing $sha1
> > +                               (clear_local_git_env; cd "$sm_path" && =
git-fetch) ||
>=20
> You should 'git fetch $remote_name' here, and of course, initialize
> remote_name before this.  But how can we know the remote_name in the
> first place?  Is it safe to assume the submodule remote names will
> match those in the superproject?

The other git-fetch call from git-submodule.sh is also bare (i.e. no
specified remote).  When the remote needs to be specified, other
portions of git-submodule.sh use $(get_default_remote), which is (I
think) what the user should expect.  v6 of this series had a
configurable remote name, but Junio wasn't keen on the additional
configuration option.  I don't really mind either way.

>=20
> > +                               die "$(eval_gettext "Unable to fetch in=
 submodule path '\$sm_path'")"
> > +                       fi
> > +                       remote_name=3D$(get_default_remote)
>=20
> This get_default_remote finds the remote for the remote-tracking
> branch for HEAD in the superproject.  It is possible that HEAD !=3D
> $branch, so we have very few clues to go on here to get a more
> reasonable answer, so I do not have any good suggestions to improve
> this.

For detached HEADs, get_default_remote should fall back to 'origin',
which seems sane.  If the user wants a different default, they've
likely checkout out a branch in the submodule, setup that branch's
remote, and will be using --merge or --rebase.  If anyone expects
users who will be using detached heads to *want* to specify a
different remote than 'origin', that would be a good argument for
reinstating my submodule.<name>.remote patch from v6.

> > +                       sha1=3D$(clear_local_git_env; cd "$sm_path" &&
> > +                               git rev-parse --verify "${remote_name}/=
${branch}") ||
>=20
> This does assume the submodule remote names will match those in the
> superproject.  Is this safe?

Another good catch.  I should be calling get_default_remote after
cd-ing into the submodule.  Will change in v8.

Thanks for the feedback :)
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQyQz4AAoJEEUbTsx0l5OMGVEP/0F2YzSuRf99bq3PmiPW9Ysi
5HvJTLsF5OhrjxFOWkKpOM52Ev6puJobxm0liCRf/7dubFU3cVnuJ9eBqGiWHkhl
yKfiJhxq0iu7n5s19HUH4Bi/JMEzGalMeOY/SZX6jEIF/hY4WJ71sQ73HYdN5Gpi
6TEaebAVvG2eqUIangaRg+IYpAOVWnHPOVGlHBDBEPIvTSdEtJwFIq5kAl/1FTAX
pvWr8F1iQar28A/SMZxS6pASPv1D8hY47nWlKSMEbWvg3UCvGbq5LYXyZPn5notJ
9GdyuT6St4gOo+PrBexpirkbr99PTcG2wmDnl6eh7eR2TWVVxd1mIBp76ZsKyELF
+E0S0/EEcY63gmo59oHAhF+BDQ0aKXd8g2Hps4blOyc6JBYXLza3hhwOV6fuKGz2
gZJka6xHPjJO/4DTfS1uFXDfVifgGXCmxoXY7kUrPX9qlbRLy3ibFoZo5al8jFKq
hLsno5TUEawOiIFijBeI6FnxuwcxUHia1LfZXAugwncaQyYox7VXxI7eI+QYhRgM
EexehwYRQaN/2kEMxA6DE/LipiXlA8eXbepHI/T81W22og2yLWYAHUp5qO2knzmT
2wVHJ3HNQrpT6JvSfD8rxStT0Y8TkjTacgB/P5Cdxswagf0cEDpLg6KVz54XYCEG
yi9M8wasRE1wOPfjGjui
=MCp3
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
