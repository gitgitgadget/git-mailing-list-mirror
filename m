Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B403339857
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770762503; cv=none; b=fUQnUC0fqkRnMrTsDzGTc6arlN968J3ILMPVDVI+lLxU650+PnOkUxSn1i52Fljzs+U63UmH4lJ2mr0jDW7Oiywn3cCfhmXgjoOPdRhqk/GdJJKi4zoxhnZ9TRywOwPTjWrR8Gp8vMh90g2Jn6ArBHo/gSjqoqrUAF8nYlMD2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770762503; c=relaxed/simple;
	bh=SOPa4JmNTs49AcFGwfTrlN1bNcBrLPHRjuNVp5t9srw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCFc3zgIizTMsPJuc/fWigvPbLVEmDfdELnAnX2vBKF70VRSg5Z4j1bkCvPewT443ClUhxrcVNh91o0nIgD9ihNr/ICki1imskuNOB+E7eBR4rGoluyoeTBgP1ZQYGIBz9zTom0H9ZBwfQ/WJkzjRflNsC+9XtrfwFCuZTQjFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=Brd0RIAO; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="Brd0RIAO"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 3E7E03F85A;
	Tue, 10 Feb 2026 23:28:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id atf0z3eLuogz; Tue, 10 Feb 2026 23:28:19 +0100 (CET)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 0DAFE3F44B;
	Tue, 10 Feb 2026 23:28:19 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8286B1E74;
	Tue, 10 Feb 2026 23:27:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770762441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YSmOMcTOg8xEJToK/rxsh1rQnwjDO9wpe0QFsvUTRQc=;
	b=Brd0RIAOlSbRbXd3iWLT7Bfa/0FskYHqhsjhqTDlgR3qGSsBogOhIXKc/JWW4YSdAIbhQB
	cXLqHhBvrA/6MG0inDs+dC2oWYouAK00MhhcArpnoIBVpBZNtfNme4vFycf4s+jFRSzWNh
	qzdGpXSGLPfiPvrVouUFrw0WxLePVIdY1w/YgBHvEahRtBsYnY/ev5TN1zH13TK7QL6OiX
	pPOVuYDXtutKhjZV8hKeNcH3jkq0rSskjE5Cm7BSM8uuHi4Jz2k/6qiEvoKqI9LLXc/4bt
	L79xAWk8uBi+wBYxH10NxChto+6v2KahviqzTv9MCTSHvj8WJNrUeZKL8hJh4Q==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH 3/3] alias: support non-alphanumeric names via subsection syntax
Date: Tue, 10 Feb 2026 23:27:45 +0100
Message-ID: <20260210222745.78575-4-jonatan@jontes.page>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Git alias names are limited to ASCII alphanumeric characters and
dashes because aliases are implemented as config variable names, which
are validated by iskeychar(). This prevents non-English speakers from
creating aliases in their native languages.

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
 alias.c                         | 39 +++++++++++++++++----
 help.c                          | 14 ++++++--
 t/t0014-alias.sh                | 60 +++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+), 18 deletions(-)

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
index 1f8e13610c..ae1fe1efc6 100644
--- a/alias.c
+++ b/alias.c
@@ -17,15 +17,37 @@ static int config_alias_cb(const char *key, const char *value,
 			   const struct config_context *ctx UNUSED, void *d)
 {
 	struct config_alias_data *data = d;
-	const char *p;
+	const char *subsection, *subkey;
+	size_t subsection_len;
 
-	if (!skip_prefix(key, "alias.", &p))
+	if (parse_config_key(key, "alias", &subsection, &subsection_len,
+			     &subkey) < 0)
 		return 0;
 
+	/*
+	 * Two config syntaxes:
+	 * - alias.name = value   (without subsection, case-insensitive)
+	 * - [alias "name"]
+	 *       command = value  (with subsection, case-sensitive)
+	 */
+	if (subsection) {
+		if (strcmp(subkey, "command"))
+			return 0;
+		if (!value)
+			return config_error_nonbool(key);
+	}
+
 	if (data->alias) {
-		if (!strcasecmp(p, data->alias)) {
-			if (!value)
-				return config_error_nonbool(key);
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
@@ -33,10 +55,13 @@ static int config_alias_cb(const char *key, const char *value,
 	} else if (data->list) {
 		struct string_list_item *item;
 
-		item = string_list_append(data->list, p);
+		if (subsection)
+			item = string_list_append_nodup(data->list,
+				xmemdupz(subsection, subsection_len));
+		else
+			item = string_list_append(data->list, subkey);
 		if (value)
 			item->util = xstrdup(value);
-		/* if !value, item->util remains NULL but item is still added */
 	}
 
 	return 0;
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
index 07a53e7366..5d1f7730e6 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -112,4 +112,64 @@ test_expect_success 'cannot alias-shadow a sample of regular builtins' '
 	done
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
+	git help -a | grep "förgrena"
+'
+
 test_done
-- 
2.53.0

