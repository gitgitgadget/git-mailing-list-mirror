Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9180DC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A282073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c0wzvVTZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlYXt08/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgC3Nqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:46:46 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:58871 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727954AbgC3Nqq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:46:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5A5CD6AE;
        Mon, 30 Mar 2020 09:46:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=iiLHvfGFbXDx0F/ifU81Fk15CFN
        dQ7LUojXb4EG+zDs=; b=c0wzvVTZhrDy/9/z+0n7V8qYY13jpj48e2hSFlvHdZT
        XX8tl6vZEsyMvUZkwU3OjKBrmazsc2Cg+jckl7OVc1V2VL/S3HEDdNYe8Lplj5bj
        nAngpNHewPAOkccpjK6a7n/phg8TnIhmKmqdMvbl7artW7UVCGpQCfeHHcN5SU8x
        XFyu7/fi/PXfkClyWkUbVey53KQL0nyAt6uReCGdBOwQbYLBpB6Nx6NkSWQk0KTD
        3RYum1z5UbolHKc7I2bPDrxvJsC5ROBnJdyZFd1tSrRNq/vZMRSrcE2JFy4gusho
        Cggv4sNpVAVbKox3pMJ1URiF0UrFdVmhp+TpmAkLG8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=iiLHvf
        GFbXDx0F/ifU81Fk15CFNdQ7LUojXb4EG+zDs=; b=HlYXt08/SJnjrfqbz0MvPW
        n2U6mYfF2tT1aHgcOrXvBmNozdg+3qTmDyliFHABKq3ndoYb1vb9FfpqdjZcttUo
        gBqVM0/JnydaLwaGlYaIpiDwIac80pKv1JEzp4m+4Zr9Vk8eCopzJnI/d2nXs8mO
        pywKVPD69QSzMl53GczC/LPqr1wuz1ndeR8s3My3yxnVvDuFL3n2+NqJASNUw2xC
        ADmYK7+aYWvk9ZHb7EMa3xFJsqHTnSeLYHXGX9WjOVYFTANhK3YnnrO/WJF079Uu
        RUzHf4s/9rJsyBzq95l8RxtoU2lx2jy4P4XGLW9br6TFffP19iTAe5Om3XtvTRxw
        ==
X-ME-Sender: <xms:RPiBXtg1KWPJuXtHrF78jbVDlIpXqPbayrhE7W7lgOsyh4-fY6DcYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:RPiBXnQGC0G2w_xcucMZvoD88mZVBzean3dEPgepDqFbhFMa5NDH7A>
    <xmx:RPiBXuyWAf2zignx-XxZXiBxoENMH3__KjqQ6zdjVfEdWwqqz5iFLQ>
    <xmx:RPiBXqdAHiU8jQI6nBz7foVnvaapGaD8JZ4zlPzswJtd3UH6mBU64Q>
    <xmx:RfiBXvParpPhvz-qUHUNybiGs3Y6UUOYMzpFyHEdSFCo56qKtQReZg>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 499B0328005E;
        Mon, 30 Mar 2020 09:46:44 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 60ad1216 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:46:42 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:46:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/9] update-ref: pass end pointer instead of strbuf
