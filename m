Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D73AD50A
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648802; cv=none; b=UDg30UDd7hDF3y8DFKfHLjAM+9VYk5Sf8O0AwvsXWo6avx8HlUaz29QdMCkLGmO8JV8v1YZJ2OHGYtNBg6NpUGcH1YBHG0RK8EZcOtBtBRqGjQV1nSEcm+obvMB1RG332XvddC99g4zETcliDsrCvP/BMSM7HdWQt7uC0CyGV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648802; c=relaxed/simple;
	bh=wpTK201CZn1WZ/V5+2g6KB0rKtDp0uRRkWDp22XqMoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYBt2AfjeddxTMEyfQHQ3zEkUMlEGgs0FY4sN/dqq6tWoyModUQokNzK7+6uhWETwuMnSdMJWLbjxtElIapQQltguy4mGSfF15xvgoGwArhf1qh2ZPruBT5/MRMS6WGkaQPs1ILEHtjyOs0lHPgphVbYcG9qNYEDPVwru9Rhgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=b1sFVNcn; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="b1sFVNcn"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 05A9B60428;
	Tue, 16 Jun 2026 22:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781648800; bh=wpTK201CZn1WZ/V5+2g6KB0rKtDp0uRRkWDp22XqMoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1sFVNcnwDmSwwOQTRFjIA1+FqYE53DZVCEZSD+7Eh+h6efgfhCu46J1bPothWcRd
	 2HS/1e4/oj4lmxqQK0s2reoH96PIoIdPkyFZdVR5UA+TbqhBJZTaqFb+KWO4uTE8tL
	 jAJHFLa4lf7M+OtlTxNfc7v/O0dC+le+BeNXkMio=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] fetch: rename function report_set_head
Date: Tue, 16 Jun 2026 18:25:18 -0400
Message-ID: <20260616222606.1003521-5-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616222606.1003521-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260616222606.1003521-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update to the slightly more obvious name 'warn_set_head', which matches
the verbiage of the followRemoteHEAD options.

Signed-off-by: Matt Hunter <m@lfurio.us>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82969e230f5a..9a45e1e7a44d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1707,7 +1707,7 @@ static void set_head_advice_msg(const char *remote, const char *head_name)
 			remote, head_name, remote, remote, head_name);
 }
 
-static void report_set_head(const char *remote, const char *head_name,
+static void warn_set_head(const char *remote, const char *head_name,
 			struct strbuf *buf_prev, int updateres) {
 	struct strbuf buf_prefix = STRBUF_INIT;
 	const char *prev_head = NULL;
@@ -1787,7 +1787,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 	if (verbosity >= 0 &&
 		follow_remote_head == FOLLOW_REMOTE_WARN &&
 		(!no_warn_branch || strcmp(no_warn_branch, head_name)))
-		report_set_head(remote->name, head_name, &b_local_head, was_detached);
+		warn_set_head(remote->name, head_name, &b_local_head, was_detached);
 
 cleanup:
 	free(head_name);
-- 
2.54.0

