From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Mon, 03 Mar 2014 21:34:26 +0100
Message-ID: <1393878866.7891.22.camel@Naugrim>
References: <1393858066.7891.20.camel@Naugrim> <5314BFA5.2030807@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mqvi2tD9Qj3u/IJ3Jsvm"
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 03 21:34:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKZZN-0002iY-RG
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 21:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbaCCUed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 15:34:33 -0500
Received: from smtpout5.laposte.net ([193.253.67.230]:21875 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbaCCUec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 15:34:32 -0500
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8509-out with ME
	id Z8aS1n0092iaXuy038aSv0; Mon, 03 Mar 2014 21:34:27 +0100
In-Reply-To: <5314BFA5.2030807@web.de>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243268>


--=-mqvi2tD9Qj3u/IJ3Jsvm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 03 mars 2014 =C3=A0 17:45 +0000, Jens Lehmann a =C3=A9crit :
> Am 03.03.2014 14:47, schrieb Henri GEIST:
> > This new option prevent git submodule <add|update> to clone the missing
> > submodules with the --separate-git-dir option.
> > Then the submodule will be regular repository and their gitdir will not
> > be placed in the superproject gitdir/modules directory.
>=20
> And what is your motivation for this? After all submodules containing
> a .git directory are second class citizens (because they can never be
> safely removed by regular git commands).
>

I recognize most people will prefer to have the .git directory separate.
And I do not intend to make this option the default.

My reasons are:

  - As it is not clearly stated in the doc that the gitdir is separate.
    The first time I have copied one module to an USB key I had a big
    surprise.

  - This will not change anything for people not using it.

  - I use an other patch which I plane to send later which enable multiple
    level of superproject to add a gitlink to the same submodule.
    And in this case the superproject containing the separate gitdir will b=
e
    arbitrary and depend on the processing order of the
    'git submodule update --recursive' command.

  - I have written this for myself and have using it since 2012 and send it=
 in
    the hope it could be useful for someone else even if it is only a few
    people. But if its not the case no problem I will keep using it for mys=
elf.


> > Signed-off-by: Henri GEIST <geist.henri@laposte.net>
> > ---
> >  Documentation/git-submodule.txt |   18 ++++++++++++++++--
> >  git-submodule.sh                |   22 ++++++++++++++++++++--
> >  t/t7400-submodule-basic.sh      |   12 ++++++++++++
> >  3 files changed, 48 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
> > index 21cb59a..303a475 100644
> > --- a/Documentation/git-submodule.txt
> > +++ b/Documentation/git-submodule.txt
> > @@ -10,13 +10,14 @@ SYNOPSIS
> >  --------
> >  [verse]
> >  'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name=
>]
> > -	      [--reference <repository>] [--depth <depth>] [--] <repository> =
[<path>]
> > +	      [--reference <repository>] [--depth <depth>] [--no-separate-git=
-dir]
> > +	      [--] <repository> [<path>]
> >  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>=
...]
> >  'git submodule' [--quiet] init [--] [<path>...]
> >  'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
> >  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
> >  	      [-f|--force] [--rebase|--merge|--checkout] [--reference <reposi=
tory>]
> > -	      [--depth <depth>] [--recursive] [--] [<path>...]
> > +	      [--depth <depth>] [--recursive] [--no-separate-git-dir] [--] [<=
path>...]
> >  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-li=
mit) <n>]
> >  	      [commit] [--] [<path>...]
> >  'git submodule' [--quiet] foreach [--recursive] <command>
> > @@ -107,6 +108,10 @@ is the superproject and submodule repositories wil=
l be kept
> >  together in the same relative location, and only the
> >  superproject's URL needs to be provided: git-submodule will correctly
> >  locate the submodule using the relative URL in .gitmodules.
> > ++
> > +If `--no-separate-git-dir` is specified, missing submodules will be cl=
oned
> > +has normal git repository without the option `--separate-git-dir` poin=
ting
> > +to the modules directory of the superproject gitdir.
> > =20
> >  status::
> >  	Show the status of the submodules. This will print the SHA-1 of the
> > @@ -185,6 +190,10 @@ If the submodule is not yet initialized, and you j=
ust want to use the
> >  setting as stored in .gitmodules, you can automatically initialize the
> >  submodule with the `--init` option.
> >  +
> > +If `--no-separate-git-dir` is specified, missing submodules will be cl=
oned
> > +has normal git repository without the option `--separate-git-dir` poin=
ting
> > +to the modules directory of the superproject gitdir.
> > ++
> >  If `--recursive` is specified, this command will recurse into the
> >  registered submodules, and update any nested submodules within.
> >  +
> > @@ -363,6 +372,11 @@ for linkgit:git-clone[1]'s `--reference` and `--sh=
ared` options carefully.
> >  	clone with a history truncated to the specified number of revisions.
> >  	See linkgit:git-clone[1]
> > =20
> > +--no-separate-git-dir::
> > +	This option is valid for add and update commands. Specify that missin=
g
> > +	submodules should be clonned as self contain repository without a
> > +	separate gitdir placed in the modules directory of the superproject
> > +	gitdir.
> > =20
> >  <path>...::
> >  	Paths to submodule(s). When specified this will restrict the command
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index a33f68d..36eaf31 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -5,11 +5,11 @@
> >  # Copyright (c) 2007 Lars Hjemli
> > =20
> >  dashless=3D$(basename "$0" | sed -e 's/-/ /')
> > -USAGE=3D"[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--r=
eference <repository>] [--] <repository> [<path>]
> > +USAGE=3D"[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--r=
eference <repository>] [--no-separate-git-dir] [--] <repository> [<path>]
> >     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path=
>...]
> >     or: $dashless [--quiet] init [--] [<path>...]
> >     or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> > -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] =
[-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] =
[--] [<path>...]
> > +   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] =
[-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] =
[--no-separate-git-dir] [--] [<path>...]
> >     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit=
 <n>] [commit] [--] [<path>...]
> >     or: $dashless [--quiet] foreach [--recursive] <command>
> >     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
> > @@ -36,6 +36,7 @@ update=3D
> >  prefix=3D
> >  custom_name=3D
> >  depth=3D
> > +noseparategitdir=3D
> > =20
> >  # The function takes at most 2 arguments. The first argument is the
> >  # URL that navigates to the submodule origin repo. When relative, this=
 URL
> > @@ -270,6 +271,17 @@ module_clone()
> >  		quiet=3D-q
> >  	fi
> > =20
> > +
> > +	if test -n "$noseparategitdir"
> > +	then
> > +		(
> > +			clear_local_git_env
> > +			git clone $quiet ${depth:+"$depth"} -n ${reference:+"$reference"} "=
$url" "$sm_path"
> > +		) ||
> > +		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path=
' failed")"
> > +		return
> > +	fi
> > +
> >  	gitdir=3D
> >  	gitdir_base=3D
> >  	base_name=3D$(dirname "$name")
> > @@ -359,6 +371,9 @@ cmd_add()
> >  		-q|--quiet)
> >  			GIT_QUIET=3D1
> >  			;;
> > +		--no-separate-git-dir)
> > +			noseparategitdir=3D1
> > +			;;
> >  		--reference)
> >  			case "$2" in '') usage ;; esac
> >  			reference_path=3D$2
> > @@ -758,6 +773,9 @@ cmd_update()
> >  		-f|--force)
> >  			force=3D$1
> >  			;;
> > +		--no-separate-git-dir)
> > +			noseparategitdir=3D1
> > +			;;
> >  		-r|--rebase)
> >  			update=3D"rebase"
> >  			;;
> > diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> > index c28e8d8..aa2df3d 100755
> > --- a/t/t7400-submodule-basic.sh
> > +++ b/t/t7400-submodule-basic.sh
> > @@ -81,6 +81,18 @@ inspect() {
> >  	)
> >  }
> > =20
> > +test_expect_success 'submodule add --no-separate-git-dir' '
> > +	(
> > +		cd addtest &&
> > +		rm -rf submod &&
> > +		git submodule add --no-separate-git-dir -q "$submodurl" submod >actu=
al &&
> > +		test_must_be_empty actual &&
> > +		test -d submod/.git &&
> > +		rm -rf submod &&
> > +		git reset --hard
> > +	)
> > +'
> > +
> >  test_expect_success 'submodule add' '
> >  	echo "refs/heads/master" >expect &&
> >  	>empty &&
> >=20
>=20




--=-mqvi2tD9Qj3u/IJ3Jsvm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMU51IACgkQkKuHPdwEGdSghgD/QU4QxMzGew8qXLbPGaHe0+z1
SpdKQVYNO2eaf4uLEUwA/1ZVEpRYGfK9n67zmIMFGdQBNbc+zNhgLNepcchTFeMs
=lzGQ
-----END PGP SIGNATURE-----

--=-mqvi2tD9Qj3u/IJ3Jsvm--
