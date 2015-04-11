From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] grep: correctly initialize help-all option
Date: Sat, 11 Apr 2015 02:34:21 +0200
Message-ID: <20150411003421.GA2111@pks-mb>
References: <1428586916-22679-1-git-send-email-ps@pks.im>
 <5526F535.4020407@web.de>
 <20150410052250.GA372@pks-pc.localdomain>
 <5527FB95.5010806@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 02:33:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgjM2-0004Fi-II
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 02:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbbDKAcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2015 20:32:53 -0400
Received: from sender1.zohomail.com ([74.201.84.162]:53488 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164AbbDKAcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 20:32:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; 
  b=tQyB0HS4Yt3WrbjsuXIPv9S2Gp/auTcz/HZneTD/oJOF7SkU3ZUlkEP5fIJlhn6HnKmJf+nu6DOu
    3NYyrOqhn4kDyGjlN9gePdjj+MiolsjqiqGIwTtucfOLeXe1upAoFTW7JgKZ7Uo5HORqr1Y8nHjE
    6S8FCl0La/1TkyX1j+E=  
Received: from localhost (dslb-094-222-027-198.094.222.pools.vodafone-ip.de [94.222.27.198]) by mx.zohomail.com
	with SMTPS id 1428712370476182.89876212434785; Fri, 10 Apr 2015 17:32:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5527FB95.5010806@web.de>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267019>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 06:34:29PM +0200, Ren=E9 Scharfe wrote:
> Am 10.04.2015 um 07:22 schrieb Patrick Steinhardt:
> > On Thu, Apr 09, 2015 at 11:55:01PM +0200, Ren=E9 Scharfe wrote:
> >> Am 09.04.2015 um 15:41 schrieb Patrick Steinhardt:
> >>> ---
> >>>    builtin/grep.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/builtin/grep.c b/builtin/grep.c
> >>> index abc4400..c0bf005 100644
> >>> --- a/builtin/grep.c
> >>> +++ b/builtin/grep.c
> >>> @@ -738,7 +738,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
> >>>    			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
> >>>    		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
> >>>    			 N_("allow calling of grep(1) (ignored by this build)")),
> >>> -		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage"),
> >>> +		{ OPTION_CALLBACK, 0, "help-all", &opt, NULL, N_("show usage"),
> >>>    		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
> >>>    		OPT_END()
> >>>    	};
> >>
> >> help_callback() returns -1 immediately, IOW the value pointer is never
> >> used anyway.  So why does your change make a difference?  *puzzled*
> >>
> >> We could pass NULL instead, as in builtin/show-ref.c, which would make
> >> it clear that the pointer is just a dummy.
> >
> > Changed in v2, as well.
>=20
> Thank you.  I should really re-fetch from Gmane before finishing an=20
> interrupted reply..
>=20
> > In general the change won't make any difference when running the
> > command. But as said in the commit message it caused gcc (gcc
> > version 4.8.3 (Gentoo Hardened 4.8.3 p1.1, pie-0.5.9), ARMv7 HF)
> > to segfault when &options was passed in as value. Even though
> > this is probably an error in gcc we can easily work around it by
> > doing the Right Thing here.
>=20
> OK, so does it crash on this one-liner as well?
>=20
> 	struct t {void *p;} s =3D {&s};
>=20
> Or on this?
>=20
> 	void *p =3D &p;
>=20
> If yes then the author of the hardening feature might be interested in=20
> this fact.
>=20
> Ren=E9

No, the segfault is not triggered by this. I've also tried to use
the exact arguments to gcc that are used when compiling grep.c,
but to no avail. I'll maybe try to reproduce this with a minimal
testcase next week.

Regards
Patrick

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVKGwNAAoJEBF8Z7aeq/EsMj8P/R+72zo7Cq7r49elER3BHoHj
9qhKTe6GweVqKHpshQevrphm+jHUIOQjUPDhuNI5PRShMc9XyPU1keYLBQynI5Ps
CFMoiFSVPED4MUym8Yg9zZMkusgYaLoVS4E2MXUCOMeDlKbov+VY99EQzSebkHur
tsy1Ole4v2sairr6F/rfWS1SU5iJdIOhUjiNDJsCaFt4d/Kq/ixc3JEjZN6XGatc
xILAHpfWyLbP2v7CYvdkFGTYxBP8L7St41bW90lMPzBczCQTbNICaGGLnJzhYjPE
ltahR/OccXDorVgSXX81JlJQKpchyjor+/xWFjLR9Z3GDb5HwO6JrJOCTnTnv6J0
Lm1+RspbDtMBwURohVB+W5lcGZyI3KSoNrEd+HEnDQ3bMlpILsvIQSB66jNo4fKu
cu9ehAGzXD0WnsBNN6ECnQ2ZgIaXc6HSc3/FLM3FH/H5qcR67fZUt+YZc3EK+gRk
i/kZo2tjnQLKbOsBc3dYltssCZmOG51EhMP1gmjTra3F2pdvGygyvWhmXjGNAV14
nU6hcEyedM0B55YL45NT3u5apSqhXLgyOWs/PdyO5TjwIbUlioBHuClviMrPmnnC
t6T29Y3/71MSQv2trit34d9zRsWS4Fn2TigoHGxt1PH03Ys2bxe+EGnLZR0gayNG
eMdv5sauOppBX5V6dsmi
=prnw
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
