Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3841E4AC
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="I5YpgpEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702723642; x=1703328442; i=l.s.r@web.de;
	bh=e5mkGA19XQfEaJEn9XvV8tW13wWNygGA/Ka/T7Oe+kw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=I5YpgpEm5PrxS1bLOO0PFGyVHX+o9eOUaHeYC4F/wp02L7J7J6vcHS2nFBAw9KGA
	 PjntSewiZpRCFdzBzbN+LTfQfPnC1moSm5SzcWt0gleUveDLiUTtb+IspaF1/W0pw
	 PvqUuRsm7KDGXz53jjWW6UuYE+mI2Vgh1udWPaBlLrX2bbIbWltK7Wr0kZXlvxqVQ
	 rHgn/vT0zZOB1io7S0utwWLatgO4feH6H9j1g1qzbwsawQZtqKG4zkuYtaFM9NzPU
	 5asO6rKj5jKiUfEX9A7Y0au5prZ1jMMtdLnQzA/GpSEp3cLX5X1+cWrcJNLzixDZp
	 VrjPCCP8GDoYcJ1FIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1rPI-1rCGLB4Avo-002grn; Sat, 16
 Dec 2023 11:47:22 +0100
Message-ID: <2d30dc36-6091-4b47-846f-92d3f4a8b135@web.de>
Date: Sat, 16 Dec 2023 11:47:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool
Content-Language: en-US
To: git@vger.kernel.org
Cc: AtariDreams via GitGitGadget <gitgitgadget@gmail.com>,
 Seija Kijin <doremylover123@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
 <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
 <20231214220503.GA3320432@coredump.intra.peff.net>
 <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kg4vUIo2kBjZTwi2vdvCeXPLKISmsu8TlVAcEQLuIYCBJ+xPviP
 PqDC4tQ5KCvKa7L061qK0cJC1egUhb6fMXTRLT136LcbFoouT7yC2LygtdQc6UtNgVgtmku
 EwmHOpmNYBgeVF6jPKCRU3ouYotW1y38Yvtot0u9Zpt5sL4oZcwUBLEULNBlaIShf2xk8jx
 gUuu5uGzDqlwPrhB59cYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uj0CxqVICYE=;DoH21vKzHne27DZGhjjLq5niu/+
 svFftPa25rK4sOaGsXd+Cq022vOI0mNfp+Dp8L7OcTvHksxLTFb47yEGmAPj44MnngmGo5DR7
 Le/+pm/57kfd4PqHUuprT39g1nd2oIJJwXod0fPxSSl/1momBx6wWZclIs398qAQXBerfSHA/
 MxRuGPl/p2O04x+bMt0lRgmC5wrc4ev1yngLCA0V1tA2c1Mm9B5s3PnDHOGSUZRcdvaB4SQBg
 frgUdVyMfp2oLUj+HCTEmu34P88Caj33tXXwPqsSIJGEeTHlYp2KkLcl9Jn96evU+ye7bAB/B
 VwoFT0IJGdw/RYjbpf8O3KEWdP30Ky15R/M9WJlOkJk4Gf7NR666jI5WxRQy9CN0oIsXWQwBE
 jfCV40oH5xvn2GMFkcb2wij4MuvrhUUZqs0cf9Kyiw4RIu9zjaf/v84mf8iu4g63cPKGo6KtF
 Fomgi18O0qLf6erLeb3HUwkK9WQDFGPOARKCxW6oyYD84mSqNnH+JEjA2ypIEzpFru2poEwmD
 2HuCFQyY4XAN+FSxwbIRvm0tmP2ugh8A4k1PWd5omrF5AjDTFGFW4tj80KfZqoB3HFZIm9n4a
 xsxvAKFt6xqm8o/a429zRfNdIMo2CETR0NvfdEdHoqgrrVZWmCoKRXSLs/edhptjBJvuDtw+9
 1YVhwDrnSd074fCIKr03bmqLmRiRdnFDKoVVCLKcNKD0arVQcEJBJJs6RpjcXwdsfilhZMg58
 KqJYtpd+OgXMOH0WrJgg+4mxa4Z7yu6jgvqWZrW05oX7dCVN4rdVb1a+nrU7YNEB9YgMXtT3p
 DqTsepCopa16DPbnybQzJBo0bIuavDJ9CtpX4hVBuA9aJeMtbpxNP+SP8QDXsqITWQBqScwaS
 NQWQwuGg5kkGGyiRL+QkAPyqIb5CW3j1TODJKHumZHLEQ/yxVl/ZXLztJFV+jK1klH/6joUX3
 epTsLb1BFPgsWYikuk3kHc/ad2U=

