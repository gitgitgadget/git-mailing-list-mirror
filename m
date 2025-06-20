Received: from mail.thalheim.io (mail.thalheim.io [95.217.199.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B51F9EC0
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.199.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401527; cv=none; b=V0C3FAvAYyIpAIKJsDeqM3u2/yfdv6LFnUqu5wouMLCczuIhtmGTOq7BO/4k4NHK/w20CUMyhh7u2fMhQM155KEkZpzAff7+zkxWVibK1rARS823gxDDKS9w8siYHugLHnmHGXlG6+F2443UvCzVTWgC7q6hrQ237TpWZtUUfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401527; c=relaxed/simple;
	bh=bCp42D2VGzv3JyNiT5dXFAJt9T5e6M+/AHsFTINmXLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dj0dbS3SX4KAIotXqpoGpU7hXPAycDFEl45nOpbfvB43pT8cni09O/ZwxxnmEC9FyTBr//sh2wubx3LC+w4gn/ipvjDwd7DaLHNMwh9WyjUtP7ClWsxdSiMhYVTdJ0QVVkNmjdrVOecmENL+WU+yjXckihMqFUfw4YheOH6j9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=bkqfRSGI; arc=none smtp.client-ip=95.217.199.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="bkqfRSGI"
Received: from localhost (unknown [IPv6:2001:a61:2a2d:e101:8495:ad93:205d:87b2])
	by mail.thalheim.io (Postfix) with ESMTPSA id 22D7F252A55;
	Fri, 20 Jun 2025 06:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1750401523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttmqZxQlXzqU2xPtwN3ecnjkZEl1rH4+974oOkEb+SE=;
	b=bkqfRSGIhMupiHNYuGeYGm9N8KmEefKhM3/Zzs5OLzsjBzsTblUy0SR7rvAt9G7uAXDCgA
	cIu5M+867vpbvLtkRekscTy3iuqtglCqUEhwKELLU9xNWScI1aU6aGMz/WmWqZaBVO+Kxk
	j8Aki3jmxiMuC7/pYTNHJaNh8gToU3s=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@higgsboson.tk smtp.mailfrom=joerg@thalheim.io
From: Joerg Thalheim <joerg@thalheim.io>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Aditya Garg <gargaditya08@live.com>,
	=?UTF-8?q?J=C3=B6rg=20Thalheim?= <joerg@thalheim.io>
Subject: [PATCH v2 0/2] imap-send: improve error messages for missing configuration
Date: Fri, 20 Jun 2025 08:38:34 +0200
Message-ID: <20250620063836.252881-1-joerg@thalheim.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io>
References: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jörg Thalheim <joerg@thalheim.io>

This patch series improves error messages when required IMAP configuration
is missing, making it easier for users to understand and fix the issue.

Changes since v1:
- Rebased on top of ag/imap-send-resurrection branch as requested
- Split into two patches:
  * First patch fixes the confusing "store" → "folder" terminology
  * Second patch adds configuration hints using advise() API
- Use error() and advise() instead of fprintf() for better integration
  with Git's message handling

Thanks to Junio for the helpful feedback on v1.

Jörg Thalheim (2):
  imap-send: fix confusing 'store' terminology in error message
  imap-send: improve error messages with configuration hints

 imap-send.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.49.0

