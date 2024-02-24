Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8CC4CDE5
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810289; cv=none; b=dOsQIkJSfDTlfmjPpnpeESaZsfUKSIzuPbf6Eo5l2jFcZaJdOP2u8rMH73ABTVfRiwTrGp6HqTTZpzfqFYZABrDAnlW+TX1vGSwjFUfB1tTTX+9qqz3uwBzh5e3jJgPkswxRZng5J6aM2IOCRXRxAN1CE/leNGEZqRZtALJEc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810289; c=relaxed/simple;
	bh=gJi2rVxfHwoA8b65uLZpWx3RXhSwm2SHJMx16zn9L/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3YW5MxCMeoCZUA0DzrdxHdMAa3UvhE2ohn97q2SGI4RxufTEK5E9Ps9R3q1xfVP85+TtvqLtPBkjTd2q7sbfTV7RNiAdqPSNhEsYPYMTPgyySHgowALxyMtqqRwXJIrxYIhQ5y1/Fa63NapT0eMxCxaJvS+2tTipDRP7dnWQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=rifvCcdN; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rifvCcdN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708810277; x=1709415077; i=l.s.r@web.de;
	bh=gJi2rVxfHwoA8b65uLZpWx3RXhSwm2SHJMx16zn9L/Q=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=rifvCcdNxZpHIcgK6iZKeH+3Y0p0vzIp2BMVZzfbThMvaX4UlfxyNoZasmLNZi9J
	 vZFnZ3+TWkwpQwG3LzLZ1xPhI7YD2cwC53HueW49BK1NM7vaBH84ScE3M2Mqcwfac
	 gcDZd9Gy+KfmJvrLJrxuNOEwOMUMj842Tkubq1c9QQwapaeA677A6rrFAB/+TtgUP
	 onz8LYAIe5JbT9bh5iKbe9/58h4eHPlRT4iyyeelUiT3Vzxer9El2QWeszwoadONx
	 OfrHx5iT08xqpHBNhJNWx9NKclqPKSy+DlFioBcQ561ch6oY9NclYcBDIWB/ZItgP
	 iqW8GtVwoA5GRLfAqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MdwNW-1r5UPL356M-00azSu for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:31:17
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 5/6] parse-options: normalize arg and long_name before comparison
Date: Sat, 24 Feb 2024 22:29:52 +0100
Message-ID: <20240224212953.44026-6-l.s.r@web.de>
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
X-Provags-ID: V03:K1:GvnvA/q7me6hbj7Ucjch7xQPFimJICOqdOflRvwINWMgHUf0t4c
 MqQ7wEd4A/YFp6WVAdCIYEHj6gU7DPdyL6bJW68CRcbbEctPXw08Cw+5LjuA/Ph048zocW8
 PJA2jGqsl4NFh97uNGpF4wJ/ErCpICa1AgwrQkKB4J1viW1H6hYzdHmiTJI1iKUL0CXO3iX
 w9T4QWmjp1YNTY5AZHyhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bk/NNM03I3Q=;FCxIpSWRMV97v6EGnt1x7cf9r9y
 WnjE8onyCLN81YsLmlHb+gaqBNah5/A9/2RMbEDxteKKosrJyWR6lloh4rugYwA8NtWK0jURT
 uBKBfbBVqjAoSJrIHmA9hhGVwPbhbLPoUM0affCZDcQbB6PtLuD4bh+pv6OZZ/ORPCFzoXSrR
 6qzI35GG7qYlcX69b3Tie0TsJpJfSpOPAfNQ3hHko/q1uFgmkqygb+j7974CAlehidzdgsAwl
 YijKXOp0ktdojP6ak8pYgeUIDsJly3WVV8qx+dkK9Itvj7WTSsHOJdGmxlH2uTJGRdNd1c5tz
 2GtPtyodfG6n5wgd97e5jLQ/CFBCp1NSpHNAQjQMHbtGqc+qbtqg/JaGfZ4Uz9ePT/Wcmh+OI
 EPG+517UJVGdpXV0UxI9tMz3fylLWLzNWv4xXTPApQbnCUCjdqf9hOYkaKevYFO8cRKpTEjcS
 KfbnoutZ8WUqvCy1fAEgEBDc4+jT9KzklPz5lb6YNHWuxtSTb5f7MlnVZhAhrxq6PFte60ryz
 gzHqHR3/0usf8CprbRPryVox9z1QhdYWjAj7EKY92vDZYbeyRLRuW93aTYPULGd9/aqQg2pUw
 v+1tFaR2tIGAWBNjpxfbtSlYEZMoMl6FQWYv7FUbCPAbw+k7H9MPjVzbOg7FZ7Qg/XRKg7CHR
 QcZqr0FkvSO0juRHh19ztu2glnRRIgUI/1IfTa4iUV1zYySkOQEdggP74buWr8VXtVUTjlY/3
 t+lh5V8dRqN4aK0T/oa6b+B9JPhV+7RLFAh/GKSEXHKL3kG1RWq4xme1Hh5YyW5sytYL7dRIQ
 ObF9YWGLrxs/MiN5R15AE6YXUAF+r8Fof8KR36oiavgHU=

Strip "no-" from arg and long_name before comparing them.  This way we
no longer have to repeat the comparison with an offset of 3 for negated
arguments.

Note that we must not modify the "flags" value, which tracks whether arg
is negated, inside the loop.  When registering "--n", "--no" or "--no-"
as abbreviation for any negative option, we used to OR it with OPT_UNSET
and end the loop.  We can simply hard-code OPT_UNSET and leave flags
unchanged instead.
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

