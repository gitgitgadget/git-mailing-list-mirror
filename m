Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1BBC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 16:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A545A206E9
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SaxBYY2q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KhRM6y9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgDCQvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:51:09 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36285 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728095AbgDCQvJ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Apr 2020 12:51:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C3C535C03AA;
        Fri,  3 Apr 2020 12:51:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 03 Apr 2020 12:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wvarfmCi/BrcRqPsHEQZGWSVxTY
        d00T+W96ovhaZD88=; b=SaxBYY2qBmGEvRJBBp65kSkrr7RcuHDaOpIxQ1pXBKh
        65jiv4ASL0IEz5xrhDhFkHkP2R7myVGQiZdOCYIaIc9qYU3RpcuM67w8NI5okl0K
        GkKf6CXkLiaoBaVTeA+P698CURQrY9ttfyUKugbryWOWeaCKMeujgS1mWFALUkV/
        EYNXpJxheo53QHVZCw3JtPAascZ5ZG9Q9RrZKd2KGj2w7xs16JMYKxjBZEVlODq9
        +VFqq3n7qebzBEsCLsXvBRtePePKL8T/huSYyZ8hXtNPxOLD+nP1dg06+JIG0L4L
        Fust+R6rUB3RM3az3a8YOT7fRycTKKfU4Sf5TaFGzCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wvarfm
        Ci/BrcRqPsHEQZGWSVxTYd00T+W96ovhaZD88=; b=KhRM6y9t7WYWrJOK5FTnhZ
        ylDHAxHBH4Ikd1MEpJxd7om2pEwCHb1534Oa2YjP9RzzjaZSP1W9ANh8WAP2f41P
        93aYYOvvGoS45X9imyg84lOankXs/9WEm7yUnmhEWlSLY/HD8VYaMF3BxylNHtD3
        oIoXTu9DXNN1cDA42CzpnBPu4zYnmr/5NZ6IPDwsUShV7JV57nYqRQZV4I3JIOzR
        b3ThDHSp9WJy5hIjFgohxdVA3b01Bg0QnvWLT3dP2RLsv54vRA3A2yJs5PeBbFDp
        UZoUOZtWsPe7647ctWXxqczMIoOePqAouMR8LGQLyaIgr4EmvfWEdh8OC6mrgkHg
        ==
X-ME-Sender: <xms:emmHXokQkwnIzrj9MIXY8sfRlBLQAAZodRQHWNu2Nx-_upWQbORCeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdeigddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddufe
    drvddugedrudegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:e2mHXjPgjfs6es_kGnk0eiGGxxNrQVkgJcUfu1lv70nDz_yOO7LCAQ>
    <xmx:e2mHXqH5hxsFWmQC-9hqusZuc8bR79qFFvlrWqDq-6pGHyjfZyfr0A>
    <xmx:e2mHXgWfKcMRzV0lCQIxiZoAiFaWRBab6wV9GiqKDBQYd661X5dWGg>
    <xmx:e2mHXgv0YVS9HlbcZhoNT7NIXHYShmy_JWqpARqUJWPbiHRjc_hlFg>
Received: from vm-mail.pks.im (x4d0dd68d.dyn.telefonica.de [77.13.214.141])
        by mail.messagingengine.com (Postfix) with ESMTPA id 62DAB328005E;
        Fri,  3 Apr 2020 12:51:06 -0400 (EDT)
Received: from localhost (xps [10.192.0.12])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b53c8718 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 3 Apr 2020 16:51:02 +0000 (UTC)
Date:   Fri, 3 Apr 2020 18:51:52 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     phillip.wood@dunelm.org.uk
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 9/9] update-ref: implement interactive transaction
 handling
Message-ID: <20200403165152.GA4244@xps.pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
 <5670bea2b15bafbd93d7d507b35e54980ad06fb9.1585811014.git.ps@pks.im>
 <fd4b874a-478f-2139-e910-c000b8a1f396@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <fd4b874a-478f-2139-e910-c000b8a1f396@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 02:40:26PM +0100, Phillip Wood wrote:
