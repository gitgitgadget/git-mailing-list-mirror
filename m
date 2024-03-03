Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50AC13C
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468400; cv=none; b=H72eOErFjw9hEv++iAwSrY002iHanD7UJcl8FmKfmDouPNKFErApPluut3gRyavbpn8qYSZ6JKeSKFenM5wk9IYXP7heLBk67//0DiMC251QnpqY0TOcoJfA8eu6eet6VLlb7HsUL/g2CGkq+yy/shjGr555Hmg4k6aIJ1JtXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468400; c=relaxed/simple;
	bh=RoMlF32F9cMG0eaEdtMsrcQW1AITe0vez2c9SuVV3KM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsAvVqASe3uKOxySJmGnBhtoJCinDPMv6XbXZNBjvdV0QLffI+cMAiXEHFcOM2Zm1E70K761f3W/QYmrBrZBPI2lGmQjzPHtj4xPhIcAiyFRivD9eBjt1OwnXtOSXOhzOjkIcP0+B+2jd5NGyFEdolMYbe2CpvYKnAFD26BUmd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bihRt+BR; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bihRt+BR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709468394; x=1710073194; i=l.s.r@web.de;
	bh=RoMlF32F9cMG0eaEdtMsrcQW1AITe0vez2c9SuVV3KM=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=bihRt+BRSHBV2+RdGx1mudXKQnc7AMltQP/01hXeXZQJyZbaoLdPXUVu0q7K/S6H
	 XJeMScXVSzmQJqVn42TNqCPb5R1OahATimfipZwSRPpir7w6zYb2rSnu0WZaIuKBL
	 LhNpdp0Mx6oFHlms/TsxIK1kVWYoApBun51KWUY1tZDBMARDimFOeYZGr5G//dJKg
	 Q6X9S7TwJ/2nDMbmAhXY+hWrZQyT/cIAKPA0oSPe4/ByeRuxkfztN39+Z3F7N7YIQ
	 wg48ERJ7erdm5CKDHykfjxf6WKZuP3lzME7q+f2xEfKFxDvUaN51HeTApcsLYi/DL
	 q6ombYJlpr3eqGEgzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MxHUC-1qwdLl3Z9s-00xSTu for <git@vger.kernel.org>; Sun, 03 Mar 2024 13:19:53
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH v2 5/6] parse-options: normalize arg and long_name before comparison
Date: Sun,  3 Mar 2024 13:19:42 +0100
Message-ID: <20240303121944.20627-6-l.s.r@web.de>
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
X-Provags-ID: V03:K1:/JedbBqZyWoGLdEkLJHDWCaF/z4sHCyX9cBuTZff22ns1gCNN6D
 UrqSZbcMNA2QkHYKwfdkGOcuPxrCODYojNSHWpW4uHYKYGvdY7QhcNL53zw6YHdgYE78F61
 2tE882dQ6H0Dg+4gROdWrzfQ0X8uiFrKzS8qDQhgMk5IFfNLHhfZZmPUMskie4ZZLssBTBO
 be1RdTQ8vP0QMg80g8Rsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B3eQ1VLbkxU=;68ltKJdFA/7TbDtb/PHSnCVXAbD
 +BKjCgt8d5ZpY7ds+x0jXyf3CC16jIYGQhg01LmHPZtQSCxAg0hY2v2q8nCMWpTZ/pToEBfD5
 lCIDrauc+DwL2w7LftAUTBkQv9oIO6LC4HAxTnDmixnKjTP+09bQvE/1WIWsHI9tlzcMe0xpL
 dCNww5eiH1pU3XG+Kdy8ILgGQjMieng2S8+DdUkd/qqWCi6+1N8sxiRhDwLo7dScy2M3dWlXK
 eQ0cwCRTUP7lLRABdS2IU4OkjQVMSxAhDWuRBuj38hWVPEN69EXkoZfQwMp2VK41McNGva3lA
 cQY+2d5ksl3GLK60KjeNog6AT/fsE+trcvyxu9WqxPTW3idV+eqhUnl/2lE5HpBaYO4SY2dBr
 6Iz+WRtjxDFipjh77vm4oFyK0RDEL+MFU32vm7CcngmR3dMzITgnYm6JnpZlWtnJyDZFDoOml
 8yKZVhom3Eb3nQTWhO2KNX+bIWHz/h4FvLoEB/3Usj8TlWhuWnsUeD7nSs3geCUYy+Dcr9PMO
 pL9dNSpGTlaU0uRb1JOxMofh2tWgy93FGK4lrRcRmhaBjo0rVCXbrSLqEn89xN5OXJz58nZ/J
 sCk5Z50q3KbrPaKh0lWu4fT0V/uxUt14tPwag7AaAnikhh3+FT8+kP7uktolzja0GtMeZpz14
 +pZPqpDaje51TNw4JElJpWFfqeZ47xt2L3w2YvzYpeay2ULKKeXXSx/2zGnpyVvt9RnOiI7Rh
 hYAq83yrMO/Hey0eixy8Gziv1nsTS8AcAlRFWEGWI1wYr006p4gCGWyFJiHd9QLIoIsYWh9W1
 NV+BsvVeYnrHet848odAyX6gqVefxYGM2tsgV+QZ6sbZY=

