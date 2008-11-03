From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and  --prune-empty.
Date: Mon, 03 Nov 2008 10:27:29 +0100
Message-ID: <20081103092729.GE13930@artemis.corp>
References: <20081030132623.GC24098@artemis.corp> <1225445204-28000-1-git-send-email-madcoder@debian.org> <7viqr5wgl7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="BZaMRJmqxGScZ8Mx";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, pasky@suse.cz, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 10:28:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwvjq-0001la-7x
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbYKCJ1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbYKCJ1c
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:27:32 -0500
Received: from pan.madism.org ([88.191.52.104]:36172 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659AbYKCJ1b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 04:27:31 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AF4983B2B0;
	Mon,  3 Nov 2008 10:27:30 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8A63155AC1C; Mon,  3 Nov 2008 10:27:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7viqr5wgl7.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99918>


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2008 at 04:58:44AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > +case "$prune_empty,$filter_commit" in
> > +',')
> > +	filter_commit=3D'git commit-tree "$@"';;
> > +'t,')
> > +	filter_commit=3D"$functions;"' git_commit_non_empty_tree "$@"';;
> > +','*)
> > +	;;
> > +*)
> > +	die "Cannot set --prune-empty and --filter-commit at the same time"
> > +esac
>=20
> This is only style issue, but I find the above extremely difficult to
> read.  If it were either:
>=20
> 	case ... in
>         ,) do "neither set case" ;;
>         t,) do "prune but not filter case" ;;
>         *) do "both set case" ;;
>         esac
>=20
> or (rather amateurish but conveys what it wants to do more clearly):
>        =20
> 	case ... in
>         '','') do "neither set case" ;;
>         t,'') do "prune but not filter case" ;;
>         t,t) do "both set case" ;;
>         esac
>=20
> I wouldn't have to wonder which sq pairs with which one.

agreed.

> > diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> > index b0a9d7d..352b56b 100755
> > --- a/t/t7003-filter-branch.sh
> > +++ b/t/t7003-filter-branch.sh
> > @@ -262,4 +262,12 @@ test_expect_success 'Tag name filtering allows sla=
shes in tag names' '
> >  	test_cmp expect actual
> >  '
> > =20
> > +test_expect_success 'Prune empty commits' '
> > +	make_commit to_remove &&
> > +	(git rev-list HEAD | grep -v $(git rev-parse HEAD)) > expect &&
>=20
> I am not sure what this one is doing.
>=20
>  - Isn't this the same as "git rev-list HEAD^"?
>  - Do you need a subshell?

The filter-branch is supposed to prune the last commit done (current
HEAD) from the revision list. So I build the rev-list we're supposed to
have in the end, and remove the matching ref from it. I don't see how to
avoid the subshell though, but if someone knows better please do :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkOxAEACgkQvGr7W6HudhytYQCdGrm2AnzayL5NtuRtfxv+vU19
Gn0AoJEuUBsr1COHkPSsSDwWaCua3Y5R
=IQxm
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