> Hi Patrick
>=20
> On 02/04/2020 08:10, Patrick Steinhardt wrote:
> > The git-update-ref(1) command can only handle queueing transactions
> > right now via its "--stdin" parameter, but there is no way for users to
> > handle the transaction itself in a more explicit way. E.g. in a
> > replicated scenario, one may imagine a coordinator that spawns
> > git-update-ref(1) for multiple repositories and only if all agree that
> > an update is possible will the coordinator send a commit. Such a
> > transactional session could look like
> >=20
> >      > start
> >      < start: ok
> >      > update refs/heads/master $OLD $NEW
> >      > prepare
> >      < prepare: ok
> >      # All nodes have returned "ok"
> >      > commit
> >      < commit: ok
> >=20
> > or
> >=20
> >      > start
> >      < start: ok
> >      > create refs/heads/master $OLD $NEW
> >      > prepare
> >      < fatal: cannot lock ref 'refs/heads/master': reference already ex=
ists
> >      # On all other nodes:
> >      > abort
> >      < abort: ok
> >=20
> > In order to allow for such transactional sessions, this commit
> > introduces four new commands for git-update-ref(1), which matches those
> > we have internally already with the exception of "start":
> >=20
> >      - start: start a new transaction
> >=20
> >      - prepare: prepare the transaction, that is try to lock all
> >                 references and verify their current value matches the
> >                 expected one
> >=20
> >      - commit: explicitly commit a session, that is update references to
> >                match their new expected state
> >=20
> >      - abort: abort a session and roll back all changes
> >=20
> > By design, git-update-ref(1) will commit as soon as standard input is
> > being closed. While fine in a non-transactional world, it is definitely
> > unexpected in a transactional world. Because of this, as soon as any of
> > the new transactional commands is used, the default will change to
> > aborting without an explicit "commit". To avoid a race between queueing
> > updates and the first "prepare" that starts a transaction, the "start"
> > command has been added to start an explicit transaction.
> >=20
> > Add some tests to exercise this new functionality.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >   Documentation/git-update-ref.txt |  26 ++++++
> >   builtin/update-ref.c             | 106 +++++++++++++++++++++++--
> >   t/t1400-update-ref.sh            | 131 +++++++++++++++++++++++++++++++
> >   3 files changed, 255 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/Documentation/git-update-ref.txt b/Documentation/git-updat=
e-ref.txt
> > index 9bd039ce08..3e737c2360 100644
> > --- a/Documentation/git-update-ref.txt
> > +++ b/Documentation/git-update-ref.txt
> > @@ -66,6 +66,10 @@ performs all modifications together.  Specify comman=
ds of the form:
> >   	delete SP <ref> [SP <oldvalue>] LF
> >   	verify SP <ref> [SP <oldvalue>] LF
> >   	option SP <opt> LF
> > +	start LF
> > +	prepare LF
> > +	commit LF
> > +	abort LF
> >  =20
> >   With `--create-reflog`, update-ref will create a reflog for each ref
> >   even if one would not ordinarily be created.
> > @@ -83,6 +87,10 @@ quoting:
> >   	delete SP <ref> NUL [<oldvalue>] NUL
> >   	verify SP <ref> NUL [<oldvalue>] NUL
> >   	option SP <opt> NUL
> > +	start NUL
> > +	prepare NUL
> > +	commit NUL
> > +	abort NUL
> >  =20
> >   In this format, use 40 "0" to specify a zero value, and use the empty
> >   string to specify a missing value.
> > @@ -114,6 +122,24 @@ option::
> >   	The only valid option is `no-deref` to avoid dereferencing
> >   	a symbolic ref.
> >  =20
> > +start::
> > +	Start a transaction. In contrast to a non-transactional session,=20
>=20
> I found the talk of "non-transactional" sessions a bit confusing because=
=20
> the normal --stdin does update all the refs it is given as a single=20
> transaction, so that if it cannot update one ref none of them are=20
> updated. If I've understood correctly these changes are about=20
> coordinating transactions across several repositories. I'm not sure how=
=20
> best to convey that in the man page - perhaps we could call them single=
=20
> repository transactions and multi repository transaction or something.

The ultimate goal is to be able to create something that sits atop a set
of repos that's able to coordinate multiple reference transactions at
the same time and then do an all or nothing commit across all repos or
abort in case any of the repos will not be able to perform the update.
The proposed change is still about a single repository, only, and have
the aim of actually enabling transaction semantics in the first place.
Until now, it's only possible to start a transaction via
git-update-refs(1), but you can't really control it except for the fnial
commit.

So with that being said I'm not quite sure whether it makes sense to
document the potential for handling transactions across multiple repos.
It does show that I could improve the documentation, though, and make
the intent and scope clearer. I'll try to do that for the next version,
thanks for your feedback!

Patrick

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6HaacACgkQVbJhu7ck
PpT39hAAixahg2c+LxSV4ae6HF/UcGCLvfk5aavvk8FhaLcgf6dCdQs+t1gZ0fFB
MyCrfNvg4YYuMK4u2FyUnXTtOBZ8HkL0GjqIdQeRjmehUJ35tY+FqoKq20OeyZLr
sgyLPMxlGe3hfXkbPOV/yX/H0BARYpiYk8AI4oKPhGNTiPApW6+cvcX/R7zpvdIk
1vnLm4uuntIQybtZkd2+vASdV+qWtrxH1YSrTtD5wQBuUOwg/Lz67ZSsjb9+DJ9h
00BCwgQ+OQiJ7MBSoPENbP72fD7AXQu+7aX2i0zdkpLWunbPGah9iuTaTfywJpi8
34pHNGUNs3xHMJe8GhpYlvGb3IZjSMR0X91kQksqOTj1LCWCe4DLMgx7+6G4ojkT
xXschdEF7AdIhcx1UYyZNvhLsd/iUFjjT7uQW36dJI9KC0Bc+qRPoOwyamcoCGR7
41HeX0UlqKuU8Zm/3zf/gscY0lVhC4AgGYbqAvuDX99vGE8bRm2vljJErgudhLPh
SEkIArVasLbHoZLCGaMr1KIb0iqyChIkVxLIC4UjJVcbTIT7rCEwCQn/nCOSQDAz
SuQ/i91RKu3SAjaKrVuLJOybU8ZxEeAAx9euvZ0ZBUxMNK4lkwC2bYzoYnV6QM/3
tRqVadHmQA65hk0jinWx+SXDNV2znneNpjN+/qYKuGhHNpRQEKw=
=Pmxq
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
