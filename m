Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E34CB57
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810287; cv=none; b=hhU93yssxDNeJRc6aH1zzSURohmxgpNqZqt1mCR4qkoKdzI1oVgbx42KsJFa7NVpLYQiEbn2/0zXPri8p9jhn8wTao9X1A6BE5RMmCw4WQrfFe/OMEOIdiJnblf7WMlGHsab01eBOdfz5HN7W1jM2wt/X411A/tWwHKRrXXdSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810287; c=relaxed/simple;
	bh=I+y5jzEzysQcSA2yVOlY52+kmRTrscp/lyatL8IEBU4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AulqTY09xIc1U7tt33sS2lznZgfs0KHdL4QUBsooC4n6xe28hVL4j2UilY6Z74bftZ3YmaHlHv5URqtgRIcy/nPWMFz/87M61KEbvqONItbP6KeglEmxz0hBFz+OnlJIDUGmQKr218BGWa70Rc/axje9cl+Qb+ZgHn/lQrOZpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=rsFUQdOv; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rsFUQdOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708810278; x=1709415078; i=l.s.r@web.de;
	bh=I+y5jzEzysQcSA2yVOlY52+kmRTrscp/lyatL8IEBU4=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=rsFUQdOvwj3dvnIfZXzHXXPKehq6Kqw0SlDipv1GjYiQcA5oPwbC/z4uq3+eqJRn
	 idbzAxwRbA6gCZxfhFTRVQyEu0By0kzlhylkklr/5LuG8b99Ewf2HT4x+icN3fHRc
	 xB5SC7bLMS+SHOcDYusTOO6WGtC4dbPDy9XCv9YylQM4w8FCkeee/nVqc4DWW+cNi
	 a0Do4WFwvikRAmC2KK/GeOEezhh3K38FWVm4/gJm0oFYbfs+pYfpojdMbQQTSidq6
	 RNLn4CIZSqInCT0eRaF7E4OvGSg6t2UM3Y4abHzQLX1cFTJv70c4/NkdjStmOcZ3s
	 S32SSPVUWcxUiSRjIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MKM5z-1rKxze3eRz-00Lnvp for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:31:17
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 6/6] parse-options: rearrange long_name matching code
Date: Sat, 24 Feb 2024 22:29:53 +0100
Message-ID: <20240224212953.44026-7-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224212953.44026-1-l.s.r@web.de>
References: <20240224212953.44026-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YQNjp/9IqzV+UnH0DsZc28p5UE9yTkhl/G4JVQGKI+065bzzwZH
 H1DvR1ofQiFqNxN29/rnP1e4vc0ZPITx5q7m0071w6OW5BkWskfyf810Qb9WtwyQiH3XSMU
 h/LpAgSOinBxdh4SaF4MJGLZ63jyCOlhcbYpIRgTZ1ulr2CFvbkmoiCXeUg8ZB55o6wTxaq
 UChG/TaxReGU9YYW3Ytjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6bO9MtzmhmI=;z7R/VbJS3LhuO60e8x50gKyEHR7
 8kklFXQ3Dz0unVTNtz1SqN0vFezUkOH58z3aEntJB+Z3IhcBkQfle18pb41ZfvWTCp1DvLFwq
 JEX+ZX9vfWND5+BmuE5L8ZezDb4L75XmyRZxyCMxdaBEdRm0h3RsKyiUcidf04xwWmXIZkabG
 0DaP1x3iU/Bzny/yysz0YYO0cHz8TgMBoLquckSwdZl9mpmpnyVeBqaqpKjUmyDwSq262D73v
 TnIa27zdrC1bYW5vvr+FhaeZAqc0FgjfPdNFep5HKJomooHvkzC287u3TANkNyo2xxTRNLpJT
 qvbjSlcTqYkWDJccnksAx2IHPKxd4FXDghn2r4sCy7zy1q+h6SBqDNfKVuEXJ849njNaMCXRj
 Bih5O+Z3Lgug9Ccg/U/9aVJZAtvQzUkr9tNDY/2rexOTMUXYGV6iniji/PjVr20yLVtq7amz1
 uYKUBAuDo/dDg8hgJ6lCtofZbmL2WyQl0TdApT3hB2IvWUOSdQyO2Qn71Fu87NcR8TEYUlQJm
 qzEMeQ2Be5X5WusZkYrp2j66tWhBD1beWxLMDg5vHruCJX2fcO6UElxw+RWyfxtFltqnF+6ys
 YAGO5kOrx8yK8AZxUGua86b/gHEAVKHrBoMwuwPAfgYkoG6r4g1muNFwEXqFf+JOefaTmMKfy
 wxYLt9MwgdBC/N4fNrENUGpTnhi40QSrJapkvXMogrr8OWo8Nl+ILS/E0UxmDLx5F+cujZ04m
 oZQ7eZ8OBsGxRaFxcLDoZUORu1oFyhPhN1Jdnfutjq07Yf7nSE+tDxNUmsPjJxMwxT3TIaVYK
 2oaIfGPLNRZkp3zb2W+ECYb9QZegoOodND4yaJ4QIipVA=

Move the code for handling a full match of long_name first and get rid
of negations.  Reduce the indent of the code for matching abbreviations
and remove unnecessary curly braces.  Combine the checks for whether
negation is allowed and whether arg is "n", "no" or "no-" because they
belong together and avoid a continue statement.  The result is shorter,
more readable code.
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

