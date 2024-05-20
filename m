Received: from impout002.msg.chrl.nc.charter.net (impout002aa.msg.chrl.nc.charter.net [47.43.20.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A121CA81
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231811; cv=none; b=RvKKLPQkkeSns5V+iKnfIvp/XkFjkmuoxH3PY5fJ2uWMVkz5ZJENJUWg0WDIKvedsv5MFH56qva91rAv8tbDa5Uxa9a58hXVdz0wbRrY+22xFcnJR2Eo//KEwNEpZSAIGiIdaHt7r/QWJ9L6Rfu9Cpzbq+M0kgOCpNO/gcIZavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231811; c=relaxed/simple;
	bh=m+7tsqyODQ7oJwB6TVsZXTlgbv3cuEmQ7ugnEBUaRtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVD5RuPCevfqiotlQHal/haM3GMn80/mIGHYXwDt1SGRFNU7JON3Yn7u8Vr5jYgCm6edAhXD5PUDom8Irgg7GMRliFyQhXp0F86iCvcOdpRM2/DoIZMJmh+PdMtHOciLr/ipdiOjt+jmTytzhzDIQ8LOc9+ayIV5nyJnSMsfWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=NlSdb3ub; arc=none smtp.client-ip=47.43.20.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="NlSdb3ub"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id 98GYsTho2i0hy98GdsQjRm; Mon, 20 May 2024 19:01:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1716231711;
	bh=m+7tsqyODQ7oJwB6TVsZXTlgbv3cuEmQ7ugnEBUaRtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NlSdb3ubbG0vmQKkM2lRPf/ePCOjwkrrihNoc5Wbw6kwsC841fdaSEVV72WPZ+3+z
	 4U2rdmCiWVHAXwlx4LIYmgh3xqcVn2Un/b5tUzqHvHOCa9EKi+K9Iy7tiRWUaCtauZ
	 r7xcjmCFedW2nvpJx5e6K8uyEgJPMXV7hFWv9xOGS/BeePNTlFnE0MsG2tm1GdB6kq
	 Beoq9oEU1wx6vFtytex6bxjWO7SHLKXS5+p6pP0DwIcvAokru1XsIQ/D9JU1nWQNz4
	 /oYpoMqd13SP6iP5iFrtUoU5E/yUa2g558laOCQsV1Qi2IVxWPBVbijtvkgrE7Et43
	 2LCnkTBVIgD6g==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=Wf8KaVhX c=1 sm=1 tr=0 ts=664b9e1f
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=tSug4fyTdhxCZ_G02zYA:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] improve chainlint.pl CPU count computation
Date: Mon, 20 May 2024 15:01:28 -0400
Message-ID: <20240520190131.94904-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOmijoj/6CdUaPFXhSUgYYnYPQSqroei4wjBGUvv3VXroIbeoZyoBKHHFDO0rJ5p/P5Gl/2850lole7wmV7SI2aOWxzlaarIY2svGYV4rGI0uOtLT59A
 VhLyJ8FPe3zcPpXH4yFltBo7jLUXBm0EU1ne7qHOLGtes9A7BJ1BR7ecZDNsL4CRjkOZkyVCgQS4sO6l1AC5fKySEBECdVuy0ET8Xpz7aOZsjTyb0/RhoMpJ
 cb1LaBvo6jqer8uZE97JNFrclZqv/N3CnKj6wwRrATOfQtEVsMcAlQe4ycbxcaXduYlYR2vyxA6hUa+5cI7uKQ==

From: Eric Sunshine <sunshine@sunshineco.com>

This series replaces a patch[1] sent by John Paul Adrian Glaubitz to fix
chainlint.pl CPU count computation on Linux SPARC.

Unlike its predecessor, this series also fixes an underlying problem in
which ncores() could return 0 which would result in chainlint.pl not
processing any of its input test scripts. Patch [3/3] also fixes CPU
count detection on Alpha[2].

Patch [2/3] of this series is more or less Adrian's original patch[1] so
it retains his authorship, though I simplified the regular-expression
and tweaked the commit message.

[1]: https://lore.kernel.org/git/20240520111109.99882-1-glaubitz@physik.fu-berlin.de/
[2]: https://lore.kernel.org/git/503a99f3511559722a3eeef15d31027dfe617fa1.camel@physik.fu-berlin.de/

Eric Sunshine (2):
  chainlint.pl: make CPU count computation more robust
  chainlint.pl: latch CPU count directly reported by /proc/cpuinfo

John Paul Adrian Glaubitz (1):
  chainlint.pl: fix incorrect CPU count on Linux SPARC

 t/chainlint.pl | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
2.45.1