Message-ID: <cbe430029df9e8e6dc88e3e0ca7380ea5b6d00ef.1585575749.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585575749.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <cover.1585575749.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7JfCtLOvnd9MIVvH
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
index 6f2aba916b..139c3b11fa 100644
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
@@ -193,11 +193,11 @@ static const char *parse_cmd_update(struct ref_transa=
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
@@ -217,7 +217,7 @@ static const char *parse_cmd_update(struct ref_transact=
ion *transaction,
 }
=20
 static const char *parse_cmd_create(struct ref_transaction *transaction,
-				    struct strbuf *input, const char *next)
+				    const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -230,7 +230,7 @@ static const char *parse_cmd_create(struct ref_transact=
ion *transaction,
 	if (!refname)
 		die("create: missing <ref>");
=20
-	if (parse_next_oid(input, &next, &new_oid, "create", refname, 0))
+	if (parse_next_oid(&next, end, &new_oid, "create", refname, 0))
 		die("create %s: missing <newvalue>", refname);
=20
 	if (is_null_oid(&new_oid))
@@ -252,7 +252,7 @@ static const char *parse_cmd_create(struct ref_transact=
ion *transaction,
 }
=20
 static const char *parse_cmd_delete(struct ref_transaction *transaction,
-				    struct strbuf *input, const char *next)
+				    const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -266,7 +266,7 @@ static const char *parse_cmd_delete(struct ref_transact=
ion *transaction,
 	if (!refname)
 		die("delete: missing <ref>");
=20
-	if (parse_next_oid(input, &next, &old_oid, "delete", refname,
+	if (parse_next_oid(&next, end, &old_oid, "delete", refname,
 			   PARSE_SHA1_OLD)) {
 		have_old =3D 0;
 	} else {
@@ -291,7 +291,7 @@ static const char *parse_cmd_delete(struct ref_transact=
ion *transaction,
 }
=20
 static const char *parse_cmd_verify(struct ref_transaction *transaction,
-				    struct strbuf *input, const char *next)
+				    const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -304,7 +304,7 @@ static const char *parse_cmd_verify(struct ref_transact=
ion *transaction,
 	if (!refname)
 		die("verify: missing <ref>");
=20
-	if (parse_next_oid(input, &next, &old_oid, "verify", refname,
+	if (parse_next_oid(&next, end, &old_oid, "verify", refname,
 			   PARSE_SHA1_OLD))
 		oidclr(&old_oid);
=20
@@ -323,7 +323,7 @@ static const char *parse_cmd_verify(struct ref_transact=
ion *transaction,
 }
=20
 static const char *parse_cmd_option(struct ref_transaction *transaction,
-				    struct strbuf *input, const char *next)
+				    const char *next, const char *end)
 {
 	const char *rest;
 	if (!skip_prefix(next, " ", &next))
@@ -337,7 +337,7 @@ static const char *parse_cmd_option(struct ref_transact=
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
@@ -385,7 +385,7 @@ static void update_refs_stdin(struct ref_transaction *t=
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


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B+EMACgkQVbJhu7ck
PpRDBw//TyvvwjQ+dRoVSX8egxx0+lv9JJcPFN2uTnQrIHz0MNC00y1UKiObL+0C
nIVX2HheTLGloheVkbavArf4M3WKRHp8hF4KNZDfcl3cC/qEOR6Ij9sZyCYxPOEQ
W3qES0eKTal3m1Klmd/v5y+AgD3jzhZqsVNS1je3h/JcnHwWgBwYXRnstrKWkZGM
F2qfwqgt+OWkqmjeJoHsgk6jYDIFDaFGQWQuYLB0lT141L8f3v0qtM5H7mFT/4sa
M82GcheDQUMSlMDkgtDypHy+VmjR0M2Zaz1I3Z4C/jnnDaulkUMeSUAg30iO+BHp
ErxOKyFx7WqyQPRa6FtILGrzZYsqRJ3p82zu2HQyi1oN8EOmd/3poQb5e99fi+hc
ru0jdF8tHdjTE/zbBlVxhkiKIJpf9aQp0b2ICG4v/MLy2nueqiPYIXIo+J0Og7FS
XMR7uWgVLliDAz4UWsnrdhOppGcGqqANHFebYak3yYfdmzfglzZkpjmQc/t+k4YM
Os+5R7Mzer9NZt7RAa9kq50pr+nawKrQalwGP6bCwz+44fowfS4Zuwg6q2NuIMXU
ORogFtvQSS965wNDknGbA1AHL/2DoJPOsx3GLjKdDzFWqRd9ChtlPbhGm93GbjH4
Dzl2AwXkEkq83GMye6dHOgAh3413VnsaClOjnJvqlmS7cvDqfjo=
=n3Tb
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
