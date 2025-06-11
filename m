Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48927248F7E
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680106; cv=none; b=URkf49GFvyeYju8X4/fgmMk/QZBtnQt8SLMHIbzzxEr9LqC2uLniOG6d7pRvc/3gdR+9S+BmKT672f1U5N71J4rcNujtRjHtVtbxMie24KuIrqSVybGDOLAopX9z9Qh/GNQawfKaoixrQ7igT052tY6EZhQdjKYC7rsb/beyVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680106; c=relaxed/simple;
	bh=1IRRAdTznqLSjXX/4iPYBNt060k/X2YOtdCNWQreyGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdI82KoX6qStVjwtwgN2m/XvzrOqXH0Je9CVr5qqTJ8DgKhSoowJFUDiWcacSRLBu8um3mi/64TMNqA0WAeaPePOO+S4cwa49JC6D9HCdv7mY4aG0OflNmRyb8Rxm+NPQDxzd3K0BeMEUYtJ0+p8oYhxXCcXIOQ/7AfPS9NLOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=U6eIkCxh; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=RcESsm57; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="U6eIkCxh";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="RcESsm57"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id BD1C861383; Thu, 12 Jun 2025 00:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1749680093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRxM2AjHiwBhfMICja7Uti46TcK0e+9ILbqHwoH1V1E=;
	b=U6eIkCxhzwpzjZDB+YuR7SYHKLI5vXeinDEVwaoqwqE6ihMNhaOzvRoLgHnuHSNCVQm88A
	9U8kkNG86OU5s9lfjpE0iXgbZjTEPu0osUXX9evMj0FOTlEo/dF+XziriNCILHKMsEnbHi
	EMJZsMh7XFwe0LLJnekuR8cvSb5sUa7ZnU9Dh+wh0XAXX9bSlC8/tFyQrQeYHdPQFK3SRO
	UX+vbO++lOMNC+21rdzptcDaGU55U405DrjnQy33aCvnN4coatQKWbt9m3x5pCS42z5UhM
	qCQPyVtJ911j0Yncr0OOVw/WftMsBRhXIrUosbtd1DKTh4DY5v16UdKg4XRvbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1749680093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRxM2AjHiwBhfMICja7Uti46TcK0e+9ILbqHwoH1V1E=;
	b=RcESsm57OjNl/ZwRXaOw/H0s8phOj04g0DjzKxrux+AVQcAtmgZ0ORddijQYm2siBK/6XL
	c32ovIE2SX5ke6CQ==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v2 4/6] bswap.h: Always overwrite ntohl/ ntohll macros
Date: Thu, 12 Jun 2025 00:14:40 +0200
Message-ID: <20250611221444.1567638-5-sebastian@breakpoint.cc>
In-Reply-To: <20250611221444.1567638-1-sebastian@breakpoint.cc>
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ntohl and htonl macros are redefined because the provided macros were
not always optimal. Sometimes it was a function call, sometimes it was a
macro which did the shifting. Using the 'bswap' opcode on x86 provides
probably better performance than performing the shifting.
These macros are only overwritten on x86 if the "optimized" version is
available.

The ntohll and htonll macros are not available on every platform (at
least glibc does not provide them) which means they need to be defined
once the endianness of the system is determined.

In order to get a more symmetrical setup, redfine the macros once the
endianness of the system has been determined.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 compat/bswap.h | 54 ++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index fd604d9f7b74b..aeef304f671f5 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -87,27 +87,6 @@ static inline uint64_t git_bswap64(uint64_t x)
=20
 #endif
=20
-#if defined(bswap32)
-
-#undef ntohl
-#undef htonl
-#define ntohl(x) bswap32(x)
-#define htonl(x) bswap32(x)
-
-#endif
-
-#if defined(bswap64)
-
-#undef ntohll
-#undef htonll
-#define ntohll(x) bswap64(x)
-#define htonll(x) bswap64(x)
-
-#else
-
-#undef ntohll
-#undef htonll
-
 #if defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && defined(__BIG_END=
IAN)
=20
 # define GIT_BYTE_ORDER __BYTE_ORDER
@@ -145,14 +124,33 @@ static inline uint64_t git_bswap64(uint64_t x)
=20
 #endif
=20
-#if GIT_BYTE_ORDER =3D=3D GIT_BIG_ENDIAN
-# define ntohll(n) (n)
-# define htonll(n) (n)
-#else
-# define ntohll(n) default_bswap64(n)
-# define htonll(n) default_bswap64(n)
-#endif
+#undef ntohl
+#undef htonl
+#undef ntohll
+#undef htonll
=20
+#if GIT_BYTE_ORDER =3D=3D GIT_BIG_ENDIAN
+# define ntohl(x) (x)
+# define htonl(x) (x)
+# define ntohll(x) (x)
+# define htonll(x) (x)
+#else
+
+# if defined(bswap32)
+#  define ntohl(x) bswap32(x)
+#  define htonl(x) bswap32(x)
+# else
+#  define ntohl(x) default_swab32(x)
+#  define htonl(x) default_swab32(x)
+# endif
+
+# if defined(bswap64)
+#  define ntohll(x) bswap64(x)
+#  define htonll(x) bswap64(x)
+# else
+#  define ntohll(x) default_bswap64(x)
+#  define htonll(x) default_bswap64(x)
+# endif
 #endif
=20
 static inline uint16_t get_be16(const void *ptr)
--=20
2.49.0

