Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822BB24BC18
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845596; cv=none; b=kS6+65pEplLFj1/t/1q6lRWjKmnH9LecC2Z5jNeKiebaimJ8b209yi8ab+7SDmtHQ9ckj6qdmdCO4710pejYOrZNq1HSTHPJcffcyIVSG4Dlc4uHro6vCdo5ZEbPXa4xX0+cSTOz4LPY5WDVRtstwy4hpUANE0OxWCh8kOUd7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845596; c=relaxed/simple;
	bh=euBXHrZ42frDrvfa0/ise71IY1qZtBZMUPrwPv4lwZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGlZqIbDnlQ5mlYdlNB/ITVql8pRMdGzjHJWowaS9EhpMlzz1gn4NTirh23dTl80GKAmOE9imBDANotcaErXzupAIH42b6pmHCaJVa+ik4PIeylOxKKPP/jkqy41Rbik/ASb+NZPpP+v4HshKPIwdHxDxZNTVJQy5pk16IWwqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=eiGQXl1E; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="eiGQXl1E"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2ru8KPp; Thu, 17 Apr 2025 00:19:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845594; bh=U8zXOWGOj6xAnCUAvdpdKL+3RoTLT/w2xicatoD8QXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eiGQXl1EmkVn/x+mE3lpwPra5kCxIt11/q5pFr5KRwxKb+Aq000PXSWfZYMyu0Do9
	 8lPfdiYSemp8eQAXT3jqs/cAo1EiXLapQyutazScu+i8iCsJzQFyL4kNElhU0bhhBy
	 XXx4CGCJf5g+TV2QKCMRPGaETisNzY411w77wxqqEaxlFP4Q6Zyf5AsKUGF1IosOMU
	 Rg0qZsb6g9/ybeY8s9a5wGt2bxnuLLCPtaImaxelke0lm2ETTI3yOWtJSURhjZO03K
	 qk7wt7vGojNbGXpzSCZLpU95m/V8OVZ72rspyclWVEw0kI71Yxt7XicjhkSnaYDwqe
	 egkZJ7mk5PZ5w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003b1a
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=eTvDwwv87Y-7DfItWLMA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 09/13] config.mak.uname: add clock_gettime() to the cygwin build
Date: Thu, 17 Apr 2025 00:18:30 +0100
Message-ID: <20250416231835.2492562-10-ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfEQrb61MaiwmFyLVw0EH97BgDVeJhCmgZCA88cysnFBgdHrIhk5wBZLEvVe35KVM4mdmV0KvaZ3KHA3UdGRwQR8EX27R4M9WrriA8SObsTZAwV2Ex1O4
 /rpF59xokaxd37ZPZeselplM/ah9FzhPOv3of+iCcghAnXIKNRCMsd1jYiQBDynoOHRKQA2aUbsiGxVGadsjuG+WFguMy/x7K0M=

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
index 1b3ba8a341..d058b34292 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -251,6 +251,8 @@ ifeq ($(uname_O),Cygwin)
         endif
 	HAVE_DEV_TTY = YesPlease
 	HAVE_GETDELIM = YesPlease
+	HAVE_CLOCK_GETTIME = YesPlease
+	HAVE_CLOCK_MONOTONIC = YesPlease
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-- 
2.49.0

