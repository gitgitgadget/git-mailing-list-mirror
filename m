Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AD1396572
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774678; cv=none; b=szuwXr6iy1PR7db1rawpfOz3/KKNioIE+4sy21G8mzUW9njhOemX23VyEQCpdRWqwn+Rv9ApPXRmvmsWRLlEFJnP/6JdL7kMqN/BAsCB6XQOfRAFirhZbFyd2aqrywdcsrPUFGvHg9D6oI5FxmdqvFOWUR8Ruy28fi1xhWI94xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774678; c=relaxed/simple;
	bh=7bfvpvsAkQ8aeGJMhbs8Uje0JYa4tqibIRXu/PLv+cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCMVEwa6i2oGovGadtth5cInldXqVDZPEcEFzPc6y014GIFxe+6cuD6OK7T3LJGXko4FfnI8ORu96wWvNob7O+Io3Ns7mxARFj1SIdbHaCBmIn6IocnwVeZVkwfxrK9yDBO9DYenoDoKBGz+3wdmRKGf8RHu61z1CJhJ8bK7J7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kpZU2GI/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kpZU2GI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775774676;
	bh=7bfvpvsAkQ8aeGJMhbs8Uje0JYa4tqibIRXu/PLv+cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=kpZU2GI/S3Qggij6NT2kq3m0x1Ke1qo1ihOuetQlTRECE2AE0NoPwzMmG13jPnT9K
	 +S00kHJQyyh21SLAJ4cj49utJ8QVrSrMe3iAKPdfK9V67LQbyIjnGbfSkuxCKRoOyD
	 tRDMaWrCrWNAbLJTWJJpOJlp31R3s3J0sepx1BkJ3yrD4fGRylDnWPXJSmtE0uBXvz
	 AsQJ6gGmVqIY6WXI1KV5nxTdWlDRuXyL6FY6HC35sSs3YMCpqTAghFw2lW87ydvdYn
	 oBmVcZcYiX1lMcgd0EA9/KXRwM5UlfJnvtmHBo0njej8wfrKeCeCwKMMN0ZrGTqKqv
	 pvac/D/6AJ1KG58M/xtLKK7kePUAJsslFv5W0ewezCA1zNRz8N1JmQfoYdLvojPkbx
	 We/7RzPuTtpMVc5qJAwO8Vu2a1tntz3x/P0cML537vQ7E+nhMXpHjQrqWjOe9moySC
	 +tNRaABOm8VOUV6OVPuEMGzu4CKDiUJOmTcfZcD5gutoguQ0E02
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:fec4:70ef:431f:d174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 54E8F24402;
	Thu,  9 Apr 2026 22:44:36 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 3/4] Linux: link against libdl
Date: Thu,  9 Apr 2026 22:44:33 +0000
Message-ID: <20260409224434.1861422-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older versions of Rust on Linux, such as that used in Debian 11 in our
CI, require linking against libdl.  Were we linking with Cargo, this
would be included automatically, but since we're not, explicitly set it
in the system-specific config.

This library is part of libc, so linking against it if it happens to be
unnecessary will add no dependencies to the resulting binary.  In
addition, it is provided by both glibc and musl, so it should be
portable to almost all Linux systems.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index ccb3f71881..7aab56c590 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -63,6 +63,7 @@ ifeq ($(uname_S),Linux)
 	PROCFS_EXECUTABLE_PATH = /proc/self/exe
 	HAVE_PLATFORM_PROCINFO = YesPlease
 	COMPAT_OBJS += compat/linux/procinfo.o
+	EXTLIBS += -ldl
 	# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
         ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
