Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD209C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F820757
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fHhjlmPe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ERaHyvlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgC3Nqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:46:39 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:40465 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727954AbgC3Nqj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:46:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9CE02622;
        Mon, 30 Mar 2020 09:46:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=iwZsX6lhLXdKSuczgsbqmfQ2IrP
        FMNmSdEex3+ZPJng=; b=fHhjlmPe69q9re56f8PWmcJHq71I4LS9Mbq3BG3TBSC
        8kwswD/t7xLgy/9VK/bqCYyfrgNggQn6Fc6qUCnQgeHahIsDXHYZWSbFy5BLVPwY
        mUzvH99tsq5pfrJbBHyBCO3hblL3+I9BU2u7GPBlDs5Uwmvr7f7WOx/J1q1NXjDR
        oZ1UQ1lz5FtehmVirhscVT7MX/qAgEh3GkZsL65irEH1PbS6DcoLCOJPdbmQadB3
        7ovfGYG+KWujg/ByylJADsAChtjGdq7dX2GV22m8Q9nhXQoqj7X052KUfre/Yw7l
        KMVVcg9bFUE4r3vr7yGpF+r7YI1doYwkl6x4g1AycXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=iwZsX6
        lhLXdKSuczgsbqmfQ2IrPFMNmSdEex3+ZPJng=; b=ERaHyvlFF9dcm8WWznwYLU
        1b37NFMVwB1QMulFUJAHcXg5ug0xZtZor2oA1yxYqMyRwlEewlLUOuFDQ+eK3fgb
        7rsJdT5CUbE9o1Nm+pc2yxxX+KZdzCf7lzKwRUcD7acxnHk8wIBVt9K2WvkOkWwd
        9mvRWkeizEa4325cqE2E1jyT6VsDkdwiqC4VatvKv0PZzay1Q5W7xqMN7Tjr1xlu
        SrBVIOd4y0oj7CEJwnwmP3fuoPnrjOG6uPjvq/SiOy1Mdi1Rj0zPp1pEY5TcygQU
        a/FNNZBfDHrvTkdqBWMwR6oLJcUCg4liGIcHM6u88gdqxVvx0MDx9DYcKYIlzclQ
        ==
X-ME-Sender: <xms:PviBXswpty1RcdGQpfveBQKv_0aglUktuSwZYUHA8YnqvCX6PsNF3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:PviBXmSpXXgfYgeOsdQOjhR9mlkx7klFFOoiPIKRIqptguv6rtBRqw>
    <xmx:PviBXoihi-PchuR0vXlPCHUp-LQvvt4hqTJbzq-fL9-09aPp9W6Gmw>
    <xmx:PviBXuZ2iIkvuqSTLUK7Lg8u_tOpdBBkcqxaRH5-sTQz6DojXDh0ng>
    <xmx:PviBXgafuDFkqnRZFRSUzD9mbCJAK_EsVHOcaULno3G74bO13lVW_w>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 86579328005D;
        Mon, 30 Mar 2020 09:46:37 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 53a19b53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:46:36 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:46:40 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/9] update-ref: drop unused argument for `parse_refname`
Message-ID: <49a14d20462bb9d7f00e42df73fc21b050be1db0.1585575749.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585575749.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <cover.1585575749.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `parse_refname` function accepts a `struct strbuf *input` argument
that isn't used at all. As we're about to convert commands to not use a
strbuf anymore but instead an end pointer, let's drop this argument now
to make the converting commit easier to review.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 559475681e..6f2aba916b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -50,7 +50,7 @@ static const char *parse_arg(const char *next, struct str=
buf *arg)
  * the argument.  Die if C-quoting is malformed or the reference name
  * is invalid.
  */
-static char *parse_refname(struct strbuf *input, const char **next)
+static char *parse_refname(const char **next)
 {
 	struct strbuf ref =3D STRBUF_INIT;
=20
@@ -189,7 +189,7 @@ static const char *parse_cmd_update(struct ref_transact=
ion *transaction,
 	if (!skip_prefix(next, " ", &next))
 		die("update: missing space after command");
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("update: missing <ref>");
=20
@@ -226,7 +226,7 @@ static const char *parse_cmd_create(struct ref_transact=
ion *transaction,
 	if (!skip_prefix(next, " ", &next))
 		die("create: missing space after command");
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("create: missing <ref>");
=20
@@ -262,7 +262,7 @@ static const char *parse_cmd_delete(struct ref_transact=
ion *transaction,
 	if (!skip_prefix(next, " ", &next))
 		die("delete: missing space after command");
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("delete: missing <ref>");
=20
@@ -300,7 +300,7 @@ static const char *parse_cmd_verify(struct ref_transact=
ion *transaction,
 	if (!skip_prefix(next, " ", &next))
 		die("verify: missing space after command");
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("verify: missing <ref>");
=20
--=20
2.26.0


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B+D0ACgkQVbJhu7ck
PpSEwA//cx+JfFRfxhe6A4/Egx0axh2s+N4f9qPewagORYeefx7HynJI6dqw807K
10OnQ+IMH3U/pcZ6AbckfPS/wfyVtLleby79ckVl8/no+HgPXWSyfW04leC68BJ+
hxyHgHl7TU9pZknf8MnijRFuPNAUyo3SB4ygheqIf6H8jq4VnTyERmpBTSnt/pFj
HmOlulbK8jSqzeiA5mq9YKkfNelW5XjvX7AYZYr2B0rXaoaQmA6aHgC5ABijnm16
CnkFMBm9rG0f7k3uuqjyGKcGf6ASGKw4J5L+6fpI7XjTVVA+/2/vfbzu7Z8lGOWi
qR9CYMv32xW7eYhcotOIcMu2udskLe4PankD6BQtu7vbz9qtU9CLFryL3h7SpBy9
cwpP+PAZ9O9FPbSZS8rKAFrLPu2R/W50croowbkQQpjXIyyZFgOYOGzfsmA/GncY
aDQs5hwVEj03Vg3VgM2z/cug569Ce0fglgwxkQmFj18aQlodU70YMZr8suPS2R2J
Mb1RWWX2HLsGz9iS4TuO5jA2aoF4R7876zinAhWllqgGNJRw7SrWJ7KXgyKOzl7C
t36QsT9/nz4PaJcVms3W1ZfbU0c254r00aaqjZ7kxyjUBQvWvsyQpdL0G6bJzWLJ
A6hZOTegY6tAH2XRctK+l3OarYeOwVFqUZTuqy1J9UXo7DpUDYU=
=hqbn
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
