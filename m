Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB1BC4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F13E20663
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qvuLKvtP";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TSvsMgsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgKIKHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:07:05 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53591 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728108AbgKIKHE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Nov 2020 05:07:04 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4094610E4;
        Mon,  9 Nov 2020 05:07:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 09 Nov 2020 05:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=70az/y8KTAsJ4BrK1QhVINvFuTf
        ph+rkrc/2eGHI7Io=; b=qvuLKvtPbrJ6bEvkoCBfgMhKl8tseuFSDTEvCCbD2oa
        oML//K3+MWzf5iGaoeHyNTWYm1hQSrH7DmY1Ndwetoa/CAhNOW5YQbw81vWVhfE8
        95tPAAGVgyGphPH11X0rLEmPp9R0uY1wWUHEkDUB2KQ7Vq73HrQtInO84/NlAaYD
        vNwkNC/csjhYgHZ//LJmzEz9T7jfD00qSjwsjCz+kgvzVLxNQHUY8eKhgSYCbZXt
        lmxts1tI62zn0uSddLsLkiTMrHykL+Kst2zt+N64WW5rzC6ZcMEWmEcC/oln+M0y
        DHYHG4UU0tWzqXEWrQKFdsMXszE/LsZyXtINSp1mPIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=70az/y
        8KTAsJ4BrK1QhVINvFuTfph+rkrc/2eGHI7Io=; b=TSvsMgsuvvlWBag/lnbBz6
        VFfCLUiOX7qf08Hf7UxtumKKAC2U8LfDS+zCSrF7W5usk+J/kGxd8MLsnf7+YFCD
        uzOLUDGzHGDV/z97HEBPxtuK4bTnTFgBYj8jcdaZXYBaRaSNFLtXhFSKflyrdINh
        huv+Otu3qgF83cFXMWGpniuJZm5d00HZpcYk94gd5RvEWAmaQnSUHLSA2ufmtmb0
        vrg8Q1IFQSOM4nMQCzrlEnmcbIfltpyT0Hips7+lPWmO+LXRXXJKWQduqXsmur71
        IngeieCG5EziCVTMnCZfxz6sAWdFNbWt5oVEhfzIj7u1flqj13l5so/hfSmbDcOQ
        ==
X-ME-Sender: <xms:xxSpX7H1Vjx479Mgb7ICW1tLRRwItfAEBc_rGqQO-n4mWD2Lh2BbcQ>
    <xme:xxSpX4W-5RYSPz8Iw0NZnb46jP-8m60x278nioAy7yNoOgXCTCwTYSLN4xp6VA-J6
    PBDdfNqR9Kc4AsBgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledruddvrdegledrvdduleenucev
    lhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:xxSpX9L0-RhtfSlrHdjxLrDKb_IbyNVv9gO6y4KN6OOB-VRqb4dKCw>
    <xmx:xxSpX5FV3UZd83mIsz8UiJd-TN8wlI9uqY7JE4PaiRJFzboaHau4vg>
    <xmx:xxSpXxV5DeOUYqc3GHiuBjclOH3D05cBEDd14HQzKLmdcQJ7PJXRNA>
    <xmx:xxSpXyca7m8ek9Zw5Wv4UvhM7RO2_rk081ZdDEXpe7yYgyOIHDR9IQ>
Received: from vm-mail.pks.im (dynamic-089-012-049-219.89.12.pool.telefonica.de [89.12.49.219])
        by mail.messagingengine.com (Postfix) with ESMTPA id 306ED3063082;
        Mon,  9 Nov 2020 05:07:03 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1a9fdc4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Nov 2020 10:07:02 +0000 (UTC)
Date:   Mon, 9 Nov 2020 11:07:01 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 4/4] update-ref: Disallow restart of ongoing transactions
Message-ID: <d9abffef71466a0752c210878bb6b8fca7a72287.1604908834.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1604908834.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <cover.1604908834.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is currently possible to write multiple "start" commands into
git-update-ref(1) for a single session, which doesn't make a lot of
sense to do in the first place. It's also not quite obvious what should
actually happen. Would this just go on with the current transaction as
if nothing was written or would it recreate a new session which doesn't
yet have any references? Silently ignoring this usage isn't helping
either as it may indicate erroneous use of the interface.

This commit catches this use and instead raises an error if the user is
trying to restart an ongoing transaction.

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
index 7ed41bb328..e53d973d04 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1583,4 +1583,15 @@ test_expect_success 'transaction can commit after ab=
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


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+pFMQACgkQVbJhu7ck
PpRULQ//f0kPBG9jB4aN7hBqbo6OJkR/Q4bmh0G5JkSzkc0qokw4+mvSd2PkiyKB
LDEeh3sRFoAiiy5tmblubFqtrnf+0roo2SNbLZCjaAjrjt4PWm5ySa7IXPQoDgYk
Bc7PMvY351Le0FKwbf4QV3tG7HbGl3t4Svb3TcaJY+A59dPRsYvXnOMxK4802Sui
CboXAQSUrSiNnXveDiNolRfain0/+yV2nPRH7KvDYkg9i36vcYvhDh3x8hHWAD3P
FbiS42FERerw7MJudOLCcLw9fChQPWQBjNdmD3Vg9YvLg/1L3+BYRikqJIdskvak
jH1Po3HihC52vxdzoCwq5wA33+Du4eq+xCIA44WjgSXqCb1Wl3wGviiYQouI254S
k9EV2RzZOyZbxg6RfiRR9nuQESG4Fs+v5VHR095verlZKvCvpVsRIUuY//mV6+dm
UmnwF9KHkEuJk8/UlmNJTZVFI/2ldUcn3I1bfMQBH3wvmaO1ImcVjHpxkmOuqiMe
x3h4EiT0/N0xk35OiovoKdubwnFPh+9Tpx8iNbxQtxqAXkZvFCSPth96YM+YMT+i
AbngowEeG+e+XgUBtsEwmy2b26x6L8NjWfhCWymOfs7x73X8WKfQPUJ5Ym73/IXk
vNboATPQmNhCSam2mdpRBIVXsLF0dGHd2GgoUhrkHerZ0yvpBjs=
=ZD9R
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
