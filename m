From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH v2] cherry-pick: make sure all input objects are commits
Date: Thu, 11 Apr 2013 13:03:25 +0200
Message-ID: <20130411110324.GD12770@suse.cz>
References: <20130403092704.GC21520@suse.cz>
 <7v38v1yn8o.fsf@alter.siamese.dyndns.org>
 <20130411092638.GA12770@suse.cz>
 <CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 13:03:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQFI7-00073o-W8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 13:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763192Ab3DKLDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 07:03:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42292 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761383Ab3DKLD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 07:03:28 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8B25DA3A78;
	Thu, 11 Apr 2013 13:03:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220844>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2013 at 03:52:44PM +0530, Ramkumar Ramachandra <artagnon@gm=
ail.com> wrote:
> > +       for (i =3D 0; i < opts->revs->pending.nr; i++) {
> > +               unsigned char sha1[20];
> > +               const char *name =3D opts->revs->pending.objects[i].nam=
e;
> > +
> > +               if (!get_sha1(name, sha1)) {
> > +                       enum object_type type =3D sha1_object_info(sha1=
, NULL);
> > +
> > +                       if (type > 0 && type !=3D OBJ_COMMIT)
> > +                               die(_("%s: can't cherry-pick a %s"), na=
me, typename(type));
> > +               }
>=20
> else?  What happens if get_sha1() fails?

I guess that is a should-not-happen category. parse_args() calls
setup_revisions(), and that will already die() if the argument is not a
valid object at all.

> > diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-=
many-commits.sh
> > index 4e7136b..19c99d7 100755
> > --- a/t/t3508-cherry-pick-many-commits.sh
> > +++ b/t/t3508-cherry-pick-many-commits.sh
> > @@ -55,6 +55,12 @@ one
> >  two"
> >  '
> >
> > +test_expect_success 'cherry-pick three one two: fails' '
> > +       git checkout -f master &&
> > +       git reset --hard first &&
> > +       test_must_fail git cherry-pick three one two:
> > +'
>=20
> So you're testing just the third case (where commit objects are mixed
> with non-commit objects), which is arguably a bug.  Okay.

Yes. If you would want, I could of course add test cases for two other
cases when we already errored out and now the error message is just
changed, but I don't think duplicating the error message strings from
the code to the testsuite is really wanted. :-)

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlFmmHwACgkQe81tAgORUJaTJACeKPui8+fZH+Nz3GIBFoCP5wjN
liMAoKdN00xdTFYRiMGlh2MsA/5GhZ7U
=JZsn
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
