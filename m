Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E79C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F224E20784
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aW3KugoF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XEmbdwRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgDBHJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:35 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47495 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387447AbgDBHJf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 03:09:35 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 291B25C0281;
        Thu,  2 Apr 2020 03:09:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 03:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=yM9X7I4cWYrAHEkC6K+XmEnQGrD
        DWu/uule9ZBR7Oa8=; b=aW3KugoFs6DJDM0IFJPCGwAciiU66LWyGHmLKO8MJWv
        /pU/WcpP9at/SS3BwFTFy0XnQZqQwxIWi3omtUngq5TJqI098w3bWYEobj53z94C
        CcdaYTFPGzjQpLDxm+iwe596dOCdnYKAZv76QXqeb3etoYim2HxjQog8jikPi/rm
        b4QY1cUwg4384yZwIt4qwIJRwrl/Hn/TwI9bYu8f+PxaHjlgs0jKvnNx5G/Rl5RI
        SSW/p/INJsQEY6YrEZQUdOVFNFMl2zgjAL/e8AT3zJePu+BzPHliqxKlHueJYfga
        tRqzatGsco33Fq6DjtAMPVqUfpwz8ymZsGvsFwrKJgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yM9X7I
        4cWYrAHEkC6K+XmEnQGrDDWu/uule9ZBR7Oa8=; b=XEmbdwReoZubDZJ66/E2Er
        VZXgf8v1yv77bfxid8/hvMKseo+jUdkvTCuzk/3XBBmjLOCpo+3NeAcWr2OuNfEv
        yT0ejOdtUlZpRCwnEWpV6UQcUdh6nPukVWhcxLo10dpRUi71q6P1/aZb4HXq2h7q
        U4d9xVR91dl+pe3Rh9OpKuYIBJ0yU7z3iSJ69Zv3+Wj1YJ1wyuudAVORdkAgZ4U0
        ljqWPWLJGynT1V61cqBsCsKXs92YoKpSDEP3gQG2z+Pdhyg+mrN/DOiP4VFTjyvB
        WuBm2txQqS07qofTGByyEMZc69m2uc3o/AwbkjCVzu9YiTcW1KAIk3z3w54yRRtw
        ==
X-ME-Sender: <xms:ro-FXvLd-euYGnI0OUIK4Z7bzAnuN-WAr-vUvZCamZXPUaqw2bQtAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvd
    drleegrddvkeenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ro-FXjsS1L3Uqb4ChKpCz-GmMu-PUo50dy1BTNp-E6fLQYYyYftWcw>
    <xmx:ro-FXgn0sqxed9qAYlP5y2NtlSGXC0lZtMKgH2ie34e64pF2lcJsuQ>
    <xmx:ro-FXilKCD4_WcuiB0DA_MpAiJ0ae3A2JRw9xSEgAD7yEKh4DxCvug>
    <xmx:ro-FXjldvBR6AoIw-7zUhDzkTmqUbbsSvEqwFiSGmZdGavdfyJvnaA>
Received: from vm-mail.pks.im (x590c5e1c.dyn.telefonica.de [89.12.94.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F973306CD75;
        Thu,  2 Apr 2020 03:09:33 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e063f603 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 2 Apr 2020 07:09:31 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:09:38 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/9] update-ref: organize commands in an array
Message-ID: <0f881d49366fe9d9806b08af35319475ca07abc3.1585811013.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <cover.1585811013.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vkogqOf2sHV7VnPd
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
 builtin/update-ref.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2d8f7f0578..a6ff88b95b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -310,7 +310,8 @@ static const char *parse_cmd_verify(struct ref_transact=
ion *transaction,
 	return next;
 }
=20
-static const char *parse_cmd_option(struct strbuf *input, const char *next)
+static const char *parse_cmd_option(struct ref_transaction *transaction,
+				    struct strbuf *input, const char *next)
 {
 	const char *rest;
 	if (skip_prefix(next, "no-deref", &rest) && *rest =3D=3D line_termination)
@@ -320,33 +321,49 @@ static const char *parse_cmd_option(struct strbuf *in=
put, const char *next)
 	return rest;
 }
=20
+static const struct parse_cmd {
+	const char *prefix;
+	const char *(*fn)(struct ref_transaction *, struct strbuf *, const char *=
);
+} command[] =3D {
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
+		for (i =3D 0; i < ARRAY_SIZE(command); i++) {
+			const char *prefix =3D command[i].prefix;
+
+			if (!skip_prefix(next, prefix, &next) ||
+			    !skip_prefix(next, " ", &next))
+				continue;
+
+			cmd =3D &command[i];
+			break;
+		}
+		if (!cmd)
 			die("unknown command: %s", next);
=20
+		next =3D cmd->fn(transaction, &input, next);
 		next++;
 	}
=20
--=20
2.26.0


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Fj7EACgkQVbJhu7ck
PpTOKw//dOBu9PFuATcjHAk3G2sLp2NZzokJBeE3ZDKLpfmtZXY+QyEWp+/Zd4LV
7X+FCr7o8lJylNeaTDxamGgDpksHYQYahOPhj89VeHJG2Tiu8xr86wFXNQZKWzeQ
JfZr9N57XrDUC7WIHJYKAj40DG6lG66tc7o6hXkSaKUJ9wW+6EfEeojGA/a9UgK9
gm+ldfxme4VJQhcstzQddT8DTDB46JAaPMdY6ZImT+YU7Zxa0I8GDlvlBcG9oUYt
EnOwkLPjpohDm9R03pYrGwnNOc0zB5ycHHIPkiQly04mxM78jEumtfRGzFlCURd1
mIvPh2+Ofdd8v28s7sKGyczU+tgYx+5FmlC5tnpZMi1a+fnaYuJTRlNc2ZldD7hz
g8njfcgKMW/SkQDO9ZvBxnisog6X/J1xwFoo0grs0tGbyKzvOJonxyomE6VbO1df
+hfCVXG+fZgKiozNoqbULACFMbUAZq120wLpHqHKc6T4I4bghWlviMbytJziHMk9
eXL91Q2zqyPqkVDWtlAzi3v/1lMc9CBe9mnfUENSH0TNEjoeMHpirV1+179wlz0u
CoVyj3jHrWWAr8zatVjbuZ/CQopyTzkraABdq0SWtEXxwj3oOqQu7ulWXiY98+8z
3GiYB+u/YbD5V63qayrKSn3rLBgMvsXogeWoNsomQnqXRBvq4t0=
=7Fdf
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
