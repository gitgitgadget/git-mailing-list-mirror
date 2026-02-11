Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F56311977
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844743; cv=none; b=pVnAFEQapj1SwyIIp0lJYw8eHphdPsKW9Um4BD7KqUcRclSk+FasA27YJ2wMIBFne2op/evJqPxkdZSxCNyD2MkQtyPPOiFUnEh9J0z2a4drCziUGg7FQMR5VYPYsGR46zVTt00GAUHlz7RH+BpDAiQ3inPdW6Aj8ydpQijTva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844743; c=relaxed/simple;
	bh=9ykDifSQY54Lii7ghFyq4rieHHjmcEzXxi+nvcqfrjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQqHFMfdDsXCJbRD0xqDCAc3VwD4TFnCePIEpJSvipS9/W9gWT12/s/Fu4avCj+zcKwPf+KC2fWUlyNnPrxNLCRRBJNKAEYADGdPmDxEvezrO1ew2MBkLf466JNJ9x7dOm1THKYP8gy2OJ7Ahhpw9kxq0TFqPf6DdPZXGlEQV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=ag+h59gt; arc=none smtp.client-ip=79.136.2.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="ag+h59gt"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 273E3408FC;
	Wed, 11 Feb 2026 22:18:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vsJXhGKzaep3; Wed, 11 Feb 2026 22:18:52 +0100 (CET)
Received: 
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 434A43F6F3;
	Wed, 11 Feb 2026 22:18:52 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA7D3B1E34;
	Wed, 11 Feb 2026 22:17:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770844673; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=30pZ9p+BV4aShSka4/t6HHZhomNsJ383otHoKPI8kKc=;
	b=ag+h59gtQQhu0Om4fohFpRM0lrOp5zHU9KCWrKH1Q3/6XYkcH7yIG5fawWZ/4Ae1Ac7Yi2
	2VjrO2MdgEJ64H6WqD9GTdJxKy5uNLIWwdCGoFtaldierSwcH0pHkb7KKxOjScCFDBUvLJ
	2phFi38kXRVqTvMjzC+WSx9upDMqJ7hKnOe9yqOvidAdDD7cXXLm5HE4+vCIStDC7idrBo
	Q+Z2OD0Wwv7EoXgTIQAeds0i+6YoMStT2xm6cLqyuFG6zl6LX3HLQfzDQ+IajRI4wVkSuC
	2nUKVHSEn4ZH5fjdmYt9pDeroShQLpbWlivK66Ho2aUm4VWrlzUkBpGGPeh4Uw==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v4 3/3] alias: support non-alphanumeric names via subsection syntax
Date: Wed, 11 Feb 2026 22:18:10 +0100
Message-ID: <20260211211810.278806-4-jonatan@jontes.page>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Git alias names are limited to ASCII alphanumeric characters and
dashes because aliases are implemented as config variable names.
This prevents non-English speakers from creating aliases in their
native languages.

Add support for arbitrary alias names by using config subsections:

    [alias "förgrena"]
        command = branch

The subsection name is matched as-is (case-sensitive byte comparison),
while the existing definition without a subsection (e.g.,
"[alias] co = checkout") remains case-insensitive for backward
compatibility. This uses existing config infrastructure since
subsections already support arbitrary bytes, and avoids introducing
Unicode normalization.

Also teach the help subsystem about the new syntax so that "git help
-a" properly lists subsection aliases and the autocorrect feature can
suggest them. Use utf8_strwidth() instead of strlen() for column
alignment so that non-ASCII alias names display correctly.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 Documentation/config/alias.adoc | 43 ++++++++++++++++++-----
 alias.c                         | 32 ++++++++++++++---
 help.c                          | 14 ++++++--
 t/t0014-alias.sh                | 61 +++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 80ce17d2de..9184f7cb37 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -1,12 +1,39 @@
 alias.*::
-	Command aliases for the linkgit:git[1] command wrapper - e.g.
-	after defining `alias.last = cat-file commit HEAD`, the invocation
-	`git last` is equivalent to `git cat-file commit HEAD`. To avoid
-	confusion and troubles with script usage, aliases that
-	hide existing Git commands are ignored except for deprecated
-	commands.  Arguments are split by
-	spaces, the usual shell quoting and escaping are supported.
-	A quote pair or a backslash can be used to quote them.
+alias.*.command::
+	Command aliases for the linkgit:git[1] command wrapper. Aliases
+	can be defined using two syntaxes:
++
+--
+1. Without a subsection, e.g., `[alias] co = checkout`. The alias
+   name is limited to ASCII alphanumeric characters and `-`,
+   and is matched case-insensitively.
+2. With a subsection, e.g., `[alias "name"] command = value`. The
+   alias name can contain any characters including UTF-8, and is
+   matched case-sensitively as raw bytes.
+--
++
+Examples:
++
+----
+# Without subsection (ASCII alphanumeric and dash only)
+[alias]
+    co = checkout
+    st = status
+
+# With subsection (allows any characters, including UTF-8)
+[alias "hämta"]
+    command = fetch
+[alias "gömma"]
+    command = stash
+----
++
+E.g. after defining `alias.last = cat-file commit HEAD`, the invocation
+`git last` is equivalent to `git cat-file commit HEAD`. To avoid
+confusion and troubles with script usage, aliases that
+hide existing Git commands are ignored except for deprecated
+commands.  Arguments are split by
+spaces, the usual shell quoting and escaping are supported.
+A quote pair or a backslash can be used to quote them.
 +
 Note that the first word of an alias does not necessarily have to be a
 command. It can be a command-line option that will be passed into the
