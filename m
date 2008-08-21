From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Thu, 21 Aug 2008 16:06:10 +0200
Message-ID: <20080821140610.GS23800@genesis.frugalware.org>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com> <20080819132803.GA26201@laptop> <48AADDBB.1080203@viscovery.net> <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com> <7vfxozpeyh.fsf@gitster.siamese.dyndns.org> <237967ef0808201914k2cf8ad09s7b7d56dd8ea35d62@mail.gmail.com> <7vbpznkmbf.fsf@gitster.siamese.dyndns.org> <7v7iabklas.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 16:09:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWAoo-0004g8-SV
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 16:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbYHUOGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 10:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbYHUOGP
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 10:06:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:42590 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114AbYHUOGM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 10:06:12 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1FF861B2506;
	Thu, 21 Aug 2008 16:06:11 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 51AC14465E;
	Thu, 21 Aug 2008 15:09:07 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 93D591770019; Thu, 21 Aug 2008 16:06:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7iabklas.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93150>


--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2008 at 10:07:55PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > Yes, there are some weird patch in 'next'.  Miklos, could you fix the
> > output format of that thing?

You were faster. ;-)

> I do not think the code in 'next' that reuses the "help" thing to show
> only the list to stdout while still giving the error message to stderr
> makes any sense.
>=20
> Let's do this.
>=20
> ---
>=20
>  builtin-merge.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git c/builtin-merge.c w/builtin-merge.c
> index 1f9389b..3e8db0d 100644
> --- c/builtin-merge.c
> +++ w/builtin-merge.c
> @@ -110,9 +110,17 @@ static struct strategy *get_strategy(const char *nam=
e)
>  		}
>  	}
>  	if (!is_in_cmdlist(&main_cmds, name) && !is_in_cmdlist(&other_cmds, nam=
e)) {
> -
> -		fprintf(stderr, "Could not find merge strategy '%s'.\n\n", name);
> -		list_commands("strategies", longest, &main_cmds, &other_cmds);
> +		fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
> +		fprintf(stderr, "Available strategies are:");
> +		for (i =3D 0; i < main_cmds.cnt; i++)
> +			fprintf(stderr, " %s", main_cmds.names[i]->name);
> +		fprintf(stderr, ".\n");
> +		if (other_cmds.cnt) {
> +			fprintf(stderr, "Available custom strategies are:");
> +			for (i =3D 0; i < other_cmds.cnt; i++)
> +				fprintf(stderr, " %s", other_cmds.names[i]->name);
> +			fprintf(stderr, ".\n");
> +		}
>  		exit(1);
>  	}

Given that we don't have 100+ merge strategies like we have 100+ git
commands, I think printing them in one line should not be problematic,
and this definitely improves script usability, so I like it, thanks.

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkitdlIACgkQe81tAgORUJaSTQCgpV93UJvCqQHmxqUG2XetTRhK
dBkAn1zD/GRt5BT23EAQWzxX8LSNqc6C
=FvD0
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--
