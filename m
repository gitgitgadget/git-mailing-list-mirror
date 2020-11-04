Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37562C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94243221E2
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rz83auZU";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHdsInBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgKDO5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:57:22 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:46427 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730312AbgKDO5V (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Nov 2020 09:57:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8B91B2D5;
        Wed,  4 Nov 2020 09:57:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 04 Nov 2020 09:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Tk0rizpbOUHOTA97MH1n9+poayf
        wwaAiAMz2dg4QF6Y=; b=Rz83auZUv0r86iSB9QmVkn36Ghp14t45leH10h7DFqi
        cekBfsB1iPVOjMmi0W0j/d1FBsl7/29GBUAGKm1TZn+Vkp2sggxjqJaQcGjQhKfK
        ocT3DFrm7oXvcKqickqAN0TSBGhQDUy6Ms1Zm79CzWXl4AcenkU/1cAo827Q4NZ4
        hxi4wfsjA8MEZw3AFGq2nOwg1b6HtKCbVtn+Er8eKiP6uC0ePuu4iaRdmFGcrtkx
        UrXrHAlt7p2vfKtyfIYTnb+dCEFdeRRCFMvv5BCm0GSYSrYOq55wF88546R+UcG0
        b5Fpus3sBziN047TUPYtWqpQ61Kjz7z0Bj8VBPYJ9Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Tk0riz
        pbOUHOTA97MH1n9+poayfwwaAiAMz2dg4QF6Y=; b=BHdsInBahG5kI2rdnVG+W6
        pD01YQsUx4qitOt3kCuasBQvJQp9Og2A25pg+iGo6n5giRwfpMhzz0I35FIN6NA1
        4u6xNIplbpUA7cBlWH+ruT3vq+/TkERMRLKefym/SIqnJmqF5iKJRylJiUXZZaBD
        Bgzb5rmqIwB+ISHNjTxk5v3v4eDJFtZvK6M7k396zTTixF3K4EnKDZtdEi0tNUT3
        dz5elZ0KiZmsleR8iRs5HLjz04KkFouWPd3itxCxyN5DZ1CYdnkTw6YBAGcTfy+2
        4Qc8DJAmYY2wVsGUfOTkogFp/FxncwtwC+vIYtcuy44aWKGTCrLO896QAISOep4A
        ==
X-ME-Sender: <xms:UMGiX4EBsTvCAcqfuntWNHkSnPzQ4uN9-a90g9q6ZRrl_TMGcuQYlw>
    <xme:UMGiXxWmmfoJePlIzdYU8vFHsJdwGZdLw1lpq0VwwqrryUKdvFdBhBu28TMu3RUZF
    2XkiTo7jjF7j8yUcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudeluddrheegrdehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:UMGiXyLtXgfamqtylwuJCbaJMIEM7r7Znymk939J1gqGZW0CHcrVJA>
    <xmx:UMGiX6HvssjTZm_U8Itlpu5eJaPKbNtrV0e47yD0paVCiD9UbjxM4Q>
    <xmx:UMGiX-VxKvpVIiZyKmtMuP59wkTd71x11qa20YuathK69odvqk5GGg>
    <xmx:UMGiX5CmwjdsykCPW1E3slWOgcCBRNjIjaFVHJD_j89GHjJm_D3EUQ>
Received: from vm-mail.pks.im (x4dbf3605.dyn.telefonica.de [77.191.54.5])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9D0733280392;
        Wed,  4 Nov 2020 09:57:19 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 05d215c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Nov 2020 14:57:18 +0000 (UTC)
Date:   Wed, 4 Nov 2020 15:57:17 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 1/2] update-ref: Allow creation of multiple transactions
Message-ID: <eec7c2e8ec3e49b34066190d59fc45276bed637f.1604501265.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <cover.1604501265.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While git-update-ref has recently grown commands which allow interactive
control of transactions in e48cf33b61 (update-ref: implement interactive
transaction handling, 2020-04-02), it is not yet possible to create
multiple transactions in a single session. To do so, one currently still
needs to invoke the executable multiple times.

