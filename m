Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914D2C9D
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720952292; cv=none; b=J94RAJOZj/YO/gnqYw/C6zL/idO4NoCwXlTrSjHNFZtKw5bJs0zmSaLY6t1spaDM6ujk/GKKzLojQ25kv53MxWxM6Wlt6cSolJ1R5p6WaMafQ5KV+Tk6nvL39PfLh5vGYuTsDiIOCfwW33xNIM3qlHRhFNjlMaL4/t7n3SJ+crg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720952292; c=relaxed/simple;
	bh=VDV8jH+B/bXpIJjupOhR5f0DREFC/HVzbE9Yi0Rtj1s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YZsZfuY4yGobW5qo2iw25XjjhSmCar56wZrCfBcd05UW7VqTHPYL62hjUUUg89f7zgaaca+j4SIgOTYZ95wYU4NDymOzSXrIhwB4l0SavvHzNQj8xFyuNOEivaT7LGs3SMnTn/Ne6TZOeugjFRP/oGjPzOon2M7WKHOZFjqBsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=UvQ6uaus; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="UvQ6uaus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720952274; x=1721557074; i=l.s.r@web.de;
	bh=CMcqB8TSaovzUdcIVvUNGJVRH/ECzsYamKS5ZemJONU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UvQ6uaus5ol40Yx0JZPsB1j84sabPCDnA5JQAJpSEPO6ylP6nkwxiNxp/epN4dbG
	 H1mdndqahjtSZGUSzI4sl390s22fgn+txdVbApcYNnmsuztvEKcQaL/JhTLZL8xO2
	 HknueOvs7t+ug815BmqNItLBZkwoGsuZi0eYZrkCTpzRslkYrbPQZFk89PLKflA7l
	 irzgtzpqxXRwrDeH4KCY0ogzoFH+omj7iafWhDE30LBml5059rMZJYa5ne+zUEK+s
	 wKCX3mCEQIUU99pqdmWFMgJ+TTPS0Y/YspuALGseTf30LdAFChbtlSNh0xdT89+bb
	 5otR5zRCHRRKaR4cQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mho04-1rpDlK0TGy-00ZjpM; Sun, 14
 Jul 2024 12:17:54 +0200
Message-ID: <5bbef273-382e-4096-9ca6-d74781223e55@web.de>
Date: Sun, 14 Jul 2024 12:17:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] t-strvec: improve check_strvec() output
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
Content-Language: en-US
In-Reply-To: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JMOWYqqeeWKTKj7gIHRByFkUUFLKO2y1UWIz4G1eemqhcQ8gX0L
 NLYZazXXxjrIa1ALnL08tvCy+g9Z6DPOstLzTZO1avpHmcwPKep/pqWSRkf7ps1Iu5cUEI9
 FXSFwyl191l++Y1bzEvQIqdxFHQM4U2pXYQxeEAmXjbguKumSH1fciv2DuLqhRiuix6RHw2
 fxKirHfW+OuxoXO1TA9rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8GhCbDHWGPs=;cSDS8CwCihrPYptKhgR0xyj7LAP
 hui7fVGHXROa2mrKjgEPefenqfK77PhP7n6ClB5+stZcvO1NWFyTywQnuctoFStRw5Ur8RE0S
 wVTBL9lpOWi0FYvwbK6jyOiMuc1A+yYedKPQAWXLCgnFeo4mj9qJ2EGGu5LJ/xgOWQcTPu3OV
 OuKMh2UhwNZlQyuer6Ml+Umpgojlx2lvMZmAmaij1ylXNnoEk1pEwoyPvSZGfLF3L5fVQmcWU
 JaAQrr2rdJmmaOO2JdhAwcOCgJcl7ZWxGEQ8PUyBQ1+TRPq1Q6GS3kgeU0+afCaWjMbOaTsRf
 xSY3TblvNTITjkgUsK3Jq0Cetd+xdshW9+V5tCs92sGZySAUMUBEaZO+4u1qN+zOdQhB/CVEU
 KI4y/2hS1lCKzSbfWHMTlVRmCEW+pOfmVHeROBsiCwODeON/A34AP9lsCa/yzuajt/Y2e+yPC
 ih7v+30i7isRuRP0817pytoS6qv4EyoAcPsCMRD3Mabhktg/NZE61P//brE2UqzoMUQVRiUcD
 8MrUjDJAs3XeV+p7uIvgY7wurThHqIui+O6ovxiY/E4TbWdep0GHTnY9OaY6UcX7PSd99wet1
 hi/Q5FoqIKtjqgFdjMfr9Z0aMe8Gqs+kd/FPfvvrFOhsWEDgBl2uiJGrN0E/oHZ3upm3sxpFd
 p2F9LXw43Cjrgb9ISuAsy2OfJnTa6uCcb6bdcmbKKp09LTW8Oz/D5CBtdc3U8MbjjY+Jf5Zu4
 CGb+DCQ0ipI40GhQKAVwxtA24P50HRLuHy7rQ15aMSLlhCRZ4tnRw1i7pQPZwWrgBC/fabVE7
 F+It3kXp/S7XuxAZ7pdS/bww==

The macro check_strvec calls the function check_strvec_loc(), which
performs the actual checks.  They report the line number inside that
function on error, which is not very helpful.  Half of them trigger
an assertion with a custom message that reports the line of the
check_strvec call, which is more useful, but a bit awkward.

Improve the output by getting rid of check_strvec_loc() and performing
all checks within check_strvec, as they then report the line number of
the call site, aiding in finding the broken test.  Determine the number
of items and check it up front to avoid having to do them both in the
loop and at the end.

