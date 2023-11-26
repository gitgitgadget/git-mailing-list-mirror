Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=brob.st header.i=josh@brob.st header.b="JTjaL215"
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Nov 2023 16:24:03 PST
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB0110
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 16:24:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700957336; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iUSXsGWrRdecjSuL+6Fwf07j9F6aiIQsKxZmFWTbgRBIIhCk63OM/WAyiLufhkz3LpHYayFSLrl0Lt504d819IqH8PvzY2rSoxRsgpNKHrZkwxxRdTO1YXyT6UI+HSqqTQ0WFaU+4Lz6aG4t7boADPWf96XBcCmcEB4pBmEI/eA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1700957336; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cB+Kd1QotK32Oeqf5GMkOcwUU8KqWxh7HaU5GOi24Dg=; 
	b=JyYFkC8FR9DgCxZJe+Ce8ruO4XQkmqgDLzk0eSFLbZMR+/NNpH/3+qwH1B6VEV2zGi0ivNOk0hJCFeBaC3/0CY4GUgqYeLCK/8/rWUrBYA2zZO/BaQvvGEMndwAnHYZtxDTrUy2+5gKJmfAFsIhNZxKooM36fsByv18xLvJdqQA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=brob.st;
	spf=pass  smtp.mailfrom=josh@brob.st;
	dmarc=pass header.from=<josh@brob.st>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700957336;
	s=df; d=brob.st; i=josh@brob.st;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cB+Kd1QotK32Oeqf5GMkOcwUU8KqWxh7HaU5GOi24Dg=;
	b=JTjaL215AgCjW1Z1gA3vxrh89QwxZfRWN/qatntja1S0yrUp/wqWVB+F4g4B6eaN
	tM70HkzBkSrwD31EI0TiuGBxfl/t5TkiW+x/cfyCwPlTyttxWdXDOvZJfRo/Lfib6eA
	wBHoiqEfGDHqe4GebKnc1hgQgW9cXIPbJ1xuxQFQ=
Received: from localhost.localdomain (104.223.118.51 [104.223.118.51]) by mx.zohomail.com
	with SMTPS id 1700957333695182.92040930819962; Sat, 25 Nov 2023 16:08:53 -0800 (PST)
From: Josh Brobst <josh@brob.st>
To: git@vger.kernel.org
Cc: Josh Brobst <josh@brob.st>
Subject: [PATCH] builtin/reflog.c: fix dry-run option short name
Date: Sat, 25 Nov 2023 19:05:14 -0500
Message-ID: <20231126000514.85509-1-josh@brob.st>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The documentation for reflog states that the --dry-run option of the
expire and delete subcommands has a corresponding short name, -n.
However, 33d7bdd645 (builtin/reflog.c: use parse-options api for expire,
delete subcommands, 2022-01-06) did not include this short name in the
new options parsing.

Re-add the short name in the new dry-run option definitions.

Signed-off-by: Josh Brobst <josh@brob.st>
---
 builtin/reflog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index df63a5892e..a39962df69 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -248,7 +248,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	int verbose = 0;
 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
 	const struct option options[] = {
-		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
+		OPT_BIT('n', "dry-run", &flags, N_("do not actually prune any entries"),
 			EXPIRE_REFLOGS_DRY_RUN),
 		OPT_BIT(0, "rewrite", &flags,
 			N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
@@ -368,7 +368,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	int verbose = 0;
 
 	const struct option options[] = {
-		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
+		OPT_BIT('n', "dry-run", &flags, N_("do not actually prune any entries"),
 			EXPIRE_REFLOGS_DRY_RUN),
 		OPT_BIT(0, "rewrite", &flags,
 			N_("rewrite the old SHA1 with the new SHA1 of the entry that now precedes it"),
-- 
2.42.0

