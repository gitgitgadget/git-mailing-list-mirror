Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD27024A07A
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680106; cv=none; b=c6/XgaK0Rz0kR5aqRQSTJunoGVv9tvsaXtQHfq1ZjC8FcshwHu0K3i1RXPn+kaaAEA15DTuWd4iuDviZHMcGm2yaebQuLBvtG1fOcswq/sQsnDy1mYRZZzd5wxJlnf1UTPVMuEGNq/e9T8yha7LOqhyW0cdAZJwcsalJg0+NW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680106; c=relaxed/simple;
	bh=lYz7ph7FF5u8o9Fvk0t5L5xAYkqxjO3v1L9/AirRFIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apsm+kdtZXplWKLlpD9hGjfN1g7rvxKrEK8oqlYcBT9qXglH2Bkn7CFetjBy2j/RtPUHrvloteXtBhSKLza9pPAXb+w0nljN+PPOW6vmhvYHRvgR9y2FL2bRSUGeuAexxuzzWYEEHUbs3ZoOuG/iqpm1QSXHV9JIUdwkC0tRuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=PI88+wa7; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=Ns/nKD/S; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="PI88+wa7";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="Ns/nKD/S"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id B0D6A61377; Thu, 12 Jun 2025 00:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1749680093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KJyoMUaKc/mGGLj5VfLeqQWjsP7Hti+2BF0DboQRpc=;
	b=PI88+wa7qZ72Oq/S+mCI7fj+pMGT69VO7f9h/TgqXIRhI2XkMD3AyRIA0kphAQhK9yJvEe
	i+UJpPBz1JZF/Z5+JzTIDLcLsXL6B7XF8jEVtckXKBlrAMwY/Pc11Qsfc4JLvfqZBDC1o1
	9tBro4ISeo8+BeSJslpJi+oSgIusIjKWN5JcXiivhZ8L3xF/8EgtkX7HWlzawA7RSRJdac
	N9SrkH9AGG+JuSgurBL05viF15VmcnOfs5gfepSmRPoh8JEhhwWk5QsQxw0p5s79Lgp134
	v5xN0q2VRg7mwb9uk2aBGvxtdf7h3v7aNGcXY3UmzCtCDA55EYRXTr62x56YSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1749680093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KJyoMUaKc/mGGLj5VfLeqQWjsP7Hti+2BF0DboQRpc=;
	b=Ns/nKD/S9QrDzgrh7xzu8SUQPfxTFvnEr7XHSSrCcWbexhCOa8AzdfBffmNBMme8H52peX
	a9Kcbqk+qSKCPCAA==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v2 6/6] bswap.h: Provide a built-in based version of bswap32/64 if possible
Date: Thu, 12 Jun 2025 00:14:43 +0200
Message-ID: <20250611221444.1567638-8-sebastian@breakpoint.cc>
In-Reply-To: <20250611221444.1567638-1-sebastian@breakpoint.cc>
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The compiler is in general able to recognize the endian shift and
replace it with an optimized opcode if possible. On certain
architectures such as RiscV or MIPS the situation can get complicated.
They don't provide an optimized opcode and masking the "higher" bits may
required loading a constant which needs shifting. This causes the
compiler to emit a lot of instructions for the operation.

The provided builtin directive on these architecture calls a function
which does the operation instead of emitting the code for operation.

Bring back the change from commit 6547d1c9 (bswap.h: add support for
built-in bswap functions, 2025-04-23). The bswap32/64 macro can now be
defined unconditionally so it won't regress on big endian architectures.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 compat/bswap.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/compat/bswap.h b/compat/bswap.h
index ed00f6d1d53f3..28635ebc690e3 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -32,6 +32,14 @@ static inline uint64_t default_bswap64(uint64_t val)
 		((val & (uint64_t)0xff00000000000000ULL) >> 56));
 }
=20
+/*
+ * __has_builtin is available since Clang 10 and GCC 10.
+ * Below is a fallback for older compilers.
+ */
+#ifndef __has_builtin
+# define __has_builtin(x) 0
+#endif
+
 #undef bswap32
 #undef bswap64
=20
@@ -46,6 +54,11 @@ static inline uint64_t default_bswap64(uint64_t val)
 #define GIT_BIG_ENDIAN 4321
 #define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
=20
+#elif __has_builtin(__builtin_bswap32) && __has_builtin(__builtin_bswap64)
+
+#define bswap32(x) __builtin_bswap32((x))
+#define bswap64(x) __builtin_bswap64((x))
+
 #endif
=20
 #if defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && defined(__BIG_END=
IAN)
--=20
2.49.0

