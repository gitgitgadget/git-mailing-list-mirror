Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8248433DD
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810287; cv=none; b=LDyw+ecaWzGVL/JDTqyZLOnwKTUzhexF2aJZbu8/sQsn8AWyu8I+QVBBu9DzHDZ5mR8Q2SnBnpq2NtAXrk6VRaqkmjUvBGay5FoE2W02wPc1mgZlOu/YcWBy0iEqJz+SqCbEwEs5zeIncNv9wuvvTUjLN3EkCpdRE4VPc0DsVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810287; c=relaxed/simple;
	bh=/q3rGH4Zqz5++F5dtdbxjpC//Zf5HMkzQztTLDrEfF0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNVf7Jl1S4NwEnRbm1FrNxosJjrDiHJPyHJvWv58LY4JUlrsp8soS11Uhx5oVWDQXGhSzoX5zBsvV0NzTh9axhbwIyurmxY0SkwwzRPLeaR8krpTycfmQuuaPM0M0uDhSjenU8KG2JMfO2zFJiy7VxsmomXcrnFsXr2Sm/A1Cmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=FrwvfojS; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="FrwvfojS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708810277; x=1709415077; i=l.s.r@web.de;
	bh=/q3rGH4Zqz5++F5dtdbxjpC//Zf5HMkzQztTLDrEfF0=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=FrwvfojS7TJFdqL1eW2arKNfRr6PAYk1Vax4yNmmbyF2ie9iZLsE79if2vJ9u3eT
	 D9s9mdr4xE/uOaAdVQzvJ33WhbH4ZZEvPzLk16G7Vg0cj//AFE8LSzp6iyoNqBQqp
	 988sY7L3t3ENxrIKesR9HNqj5rrPf1iVQ3oILPf8uxoFW1eQr6EyYsmME/hJdm1iK
	 YQHYQX/vf3jAtVHrh+JwvqLAvcIdNAlN0nQR+gBx5Tjo1dEPBcKTCqCD0jy/Mwptp
	 GOpCa2FH2vnJW3pWE8EUnUB42q9kZfXhi0emRL0p81nRM9YAkcWLhUn0BTcYFDAfW
	 GQcHMUQ6rF4gn+qSbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MDMzC-1rnJXH1qQI-00AULs for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:31:17
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 3/6] parse-options: factor out register_abbrev() and struct parsed_option
Date: Sat, 24 Feb 2024 22:29:50 +0100
Message-ID: <20240224212953.44026-4-l.s.r@web.de>
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
X-Provags-ID: V03:K1:gxLpmXi3Cf+B9Ji99BK8fmDhKb+v5mHKeVa/gVXol1PmidPmzw6
 lOqCeAihlnShTSNgceVPJFqQxXGE5Zcb7ICpiIPsq3eS/c/4lqKJL0STLqf56gPfiQ4Fouf
 EUGNn3VEfhOTufNOt2+wPQEb9pG/r32/R9UdgrQ2bvavNeI/Tk31G1SRdsi7RNqa/JLTz4d
 XVd8c4hevKep6AopxaD2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AimHdJrg6bg=;OZLvAZVj+C29Ldrh5tQ0cuFU9Rk
 sTxXiZ01YyNxATvZoKzkY38mMWS9l9vMeVYHQeY/cQKemfbj4Os6vB6F7IrdWG8Dap4S8fOkD
 2NMDa82qMivJqDf1FGi2N7yXbHAwr2DL49AVetvkS34GoY/jyi8GNITHsVr1VjJEV5ruogmpZ
 6gKg6RW4gILfggW3a3F5DpYGHiKfflH8QKdrA8gB9uPDgYw25SUfpqh54PbDRNT+W0Au9dUKy
 5INTfVRKRV2Y0K2y30ULbY3kVY6Im/G+OymWCFEVln8ut0jqERZl1T4jJkP/ydIcEFjJWu6OC
 1lVFMyiJCVzWHpLiyHdoWIFxQyZDZCvFJ/Z2ORHEnc/l6NvqaD9qe0/OAfdfPHRm2niwu28KN
 Xx00/KDCbPliF1Oo+n3y9TlO65GK+EccFRs10xIBl/OOGWinTMcLDIqvnej4+mpuCsjXC2bfX
 ybPQhItRwML9UNj0oUNtxp7y6Q3zL36EBkDSJ75Gi/EDPu8XZ6+K0JvIMbUpNrTn8R8UqikzV
 Kj5WPr1PaxTn9KCN6SkGsErLwgTcLRx+vubKzvLsPUZIpBOiJMJI9BwHwGfuY1iW52HDN3TOx
 Pg6loRgggqqsCOpsAne9b6z5kQ7jwwTj7KA1s8V52bgNLlnrFLFUUQRWja7a/krJx+pafgiaY
 5pw9+rPCmUsO3yONSEmJGPItUeRxgFhIMu5aFe7lN8zeJljfG4knWdXcQEGtT20ayk3jqgqVO
 TblUTKlIx5/q4m/12DMAJmzhAXEuqQd+CqDvRImf0WRDIzYtFeLu4i9R2omAjBpY7j9dm8c4N
 nhv8JofljgT+2VX1OqUoT+6/ik/dbQ6T9dvZgMEPpWLHQ=

Add a function, register_abbrev(), for storing the necessary details for
remembering an abbreviated and thus potentially ambiguous option.  Call
it instead of sharing the code using goto, to make the control flow more
explicit.

