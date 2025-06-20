Received: from mail.thalheim.io (mail.thalheim.io [95.217.199.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9028C037
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.199.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434992; cv=none; b=TpdDUp6RvLdQ8YnOqkkc2aaRShnmyY4wled5c/6jxgQNqP0hQQ9bFy/VJ4jgb1Wl/mKEUh0GgbS5ADYRpF/flTyKK/fB5f02yNXw1/+qnck/4ZtqiNel1zJYbUZ3km6lV+bFUdORAMCbdMMI4OuJYKhFrA2kWPE2MOQKOvQY1cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434992; c=relaxed/simple;
	bh=K7r2cV5zE8EveImIapUTo0tbsm//lDlUFaZJ/Z0QFpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHQvSnpmW9hCcDfKHXBzAphc8tAqZHdTIl4B4ZRcnwlFzNiVDIc1yr5lbGhCud2di3PXc1oDdYvxc83WYOPSH4iL8FQjOnbh9jbDnfDsXDWq78FKfWm1gw3pvH0gJAbj4s1SPYL86RhZ6E7tzzW1uzzf859s5pLtp9fGmjNLlck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=ndGif+QH; arc=none smtp.client-ip=95.217.199.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="ndGif+QH"
Received: from localhost (unknown [IPv6:2001:a61:2a2d:e101:8495:ad93:205d:87b2])
	by mail.thalheim.io (Postfix) with ESMTPSA id 475E989C02A;
	Fri, 20 Jun 2025 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1750434980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BffuBeBTubTJPuQtBYH/OXhLhGQUhyETirzgLPTIdXE=;
	b=ndGif+QHlRoq3R0m8CoXwYYijfi2rSB278mPf6eaG7KjccejNK3TLXReTxQ4xgtnMvf87r
	ftN/cKV+uNkwKg9DsX4zjSYjLW3O/Tm6FE4Mwz5zsBZBXJD76Z6mM4Zf8EmUyQYrbR7jAF
	9W74+JptYeBW1LJD8zcfKF0yJ01Tu5w=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@higgsboson.tk smtp.mailfrom=joerg@thalheim.io
From: Joerg Thalheim <joerg@thalheim.io>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Aditya Garg <gargaditya08@live.com>,
	=?UTF-8?q?J=C3=B6rg=20Thalheim?= <joerg@thalheim.io>
Subject: [PATCH v3 0/2] imap-send: improve error messages for missing configuration
Date: Fri, 20 Jun 2025 17:56:12 +0200
Message-ID: <20250620155614.901816-1-joerg@thalheim.io>
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

Changes since v2:
- Use single advise() calls with multi-line strings instead of multiple
  calls, as suggested by Junio
- Simplified commit message explanation about advise() API

Changes since v1:
- Rebased on top of ag/imap-send-resurrection branch
- Split into two patches:
  * First patch fixes the confusing "store" → "folder" terminology
  * Second patch adds configuration hints using advise() API
- Use error() and advise() instead of fprintf()

Thanks to Junio for the helpful reviews.

Jörg Thalheim (2):
  imap-send: fix confusing 'store' terminology in error message
  imap-send: improve error messages with configuration hints

 imap-send.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.49.0

