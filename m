Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2138F653
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244006; cv=none; b=G7KC87HCroglanhGKXwREoww13byEaBF5S876Oo9iPniJ9TlrwaqMPaJ6eQDPO93IF9Mi9u7UFZXVlfi5qI5l6bp48UcJgbSOoW0G5WdZ9xzmHCMJqcJdtx1JC04toUHZoPQsGdtf/SZSjF1QqEBEcrvK2L49+X3PPy4cjYHYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244006; c=relaxed/simple;
	bh=GHDpcl6oITglLBfXWzDf5QmqmN703XfHWUIXdMHy7Mw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tyhzm25XV+lt8nU6l8gBOrvvX0bvc4hMajYqoLwL0cOrOVgcLGYVJ3oPBEI+h2BFp2y6+4V/+ML3CJgghZQUHms+zRsXt4UK6n7ifY+SyEqyK1ax8cnqYGpSmk726Sd0KrIBjHRFt2VaO/xvyghRr8Y1yiYbLaU86LwW8c3P91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=rcuvasWx; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="rcuvasWx"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 572F160272
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781244004; bh=GHDpcl6oITglLBfXWzDf5QmqmN703XfHWUIXdMHy7Mw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rcuvasWxvhKI+m2NckD2F72Qd+iv3auHbT3fE/nkFFa674MO+zpg+jCrMfLInBjEX
	 YP2VaOtRSfZSkvZrVhV+v9wZASUhATA/cIG6bxtXvvZxlrPmxOjZXz32JvItNNf9Je
	 qZP4cPybUtQm0mrDWffYa1GS0rlL6G8CTyPulyKw=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Subject: [PATCH 1/7] fetch: fixup set_head advice for warn-if-not-branch
Date: Fri, 12 Jun 2026 01:55:37 -0400
Message-ID: <20260612055947.1499497-2-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612055947.1499497-1-m@lfurio.us>
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260612055947.1499497-1-m@lfurio.us>
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