Conveniently collect these details in the new struct parsed_option to
reduce the number of necessary function arguments.
=2D--
 parse-options.c | 83 +++++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 34 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 056c6b30e9..398ebaef14 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -350,14 +350,40 @@ static int is_alias(struct parse_opt_ctx_t *ctx,
 	return 0;
 }

+struct parsed_option {
+	const struct option *option;
+	enum opt_parsed flags;
+};
+
+static void register_abbrev(struct parse_opt_ctx_t *p,
+			    const struct option *option, enum opt_parsed flags,
+			    struct parsed_option *abbrev,
+			    struct parsed_option *ambiguous)
+{
+	if (p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
+		return;
+	if (abbrev->option &&
+	    !is_alias(p, abbrev->option, option)) {
+		/*
+		 * If this is abbreviated, it is
+		 * ambiguous. So when there is no
+		 * exact match later, we need to
+		 * error out.
+		 */
+		ambiguous->option =3D abbrev->option;
+		ambiguous->flags =3D abbrev->flags;
+	}
+	abbrev->option =3D option;
+	abbrev->flags =3D flags;
+}
+
 static enum parse_opt_result parse_long_opt(
 	struct parse_opt_ctx_t *p, const char *arg,
 	const struct option *options)
 {
 	const char *arg_end =3D strchrnul(arg, '=3D');
-	const struct option *abbrev_option =3D NULL, *ambiguous_option =3D NULL;
-	enum opt_parsed abbrev_flags =3D OPT_LONG, ambiguous_flags =3D OPT_LONG;
-	int allow_abbrev =3D !(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT);
+	struct parsed_option abbrev =3D { .option =3D NULL, .flags =3D OPT_LONG =
};
+	struct parsed_option ambiguous =3D { .option =3D NULL, .flags =3D OPT_LO=
NG };

 	for (; options->type !=3D OPTION_END; options++) {
 		const char *rest, *long_name =3D options->long_name;
@@ -377,31 +403,20 @@ static enum parse_opt_result parse_long_opt(
 			rest =3D NULL;
 		if (!rest) {
 			/* abbreviated? */
-			if (allow_abbrev &&
-			    !strncmp(long_name, arg, arg_end - arg)) {
-is_abbreviated:
-				if (abbrev_option &&
-				    !is_alias(p, abbrev_option, options)) {
-					/*
-					 * If this is abbreviated, it is
-					 * ambiguous. So when there is no
-					 * exact match later, we need to
-					 * error out.
-					 */
-					ambiguous_option =3D abbrev_option;
-					ambiguous_flags =3D abbrev_flags;
-				}
-				abbrev_option =3D options;
-				abbrev_flags =3D flags ^ opt_flags;
+			if (!strncmp(long_name, arg, arg_end - arg)) {
+				register_abbrev(p, options, flags ^ opt_flags,
+						&abbrev, &ambiguous);
 				continue;
 			}
 			/* negation allowed? */
 			if (options->flags & PARSE_OPT_NONEG)
 				continue;
 			/* negated and abbreviated very much? */
-			if (allow_abbrev && starts_with("no-", arg)) {
+			if (starts_with("no-", arg)) {
 				flags |=3D OPT_UNSET;
-				goto is_abbreviated;
+				register_abbrev(p, options, flags ^ opt_flags,
+						&abbrev, &ambiguous);
+				continue;
 			}
 			/* negated? */
 			if (!starts_with(arg, "no-"))
@@ -409,12 +424,12 @@ static enum parse_opt_result parse_long_opt(
 			flags |=3D OPT_UNSET;
 			if (!skip_prefix(arg + 3, long_name, &rest)) {
 				/* abbreviated and negated? */
-				if (allow_abbrev &&
-				    !strncmp(long_name, arg + 3,
+				if (!strncmp(long_name, arg + 3,
 					     arg_end - arg - 3))
-					goto is_abbreviated;
-				else
-					continue;
+					register_abbrev(p, options,
+							flags ^ opt_flags,
+							&abbrev, &ambiguous);
+				continue;
 			}
 		}
 		if (*rest) {
@@ -425,24 +440,24 @@ static enum parse_opt_result parse_long_opt(
 		return get_value(p, options, flags ^ opt_flags);
 	}

-	if (disallow_abbreviated_options && (ambiguous_option || abbrev_option))
+	if (disallow_abbreviated_options && (ambiguous.option || abbrev.option))
 		die("disallowed abbreviated or ambiguous option '%.*s'",
 		    (int)(arg_end - arg), arg);

-	if (ambiguous_option) {
+	if (ambiguous.option) {
 		error(_("ambiguous option: %s "
 			"(could be --%s%s or --%s%s)"),
 			arg,
-			(ambiguous_flags & OPT_UNSET) ?  "no-" : "",
-			ambiguous_option->long_name,
-			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
-			abbrev_option->long_name);
+			(ambiguous.flags & OPT_UNSET) ?  "no-" : "",
+			ambiguous.option->long_name,
+			(abbrev.flags & OPT_UNSET) ?  "no-" : "",
+			abbrev.option->long_name);
 		return PARSE_OPT_HELP;
 	}
-	if (abbrev_option) {
+	if (abbrev.option) {
 		if (*arg_end)
 			p->opt =3D arg_end + 1;
-		return get_value(p, abbrev_option, abbrev_flags);
+		return get_value(p, abbrev.option, abbrev.flags);
 	}
 	return PARSE_OPT_UNKNOWN;
 }
=2D-
2.44.0

