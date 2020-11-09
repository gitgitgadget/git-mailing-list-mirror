Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDAEC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F3A20663
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AvSP3dYp";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k20+da6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgKIKG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:06:57 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:49461 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729027AbgKIKG4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Nov 2020 05:06:56 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B6C16455;
        Mon,  9 Nov 2020 05:06:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 09 Nov 2020 05:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=WnckeChCvO7c/UqceOZKCS230C4
        K0IallEivuJowzTk=; b=AvSP3dYpTDIIv2KN3A3e9EuyeMV4cJCknuijDfguzkQ
        kklMA9W2ItUXnzwT41jOpAgByIW2eD+SNCJGU62edNt1lCYtVxdELXhE9v88BK/7
        mH4JwHojFZR1ff658NYLg7BFF8Te+x4Rb0kYv4f4BL9q19jWSIp0n1laxWkvY9WC
        8LkmFUQ7kcebA/oTBG+biA4o2lEW2AUWi6fZCgf22W0FF007gWob4wn8oxoY0eCd
        nn/f2aLhZ4f8p/AjnQk3rW/tejcAkTZbZrO8N28+23Y/Ic+UxPM2r5Ss90RhBNVt
        f8WUqKhZgjb06zeO481c2vB+7VJmQufMZSKF5kt6jiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=WnckeC
        hCvO7c/UqceOZKCS230C4K0IallEivuJowzTk=; b=k20+da6IC3KaSziGWYe4NS
        SHPkJJX/dIWggr5b+mrY3GQQS/nMoHgVW1fGQrSgkUSaZfJyKboYHuYLqwBlOqqi
        1qitv1GnGcylADaiuhBSPOL0Tzu9TscQFbqptqFMa4iclN2AkqN3uGfMBwrpLgcp
        CS5XcHQ2wUyESO3b/M+3d6lgHbi9eXzGsAVJGrFfQ9nfY3ifnitSmMz9HI7QGe8j
        JES5QvztO8zJaPWb4B0DIitqk2cPppWusw2CdjczlRZpws3BQKS5/fVqfrY1ck3L
        b2pA4ml88uLZZ3X/oQ5dmgTs5K+p/dnfjlDejzhKSYi/x5GfUkWWHNOXEu6qjOVA
        ==
X-ME-Sender: <xms:vxSpX5e7kqGsbPvLsdvfKI9UhZeFNthKUd0OaSUb_d3sCVVtmAKNzQ>
    <xme:vxSpX3OlLcmnihjMqA-qG1mjR9x4EqGI5vQZJDP2ykgRA6CjDiPBqxW8qUpnKNZy5
    mY1c63ophSUl7H_NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledruddvrdegledrvdduleenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:vxSpXygceeJcWpcqnhisiHbyBvqJ9Rw9ZjAKNXicBpAO_V-wm6l-Aw>
    <xmx:vxSpXy9ZoCZEEnzwtC_XbgQ8KfeGQlvKdHOrqFyuYMyY9JPRprv0UQ>
    <xmx:vxSpX1v3_bdSNzb9TDUDzuimci3gzGPS58OMEj6lebrr4sJ4tZIbDw>
    <xmx:vxSpXz2WLnx5YJGcpkQPwgWfmZlT1FeHWOavinvyFzegP7KvmGIvCw>
Received: from vm-mail.pks.im (dynamic-089-012-049-219.89.12.pool.telefonica.de [89.12.49.219])
        by mail.messagingengine.com (Postfix) with ESMTPA id AB75B306307C;
        Mon,  9 Nov 2020 05:06:54 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3c822625 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Nov 2020 10:06:53 +0000 (UTC)
Date:   Mon, 9 Nov 2020 11:06:52 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 2/4] update-ref: Allow creation of multiple transactions
Message-ID: <d2e3ec46cb1f41d8018d7b2e50b3d1a5db5c957a.1604908834.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1604908834.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <cover.1604908834.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HlL+5n6rz5pIUxbD
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
index 957bef272d..7ed41bb328 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1533,4 +1533,54 @@ test_expect_success 'transaction with prepare aborts=
 by default' '
 	test_must_fail git show-ref --verify -q $b
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
+	test_must_fail git show-ref --verify refs/heads/create-and-delete
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


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+pFLsACgkQVbJhu7ck
PpRf1w/+MH3zXMuToliybD5mmZWVZvHF7w5BUtarbUYFuldw2edphXzno/rmcDSE
U7hjMW+o7HmMwgp/HUxI2N+COyYzPr+uMb/nDUIEXKfMc9JRsMHDwb3OFNkt/P1V
APHpn8PZEsdRXYZ+lS3tpVVy0rJGU3swq70tS99LLIfzAiVsA7e5moW3XkRwyHij
7sSJoR+P+UP/EqIlRnANv6X9kBrgFVNt1SC76PviB3A4TDHQbBFKvUOdqf0Ovghm
SflXKOGZEZPKbLmDlVuMehfYwj6D0c+/KVFka2ozzpdcUqcT1G/K7qZu5lnByPBu
b9sSUOf/82KQPMx0uHdioUftnN51yxbRLvcgsuNkyfghH+Gd1AG2JlfcJCRYVZ5j
qMt+E+qDHKTyn9rlY2A9y0P/FLhpmhq62yau3IhY3YhybiTCS5tqAQPNga4m8fgj
cLc5x78GzY9SpWfbBQ+a7U8OYUKzR023GSgmLhbe6MmKb415Iw+NFDYzwH4P2WyE
/X7bb7C/UuHM85wY0bzDG20n1IOKxy5UNWyo9dggzPsok/6k+/T4ndoyF25t/sdp
noz+QIIx40kToo0bo7OVBDlhSQZCRXCAInWcVdk6X9/KhmE4lmJLRqHEk63X1CIV
wiO0tGygrPfMT2hypZuSeBle99Nc3fp8dAxhskFng51O5Wq5krw=
=yC9K
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
