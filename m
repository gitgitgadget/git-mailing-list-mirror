Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A12D3738
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606775; cv=none; b=nyVXRdLIj4t6SLz96N3cYTjaDrohXfeOZK/scZINe7pPxWCiOcC3M50sWWicrtKmyx3x2rrxXVZNspNeDZqNWQm4VTI5lXWP0OZ+IlVSdi13tKuJF3Mlsv1bakRV0TmpoAO0laboDgtobUkpoNNzmjPBW2A7z2gotwuxAVA0Wy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606775; c=relaxed/simple;
	bh=SmZ1hRyd5r+OGf3Fnso+QF1IHI38YbEmEHsbbVU33ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuVQOut+JaNN+dvSynH7Yv5VIkHuphgUUAXsTaTcwkXXaxh9w8v5BcpidKWrX3+FPun8K17BS/0MTfBeDupwpwbVb5/rbpx/4oNLXtQg1YJogyc9C0LYnuIMYZM8wh0zANLKrqtPRDe38hvX3AoI/rQTz/L+GZrZZLbEVreDNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=ahxuN6dS; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=XiNW+CCU; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="ahxuN6dS";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="XiNW+CCU"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id 56743618E6; Tue, 15 Jul 2025 21:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1752606772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmZ1hRyd5r+OGf3Fnso+QF1IHI38YbEmEHsbbVU33ao=;
	b=ahxuN6dS6yW97QNOf5V3YP4DZ5G3OniuZhMPR/CNpwJm2TkKbBO+zTKAttlerg7h5O8jY6
	T7NF7V55cQFJqcVjQ4d76QYJ7qVNpzMZb//lcFjAa6NhHk/kPySn/rZbRqXLFw97+TDSLm
	7Xy3rTfeqWyc5W2plisANJmKJrK2s4YKfYn9ZCn3OQaYcepYYIH3Z6Zy7wLHzzlegbQPzp
	bDNLCzMI8DSZaXM8Yld0IxVYq+Jaq5apJ4/WNA4Z9WRgHdvzCHxwHSxGvQ9KdS3QGQx1Fd
	gGzbeuvNkGJQqyS753I+Z8ipfU9PcVk8caZnBPHM3Rgm4rZcwMddHlt4ZB4f8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1752606772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmZ1hRyd5r+OGf3Fnso+QF1IHI38YbEmEHsbbVU33ao=;
	b=XiNW+CCUjgqrkHcsoH1b/4IlUUadXM2HK2yp2b2dJhpiJ/tGVcofJxNp3IcKOyMjjhonBV
	cP1DQ6bSfIGIurBw==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v3 1/5] bswap.h: Add support for __BYTE_ORDER__
Date: Tue, 15 Jul 2025 21:12:26 +0200
Message-ID: <20250715191230.12081-2-sebastian@breakpoint.cc>
In-Reply-To: <20250715191230.12081-1-sebastian@breakpoint.cc>
References: <20250715191230.12081-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The __BYTE_ORDER__ define is provided by gcc (since ~v4.6), clang
(since ~v3.2) and icc (since ~16.0.3).

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
2.50.0