Strip "no-" from arg and long_name before comparing them.  This way we
no longer have to repeat the comparison with an offset of 3 for negated
arguments.

Note that we must not modify the "flags" value, which tracks whether arg
is negated, inside the loop.  When registering "--n", "--no" or "--no-"
as abbreviation for any negative option, we used to OR it with OPT_UNSET
and end the loop.  We can simply hard-code OPT_UNSET and leave flags
unchanged instead.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 008c0f32cf..d45efa4e5c 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -382,28 +382,42 @@ static enum parse_opt_result parse_long_opt(
 	const struct option *options)
 {
 	const char *arg_end =3D strchrnul(arg, '=3D');
+	const char *arg_start =3D arg;
+	enum opt_parsed flags =3D OPT_LONG;
+	int arg_starts_with_no_no =3D 0;
 	struct parsed_option abbrev =3D { .option =3D NULL, .flags =3D OPT_LONG =
};
 	struct parsed_option ambiguous =3D { .option =3D NULL, .flags =3D OPT_LO=
NG };

+	if (skip_prefix(arg_start, "no-", &arg_start)) {
+		if (skip_prefix(arg_start, "no-", &arg_start))
+			arg_starts_with_no_no =3D 1;
+		else
+			flags |=3D OPT_UNSET;
+	}
+
 	for (; options->type !=3D OPTION_END; options++) {
 		const char *rest, *long_name =3D options->long_name;
-		enum opt_parsed flags =3D OPT_LONG, opt_flags =3D OPT_LONG;
+		enum opt_parsed opt_flags =3D OPT_LONG;
+		int allow_unset =3D !(options->flags & PARSE_OPT_NONEG);

 		if (options->type =3D=3D OPTION_SUBCOMMAND)
 			continue;
 		if (!long_name)
 			continue;

-		if (!starts_with(arg, "no-") &&
-		    !(options->flags & PARSE_OPT_NONEG) &&
-		    skip_prefix(long_name, "no-", &long_name))
+		if (skip_prefix(long_name, "no-", &long_name))
 			opt_flags |=3D OPT_UNSET;
+		else if (arg_starts_with_no_no)
+			continue;
+
+		if (((flags ^ opt_flags) & OPT_UNSET) && !allow_unset)
+			continue;

-		if (!skip_prefix(arg, long_name, &rest))
+		if (!skip_prefix(arg_start, long_name, &rest))
 			rest =3D NULL;
 		if (!rest) {
 			/* abbreviated? */
-			if (!strncmp(long_name, arg, arg_end - arg)) {
+			if (!strncmp(long_name, arg_start, arg_end - arg_start)) {
 				register_abbrev(p, options, flags ^ opt_flags,
 						&abbrev, &ambiguous);
 			}
@@ -412,24 +426,10 @@ static enum parse_opt_result parse_long_opt(
 				continue;
 			/* negated and abbreviated very much? */
 			if (starts_with("no-", arg)) {
-				flags |=3D OPT_UNSET;
-				register_abbrev(p, options, flags ^ opt_flags,
+				register_abbrev(p, options, OPT_UNSET ^ opt_flags,
 						&abbrev, &ambiguous);
-				continue;
-			}
-			/* negated? */
-			if (!starts_with(arg, "no-"))
-				continue;
-			flags |=3D OPT_UNSET;
-			if (!skip_prefix(arg + 3, long_name, &rest)) {
-				/* abbreviated and negated? */
-				if (!strncmp(long_name, arg + 3,
-					     arg_end - arg - 3))
-					register_abbrev(p, options,
-							flags ^ opt_flags,
-							&abbrev, &ambiguous);
-				continue;
 			}
+			continue;
 		}
 		if (*rest) {
 			if (*rest !=3D '=3D')
=2D-
2.44.0

