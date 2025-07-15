Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02202E03F5
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606779; cv=none; b=Wp14o5JZveh1GZc0awpHmSTL3AmmxXonNOrrBcuZUASJCMntwcBhgAMOf5OVUoEYjdi9bkmS5+nFYaVFsw6MI8W95DCnh+/bwO9kFj2LpfYAm0ZHo7VrHXhtAwaFbFcBoECJnH2Nk1i2EtcXPDB07d0PxwRg6uFv6hPPSQfel+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606779; c=relaxed/simple;
	bh=C7Evih/aqnGzmjt6zx9luszvb4rqiKx+Ii/93RaQAt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CocdGBf+NJZHlA+wAggOQCG4FdZU4459AsXpIApY9VS0+bxeDJNNyBRpE4sEWJu+NP06jkEqh5EGSE774D+R1OoAArQByJVg8nbWON7rrxYP8Md2dv2opHyu4YM92d+QPeSutLR3Es0HYyF4+lKEPdjrbdgkd7FNj7bzjx/KD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=G5YUYXWd; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=WknT3KKx; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="G5YUYXWd";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="WknT3KKx"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id 6C276618EB; Tue, 15 Jul 2025 21:12:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1752606772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yTsTwPJLBTkEhz4EpzxjkV6EStVEkebAhswnM6CjgE=;
	b=G5YUYXWdUZAyaqrYZeyg86kOGhgcAdU3rbExml1bVq9cmsTVElnX6ibitIHDv2OK0HDrWW
	/mvbak4GWNAGXbbKoq7HAW8onWWGtbc0dLja1m7ksNK4Bwl7DzRLCL8Q3x2/dMNlBbsudt
	EGhRJT3AaHrJSmXt3cCc+JhlMxAnWlyEDe5mg9qSh8D1vaPl33SexfD3TZwEokgl94kZLJ
	/6pTuX9xwr/vhxUuXCNKRWZz2vILMgPIgvf1HT2qu0WI/rYJTv4VRHOIXRurK4ezqjM/Lh
	ok+4XZRIQp7Q/3Jc42JDefFHtnO5sFSF1WiEAzfh76hwcIanM9L2C7ka+U9OsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1752606772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yTsTwPJLBTkEhz4EpzxjkV6EStVEkebAhswnM6CjgE=;
	b=WknT3KKxVP5CkzgNvJ1+xxs9AuXAJrMoh/sjYkMpsGSRtRAXFfD46ZeSwhYl0RYzdNyWXd
	+r60sQ7qeaa7rJAw==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v3 3/5] bswap.h: Always overwrite ntohl/ ntohll macros
Date: Tue, 15 Jul 2025 21:12:28 +0200
Message-ID: <20250715191230.12081-4-sebastian@breakpoint.cc>
In-Reply-To: <20250715191230.12081-1-sebastian@breakpoint.cc>
References: <20250715191230.12081-1-sebastian@breakpoint.cc>
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
2.50.0

