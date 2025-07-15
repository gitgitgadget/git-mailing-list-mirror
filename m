Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471F22BEFE6
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606776; cv=none; b=Rh9ycFmwvcr+SZoLHRkm+4he5LNe4mGYzc8ZV4JX1PlNPqXgo0b5bPgvv5jeO2zR4+w6lf/RLb5erFYbZgW6MxpkvpjMxzi5imTL2N/m+IHeL/5Rea3HJ6qyeovWSDwABtINxBqYV/nqg0l9us/Z371RfUCwPBbB0fcX4976I+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606776; c=relaxed/simple;
	bh=jfZ+rR6zxsr6uRM5G0EbqffOfaQZLUxg3O8GLSXfvL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj33fyPMsM/ahUECeqqjKdwILdTN6re8vp7+e6gn2/gu0qwHjwlmZ0MVoeqCkH9BPoGfCNBRZSI+cdsyUkls9eSdsSXiz6l46uWNAi+RrC/GEkw5YQS4wU1r5XxcoWP0hTmsT27n7CpYxR0iJABNNLukips/d/WTIwnRlGQsuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=EM5pTdUx; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=RL6sDXoL; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="EM5pTdUx";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="RL6sDXoL"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id 64A91618E9; Tue, 15 Jul 2025 21:12:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1752606772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBnrtRwCqcLzRsrMdfrwkRhdRGVbrjL6/uCM4Il8oWs=;
	b=EM5pTdUx05bCigZvwaxkl8LE4LAEXyi/mkVqt/tPra4oB4rX48k19s3NclsljzbBROX/ng
	gwDo3donJ99vHiMdNUMGRK6dlEf2n3Qrzs6EPslLMKhidsrQWjuFNIqO0RuQhHnbAfv14z
	cL0/q06TfZ0JuhNU8XSfguH9Ao4GoyIrtFvSF63a+3dHtQ9QzUa2P83fkPYXKIEyM+Hzvc
	uROFjyZV2aBHFrAfuWBm61khYbnQHERgSg9nfNyM4VHd8ZKKC8MDlXgzPTkACTAcxHcr6x
	qDigZX+G0FCR8CS3cW8cpjCLd5NRvo/kLXXvZuXKmX6sUzX60n1YJZlAS6RwsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1752606772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBnrtRwCqcLzRsrMdfrwkRhdRGVbrjL6/uCM4Il8oWs=;
	b=RL6sDXoLxvJXGduNfO1dz5UiUXeFZrarRfbeMNf05hyiIHIciZMgPl6ovKxjyVJbh2I5xD
	/NOfk+oEwrkBsJAA==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v3 5/5] bswap.h: Provide a built-in based version of bswap32/64 if possible
Date: Tue, 15 Jul 2025 21:12:30 +0200
Message-ID: <20250715191230.12081-6-sebastian@breakpoint.cc>
In-Reply-To: <20250715191230.12081-1-sebastian@breakpoint.cc>
References: <20250715191230.12081-1-sebastian@breakpoint.cc>
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
2.50.0

