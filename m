Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D737246765
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680103; cv=none; b=Uh57zVp5wpuUxaL4QhitUILrAMFNNOmEmXt3BsCcVVqsLBHhAK7b9NO15Q9Q2leDndKM8rLFgjOn2HDXaE0V4cN81HzfILT/mhsCw7IIZU2t9g1zpLqeDVxmc1UwGZWSsGBH+Z2Lg342y7Gpsu8y6tRtwtnmyOHvCj7vKvLVb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680103; c=relaxed/simple;
	bh=IGk0zRd34DheNNGsP4/Jk+RIq83s60qDEeC5K7GrVmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6q1WkJP5NaAmxDcAlfUFweTGrJnLIqQeCwJKwAPOfIPEyn4FFOJUbd5VzPs9VVDzV9kvm/o6G0K7bfBz1IcUSXs0MhjqJnic1UEM3bbcg81aUT64gqAmzkxWLZEUdq36+hB+B8/RutwEEuzhskCfpej9+uakgHSyVdm0jdeyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=Ldma7ka/; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=3xO6rzjC; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="Ldma7ka/";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="3xO6rzjC"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id E2663604FB; Thu, 12 Jun 2025 00:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1749680092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGk0zRd34DheNNGsP4/Jk+RIq83s60qDEeC5K7GrVmU=;
	b=Ldma7ka/GrlDa1HS7IxZeGmrXp8Pz5bKFbm7sADbo9EUSXfdQx3926KrVNacVDe85g/gzk
	ildeLpjH9nPFDAtytz2cb3Db7RSdBI7FB59bvtbwJEdCWdneuFhb95u4o46/IuELHEAEGC
	wgFH88feSvfduIYPM4rBUFDm4Wrog5+/icHp2S+CmVXWmsHyI6oHc3kKerDGcS/zhp1fiP
	74Vd9E2V/+FdZuS2Hvp/keiIcnmqcqMhavLpulzGHIB85kdC7vUC2tCdo9Ec+Y4yUoX6BN
	2MfOT6QcG9WBK4mMPVWa3f35CihdYXy1Of3v+Zjsn/TbUaNTqCY7aPC9PDgeSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1749680092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGk0zRd34DheNNGsP4/Jk+RIq83s60qDEeC5K7GrVmU=;
	b=3xO6rzjCzTkpJPsVOYhWvEbkpwB6swLchD6OIGGB2NiPWt5ToT8l0UPnBUDYmuccz+rL1g
	x5wJTaNQnW7MUrBQ==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v2 2/6] bswap.h: Add support for __BYTE_ORDER__
Date: Thu, 12 Jun 2025 00:14:38 +0200
Message-ID: <20250611221444.1567638-3-sebastian@breakpoint.cc>
In-Reply-To: <20250611221444.1567638-1-sebastian@breakpoint.cc>
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The __BYTE_ORDER__ define is provided by gcc (since ~v4.6), clang
(since ~v3.2) and icc (since ~16.0.3). It is not provided by msvc as of
v19.43 / 17.13.6.
The __BYTE_ORDER and BYTE_ORDER macros are libc specific and are not
available on all supported platforms such as mingw.

Add support for the __BYTE_ORDER__ macro as a fallback.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 compat/bswap.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/compat/bswap.h b/compat/bswap.h
index b34054f2bd728..0a457542dd76a 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -116,6 +116,12 @@ static inline uint64_t git_bswap64(uint64_t x)
 # define GIT_LITTLE_ENDIAN LITTLE_ENDIAN
 # define GIT_BIG_ENDIAN BIG_ENDIAN
=20
+#elif defined(__BYTE_ORDER__) && defined(__ORDER_LITTLE_ENDIAN__) && defin=
ed(__ORDER_BIG_ENDIAN__)
+
+# define GIT_BYTE_ORDER __BYTE_ORDER__
+# define GIT_LITTLE_ENDIAN __ORDER_LITTLE_ENDIAN__
+# define GIT_BIG_ENDIAN __ORDER_BIG_ENDIAN__
+
 #else
=20
 # define GIT_BIG_ENDIAN 4321
--=20
2.49.0

