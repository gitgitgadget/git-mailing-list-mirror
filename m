Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84361C5D5E
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442431; cv=none; b=H/2RFb5yjMWOWQqX8P/9XLw1vLEV7aQZSY99sQBDouM80vt2Z3SgOTfSI4uTWGOcXwYjtQ4BJ7Ok2FgP1tNR8r2UZAL1cYN8JyBIMGwSjwDrygwBc6rygEZupbSwrlZJpzdqZF5yPvYdLn7tuDUhwyjVkefffD13EQkb6QRFZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442431; c=relaxed/simple;
	bh=J0NqQwJysPCtcJoYCxZVzjGft4dG+1FIXC6SyxSCkMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zyq8Di7wm97yfROJAZOqd9J7HxuPxx4WYC02pd+7lZTe9OH1qA6f1OyAG5rzzyTfFe5supVQSnno/Hwgu77WhIDegml9Z+EUKqXSbriffEpe8t2w3+2DA2Dq8SBn3k4ymAyuxRrnoGM0jY7oG8fb8wAdMDCAlpYFc/Sgh2ssZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from soc-PF5467PF.clients.intel.com (p5b3d22d2.dip0.t-ipconnect.de [91.61.34.210])
	by mail.holtmann.org (Postfix) with ESMTPSA id AC3A5CECCA;
	Fri, 17 Apr 2026 18:12:33 +0200 (CEST)
From: Marcel Holtmann <marcel@holtmann.org>
To: git@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH tig] Fix compiler warning with latest gcc
Date: Fri, 17 Apr 2026 18:12:28 +0200
Message-ID: <20260417161228.1578-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

        CC  src/diff.o
src/diff.c: In function ‘diff_common_add_diff_stat’:
src/diff.c:191:22: warning: initialization discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  191 |         char *pipe = strchr(data, '|');
      |                      ^~~~~~
---
 src/diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/diff.c b/src/diff.c
index 6c670e4b4fb4..182ea349eb9c 100644
--- a/src/diff.c
+++ b/src/diff.c
@@ -188,7 +188,7 @@ diff_common_add_diff_stat(struct view *view, const char *text, size_t offset)
 	const char *start = text + offset;
 	const char *data = start + strspn(start, " ");
 	size_t len = strlen(data);
-	char *pipe = strchr(data, '|');
+	const char *pipe = strchr(data, '|');
 
 	/* Ensure that '|' is present and the file name part contains
 	 * non-space characters. */
-- 
2.53.0

