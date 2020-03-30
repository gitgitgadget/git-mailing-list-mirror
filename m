Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064A6C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2002073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c9acE2Ed";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UeDpk2UF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgC3Nq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:46:59 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:52871 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727954AbgC3Nq6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:46:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D30FE574;
        Mon, 30 Mar 2020 09:46:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=0pFPLNib2Yy1XpwBHY2APRcUkux
        UcyhbtXEO6q10LaA=; b=c9acE2Ed2fqJGW476QENhObKbciKT6I+iuabUqtx87/
        /eyRzkGnpoGEa5mB3cTHoMTWY165lQjvP5aDx3z8BaJiMN9MKcB2y1jAgpiC/irh
        5Q0ghaIvifO8rfE3fQVc8BAf9IMc/SvnM0FBMZPSoRDvCkO2x0Zr38i48q7c7GWl
        3t9/3I2sX7x/VpGOHyN8HSOj2CW4MFXy3CUq2cSYQwCzj4i9ezdPxtmsmdW+wYnE
        FndEOq/pMCA8j6qUvsNmZuDLqlMmXP8yETBBOoZh18jIgWYHo9Pabuf02grrq/42
        zBvNx4eHcSa+W9/oJ/E1INI/gAaX1Tknfg2K2M9xkAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0pFPLN
        ib2Yy1XpwBHY2APRcUkuxUcyhbtXEO6q10LaA=; b=UeDpk2UFP7U8PWO2IAzsQ5
        zFXi1czfVwlOsW6iSG+DaM1rvbCO4N+KSMS0g+J3sCutBvDjMfbVDjMpV12womD9
        1stLZi9c3C+/IBpPLdSlzlHB8wVeX7o+UshYN9ta6ciz12evq+NbnZ7OHWL3wehR
        FHABXaPhvBHk0O+R2mk0rsKT3/HG5N255tVSsJC98Yq5YGz14aWDnJxdC8ioB2yM
        53pv+eeUVZqP02FgOU13suHTKC2lG0KPvjr3+0I+Hk10+tcc9TQlG/1P0Q6g83mw
        2yF8oSWKvgWlag7azHApxdzaSRGp+Pza6KGZykC/KgRrwRuEOEm1Ow30wrP+gC5A
        ==
X-ME-Sender: <xms:UfiBXuuXGVKgXfXeFWcKa15JPcftct8AbyBT080y8Ni1yCGk60F1HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:UfiBXmy_mMDb0V8TSlmJ8ThmxEuzZpx4UyrI7c_yKQI8Ob1KpIUUuw>
    <xmx:UfiBXt0yzGoPugRXOkdy-JY4fE2UUozBWpxWZUXeciia_ELxbS_Q_w>
    <xmx:UfiBXvl_L63qet5MsUCV3ppMUjfg5SSZ5WM8j2DXpIpVZpSt3RBylg>
    <xmx:UfiBXiYigC-4boGa6cNJqUCz8kuNaxqeENY8sxg4SjqOixV7l1ebVA>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id C361C328005A;
        Mon, 30 Mar 2020 09:46:56 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0dc33be9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:46:55 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:46:59 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/9] update-ref: read commands in a line-wise fashion
Message-ID: <f8786fdeb351a60bb83ac64cf5a1cbc34c73e2e3.1585575749.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585575749.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <cover.1585575749.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-update-ref(1) supports a `--stdin` mode that allows it to read
all reference updates from standard input. This is mainly used to allow
for atomic reference updates that are all or nothing, so that either all
references will get updated or none.

Currently, git-update-ref(1) reads all commands as a single block of up
to 1000 characters and only starts processing after stdin gets closed.
This is less flexible than one might wish for, as it doesn't really
allow for longer-lived transactions and doesn't allow any verification
without committing everything. E.g. one may imagine the following
exchange:

    > start
    < start: ok
    > update refs/heads/master $NEWOID1 $OLDOID1
    > update refs/heads/branch $NEWOID2 $OLDOID2
    > prepare
    < prepare: ok
    > commit
    < commit: ok

When reading all input as a whole block, the above interactive protocol
is obviously impossible to achieve. But by converting the command to
read commands linewise, we can make it more interactive than before.

