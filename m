Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19731C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78C620784
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NpDY+N3Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCYYyMPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbgDBHJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56341 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgDBHJt (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 03:09:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3B98F5C028F;
        Thu,  2 Apr 2020 03:09:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 03:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=O6AMiESRLD83K6zQxtKvWe18N/H
        t4Wi3hNEvQO1P7BU=; b=NpDY+N3QzES65ay6Yb0yrL8h6QMbtFOqnBgnmvv2leG
        FvDhKpAb3RhCt9LDkKJvIlT495pwBnUf1v4yeerpsEDkQx1A910O3tyX+LdecLAJ
        Tajzb7jx7/mC9XNNLJis7+8B+2mDn6J8cycutzEAyav+r097VQMH9X79E268+nTO
        wC6c4NbY7mDa7MJvSjPPNMGozDyxEpn0riIzNEhuLlF70jptchvdLZQGbCs+sKkh
        C8U7YkpYetOKUd6fW92jqv96QqyCi0IjLuOoLXOGLrj31p+C/JrK0w0gu4ApBVDx
        ysNAHq2Cr1RELCOC4CsZK8zzyYGoLHknO7Z+vGq6uzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=O6AMiE
        SRLD83K6zQxtKvWe18N/Ht4Wi3hNEvQO1P7BU=; b=XCYYyMPKoogM3ZUsBrBHyR
        5wfaLSyG+LVt4tcnPi9vmHkPcU9wbidIfxlsqVWnwWR4A9E+nLxiBsfRtPwfIqkN
        H8L4bkJnGlEtk54RFjug/YjGSaZoFedvm5SP8Dsn3X5aEc179AAkmoUc7fqwtYWj
        ozHRMoybBH+ixDB5/yhcjqnq/YnOJdYFrGw6/SQPNp+CDmNVhUa/SwlG+DCQyLxE
        /GX8CNVS4RB8jF21uBYfK4FISaYVug4jAIdJs/Oa7xWzLTqLD1R6LBOePbE3tKDP
        V3l1+/a8jCdreIeErLSaMMGdhUccigwIqZIXs2QqygqSypqg6UIUOlUqUZI9Ryjw
        ==
X-ME-Sender: <xms:vI-FXqJyzf3U975NAXKVEbRuG8a0CY-EBN2oqqHQyKruUuXmmpx4ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvd
    drleegrddvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:vI-FXiYQcZkonNNH2ngJa806K7ylURCmilIZQ7Q93h4t6qyI4kWtpg>
    <xmx:vI-FXjm33DoKvgQM8nFgzcM8MzD6SyXFaidlJNM_gTqyk2K1WRaMIQ>
    <xmx:vI-FXjQekeXNtQ30ny3Z-W7Y17IaHijU3GAl8IU1V7GQVzwOwkfQKQ>
    <xmx:vI-FXojoETshtBDBCxE0N0Cs0P6rPAM3RdlRm4zaGWV8uQcFvmc7LQ>
Received: from vm-mail.pks.im (x590c5e1c.dyn.telefonica.de [89.12.94.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 87F5E306CD98;
        Thu,  2 Apr 2020 03:09:47 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 45aaa4b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 2 Apr 2020 07:09:46 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:09:53 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/9] update-ref: move transaction handling into
 `update_refs_stdin()`
Message-ID: <be7bcf3dbd3e2c4b58c6c8d6a335a6ad7373de07.1585811013.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <cover.1585811013.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While the actual logic to update the transaction is handled in
`update_refs_stdin()`, the transaction itself is started and committed
in `cmd_update_ref()` itself. This makes it hard to handle transaction
abortion and commits as part of `update_refs_stdin()` itself, which is
required in order to introduce transaction handling features to `git
update-refs --stdin`.

Refactor the code to move all transaction handling into
`update_refs_stdin()` to prepare for transaction handling features.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 381d347fb4..0f34b68904 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -332,15 +332,21 @@ static const struct parse_cmd {
 	{ "option", parse_cmd_option },
 };
=20
-static void update_refs_stdin(struct ref_transaction *transaction)
+static void update_refs_stdin(void)
 {
-	struct strbuf input =3D STRBUF_INIT;
+	struct strbuf input =3D STRBUF_INIT, err =3D STRBUF_INIT;
+	struct ref_transaction *transaction;
 	const char *next;
 	int i;
=20
 	if (strbuf_read(&input, 0, 1000) < 0)
 		die_errno("could not read from stdin");
 	next =3D input.buf;
+
+	transaction =3D ref_transaction_begin(&err);
+	if (!transaction)
+		die("%s", err.buf);
+
 	/* Read each line dispatch its command */
 	while (next < input.buf + input.len) {
 		const struct parse_cmd *cmd =3D NULL;
@@ -367,6 +373,11 @@ static void update_refs_stdin(struct ref_transaction *=
transaction)
 		next++;
 	}
=20
+	if (ref_transaction_commit(transaction, &err))
+		die("%s", err.buf);
+
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 	strbuf_release(&input);
 }
=20
@@ -401,21 +412,11 @@ int cmd_update_ref(int argc, const char **argv, const=
 char *prefix)
 	}
=20
 	if (read_stdin) {
-		struct strbuf err =3D STRBUF_INIT;
-		struct ref_transaction *transaction;
-
-		transaction =3D ref_transaction_begin(&err);
-		if (!transaction)
-			die("%s", err.buf);
 		if (delete || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination =3D '\0';
-		update_refs_stdin(transaction);
-		if (ref_transaction_commit(transaction, &err))
-			die("%s", err.buf);
-		ref_transaction_free(transaction);
-		strbuf_release(&err);
+		update_refs_stdin();
 		return 0;
 	}
=20
--=20
2.26.0


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Fj8AACgkQVbJhu7ck
PpQ26A//VjOtGRaKZ1J1wJUMbISct551xvT+Ewi5HPTk8hsGLy+N+HDzRI4GWr/u
XwU3lw2f48q0f8FeRxMqfM6Ub+R8PhouwjxnyjJMn/ihwqV/kmfwAyYTqxpQsSYQ
K1cx30n7dqoO4sIRMqfGPXBWzasnZCtq7IRqb8op/LV/sWFExb7SiMUeSTG+6Y2f
wzKFSmj7ZbW/hs/2gp/H+SSsnWUXD9pnEdcSzRgg4ETycsVxu6LRqivX4AnsY6Sl
6SjLoCk5hucaVq1ElfOrBD/J4bCzHQIgPr/mrulFbGqhycrKjcU0ykTRYg2kVJZW
BcO4gJ08bR2BxjVlRE6BBzSG2Z9Oftb7jVyEhr8UBUk0jHaiDpZn55zDoLHoSbmQ
50B6F9U8dGqbGAg5NPIUt7qFa8xhiM7YurfKOHjWfiUoURjiuJgQ/myCrJ6k2Wwd
h2zNUE+cMvSfQZOpO0ytueGClwlGEhymL2FWTJVdhYZCsWQPc+togJMsEPN1a0eE
nuCeC/NVeh3WodUE5asD2PhqecocA+hzgH6hrv6eoh68mx0oMb+d/BES/myEU08y
FI9Zhkq4XVHU+p0Bj0NcZChA048ptkL7sC+Qx9ya54ghrFCE/iA9p4pmbu29XlYZ
QMr4GwmVenwnn81BCp+biXQHx9rc4vWfI840qcOZ4HZ6Vtn0hk4=
=bho7
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
