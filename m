Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68E33291F
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468578; cv=pass; b=Qxdj3HdLdGdOk6GAX8loX0+iUJiOObenXGg/u/PyUUUwoI0OR9pqk+U1Nf/D61PShqbZJBTqYdgVVGGf55ZB+EJPBZdHF6MEDyC6N9f5BOeAa/CzVtIz1X7bWXBIDJPxPJfqNU16d3qYs/DHKpUgzp50sMZUp0XgzdI1aip8EHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468578; c=relaxed/simple;
	bh=XZ6j3KHHz9XGgT+N7TgFdXpWsBexpum7rIUXX6xVXfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUSqaTKW21TMH0IfPkexouh4EHyMNwtd6WYu3euleeHHkfjUn0XZxq2/X8OFZsPR1w0s4SNl8T77M/3iEcCj6FY1+3nrgxGgkv+0k2NnKDD6tw/pk40Q7rejQkd3R56o8J5hG01gp4nLae/43TLosxNw5tHxSJvnlhqK8uePtkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=iEW4uCfi; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="iEW4uCfi"
ARC-Seal: i=1; a=rsa-sha256; t=1774468564; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GchPLwb49ewD91u+o78tV7U/rmS2aDn3kCzOy0DbfK+HAOwuTNHFJS16Cjq4zYnTrNZ40UrPAFZ3J1+u7/0Dc/CaEcyJeWqKkuaYEABw7quRkQIuk+uVXRa0kSjHQKhsR6jXxwzZuq0ywSm1/FBrCj0MuyzWEi658wcL1eJ9J6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468564; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qoZfiJXvgxQ8tUihcATpQQ1wqCAz1mCun5+N+Z585qg=; 
	b=BUsgiQFQQXJ6LnWbFt2SO6tYjAyeEbAJbVeH3efQR9FX954tOEewb4oWZdtjRrGr92x03YB2WDShu3PoAaFaSdXH3w5oMkFTtC4icTmBfRslqM7BwxZ6ReUxCH0zffsYjDr8wTlz5et2Bc2P0srFlsZ9buencyy+O+SMIjWUzng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468564;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qoZfiJXvgxQ8tUihcATpQQ1wqCAz1mCun5+N+Z585qg=;
	b=iEW4uCfi4fzZfjin5cgpEOa/8xVoSeyrudfeAHnYRcLRdeg29yPjD9y9JDklSGfh
	xqwiSsMHSoagAf8xpJXTeuwqSkmY4t2G5/bFUbtDK+omBqI7mJz26PGlY49n5JgHbK/
	COEVT82TAbCOijbcRj8XDkJQS0tI9d9MhGvfn7Tg=
Received: by mx.zohomail.com with SMTPS id 1774468562691151.8131516505307;
	Wed, 25 Mar 2026 12:56:02 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 12/12] hook: reject unknown hook names in git-hook(1)
Date: Wed, 25 Mar 2026 21:55:03 +0200
Message-ID: <20260325195503.1139418-13-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260325195503.1139418-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260325195503.1139418-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Teach "git hook run" and "git hook list" to reject hook event names
that are not recognized by Git. This helps catch typos such as
"prereceive" when "pre-receive" was intended, since in 99% of the
cases users want known (already-existing) hook names.

The list of known hooks is derived from the generated hook-list.h
(built from Documentation/githooks.adoc). This is why the Makefile
is updated, so builtin/hook.c depends on hook-list.h. In meson the
header is already a dependency for all builtins, no change required.

The "--allow-unknown-hook-name" flag can be used to bypass this check.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-hook.adoc | 13 ++++--
 Makefile                    |  1 +
 builtin/hook.c              | 35 +++++++++++++++-
 t/t1800-hook.sh             | 82 +++++++++++++++++++++++++------------
 4 files changed, 100 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index e7d399ae57..318c637bd8 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -8,8 +8,8 @@ git-hook - Run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
-'git hook' list [-z] [--show-scope] <hook-name>
+'git hook' run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
+'git hook' list [--allow-unknown-hook-name] [-z] [--show-scope] <hook-name>
 
 DESCRIPTION
 -----------
@@ -121,6 +121,13 @@ list [-z] [--show-scope]::
 OPTIONS
 -------
 
+--allow-unknown-hook-name::
+	By default `git hook run` and `git hook list` will bail out when
+	`<hook-name>` is not a hook event known to Git (see linkgit:githooks[5]
+	for the list of known hooks). This is meant to help catch typos
+	such as `prereceive` when `pre-receive` was intended. Pass this
+	flag to allow unknown hook names.
+
 --to-stdin::
 	For "run"; specify a file which will be streamed into the
 	hook's stdin. The hook will receive the entire file from
