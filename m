Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB1328608
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748821; cv=none; b=hqlFpSCBVJrBbQ/DFIetqLOWznvfGzcRt50LdG9cxc9Gy2vo6Stu8A6i1/WL1sLs/OneviCT8YtJQv7YPHG7Bg9KpDKt2lEqCijM8/WMj8ozK8c3/DxKHzdxP5HH7aw/PmPPoaGdpQOUOkPItjVWzMGaTivJWUlxrhHGx9hdxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748821; c=relaxed/simple;
	bh=gJqXii+xMrgQwswmQyY28WfMv6abRAnT25Z9vFDlPwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXWQIZZaRbp6em9HK3p2gjie2FD/DjOIUZMtknNzIn8FSaHZ0CLp2m/2ujl1DU0R/pOqNe1stvMoVnOd49yxSixeIJskqIOqkxNxXBY7iUcl4OTIH6odxcwAJfloymP0YNS6iOH7g0cutDESfy5AV5JLgj87+RcbjSdQDHo7ASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=kz2yzG/1; arc=none smtp.client-ip=79.136.2.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="kz2yzG/1"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A6C6C408FC;
	Tue, 10 Feb 2026 19:33:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRatEhIf25hT; Tue, 10 Feb 2026 19:33:19 +0100 (CET)
Received: 
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id BB8A540537;
	Tue, 10 Feb 2026 19:33:19 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA8E7B1E34;
	Tue, 10 Feb 2026 19:32:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770748342; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=y3uUym92P6vLShbrkCAoTDDvmcHWdCbtSjCgbehm/kU=;
	b=kz2yzG/1jIvrnJTxYhJ2VDbEqk1c8BvIbaYMXLy3e7atZnsU49UB3+SKw+xhjK7DCfWRNQ
	J+gnAPMFUPcmJgd2EXazkYYIFz3bC75V5kqpcUDiS1IaKYSc241BA73RNXt1wepndXypIp
	ihPCiKdaAB6PZlqMCDPJHGvpaLL64j3CevzGuR3tgxqWTRbDeNhe3Iwb6aBWonb/zQPgnJ
	ZPcsoVD4sI1GDIwrBXpPC16GLW3zCyQ38xCAIs5YrA6oGj/Zocx4jZjx4scURS7roZw3D/
	BGbMuzKHVNh8NepWMZ16yZGsF7GdD39n0qmmz9/FD6bAl6S/Ws/C+4SUsBSY2A==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v2 1/2] help: use list_aliases() for alias listing and lookup
Date: Tue, 10 Feb 2026 19:31:09 +0100
Message-ID: <20260210183110.1151072-2-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210183110.1151072-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260210183110.1151072-1-jonatan@jontes.page>
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

While at it, switch git_unknown_cmd_config() from skip_prefix() to
parse_config_key() for alias parsing, which properly handles the
config key structure and prepares for multi-level alias config keys
in a subsequent commit.

No functional change intended.

Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 alias.c |  4 +++-
 help.c  | 26 ++++++++------------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/alias.c b/alias.c
index 1a1a141a0a..c66a6095bb 100644
--- a/alias.c
+++ b/alias.c
@@ -29,7 +29,9 @@ static int config_alias_cb(const char *key, const char *value,
 						 key, value);
 		}
 	} else if (data->list) {
-		string_list_append(data->list, p);
+		if (value)
+			string_list_append(data->list, p)->util =
+				xstrdup(value);
 	}
 
 	return 0;
diff --git a/help.c b/help.c
index fefd811f7a..a450d57987 100644
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
@@ -586,7 +573,8 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 				  void *cb)
 {
 	struct help_unknown_cmd_config *cfg = cb;
-	const char *p;
+	const char *subsection, *key;
+	size_t subsection_len;
 
 	if (!strcmp(var, "help.autocorrect")) {
 		int v = parse_autocorrect(value);
@@ -601,8 +589,10 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 	}
 
 	/* Also use aliases for command lookup */
-	if (skip_prefix(var, "alias.", &p))
-		add_cmdname(&cfg->aliases, p, strlen(p));
+	if (!parse_config_key(var, "alias", &subsection, &subsection_len, &key)) {
+		if (!subsection)
+			add_cmdname(&cfg->aliases, key, strlen(key));
+	}
 
 	return 0;
 }
-- 
2.53.0

