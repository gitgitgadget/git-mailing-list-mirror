Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071101E89C
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766828098; cv=none; b=kJpvaEPkfgdTVHkofX8CCXkXVqYg+/CtmHjKOe2zKd6arpGzlKvB+Dez5QFfM7PnLPeWWgHlZkUOshXJBnRmrzt0QrEgLKVbjKok+KCL3dV/8bwPNU5D1EZg3bXnhg1haZGZjokHSxz3ekH+IH3AfLUTSIygHiViTPfMYNJm4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766828098; c=relaxed/simple;
	bh=rSlWu39QwZQs1GlRefAKS4HbmU4DUF9o4pGyca+6po0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XH2QJvfaFPM0B63Kqui3XR4TUYC6Fsnh6GfT6t9yewisI0jx7tU3hon7OZLiq5BZC3rG3ZIaB+jd0dbSQZqBAmc0KBjKTFShjxM3wdi61l8nKKXaFww7A0mRwegATiQ5VLvX3grv4XwPhyEGhmysxHuhuQGj3lXZqHN9sXd7nGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EUnyr1jY; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EUnyr1jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766828088; x=1767432888; i=l.s.r@web.de;
	bh=Mzl2Y0MTLCv2f7rLdN6KGoaITN1t2tKqgfnSB/b2y40=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EUnyr1jYYdCLgrOn/n9woEP8UOSZTesnOz+bU0H+pp0rhkVffotYPggkNEza+ao+
	 H0RsGPZ6gAzKK5j132nDhevRTApjowAvaOh7ktNZe5RXk5RGdt7LvGdFiZcDLxmzo
	 Lc9sqYOBEwsLF+mzx6ESIFYBIz+Xzkx9q4dBup9/7L+KGjUi3rLmwfLRQMs4TjXVs
	 uKF3viWqwnht80CFbH1MQrYuQVFctao9s0E/vjsSiRoCqrbZguINWxCBtF/tdzCwK
	 /9+eicmjtLU9UjqVEmKRWyiISVKGbiW5v/Z8nbBYKOU+d6fcfN3HJyWUkfLzzxHPU
	 uNF5CBFD/JNdD3tFTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.205]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1vilMU09ny-006y3m for
 <git@vger.kernel.org>; Sat, 27 Dec 2025 10:29:36 +0100
Message-ID: <1bd3c7f3-fcf6-4d8e-aa38-c15e3d51ce4c@web.de>
Date: Sat, 27 Dec 2025 10:29:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] config: use git_parse_int() in
 git_config_get_expiry_in_days()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3kNUUlNu3Sxm0YcR0awi5Nm6OATIE/au2fCaWk4JIwK1J+1jEZc
 gLyj3RgxwClAxax93kyxYy2vnAzOMD4/w3zFfd02esvOISuE7eoJJvlO8ODVoZQh5BfEaNm
 5R3vBMTQlM3jdFAVOla8HdfDlCYX+ADUDVQmhMo1tWlzXzWKTYykOQga0HOJNLNCrmXSvqA
 pJesD2wzAMfK5ooDIlmcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8NqJEMZGKvQ=;2V/NoarEtW9hWLhOc2Lhh2id11l
 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
 qxEU/Z3I57O0YvDxk=

git_config_get_expiry_in_days() calls git_parse_signed() with the
maximum value of int, which is equivalent to calling git_parse_int().
Do that instead, as its shorter and clearer.

This requires demoting "days" to int to match.  Promote "scale" to
intmax_t in turn to arrive at the same result when multiplying them.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch formatted with --function-context for easier review.

 config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 1738c0cb0d..7f6d53b473 100644
=2D-- a/config.c
+++ b/config.c
@@ -2434,22 +2434,22 @@ int repo_config_get_expiry(struct repository *r, c=
onst char *key, char **output)
 int repo_config_get_expiry_in_days(struct repository *r, const char *key,
 				   timestamp_t *expiry, timestamp_t now)
 {
 	const char *expiry_string;
-	intmax_t days;
+	int days;
 	timestamp_t when;
=20
 	if (repo_config_get_string_tmp(r, key, &expiry_string))
 		return 1; /* no such thing */
=20
-	if (git_parse_signed(expiry_string, &days, maximum_signed_value_of_type(=
int))) {
-		const int scale =3D 86400;
+	if (git_parse_int(expiry_string, &days)) {
+		const intmax_t scale =3D 86400;
 		*expiry =3D now - days * scale;
 		return 0;
 	}
=20
 	if (!parse_expiry_date(expiry_string, &when)) {
 		*expiry =3D when;
 		return 0;
 	}
 	return -1; /* thing exists but cannot be parsed */
 }
=2D-=20
2.52.0
