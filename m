Received: from mail.thalheim.io (mail.thalheim.io [95.217.199.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7A2D4B6F
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.199.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434991; cv=none; b=CkzBzmMc3CHFQWnMqPL15uUsx5H6CpW2BPW5Hx+8DkHW+OtbLIJHXq4YmLqTgrfrdDRmSL/vtlKZ1PA73Wr6voLT8KGxM74e0w6zNRxWnevplMBUr1nWKvMKRerbHx8opWKITYYK1QVY+Diu/jAf5yv8JaRBTMGpxoOf/mQp9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434991; c=relaxed/simple;
	bh=HBbsRWK3ynVLIVBlYO2ebtgwdXjghhGZBqi3+0ofsA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmMiuVeXYrpugpWg3rXgB4l9owPF7cMIxvgAWPvb0lWFbnwLHOyY5mFfqxENAc9gYskyiv5nPEIyo0SXpYBF1aLveEhBTSVFmX7dSjzuDobOKYFtxPKI+yJNTUofDwt6Z8HaEaMGqRn/S1JGpjoda4618+zJyXd/CLQZqR0Jv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=XgquPU8R; arc=none smtp.client-ip=95.217.199.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="XgquPU8R"
Received: from localhost (unknown [IPv6:2001:a61:2a2d:e101:8495:ad93:205d:87b2])
	by mail.thalheim.io (Postfix) with ESMTPSA id EC93C89C1B4;
	Fri, 20 Jun 2025 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1750434982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSCq0act4Vh55nduKlcaElfZv5kwYCLPy2zlY3FX0EY=;
	b=XgquPU8Rpb3A3z04XsT0rAwUJUF1oZf16j18tKsEd2Os7sE2IRCN8MBFGU8pmEL+V4JTup
	/DUS8ukap6A9H/8ZXWd+H11xGsM9ZIHtpZhLk7apjKN1bBi4q4zBoOcW8zPOs/ZYtNadNR
	6mYOz8GHMfB/yXLGRyNZ00Ivtmh8Zy4=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@higgsboson.tk smtp.mailfrom=joerg@thalheim.io
From: Joerg Thalheim <joerg@thalheim.io>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Aditya Garg <gargaditya08@live.com>,
	=?UTF-8?q?J=C3=B6rg=20Thalheim?= <joerg@thalheim.io>
Subject: [PATCH v3 1/2] imap-send: fix confusing 'store' terminology in error message
Date: Fri, 20 Jun 2025 17:56:13 +0200
Message-ID: <20250620155614.901816-2-joerg@thalheim.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620155614.901816-1-joerg@thalheim.io>
References: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io>
 <20250620155614.901816-1-joerg@thalheim.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jörg Thalheim <joerg@thalheim.io>

The error message 'no imap store specified' is misleading because
it refers to 'store' when the actual missing configuration is
'imap.folder'. Update the message to use the correct terminology
that matches the configuration variable name.

This reduces confusion for users who might otherwise look for
non-existent 'imap.store' configuration when they see this error.

Signed-off-by: Jörg Thalheim <joerg@thalheim.io>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index ed4c34dadd..33690cd66a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1831,7 +1831,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (!server.folder) {
-		fprintf(stderr, "no IMAP store specified\n");
+		fprintf(stderr, "no IMAP folder specified\n");
 		ret = 1;
 		goto out;
 	}
-- 
2.49.0

