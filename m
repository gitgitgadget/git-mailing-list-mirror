Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563F4CB36
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810289; cv=none; b=spuzO43zmHfrFR3oHs4uqT0Ifsh/zFk4D+ulsuPVxOJfORyYpNO5EPu2FP9xLBBVlm0PnfjZXnF743IxBipCBu3+jiIyHJuIz4j03cC2JcnTn55nKAGHfMjkcCFvkUVg3TQkp1laBwwBuqfudgDNZK4jQP1ReI4cvU07uCk86uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810289; c=relaxed/simple;
	bh=qsCjhrq09PqPIg6oOqOWS6me1VmgzooH+hnge3m5Fmw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9ZDlwLko7/q90sT2Ki0MP/lMR9xbrJ4VTx9Uw25r/x8R/xMPMNIUpQW1JyHkigI62Q1tSMrM1FbUPckqHWUAJIALAjQTWB1LcoMeFyYrvuGfStF79zeJzmTsnTccodatNv2nQeTQG7NvE83sexOnEubRyy1mzm1p4QTAG8kCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jxH9QCYs; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jxH9QCYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708810277; x=1709415077; i=l.s.r@web.de;
	bh=qsCjhrq09PqPIg6oOqOWS6me1VmgzooH+hnge3m5Fmw=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=jxH9QCYstemstTHrbFhnP7mAWJHsoI2OIaATz/bHgB7smzkWdJ5/6BSxzu3FAOoX
	 aBWY+GxuulaoV/K8sdRWbk5UtxPvgnwMTIm9pR5/e5VmW6fkDfjes9PSHibduH0yF
	 TikW//zXVvVG+L74OVwghFLC4wx4jw/z4jHJG/db+fLnNsZPONgEF4cjZv6lX9vZI
	 cWXYNOrb/1Xb55/76lJuzpwN3Zi8Rv1mk2z7rPNWZlxTDS9exb1BQAh8G4TXyM82F
	 TyfvSnUYPonPGB1cz5uExJ5J9jG20ByRPBVuG0WIkmeRZsKRbCcv0ZWl8xskDx3AS
	 yoOQcLYOCj1hIKSAvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MPrLL-1rHffy2VKF-00MuO1 for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:31:17
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 4/6] parse-options: detect ambiguous self-negation
Date: Sat, 24 Feb 2024 22:29:51 +0100
Message-ID: <20240224212953.44026-5-l.s.r@web.de>
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
X-Provags-ID: V03:K1:yqvaCAtHmEUvw1sXbZ5P+HB7bb7saZs563omVXZn4qsmh/yyYAo
 5I2J+4c3jmME7wSgqSoNHv6zi52muL8qoadQRL7ESuVXv5/UTC9sBB7qBQ+pl/h52Rt21az
 sDtQDW5cSDPIhG4EE4Xt2yiDY5cJeSathdtXd7Zecqvhk/kGepfoNvrl9w0mpfVFq7f8a4D
 ZmKy0o3vTb/DSwAdgQNww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6hDJBiDWZSw=;0hR2ZZ4KyJ2oGbp1JzqMEGdIABn
 5S48fub9rpX2wwmX6EtxMWMLmpa40YOcb6Pf79bZEa9IGdhnDS7sDuK1ftL8eO+ElAhehIREI
 GfW+qhn0m7+4ks39ZjprKsR4KWqWvzd8FM5ohigMjh8g9YWRaaP5nAYpAiJbBEfe9WPv8AvrJ
 FPC7KtGNrZ4p+5/O7h4YuuQkbqkZYe33xzjHIRSCFfYyrEUf+okk7jVscSsIbovjopi3PpKaY
 46mUvmfcoMLtddIBBi7pqfM4iVwXKkRDzlq3sA0kSp2lahDn7KxVmR+V9G+iI8anShtZkwyTD
 d0IuMbRNPR9xEMv3Bqn9sDj9JKLGsSL/tY9VmJ254KC1p7q1Xlav6X3tS/bscDPE3oES8zZgV
 MrgLi96loG2sCSfi0qqZ0cFhUtE5HRny2D9FckF7orIo33ZUMUaT0WppWyozuq4OrCeipDBNH
 8IhQUSffihe/bnKiSL+HMldGn13NMqoeUHdyRNPyWFgL+xvaKMPc584WSiC2E2GREhz33m0Jj
 frbZWA2zkP18X3ZxEvqFUlplSa3lHL7gZ232K3fFNoEOWDkhAqXmNlaExzhQFWCdxixlHPKjP
 AyWRyQ1T2+Dh6TqIscmhMrInXstKQ0omnT1H20gtcw2cy2bnUsRoFxqI54qz9B3J01TXw/Tiy
 zYP5bUD7ufYBRgbhZnsoxlQtQtBuJ9H/4OIyaQ9OnBSpZTmxY2AhFDree/K2u1w4EqqUwPtUq
 sIMX7ZonYB7JeQa9LUSu/pcENxbOL2SGiG0GeZQHFnGzzo3nAglu4vG2iEGHIwszqxL51fvsl
 IiUSK9Bsh8L5IGyMlETdGkrIIKF/rUGhDVlaPGn1utPDA=

Git currently does not detect the ambiguity of an option that starts
with "no" like --notes and its negated form if given just --n or --no.
All Git commands with such options have other negatable options, and
we detect the ambiguity with them, so that's currently only a potential
problem for scripts that use git rev-parse --parseopt.

Let's fix it nevertheless, as there's no need for that confusion.  To
detect the ambiguity we have to loosen the check in register_abbrev(),
as an option is considered an alias of itself.  Add non-matching
negation flags as a criterion to recognize an option being ambiguous
with its negated form.

And we need to keep going after finding a non-negated option as an
abbreviated candidate and perform the negation checks in the same
loop.
=2D--
 parse-options.c               |  3 +--
 t/t1502-rev-parse-parseopt.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 398ebaef14..008c0f32cf 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -363,7 +363,7 @@ static void register_abbrev(struct parse_opt_ctx_t *p,
 	if (p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
 		return;
 	if (abbrev->option &&
-	    !is_alias(p, abbrev->option, option)) {
+	    !(abbrev->flags =3D=3D flags && is_alias(p, abbrev->option, option))=
) {
 		/*
 		 * If this is abbreviated, it is
 		 * ambiguous. So when there is no
@@ -406,7 +406,6 @@ static enum parse_opt_result parse_long_opt(
 			if (!strncmp(long_name, arg, arg_end - arg)) {
 				register_abbrev(p, options, flags ^ opt_flags,
 						&abbrev, &ambiguous);
-				continue;
 			}
 			/* negation allowed? */
 			if (options->flags & PARSE_OPT_NONEG)
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index f0737593c3..b754b9fd74 100755
=2D-- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -322,4 +322,15 @@ check_invalid_long_option optionspec-neg --no-positiv=
e-only
 check_invalid_long_option optionspec-neg --negative
 check_invalid_long_option optionspec-neg --no-no-negative

+test_expect_success 'ambiguous: --no matches both --noble and --no-noble'=
 '
+	cat >spec <<-\EOF &&
+	some-command [options]
+	--
+	noble The feudal switch.
+	EOF
+	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dfalse \
+	git rev-parse --parseopt -- <spec 2>err --no &&
+	grep "error: ambiguous option: no (could be --noble or --no-noble)" err
+'
+
 test_done
=2D-
2.44.0

