Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD9407105
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959927; cv=none; b=Iw+Di3P2aMkXMDgpuv8HUdI+cnejuXzUyleEoS1jrNaGNko5G6rIABAMIU07fk++dbSw/tU/T0fbfDi7rbuiJqR/aQ4xKPKEIYeIh0bEk9tK4+fH9vbt2UjBUEiodBRh/sp00pfipnbWc7p4SUMDudp2Lg9rF8YqoTMG9KC1KU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959927; c=relaxed/simple;
	bh=EqoWbQRkCxZVj1rSk33hA2/us/K49dN6HY2M64Z5m+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYEC+yOQNTH8pQHeXNpaU5iEcZnje8vEzlcfEFIwbPhQQKNY9nWxf35z7VBFhHIkdvWQKY9Orps0VFjUiA7FFIFTuYDCQF/xjHP8emdCAr+DD7gzTGzjKlcJgrtGWYedTImrcCKZR2cCJVYKhkMdrmuhGPA2crmAMsKNzr9DFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=bxHx0/mV; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="bxHx0/mV"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773959918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mu9/jCezYczHPzNHcrp9LfWaDg2FmZihNC8N/TRWTjE=;
	b=bxHx0/mVwwwDs0hC2o1o2IoL3n+3mlMtDrgFBEEUAgZeJPxyTa40570/HbTrbi/I8BtFr3
	YwPQRU40WCYD/+P194OB3q6T9Q+0KdGxjtPGURUWyga4PXSkM5cqyUwLNtgWLovGkLmPzt
	mnTADtgRiobL4gTHszprK3ih2SvQmFhklN+gVZm7UDkM6HbDjlCTp54ZNQuvnBQXLJdu2y
	9F8Rym9A3YWKlo43kSdrkt3QI4B+8Aza8o8aWN9jqLMKO7uMza0xHzq0J90C8UxxFjxana
	jm3uGN8lcqWVgPu4iDA5dDCTzsTVP2OEL2idgUrFaXx5rS3i+dRLIVLo0A5rog==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 1/8] pretty.c: better die message %(count) and %(total)
Date: Thu, 19 Mar 2026 23:38:11 +0100
Message-ID: <a0d26c5999980f87b12022d12031d9f0dabbd864.1773959395.git.mroik@delayed.space>
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

Improve die messages for commands that do not support %(count) and
%(total)

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 74673714c8..814803980b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1551,7 +1551,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (starts_with(placeholder, "(count)")) {
 		if (!c->pretty_ctx->rev)
-			die(_("this format specifier can't be used with this command"));
+			die(_("%s is not supported by this command"), "%(count)");
 		strbuf_addf(sb, "%0*d", decimal_width(c->pretty_ctx->rev->total),
 			    c->pretty_ctx->rev->nr);
 		return 7;
@@ -1559,7 +1559,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (starts_with(placeholder, "(total)")) {
 		if (!c->pretty_ctx->rev)
-			die(_("this format specifier can't be used with this command"));
+			die(_("%s is not supported by this command"), "%(total)");
 		strbuf_addf(sb, "%d", c->pretty_ctx->rev->total);
 		return 7;
 	}
-- 
2.53.0.1018.g2bb0e51243

