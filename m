Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C5BBE68
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468402; cv=none; b=XDXkgOuEvVfAS56nE+1Up8xDykacq88x7xQ13hgMWg4Rz667M03I2ATEip4kcouaH/ohgyh0YsCt4z7RJfZo1WkkIOV0pi1HyBi6CBX//9tUAYOTulA/5We1B9Lqgzk1QwXeazLZBt6dnXw9/fS8E89PXMvro3KXr/kf5cuIxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468402; c=relaxed/simple;
	bh=D2xLPR2ewtSWiGz6tI8zVvcPZLreB65lFxearMCyBrM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHdnhrkQXac2y27CMUpE49HbyaWeHfjbTdjp3sHdV1gALnpZP0clfd0DRW2cvpOo8BSRZWgl2EImXI2DhJFsCbeUJTfUis25Cnj1gs9YYfK3ShuDi3VT1FGLE0kTx+xh5E+xib1WPfQnX0N8byq0O5sCF/4VeT0qRbv6LysqDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=QOxqD2aV; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="QOxqD2aV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709468394; x=1710073194; i=l.s.r@web.de;
	bh=D2xLPR2ewtSWiGz6tI8zVvcPZLreB65lFxearMCyBrM=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=QOxqD2aVb4xW+H/WYa8TgBDyXp7yBwUmfqk/Z7wlyu4Ig63EsIKFpr2Y1f9/kidy
	 vyvcikdI/O1Zl7nhaNhKzrnRJaGBLEmZII6RLQQQf6NkorvXP3cRjmBQ6lKnxTUFU
	 WOW4q9Rc8cseovlWHUz9PMD9dTrAXxf4w3ZJ+GdfIp9F39RHKt4DlaB9y41Il2VmA
	 9/wXs3UAeQhq7GJMfJ+1yDM64HU7NIIrwwocK77h5w3eey+BxNAgbZHuCrMBGVR8Z
	 Brquy1arc9O8wpBnYMlBLVJ+J0h0B++XnQgEFeWF6g+yUMkA4NjvEAZgiu1mtf0Xh
	 1VtH6FkXtRk3oz4dWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MumNL-1qqqio46z5-00remr for <git@vger.kernel.org>; Sun, 03 Mar 2024 13:19:54
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH v2 6/6] parse-options: rearrange long_name matching code
Date: Sun,  3 Mar 2024 13:19:43 +0100
Message-ID: <20240303121944.20627-7-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303121944.20627-1-l.s.r@web.de>
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P7DRnYce/EJlAYB3jNlcvP2KODJyhj42And/hehqMPwHFL2wJvW
 F/1fd849hAUExkBZAD3dwU9cAn8JwIf+mZ3H7i+RQkquSWciKUXgTDRhxv4xA+BDPLam11E
 wWXNx1se+SBwAl6+wvoYJPIp92jRBVq6Q1Azqv3frGyZsadhAz6BRTLgGNQhmgtQIQG68B3
 N4B8u745V86lsqKRC0tNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6XKaCvrivbA=;9w7nqGShra/pMvfCWkqNmSW345Y
 zFyLD/mtFWMOGB4w3NZCr/3fYGc3l1KpscmQ45K/V9NFZV49gcELEwySnOOwjwEQGwRr9R/B6
 4uzbLXhhsmZaiqytLERha0DfkFRLAwMf0w88E+ngs9mE8Ec4Av+7Fg63cNeHUDH12pKUcFyzX
 4Z4qMxNuX2VRg9i8gxv6LAU/MSkg0tALSVciAw5OvmViNS4CD2+Li+2wJBemyb0c6Cxc1uISy
 wPihGw8WPOcj20FP0Y4yPOTe+U3xuz5rOKdKJO37JE9aPhxIRcFE5DwBLKz9lgngHajDwmSPE
 aqRmLlu/nyqK/DigXgbIgZeN6x9phquzRfXxWfA1BOd0K9JTZJLz8LErUU0KG1FWhEvJ+F8TQ
 VeSLox0k1a+4uGgfDQcO8S4in6BpYsUCvmomhb9fwLAWdYSCAY66/ozegQYYPCuNytFu0Hj91
 GDn7nRRrNpQkV9gPYJZk+Lqfo3MrGhIhSJ2iKiWeumbP7gq5u54vh9ecU9nVvWRiglaW/LWF0
 OzITAwva0NByQ/l2yvJIEcas+UkFEjknxGsblrmUrLE2Ex8QJkjP2WWS7i1PgIJ1b+GIP3faR
 d9lxB0OD03UnRNal2su3uJ7UXtN8XvYs/wHolWz+YzR+UzfQRTHvSxHeLhKGLEEaVoLsUOhhu
 RRvyTyzxCM0Z8oxaCs64KrQh1+on4VEi5WzPfbS+WDmTkKU89nZaGKMm4Bhu1y3FonJsi+Myw
 RoJEVRYKdWaNQHUltjOjK1jwwI/eQ5uLbGKBzgGowWWtJZ1FmhGNs9pu1uB47jrQYI6fM5594
 k1+75SYxcLtw3nRu5aEGOnB08J0i4IKcRe7zYpW0uuG4g=

Move the code for handling a full match of long_name first and get rid
of negations.  Reduce the indent of the code for matching abbreviations
and remove unnecessary curly braces.  Combine the checks for whether
negation is allowed and whether arg is "n", "no" or "no-" because they
belong together and avoid a continue statement.  The result is shorter,
more readable code.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d45efa4e5c..30b9e68f8a 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -413,30 +413,23 @@ static enum parse_opt_result parse_long_opt(
 		if (((flags ^ opt_flags) & OPT_UNSET) && !allow_unset)
 			continue;

-		if (!skip_prefix(arg_start, long_name, &rest))
-			rest =3D NULL;
-		if (!rest) {
-			/* abbreviated? */
-			if (!strncmp(long_name, arg_start, arg_end - arg_start)) {
-				register_abbrev(p, options, flags ^ opt_flags,
-						&abbrev, &ambiguous);
-			}
-			/* negation allowed? */
-			if (options->flags & PARSE_OPT_NONEG)
+		if (skip_prefix(arg_start, long_name, &rest)) {
+			if (*rest =3D=3D '=3D')
+				p->opt =3D rest + 1;
+			else if (*rest)
 				continue;
-			/* negated and abbreviated very much? */
-			if (starts_with("no-", arg)) {
-				register_abbrev(p, options, OPT_UNSET ^ opt_flags,
-						&abbrev, &ambiguous);
-			}
-			continue;
+			return get_value(p, options, flags ^ opt_flags);
 		}
-		if (*rest) {
-			if (*rest !=3D '=3D')
-				continue;
-			p->opt =3D rest + 1;
-		}
-		return get_value(p, options, flags ^ opt_flags);
+
+		/* abbreviated? */
+		if (!strncmp(long_name, arg_start, arg_end - arg_start))
+			register_abbrev(p, options, flags ^ opt_flags,
+					&abbrev, &ambiguous);
+
+		/* negated and abbreviated very much? */
+		if (allow_unset && starts_with("no-", arg))
+			register_abbrev(p, options, OPT_UNSET ^ opt_flags,
+					&abbrev, &ambiguous);
 	}

 	if (disallow_abbreviated_options && (ambiguous.option || abbrev.option))
=2D-
2.44.0

