Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4838A72B
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530465; cv=none; b=i2535fJy0JaLubmvsXOQ9PdvBV6/ct9Xsrs1XF5qiUxc/wz4Z+ak71fm6f6dGlzuMrJwi7MwL+qe2s8wIMWZCOQdHonvx1VJA52fGoeuM9YTEl/uZrZe6PZrkxJccGzdtEBah37Rwf//r4sH9meaEHXA4S96VXJR/A8pAf23kw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530465; c=relaxed/simple;
	bh=ixgoBTWhsk8gjkt/BlfX5RUMvGGFfGt9KGND4zakQl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGZq8MQa2TBP4agK4v2+DUFlvFSfkSoI5/6atCE9zLnImOi4VqpY9qfj5pX26Fqgp2hDnsMwBC7S62tRKiAJXpp6132gTWtrCwlNInluSH+dkVLks8pUTyZkBa32sBo/6BVf+CLYHmTG4zyJAEUo2So6XzgMwaBgBj08MrAWd0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=gA2184hG; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="gA2184hG"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773530454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbe0dy6uBDaztgCOYX30mCSxmeY/6qPmI5WXLaoAWuQ=;
	b=gA2184hGZw+Gue+PQRx2wQbwHWAdWn+mlHVnAfIjhitPesYMM8ArmINPATze/88v1PVpQa
	RH7sCTglnd49Tt4XH3aESyRW6DuOYDDWfC0lV6Tf+m+XNe7Q63mtSUQ8awvg39XwiqlZeX
	fvfqCZJFzBl2LQeOsf3hkKPl4h6X8c1mW6QssBUaQlRZGWLDvJ9ZrVOy2V/PuQc3TGaod+
	iTsp6rDJ5vkzZNgLc1QIEvPaDdNOpxl2yIbAVWjHjgK1aqaRv3Lmk//4hPPo54OTDH46gv
	y0+gu99YudCN+rlfO9Y9NB6dsbdp+Kp3KZ9PJGxKAwvH7+trbETed3PbfX3BXQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH 5/7] format-patch: wrap generate_commit_list_cover()
Date: Sun, 15 Mar 2026 00:20:48 +0100
Message-ID: <7be0d6c49d09158739784cc70d17ddcbcd0a1fed.1773530191.git.mroik@delayed.space>
In-Reply-To: <cover.1773530191.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=mroik@delayed.space; h=from:subject:message-id; bh=ixgoBTWhsk8gjkt/BlfX5RUMvGGFfGt9KGND4zakQl0=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBptezDqI9A7qFEjJa2CribnmLF6VWM28hOIAsRv PVyqMhIPxGJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCabXswwAKCRBIeX6hnBm+ 0ZssEACEZFjPZC57vFyf6AZmXHWjd28tjbjZD63MLXgdrbESeOzQa5Cx+ScIq33zC+FTxWSPJuQ RUbAfRmtmVLWrYc/RKxjl1XDHBeObQjYYR4ylP9QzH25Rj0t5er1AaIw7oeA6VF2uy5ZeIKsmB5 CPvkWtark6u+GLwCt+enftvB82Xg2uKqTkRs0U3vveFQlBwKbAdzix7hggaIGEO1w8rQof1NAgy wFO67NvCLudso3fi7pCme1vNulk120OAYHrPecvJmd5XSEb4kxfgvTfZReJgjK37XUm9dGLiysu yDfqF9kCcgcjGoF3ONsD82WIz4+hvHijUKQOgZZPEmWvjUde265Kve0uHuvq6G+LcosFP8B+CNU 03VB+hMjh2NVeBldYKlcVJrAzJik7EBXru0HgYwGWS5xIIAbwBR3hvKNKGjSlAN6VnSAnz/JwVS tBAQ0jBxVcNLnL2UU6nxctJ/3f7HMPWOpr2cVQafHUi89ByWDXDmniKDQInls6kr8QhFIIcwIbC +U/ubJoj2obvyXlFJYyrDMxp02dTwAb4KbyiebKBrTR2cnwzxHOInsnoYRvJPJqVQev7pw1lTcR iR9sDM4KMGXq/lDX03rh+LLNXm3DXKfV/rNzZReHL06aiy3BmeL23qUXFFJXxcWT/VUxM7EpF5W 5/Zcen+5U
 aV1tjw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

While most conventions should not allow for the text lines in commit
messages to get too long, when they do it could make emails harder to
read.

Teach generate_commit_list_cover() to wrap its commit lines if they
happend to be too long.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 47126f9064..d1765ce4ad 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -40,6 +40,7 @@
 #include "progress.h"
 #include "commit-slab.h"
 #include "advice.h"
+#include "utf8.h"
 
 #include "commit-reach.h"
 #include "range-diff.h"
@@ -1364,6 +1365,7 @@ static void generate_commit_list_cover(FILE *cover_file, const char *format,
 				       struct commit **list, int n)
 {
 	struct strbuf commit_line = STRBUF_INIT;
+	struct strbuf wrapped_line = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	struct rev_info rev = REV_INFO_INIT;
 
@@ -1373,12 +1375,16 @@ static void generate_commit_list_cover(FILE *cover_file, const char *format,
 		rev.nr = i;
 		repo_format_commit_message(the_repository, list[n - i], format,
 				&commit_line, &ctx);
-		fprintf(cover_file, "%s\n", commit_line.buf);
+		strbuf_add_wrapped_text(&wrapped_line, commit_line.buf, 0, 0,
+					MAIL_DEFAULT_WRAP);
+		fprintf(cover_file, "%s\n", wrapped_line.buf);
 		strbuf_reset(&commit_line);
+		strbuf_reset(&wrapped_line);
 	}
 	fprintf(cover_file, "\n");
 
 	strbuf_release(&commit_line);
+	strbuf_release(&wrapped_line);
 }
 
 static void make_cover_letter(struct rev_info *rev, int use_separate_file,
-- 
2.53.0.959.g497ff81fa9

