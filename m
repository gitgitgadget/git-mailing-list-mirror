Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C233EC43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB372078A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i6ULELT3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mI+SUwu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCYJx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:53:56 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56119 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbgCYJx4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Mar 2020 05:53:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A8445C0227;
        Wed, 25 Mar 2020 05:53:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 05:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=lh0q1o++tE+2Dc66P8nRvQgka41
        0aAtpGllrXJFNIMY=; b=i6ULELT3dZALA5gJL4CMSTHtdFlf8Sl2VujZh7xRpyq
        imYsdbO/zWbs7YRF8hflXnCnHCTLBijQHFiYN05yZgoIWN94Auk2vnSNgkYBFHFJ
        X60bpidhUnOj2vKLbnfqpgKG651xC/c70IaGhrmKnhdb0Qaz5McB1BTTrVg4AraX
        EMuuoIlMsItilPOgupVShPrxhZkuarSylrmWF8lNSS/WnLmCw502Gz3AK7Pj0Frc
        gjDBQxLYLF5PkCSAW2g4EhddexneJ/GKW9GWH66DUa5VPf7GW9zpnH3u2scZOs50
        gHo7X+Ce+kFHXgN10UocZUyqwGUZwe/R1xymnmV5s7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lh0q1o
        ++tE+2Dc66P8nRvQgka410aAtpGllrXJFNIMY=; b=mI+SUwu+6pcrffhk0cSKFf
        90a7ApqL1A9t7LSu4UwHoBasuCPOl/8402CkrzqbwGQEwLY6DYdcjtnUMZzTjtrV
        x32SmHGXEJ3AvT0YHLEo5JPKCczZFBIG8+9A1WX8V0BP9FfyqMn7/KsQ0p2nQScL
        nFGS5X7f7+NoYR9GcCQ/LguLBqbtGKFQBTWnzytuaIxwpjicTh0L64I/DUQ70V1n
        6MVSK7g8RNdYnbcUXJvxGsbQnyjLJVCeDZ/ZmDyiaKUkaSx1cd5NM+SIOZ7PNYNG
        L1V34ze5MisujyIEP+l/zRTMWOCNXZSCh7Z0ldpjI9J6WB9zZpNzV4uonfPv0P+A
        ==
X-ME-Sender: <xms:Myp7Xl4t98LWWnJc5HqtjbwIG2Jzj93NyAVwLuvg5b4KdosTf7YFwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddufe
    drudekhedrjedvnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Myp7XtXTFwrqrwurzShhLXqFYoXRGgKLDKNhMJyHtASiRFy0hU_-Zg>
    <xmx:Myp7XjPfrNK4T6w-dSz7DKCzMO7wlttvorrhAJR2VAUdk1MucxPyrw>
    <xmx:Myp7XonNuGHKE32ZOxAFSRghkjw6GGgl-_jgfI44gjU9EJ_KW0b2Ow>
    <xmx:Myp7Xpk_zjSAk8I2EN4oqJaOoCeC7Ny6a_rmp7-Zo2WCMxJ7p7h2zg>
