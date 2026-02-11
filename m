Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4110357A37
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844738; cv=none; b=EhhZvTrMavvSsiiOPt/f/yVc2YqxNrnr0OABgDC+9SYqrLF3akqseW0RCTrs6htDfHFmxKmr734QtcapywwwEGJm6tx7TA/C0JhwWRlketPecCarQxJPcW5D0dcFkj+o4CIpoj40EzI9qkamIbFMudQJKrwpzmn7QES+0igiKrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844738; c=relaxed/simple;
	bh=80Ryg42sXg4XHYnxSja+AB+PzuYbTTgI4GA9u+Jgbzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IihwXWVHVrslF0QlHs1txlJ7njt6y/a2yCZ2ILK8gz71lBQHONxwNxOdxGDfEVYGSDChmY0h/ybMS0VoqZM2i36ckDuxpjrcMotc1zunc4WddDy2gb4q1KwhrPDkZrQjheYwr173+3a6kWNUTSdh5ug09/fNIQ8oj76ZtZ8wqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=D+WyNrLU; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="D+WyNrLU"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id CD8023F503;
	Wed, 11 Feb 2026 22:18:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXhYFuJJPslW; Wed, 11 Feb 2026 22:18:47 +0100 (CET)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id D04433F44B;
	Wed, 11 Feb 2026 22:18:47 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B4D6B1E34;
	Wed, 11 Feb 2026 22:17:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770844669; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8TGF7p5AVqLPmFN3bRho1g+bOmmfIQDxYekzw7i4l2k=;
	b=D+WyNrLU/xqxzKeQdqVaFcWaEkQaTsF2ZSZKpagixQj7itJwcFzSl5+6q56orWH9uBwsKV
	XRwcx1lj+oWP8IbcYcKGTLaLE2WUHVbAQH0h3mvapzNA4EYTmWCxo0O5UwhW7rHdqJzlf1
	adx/4VCee37mskzsmplFgQeIAa+CjidTBcEqkbqqMBJZ5dsP6t3KmVR692hi4OBWrZe5Qr
	wISb85NJp8m/L55VgQ7vSEEmYtz68ISJJgBVTOJ/oeNqqBVAL8u4mm+mvCS+0eZcfTJNLc
	z2utQKsU4B9u68zDbO5/OLQHBs2MvCP9hVPQ0ucV5d9QSCr8lH6INuPu4CEt7Q==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v4 1/3] help: use list_aliases() for alias listing
Date: Wed, 11 Feb 2026 22:18:08 +0100
Message-ID: <20260211211810.278806-2-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211211810.278806-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260211211810.278806-1-jonatan@jontes.page>
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
2.53.0

