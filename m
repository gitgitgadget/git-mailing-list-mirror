Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860801EA84
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731632054; cv=none; b=mi9r4FJFNN9K+ywrnZN483FAiwJBDFfQtdnmkm1ddOCYGllMyxZUErKdAqsuuut8u8V4+P389Cxjc4sJ5REFIr4OEl9Yj60VhyUSfyHBIJDvZsg1zduNpSQSl0eIADVQ0zgTZy3QLaFLSuQNb8gDNiXcj8OCThq6mrXsYjbTO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731632054; c=relaxed/simple;
	bh=XgaA4ojkvr8h6m4y1EUUZabIea03akQ5KPUNH09kmyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCGeVTc2swEH9tOhqFXDdSL51fpg8h4XQ/8LR/1JeidK4kMoTkFYkvtuvk0lBT6XrBFZOG/UVJzYgpz2mS6ofOFq7oO5U4N8KFDhU1KQvcB6nVnEw1C+IhlOxfgojZ4S8T9ltjYjqSvTI6H3VgzNRCNCEoHXlSI7jDf+9xpBc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IDaoaRkK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IDaoaRkK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731632051;
	bh=XgaA4ojkvr8h6m4y1EUUZabIea03akQ5KPUNH09kmyk=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IDaoaRkKmsBUNRYPPkI2YsroPXYjINVtYKmgwMnwR9lSLUS1UjTpK0dsXOxcan98g
	 zWX+TUUc+4EaRKkJIz/f5qxWjxMLkGVOCnNRAPQI3pQtpTiOqKCHHptMzMDLxIlNCo
	 xa86k0w+aFeR36NpJYA5o0/cjRWeWQhGvLHdDgMTNLCLQ9kukMR+2/p65NtCgmR2UG
	 iM259n4WHXLG/PWjPdtkyQEyA6KkeXQIW23A6FCyZ7Rd9v7R+8DXkqkRJ/2o5iVCnh
	 GKg66JjaSVOOe1na/CoLtFtwmX94MIo4rFANseBllEm3k4o699tJvlmvxi1HoY3nma
	 pSyq3lr0/kOZc3Ei4bQ5mqtpKR0L8rEEQQII1tg+JKLmjVHHU0JJjbolOrv655+UpB
	 TPq8JJBMbpCdoAqtMLl1ZNMwOFNBCImWlBIWSh0Kf/BfMgrhTVf3EKmSDwKjmQjCCQ
	 3vPXtHm303RuyIAoStp/wdIntEO7kt1wyJlIbiZXCAxy7Q/8cXR
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 39D2A200C4;
	Fri, 15 Nov 2024 00:54:11 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 0/1] Restore the ability to clone repositories owned by another user
Date: Fri, 15 Nov 2024 00:54:03 +0000
Message-ID: <20241115005404.3747302-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a long time, we've told users that the only safe way to operate on
an untrusted repository is to clone or fetch from it.  We've even
mentioned this policy in a variety of places in our documentation.

However, f4aa8c8bb1 ("fetch/clone: detect dubious ownership of local
repositories", 2024-04-10), this changed in an attempt to make things
more secure.  That broke a lot of user use cases, which have been
reported to the list.

Because our security model hasn't changed and it's still safe to clone
or fetch from an untrusted repository, let's revert a portion of that
change to allow us to clone and fetch from repositories owned by a
different user.  If a malicious repository were a problem for
upload-pack, that would probably also be exploitable on major forges,
and if it were a problem on the client side, then we'd also have a
problem with untrusted HTTPS remotes, so we're not really adding any
security risk here.

This matter was discussed extensively in the thread starting at
https://lore.kernel.org/git/ZqUc8DJ1uKcHYlcy@imp.flyn.org/.

Note that I haven't signed off on this patch because it's based on one
from Junio and I haven't gotten his sign-off yet.  It's fine to add mine
once he's added his.

brian m. carlson (1):
  Allow cloning from repositories owned by another user

 Documentation/git-clone.txt   |  9 +++++++++
 builtin/upload-pack.c         |  5 ++++-
 daemon.c                      |  6 ++++--
 path.c                        | 10 ++++++----
 path.h                        | 17 ++++++++++++++++-
 t/t0411-clone-from-partial.sh |  3 ---
 t/t5605-clone-local.sh        | 10 ++++++++++
 7 files changed, 49 insertions(+), 11 deletions(-)