Received: from vm-mail.pks.im (x4d0db948.dyn.telefonica.de [77.13.185.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id D8EF0328005E;
        Wed, 25 Mar 2020 05:53:54 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 93f558bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Mar 2020 09:53:53 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:53:55 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 4/9] update-ref: organize commands in an array
Message-ID: <50ffc263293571f8af71fd1d253ac238c6909229.1585129842.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <cover.1585129842.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We currently manually wire up all commands known to `git-update-ref
--stdin`, making it harder than necessary to preprocess arguments after
the command is determined. To make this more extensible, let's refactor
the code to use an array of known commands instead. While this doesn't
add a lot of value now, it is a preparatory step to implement line-wise
reading of commands.

As we're going to introduce commands without trailing spaces, this
commit also moves whitespace parsing into the respective commands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 66 ++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2d8f7f0578..d2b917a47c 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -171,11 +171,11 @@ static int parse_next_oid(struct strbuf *input, const=
 char **next,
 /*
  * The following five parse_cmd_*() functions parse the corresponding
  * command.  In each case, next points at the character following the
- * command name and the following space.  They each return a pointer
- * to the character terminating the command, and die with an
- * explanatory message if there are any parsing problems.  All of
- * these functions handle either text or binary format input,
- * depending on how line_termination is set.
+ * command name.  They each return a pointer to the character
+ * terminating the command, and die with an explanatory message if
+ * there are any parsing problems.  All of these functions handle
+ * either text or binary format input, depending on how
+ * line_termination is set.
  */
=20
 static const char *parse_cmd_update(struct ref_transaction *transaction,
@@ -186,6 +186,9 @@ static const char *parse_cmd_update(struct ref_transact=
ion *transaction,
 	struct object_id new_oid, old_oid;
 	int have_old;
=20
+	if (!skip_prefix(next, " ", &next))
+		die("update: missing space after command");
+
 	refname =3D parse_refname(input, &next);
 	if (!refname)
 		die("update: missing <ref>");
@@ -220,6 +223,9 @@ static const char *parse_cmd_create(struct ref_transact=
ion *transaction,
 	char *refname;
 	struct object_id new_oid;
=20
+	if (!skip_prefix(next, " ", &next))
+		die("create: missing space after command");
+
 	refname =3D parse_refname(input, &next);
 	if (!refname)
 		die("create: missing <ref>");
@@ -253,6 +259,9 @@ static const char *parse_cmd_delete(struct ref_transact=
ion *transaction,
 	struct object_id old_oid;
 	int have_old;
=20
+	if (!skip_prefix(next, " ", &next))
+		die("delete: missing space after command");
+
 	refname =3D parse_refname(input, &next);
 	if (!refname)
 		die("delete: missing <ref>");
@@ -288,6 +297,9 @@ static const char *parse_cmd_verify(struct ref_transact=
ion *transaction,
 	char *refname;
 	struct object_id old_oid;
=20
+	if (!skip_prefix(next, " ", &next))
+		die("verify: missing space after command");
+
 	refname =3D parse_refname(input, &next);
 	if (!refname)
 		die("verify: missing <ref>");
@@ -310,9 +322,12 @@ static const char *parse_cmd_verify(struct ref_transac=
tion *transaction,
 	return next;
 }
=20
-static const char *parse_cmd_option(struct strbuf *input, const char *next)
+static const char *parse_cmd_option(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
 	const char *rest;
+	if (!skip_prefix(next, " ", &next))
+		die("option: missing space after command");
 	if (skip_prefix(next, "no-deref", &rest) && *rest =3D=3D line_termination)
 		update_flags |=3D REF_NO_DEREF;
 	else
@@ -320,33 +335,50 @@ static const char *parse_cmd_option(struct strbuf *in=
put, const char *next)
 	return rest;
 }
=20
+static const struct parse_cmd {
+	const char *prefix;
+	const char *(*fn)(struct ref_transaction *, struct strbuf *, const char *=
);
+} commands[] =3D {
+	{ "update", parse_cmd_update },
+	{ "create", parse_cmd_create },
+	{ "delete", parse_cmd_delete },
+	{ "verify", parse_cmd_verify },
+	{ "option", parse_cmd_option },
+};
+
 static void update_refs_stdin(struct ref_transaction *transaction)
 {
 	struct strbuf input =3D STRBUF_INIT;
 	const char *next;
+	int i;
=20
 	if (strbuf_read(&input, 0, 1000) < 0)
 		die_errno("could not read from stdin");
 	next =3D input.buf;
 	/* Read each line dispatch its command */
 	while (next < input.buf + input.len) {
+		const struct parse_cmd *cmd =3D NULL;
+
 		if (*next =3D=3D line_termination)
 			die("empty command in input");
 		else if (isspace(*next))
 			die("whitespace before command: %s", next);
-		else if (skip_prefix(next, "update ", &next))
-			next =3D parse_cmd_update(transaction, &input, next);
-		else if (skip_prefix(next, "create ", &next))
-			next =3D parse_cmd_create(transaction, &input, next);
-		else if (skip_prefix(next, "delete ", &next))
-			next =3D parse_cmd_delete(transaction, &input, next);
-		else if (skip_prefix(next, "verify ", &next))
-			next =3D parse_cmd_verify(transaction, &input, next);
-		else if (skip_prefix(next, "option ", &next))
-			next =3D parse_cmd_option(&input, next);
-		else
+
+		for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
+			if (!skip_prefix(next, commands[i].prefix , &next))
+				continue;
+			cmd =3D &commands[i];
+			break;
+		}
+		if (!cmd)
 			die("unknown command: %s", next);
=20
+		if (input.buf[strlen(cmd->prefix)] !=3D line_termination &&
+		    input.buf[strlen(cmd->prefix)] !=3D '\0' &&
+		    input.buf[strlen(cmd->prefix)] !=3D ' ')
+			die("%s: no separator after command", cmd->prefix);
+
+		next =3D cmd->fn(transaction, &input, next);
 		next++;
 	}
=20
--=20
2.26.0


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl57KjAACgkQVbJhu7ck
PpTUChAArtkOddnOAuhIuH14jtSHXag3Pp4mhglId2yDtYCDqXeIxx0pJUvcHZzZ
3mku4xzC5FpsHCOIgZYSKgpOYRV9IrX0j8QRBszpnAFGEnbh3xrZb3nU4ZzAPGbq
UZTq2cnOCUN9O9U3TlR5D6GfmH3aBQk+ctVj49U5lLrtVrCFmqEzt379KH9YxA8A
SxSiSMKbZ1V/NyW4P+xsqIsvof3JWxurR+ujHqqgLfwwNJi79AusSNHOeE8raccz
2busU65NC3ZdFHQYTMUUw0CuE1mALVcDuxNpPRCoiuUj6T5tKL4OalDf7QGTSzWf
NbXdQJDqNYocTu6dRllf62Y+m1MMviVA3MxUNRKjz18b2Lv9vHdaprtIJe/Gx8Vm
Mf3IvlG5HdbUhcn/pMgZEeJjNCrJL4AXNx11kRkEXvJO51E9QSQtqfOgUo1/iHhN
cciVt2rqu/oRh/b6s9OCVlwZQpj/9GqVPu+wSPX2eCyWxagBf/vlXVNaexFFrKX4
kzwnq8KnsOYr9qlcHaylCYMPyy+majfnMJwgY+4kgx9QNzpK4hTXWJJrAx4zqn1e
k1z62UCBLVyA1308ET6zH6B/jUL4y4bw2rzugjU2K0XjdumiDC82VNJv37soLs8V
Fw/1vloiwk39ymBSkW1/meXl2m3Y9Don39ztasM1HKBJOWiPSEQ=
=P3wB
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
