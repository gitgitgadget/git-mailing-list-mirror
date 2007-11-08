From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH DIFF-CLEANUP 1/2] Make the diff_options bitfields be an unsigned with explicit masks.
Date: Thu, 08 Nov 2007 09:17:16 +0100
Message-ID: <20071108081716.GC6528@artemis.corp>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org> <1194430832-6224-2-git-send-email-madcoder@debian.org> <1194430832-6224-3-git-send-email-madcoder@debian.org> <1194430832-6224-4-git-send-email-madcoder@debian.org> <1194430832-6224-5-git-send-email-madcoder@debian.org> <1194430832-6224-6-git-send-email-madcoder@debian.org> <1194430832-6224-7-git-send-email-madcoder@debian.org> <7vy7d95ji1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="NU0Ex4SbNnrxsi6C";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:17:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2Zz-0008HO-NR
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997AbXKHIRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758751AbXKHIRU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:17:20 -0500
Received: from pan.madism.org ([88.191.52.104]:47707 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758302AbXKHIRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:17:19 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 01BE528BD8;
	Thu,  8 Nov 2007 09:17:18 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id EC54E31A843; Thu,  8 Nov 2007 09:17:16 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy7d95ji1.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63959>


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2007 at 06:39:02AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > reverse_diff was a bit-value in disguise, it's merged in the flags now.
> >
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
>=20
> Just my first impression, as I am in the middle of unrelated
> bisect.  I haven't read beyond diff-lib.c changes.
>=20
> > diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
> > index 0b591c8..e71841a 100644
> > --- a/builtin-diff-tree.c
> > +++ b/builtin-diff-tree.c
> > @@ -118,12 +118,12 @@ int cmd_diff_tree(int argc, const char **argv, co=
nst char *prefix)
> >  	}
> > =20
> >  	if (!read_stdin)
> > -		return opt->diffopt.exit_with_status ?
> > -		    opt->diffopt.has_changes: 0;
> > +		return DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS)
> > +			&& DIFF_OPT_TST(&opt->diffopt, HAS_CHANGES);
>=20
> Had to think a bit about this, although it is correct.
>=20
> >  	if (opt->diffopt.detect_rename)
> >  		opt->diffopt.setup |=3D (DIFF_SETUP_USE_SIZE_CACHE |
> > -				       DIFF_SETUP_USE_CACHE);
> > +							   DIFF_SETUP_USE_CACHE);
>=20
> I wonder what this is about.

  err I code with tabs of size 4 and I believe my editor was
over-zealous when I asked to reindent some part that I changed :P

> > diff --git a/combine-diff.c b/combine-diff.c
> > index fe5a2a1..3cab04b 100644
> > --- a/combine-diff.c
> > +++ b/combine-diff.c
> > @@ -664,7 +664,7 @@ static void show_patch_diff(struct combine_diff_pat=
h *elem, int num_parent,
> >  	int mode_differs =3D 0;
> >  	int i, show_hunks;
> >  	int working_tree_file =3D is_null_sha1(elem->sha1);
> > -	int abbrev =3D opt->full_index ? 40 : DEFAULT_ABBREV;
> > +        int abbrev =3D DIFF_OPT_TST(opt, FULL_INDEX) ? 40 : DEFAULT_AB=
BREV;
>=20
> Indent?

  will fix.

> > diff --git a/diff-lib.c b/diff-lib.c
> > index da55713..69b5dc9 100644
> > --- a/diff-lib.c
> > +++ b/diff-lib.c
> > @@ -188,8 +188,7 @@ static int handle_diff_files_args(struct rev_info *=
revs,
> >  		else if (!strcmp(argv[1], "-n") ||
> >  				!strcmp(argv[1], "--no-index")) {
> >  			revs->max_count =3D -2;
> > -			revs->diffopt.exit_with_status =3D 1;
> > -			revs->diffopt.no_index =3D 1;
> > +			revs->diffopt.flags |=3D DIFF_OPT_EXIT_WITH_STATUS | DIFF_OPT_NO_IN=
DEX;
> >  		}
>=20
> Now this looks harder to read that everybody else uses
> DIFF_OPT_SET() for this, without DIFF_OPT_ prefix for the
> bitmask names.

  that could be splitted in two DIFF_OPT_SET indeed. will do.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMsYMvGr7W6HudhwRArmkAJ4u6iqn8IjBGtU8I42ja8x9fJY/6gCgkQ1U
sse4hMWeBID61SRXtpYzHMY=
=/ynq
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
