Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29ADB672
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245731; cv=none; b=Rr5FGQaNAKgPk5moP0MR2dH2UPyDHeAdcAS4oEQ8YdEWo/wmBXSBIIkbx6hC87WMPtZcKjy/S9bC7L/qQHAx9WRf3YSM5zwFAaz2TJPoWzexPONTku88YEN37+Jbe/Y/ie5I/sy2hCEwBJfPO7PsLhItoGID3VjzZitzhbbgjFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245731; c=relaxed/simple;
	bh=pXD84Cbd5kBYL5tQGLfpZju8CFSwvJDoGp06DaBwtns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntpo+78D+CedHT8wLUYG4+gfssVMywG+xseFLd5d5hCy2F5n1SR3udJDWONLrjP+ESDzRajJJ+AqpDkT6gToRcBUV8+YcYg3GGr/YJpgFrSpXavJQCxmjYUrisnd/hMyHv5memQuQ1YIQK6LZUkxN7YJSjyeWTDkxCf6+KM8Ix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BVMA2mqf; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BVMA2mqf"
Received: (qmail 110188 invoked by uid 106); 23 Mar 2026 06:02:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pXD84Cbd5kBYL5tQGLfpZju8CFSwvJDoGp06DaBwtns=; b=BVMA2mqfwKuca0fz8Cn/z7l9MG3ocfxQjgwgwL9wWpVeKp6oda6/G4ObPg4TS1i8HgZ2bwi1B7NpNoaodLJMr/Dv1wyofGx2iyu4mEC7Jd0rCjPlKvPIrQfCi+95IawSCy/zOl1clloEjnr66V2gPLOvl1S5KFY0X5WLbjatN+sJpODWhYXPGKzLBJkWCA09FsxDaYCMCPAtQf6UX7thM4GHny4FcqF5Tcd2x37Pd/Js5vCFWkC7ffKhn3krP6zXTwvrQs+eXyqcK90kvnHIN1z3QiNsSaLaK7nfqh4bqLPW0ZrIi5Kv7aT1K58RJteoXv6VApuly2owNZHuukBxIw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 06:02:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 146994 invoked by uid 111); 23 Mar 2026 06:02:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 02:02:08 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 02:02:07 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>, Scott Baker <scott@perturb.org>
Subject: [PATCH v2 4/8] t: add matching negative attributes to
 test_decode_color
Message-ID: <20260323060207.GD10482@coredump.intra.peff.net>
References: <20260323060139.GA10215@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323060139.GA10215@coredump.intra.peff.net>

Most of the ANSI color attributes have an "off" variant. We don't use
these yet in our test suite, so we never bothered to decode them. Add
the ones that match the attributes we encode so we can make use of them.

There are even more attributes not covered on the positive side, so this
is meant to be useful but not all-inclusive.

Note that "nobold" and "nodim" are the same code, so I've decoded this
as "normal intensity".

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib-functions.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 14e238d24d..f3af10fb7e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -48,6 +48,9 @@ test_decode_color () {
 			if (n == 2) return "FAINT";
 			if (n == 3) return "ITALIC";
 			if (n == 7) return "REVERSE";
+			if (n == 22) return "NORMAL_INTENSITY";
+			if (n == 23) return "NOITALIC";
+			if (n == 27) return "NOREVERSE";
 			if (n == 30) return "BLACK";
 			if (n == 31) return "RED";
 			if (n == 32) return "GREEN";
-- 
2.53.0.1051.ga14e96f895

