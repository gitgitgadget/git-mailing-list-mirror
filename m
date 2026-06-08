Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1058231835
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922749; cv=none; b=nK1pcsUHmXY6kENYQdjmb1vjC1w8wiODl0PfX+WnXDGWUsxdYPq8ibTEUi5fbpJQxRYfya0QNnrPGK+/HFgb9H3XSI0XDWV8ZrvrxsnbTuh0qwjo/CAieO6vFtdBmUmbBjuVlwyXff/0rbcxolzp0Y1a0dI4rau3f2u8c5y1kcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922749; c=relaxed/simple;
	bh=yVIuB7fRLou2ts3HlYfHL7hVrZuzfnYOwWfl3O5Keps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSBz95KgcrahdGl9NHYB7o6949LDBhmVy8UtXzaWw/S4DumpugeVsBC1Z9Evfm+LlbNU67d8MQCd4jgPtFRGn4q+xVG1nfxDD2+i7nrMS2lXmRdxfzu50fFVLSHBrBBYbCg2F1iYv89xpiWpzOvMiMJGdXZem8IcQKZlQiql5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=czoTPFbT; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="czoTPFbT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aP3bUpG8xIRkLFCIIphqA8r5hsEgolyqbI0Vj6Zirm4=; b=czoTPFbTckMupdNqRf4gm+4JTN
	xy1c6dIzjgHTS5ll/aguymjh4+g0pX5m/QCkRQvG7B+ZiSb+MDO9H34e9Xgaflf8uLASujH3lXZvZ
	OIPZOG4Yz/euFZFOI7A5FUNaBoprI2UfodhzNCg2pbgADTKuNFQ3p/fBROtx2r6OwHOh+wthew6Uc
	EzlY2PwF7IGDVwjniiL6RwKClfaiGvTOq8aVsL2LH7qVwJjXWXvVExmyPEMxcfFLyRbBwy8LnxYiG
	/6epRsW0k1sgmWuovajZf7Jpxspul+Yc1zwzSnJDZl3sxD7INjjHbz45/l+98Eo5WQ4DhrjJlk725
	mkRzzkuQ==;
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wWZMK-0000000DQq9-2NzF;
	Mon, 08 Jun 2026 14:45:40 +0200
Received: from [2001:62a:4:42c:9c6e:8d7c:8076:a7dd] (helo=eduroam-077-080-000-213.wlan.univie.ac.at)
	by joan.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:x25519)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wWZMK-00000005u8X-1ZgP;
	Mon, 08 Jun 2026 14:45:40 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	asedeno@MIT.EDU,
	asedeno@google.com,
	avarab@gmail.com,
	Dominik Loidolt <dominik.loidolt@univie.ac.at>
Subject: [PATCH v3 2/2] compat/posix.h: simplify GIT_GNUC_PREREQ() comparison
Date: Mon,  8 Jun 2026 14:44:19 +0200
Message-ID: <20260608124419.38905-2-dominik.loidolt@univie.ac.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
References: <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
 <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Univie-Virus-Scan: scanned by ClamAV on joan.univie.ac.at

Replace the glibc-style bit-shift version comparison with an explicit
major/minor comparison. This is easier to read and is consistent with
the format already used by GIT_CLANG_PREREQ() and many BSD
<sys/cdefs.h> headers.

This has no runtime impact, as the macro is evaluated at compile time.
It is also more future-proof, as it no longer assumes that GCC version
components stay below 65536.

Signed-off-by: Dominik Loidolt <dominik.loidolt@univie.ac.at>
---
 compat/posix.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/compat/posix.h b/compat/posix.h
index ffdfd91c7b..deefc43f28 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -4,22 +4,24 @@
 #define _FILE_OFFSET_BITS 64
 
 /*
- * Derived from Linux "Features Test Macro" header
- * Convenience macros to test the versions of gcc (or
- * a compatible compiler).
+ * Convenience macros to test the versions of GCC (or a compatible compiler).
  * Use them like this:
  *  #if GIT_GNUC_PREREQ (2,8)
- *   ... code requiring gcc 2.8 or later ...
+ *   ... code requiring GCC 2.8 or later ...
  *  #endif
  *
+ * Note that Clang and other compilers define __GNUC__ for compatibility; use
+ * GIT_CLANG_PREREQ() to check for specific Clang versions.
+ *
  * This macro of course is not part of POSIX, but we need it for the UNUSED
  * macro which is used by some of our POSIX compatibility wrappers.
-*/
+ */
 #if defined(__GNUC__) && defined(__GNUC_MINOR__)
 # define GIT_GNUC_PREREQ(maj, min) \
-	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
+	((__GNUC__ > (maj)) || \
+	 (__GNUC__ == (maj) && __GNUC_MINOR__ >= (min)))
 #else
- #define GIT_GNUC_PREREQ(maj, min) 0
+# define GIT_GNUC_PREREQ(maj, min) 0
 #endif
 
 /* Similar for Clang. */
-- 
2.54.0

