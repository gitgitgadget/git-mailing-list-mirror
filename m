Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C2CC2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 07:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F4822370
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 07:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DpSfvLLt";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obhAKu/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770961AbgJZHnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 03:43:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52899 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1770958AbgJZHnJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Oct 2020 03:43:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A4A905C00CF;
        Mon, 26 Oct 2020 03:43:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 26 Oct 2020 03:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=C/IyLtnD8KpNvRJ4E8jxxDdTWgS
        1WSMlziQ++qQjj0U=; b=DpSfvLLtLO8gFS6GGICyKlCVzvQoJNax/6FkCi8XjRU
        qVx8qdUOh4qdqdVyW3YisLwLqhx6yCrKqQPhBp1xx+lKD4LTOEEI+ox0tuClVQEh
        p60bZGKxY24GKBnyh/H8IzbgyR2LV4byToNBrltxDbAFPGEUNF5a3qbuFouY6cmd
        81HFxbtsbGw4oVfmnV+xEYolr8pFlFcHsV07OW90chq9iJ++t7XALtw9PZymG10l
        V4hFJ/s9GGjJtqgmFV9Uk5d+DNJXDyla9r3rkjCr9RQjuomOjvgcKL35xlFufIq+
        jSV50bk+gDkU/sYxUDp/ZoBDjDP6BISdBxJ4/fKpr2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=C/IyLt
        nD8KpNvRJ4E8jxxDdTWgS1WSMlziQ++qQjj0U=; b=obhAKu/74nZXBxsCfGGJZI
        f2W90FBf3JICL+RgR4DHWTl5TQ9vCK+/Y6bF55ueeme3t7rMleB6ApyeqO6f2aOF
        xShiOu/I6vfEKlvSdLNBsAfX1dyEcAj9zGuDXQVImANwoINxgKrD/n+jVfoTBaUG
        CpHCLSOBJLIUJkh0aXb+uNb4Ym4giqcN5C3tSgdYZ2pYVs/r1YjVObOEcZUmHvaw
        wuIKTvbqKpq+5vToiyqhml2pcyFgBtCchYPB3rq1cqYdM6mQPcq7Vt/Zet4+lujc
        uEwV8UjZGM2pSWpIBRaw2NZw/u+O4kTKIpML16SIrkmqMXkITFEyj0N8YW+q2ctg
        ==
X-ME-Sender: <xms:C36WX9q1NrH6UDNSM97f_29DKcjdyTV65Cl6bENwhN8Tn8fNZ9TFUw>
    <xme:C36WX_plm5TNg57k0z6884BFa59bo32Nk2p9S6A7H_3I8z2sz_QI3dFypy18z-44j
    3wYI_LIjCvcs9oS1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledruddvrdeggedrvdegleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:C36WX6NfoanZEJEXJi0AlDYfi9UaZxesusPNKkcZLoS_85CZxLC9LQ>
    <xmx:C36WX46Wyf4yLENoH2-AlABqAeM6Lk-WybKdp87KnUC6M66P2OlI4Q>
    <xmx:C36WX85yRMRmcyPpS3tVumqitvODEuajvdEARotLx04mX9sQgwx5Nw>
    <xmx:C36WX8HLsRZapUcO2HQVev5gx0VIQ1bZTX6U57Vzkf1wzIN9Rf-UDg>
Received: from vm-mail.pks.im (dynamic-089-012-044-249.89.12.pool.telefonica.de [89.12.44.249])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70C543064685;
        Mon, 26 Oct 2020 03:43:06 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 63e2bbdb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Oct 2020 07:43:04 +0000 (UTC)
Date:   Mon, 26 Oct 2020 08:43:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] refs: implement reference transaction hook
Message-ID: <20201026074303.GA972@ncase>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
 <20201023010315.GA1542721@coredump.intra.peff.net>
 <xmqqpn59k2xw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <xmqqpn59k2xw.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2020 at 08:59:23PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > So I wonder if:
> >
> > diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction=
-hooks.sh
> > index f6e741c6c0..8155522a1a 100755
> > --- a/t/t1416-ref-transaction-hooks.sh
> > +++ b/t/t1416-ref-transaction-hooks.sh
> > @@ -9,6 +9,7 @@ test_expect_success setup '
> >  	test_commit PRE &&
> >  	PRE_OID=3D$(git rev-parse PRE) &&
> >  	test_commit POST &&
> > +	PRE_OID=3D$(git rev-parse PRE) &&
> >  	POST_OID=3D$(git rev-parse POST)
> >  '
> > =20
> > @@ -52,10 +53,10 @@ test_expect_success 'hook gets all queued updates i=
n prepared state' '
> >  		fi
> >  	EOF
> >  	cat >expect <<-EOF &&
> > -		$ZERO_OID $POST_OID HEAD
> > -		$ZERO_OID $POST_OID refs/heads/master
> > +		$PRE_OID $POST_OID HEAD
> > +		$PRE_OID $POST_OID refs/heads/master
> >  	EOF
> > -	git update-ref HEAD POST <<-EOF &&
> > +	git update-ref HEAD POST POST <<-EOF &&
> >  		update HEAD $ZERO_OID $POST_OID
> >  		update refs/heads/master $ZERO_OID $POST_OID
> >  	EOF
> > @@ -75,10 +76,10 @@ test_expect_success 'hook gets all queued updates i=
n committed state' '
> >  		fi
> >  	EOF
> >  	cat >expect <<-EOF &&
> > -		$ZERO_OID $POST_OID HEAD
> > -		$ZERO_OID $POST_OID refs/heads/master
> > +		$PRE_OID $POST_OID HEAD
> > +		$PRE_OID $POST_OID refs/heads/master
> >  	EOF
> > -	git update-ref HEAD POST &&
> > +	git update-ref HEAD POST PRE &&
> >  	test_cmp expect actual
> >  '
>=20
> I think that makes a lot of sense.  In addition,=20
>=20
> > ...  But we'd possibly want to actually change the behavior
> > to always send the actual ref value to the hook.
>=20
> I offhand do not see a reason why we shouldn't do that.
>=20
> Thanks for carefully thinking things through.

Thanks for having a look! I agree, changing this seems sensible to me.
In the end, the intention of the hook is to have a single script which
is able to verify all reference updates, no matter where they come from.
And behaving differently based on whether the user passed the zero OID
or not doesn't seem useful to me in that context.

We should also a better job than I did and describe what the old OID
actually is in the documentation.

@Taylor, given that you've already dug into the code: do you already
have plans to post a patch for this?

Patrick

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+WfgYACgkQVbJhu7ck
PpRuYRAAlI3Rk5hFgKzmGUgOeCulk4UTkr4YtrB5jQisUBoi4qg192BZ/DmsBxTv
5kXdtsVSAHFjy2uMsMP/0qoi7imWWYhCBTGcuXftJ8PWhn2v94gYcq5abybZCY0x
3uccTLj5rcP916Egp6MgSgfMRGcsREtd81/hfLhs6qoSAaQgG/nysn7c/agRl7Va
w4BfV9QD7ZrnoKK6zIstbmfrD+TlRrnpRc8T/UZfiMDsKm1RM6rWCG6Nck65HmKz
GAoLm6zNIfn7fZlGvIOnjmxs4sSNY/nvg+/EwQbHqz1rCUfoN6n8zNd+wf5A3pEt
4DA6Eex+2HUd9xVU7YEpTQNBrMYA0uHRtprxgwFXoqqW4IjDDGb/4WE2pvAGZIJ3
YBpHnEaUiynWU8nHn02wtCg4Cx/4D1aLnzkePCgdrHdPhTi1GL1nWs3RH4azqwos
rOfSKW1aV0bBgeBi9pXRhPpKtE3kq3Vl9gr0PoCTpa3As2LcINusVDCmNY/4m+Bk
FNzFwkGjIrShMIUISkBvNG3QH7VAtwgT8KY+RbDFhbhrAzLMFU4/QvFH/Twhb5fp
+PzhGx2XessfNy+2TzGsrvnYTj8bNNlwFErEi2sb/G/2qIIDKPQQNC+zzE0BrndX
t1qSaWbjXEvbm9LnsQdCj0cCkisFWGxNPKEM5Tq9xhIxnqZ+K/U=
=ao5q
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
