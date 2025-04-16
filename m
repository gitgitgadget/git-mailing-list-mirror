Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA924A067
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845563; cv=none; b=GTunteb/4zLAsAy8nXaMJ3GPk2NtHY1N/ucjXVofO8krdD9HT2H0ROW5HNikyCD9V3qXv4l2A/YKDEapQhhTpMFYO/mAVZ05CdogUvvdZK/p71yVZfloP7NooFiGN8NCwMrqSqzI4MOZjVchZ2yEieKRasMWr3ImjP1d2sMLX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845563; c=relaxed/simple;
	bh=4oZtVPkKwwvl4/kG3Pcwo/gIn6elwSpnxPM52qbEXxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPk7842m+jBOlnkaedhzCtwNN1lVRG8rsyX9gziweqt8WEE8bfih5axgkiBTVNiyjGgFOgtPpDKd8X2d9derEgJ++YDMvaNXXrRlFhWEGgVA9G3VMwweMGYRRBnm/g7LChWY38d85WeaVgOBY6eZAJVIartk8OYvlsIyV43Li4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ExwAMtB8; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ExwAMtB8"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2Ku8KPD; Thu, 17 Apr 2025 00:19:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845560; bh=mnSwRgfsuqwJWe3cxnQyOOlcRFjXhLi55yE0/tQoN7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ExwAMtB8v2Wf0tShyXsVEaLOYN3KCVIDVQrVRsefn20Z8/rdoFa5cawzVygSV2mXt
	 9ROdoRDXTcHOTm9/U/XS5LhQ2v4KyX3mvcoWEJpfY02yfvw8buN824RGe+RY9YcMH4
	 iLvYoRGNuyfg5dVmqzOSm9N/IDRm+4f9yqnob9lPgnihvSOw45cjWXtRk4Pzohjs3w
	 rni+uA25uRQvaRGOvAr7q3UCB9ornCgJQXG+2rbq0t9ONUUrzokwNCRMbrNRWPvHqS
	 eIR0kAhzi9IenYCBuWglhJ33IVtG1FHGuv4T7rMgAEDgMOd4aDN2puJK1T5GtpJZq5
	 5tTbgEXrBpjRw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003af8
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=UssqkuoP40Gt3Q7oBg4A:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 02/13] Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
Date: Thu, 17 Apr 2025 00:18:23 +0100
Message-ID: <20250416231835.2492562-3-ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfBVAVUe9R6cm6rFnbT9u7nSxogkiJ40lTbm9o+kpyDckxMfCDC5vItASLRzL+OO0oCkocv1ipB3MIjvviV1J49LUC+m3XcJvJTDkyKD7JKg+sZ3JrFQG
 MeUXSjNCYq5mZX7usnmHuEBpvlARGSExajiPCsSlrFX1lR8GBA81p21dyviKrJoaKCRX/M1KsEm2UahSFIDv1IGnZfurqggczNw=

Several build variables only have any meaning when the RUNTIME_PREFIX
variable has been set. In particular, the following build variables are
otherwise ignored:

    HAVE_BSD_KERN_PROC_SYSCTL
    PROCFS_EXECUTABLE_PATH
    HAVE_NS_GET_EXECUTABLE_PATH
    HAVE_ZOS_GET_EXECUTABLE_PATH
    HAVE_WPGMPTR

Make setting BASIC_CFLAGS, for each of these variables, conditional on
the RUNTIME_PREFIX being defined.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 7315507381..818dde32a9 100644
--- a/Makefile
+++ b/Makefile
@@ -2179,10 +2179,6 @@ ifdef HAVE_BSD_SYSCTL
 	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
 endif
 
-ifdef HAVE_BSD_KERN_PROC_SYSCTL
-	BASIC_CFLAGS += -DHAVE_BSD_KERN_PROC_SYSCTL
-endif
-
 ifdef HAVE_GETDELIM
 	BASIC_CFLAGS += -DHAVE_GETDELIM
 endif
@@ -2213,25 +2209,33 @@ ifneq ($(findstring openssl,$(CSPRNG_METHOD)),)
 	EXTLIBS += -lcrypto -lssl
 endif
 
-ifneq ($(PROCFS_EXECUTABLE_PATH),)
-	procfs_executable_path_SQ = $(subst ','\'',$(PROCFS_EXECUTABLE_PATH))
-	BASIC_CFLAGS += '-DPROCFS_EXECUTABLE_PATH="$(procfs_executable_path_SQ)"'
-endif
-
 ifndef HAVE_PLATFORM_PROCINFO
 	COMPAT_OBJS += compat/stub/procinfo.o
 endif
 
-ifdef HAVE_NS_GET_EXECUTABLE_PATH
-	BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
-endif
+ifdef RUNTIME_PREFIX
 
-ifdef HAVE_ZOS_GET_EXECUTABLE_PATH
-        BASIC_CFLAGS += -DHAVE_ZOS_GET_EXECUTABLE_PATH
-endif
+        ifdef HAVE_BSD_KERN_PROC_SYSCTL
+		BASIC_CFLAGS += -DHAVE_BSD_KERN_PROC_SYSCTL
+        endif
+
+        ifneq ($(PROCFS_EXECUTABLE_PATH),)
+		pep_SQ = $(subst ','\'',$(PROCFS_EXECUTABLE_PATH))
+		BASIC_CFLAGS += '-DPROCFS_EXECUTABLE_PATH="$(pep_SQ)"'
+        endif
+
+        ifdef HAVE_NS_GET_EXECUTABLE_PATH
+		BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
+        endif
+
+        ifdef HAVE_ZOS_GET_EXECUTABLE_PATH
+		BASIC_CFLAGS += -DHAVE_ZOS_GET_EXECUTABLE_PATH
+        endif
+
+        ifdef HAVE_WPGMPTR
+		BASIC_CFLAGS += -DHAVE_WPGMPTR
+        endif
 
-ifdef HAVE_WPGMPTR
-	BASIC_CFLAGS += -DHAVE_WPGMPTR
 endif
 
 ifdef FILENO_IS_A_MACRO
-- 
2.49.0

