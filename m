Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A77C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F152E20786
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ltanyz0b";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMeAMqAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKKHFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:05:39 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41145 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgKKHFf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Nov 2020 02:05:35 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5FA2E5C045A;
        Wed, 11 Nov 2020 02:05:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Nov 2020 02:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=0kTLwf2zRxPwGcJ9GArcUWWpQI6
        c2Yc4/DXFlcdzo5Q=; b=Ltanyz0b/5sKX3BdNrVp1Kr8dQP9Jfd39/HDDfvFH1K
        CvAmSJkr9DQ/7Ae3PjR2i0mNTrgAckQSxbSTHvmB2LVVaXn8Zk3VXqbQ6mSXB0mW
        n0h9MUFudLZd5wDCKghgfrUdEnIqAD0Cea+qHmCQMyIvrbvG8oJIQt0VnMEY2k6y
        0xBIUgzxIPmniMNnRXHQ3c3sMzDweoO7gQ9mfnnp6QURLxr/7DzRcycGe/dDvLVP
        7Bz14OvO/TAc6uA0cHrFOHGXHmpbz0Ab1m5hoWstRXEBpTHwHJ3sEx9gU9yBCxDo
        6bgC71YVhJt1NRMWAyxqlOas8UQ4FIS3kR9pRtqa8Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0kTLwf
        2zRxPwGcJ9GArcUWWpQI6c2Yc4/DXFlcdzo5Q=; b=UMeAMqAGo/+aM/6WEFyQXy
        O4zql8wN/4riCN7SsKsbSLZOez96ckf5gBKSo9aCMbGlXcudnQfQnzSz/EpDv69U
        DUO0hsRAfF58beGCvGPaj3yIbPRWcvi/hFtnaqfTzGfHRIMicrq5Wqs2g72B9ZcI
        3XZt6cnikBp6Z6MNwrmTzSwpc3eDS8+0GmHoTuwcnMUpimydtpeSikBIjrBbPqBm
        i8hQ2RgboSKoUYcIOgSpIyjW0R+A5sHUaVS5boAvpfUR/fkWRnPxcb20S085y89u
        H6bCKxwBFweZrkR4SGXXQomlRIAfg6KPH3XGFfVMKVOjkaM6u4DEjcndLBtwC2vg
        ==
X-ME-Sender: <xms:Po2rXxgJXN8JBns0aS2VIYzDGXBEgF01UqgT9zmw2RoGX6AnGrjB_g>
    <xme:Po2rX2CLcUSysWmc8fgHeMosMhQyHehzIc3CWvRMoGlejMq2nRl0vc4cNuPAHOd3T
    Q_WwbSSj4-6PtiW9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledrudegrdeivddrkeeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:Po2rXxHwcNv3xkF9Yk1WplXAl89vzOkCUW_mJfrhPGA14XYW3Qy-Gw>
    <xmx:Po2rX2TpVDljY9iHnpZSAfPZOKZ5COIC9IPgl27LBR6BeaebyZZIkw>
    <xmx:Po2rX-z7Ss-nPEtAJDXRU0BAI1L78-hqKuFM5bnd_YiBWXW7Vp-zzQ>
    <xmx:Po2rX0aea9hwd0VCMCOi3y-JqooOrI5TsA6cC9fNPOy0RpV82KfSDg>
Received: from vm-mail.pks.im (dynamic-089-014-062-088.89.14.pool.telefonica.de [89.14.62.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id ABCA6328005D;
        Wed, 11 Nov 2020 02:05:33 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6158c34d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 11 Nov 2020 06:58:52 +0000 (UTC)
Date:   Wed, 11 Nov 2020 07:58:53 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 4/4] update-ref: disallow "start" for ongoing transactions
Message-ID: <bacb8960b01b1de53b0060f2582da2b63aeda350.1605077740.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605077740.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CBruwtHZbEbVuwMp"
Content-Disposition: inline
In-Reply-To: <cover.1605077740.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CBruwtHZbEbVuwMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is currently possible to write multiple "start" commands into
git-update-ref(1) for a single session, but none of them except for the
first one actually have any effect.

Using such nested "start"s may eventually have a sensible effect. One
may imagine that it restarts the current transaction, effectively
emptying it and creating a new one. It may also allow for creation of
nested transactions. But currently, none of these are implemented.

Silently ignoring this misuse is making it hard to iterate in the future
if "start" is ever going to have meaningful semantics in such a context.
This commit thus makes sure to error out in case we see such use.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c  |  2 ++
 t/t1400-update-ref.sh | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index bb65129012..6029a80544 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -436,6 +436,8 @@ static void update_refs_stdin(void)
 		switch (state) {
 		case UPDATE_REFS_OPEN:
 		case UPDATE_REFS_STARTED:
+			if (state =3D=3D UPDATE_REFS_STARTED && cmd->state =3D=3D UPDATE_REFS_S=
TARTED)
+				die("cannot restart ongoing transaction");
 			/* Do not downgrade a transaction to a non-transaction. */
 			if (cmd->state >=3D state)
 				state =3D cmd->state;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 2890504edd..e109097970 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1582,4 +1582,15 @@ test_expect_success 'transaction can commit after ab=
ort' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'transaction cannot restart ongoing transaction' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/restart $A
+	start
+	commit
+	EOF
+	test_must_fail git update-ref --stdin <stdin >actual &&
+	test_must_fail git show-ref --verify refs/heads/restart
+'
+
 test_done
--=20
2.29.2


--CBruwtHZbEbVuwMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+ri6wACgkQVbJhu7ck
PpTbUw//b4BUc2v08rbBHYLN3UagEq9fdlnuKdJeKGVDTdt8YNXlpk3e4gWvfICg
TwBB6XBXSZRGsmCMqBvJe17adQVZY+W5wKeHCEiFcFXyAWBLBwZCmDqbOjjw+T3w
HecnCOvy3CET/YvnIsoIgLqtMppcoey1H/9jHqHZNx3+UwtDD1wQ8VI+JWcm+9a9
nni5YK7zAGqNH4TRvhBxL2w2zDwVoC/tURcTydwuFaQ4ux2FTdGWbI8NJJOLhUoM
fq1C/yM3V9OIfAtbIVjP23NZ+udCq/Io/z84twkXavfCNHmMZ/X7VrG1bYUk2Cst
U5jih6nnAAt9kvdSmzKP5fqC9XPbXvzzJPqS3IZy2PwSbQOlOB96Q8YmKiTU4o3N
MveJcxeuwteJqKlNhar+3S5KPZhUwK/TaUqJLS8xdmRCAf7JLT/y7QRlPpQxUMDb
G1w0RqLiCBaGzJjWKty4u5BW5REOGBeoO0Aiizgl0hbaSAcBo6CTX8WbLs9gmLKx
mDLrdmKFQPjmENji74hUv8IplAc2NE59xLZrrj/VPDblDqvtjEn0PZFhKODXw5k4
AMe/FW+TE/ltsketqH4BgngWOmWGDqJ43UIMnCNXc7b/31J5g3O4VrMB0L06O8s8
74DaEbMh3H09dDx7yq3QxJXgT0HuISkmzJX2sPD5mGK+JqipKXc=
=jNd6
-----END PGP SIGNATURE-----

--CBruwtHZbEbVuwMp--