Sanity check the expected items to make sure there are any and that the
last one is NULL, as the compiler no longer does that for us with the
removal of the function attribute LAST_ARG_MUST_BE_NULL.

Use only the actual strvec name passed to the macro, the internal
"expect" array name and an index "i" in the output, for clarity.  While
"expect" does not exist at the call site, it's reasonably easy to infer
that its referring to the NULL-terminated list of expected strings,
converted to an array.  Align the "i" with previous lines in the output.

Here's the output with less items than expected in the strvec before:

 # check "vec->nr > nr" failed at t/unit-tests/t-strvec.c:19
 #    left: 1
 #   right: 1
 # check "strvec index 1" failed at t/unit-tests/t-strvec.c:71

... and with the patch we get the more concise and still comprehensive:

 # check "(&vec)->nr =3D=3D ARRAY_SIZE(expect) - 1" failed at t/unit-tests=
/t-strvec.c:53
 #    left: 1
 #   right: 2

With too many items in the strvec we got before:

 # check "vec->nr =3D=3D nr" failed at t/unit-tests/t-strvec.c:34
 #    left: 1
 #   right: 0
 # check "vec->v[nr] =3D=3D NULL" failed at t/unit-tests/t-strvec.c:36
 #    left: 0x6000019a40b0
 #   right: 0x0

... and with the patch we get the more concise and informative output
that includes the caller's line number:

 # check "(&vec)->nr =3D=3D ARRAY_SIZE(expect) - 1" failed at t/unit-tests=
/t-strvec.c:53
 #    left: 1
 #   right: 0

A broken alloc value was reported like this:

 # check "vec->alloc > nr" failed at t/unit-tests/t-strvec.c:20
 #    left: 0
 #   right: 0
 # check "strvec index 0" failed at t/unit-tests/t-strvec.c:74

 ... and with the patch:

 # check "(&vec)->nr <=3D (&vec)->alloc" failed at t/unit-tests/t-strvec.c=
:56
 #    left: 2
 #   right: 0

Note that .alloc =3D=3D .nr is only valid if the strvec is empty, but
check_strvec doesn't detect this error with or without this patch.
Leave that for later.

An unexpected string value was reported like this:

 # check "!strcmp(vec->v[nr], str)" failed at t/unit-tests/t-strvec.c:21
 #    left: "foo"
 #   right: "bar"
 # check "strvec index 0" failed at t/unit-tests/t-strvec.c:71

... and with the patch we get:

 # check "!strcmp((&vec)->v[i], expect[i])" failed at t/unit-tests/t-strve=
c.c:53
 #    left: "foo"
 #   right: "bar"
 #       i: 0

If the strvec is not NULL terminated, we got:

 # check "vec->v[nr] =3D=3D NULL" failed at t/unit-tests/t-strvec.c:36
 #    left: 0x10444e9e4
 #   right: 0x0

... and with the patch we get the line number of the caller:

 # check "!strcmp((&vec)->v[i], expect[i])" failed at t/unit-tests/t-strve=
c.c:53
 #    left: "bar"
 #   right: NULL
 #       i: 1

check_strvec calls without a trailing NULL were detected at compile time
before:

 t/unit-tests/t-strvec.c:71:2: error: missing sentinel in function call [-=
Werror,-Wsentinel]

... and with the patch it's only found at runtime:

 # check "expect[ARRAY_SIZE(expect) - 1] =3D=3D NULL" failed at t/unit-tes=
ts/t-strvec.c:53
 #    left: 0x100e5a663
 #   right: 0x0

We can let check_strvec add the terminating NULL for us and remove it
from callers, making it impossible to forget.  Leave that conversion for
a future patch, though, since this reimplementation is already intrusive
enough.

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v2:
- Replace check_strvec_loc() with macro code.
- Rewrite commit message and subject accordingly.

 t/unit-tests/t-strvec.c | 46 +++++++++++++----------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index d4615ab06d..fdb28ba220 100644
=2D-- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -3,38 +3,20 @@
 #include "strvec.h"

 #define check_strvec(vec, ...) \
-	check_strvec_loc(TEST_LOCATION(), vec, __VA_ARGS__)
-LAST_ARG_MUST_BE_NULL
-static void check_strvec_loc(const char *loc, struct strvec *vec, ...)
-{
-	va_list ap;
-	size_t nr =3D 0;
-
-	va_start(ap, vec);
-	while (1) {
-		const char *str =3D va_arg(ap, const char *);
-		if (!str)
-			break;
-
-		if (!check_uint(vec->nr, >, nr) ||
-		    !check_uint(vec->alloc, >, nr) ||
-		    !check_str(vec->v[nr], str)) {
-			struct strbuf msg =3D STRBUF_INIT;
-			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
-			test_assert(loc, msg.buf, 0);
-			strbuf_release(&msg);
-			va_end(ap);
-			return;
-		}
-
-		nr++;
-	}
-	va_end(ap);
-
-	check_uint(vec->nr, =3D=3D, nr);
-	check_uint(vec->alloc, >=3D, nr);
-	check_pointer_eq(vec->v[nr], NULL);
-}
+	do { \
+		const char *expect[] =3D { __VA_ARGS__ }; \
+		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
+		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
+		    check_uint((vec)->nr, =3D=3D, ARRAY_SIZE(expect) - 1) && \
+		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
+			for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) { \
+				if (!check_str((vec)->v[i], expect[i])) { \
+					test_msg("      i: %"PRIuMAX, i); \
+					break; \
+				} \
+			} \
+		} \
+	} while (0)

 static void t_static_init(void)
 {
=2D-
2.45.2