Use the data type bool and its values true and false to document the
binary return value of skip_prefix() and friends more explicitly.

This first use of stdbool.h, introduced with C99, is meant to check
whether there are platforms that claim support for C99, as tested by
7bc341e21b (git-compat-util: add a test balloon for C99 support,
2021-12-01), but still lack that header for some reason.

A fallback based on a wider type, e.g. int, would have to deal with
comparisons somehow to emulate that any non-zero value is true:

   bool b1 =3D 1;
   bool b2 =3D 2;
   if (b1 =3D=3D b2) puts("This is true.");

   int i1 =3D 1;
   int i2 =3D 2;
   if (i1 =3D=3D i2) puts("Not printed.");
   #define BOOLEQ(a, b) (!(a) =3D=3D !(b))
   if (BOOLEQ(i1, i2)) puts("This is true.");

So we'd be better off using bool everywhere without a fallback, if
possible.  That's why this patch doesn't include any.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git-compat-util.h | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 3e7a59b5ff..603c97e3b3 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -225,6 +225,7 @@ struct strbuf;
 #include <stddef.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <string.h>
 #ifdef HAVE_STRINGS_H
 #include <strings.h> /* for strcasecmp() */
@@ -684,11 +685,11 @@ report_fn get_warn_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));

 /*
- * If the string "str" begins with the string found in "prefix", return 1=
.
+ * If the string "str" begins with the string found in "prefix", return t=
rue.
  * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the poi=
nt in
  * the string right after the prefix).
  *
- * Otherwise, return 0 and leave "out" untouched.
+ * Otherwise, return false and leave "out" untouched.
  *
  * Examples:
  *
@@ -699,57 +700,58 @@ void set_die_is_recursing_routine(int (*routine)(voi=
d));
  *   [skip prefix if present, otherwise use whole string]
  *   skip_prefix(name, "refs/heads/", &name);
  */
-static inline int skip_prefix(const char *str, const char *prefix,
-			      const char **out)
+static inline bool skip_prefix(const char *str, const char *prefix,
+			       const char **out)
 {
 	do {
 		if (!*prefix) {
 			*out =3D str;
-			return 1;
+			return true;
 		}
 	} while (*str++ =3D=3D *prefix++);
-	return 0;
+	return false;
 }

 /*
  * Like skip_prefix, but promises never to read past "len" bytes of the i=
nput
  * buffer, and returns the remaining number of bytes in "out" via "outlen=
".
  */
-static inline int skip_prefix_mem(const char *buf, size_t len,
-				  const char *prefix,
-				  const char **out, size_t *outlen)
+static inline bool skip_prefix_mem(const char *buf, size_t len,
+				   const char *prefix,
+				   const char **out, size_t *outlen)
 {
 	size_t prefix_len =3D strlen(prefix);
 	if (prefix_len <=3D len && !memcmp(buf, prefix, prefix_len)) {
 		*out =3D buf + prefix_len;
 		*outlen =3D len - prefix_len;
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }

 /*
- * If buf ends with suffix, return 1 and subtract the length of the suffi=
x
- * from *len. Otherwise, return 0 and leave *len untouched.
+ * If buf ends with suffix, return true and subtract the length of the su=
ffix
+ * from *len. Otherwise, return false and leave *len untouched.
  */
-static inline int strip_suffix_mem(const char *buf, size_t *len,
-				   const char *suffix)
+static inline bool strip_suffix_mem(const char *buf, size_t *len,
+				    const char *suffix)
 {
 	size_t suflen =3D strlen(suffix);
 	if (*len < suflen || memcmp(buf + (*len - suflen), suffix, suflen))
-		return 0;
+		return false;
 	*len -=3D suflen;
-	return 1;
+	return true;
 }

 /*
- * If str ends with suffix, return 1 and set *len to the size of the stri=
ng
- * without the suffix. Otherwise, return 0 and set *len to the size of th=
e
+ * If str ends with suffix, return true and set *len to the size of the s=
tring
+ * without the suffix. Otherwise, return false and set *len to the size o=
f the
  * string.
  *
  * Note that we do _not_ NUL-terminate str to the new length.
  */
-static inline int strip_suffix(const char *str, const char *suffix, size_=
t *len)
+static inline bool strip_suffix(const char *str, const char *suffix,
+				size_t *len)
 {
 	*len =3D strlen(str);
 	return strip_suffix_mem(str, len, suffix);
=2D-
2.43.0
