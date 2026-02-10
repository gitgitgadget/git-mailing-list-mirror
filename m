Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F330EF86
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770762501; cv=none; b=dekKYi5IzorGGVvJzDo4Akbts0s9CmsylgIteYSP/3wUYbzjLytCTsoIbP7rneVZon/htqJZnaqwGChxc9kPs4YXigO8NA7foGXvsvrH0CCv/W1Ic0s8KvmU0BTQovRN75sxozTESaZ+MQtOvesLdMjj6zACfamQ0ElRywaDetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770762501; c=relaxed/simple;
	bh=GWLcbORGzjKYKiQmgfXDJXvbdqfd0mzXcS6Fn+0YE0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQtr01Iw6laBCGRzZcNfjK6obaAi5LPq5QPr4kJPESF56eVKrTrcmdx2a0B3Rs7rJUvGhq9qsRr26f+OLfNI1YXeMtEWW3efiGwgbIx87kJskdTeY4Sa1tfXGuAoNlMzKkyXDHDI6Qen2eab5PAlzCqUbbC/wsAUqZXJJVPUY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=YXN0wZah; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="YXN0wZah"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 5D06C3F841;
	Tue, 10 Feb 2026 23:28:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ou9MU_MElB6p; Tue, 10 Feb 2026 23:28:16 +0100 (CET)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 6B74D3F44B;
	Tue, 10 Feb 2026 23:28:16 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B2F5B1E74;
	Tue, 10 Feb 2026 23:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770762439; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=z66wQ/5kqWeszx4/RsSH7BaXWts6qek1Cgh0wgLamG8=;
	b=YXN0wZah5zfK4xi2/SnQ1YqILBqmYxvCkULVPfqLJL49IUgCU7OFICwF8pTufTjFDOc0c4
	Auuup2WJTb1gY2ToW8OUXfW1f7DUbEX5NkH9jM2U7HTSl3/uARa2gXLWkoFDQTFjO7T2tc
	9qAhxnXGUT2UkyB8DhUkG6xpAcSCl7KhDoXgYssn7XRSQ3xZalJVeS/YYs4xTtuCgdmCtN
	zq1hiqihwBUVentUZ2hxNjUv7Fy4/mHyi8BSvpGOdkb8hdyr/Fq67xD6Fx/GTov38KhWBe
	R1XMuA0NnmfZs9tCPYhyE2Hlq8x0/1yuOjVJ6zeISKlCo4brXZycf4nLX64eAw==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH 1/3] help: use list_aliases() for alias listing
Date: Tue, 10 Feb 2026 23:27:43 +0100
Message-ID: <20260210222745.78575-2-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210222745.78575-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260210222745.78575-1-jonatan@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

help.c has its own get_alias() config callback that duplicates the
parsing logic in alias.c. Consolidate by teaching list_aliases() to
also store the alias values (via the string_list util field), then
use it in list_all_cmds_help_aliases() instead of the private
callback.

This preserves the existing error checking for value-less alias
definitions by checking in alias.c rather than help.c.

No functional change intended.

Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 alias.c |  9 ++++++++-
 help.c  | 17 ++---------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/alias.c b/alias.c
index 1a1a141a0a..1f8e13610c 100644
--- a/alias.c
+++ b/alias.c
@@ -24,12 +24,19 @@ static int config_alias_cb(const char *key, const char *value,
 
 	if (data->alias) {
 		if (!strcasecmp(p, data->alias)) {
+			if (!value)
+				return config_error_nonbool(key);
 			FREE_AND_NULL(data->v);
 			return git_config_string(&data->v,
 						 key, value);
 		}
 	} else if (data->list) {
-		string_list_append(data->list, p);
+		struct string_list_item *item;
+
+		item = string_list_append(data->list, p);
+		if (value)
+			item->util = xstrdup(value);
+		/* if !value, item->util remains NULL but item is still added */
 	}
 
 	return 0;
diff --git a/help.c b/help.c
index fefd811f7a..0bdb7ca10f 100644
--- a/help.c
+++ b/help.c
@@ -20,6 +20,7 @@
 #include "prompt.h"
 #include "fsmonitor-ipc.h"
 #include "repository.h"
+#include "alias.h"
 
 #ifndef NO_CURL
 #include "git-curl-compat.h" /* For LIBCURL_VERSION only */
@@ -468,20 +469,6 @@ void list_developer_interfaces_help(void)
 	putchar('\n');
 }
 
-static int get_alias(const char *var, const char *value,
-		     const struct config_context *ctx UNUSED, void *data)
-{
-	struct string_list *list = data;
-
-	if (skip_prefix(var, "alias.", &var)) {
-		if (!value)
-			return config_error_nonbool(var);
-		string_list_append(list, var)->util = xstrdup(value);
-	}
-
-	return 0;
-}
-
 static void list_all_cmds_help_external_commands(void)
 {
 	struct string_list others = STRING_LIST_INIT_DUP;
@@ -501,7 +488,7 @@ static void list_all_cmds_help_aliases(int longest)
 	struct cmdname_help *aliases;
 	int i;
 
-	repo_config(the_repository, get_alias, &alias_list);
+	list_aliases(&alias_list);
 	string_list_sort(&alias_list);
 
 	for (i = 0; i < alias_list.nr; i++) {
-- 
2.53.0

