Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EB286D42
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054395; cv=none; b=N/X1GqkJ1X59KedBfZpOO04UW0xMsE2Ud1lDnL7062AHtbFK0DmxHy4kGqn/F6HFsdQ6w6BH+6PXhhhbpwlAklw53tOe4KgU0Jp36KBeOf0L7BYwZqDnqGlF+3dhZ4BcPonnVQ7BV2/FHREsovLHGsxQv1xVYvnNrMNAvdM+q0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054395; c=relaxed/simple;
	bh=KbqnfnCdjEbghD4JMDQWzBf5KcnzUFu7+lQsHgJVktI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AyfYx/D014eVpttWOLZy4Z+pSd53v9oCaEl+a8ytkntjkhORo5PHdyHGrVMpX+ddsKmRa7U60L/zUTCv+bWYjhHYnO4VPDQ9jlkpNehzgvF3OEBHV02cZLWwEbJWBrzKvThrdMgelBe/towwSuu7/VQQkK1b34SHK4v2fr3uqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=PGJ7dOYC; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="PGJ7dOYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752054389; x=1752659189; i=l.s.r@web.de;
	bh=Xr9iIEdwMsdPyQ7dbAx1t3iihjyUjobI46AZ2DCCr4U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PGJ7dOYC8UaF6ErZcua9hzuz+9NP+OVRvXe5haNdzNBX6pkVC67IEKnqlrZaZCg5
	 Bv7VNIzghhYYCoaPefcM2ZUha2eRxJiclgNegHLcPk0GIEJkHQ2s0nIJCS4VTwBin
	 gsT5IfuP5xy7THRKhpfAH6pRgo6QEpcBPK+5gPTZ6yVG75tvQGQ53bWpgr3ifBBdU
	 sqXU4cgBgGU/PxxL0F/SxNR7vkaF64QQbphgvuvRw2y3dVisDCOQinwGdn1Dmnx8t
	 EVSgpt4n79kdFDCM7L49akj6CCyyMwl/yfFtK6G25Bwr8ag64Faz/lbcIimK9dmxK
	 3aQbN07piN0G278rSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N01Zk-1utyrr0dc6-0146AZ; Wed, 09
 Jul 2025 11:46:29 +0200
Message-ID: <2f88dc74-e744-4b09-897a-522429f579b1@web.de>
Date: Wed, 9 Jul 2025 11:46:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 7/7] parse-options: add precision handling for
 OPTION_COUNTUP
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Language: en-US
In-Reply-To: <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k2KGeAYS9Fb8ZWckV8lImiH8mmnNf2bmLVwXzj1w8xXmVafhEWJ
 zTNTE+FBBLHVH6U5x0g1gRAhTtbZMYl0v6m3/2vF1O3pxGyLyPDe7KIh540dPyC6v/2mYHw
 IjO5D/qXmQ14DYyBXXfnDldCkfgXq4UWQDqs+QslTRSGRwBMry03W5c1GYr7QkbXHZTm3va
 5or6Pd7agLquABD7/5xvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1rWzNWP5BEg=;324E6exMmQhwCrKSCrMul2e4N9X
 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

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
index a813511b1b..5224203ffe 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -177,10 +177,22 @@ static enum parse_opt_result do_get_value(struct par=
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
+		intmax_t value =3D get_int_value(opt, flags);
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
@@ -651,10 +663,10 @@ static void parse_options_check(const struct option =
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
