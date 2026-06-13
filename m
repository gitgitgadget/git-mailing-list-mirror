Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1C3E0C55
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781353690; cv=none; b=A9+ZU9mSaYgAHg799ja2ZhVbwQZrJ0IMJ8j79ocvkkO4T+ZtS8sDciTdX14oNs7OvRStrlWNTivdX/s/sKlRW9qZiRGdPxovwC5c9oL5R1l4ptVwg/pJ+hIGsKqGmGD2XR+NzLLU1Jf4hf1zpa3BiEnBv84H68+ZEA7phJSc3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781353690; c=relaxed/simple;
	bh=E9PGUHZcAdsiEML7OSDNWw4OSosHn7b2rpZ5SpyEve0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR9sgK+v0mdneKud9RfZ9WcHFqod0h1TtZ/2gF/XaMD8XtkNY4ol7U9WzcYyZIyDV7rhC3vPCQ2KjzzE7o9yLONZpl88WAXr36JVU5+ZaU4QULlBC3jnMnfIlV9+JRny7B3O9f3OQ3lU+0qQzrBwNOPvSykk+U2jbT7IQMpiaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=bYzRiO/I; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="bYzRiO/I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LDK2CI+EjK/psh8gloQH3/SlgzB4SkITpYZufC1v9Sk=; b=bYzRiO/IUo3h4brgfi2kOK2OZo
	BCo93AKHSnNTZCc45BA26I1ojUAZwx9QqRPrI7bcHx/JhKOyqnBefixbojFdz5WrJ1B5iMzNByB7A
	yBzbz+PSwxdy0RdQ1eoD1mk85fYK/oOPVh9cjYsD418hrFcbMshMiwqTFXcz5kjAXiR+KayFez9x4
	+fSj+/ZknPl8DgNuGnVsDQH5NimCfNZWPF/7O38DWBEVVVPl/xrIv55F1QG17UkORuNsAJxCjdiZ3
	cJWYJvHLhGCuLzGovhWJUnhDe9mRLUXNvbOsnAAPIcV6IZOv7DTjigO5qmktCr51gj7pwmZoLq6/1
	moxYDIGg==;
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wYNT2-00000007413-07HN;
	Sat, 13 Jun 2026 14:28:04 +0200
Received: from 84-115-215-81.cable.dynamic.surfer.at ([84.115.215.81] helo=localhost.localdomain)
	by joan.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:x25519)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wYNT1-00000001VX9-3Tnx;
	Sat, 13 Jun 2026 14:28:03 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	asedeno@MIT.EDU,
	asedeno@google.com,
	avarab@gmail.com,
	Dominik Loidolt <dominik.loidolt@univie.ac.at>
Subject: [PATCH v4 3/3] compat/posix.h: simplify GIT_GNUC_PREREQ() comparison
Date: Sat, 13 Jun 2026 14:27:11 +0200
Message-ID: <20260613122711.38662-4-dominik.loidolt@univie.ac.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613122711.38662-1-dominik.loidolt@univie.ac.at>
References: <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
 <20260613122711.38662-1-dominik.loidolt@univie.ac.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Univie-Virus-Scan: scanned by ClamAV on joan.univie.ac.at

GIT_GNUC_PREREQ() uses a glibc-style bit-shift version comparison,
which is harder to read than an explicit major/minor comparison.

Use an explicit comparison, as in many BSD <sys/cdefs.h> headers, and
drop the Linux header attribution comment because it no longer applies.

Signed-off-by: Dominik Loidolt <dominik.loidolt@univie.ac.at>
---
 compat/posix.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/posix.h b/compat/posix.h
index d2de5cedf5..2f01564b0d 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -4,7 +4,6 @@
 #define _FILE_OFFSET_BITS 64
 
 /*
- * Derived from Linux "Features Test Macro" header
  * Convenience macros to test the versions of GCC (or a compatible compiler).
  * Use them like this:
  *  #if GIT_GNUC_PREREQ (2,8)
@@ -19,7 +18,8 @@
  */
 #if defined(__GNUC__) && defined(__GNUC_MINOR__)
 # define GIT_GNUC_PREREQ(maj, min) \
-	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
+	((__GNUC__ > (maj)) || \
+	 (__GNUC__ == (maj) && __GNUC_MINOR__ >= (min)))
 #else
 # define GIT_GNUC_PREREQ(maj, min) 0
 #endif
-- 
2.54.0

