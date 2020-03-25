Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FA3C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901E120772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZPezLTte";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oEzl1u3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgCYJyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:54:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40403 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgCYJyK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Mar 2020 05:54:10 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BD5A55C0227;
        Wed, 25 Mar 2020 05:54:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 05:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=E3pORn4g+20avaF/z39bVQaTeHZ
        /UXiNAg6fm9aH54E=; b=ZPezLTteraKifHRyLlFiEArpQ25QTngQQ1gJZLPqrx6
        ugjSlGyQVA8t6lSfsMOLfbFJZP8ij9A8ll+GxWJ925elfKNYXwrbDyJwUnB8U6YB
        7Q1WBk3djNexv+cVlB2RAGIEPxwFn8sKq6JRIyuUqZnNYX3QO2f8XsPlR/pMg4SA
        Cu9fY+t/0rKZmO1jcMJbrb/XCZZD4yXajMdcASWAmxcue+QCHMgEPL87ljBcv2I9
        YHd0CCqI2fibPTNYur5aicSXobULGmr4Yhr/MjSVy8U4NlhAosFACk+z53+1iuvx
        D+W+qJA//1TgOdWaE8beGCDbgVhFnxgQAfnQtaDUJ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=E3pORn
        4g+20avaF/z39bVQaTeHZ/UXiNAg6fm9aH54E=; b=oEzl1u3KlCZK+shIU66E8V
        H9I5Tqt9Pycd6DSNCv0upg1pFJE9SSXHeLJTM5gnmxT2rWwIvgyoSvWJx7DCysF2
        9Sglpare5+vwE/YewrF98nfwIguPHClz/p/MYkzxeMyZRsOzKdY3/TYum3ZbYNsz
        MkHdd4bsNRQqpoKpBDMYtm5K5pQbx7tVtOrBFthR9EJ7GxNaez//9OZ/cDxz78V2
        jhBWcOJHtKQhyUAZI+JGou4STrSBgdgacFLzBL2YMs8X0msinnLTNk929D9j6CiS
        diQazGh3aSSR68TkKCItaIUeGYWnx0tjP91qOanjrRkerWh44VEvYzTP/NBv/5Cw
        ==
X-ME-Sender: <xms:QCp7XpEOVqA-X1-eD9MQhng3o9BvO-x9zJvlmdA35nT_KMNuLqRKaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddufe
    drudekhedrjedvnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QCp7XtOg1sT6vQgFpjRTGGvWZkTn1_MJ2zEi-ksEHPi_uJTkRPI-pQ>
    <xmx:QCp7XriX2sWRsOzHtDp67aR4Z1sWmci4IQSWEiS_Q59TP8tJuhO3qw>
    <xmx:QCp7XkHyRjurXoPoQr7049x1iiyf3VDbapufOvn82Z6xHZCYtWkWVg>
    <xmx:QCp7XlrPx-j9i1DUU4VIHwwiQ-CmHmvo8mWDUES0_IPbxCj-zvH01g>
Received: from vm-mail.pks.im (x4d0db948.dyn.telefonica.de [77.13.185.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id 26CF7328005A;
        Wed, 25 Mar 2020 05:54:08 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8862f0ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Mar 2020 09:54:07 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:54:09 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 6/9] update-ref: pass end pointer instead of strbuf
Message-ID: <51ebb2f8496641380aed4810fa0bb7ebc3bc0a99.1585129842.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <cover.1585129842.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9amGYk9869ThD9tj
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
index 6f4e8e88c1..6f036ae765 100644
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
 } commands[] =3D {
 	{ "update", parse_cmd_update },
 	{ "create", parse_cmd_create },
@@ -378,7 +378,7 @@ static void update_refs_stdin(struct ref_transaction *t=
ransaction)
 		    input.buf[strlen(cmd->prefix)] !=3D ' ')
 			die("%s: no separator after command", cmd->prefix);
=20
-		next =3D cmd->fn(transaction, &input, next);
+		next =3D cmd->fn(transaction, next, input.buf + input.len);
 		next++;
 	}
=20
--=20
2.26.0


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl57Kj4ACgkQVbJhu7ck
PpQTxRAAgN/xZZdz4C7z0C7Lu/Nf3aHaKG3meDyRlhdhhoI8OV/zlSmqpn46Fu1u
ek9qoRb72hqNDgygJ/w28Ioz3qIl8+QtdaK0L0aSwxdpttExL8HSqBBBkmwqvxwr
bWk49gNij7XLBqGHuQw7j4hTEggEtdG8gf1WTJpyZyePCJRjCF8kev268sKSqGua
mr1o6e260+Xhd8MGLIlQPUKQZHh9K069iE9qmgEQ9YNlpMsbgNDIRYRBUbr4WCd0
ehziKsMUdEfRME0kFexcmLbLfFBj17Q2nUeG/Rr5pAh6VHM7Tv919O+PRDKkGJju
4Nnn/ybMqwte9um6Z4tVfRLIhJeJPztcJWK6vE6RMe8bAfgO08TmciaKNTyb+fl3
vIDHZqGalS7kh0bQZowmglv7F7adFEwGh/HaUws2RnpwaxZkmxZXQfjHvAorxqyY
o7Sdr+lk60b4d2LkrQACjoK6P4ZHSeJMV7ubohgQoHFUtCbw4sfiDNszJlo1GK0s
ZS0+I8ZIptDC4l51viNQ2hO4ESFW+z3cKPQyv6Prw6Z116HFaWoNzWI8kH+xoQWL
X1HLQ/4Ldrm3BmzfIbsF2fxUA/7awak4B7F5jKW3idlDDPm3B+ULO5NZ+y2nx+6C
MxUr3pexs9sG/530jIdcchuYtCRlyV+c53O7wvyRldllzOBNZ88=
=kfig
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
