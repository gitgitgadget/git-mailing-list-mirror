From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 12:49:20 -0500
Message-ID: <20121201174920.GE4823@odin.tremily.us>
References: <20121201163004.GB4823@odin.tremily.us> <50BA3D7D.8040707@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Dec 01 18:56:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TerIo-0005Ya-US
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 18:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab2LARtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 12:49:24 -0500
Received: from vms173005pub.verizon.net ([206.46.173.5]:54628 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab2LARtX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 12:49:23 -0500
Received: from odin.tremily.us ([unknown] [72.68.81.98])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MED0075V5I8QQ30@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 01 Dec 2012 11:49:22 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 8FE3D6E3D43; Sat,
 01 Dec 2012 12:49:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354384160; bh=1q8d61yATutKJ5rWovSdVj7VpPU8XaK7vNL0JA/iGHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NKUgCsSc+negx3X0xRG1vhVk2BLSuBkszixUG4teByqh/m6NdMAdy6KoIREJhV5C5
 f9kXz0O+R3qn7WlsGYkbN1buakNdvhfvtTIWpxGhfPoHPq1Dr3epFrVdeeDSfmD3I/
 lKdSQ3mHsy6vCr5NQfGZ+7j607nycUnoU/ckqs2w=
Content-disposition: inline
In-reply-to: <50BA3D7D.8040707@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210983>


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2012 at 06:25:17PM +0100, Jens Lehmann wrote:
> Am 01.12.2012 17:30, schrieb W. Trevor King:
> > On Sat, Dec 01, 2012 at 04:38:02PM +0100, Jens Lehmann wrote:
> > > 1) It tells the submodule commands that the user wants to have
> > > that submodule populated (which is done in a subsequent "update"
> > > after "init" copied the url there).
> >=20
> > Good point, but this should depend on submodule.<name>.update;
> > having it as a side effect of a local submodule.<name>.url makes
> > no sense.
>=20
> Sorry, but that makes tons of sense: url controls if the submodule
> is to be populated and from where, update controls how (and can even
> veto populating it if set to "none"). We /could/ do it differently,
> but I can't see why we should (and risk severe compatibility issues).

I think removing `init` will cause some compatibility issues anyway,
so I was re-imaging how you do it.  I don't think update=3D'none' and
"don't populate my submodule" are distinct ideas, while a locally
configured url=3D"somwhere" and "please populate my submodule" are (with
the blank-url case defaulting to the superproject itself).

> > > 2) It can be used to follow moving upstreams (think of checking
> > > out an earlier commit before the upstream was moved, you won't
> > > be able to clone it from there without having the new setting
> > > persist). And which repository you follow is a matter of trust,
> > > so the extra "git submodule sync" in that case is a good thing
> > > to have.
> > >=20
> > > So I believe 'url' is the only setting that should be copied
> > > into .git/config while all the others shouldn't.
> >=20
> > If you want to override the old repository location for an old
> > commit, setting submodule.<name>.url makes sense.  My rewritten
> > `sync` updates the local submodule.<name>.url in the superproject
> > if the configuration option is already set [1].  Perhaps a `sync
> > --local` invocation should forcibly populate the local
> > submodule.<name>.url to make this workflow easier.  Bundling sugar
> > for this special case should not happen under an extra command
> > called `init`.
>=20
> What real world problems do we have with the current init/sync that
> this approach would solve?

I don't have any, but in my `update --remote` series I'm adding two
new config options that are handled differently (define in
=2Egitmodules, override in superproject .git/config) than existing
submodules options.  I'm trying to avoid confusing users by
standardizing on the more flexible method, which avoids copying stuff
into the superproject's .git/config, and under which the current
`init` functionality doesn't make much sense.

> > > > [snip get_submodule_config()]
> > >
> > > Something like that makes sense. You can use it for the settings
> > > you add first and we can then reuse that for 'update' in a
> > > separate patch later.
> >=20
> > I'm currently working out the details independently against
> > v1.8.0. This will be a fairly major shift, so I think it should
> > stay independent of `update --remote`.  The `update --remote`
> > stuff should be easy to adjust/rebase if the `init`
> > removal/adjustment develops into something acceptable.
>=20
> I totally agree. Let's get the `update --remote` stuff ready first.

Ok, but we'll have the possible confusion about option setting that I
mention above.  Still, it's good to minimize the number of irons in
the fire, and an `init` removal will probably not get in until 2.0
anyway.  If other people are fine with the different initialization
paths, I'll put the init-removal on hold for now.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQukMeAAoJEEUbTsx0l5OMtJ4P/3UfbXVIlCxvAa/1rNfhMgNr
qN0kzpjTFlsrNaG65YOJ2rRPGo7qdDeJoyDW+p5td4vh1+U0mrE8sBggsqsnICNg
DsqSawbOphld5IgnApHBRP7EhFeud4nCIj27pnrAJeU083ay3AHq6KepZNh0C7or
imdZyxuffdf+cDFeq6is1Uz8sI1cwH3II8X82g9J1Cti7UkpM2N0gcpRyVeHAlVE
8k1yjqgIoumb25k9F0qMRzbZRfZ4CrQ0IwCjSo/LUXUAWb69UQgpuHsQ8hQ9eKKo
b8JwvQXZ6x+5z8pjhbLD+0+JFTcs0ROJiny2YKEfuFUIFcqvxhXwpr7GYlobplif
povGRb3fu2lHtEb4Z6M6qjQzAL7zeEc70drxusblzoB2oTZkE2wNEWxIDmyyRFvM
+d+8N8axxwkcfNTeVhLBZX3RoZVbIjxEIQCLFaiHhHHyE3r+8kyVuzC8mqQFyJCO
YEM9TfdjtZE8jzHLnrhp9I5ogbRHmC5yeGJXCvwd8NySZo2F66JxPex5pWqsRNCd
zRyUzjZhzU/GqApNlXlPdiI3w49WG4nKi/7BVtGH2XyIFBaAbts1Y2PX2sBf7lN7
CJ4b7E+ED8MyAJK4j61LLgJ4yL63UQjEGE3ygwSyz6fZD1YCGQVfM33YDaplXL2T
AamnW3hvvEGTdVU88AXP
=LkY8
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
