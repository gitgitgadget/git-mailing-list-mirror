Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED2357D0D
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862508; cv=none; b=NIO3fxO0Wiqn/1qyq3wcmy8fgZpMSmzyDMU6QbPmG1BB3BigTB4xsHbc+4b5Ij4RlNd12hqJONh9G9xPf03FkaAaNd04nTy1CeiiOFyopmDwPfybUVk3RaZ75ox8LXjM9tvefxJNz0g8xnftFAxDLfNgyFYYBAjI5MMAnvjBS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862508; c=relaxed/simple;
	bh=GHDpcl6oITglLBfXWzDf5QmqmN703XfHWUIXdMHy7Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRdXbYVcB/JLLkIbPWgqrgcFySIGcUkf8ODE6imJLPIQTEETIPOv0zmIMfMTARgZ2GsZUCodYJMeUYfQUzMY3ZQllIoEjQpS+9MiRjcc5rtwNaRgIPR4uGALmX4Gn4wSzv1bLyDgEbYeqDNIiYwRM+o4ksLPsToj31nxfqDNCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=Hm+Hzmqb; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="Hm+Hzmqb"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 8B436600E8;
	Fri, 19 Jun 2026 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781862500; bh=GHDpcl6oITglLBfXWzDf5QmqmN703XfHWUIXdMHy7Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hm+HzmqbBhPVk/q/ubnE9ZGG1GTFTYkOCWeV8myWuYddtuW0IaIColfnWipRf4iAo
	 0QsojqHUo93jr8VPQxxGvw1JXt8gewkb1cGm7aW8yB7UFtmQqee2N7Lh8zkJcGxhHI
	 g4YQzfZNp14TEsLt24LBsHX8W5jHYnpuTUWnxGok=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/8] fetch: fixup set_head advice for warn-if-not-branch
Date: Fri, 19 Jun 2026 05:44:20 -0400
Message-ID: <20260619094751.2996804-2-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619094751.2996804-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260619094751.2996804-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specifying the word 'branch' in the command is not correct - a mismatch
with both the implementation in remote.c and the documentation.

Signed-off-by: Matt Hunter <m@lfurio.us>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c1d7c672f4e0..82969e230f5a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1700,7 +1700,7 @@ static void set_head_advice_msg(const char *remote, const char *head_name)
 	N_("Run 'git remote set-head %s %s' to follow the change, or set\n"
 	   "'remote.%s.followRemoteHEAD' configuration option to a different value\n"
 	   "if you do not want to see this message. Specifically running\n"
-	   "'git config set remote.%s.followRemoteHEAD warn-if-not-branch-%s'\n"
+	   "'git config set remote.%s.followRemoteHEAD warn-if-not-%s'\n"
 	   "will disable the warning until the remote changes HEAD to something else.");
 
 	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_head),
-- 
2.54.0

