From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Mon, 03 Dec 2012 10:38:55 -0500
Message-ID: <20121203153855.GA14981@odin.tremily.us>
References: <20121202211159.GA12429@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 16:39:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfY7R-0004fn-AR
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 16:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab2LCPjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 10:39:25 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:31980 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab2LCPjY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 10:39:24 -0500
Received: from odin.tremily.us ([unknown] [72.68.101.162])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEG00ICKOSW6ZB0@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 03 Dec 2012 09:39:02 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id E13CE6E53BA; Mon,
 03 Dec 2012 10:38:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354549135; bh=nfyl7YeCBqHfpvdPIxKjtEemVfDyqtUyB1ElJN43CEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OQfPSU6P4vGiUoXIN2XvXaiYeA+sTy2bikytZmV7dLNoZvHi6EznVawwrBX5fIJix
 dEaeqbowkqdXgXDcYGXrMXF/ph8qsVbDmNkvaNqpF6YfDwa2ek0P4k0C8XGHwpBVbI
 rrZCRoe3BlcUHjM6ju7+1geuah2Yk78hcAfLtEmU=
Content-disposition: inline
In-reply-to: <20121202211159.GA12429@odin.tremily.us>
 <20121201165404.GD4823@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211042>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2012 at 04:11:59PM -0500, W. Trevor King wrote:
> On Sun, Dec 02, 2012 at 09:29:29PM +0100, Jens Lehmann wrote:
> > Am 01.12.2012 18:49, schrieb W. Trevor King:
> > > On Sat, Dec 01, 2012 at 06:25:17PM +0100, Jens Lehmann wrote:
> > >> What real world problems do we have with the current init/sync that
> > >> this approach would solve?
> > >
> > > I don't have any, ...
> >=20
> > We don't want to change working code and cause compatibility issues
> > just because we /could/ do things differently, no?
>=20
> In principle, yes, but in this case I think changing the
> implementation does not risk much in the way of compatibility issues
> (it only hurts users who rely on `submodule init` setting
> submodule.<name>.url for reasons of their own.  A few of the existing
> tests explictly check the url setting, so perhaps there are a number
> of users who do require this side effect?
>=20
> I think this risk is outweighed by the benefits of having a clearer
> activation option.

For anyone interested in an implementation of my
submodule.<name>.active proposal, I've posted an initial version:

  git://github.com/wking/git.git wtk/submodule.name.active

I can re-post it here as a PATCH series, but I don't think we're at
the level of patch-specific feedback yet.

I'm currently pretty happy with it except for the last commit:

  HACK work around missing index entry for existing empty submodules

To solve that cleanly, I'd need a solution to the commit-less existing
repository problem which I mentioned earlier:

On Sat, Dec 01, 2012 at 11:54:04AM -0500, W. Trevor King wrote:
> I'm currently stuck with adding a commit-less existing repository as a
> submodule (which happens in t7400-submodule-basic.sh, ../bar/a/b/c
> works with relative local path):
>=20
>   $ mkdir -p super/sub
>   $ cd super
>   $ git init
>   $ (cd sub && git init)
>   $ git submodule add ./ sub
>   $ git status
>   # On branch master
>   #
>   # Initial commit
>   #
>   # Changes to be committed:
>   #   (use "git rm --cached <file>..." to unstage)
>   #
>   #       new file:   .gitmodules
>   #
>=20
> What I'm missing is a gitlink form sub for 'Subproject commit
> 00000...' or some such.  When the subproject has an actual commit,
> things work as expected:
>=20
>   $ mkdir -p super/sub
>   $ cd super
>   $ git init
>   $ (cd sub && git init && echo line-1 > file && git add file && git comm=
it -m file)
>   $ git submodule add ./ sub
>   $ git status
>   # On branch master
>   #
>   # Initial commit
>   #
>   # Changes to be committed:
>   #   (use "git rm --cached <file>..." to unstage)
>   #
>   #       new file:   .gitmodules
>   #       new file:   sub
>   #
>=20
> This means that module_list isn't aware of the empty submodule, when
> the user has just explicitly added it.  Fixing this would seem to need
> either 'Subproject commit 00000...' as I suggested earlier, or an
> adjustment to module_list that also spits out submodules that are in
> .gitmodules but not in the index.

Other than that, I think all the changes in the test suite are
logically sound and unlikely to cause problems with existing usage.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQvMeOAAoJEEUbTsx0l5OMwL4P/2Mvm4XOgwWPLoxiia2weoaF
NbhhlydqkoVtrRQNzZSDkTs8416lwvJRlRJephvKjv/fzKXL3PKe8PBpnuMguqcs
agYIfJrBfFVdbzEyP/Ds/beQQ81WbCpn1IDgxCLI80HanNGtEe2bpncWp1E/I+JM
DTQhRod6O62xoLFVgqI6rpJtNqxwxoBru14YzBpWScD8UOSPL+p3Gc/sNnxe6Q+N
awAx83yQtpo0txHuuyww/NwOyWwOtJJCRhl2eE+fhV4WXY8D635YFZFX3HFa8qsb
cYmlyKZM82Ht8HhmG5VLrE9fCTdUwpouEbyio1fts8FoZ2UPV+iuSDrDJxdAKNw5
ZCtH/eZ34P7Fx9v7WdFhA+o9zKNKzyT/TodV+hsuhrG/f5Bl0ix8lRTZ+YO8Ycoy
MfTPqT2HiaQe0nWe5XlHhO96bolRQa2b/BJfCELWWIc4yb0FgSpFqA4PKJJBMMmL
zDErjpIUmJUYPdlG9o3+U2mQlZx/VY+XpJWGZbII7A8knyLI8a0hh8GjhvTKlIsp
3sPFlRdUN/vcrp6f0ivVVWH3z/wmMObvmcqFC4MauGQOkMN2H1qngnrAmO0jQoF7
9cb/57rrpTPsFNUWvYocXQvcdicILP7XAPMlkzBxz1cMn+gm459JgCE8mYceA7cX
9Gp32YojTgeLTaY8iy2i
=CxdG
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
