X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 19:48:02 +0100
Message-ID: <20061201184801.GG18810@admingilde.org>
References: <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703375.4050500@b-i-t.de> <20061201145817.GY18810@admingilde.org> <45704EA3.40203@b-i-t.de> <20061201165418.GD18810@admingilde.org> <45706758.2020907@b-i-t.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yRy5AYMdKszmZQyZ"
NNTP-Posting-Date: Fri, 1 Dec 2006 18:48:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45706758.2020907@b-i-t.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32955>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqDQf-0007qm-ID for gcvg-git@gmane.org; Fri, 01 Dec
 2006 19:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031663AbWLASsG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 13:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031684AbWLASsF
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 13:48:05 -0500
Received: from agent.admingilde.org ([213.95.21.5]:17111 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031663AbWLASsD
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 13:48:03 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqDQY-0000PM-6g; Fri, 01 Dec 2006 19:48:02 +0100
To: Stephan Feder <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org


--yRy5AYMdKszmZQyZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2006 at 06:33:12PM +0100, Stephan Feder wrote:
> We are in agreement about two fundamental parts of the implementation=20
> and their meaning:
>=20
> 1. A submodule is stored as a commit id in a tree object.
>=20
> 2. Every object that is reachable from the submodule's commit are=20
> reachable from the supermodule's repository.

Correct.

> >>For example, git has the subproject xdiff. If git had been able to work=
=20
> >>with subprojects as I envision, and if xdiff had been published as a gi=
t=20
> >>repository (not necessarily subproject enabled), it could have been=20
> >>pulled in git's subdirectory xdiff as a subproject.
> >
> >This could have been done if submodule support would have been available
> >at the time xdiff was introduced, yes.
> >
> >>There would not have been a separate branch or even repository for
> >>xdiff in the git repository.
> >
> >What separate branch or repository are you talking about?
>=20
> That's it: There is no need for a separate branch or repository. If you=
=20
> have the subproject's commit in the superproject's object database (and=
=20
> we really have that, see 1. and 2. above), why do you _have to_ store it=
=20
> elsewhere?

Let's see if I understand you correctly:

You don't want to create an additional .git directory for the submodule
and just handle everything with one toplevel .git repository for the
whole project.
Without the .git directory, you of course do not have refs/heads inside
the submodule.

So this is a different user-interface approach to submodules when
compared to my approach.  But the basis is the same and both could
inter-operate.

Now your submodule is no longer seen as an independent git repository
and I think this would cause problems when you want to push/pull between
the submodule and its upstream repository.
No technical problems, but UI-problems because now your submodule is
handled completly different to a "normal" repository.


> >Yes, but if it would have been integrated as a submodule it obviously
> >would have been committed to the xdiff submodule inside the git
> >repository.
>=20
> No. The xdiff submodule would only exist as part of the git repository.=
=20

But you could still call the "xdiff" part of the git repository a
submodule.  And then changes to the xdiff directory result in a new
submodule commit, even when there is no direct reference to it.
So you'd still "commit to the xdiff submodule".

> You could, f.e., access the xdiff commit in git HEAD as HEAD:xdiff//=20
> (again my proposed syntax). HEAD:xdiff//~2:xemit.c would give you the=20
> grandparent of xemit.c in the xdiff submodule.

git-cat-file commit HEAD:xdiff already works out of the box (even
cat-file tree to get the submodule tree).  But up to now revision
parsing follows the file name only once.

What about just separating things with "/"?

commit HEAD
tree   HEAD/
blob   HEAD/Makefile
commit HEAD/xdiff
tree   HEAD/xdiff/
blob   HEAD/xdiff~2/xemit.c

this may add some confusion when used with hierarchical branches, but
it's still unique:

	refs/heads/master/xdiff/xemit.c

Just use as many path components until a matching reference is found,
then start peeling.
Or just use / between super and submodule:

	refs/heads/master:xdiff/xemit.c

I think this is easier to read then

	refs/heads/master:xdiff//:xemit.c


> If you mean the submodule repository created by init-module I=20
> understand. But why create this "helper repository at all"?

Because it helps "normal" git operations ;-)

--=20
Martin Waitz

--yRy5AYMdKszmZQyZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcHjhj/Eaxd/oD7IRAgb7AJwP+SFMUG9H8mpM6rsbKtNgiEz2jgCfRvxw
9zP65bdwjLyoZkXNcVYp9ns=
=az8n
-----END PGP SIGNATURE-----

