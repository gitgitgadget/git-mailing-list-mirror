Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33489C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CC820784
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QmmVD5pJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N962f3I7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbgDBHJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38915 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgDBHJo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 03:09:44 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F2DF5C0290;
        Thu,  2 Apr 2020 03:09:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 03:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=xIlHGRT5bwk2fhL7S3NG4XJBPsc
        YbODI905bbJ0V9Cg=; b=QmmVD5pJQu7mICjW5JMULss4OBp26ZYgmDTBYr08CyU
        JDHEwzbx7VGHB1U1eUdl+pnIPDROHhGpc9Qg4nudzDNMuIDlfa9NGNyYB7fOibQg
        oh413whcfzKu9+G7aDF1kNco8j5PnIHL3JReXRyy3JGtH79z3F2+gFNuck3fLFkJ
        D9lyT+UGcGpLUPp+kZzqCdjsRtuKhHiAzXZxYGZMMtPdE0HeoTbTKT5LcwRTdqqe
        G+40ajUayL6AEd6Gq2fzN6KS35pgZE3TEVT3o5wZr+4enK0DVRlVo0q6dliG/Xdl
        Hx/7gE/alcF0+iOMLps1K/2BqChG+lJ6Njw+7vShM2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=xIlHGR
        T5bwk2fhL7S3NG4XJBPscYbODI905bbJ0V9Cg=; b=N962f3I7miMe/T6q11fgvn
        iXsWCHPgTXs4iSWQfb6wThz40hmjLAt5b5EKNchj2AIXn3DOLhNKmNC8htMEOREz
        hcip+i3bV0eGE/lzCo0Dx1v364yJydWKawXEzaMEcSHK+XDz2oE/Ulh/LT10EcY/
        6BnT3LUK4B4cMDVeB5PoZGJgN9uRhoT5aM3daSaMfyOyAI1Y6a7tFjAhEEEZO3lg
        QpVITM7yBuJKwP4ulO6IUA2DUT6nN9bHb6oppQqCc/V9aiTdY+/soswFXdK6SOkk
        0d20exti1acwyAOGK92dLiPahk00Ikppf822bFIgsdHKgRGjx4T4YK3S6FT8xMLw
        ==
X-ME-Sender: <xms:t4-FXogD8BG4sudZPsHNbmDupv4IeNAatuVwfHRGRsc3AXyACtuirg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvd
    drleegrddvkeenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:t4-FXtL7m4LbOwCN8j2myvXTxX_xS8F2Q7x1rCZBvGQNcXllJnEtmw>
    <xmx:t4-FXpUAlr9woXBCEr3c63BToo63SgAYht0kWvcEXbUrlE_14eOt8g>
    <xmx:t4-FXoWCo2q3KznEJkR52uYnJMmsS3mceu7bPKj6EV0yDxzkcA49JA>
    <xmx:t4-FXnpTV6MclWN_WdNzKQ_pqwnxn7WxEKKuuWncuHcaojGqlchXbQ>
