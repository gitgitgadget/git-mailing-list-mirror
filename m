X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Wed, 29 Nov 2006 17:03:56 +0100
Message-ID: <20061129160355.GF18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281029.11918.andyparkins@gmail.com> <ekh45n$rfc$1@sea.gmane.org> <200611281335.38728.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
NNTP-Posting-Date: Wed, 29 Nov 2006 16:04:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611281335.38728.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32647>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpRuj-0000VW-TV for gcvg-git@gmane.org; Wed, 29 Nov
 2006 17:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967454AbWK2QD6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 11:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935845AbWK2QD6
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 11:03:58 -0500
Received: from agent.admingilde.org ([213.95.21.5]:29909 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S935844AbWK2QD5 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 11:03:57 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GpRue-0005ZQ-5H; Wed, 29 Nov 2006 17:03:56 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Nov 28, 2006 at 01:35:37PM +0000, Andy Parkins wrote:
> The reason I thought it would have to be HEAD at all times, is to prevent=
=20
> situations where the supermodule commit doesn't reflect the state of the=
=20
> current tree.

The way I wanted to address this is to show in the supermodule
git-status that the submodule is using another branch.
That way you are warned and can decide not to commit the supermodule.

I implemented tracking of refs/heads/master (not HEAD) without much
thinking, and only recently began to think about possible problems with
this approach.

But I think it is an important design decision to take, so I'd like to
have consensus here.

Pro HEAD:
 - update-index on submodule really updates the supermodule index with
   a commit that resembles the working directory.
Contra HEAD:
 - HEAD is not garanteed to be equal to the working directory anyway,
   you may have uncommitted changes.
 - when updating the supermodule, you have to take care that your
   submodules are on the right branch.
   You might for example have some testing-throwawy branch in one
   submodule and don't want to merge it with other changes yet.

Pro refs/heads/master:
 - the supermodule really tracks one defined branch of development.
 - you can easily overwrite one submodule by changing to another branch,
   without fearing that changes in the supermodule change anything
   there.
Contra refs/heads/master:
 - after updating the supermodule, you may not have the correct working
   directory checked out everywhere, because some submodules may be on a
   different branch.
 - there is one branch in the submodule which is special to all the other.

I think that most of the disadvantages of refs/heads/master can be
solved by printing the above-mentioned warning in git-status when the
submodule is using another branch (similiar to the
planned-but-not-implemented warn if the submodule has uncommited
changes).

I don't yet know how to cope with tracking HEAD directly, so I'm still
in favor of tracking refs/heads/master, as already implemented.

--=20
Martin Waitz

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFba9rj/Eaxd/oD7IRAo9GAJ9hk+C7Edtgk3oPPJSieWI2xxhFCACggXkS
UgoD/4dz26y+3LV00BpxwPk=
=95zp
-----END PGP SIGNATURE-----

