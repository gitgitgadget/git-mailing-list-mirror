Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C789326928
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893021; cv=none; b=ogvgQJTNqMO0sKS8EfjiYEXfKtz0HaQ9yAAUAEQ1bJaFIf9yBcS+VagU9yDH+wU0o/95rkFeb6J+kxiukgLjJwEsws/QX8gN9eGvwfpoyQI8R4hyesvEQ/y0KzhEi5lWszENnhwo18b7oG2fyYC2KYCUE6UJrUOtBZod2zlNuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893021; c=relaxed/simple;
	bh=ob+rI+rG2sk00VopvfhlfqrB42SwS+mjV/GK+fWj0nw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DFhDK422an/uPrEx1+SnkIOK5yq/DIrXB3lHnANEupX+fRV4grkCbr5msKpcJmiWaWKmL8oKtbuL+XeX4pD3PBLjYCqj6yok2422/3JQTgmUIUsL2aiHkt3Iyrxi+BU5X9PJmlzjFmzgACPT/PyFY8loSYTTEWTB4WaPAMhJgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=YdtyWLhs; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="YdtyWLhs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767893010; x=1768497810; i=tboegi@web.de;
	bh=rZ8uHECcwrNVTcy78utj0abAfQ93M/k/zGyvJ4RNwIo=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YdtyWLhs6rw0SAGJpk07oMGMzO9XdUIwbXvsKr3frM/z5ADNUjvDUcwmBhVrKu5A
	 g+b9ReLvhYj2LNCYvhwD1jhe4AJRwWo0Zot+7ytQYZ7vWNZFPJSSpLsdlUNEVY7en
	 ul9JdDuFvyLrt6UT6C2uLR2qNo9cH/sC4TjLDuN82sED8Sl8GRfMwCGsUcAY4k6au
	 n3LRBu4G2wZKKUXfrcnjO5F0Z6kCiwPpbgBmKb7BNRBbgObM15rI9jaAusRauPtr9
	 xJ86375M80OKbbRqNXxmUuVIPJYbcWwbIVy1aD/7z8w1PKcYWez0ZVNUPf16O5AjG
	 1bXQX0vMaa0+G0Ufww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvsq5-1vtNFV1gwR-00zmbX; Thu, 08
 Jan 2026 18:23:30 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v1 1/2] utf8.c: Prepare workaround for iconv under macOS 14/15
Date: Thu,  8 Jan 2026 18:23:28 +0100
Message-ID: <20260108172328.466132-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qlklLUudoT0MLFbKH+bSooFVkLpCst4/IsLspNRdzivy9RbBpJC
 W+LNd326zn/B3fb9Uw5dzTI/x1IIePWiZ378yxFQijtGPvQeTIszcdrkxhAvSBGqPa4Prvo
 hsUVXCUo566ZrikLMtpp6LKal2ICX1LxUX29/VLYS0opJwVM+osgCRk3cBzu3Nsfm6UmQqG
 d34xmeDkRihA5n0yMs3NQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qkyKV0IVt0g=;iW1NKwF+MUEJKaD+21akH8fe8YD
 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

From: Torsten B=C3=B6gershausen <tboegi@web.de>

MacOS14 (Sonoma) has started to ship an iconv library with bugs.
The same bugs exists even in MacOS 15 (Sequoia)

A bug report running the Git test suite says:

three tests of t3900 fail on macOS 26.1 for me:

  not ok 17 - ISO-2022-JP should be shown in UTF-8 now
  not ok 25 - ISO-2022-JP should be shown in UTF-8 now
  not ok 38 - commit --fixup into ISO-2022-JP from UTF-8

Here's the verbose output of the first one:

=2D---- snip! -----
expecting success of 3900.17 'ISO-2022-JP should be shown in UTF-8 now':
                compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/2-UTF-8.t=
xt

=2D-- /Users/x/src/git/t/t3900/2-UTF-8.txt 2024-10-01 19:43:24.605230684 +=
0000
+++ current     2025-12-08 21:52:45.786161909 +0000
@@ -1,4 +1,4 @@
 =E3=81=AF=E3=82=8C=E3=81=B2=E3=81=BB=E3=81=B5

 =E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=81=AE=E3=81=8C=E3=80=81=E3=81=84=
=E3=82=8B=E3=81=AE=E3=81=A7=E3=80=82
-=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3=E3=81=90=E3=82=8A=E3=82=8D=E3=81=B8=E3=80=82
+=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3$0$j$m$X!#
not ok 17 - ISO-2022-JP should be shown in UTF-8 now
1..17
=2D---- snap! -----

compare_with runs git show to display a commit message, which in this
case here was encoded using ISO-2022-JP and is supposed to be reencoded
to UTF-8, but git show only does that half-way -- the "$0$j$m$X!#" part
is from the original ISO-2022-JP representation.

That botched conversion is done by utf8.c::reencode_string_iconv().  It
calls iconv(3) to do the actual work, initially with an output buffer of
the same size as the input.  If the output needs more space the function
enlarges the buffer and calls iconv(3) again.

iconv(3) won't tell us how much space it needs, but it will report what
part it already managed to convert, so we can increase the buffer and
continue from there.  ISO-2022-JP has escape codes for switching between
character sets, so it's a stateful encoding.  I guess the iconv(3) on my
machine forgets the state at the end of part one and then messes up part
two.

[end of citation]

Working around the buggy iconv shipped with the OS can be done in
two  ways:
a) Link Git against a different version of iconv
b) Improve the handling when iconv needs a larger output buffer

a) is already done by default when either Fink [1] or MacPorts [2]
   or Homebrew [3] is installed.
b) is implemented here, in case that no fixed iconv is available:
   When the output buffer is too short, increase it (as before)
   and start from scratch (this is new).

This workound needs to be enabled with
'#define ICONV_RESTART_RESET'
and a makefile knob will be added in the next commit

Suggested-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

[1] https://www.finkproject.org/
[2] https://www.macports.org/
[3] https://brew.sh/

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 utf8.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/utf8.c b/utf8.c
index 35a0251939..96460cc414 100644
=2D-- a/utf8.c
+++ b/utf8.c
@@ -515,6 +515,19 @@ char *reencode_string_iconv(const char *in, size_t in=
sz, iconv_t conv,
 			out =3D xrealloc(out, outalloc);
 			outpos =3D out + sofar;
 			outsz =3D outalloc - sofar - 1;
+#ifdef ICONV_RESTART_RESET
+			/*
+			 * If iconv(3) messes up piecemeal conversions
+			 * then restore the original pointers, sizes,
+			 * and converter state, then retry converting
+			 * the full string using the reallocated buffer.
+			 */
+			insz +=3D cp - (iconv_ibp)in; /* Restore insz */
+			cp =3D (iconv_ibp)in;         /* original start value */
+			outpos =3D out + bom_len;     /* original start value */
+			outsz =3D outalloc - bom_len - 1; /* new len */
+			iconv(conv, NULL, NULL, NULL, NULL); /* reset iconv machinery */
+#endif
 		}
 		else {
 			*outpos =3D '\0';
=2D-=20
2.50.0.rc0.46.g7014b55638.dirty

