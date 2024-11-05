Received: from mailrelay1-3.pub.mailoutpod3-cph3.one.com (mailrelay1-3.pub.mailoutpod3-cph3.one.com [46.30.212.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21821D150C
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801704; cv=none; b=cOUaTjkgjYG3ElTwEmJj3v55tJ0Gh3HfKv5RlKm3jq5inPy+V4WDfRp/VKBNFU3Mt+dVxgrQoHj4xyBfm1yMeSfmtDvdc+AymneNKLaJw2NJV2dRshVoycklw52DDlbjzsAR70hIvINoaJflQ5kqyCGvTvFa6QBSJ7dwEOMCrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801704; c=relaxed/simple;
	bh=+c4UPrPZa+Hj7nDJzJCSWGhNsd4fIl8mjoN9U2oCEto=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=TkBzwYEvP/TZ1eofhWCUlEga+V19pHri7cm9Tr/qwCHO6kEEVqDUkCwLdN/LjKhAyDgLwiEz55ofDt279sDYLwyTMTWTbGCyi1l+1ZOdbdyKd9ELCkBa775Ay4V6vr068414RHaWTFUiCPY9NJdK1FnYPaSmIcYlIU1Xe0W/xgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxsi.org; spf=none smtp.mailfrom=maxsi.org; dkim=pass (2048-bit key) header.d=maxsi.org header.i=@maxsi.org header.b=bWfu51Oj; dkim=permerror (0-bit key) header.d=maxsi.org header.i=@maxsi.org header.b=TDE7MB3v; arc=none smtp.client-ip=46.30.212.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxsi.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=maxsi.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxsi.org header.i=@maxsi.org header.b="bWfu51Oj";
	dkim=permerror (0-bit key) header.d=maxsi.org header.i=@maxsi.org header.b="TDE7MB3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=maxsi.org; s=rsa1;
	h=content-transfer-encoding:content-type:cc:to:subject:from:mime-version:date:
	 message-id:from;
	bh=XjL5jg2blMB96rwKMycRJx2V83bMQqV/4P3wixmKT4E=;
	b=bWfu51OjZv94xGifs2pPEDOjapNIpDhhbhkpHjnQJB2huVv61N8c7+unFQpmgg6MU6D/BDpfbO2X6
	 vx/0b+SsTUrBy8l2frhFeAy+TkfYvy7FZSdvI1XKd69M/7Vp9Cc7ukRywv87Xc5Iet+nVYMHFgjF6n
	 rBUrppgPJzGSIMukYGW3v5DCnWltGJdhYr+DvBa0QjpwHVfuZAgse+glYA/VARvRyjBgBvbcd7amZE
	 VWJB1cP4vdceyH5EKXauZ8vaR9ItecaL5cXnSBMcFK7VE2f8MYhYjIS3NJicvVdEFL39mpARgRin3G
	 gYpvGcOUKT3MeRSNFiAB9sLwEth4EOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=maxsi.org; s=ed1;
	h=content-transfer-encoding:content-type:cc:to:subject:from:mime-version:date:
	 message-id:from;
	bh=XjL5jg2blMB96rwKMycRJx2V83bMQqV/4P3wixmKT4E=;
	b=TDE7MB3vPiJ9T/7esgHxf3dPj+MhcbCqtN3+6sOOGBYI/Igs73CLez3ePwcr3N+ERLYuUvAuDpk0B
	 ZRA09CPAA==
X-HalOne-ID: a64aa0fd-9b5e-11ef-bf7d-7f063c5bcc39
Received: from [192.168.87.156] (unknown [85.203.218.213])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id a64aa0fd-9b5e-11ef-bf7d-7f063c5bcc39;
	Tue, 05 Nov 2024 10:13:49 +0000 (UTC)
Message-ID: <76f4dfe6-3724-472b-9b42-c91926e61fd1@maxsi.org>
Date: Tue, 5 Nov 2024 11:13:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH] Makefile: don't remove configure on distclean
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

make distclean conventionally restores the extracted release tarball to
its original distributed contents by cleaning the source code for
distribution. However, the configure script is part of the distribution
and should not be removed. This behavior is creating problems on my
package infrastructure where configure-based packages have make
distclean run afterwards and then the subsequent git build fails.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6f5986b66e..c488b914a0 100644
--- a/Makefile
+++ b/Makefile
@@ -3723,7 +3723,6 @@ dist-doc: git$X
 ### Cleaning rules
 
 distclean: clean
-	$(RM) configure
 	$(RM) config.log config.status config.cache
 	$(RM) config.mak.autogen config.mak.append
 	$(RM) -r autom4te.cache
-- 
2.45.2

