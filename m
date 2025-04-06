Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B71A8F93
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968398; cv=none; b=mOzYTuNGPiJhepesY7sxAcc967EFeHMRABkJGs6R4isjnVNC62CmFsumRgqxDeBdfPKSHybv8mTHVcu/4uPS2/r3SgvfagH4kt41CBDYwbPPxuR7zFBPdRoFA03rv5k4jH91G7/v/KYn7C1eYKPPRGQd/i/L5Bf4Sfk0BSv7AdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968398; c=relaxed/simple;
	bh=d1lzhXChVRMo2b/QZHlmOuSSEiAB1iJRC2mh6ShXuWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/yt28xYJyCLqL4m1PtBzbcN5/NfFIn0Y5cMMsJ1FSNQe5jFFYp3aWeyFBhLdxoHGtyPY521LytUzsMQRGfffjpzUJ2Th6W4q/lthwe+Fm24WCMZFXCcGHr9g68+Bj3nwhEz5GUF8fYdjzijaivp7JpL5hdO/Z3aD4pYxPMw5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=cuiFi3vl; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="cuiFi3vl"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VqVupkLz; Sun, 06 Apr 2025 20:39:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968395; bh=LXwAM8I34ieECbM8PTWuYJb8slP8J5I8B7K85IHznxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cuiFi3vl+hcIx7sMrW2hhpDkXouiLmjYvraGZj5HaNv0F8Y+Gqnx56Ig2n9BaQ8gK
	 2cn8OumjJOm1Mhg4cBR4/VbDqEs9MCXfejcDmKthVr6eAW8lI9v5blDAleKCoJm2Ip
	 IiVzx0ydS6NL3PE2zlSKRH8eS8GTurkUyQTQfgc3q1r1bicxBEs1ZCu/MO4spoJz/O
	 a/56Kb+BqNGepGgRi42xBnzw8nu4m7GAIq67wFiJh4pUQyiXslXVmmD8FOneyk5yrp
	 gXjQeQmBjiEiJxaOKeuZoN2tTuPGtKKWVhTqfnZPaoJlumODKlbMwW6BuCs+hJOD3s
	 uybApXybGiqzg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d88b
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=eTvDwwv87Y-7DfItWLMA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 09/13] config.mak.uname: add clock_gettime() to the cygwin build
Date: Sun,  6 Apr 2025 20:38:35 +0100
Message-ID: <3bd6e40cd23b07b86b5db146a00bfa01458f2e04.1743859985.git.ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com> <cover.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOHIDJtdXQ+gScaCEKJKjkzWiz+4MQE91r+FPshhkaaEPCE7mxXxb9MgLkpbIXVke9wL0FXuhJKzE5ZseBUHAcDgzTjuMht0Z9RZeHprli6CiqDmwlA0
 DN4+mqhi+xiYSdLKTTvAGkBP/g/PWmXAznLqXRGWxMd3W1gsjLb5iny93txhI9B3ZYnGs/UGIhGji5jq+T9+6/kCOaX9M5obFOs=

Cygwin supports the clock_gettime() function, along with the associated
CLOCK_MONOTONIC preprocessor symbol. The autoconf and meson builds both
enable the use of those symbols. In order to have the same configuration
for the make builds, add the HAVE_CLOCK_GETTIME and HAVE_CLOCK_MONOTONIC
build variables to the cygwin section of the config.mak.uname file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 1b3ba8a341..942550fb9e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -251,6 +251,8 @@ ifeq ($(uname_O),Cygwin)
         endif
 	HAVE_DEV_TTY = YesPlease
 	HAVE_GETDELIM = YesPlease
+	HAVE_CLOCK_GETTIME=YesPlease
+	HAVE_CLOCK_MONOTONIC=YesPlease
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-- 
2.49.0

