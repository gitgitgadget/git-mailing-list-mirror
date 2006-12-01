X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 13:28:54 +0100
Message-ID: <20061201122854.GR18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011102.17079.andyparkins@gmail.com> <20061201111027.GR12463MdfPADPa@greensroom.kotnet.org> <200612011212.35656.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4T94Hejb80K+e1gX"
NNTP-Posting-Date: Fri, 1 Dec 2006 12:29:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612011212.35656.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32912>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq7Vo-0006TD-9w for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967592AbWLAM24 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967611AbWLAM24
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:28:56 -0500
Received: from agent.admingilde.org ([213.95.21.5]:17331 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S967592AbWLAM24 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:28:56 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq7Ve-0005Ug-LQ; Fri, 01 Dec 2006 13:28:54 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--4T94Hejb80K+e1gX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 12:12:34PM +0000, Andy Parkins wrote:
> On Friday 2006 December 01 11:10, Sven Verdoolaege wrote:
>=20
> > You were proposing to create an extra object containing some random val=
ue
> > that is disconnected from the repo.
>=20
> Right, I think I've finally understood what Martin (and you) are
> proposing.  You want every commit in the submodule to be propagated up
> to the supermodule as well.  Okay.
>=20
> I don't think it's right, but at least I understand.

Please note that the submodule commits are not part of the supermodule
commit chain, they are part of the supermodule _tree_.

> It seems wrong because it's making commits in the supermodule that aren't=
=20
> commits to do with that project.

Of course they are part of your project, just like all the tree and blob
objects, too.

> In my libxcb example; why should every project use libxcb in have to
> store the entire history of libxcb?

Because you want to be able to use the submodule as a repository of its
own, too.  Be able to look at its history if you want to.
Be able to merge with new versions of the submodule.
This is what distiguishes a submodule from a pure file-based import of
another project.

> When examining the supermodule history, I won't care about how libxcb
> got to the state its in, and it's just noise in the supermodule
> history.  What if I use 10 submodules, the supermodule history won't
> show you anything useful - it's just unrelated submodule commits.

Again: the submodules are part of your supermodule _tree_, not it's
commit chain.  So you won't see the submodule commits when you invoke
git-log in the supermodule.

> It gets worse, this is why I was asking for more detail: this commit
> that you're storing in the supermodule.  It's the same commit as is in
> the submodule?

It is _the_ commit from the submodule, yes.

> What would the parent commit of that commit be?  It has to be the same
> in both, because the commit-hash forces it to be.

It is the commit of the submodule, so its parents point to the submodule
history.

> > > Is that commit in the submodule or the supermodule?
> >
> > It's in BOTH.  That's why it's a *sub*module.
>=20
> If it's in BOTH then the supermodule is a normal git repository.  You are=
n't=20
> tracking the submodule, you're just including it en masse.

The submodule is part of the entire project, so yes, it is included.
And the supermodule tracks submodule development by storing references
to the submodule history that was used at that time.


Lets try to paint a little diagram:


belongint to:
/--------- supermodule -------\    /---- submodule -------\

commit -> tree +-> blob
  |            +-> tree -> ...
  |            +-----------------> commit -> tree -> ...
  v                                  |
commit -> tree +-> ...               v
  |            +-----------------> commit -> ...
  |                                  |
  |                                  v
  |                                commit -> ...
  v                                  |
commit -> tree +-> ...               v
               +-----------------> commit


Both have their independent history, but they are linked as some
submodule versions are part of the supermodule tree.

--=20
Martin Waitz

--4T94Hejb80K+e1gX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcCAGj/Eaxd/oD7IRAhc8AJ0U/3Ldn2lXvM1P90m6pxMTtbeQNwCeKv2o
1wgHB8Slo0R7okKUsr+YsLg=
=7owK
-----END PGP SIGNATURE-----

