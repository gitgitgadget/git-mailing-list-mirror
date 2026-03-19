Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3E35A933
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959928; cv=none; b=HbPARl6USdKvtLTaeRp5OqemJrJp/baOCyeR4WDzTHexKDgVy4/EDNlDe2wh3doIncq+AWWQ6DrQ6NARGVMVvPG3n7W6GsDOcyjqF8qVK7O/+uhveB2tfnWmpofxbGHe3jpsqfTP/EcCWkNmsdRtPOvlSxWDkMkl1ZR8MxD4kl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959928; c=relaxed/simple;
	bh=uDm5kiz7MMMM1K4TAXxE6I7KPoUInFWHWBBD2GaoLLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFcFpmV/o/oUDDY66kQsLcRhLTEbF6d9+2i55iLBeK4nmzmzHX+mAciRQ+Fxq6FZU2p5JcE3wcBFGzxduD5K7OqUpgsHnlnkNvFeg02CHU4xdhMllC+IiKAJAM1ErdEG72aMuo3NZpbyZkc60Bc852YMXlcjSkOvAXq/Qo7lGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=P5vmrjpB; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="P5vmrjpB"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773959919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uN/UpmOi7UHfp6vT8y9Rr4H3yRxOIIx23ExYVcPvlfc=;
	b=P5vmrjpBIAPjmNtqV+GJJ4ufGsKwDK8RrbRPvwfQMseq/9XfpqtEVYnVYI4SQkd+ILv6/O
	Twwy3GbU/bjs5iUPY2qqLnjRtSEhQXYJIhOCpzNAcaoNv5vBXaxn5RXFZrZvuduK37AUC5
	hq1VintI5hkKJ1exsbxV3DGYetgav1IXUB3eLSG//ZfjpbRn/u5p6LWoo0FJGtr4bqLTm6
	I1rP6JeZuR65PNoevmp2VSkPXRcTKLGeU41a6YO5Fudu+ZwfIUo/Ar5d3BVpFTAYT7FR3k
	T0UvIEfNH0h7J9wLi0Yuhak+P2CPKGCLtN+FX2LOZFvxO1eRZJTVUEBHSq9IKw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 2/8] format-patch: refactor generate_commit_list_cover
Date: Thu, 19 Mar 2026 23:38:12 +0100
Message-ID: <883dd358b6d69ab8430a4fcd95318150a6fca870.1773959395.git.mroik@delayed.space>
In-Reply-To: <cover.1773959395.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space> <cover.1773959395.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Refactor for readability and remove unnecessary initialization.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 716ebc2701..997bdd608e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1376,12 +1376,11 @@ static void generate_commit_list_cover(FILE *cover_file, const char *format,
 	struct pretty_print_context ctx = {0};
 	struct rev_info rev = REV_INFO_INIT;
 
-	strbuf_init(&commit_line, 0);
 	rev.total = n;
 	ctx.rev = &rev;
-	for (int i = n - 1; i >= 0; i--) {
-		rev.nr = n - i;
-		repo_format_commit_message(the_repository, list[i], format,
+	for (int i = 1; i <= n; i++) {
+		rev.nr = i;
+		repo_format_commit_message(the_repository, list[n - i], format,
 				&commit_line, &ctx);
 		fprintf(cover_file, "%s\n", commit_line.buf);
 		strbuf_reset(&commit_line);
-- 
2.53.0.1018.g2bb0e51243

