Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2963F2192FA
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197901; cv=none; b=N/bXQF0XbEtPDLc0eE2ov4cbqsiUF/t6XRVQUzIrpm3Tck/LXXm6L/gxponcAQM5nW5w4DS2qqKSkrUcAmtK2/uUQagMHHnWIrl6C+nichXL3cMHTuhoWJx96z22ffry+fgAS2rD5wm0PqP6LWPlqCkBx1csomwgysjp43//MNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197901; c=relaxed/simple;
	bh=agSgxNTScR65E7wEwD+k/n5vdPoNiSw+2Rygj5H/xG4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o3JdDf3t1AFbBE+/SHi+fPlTaEV6l7lMhHAkxlj+5vAp+ZWnBZtzlfsDktu+Cih8E5Z/ruJS3XLljWIBpYejliqqbtBEP+kRIfJ4PwevsVSWeqdNjgmMj/HdlI+n9ZnwX+BPM3SyiGFk/4aKt4RvUEhPTkrJI53RouOnb5UiEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NVypC8J5; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NVypC8J5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751197897; x=1751802697; i=l.s.r@web.de;
	bh=NUt+V1G4LJxexqERo6olF3O0tTraKf7Vx7bcame8bIM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NVypC8J5Oc5baMMDVFcm73VZtM2r9QoEM2SZieeoxylBLNibmTGWjKar4DdmCsTV
	 /87M6uiLcqJsCoJLqQWUoq5CkYzlR0r3CQXsobL6XeVGM6CTX9NVC+5cy3Nwe/Jz1
	 yrHYeXm7ezMYIlmvmEuVcNgCLWl0qd5c6iUF+mMme0zCQpS1mLHLzUkqKKnoxz/Hc
	 YFC6nUbJaak1+k9+CEQRSBfQrIOMvrAUsqUwCWR5Uqk9Ou//bVIna9nYdlZSxBx/h
	 b5kBohZjDwRbnEah8/uOzySuevyyOjm8x1K+EZtFhKy4g/Q8Kury46Y7RJBgwDhJM
	 CUojisKs153jWOC7rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QqN-1uWg3A0t8v-009oVJ; Sun, 29
 Jun 2025 13:51:37 +0200
Message-ID: <7322758a-9310-4892-b476-50dc57d559b4@web.de>
Date: Sun, 29 Jun 2025 13:51:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6/6] parse-options: add precision handling for OPTION_COUNTUP
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Language: en-US
In-Reply-To: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0DPuvMDzgDWJ3vm8SbdwKUIm2JYG5+/vy0soT0kNqFRlOR/d4EC
 spprLVwYftOA/y1hZmJfAEUAH/k+xWsdpJ7jZ4TJbHh1EiuAvsU4vY+4qHLka0MrybLNfPp
 eGWt66uYDWF/0SZGruS7ClbefUH5OPLex9TVs4MHBXil6YBvG+0MenshKOctbozN9J2bFdB
 ykE9IP8JqQgm1GbPW0VzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WhbbHED46/Y=;a+MuVN88myBXGuCUS7tcUUjrIIl
 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
 bnhAJG9BygyOmgUxfIgy+es=

Similar to 09705696f7 (parse-options: introduce precision handling for
`OPTION_INTEGER`, 2025-04-17) support value variables of different sizes
for OPTION_COUNTUP.  Do that by requiring their "precision" to be set,
casting their "value" pointer accordingly and checking whether the value
fits.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c               | 22 +++++++++++++++++-----
 parse-options.h               |  1 +
 t/helper/test-parse-options.c |  3 +++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 0dc9b0324a..0dd08a3a77 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -166,10 +166,22 @@ static enum parse_opt_result do_get_value(struct par=
se_opt_ctx_t *p,
 	}
=20
 	case OPTION_COUNTUP:
-		if (*(int *)opt->value < 0)
-			*(int *)opt->value =3D 0;
-		*(int *)opt->value =3D unset ? 0 : *(int *)opt->value + 1;
-		return 0;
+	{
+		size_t bits =3D CHAR_BIT * opt->precision;
+		intmax_t upper_bound =3D INTMAX_MAX >> (bitsizeof(intmax_t) - bits);
+		intmax_t value =3D get_int_value(opt);
+
+		if (value < 0)
+			value =3D 0;
+		if (unset)
+			value =3D 0;
+		else if (value < upper_bound)
+			value++;
+		else
+			return error(_("value for %s exceeds %"PRIdMAX),
+				     optname(opt, flags), upper_bound);
+		return set_int_value(opt, flags, value);
+	}
=20
 	case OPTION_SET_INT:
 		return set_int_value(opt, flags, unset ? 0 : opt->defval);
@@ -630,10 +642,10 @@ static void parse_options_check(const struct option =
*opts)
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
 		case OPTION_BITOP:
+		case OPTION_COUNTUP:
 			if (!signed_int_fits(opts->defval, opts->precision))
 				optbug(opts, "has invalid defval");
 			/* fallthru */
-		case OPTION_COUNTUP:
 		case OPTION_NUMBER:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
diff --git a/parse-options.h b/parse-options.h
index 8bdf469ae9..312045604d 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -183,6 +183,7 @@ struct option {
 	.short_name =3D (s), \
 	.long_name =3D (l), \
 	.value =3D (v), \
+	.precision =3D sizeof(*v), \
 	.help =3D (h), \
 	.flags =3D PARSE_OPT_NOARG|(f), \
 }
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 2ba2546d70..68579d83f3 100644
=2D-- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -178,6 +178,7 @@ int cmd__parse_options(int argc, const char **argv)
 			.type =3D OPTION_COUNTUP,
 			.short_name =3D '+',
 			.value =3D &boolean,
+			.precision =3D sizeof(boolean),
 			.help =3D "same as -b",
 			.flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
 		},
@@ -185,6 +186,7 @@ int cmd__parse_options(int argc, const char **argv)
 			.type =3D OPTION_COUNTUP,
 			.long_name =3D "ambiguous",
 			.value =3D &ambiguous,
+			.precision =3D sizeof(ambiguous),
 			.help =3D "positive ambiguity",
 			.flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 		},
@@ -192,6 +194,7 @@ int cmd__parse_options(int argc, const char **argv)
 			.type =3D OPTION_COUNTUP,
 			.long_name =3D "no-ambiguous",
 			.value =3D &ambiguous,
+			.precision =3D sizeof(ambiguous),
 			.help =3D "negative ambiguity",
 			.flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 		},
=2D-=20
2.50.0
