Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE733D6FA
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426374; cv=none; b=eGPin8jZFaKy4G6Q2gtSSuLBAG3t8Ez4CJ5+w1EWkBkN34S8sHjJxupgEjECCpGL+6VaJIkbJYvg42QmilkDu6GXmvgvAYdh0ueuwX/NltDlVRnq7StyZ081YeKKmbL2bGikI7pLOHSwQ9nm+8tYtFmDYfYA/iRfOF7Pd1Rf+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426374; c=relaxed/simple;
	bh=oLPN4fhyB8meEKx5D8EhLhTol2n19Z79PgLjdqJogIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQhRfPdVAU/MRj6TA/VodyoFX52RcBx8FmW8bWEnR9kOdRh2WayDsILNrMWwLj008v9NsPMJRmsKnTwBKnOd15NKwdJsVdCLZs5j6Qh8r0KKaVW5CKOF8ESgXBX9P9cGDJPfktgdIOkG6Ybp4iWah7pc96vxJlq5MF32CayU+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=Fn9Ia9xG; arc=none smtp.client-ip=213.80.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="Fn9Ia9xG"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A2EF43F7AA;
	Wed, 18 Feb 2026 15:52:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w-9HbU-_Ga2F; Wed, 18 Feb 2026 15:52:39 +0100 (CET)
Received: 
	by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 10BBC3F62C;
	Wed, 18 Feb 2026 15:52:39 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E45CB20AA;
	Wed, 18 Feb 2026 15:51:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771426290; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pxi+8qvas+dnSQgLUoKovn+Lux9w9TrDZSs3mGINAyk=;
	b=Fn9Ia9xG5HBBenG+jCLUW/mgGV4nwLfJuWqTfvVng5xfxkSvjZAHqzlyJ5OBZnVg61yvGs
	5y2a5T9B6Bckz+tFDP+n21qI20LyNOvxRUV08TNYOcbmuaLz3ht3ZJObtYth8RzbBZ9A2v
	h4gGHKavp0P1iaM1Z/yIGF0ypt2X8LzGsoPx5BtLuXoENaxcV6TSsBZmaOcvvT9HtcrByq
	1AT3ZJ9BfCXxMFZo+92huAd5SlyBUlRKSCkh+1hZo3JWVx6j+/5h1z6/mBXrb0oJH2+RPL
	3BThpi9Cy1BeNBq4ap4uVHSZkDhJLyID4bcO5iu7rvwKMQtoqofhEJE/GJek9g==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v6 1/4] help: use list_aliases() for alias listing
Date: Wed, 18 Feb 2026 15:52:11 +0100
Message-ID: <20260218145214.581460-2-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0.122.g3abf75d576
In-Reply-To: <20260218145214.581460-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218145214.581460-1-jonatan@jontes.page>
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
2.53.0.122.g591c997fb5.dirty