diff --git a/alias.c b/alias.c
index 271acb9bf1..896d0f80a4 100644
--- a/alias.c
+++ b/alias.c
@@ -17,13 +17,33 @@ static int config_alias_cb(const char *key, const char *value,
 			   const struct config_context *ctx UNUSED, void *d)
 {
 	struct config_alias_data *data = d;
-	const char *p;
+	const char *subsection, *subkey;
+	size_t subsection_len;
 
-	if (!skip_prefix(key, "alias.", &p))
+	if (parse_config_key(key, "alias", &subsection, &subsection_len,
+			     &subkey) < 0)
+		return 0;
+
+	/*
+	 * Two config syntaxes:
+	 * - alias.name = value   (without subsection, case-insensitive)
+	 * - [alias "name"]
+	 *       command = value  (with subsection, case-sensitive)
+	 */
+	if (subsection && strcmp(subkey, "command"))
 		return 0;
 
 	if (data->alias) {
-		if (!strcasecmp(p, data->alias)) {
+		int match;
+
+		if (subsection)
+			match = (strlen(data->alias) == subsection_len &&
+				 !strncmp(data->alias, subsection,
+					  subsection_len));
+		else
+			match = !strcasecmp(data->alias, subkey);
+
+		if (match) {
 			FREE_AND_NULL(data->v);
 			return git_config_string(&data->v,
 						 key, value);
@@ -34,7 +54,11 @@ static int config_alias_cb(const char *key, const char *value,
 		if (!value)
 			return config_error_nonbool(key);
 
-		item = string_list_append(data->list, p);
+		if (subsection)
+			item = string_list_append_nodup(data->list,
+				xmemdupz(subsection, subsection_len));
+		else
+			item = string_list_append(data->list, subkey);
 		item->util = xstrdup(value);
 	}
 
diff --git a/help.c b/help.c
index eccd0c22f8..d7c6011780 100644
--- a/help.c
+++ b/help.c
@@ -21,6 +21,7 @@
 #include "fsmonitor-ipc.h"
 #include "repository.h"
 #include "alias.h"
+#include "utf8.h"
 
 #ifndef NO_CURL
 #include "git-curl-compat.h" /* For LIBCURL_VERSION only */
@@ -108,7 +109,7 @@ static void print_command_list(const struct cmdname_help *cmds,
 
 	for (i = 0; cmds[i].name; i++) {
 		if (cmds[i].category & mask) {
-			size_t len = strlen(cmds[i].name);
+			size_t len = utf8_strwidth(cmds[i].name);
 			printf("   %s   ", cmds[i].name);
 			if (longest > len)
 				mput_char(' ', longest - len);
@@ -492,7 +493,7 @@ static void list_all_cmds_help_aliases(int longest)
 	string_list_sort(&alias_list);
 
 	for (i = 0; i < alias_list.nr; i++) {
-		size_t len = strlen(alias_list.items[i].string);
+		size_t len = utf8_strwidth(alias_list.items[i].string);
 		if (longest < len)
 			longest = len;
 	}
@@ -591,8 +592,15 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 	/* Also use aliases for command lookup */
 	if (!parse_config_key(var, "alias", &subsection, &subsection_len,
 			      &key)) {
-		if (!subsection)
+		if (subsection) {
+			/* [alias "name"] command = value */
+			if (!strcmp(key, "command"))
+				add_cmdname(&cfg->aliases, subsection,
+					    subsection_len);
+		} else {
+			/* alias.name = value */
 			add_cmdname(&cfg->aliases, key, strlen(key));
+		}
 	}
 
 	return 0;
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index a13d2be8ca..34bbdb51c5 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -122,4 +122,65 @@ test_expect_success 'alias without value reports error' '
 	test_grep "alias.noval" error
 '
 
+test_expect_success 'subsection syntax works' '
+	test_config alias.testnew.command "!echo ran-subsection" &&
+	git testnew >output &&
+	test_grep "ran-subsection" output
+'
+
+test_expect_success 'subsection syntax only accepts command key' '
+	test_config alias.invalid.notcommand value &&
+	test_must_fail git invalid 2>error &&
+	test_grep -i "not a git command" error
+'
+
+test_expect_success 'subsection syntax requires value for command' '
+	test_when_finished "git config --remove-section alias.noval" &&
+	cat >>.git/config <<-\EOF &&
+	[alias "noval"]
+		command
+	EOF
+	test_must_fail git noval 2>error &&
+	test_grep "alias.noval.command" error
+'
+
+test_expect_success 'simple syntax is case-insensitive' '
+	test_config alias.LegacyCase "!echo ran-legacy" &&
+	git legacycase >output &&
+	test_grep "ran-legacy" output
+'
+
+test_expect_success 'subsection syntax is case-sensitive' '
+	test_config alias.SubCase.command "!echo ran-upper" &&
+	test_config alias.subcase.command "!echo ran-lower" &&
+	git SubCase >upper.out &&
+	git subcase >lower.out &&
+	test_grep "ran-upper" upper.out &&
+	test_grep "ran-lower" lower.out
+'
+
+test_expect_success 'UTF-8 alias with Swedish characters' '
+	test_config alias."förgrena".command "!echo ran-swedish" &&
+	git förgrena >output &&
+	test_grep "ran-swedish" output
+'
+
+test_expect_success 'UTF-8 alias with CJK characters' '
+	test_config alias."分支".command "!echo ran-cjk" &&
+	git 分支 >output &&
+	test_grep "ran-cjk" output
+'
+
+test_expect_success 'alias with spaces in name' '
+	test_config alias."test name".command "!echo ran-spaces" &&
+	git "test name" >output &&
+	test_grep "ran-spaces" output
+'
+
+test_expect_success 'subsection aliases listed in help -a' '
+	test_config alias."förgrena".command "!echo test" &&
+	git help -a >output &&
+	test_grep "förgrena" output
+'
+
 test_done
-- 
2.53.0

