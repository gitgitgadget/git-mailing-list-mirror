Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E627F4F5
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781353689; cv=none; b=S7Srr/r4W5kDj9WZhEsvU9BDqRdgf4GrSe8Y4+U8TZSmRdox7kGDew/kUCV4TllKmHCz9kdawz0jf/v9kc5e1RhkJDAZgLR0At8MmINYZdVOlhec37tVnLT74Np/1WLftifyYCrvt+8C4EKm6MnzsWbTYjgtpnVe6Mi2R7lussY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781353689; c=relaxed/simple;
	bh=LXrQhEbNMnRkv7WyuTNSYRvek6ytaq3DB/lOeFZEKKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltPjW5ervt7mXeTjKhyqQIj7y8N1E4/K2oTT6Zp0hAnDcpmuNb6HNodEQu+79GEdb5vp3eEZ4EMPL+UMZDCT0Ox4ppQOGL8s+dPj4O7PtVq4H799yHPmtP9EFEJTU2UaS7uAnReX+Q6yJCZkpGFAkLsFHdF/cH4S/azzRwgwBM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=U1yuu8HY; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="U1yuu8HY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=u9fWBKspkpFR9+E5Nnv11q0QqHZR3FPSvzwNTcsnIxA=; b=U1yuu8HYGhTY+n6wbDmHD9xtHT
	r+ZSeNuWogVnHOj1zIcHe8N1bCYqDBo/7hPKRitnCenqe6z8jzcI7G/6HNQNdyrD5qFEgKZAqHVyp
	VV8RuR22obbicA65mIgR26++rVQPPAOINlBUI8G4HQG4w1tD5zHkhMayCrtVmnUcIitOPcmHr6vwH
	VGP7HzqgMchVf3t1ivrXP/peqhMkgxsndn9cD1/tBMBb/hg4uTDxPK69H5Zo0Dm2HX7Z8cV4jpXT1
	8JuuW2+StWz/8wwdm/yQkU7eqXWAwKYIoDdLne1SeKMnKaX78ckAtnjA3ciNSQ7b4kvSImYXRHP1X
	wx3A0OpA==;
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wYNT1-0000000740w-3KxL;
	Sat, 13 Jun 2026 14:28:03 +0200
Received: from 84-115-215-81.cable.dynamic.surfer.at ([84.115.215.81] helo=localhost.localdomain)
	by joan.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:x25519)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wYNT1-00000001VX9-2UVd;
	Sat, 13 Jun 2026 14:28:03 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	asedeno@MIT.EDU,
	asedeno@google.com,
	avarab@gmail.com,
	Dominik Loidolt <dominik.loidolt@univie.ac.at>
Subject: [PATCH v4 2/3] compat/posix.h: clean up GIT_GNUC_PREREQ() and UNUSED
Date: Sat, 13 Jun 2026 14:27:10 +0200
Message-ID: <20260613122711.38662-3-dominik.loidolt@univie.ac.at>
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

Fix the preprocessor indentation of the GIT_GNUC_PREREQ() and UNUSED
macros according to the CodingGuidelines, without changing their
behavior.

Adjust the spelling in the GIT_GNUC_PREREQ() comment block.

Signed-off-by: Dominik Loidolt <dominik.loidolt@univie.ac.at>
---
 compat/posix.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/compat/posix.h b/compat/posix.h
index 273cb87101..d2de5cedf5 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -5,11 +5,10 @@
 
 /*
  * Derived from Linux "Features Test Macro" header
- * Convenience macros to test the versions of gcc (or
- * a compatible compiler).
+ * Convenience macros to test the versions of GCC (or a compatible compiler).
  * Use them like this:
  *  #if GIT_GNUC_PREREQ (2,8)
- *   ... code requiring gcc 2.8 or later ...
+ *   ... code requiring GCC 2.8 or later ...
  *  #endif
  *
  * Note that Clang and other compilers define __GNUC__ for compatibility; use
@@ -17,12 +16,12 @@
  *
  * This macro of course is not part of POSIX, but we need it for the UNUSED
  * macro which is used by some of our POSIX compatibility wrappers.
-*/
+ */
 #if defined(__GNUC__) && defined(__GNUC_MINOR__)
 # define GIT_GNUC_PREREQ(maj, min) \
 	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
 #else
- #define GIT_GNUC_PREREQ(maj, min) 0
+# define GIT_GNUC_PREREQ(maj, min) 0
 #endif
 
 /* Similar for Clang. */
@@ -48,13 +47,13 @@
  * compilation, consider using MAYBE_UNUSED instead.
  */
 #if GIT_GNUC_PREREQ(4, 5) || GIT_CLANG_PREREQ(2, 9)
-#define UNUSED __attribute__((unused)) \
-	__attribute__((deprecated ("parameter declared as UNUSED")))
+# define UNUSED __attribute__((unused)) \
+	__attribute__((deprecated("parameter declared as UNUSED")))
 #elif defined(__GNUC__)
-#define UNUSED __attribute__((unused)) \
+# define UNUSED __attribute__((unused)) \
 	__attribute__((deprecated))
 #else
-#define UNUSED
+# define UNUSED
 #endif
 
 #ifdef __MINGW64__
-- 
2.54.0