This commit addresses this shortcoming by allowing the "start" command
to create a new transaction if the current transaction has already been
either committed or aborted.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-update-ref.txt |  3 +-
 builtin/update-ref.c             | 13 ++++++++-
 t/t1400-update-ref.sh            | 50 ++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-re=
f.txt
index d401234b03..48b6683071 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -125,7 +125,8 @@ option::
 start::
 	Start a transaction. In contrast to a non-transactional session, a
 	transaction will automatically abort if the session ends without an
-	explicit commit.
+	explicit commit. This command may create a new empty transaction when
+	the current one has been committed or aborted already.
=20
 prepare::
 	Prepare to commit the transaction. This will create lock files for all
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 8a2df4459c..bb65129012 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -446,7 +446,18 @@ static void update_refs_stdin(void)
 			state =3D cmd->state;
 			break;
 		case UPDATE_REFS_CLOSED:
-			die("transaction is closed");
+			if (cmd->state !=3D UPDATE_REFS_STARTED)
+				die("transaction is closed");
+
+			/*
+			 * Open a new transaction if we're currently closed and
+			 * get a "start".
+			 */
+			state =3D cmd->state;
+			transaction =3D ref_transaction_begin(&err);
+			if (!transaction)
+				die("%s", err.buf);
+
 			break;
 		}
=20
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4c01e08551..72d995aece 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1526,4 +1526,54 @@ test_expect_success 'transaction with prepare aborts=
 by default' '
 	test_path_is_missing .git/$b
 '
=20
+test_expect_success 'transaction can commit multiple times' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/branch-1 $A
+	commit
+	start
+	create refs/heads/branch-2 $B
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start commit start commit >expect &&
+	test_cmp expect actual &&
+	echo "$A" >expect &&
+	git rev-parse refs/heads/branch-1 >actual &&
+	test_cmp expect actual &&
+	echo "$B" >expect &&
+	git rev-parse refs/heads/branch-2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction can create and delete' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/create-and-delete $A
+	commit
+	start
+	delete refs/heads/create-and-delete $A
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start commit start commit >expect &&
+	test_path_is_missing .git/refs/heads/create-and-delete
+'
+
+test_expect_success 'transaction can commit after abort' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/abort $A
+	abort
+	start
+	create refs/heads/abort $A
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start abort start commit >expect &&
+	echo "$A" >expect &&
+	git rev-parse refs/heads/abort >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.29.2


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+iwUwACgkQVbJhu7ck
PpQQjQ/+IKbcEDtltqmEcK3KtqWzMj6MB4fb2p2apkMiX5aqgSjunzUJmAj3HwRA
1bQFWV8oIblw4mm9kvdo3UdPa4m3a7X3zISXh9CiNlQTq+2m7+qhGwtUDVax528Q
ZpnQOWvrrWxnp0jbIUDSveMJnLWIsdb9F3zzwFkZvSziz/qSSVBo7nl8s8Eqx+zJ
or8ogeMt4aqxdauvZ6Jl84EZSs5dGIPssMDJOu1PXeXCt2WaKUvhVuJPcKkSrltk
tO+Z2lIxbwInHdpswwVyqT/Xe79NT8CERzZOtdJ3yy/hpcH2RHqwrLqHTwY7Y67h
TCu6rdapvARjrnIwnb4XyUSi0RKlZEkJgkQtDfxO6WIF588hwZlmZB53GgrS5djr
2FUbNAm78JsZuzi/h1dfBcR3DWpGZgwny/rfSffFuEoKhQkeyusmqDfXbhv02aVB
qeB/3sKcjW1jd6I+0AsjTVmeOdiAPT+7cTiLj6p/kjlC2539zmvCUK9d0zzjJUw/
H3W505Y+BDGnMbmf7ptj58zd1uOZFJvGfXaRSfhxlCesPO3NRppoyskziSiXpJhX
0mRLYUUbcKK58K3y1H8cjRRnZESAgl1yxYETnOC8nptjd3pxkKWsqhDbh6QLhp3M
TFWxDwFt4w0Q5ufyBLges0cPF0rwI1VaKlnI0radUPtXkDgixx0=
=Fb1f
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
