Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7032D3238
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606775; cv=none; b=oJaBsPHfqBsq/sUcsGEdWHIzAl1hrvzm3k5eCcXxo2CORV3StNnHBuIA6br2ymH79y0k8Q5uU+URF2MIYxmiZi4h1qTzwQbGOLqPh2EtXUrR8awTZynkilZGOMSINEHx7yB+s7d/MyykWZP+72/xx+4XkH5jWVuyUImddvHUYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606775; c=relaxed/simple;
	bh=O5Rcmf8+Jk5zVqohJ8j3fT10cI/ADXjaMeXRZG3wxLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V248z9YW2AxhoZ0A2qFa16oeqP034tBQtdhpCfjjXX+YnGo7+6yG4suRVGkFYQ23HpQNYy/JuUXpE8O2nOuP6kCMEOajwgxCkG5TGUP6M+R1HPmDR0hm5DoO2Z2j+eMnqyUz9G8LQrP2/pAr0OYvqspARWLOd8stQxizCEB8bOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=Ns9e4Wwl; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=vzV9z8cj; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="Ns9e4Wwl";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="vzV9z8cj"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id 5E43660555; Tue, 15 Jul 2025 21:12:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1752606772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5NmuFKEQyPSgk6r99pOe2775e03feTOtJS9WkybCc4=;
	b=Ns9e4WwlCAQsKQY8ThHTAGeCXdk30gal8AI4Yj1JC7KXi4F7xTGIGpbZh2n2VHbRfnV1hE
	r1zbROhcJJ+EJhRDpSOu48Ho7ROEBmSesobYNK5qXlFxJlLL683N7wVLUpZKQ6d9KS4Cv8
	wE3zHA+xKEDptlulseqA/86ZuqlctnSbP9Fi5QdwwB2wTmelo8LGhwNeH6JQ1B97tsVl4v
	Xf6XhKWvcj43nRSvbcIRKoDzgwaLvKG04DPG2H95tqdCCLL4pM7zHRfwkAI0iP4TuB5WVe
	GOOozg/2a/fxVzdZDEyUC+MWT3PV2Jv/xstLGoSjZrAhtESDjq1OYpjitTSzHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1752606772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5NmuFKEQyPSgk6r99pOe2775e03feTOtJS9WkybCc4=;
	b=vzV9z8cj6HUTh/AHyGRBGKwMlZ63eT5QUC6t7+d0ueLoaWHlcR0+fI73y4M9HAWl6CsS4A
	nKX7bZaIKo0alHDg==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v3 4/5] bswap.h: Remove optimized x86 version of bswap32/64
Date: Tue, 15 Jul 2025 21:12:29 +0200
Message-ID: <20250715191230.12081-5-sebastian@breakpoint.cc>
In-Reply-To: <20250715191230.12081-1-sebastian@breakpoint.cc>
References: <20250715191230.12081-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On x86 the bswap32/64 macro is implemented based on the x86 opcode which
performs the required shifting in just one opcode.
The other CPUs fallback to the generic shifting as implemented by
default_swab32() and default_bswap64() if needed.

I've been looking at how good a compiler is at recognizing the default
shift and emitting an optimized operation:
- x86, arm64 msvc v19.20
  default_swab32() optimized
  default_bswap64() shifts
  _byteswap_uint64() optimized

- x86, arm64 msvc v19.37
  default_swab32() optimized
  default_bswap64() optimized
  _byteswap_uint64() optimized

- arm64, gcc-4.9.4: optimized
- x86-64, gcc-4.4.7: shifts
- x86-64, gcc-4.5.3: optimized
- x86-64, clang-3.0: optimized

Given that gcc-4.5 and clang-3.0 are fairly old, any recent compiler
should recognize the shift.

Remove the optimized x86 version and rely on the compiler.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 compat/bswap.h | 41 +----------------------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index aeef304f671f5..ed00f6d1d53f3 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -35,46 +35,7 @@ static inline uint64_t default_bswap64(uint64_t val)
 #undef bswap32
 #undef bswap64
=20
-#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
-
-#define bswap32 git_bswap32
-static inline uint32_t git_bswap32(uint32_t x)
-{
-	uint32_t result;
-	if (__builtin_constant_p(x))
-		result =3D default_swab32(x);
-	else
-		__asm__("bswap %0" : "=3Dr" (result) : "0" (x));
-	return result;
-}
-
-#define bswap64 git_bswap64
-#if defined(__x86_64__)
-static inline uint64_t git_bswap64(uint64_t x)
-{
-	uint64_t result;
-	if (__builtin_constant_p(x))
-		result =3D default_bswap64(x);
-	else
-		__asm__("bswap %q0" : "=3Dr" (result) : "0" (x));
-	return result;
-}
-#else
-static inline uint64_t git_bswap64(uint64_t x)
-{
-	union { uint64_t i64; uint32_t i32[2]; } tmp, result;
-	if (__builtin_constant_p(x))
-		result.i64 =3D default_bswap64(x);
-	else {
-		tmp.i64 =3D x;
-		result.i32[0] =3D git_bswap32(tmp.i32[1]);
-		result.i32[1] =3D git_bswap32(tmp.i32[0]);
-	}
-	return result.i64;
-}
-#endif
-
-#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64) || defined=
(_M_ARM64))
+#if defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64) || defined(_=
M_ARM64))
=20
 #include <stdlib.h>
=20
--=20
2.50.0

