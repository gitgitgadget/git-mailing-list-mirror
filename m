From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Tue, 10 Jun 2008 01:25:24 +0200
Message-ID: <20080609232524.GV29404@genesis.frugalware.org>
References: <alpine.DEB.1.00.0806091458190.1783@racer> <1213051426-11530-1-git-send-email-vmiklos@frugalware.org> <7v8wxefbtn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAPpM8TI9SUHvGJT"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:26:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qkn-0002rt-ML
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbYFIXZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755504AbYFIXZ2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:25:28 -0400
Received: from virgo.iok.hu ([193.202.89.103]:57533 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754918AbYFIXZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:25:27 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 975531B2546;
	Tue, 10 Jun 2008 01:25:26 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5341E44668;
	Tue, 10 Jun 2008 01:07:04 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3DD811770022; Tue, 10 Jun 2008 01:25:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8wxefbtn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84452>


--uAPpM8TI9SUHvGJT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2008 at 04:06:12PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>=20
> > +struct commit_list *get_octopus_merge_bases(struct commit_list *in, in=
t cleanup)
> > +{
> > +	struct commit_list *ret, *i;
> > +
> > +	ret =3D merge_bases_many(in->item, in->next);
> > +	if (cleanup)
> > +		for(i =3D in; i; i =3D i->next)
> > +			clear_commit_marks(i->item, all_flags);
> > +	return ret;
> > +}
>=20
> I suspect either me or you are confused, but how is this exactly used?
>=20
> The code for merge_bases_many(), at least the one I showed you a few days
> ago, is not a replacement for "show-branch --merge-base", and I do not
> think you would want to use it as such in the rewrite of git-merge, if you
> are trying to replace this part of git-merge.sh:
>=20
>         case "$#" in
>         1)
>                 common=3D$(git merge-base --all $head "$@")
>                 ;;
>         *)
>                 common=3D$(git show-branch --merge-base $head "$@")
>                 ;;
>         esac

Then I think I'm the one who is confused. My original
get_octopus_merge_bases() - in commit e13c0c2 - was exactly to replace
this part.

So, may I assume that the original get_octopus_merge_bases() is OK for
this purpose?

> The purpose of merge-base-many code was to improve this line in the
> git-merge-octopus.sh:
>=20
> 	common=3D$(git merge-base --all $MRC $SHA1) ||
> 		die "Unable to find common commit with $SHA1"
>=20
> Instead of keeping a single MRC, we can compute the merge-base-many
> between the SHA1 (i.e. the one we are looking at right now -- it is fed as
> "one") and all the previous SHA1's we have already looked at (they become
> "two's"), like this:
>=20
> 	common($git merge-base-many $SHA1 $SHA1_SO_FAR)
>=20
> and you would have at the end of the loop:
>=20
> 	SHA1_SO_FAR=3D"$SHA1_SO_FAR$SHA1 "
>=20
> or something.

Actually I do not want to touch git-merge-octopus.sh before
builtin-merge is not ready. (I try to "do one thing and do it
well".)

Thanks.

--uAPpM8TI9SUHvGJT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhNu+QACgkQe81tAgORUJbVWgCeNLnTF4Crq98a+wF6bkr5B5SU
HAIAoJ+iPnwhco5TqBgT1b5n+4Gw2FTf
=8nyD
-----END PGP SIGNATURE-----

--uAPpM8TI9SUHvGJT--