Received: from vm-mail.pks.im (x590c5e1c.dyn.telefonica.de [89.12.94.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id C8689306CDC6;
        Thu,  2 Apr 2020 03:09:42 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ad95fdaa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 2 Apr 2020 07:09:41 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:09:48 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/9] update-ref: pass end pointer instead of strbuf
Message-ID: <192cbf59446e5d0dbd842008d0d43581b85dfdbe.1585811013.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <cover.1585811013.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We currently pass both an `strbuf` containing the current command line
as well as the `next` pointer pointing to the first argument to
commands. This is both confusing and makes code more intertwined.
Convert this to use a simple pointer as well as a pointer pointing to
the end of the input as a preparatory step to line-wise reading of
stdin.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1bba5ea6c2..381d347fb4 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -95,7 +95,7 @@ static char *parse_refname(const char **next)
  * provided but cannot be converted to a SHA-1, die.  flags can
  * include PARSE_SHA1_OLD and/or PARSE_SHA1_ALLOW_EMPTY.
  */
-static int parse_next_oid(struct strbuf *input, const char **next,
+static int parse_next_oid(const char **next, const char *end,
 			  struct object_id *oid,
 			  const char *command, const char *refname,
 			  int flags)
@@ -103,7 +103,7 @@ static int parse_next_oid(struct strbuf *input, const c=
har **next,
 	struct strbuf arg =3D STRBUF_INIT;
 	int ret =3D 0;
=20
-	if (*next =3D=3D input->buf + input->len)
+	if (*next =3D=3D end)
 		goto eof;
=20
 	if (line_termination) {
@@ -128,7 +128,7 @@ static int parse_next_oid(struct strbuf *input, const c=
har **next,
 			die("%s %s: expected NUL but got: %s",
 			    command, refname, *next);
 		(*next)++;
-		if (*next =3D=3D input->buf + input->len)
+		if (*next =3D=3D end)
 			goto eof;
 		strbuf_addstr(&arg, *next);
 		*next +=3D arg.len;
@@ -179,7 +179,7 @@ static int parse_next_oid(struct strbuf *input, const c=
har **next,
  */
=20
 static const char *parse_cmd_update(struct ref_transaction *transaction,
-				    struct strbuf *input, const char *next)
+				    const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -190,11 +190,11 @@ static const char *parse_cmd_update(struct ref_transa=
ction *transaction,
 	if (!refname)
 		die("update: missing <ref>");
=20
-	if (parse_next_oid(input, &next, &new_oid, "update", refname,
+	if (parse_next_oid(&next, end, &new_oid, "update", refname,
 			   PARSE_SHA1_ALLOW_EMPTY))
 		die("update %s: missing <newvalue>", refname);
=20
-	have_old =3D !parse_next_oid(input, &next, &old_oid, "update", refname,
+	have_old =3D !parse_next_oid(&next, end, &old_oid, "update", refname,
 				   PARSE_SHA1_OLD);
=20
 	if (*next !=3D line_termination)
@@ -214,7 +214,7 @@ static const char *parse_cmd_update(struct ref_transact=
ion *transaction,
 }
=20
 static const char *parse_cmd_create(struct ref_transaction *transaction,
-				    struct strbuf *input, const char *next)
+				    const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -224,7 +224,7 @@ static const char *parse_cmd_create(struct ref_transact=
ion *transaction,
 	if (!refname)
 		die("create: missing <ref>");
=20
-	if (parse_next_oid(input, &next, &new_oid, "create", refname, 0))
+	if (parse_next_oid(&next, end, &new_oid, "create", refname, 0))
 		die("create %s: missing <newvalue>", refname);
=20
 	if (is_null_oid(&new_oid))
@@ -246,7 +246,7 @@ static const char *parse_cmd_create(struct ref_transact=
ion *transaction,
 }
=20
 static const char *parse_cmd_delete(struct ref_transaction *transaction,
-				    struct strbuf *input, const char *next)
+				    const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -257,7 +257,7 @@ static const char *parse_cmd_delete(struct ref_transact=
ion *transaction,
 	if (!refname)
 		die("delete: missing <ref>");
=20
-	if (parse_next_oid(input, &next, &old_oid, "delete", refname,
+	if (parse_next_oid(&next, end, &old_oid, "delete", refname,
 			   PARSE_SHA1_OLD)) {
 		have_old =3D 0;
 	} else {
@@ -282,7 +282,7 @@ static const char *parse_cmd_delete(struct ref_transact=
ion *transaction,
 }
=20
 static const char *parse_cmd_verify(struct ref_transaction *transaction,
-				    struct strbuf *input, const char *next)
+				    const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -292,7 +292,7 @@ static const char *parse_cmd_verify(struct ref_transact=
ion *transaction,
 	if (!refname)
 		die("verify: missing <ref>");
=20
-	if (parse_next_oid(input, &next, &old_oid, "verify", refname,
+	if (parse_next_oid(&next, end, &old_oid, "verify", refname,
 			   PARSE_SHA1_OLD))
 		oidclr(&old_oid);
=20
@@ -311,7 +311,7 @@ static const char *parse_cmd_verify(struct ref_transact=
ion *transaction,
 }
=20
 static const char *parse_cmd_option(struct ref_transaction *transaction,
-				    struct strbuf *input, const char *next)
+				    const char *next, const char *end)
 {
 	const char *rest;
 	if (skip_prefix(next, "no-deref", &rest) && *rest =3D=3D line_termination)
@@ -323,7 +323,7 @@ static const char *parse_cmd_option(struct ref_transact=
ion *transaction,
=20
 static const struct parse_cmd {
 	const char *prefix;
-	const char *(*fn)(struct ref_transaction *, struct strbuf *, const char *=
);
+	const char *(*fn)(struct ref_transaction *, const char *, const char *);
 } command[] =3D {
 	{ "update", parse_cmd_update },
 	{ "create", parse_cmd_create },
@@ -363,7 +363,7 @@ static void update_refs_stdin(struct ref_transaction *t=
ransaction)
 		if (!cmd)
 			die("unknown command: %s", next);
=20
-		next =3D cmd->fn(transaction, &input, next);
+		next =3D cmd->fn(transaction, next, input.buf + input.len);
 		next++;
 	}
=20
--=20
2.26.0


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Fj7sACgkQVbJhu7ck
PpS19w//XWmaRRPSxVnt+ShAGInoBPjTVWp10Y660xSYYARcaIAKaK/Sb6reyTuO
M0rd1Bkn8CKgTWf4+AEbSn6Z9CVOPFI3Vc/ebrpc4DtEcWLoumO7zHmY2PgeyprG
i6caWeGHro8ywbwNbKrolgAx2wj3Fvmdx6uCyfdXkofXizK/UO4i21gWLoKguSUM
WfHCI+kJzg7yFGXnVIH1VxelqKNL7htb2HixBxhMUZG3X3tqy8K3tQ/52IvuPbP/
OJ3GrB6Uixtck2dEf38L/p3KFHPtjCrUNWNxFCUg8TgxyucEQcxusLjDi5QBsSAN
4XBgkpLPRr4W1LqEwDEyQSYduKmY1uWxhW4w7ah8CYySePdwY+r0MjV/gofvNxOI
UmN9ecnkKi9u31bv5dLO90ve52+r01JzIKz8vxIPs0JE9muJaBct5bSGlOPoGpGB
2is+FVe+m0kJwmLAmzcUQL+q9/tpOfO6SfBnCX15DaEpdtGuYMjBw+soiO7e5SnY
CIX4NLlEUB4Xh2AnT+PhwhVPxDLPqkX3y7Ejh85rhtVNmjCO15CD/AFnIvvXohDT
RZq3mRIWz01k/8rxd0N2N8P7ll8Rpvk/aPGEyge63N0u+jMCJUCHH813xdUJbw7K
3G+Pbi4/LeNyYOtIeJKd7GtN7MQ0s2/SzKgCA7dpbexPqTVw2dg=
=sib/
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
