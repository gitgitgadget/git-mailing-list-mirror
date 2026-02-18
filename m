Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69A32E68D
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451926; cv=none; b=meMecxq10FW8mgnwkxc1k0PFA/N1lrXucKUNBjeKEDJm8lOHM/v+Uscpr+0YoU3awZKNtj6llMaTrhKmR9cFcFeXQOpzqYzDwd9CysqQJLnTLar0Np+0iILEBJ7cMOHtHq4mJYEe+KfPz6tCMqSXI3nSnoiDNRgkjj/yc2qrrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451926; c=relaxed/simple;
	bh=AcwlRvjODm7Ak9dLOUhAQxyv/eZAh4tNnyO363XJ/Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tW445oWW+2HhnyryPITphEW3UX9OVYjRBcWIh7InP3efUjGIInAT96BFGMRzn3XUEcPSSRfTLyQRzJztOIIHeszvVMDOnhRpZA2bn4pOKn8GidkSkjF/CxFfzj9dMVPuuM5MWZqgDOmNshNBvhQ4xRcBFE+XDWshb4HQ8aYQUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=CcKTdfxx; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="CcKTdfxx"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 76F6E40B59;
	Wed, 18 Feb 2026 22:58:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QxyavPG9WS_j; Wed, 18 Feb 2026 22:58:41 +0100 (CET)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 9CF5640B35;
	Wed, 18 Feb 2026 22:58:41 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53235B211C;
	Wed, 18 Feb 2026 22:57:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771451852; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=nQzaQbvv4Qy82Aebq57I1DVbC8S/6XGGvTsoKZA/Oj0=;
	b=CcKTdfxxjTo89Ks2vAFecduQIeVYblNd7AzEdPvr5Zbc5PAtwdp6j2WKV2dJ3E0b6woI+Y
	heOOi9bJaOhlV1Gh5enz1s1B5m0Y3gjlMrilQTzwMEgs6rfFutILhJy2KC+o43SW4MOoym
	uKLuot9uHjGmezFjRXUVgMTwrFRRAf/9aQKwP8jzmjcIkQ7BU5MmYd+IeczLXOoYk7b7EA
	0mNDJP1oPi7gkHNYHAnzcqHjmcc7cTKggZUWXJyDjukAbPl3XVZeRdS091yrWZZBNs/Q20
	bEiHtiGKY5/XRGMsC9PxPwUm09NBAcUyjnXtiXWR6AzbjG6ts+CP/NAfJSQ0bQ==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v7 1/4] help: use list_aliases() for alias listing
Date: Wed, 18 Feb 2026 22:57:34 +0100
Message-ID: <20260218215737.1181147-2-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0.122.g3abf75d576
In-Reply-To: <20260218215737.1181147-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218215737.1181147-1-jonatan@jontes.page>
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
 alias.c          |  8 +++++++-
 help.c           | 17 ++---------------
 t/t0014-alias.sh | 10 ++++++++++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/alias.c b/alias.c
index 1a1a141a0a..271acb9bf1 100644
--- a/alias.c
+++ b/alias.c
@@ -29,7 +29,13 @@ static int config_alias_cb(const char *key, const char *value,
 						 key, value);
 		}
 	} else if (data->list) {
-		string_list_append(data->list, p);
+		struct string_list_item *item;
+
+		if (!value)
+			return config_error_nonbool(key);
+
+		item = string_list_append(data->list, p);
+		item->util = xstrdup(value);
 	}
 
 	return 0;
diff --git a/help.c b/help.c
index 08b5c60204..5b1b320d02 100644
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
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 07a53e7366..a13d2be8ca 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -112,4 +112,14 @@ test_expect_success 'cannot alias-shadow a sample of regular builtins' '
 	done
 '
 
+test_expect_success 'alias without value reports error' '
+	test_when_finished "git config --unset alias.noval" &&
+	cat >>.git/config <<-\EOF &&
+	[alias]
+		noval
+	EOF
+	test_must_fail git noval 2>error &&
+	test_grep "alias.noval" error
+'
+
 test_done
-- 
2.53.0.122.g3abf75d576

