Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D64BE62
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460840; cv=none; b=mGRjWOychpgEWUKTgsHdGatZQMWfXpkr2L+25E06S1dDrLHjVKj6olk/dfxFBFdMdTx2x8L/dRIHVvj84JYcw8HpSpFGyI7OVwcysuknUm5R4h0NRRlaRDGThH/koP/Gt29pKdgaULtS2ELMXpx7IjrC2ZMST72wYgZqxsccPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460840; c=relaxed/simple;
	bh=0pEbMqQOu33ZziNbxeWB0teo9gs5t939dKMTf1M3eZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQI5voDo+mdVbUUhz+/HJOoe+k1fIsEIwuqduPI1BQBplMIFZMDfXt+mQZdnhTf4fVsrFjyf9yAotH/aatWGfQJte5nesHMlW7qXWmHtEFt4mjxccGs3eFNtBzIRfURRrQygnqj8rJS/h62ALrftQLLsr+VH5gRLHSt29BqAr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=i9ieRokd; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="i9ieRokd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709460829; x=1710065629; i=l.s.r@web.de;
	bh=0pEbMqQOu33ZziNbxeWB0teo9gs5t939dKMTf1M3eZU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=i9ieRokdFXSvRp0S/Gym06LzTvzrxBjrG/SwUGw3XZfVF6ogOmjmVAUFDS4pFroC
	 +p1mcIS44bzK2qhac8uj8snpRgzoEej1uTxXnzREkQDbZH2lQi+JdkBchmeTlJ2Ka
	 xob4WKy/wokz7QmKMc7ApQ8w7bGrGLOS6k0KBbU94BDI3sbmelCm5ZhHBxEtH2HMf
	 Mc0i4+P9VXLPkbBQwhdKMetoGdQeV+PPSWteso2G+pKqXJyja6pD9YlMUNLPytNU8
	 XDGnr7qfUYQkKtdOG8hJBWCDrN6niClBahbaL17aRwUfrVeRlQPf4Zp/KHzbDFQy3
	 PK1lUdm+9voQSqDh9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MtPvm-1qrdMh3DB8-00urj2; Sun, 03 Mar 2024 11:13:49 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 1/4] t-ctype: allow NUL anywhere in the specification string
Date: Sun,  3 Mar 2024 11:13:25 +0100
Message-ID: <20240303101330.20187-2-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303101330.20187-1-l.s.r@web.de>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240303101330.20187-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cSQfni6q8uN6JkenxEDsKe4NRK9lxNoKnVZk2WGvlfa2ptbgmxT
 4/h/TAn1+tGLmJcTTBZDOorP2q79HtDA38DuMvFr70+u43/d6FnJlF6Co9umPcNWzflEp0Y
 16c75I7F3WqyuUHGmhZ0Nq9mu/F7URE0u3LzUb92vsLF/28fu2hcGEgWO0z7keIVtlyzbqU
 nb1cxWh3J4ix0pULzGNbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fh+LqK6mkF8=;sQChWFWeg4MA2NtgVm9X+XOPHiV
 pQ1UtloVrfepfHzWJjIp1He0hkt6G+XpO53kfbuiycqvhWRfg1hXf5NYFc/qPSni4+2d8ilIj
 eZRABLXss1mUbDgQo8lPflJ6Y5oQZ1EJ39eTCXIUuHxjcj+shfMyn4vb6OZuN5EeeBcG8OBVz
 o4LJ/uRe7umAeBFR2bPYh3I5qUZdhQEZ5vLk7pC6o0s9RcU9VUi1gkWe4ASIUNWRbzdZYpraI
 QLni6GTBZfz01uGxry+EXnIhHe5XOQ+eLsKDvedqXIHgpN6jeETUaOgZVbYUtZTLB23pYL6D/
 p3V0XVhK9BwASbxi3iF1Bt9noVl5/gSOVzSAbKg0fXm0SzYF7HFqZnLl3HqNGrzmE7FDI25E2
 vcDg9QclOgPb+r6eJIxU4sCldF79C/NZFKKrzy4ki0N4zTWCxhO4xU9NgUx5VumjuxsDlcNbd
 r4WDH+FV98t5bu6RgW/T2RzQKUBrQJjZ36BFwCadXvzWAi6w1w7rPNMs+xqDDjFre6WIeQQCh
 G6XAix9W8fP+PM85zJNsIX756CiGMwXs/OFMz5TLNd/FDzRFHqcNaEjjjSFXUOg/G2jwWlx+q
 h0CxSiaq8mnWiI/QbeFiMPQbmdzsNd8Xw9BRbwYlUwPIdKCZhMny5/aE/gAA8ai7gn4cuKhDF
 1hEaYbVJjTooH6Ul58UAQL+ErdwJ8r6FzfOXOgWvY2z2HCI8CNBdmvpyAovhbueFEGbKloza3
 +6qVciRyDNl/akUM5SvjX8O+tL5t/h7fZspnj7bNqKZNJL84XBlvx7iBYDLuXL9xumRHpSXsp
 Gq0RHjLLCLB/Ke9iBDub6O7mk6TIJnahqHQA/i55OkqN4=

Replace the custom function is_in() for looking up a character in the
specification string with memchr(3) and sizeof.  This is shorter,
simpler and allows NUL anywhere in the string, which may come in handy
if we ever want to support more character classes that contain it.

Getting the string size using sizeof only works in a macro and with a
string constant.  Use ARRAY_SIZE and compile-time checks to make sure we
are not passed a string pointer.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index f315489984..35473c41d8 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -1,23 +1,13 @@
 #include "test-lib.h"

-static int is_in(const char *s, int ch)
-{
-	/*
-	 * We can't find NUL using strchr. Accept it as the first
-	 * character in the spec -- there are no empty classes.
-	 */
-	if (ch =3D=3D '\0')
-		return ch =3D=3D *s;
-	if (*s =3D=3D '\0')
-		s++;
-	return !!strchr(s, ch);
-}
-
 /* Macro to test a character type */
 #define TEST_CTYPE_FUNC(func, string) \
 static void test_ctype_##func(void) { \
+	size_t len =3D ARRAY_SIZE(string) - 1 + \
+		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
+		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
 	for (int i =3D 0; i < 256; i++) { \
-		if (!check_int(func(i), =3D=3D, is_in(string, i))) \
+		if (!check_int(func(i), =3D=3D, !!memchr(string, i, len))) \
 			test_msg("       i: 0x%02x", i); \
 	} \
 	if (!check(!func(EOF))) \
=2D-
2.44.0

