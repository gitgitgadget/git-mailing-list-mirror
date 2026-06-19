Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B727456
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862510; cv=none; b=RoT9cDtvFGLez9fKhZJU8UdaN3vycmcCnFgs27FRb1WPm8ZE5nihch7PTTxw7yGru5JCgXoVZJFPN7uRpAuMpWD/p7LQp1hFVx6/jDigW8spBZ8/pzV0apEaU6+IA7c3rHMkcPZk5pMLguplSGehvapMKHLHK0Q6gw3r9scWaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862510; c=relaxed/simple;
	bh=wpTK201CZn1WZ/V5+2g6KB0rKtDp0uRRkWDp22XqMoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RogCBPSYq3cGvQAdtB5qRLajsFSeWSyU0mQ/Tusb7L3MTxOUuJ4+3P8vrbzYF/HabBUaY1vemO4Iy3at1S0uEkgAoK6aMPj6Jc/QDwpmYk2crEaWdngVGqR3OuPf31pojsEG3jxFYvrK/G1OCa3VVOaPf9rP0OnLIYr0k8y5C98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=c1P7krF/; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="c1P7krF/"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 011D76051D;
	Fri, 19 Jun 2026 09:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781862507; bh=wpTK201CZn1WZ/V5+2g6KB0rKtDp0uRRkWDp22XqMoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1P7krF/jRSn+os4vlayjC0K+TUazof5eCCrz67wBlMW+an+qv0thNsRg613kuBZo
	 vljxaJhnZyYRMTqqa8eVkae0dNO6TsCaLQpCa0otbbLZd5ac0xgH/iByeGKYN0NkKG
	 nlFs3i5DGHxJCvcT62WB8cKn5OBneUQM5W9Z9ED0=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/8] fetch: rename function report_set_head
Date: Fri, 19 Jun 2026 05:44:23 -0400
Message-ID: <20260619094751.2996804-5-m@lfurio.us>
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