@@ -159,7 +166,7 @@ Then, in your 'mywrapper' tool, you can invoke any users' configured hooks by
 running:
 
 ----
-git hook run mywrapper-start-tests \
+git hook run --allow-unknown-hook-name mywrapper-start-tests \
   # providing something to stdin
   --stdin some-tempfile-123 \
   # execute hooks in serial
diff --git a/Makefile b/Makefile
index bf2228de9d..6d64431219 100644
--- a/Makefile
+++ b/Makefile
@@ -2673,6 +2673,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
+builtin/hook.sp builtin/hook.s builtin/hook.o: hook-list.h
 
 builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
diff --git a/builtin/hook.c b/builtin/hook.c
index f671e7f91a..c0585587e5 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -4,12 +4,22 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hook.h"
+#include "hook-list.h"
 #include "parse-options.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
-	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
+	N_("git hook run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
 #define BUILTIN_HOOK_LIST_USAGE \
-	N_("git hook list [-z] [--show-scope] <hook-name>")
+	N_("git hook list [--allow-unknown-hook-name] [-z] [--show-scope] <hook-name>")
+
+static int is_known_hook(const char *name)
+{
+	const char **p;
+	for (p = hook_name_list; *p; p++)
+		if (!strcmp(*p, name))
+			return 1;
+	return 0;
+}
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
@@ -34,6 +44,7 @@ static int list(int argc, const char **argv, const char *prefix,
 	const char *hookname = NULL;
 	int line_terminator = '\n';
 	int show_scope = 0;
+	int allow_unknown = 0;
 	int ret = 0;
 
 	struct option list_options[] = {
@@ -41,6 +52,8 @@ static int list(int argc, const char **argv, const char *prefix,
 			    N_("use NUL as line terminator"), '\0'),
 		OPT_BOOL(0, "show-scope", &show_scope,
 			 N_("show the config scope that defined each hook")),
+		OPT_BOOL(0, "allow-unknown-hook-name", &allow_unknown,
+			 N_("allow running a hook with a non-native hook name")),
 		OPT_END(),
 	};
 
@@ -57,6 +70,13 @@ static int list(int argc, const char **argv, const char *prefix,
 
 	hookname = argv[0];
 
+	if (!allow_unknown && !is_known_hook(hookname)) {
+		error(_("unknown hook event '%s';\n"
+			"use --allow-unknown-hook-name to allow non-native hook names"),
+		      hookname);
+		return 1;
+	}
+
 	head = list_hooks(repo, hookname, NULL);
 
 	if (!head->nr) {
@@ -103,8 +123,11 @@ static int run(int argc, const char **argv, const char *prefix,
 	int i;
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	int ignore_missing = 0;
+	int allow_unknown = 0;
 	const char *hook_name;
 	struct option run_options[] = {
+		OPT_BOOL(0, "allow-unknown-hook-name", &allow_unknown,
+			 N_("allow running a hook with a non-native hook name")),
 		OPT_BOOL(0, "ignore-missing", &ignore_missing,
 			 N_("silently ignore missing requested <hook-name>")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
@@ -136,6 +159,14 @@ static int run(int argc, const char **argv, const char *prefix,
 	repo_config(the_repository, git_default_config, NULL);
 
 	hook_name = argv[0];
+
+	if (!allow_unknown && !is_known_hook(hook_name)) {
+		error(_("unknown hook event '%s';\n"
+			"use --allow-unknown-hook-name to allow non-native hook names"),
+		      hook_name);
+		return 1;
+	}
+
 	if (!ignore_missing)
 		opt.error_if_missing = 1;
 	ret = run_hooks_opt(the_repository, hook_name, &opt);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 8c5237449d..96749fc06d 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -31,11 +31,41 @@ test_expect_success 'git hook usage' '
 	grep "unknown option" err
 '
 
+test_expect_success 'git hook list: unknown hook name is rejected' '
+	test_must_fail git hook list prereceive 2>err &&
+	test_grep "unknown hook event" err
+'
+
+test_expect_success 'git hook run: unknown hook name is rejected' '
+	test_must_fail git hook run prereceive 2>err &&
+	test_grep "unknown hook event" err
+'
+
+test_expect_success 'git hook list: known hook name is accepted' '
+	test_must_fail git hook list pre-receive 2>err &&
+	test_grep ! "unknown hook event" err
+'
+
+test_expect_success 'git hook run: known hook name is accepted' '
+	git hook run --ignore-missing pre-receive 2>err &&
+	test_grep ! "unknown hook event" err
+'
+
+test_expect_success 'git hook run: --allow-unknown-hook-name overrides rejection' '
+	git hook run --allow-unknown-hook-name --ignore-missing custom-hook 2>err &&
+	test_grep ! "unknown hook event" err
+'
+
+test_expect_success 'git hook list: --allow-unknown-hook-name overrides rejection' '
+	test_must_fail git hook list --allow-unknown-hook-name custom-hook 2>err &&
+	test_grep ! "unknown hook event" err
+'
+
 test_expect_success 'git hook list: nonexistent hook' '
 	cat >stderr.expect <<-\EOF &&
 	warning: no hooks found for event '\''test-hook'\''
 	EOF
-	test_expect_code 1 git hook list test-hook 2>stderr.actual &&
+	test_expect_code 1 git hook list --allow-unknown-hook-name test-hook 2>stderr.actual &&
 	test_cmp stderr.expect stderr.actual
 '
 
@@ -47,7 +77,7 @@ test_expect_success 'git hook list: traditional hook from hookdir' '
 	cat >expect <<-\EOF &&
 	hook from hookdir
 	EOF
-	git hook list test-hook >actual &&
+	git hook list --allow-unknown-hook-name test-hook >actual &&
 	test_cmp expect actual
 '
 
@@ -56,7 +86,7 @@ test_expect_success 'git hook list: configured hook' '
 	test_config hook.myhook.event test-hook --add &&
 
 	echo "myhook" >expect &&
-	git hook list test-hook >actual &&
+	git hook list --allow-unknown-hook-name test-hook >actual &&
 	test_cmp expect actual
 '
 
@@ -68,7 +98,7 @@ test_expect_success 'git hook list: -z shows NUL-terminated output' '
 	test_config hook.myhook.event test-hook --add &&
 
 	printf "myhookQhook from hookdirQ" >expect &&
-	git hook list -z test-hook >actual.raw &&
+	git hook list --allow-unknown-hook-name -z test-hook >actual.raw &&
 	nul_to_q <actual.raw >actual &&
 	test_cmp expect actual
 '
@@ -77,12 +107,12 @@ test_expect_success 'git hook run: nonexistent hook' '
 	cat >stderr.expect <<-\EOF &&
 	error: cannot find a hook named test-hook
 	EOF
-	test_expect_code 1 git hook run test-hook 2>stderr.actual &&
+	test_expect_code 1 git hook run --allow-unknown-hook-name test-hook 2>stderr.actual &&
 	test_cmp stderr.expect stderr.actual
 '
 
 test_expect_success 'git hook run: nonexistent hook with --ignore-missing' '
-	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
+	git hook run --allow-unknown-hook-name --ignore-missing does-not-exist 2>stderr.actual &&
 	test_must_be_empty stderr.actual
 '
 
@@ -94,7 +124,7 @@ test_expect_success 'git hook run: basic' '
 	cat >expect <<-\EOF &&
 	Test hook
 	EOF
-	git hook run test-hook 2>actual &&
+	git hook run --allow-unknown-hook-name test-hook 2>actual &&
 	test_cmp expect actual
 '
 
@@ -108,7 +138,7 @@ test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
 	Will end up on stderr
 	Will end up on stderr
 	EOF
-	git hook run test-hook >stdout.actual 2>stderr.actual &&
+	git hook run --allow-unknown-hook-name test-hook >stdout.actual 2>stderr.actual &&
 	test_cmp stderr.expect stderr.actual &&
 	test_must_be_empty stdout.actual
 '
@@ -120,12 +150,12 @@ do
 		exit $code
 		EOF
 
-		test_expect_code $code git hook run test-hook
+		test_expect_code $code git hook run --allow-unknown-hook-name test-hook
 	'
 done
 
 test_expect_success 'git hook run arg u ments without -- is not allowed' '
-	test_expect_code 129 git hook run test-hook arg u ments
+	test_expect_code 129 git hook run --allow-unknown-hook-name test-hook arg u ments
 '
 
 test_expect_success 'git hook run -- pass arguments' '
@@ -139,7 +169,7 @@ test_expect_success 'git hook run -- pass arguments' '
 	u ments
 	EOF
 
-	git hook run test-hook -- arg "u ments" 2>actual &&
+	git hook run --allow-unknown-hook-name test-hook -- arg "u ments" 2>actual &&
 	test_cmp expect actual
 '
 
@@ -148,12 +178,12 @@ test_expect_success 'git hook run: out-of-repo runs execute global hooks' '
 	test_config_global hook.global-hook.command "echo no repo no problems" --add &&
 
 	echo "global-hook" >expect &&
-	nongit git hook list test-hook >actual &&
+	nongit git hook list --allow-unknown-hook-name test-hook >actual &&
 	test_cmp expect actual &&
 
 	echo "no repo no problems" >expect &&
 
-	nongit git hook run test-hook 2>actual &&
+	nongit git hook run --allow-unknown-hook-name test-hook 2>actual &&
 	test_cmp expect actual
 '
 
@@ -178,11 +208,11 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	# Test various ways of specifying the path. See also
 	# t1350-config-hooks-path.sh
 	>actual &&
-	git hook run test-hook -- ignored 2>>actual &&
-	git -c core.hooksPath=my-hooks hook run test-hook -- one 2>>actual &&
-	git -c core.hooksPath=my-hooks/ hook run test-hook -- two 2>>actual &&
-	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook -- three 2>>actual &&
-	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook -- four 2>>actual &&
+	git hook run --allow-unknown-hook-name test-hook -- ignored 2>>actual &&
+	git -c core.hooksPath=my-hooks hook run --allow-unknown-hook-name test-hook -- one 2>>actual &&
+	git -c core.hooksPath=my-hooks/ hook run --allow-unknown-hook-name test-hook -- two 2>>actual &&
+	git -c core.hooksPath="$PWD/my-hooks" hook run --allow-unknown-hook-name test-hook -- three 2>>actual &&
+	git -c core.hooksPath="$PWD/my-hooks/" hook run --allow-unknown-hook-name test-hook -- four 2>>actual &&
 	test_cmp expect actual
 '
 
@@ -262,7 +292,7 @@ test_expect_success 'hook can be configured for multiple events' '
 	# 'ghi' should be included in both 'pre-commit' and 'test-hook'
 	git hook list pre-commit >actual &&
 	grep "ghi" actual &&
-	git hook list test-hook >actual &&
+	git hook list --allow-unknown-hook-name test-hook >actual &&
 	grep "ghi" actual
 '
 
@@ -336,15 +366,15 @@ test_expect_success 'stdin to multiple hooks' '
 	b3
 	EOF
 
-	git hook run --to-stdin=input test-hook 2>actual &&
+	git hook run --allow-unknown-hook-name --to-stdin=input test-hook 2>actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'rejects hooks with no commands configured' '
 	test_config hook.broken.event "test-hook" &&
-	test_must_fail git hook list test-hook 2>actual &&
+	test_must_fail git hook list --allow-unknown-hook-name test-hook 2>actual &&
 	test_grep "hook.broken.command" actual &&
-	test_must_fail git hook run test-hook 2>actual &&
+	test_must_fail git hook run --allow-unknown-hook-name test-hook 2>actual &&
 	test_grep "hook.broken.command" actual
 '
 
@@ -353,7 +383,7 @@ test_expect_success 'disabled hook is not run' '
 	test_config hook.skipped.command "echo \"Should not run\"" &&
 	test_config hook.skipped.enabled false &&
 
-	git hook run --ignore-missing test-hook 2>actual &&
+	git hook run --allow-unknown-hook-name --ignore-missing test-hook 2>actual &&
 	test_must_be_empty actual
 '
 
@@ -403,7 +433,7 @@ test_expect_success 'globally disabled hook can be re-enabled locally' '
 	test_config hook.global-hook.enabled true &&
 
 	echo "global-hook ran" >expected &&
-	git hook run test-hook 2>actual &&
+	git hook run --allow-unknown-hook-name test-hook 2>actual &&
 	test_cmp expected actual
 '
 
@@ -463,7 +493,7 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 
 	test_expect_code 1 git \
 		-c core.hooksPath=bad-hooks \
-		hook run test-hook >out 2>err &&
+		hook run --allow-unknown-hook-name test-hook >out 2>err &&
 	test_must_be_empty out &&
 
 	# TODO: We should emit the same (or at least a more similar)
@@ -487,7 +517,7 @@ test_expect_success 'stdin to hooks' '
 	EOF
 
 	echo hello >input &&
-	git hook run --to-stdin=input test-hook 2>actual &&
+	git hook run --allow-unknown-hook-name --to-stdin=input test-hook 2>actual &&
 	test_cmp expect actual
 '
 
-- 
2.52.0.732.gb351b5166d.dirty