Obviously, the linewise interface is only a first step in making
git-update-ref(1) work in a more transaction-oriented way. Missing is
most importantly support for transactional commands that manage the
current transaction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 80 +++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1a7906545d..77cd235dfc 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -178,8 +178,8 @@ static int parse_next_oid(const char **next, const char=
 *end,
  * line_termination is set.
  */
=20
-static const char *parse_cmd_update(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_update(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -212,12 +212,10 @@ static const char *parse_cmd_update(struct ref_transa=
ction *transaction,
 	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
-
-	return next;
 }
=20
-static const char *parse_cmd_create(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_create(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -247,12 +245,10 @@ static const char *parse_cmd_create(struct ref_transa=
ction *transaction,
 	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
-
-	return next;
 }
=20
-static const char *parse_cmd_delete(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_delete(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -286,12 +282,10 @@ static const char *parse_cmd_delete(struct ref_transa=
ction *transaction,
 	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
-
-	return next;
 }
=20
-static const char *parse_cmd_verify(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_verify(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	struct strbuf err =3D STRBUF_INIT;
 	char *refname;
@@ -318,12 +312,10 @@ static const char *parse_cmd_verify(struct ref_transa=
ction *transaction,
 	update_flags =3D default_flags;
 	free(refname);
 	strbuf_release(&err);
-
-	return next;
 }
=20
-static const char *parse_cmd_option(struct ref_transaction *transaction,
-				    const char *next, const char *end)
+static void parse_cmd_option(struct ref_transaction *transaction,
+			     const char *next, const char *end)
 {
 	const char *rest;
 	if (!skip_prefix(next, " ", &next))
@@ -332,48 +324,49 @@ static const char *parse_cmd_option(struct ref_transa=
ction *transaction,
 		update_flags |=3D REF_NO_DEREF;
 	else
 		die("option unknown: %s", next);
-	return rest;
 }
=20
 static const struct parse_cmd {
 	const char *prefix;
-	const char *(*fn)(struct ref_transaction *, const char *, const char *);
+	void (*fn)(struct ref_transaction *, const char *, const char *);
+	/*
+	 * If using NUL-terminated format, only the first argument will be
+	 * available in the first line. In case a command expects more than one
+	 * argument, we thus have to fetch an additional `extra_lines` number
+	 * of lines.
+	 */
+	unsigned extra_lines;
 } command[] =3D {
-	{ "update", parse_cmd_update },
-	{ "create", parse_cmd_create },
-	{ "delete", parse_cmd_delete },
-	{ "verify", parse_cmd_verify },
-	{ "option", parse_cmd_option },
+	{ "update", parse_cmd_update, 2 },
+	{ "create", parse_cmd_create, 1 },
+	{ "delete", parse_cmd_delete, 1 },
+	{ "verify", parse_cmd_verify, 1 },
+	{ "option", parse_cmd_option, 0 },
 };
=20
 static void update_refs_stdin(void)
 {
 	struct strbuf input =3D STRBUF_INIT, err =3D STRBUF_INIT;
 	struct ref_transaction *transaction;
-	const char *next;
-	int i;
-
-	if (strbuf_read(&input, 0, 1000) < 0)
-		die_errno("could not read from stdin");
-	next =3D input.buf;
+	int i, j;
=20
 	transaction =3D ref_transaction_begin(&err);
 	if (!transaction)
 		die("%s", err.buf);
=20
 	/* Read each line dispatch its command */
-	while (next < input.buf + input.len) {
+	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
 		const struct parse_cmd *cmd =3D NULL;
=20
-		if (*next =3D=3D line_termination)
+		if (*input.buf =3D=3D line_termination)
 			die("empty command in input");
-		else if (isspace(*next))
-			die("whitespace before command: %s", next);
+		else if (isspace(*input.buf))
+			die("whitespace before command: %s", input.buf);
=20
 		for (i =3D 0; i < ARRAY_SIZE(command); i++) {
 			const char *prefix =3D command[i].prefix;
=20
-			if (!skip_prefix(next, prefix, &next))
+			if (!starts_with(input.buf, prefix))
 				continue;
=20
 			/*
@@ -389,10 +382,19 @@ static void update_refs_stdin(void)
 			break;
 		}
 		if (!cmd)
-			die("unknown command: %s", next);
+			die("unknown command: %s", input.buf);
=20
-		next =3D cmd->fn(transaction, next, input.buf + input.len);
-		next++;
+		/*
+		 * Read extra lines if NUL-terminated. Do not raise an error in
+		 * case there is an early EOF to let the command handle missing
+		 * arguments with a proper error message.
+		 */
+		for (j =3D 0; line_termination =3D=3D '\0' && j < cmd->extra_lines; j++)
+			if (strbuf_appendwholeline(&input, stdin, line_termination))
+				break;
+
+		cmd->fn(transaction, input.buf + strlen(cmd->prefix),
+			input.buf + input.len);
 	}
=20
 	if (ref_transaction_commit(transaction, &err))
--=20
2.26.0


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B+FAACgkQVbJhu7ck
PpTTMg//VDnlxMZPcj9BFHdTldyohbWXgSuC+O+56+jkgGy4ETv4vfAtBvJSATSl
TRaGjuwJ2/rnQAm80rPQ1B1geC6qNbjy6Jr0K9ENrw8lmFJyLQLS48IUSIw1eBO6
SSuRxjLeddgAjiYqCtXvT1L5nlwwck6cWb3D+sfRd0COmbboa7yOl9O9SUnf54WF
Om2buRRO0nxNTqhysVMk0WRtDORT3ufutal4hoozY0fmvVluzvHNLMpo36rJwxDi
U1WZiDguX30cI+JSePwgpq8z3EpG/aCQ8uY4XDdoWjDOQ19iEqnSguTIq/M+sucu
NMy/Egaj8gbik3OZoO5IuOiZYi8ncaXc5Gb0vJ0chsypbUN9d3MEnYTemrucLpOT
EJkFw/RdynR2d0Nv5rmmrtJMSI676PsMvWDcEi6TopbRjzxJfrsHlfjOaNlm/XLW
GQ9DNws0hNKfyhKyXvIcJ2J3jkjCR8DalKAJAMAdLs/sQU4q6SJcA0eLJFdp4FQa
p/Bq+akW/XvRXf3xSrjmrbb/Ownwr9o5TLKZGYx/Yy34GfeWtuvHWZM0aWuxrucw
kHbRwSqokgHoGwV1TrmTQLgqacQecl9HE2IEnelhG5a75X0tOVQyn1qBrLP2lH6g
eCST0jk5UnaKDIqepXfmRXSGaj5+bPNRZYNLQ7yCjyrywaNBALs=
=UQJd
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
