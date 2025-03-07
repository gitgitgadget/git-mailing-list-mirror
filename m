Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727C1A23B8
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357124; cv=none; b=hcNG6qo0g4XrpqIC0mEZjd+A3E0xmFyu5zPKw9MmLOHSMfQaEF7gXLF+8a+gFswBnHe5Q11lyAdFO7JGmveZ+91HhXQQ96gQSicCmagCNNgd16fZl4Dp3XYNtzePWOQIvgck0iym5VTvA1/1T5xh/NsJqCtbbsZLP0EjpcUMEoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357124; c=relaxed/simple;
	bh=pCTX2b37P/bWb9HaXGG19ZugYB2MGBiz0aSmQf7kWyY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K+2qoWdMXxBOTt8YhRn6fi/iPSt2dRvgz53rp6XKiUF7uQf/1YGfqoVMtaa8uM7rHaAPB+0cotFRTvCOMUptsH0dWzkyVU663enUcqKSfidibnHaNVfOLqfiar+LsBUGz/lCjEhl7ISay4PGw7tSyKDdgJRyGEP6OEDoJ21kuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=4LvWqDb7; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="4LvWqDb7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1741357116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rifevUyadG6XbYbXly9BNbXbT0qGK3BXqEuV/FCVwJ4=;
	b=4LvWqDb7svR0Z9/sZFCyGVqqdwSU6/4qr/iFkbxLss3/+hsxxf364N17LeDBMvwMQIW+qQ
	RnaWHet2R91RWbA40Oj4kj++v4VTJc30HnjfHJsjAL/4B+gUBbVtLlmjOjC0ztIxIRUmrw
	6Pn2aTC8b6f/3ExiH/goWSvNL2bq46c=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/2] Ensure zlib version is printed by git-version(1)
Date: Fri, 07 Mar 2025 15:18:06 +0100
Message-Id: <20250307-toon-zlib-git-version-v1-0-5e8069752bb9@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4Ay2cC/x3MQQqAIBBA0avErBtQI6KuEi1MpxoIDY2IxLtnL
 f/i/QSRAlOEoUoQ6OLI3pWQdQVm024lZFsalFCtaESHp/cOn51nXPnEi8InUHfWzL3RWtICxR6
 BFr7/7zjl/ALjBYGbZwAAAA==
X-Change-ID: 20250307-toon-zlib-git-version-a7dcb9caa1ef
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

I was trying to benchmark the difference between using zlib and zlib-ng.
To be sure I was testing the correct version, I was interested if
git-version(1) would tell which zlib library it uses. After some digging
I saw it should be printing the zlib version number, but on my machine
it wasn't.

I discovered a regression caused by 41f1a8435a (git-compat-util: move
include of "compat/zlib.h" into "git-zlib.h", 2025-01-28). In the first
commit I'm addressing that regression.

But I've noticed building against zlib-ng directly still didn't print
the zlib version. This issue is resolved in the second commit.

--
Toon

Signed-off-by: Toon Claes <toon@iotcl.com>
---
Toon Claes (2):
      help: include git-zlib.h to print zlib version
      help: print zlib-ng version number

 help.c               | 5 ++++-
 t/t0091-bugreport.sh | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)
---



---

base-commit: a36e024e989f4d35f35987a60e3af8022cac3420
change-id: 20250307-toon-zlib-git-version-a7dcb9caa1ef

Thanks
--
Toon

