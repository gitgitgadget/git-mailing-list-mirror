Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3724CED5
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845610; cv=none; b=YlHCs2C7HBRFcYpiilYd+SJ6odHggRVe7gmWn7qVLpR5L+bLEp/f8KS5dbwBmJdtm6YfL57Y4D61iUsaMW0+97HFKqc+lJi7ty6jow/icnIcEC9Px9t9HwGw42JFlzrsSM1T76F1LbW3wkhHiyb3w+NgucPnMPithurTGo/sz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845610; c=relaxed/simple;
	bh=WtfZUAj+05DvD5rmKPASKOSXyMDIyw7o2p/P4nBP/9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK5YB8bKA2L0sA3QL3IANokfEeE2QUIZZtq4+GeQ+uOP3GLAKJTRjlzOV8t3g7Ew1t++RPKwqs2RkHRWhFLHggtroQ8xu1iAhSsD6iF1la0GE0cX7ijDIEUcHFIBePrqjVTaX/ao/BMqFKaHvr2jVioEL5V40dM7NpezdUUuv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=JP+ke39y; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="JP+ke39y"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C36u8KQA; Thu, 17 Apr 2025 00:20:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845608; bh=+mCRD0/upb9ZPCU/tGKgYTAJjEOAhRNF7dsSOqIZYM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JP+ke39ydRod/2FG9XXE3qVsoTre08CGCsAkN4Kr6Ri2eWwzH13+O3NSaSRuqvTw3
	 aftVX7I+G27lMQzmxQ1wGr6FDRNUgMLsqCSW0T8AEV93GEy2jtOIrX0CY+IuNI7hV6
	 BkDK1CiW+iS+ahahPgmj/oboda9JJuTADPvg1kNMDLLCHLVHKgU5s9sLyHHLW3ln29
	 atPeDv3dvWPccHzybzm91jFm9mNuhZMT9R31gSfP2GSeOxmE2G7yH9AVB9N9bNHkVx
	 qnbdr9Tnybsa8VlZ8NR9miSF4TBMXJND9DQ6Y5CXbR0np8zzwsZP1OopYqmnWrqCAs
	 l2+XUJVp5zEGQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003b28
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=WBFf2OPKqg4umVxYW-kA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 13/13] config.mak.uname: set CSPRNG_METHOD to getrandom on Linux
Date: Thu, 17 Apr 2025 00:18:34 +0100
Message-ID: <20250416231835.2492562-14-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNQtwomiADszzSFy7LuF14g7VY+F7g+wcWCTHQNo8OHJOOpq48XN/19M1w4oZzkECOYkUaq8v7Zik28ZahQeF9Bpi7OcYlsIy1z08soho5IFXxMgzxuW
 AlWD2cPk8V6CpnwFTrD9mFonzXcb1MznXmVk/oT2RbMbAdxZHvd/NsLwqd06u/SI/I9AvCQgCKi3p1/oSbhHJ3D1Z5itCwPFvJs=

Commit 05cd988dce ("wrapper: add a helper to generate numbers from a
CSPRNG", 2022-01-17) added a csprng_bytes() function which used one
of several interfaces to provide a source of cryptographically secure
pseudorandom numbers. The CSPRNG_METHOD make variable was provided to
determine the choice of available 'backends' for the source of random
bytes.

Commit 05cd988dce did not set CSPRNG_METHOD in the Linux section of
the config.mak.uname file, so it defaults to using '/dev/urandom' as
the source of random bytes. The 'backend' values which could be used
on Linux are 'arc4random', 'getrandom' or 'getentropy' ('openssl' is
an option, but seems to be discouraged).

The arc4random routines (ar4random_buf() is the one actually used) were
added to glibc in version 2.36, while both getrandom() and getentropy()
were included in 2.25. So, some of the more up-to-date distributions of
Linux (eg Debian 12, Ubuntu 24.04) would be able to use the 'arc4random'
setting. All currently supported distributions have glibc 2.25 or later
(RHEL 8 has v2.28) and, therefore, have support for the 'getrandom' and
'getentropy' settings.

The arc4random routines on the *BSDs (along with cygwin) implement the
ChaCha20 stream cipher algorithm (see RFC8439) in userspace, rather than
as a system call, and are thus somewhat faster (having avoided a context
switch to the kernel). In contrast, on Linux all three functions are
simple wrappers around the same kernel CSPRNG syscall.

If the meson build system is used on a newer platform, then they will be
configured to use 'arc4random', whereas the make build will currently
default to using '/dev/urandom' on Linux. Since there is no advantage,
in terms of performance, to the 'arc4random' setting, the 'getrandom'
setting should be preferred from an availability perspective. (Also, the
current uses of csprng_bytes() are not in any hot path).

In order to set an appropriate default, set the CSPRNG_METHOD build
variable to 'getrandom' in the Linux section of the 'config.mak.uname'
file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 330741eb5a..db22a8fb31 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -50,6 +50,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_ALLOCA_H = YesPlease
 	# override in config.mak if you have glibc >= 2.38
 	NO_STRLCPY = YesPlease
+	CSPRNG_METHOD = getrandom
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 	HAVE_DEV_TTY = YesPlease
-- 
2.49.0

