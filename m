Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FFC1802C6
	for <git@vger.kernel.org>; Tue, 14 May 2024 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710610; cv=none; b=haCDbyN1YK8YCHYFqxArPC5Qig16QYq5Lke+LsP0TRXcVSz0vqEkM4NQZUKDHK2v5NAaNsoMqb6G4kQBfufH88NitGLM1Jq9NIXrqtf097KBKGVR9BaU7nSUK5nNU9HijlPi56KojCIYtGzayZuWa8Az6vKExYw7pbJ50HP7XGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710610; c=relaxed/simple;
	bh=OdgKVbDMhdazLoFxPcQe0s7DL8mQx2S6s1BEl6HhQTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTTBiqvB26POBq6rNlrhcFZSiR8PXAXsYHb4nN1Z02Ym/zCM5h9D76e7EU8GzPTyhdeAi7m1KHm14WKg25DCMOADTqNMPhlbqTrghDHRaSToeZjaWfvGqLljiPcbtkcTQMN0syqUchtZOhx0NJHY0W127ZjliqjxYLlO7ZSDZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ogFmCh7X; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ogFmCh7X"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A87D25DA88;
	Tue, 14 May 2024 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715710605;
	bh=OdgKVbDMhdazLoFxPcQe0s7DL8mQx2S6s1BEl6HhQTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ogFmCh7X3mBfFMlx1+TvEofMeMmLiJt0+xsuwtJQeeAWsya4fKxrQGTFwpYUlBJ/x
	 KOsot6wquGIcIcAeK4EwS0vDskA76T4zXFrEXejDh8An8LXbTPoHKz5w21dweTjhmA
	 3+Jhr4WNfp2L5RnVEs/BMaMyOsr1f2IRQuIm1B2j2L1zVlyeu6P/F+M0W05MSa8n+1
	 Lg1rvsp5H5w+/QGa20WCD30chy5IdfMJeLF/cQKVwRVkDYxMHQ2ri+WatTsUZCmRU1
	 1HQ5L8dLS1YQDh3NDmcqzZ7dcAmEWyPcJK27GBzcYwu19RO6gKCEH/SagaY6orEVMP
	 zRwamY6ZU7m4hVvBsro0e68SgOdocfN214n4lB74kX8vNcs5WlcQW36l77xpEW8j/Z
	 qz7TlPZYuMMk3hacSBrj0VOCpZiq/neVtzXVK6TMEYGQp477Scalkfn+c/Y14l2n8r
	 E64IZOp/4pwT/iuX4AS/TaiQFzbqmLbanraL9QSLs9Z2BqDPRjb
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Revert "clone: prevent hooks from running during a clone"
Date: Tue, 14 May 2024 18:16:40 +0000
Message-ID: <20240514181641.150112-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240514181641.150112-1-sandals@crustytoothpaste.net>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <bk2204@github.com>

This change breaks Git LFS, which relies on the pre-checkout hook to run
in a clone.  This is to allow files which have the lockable attribute,
which are usually large binary assets which cannot be merged, to
be marked read-only when a user doesn't have a lock so as to prevent
conflicts.

Revert this change since it causes functional problems.

This reverts commit 8db1e8743c0f1ed241f6a1b8bf55b6fef07d6751.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 builtin/clone.c  |  5 -----
 hook.c           | 32 ------------------------------
 t/t5601-clone.sh | 51 ------------------------------------------------
 3 files changed, 88 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0e7cf198f5..c66a32feb3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -987,12 +987,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
 
-	xsetenv("GIT_CLONE_PROTECTION_ACTIVE", "true", 0 /* allow user override */);
 	template_dir = get_template_dir(option_template);
-	if (*template_dir && !is_absolute_path(template_dir))
-		template_dir = template_dir_dup =
-			absolute_pathdup(template_dir);
-	xsetenv("GIT_CLONE_TEMPLATE_DIR", template_dir, 1);
 
 	if (option_depth || option_since || option_not.nr)
 		deepen = 1;
diff --git a/hook.c b/hook.c
index eebc4d4473..f5f46e844e 100644
--- a/hook.c
+++ b/hook.c
@@ -11,30 +11,6 @@
 #include "setup.h"
 #include "copy.h"
 
-static int identical_to_template_hook(const char *name, const char *path)
-{
-	const char *env = getenv("GIT_CLONE_TEMPLATE_DIR");
-	const char *template_dir = get_template_dir(env && *env ? env : NULL);
-	struct strbuf template_path = STRBUF_INIT;
-	int found_template_hook, ret;
-
-	strbuf_addf(&template_path, "%s/hooks/%s", template_dir, name);
-	found_template_hook = access(template_path.buf, X_OK) >= 0;
-#ifdef STRIP_EXTENSION
-	if (!found_template_hook) {
-		strbuf_addstr(&template_path, STRIP_EXTENSION);
-		found_template_hook = access(template_path.buf, X_OK) >= 0;
-	}
-#endif
-	if (!found_template_hook)
-		return 0;
-
-	ret = do_files_match(template_path.buf, path);
-
-	strbuf_release(&template_path);
-	return ret;
-}
-
 const char *find_hook(const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
@@ -70,14 +46,6 @@ const char *find_hook(const char *name)
 		}
 		return NULL;
 	}
-	if (!git_hooks_path && git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0) &&
-	    !identical_to_template_hook(name, path.buf))
-		die(_("active `%s` hook found during `git clone`:\n\t%s\n"
-		      "For security reasons, this is disallowed by default.\n"
-		      "If this is intentional and the hook should actually "
-		      "be run, please\nrun the command again with "
-		      "`GIT_CLONE_PROTECTION_ACTIVE=false`"),
-		    name, path.buf);
 	return path.buf;
 }
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index deb1c282c7..cc0b953f14 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -788,57 +788,6 @@ test_expect_success 'batch missing blob request does not inadvertently try to fe
 	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
 '
 
-test_expect_success 'clone with init.templatedir runs hooks' '
-	git init tmpl/hooks &&
-	write_script tmpl/hooks/post-checkout <<-EOF &&
-	echo HOOK-RUN >&2
-	echo I was here >hook.run
-	EOF
-	git -C tmpl/hooks add . &&
-	test_tick &&
-	git -C tmpl/hooks commit -m post-checkout &&
-
-	test_when_finished "git config --global --unset init.templateDir || :" &&
-	test_when_finished "git config --unset init.templateDir || :" &&
-	(
-		sane_unset GIT_TEMPLATE_DIR &&
-		NO_SET_GIT_TEMPLATE_DIR=t &&
-		export NO_SET_GIT_TEMPLATE_DIR &&
-
-		git -c core.hooksPath="$(pwd)/tmpl/hooks" \
-			clone tmpl/hooks hook-run-hookspath 2>err &&
-		test_grep ! "active .* hook found" err &&
-		test_path_is_file hook-run-hookspath/hook.run &&
-
-		git -c init.templateDir="$(pwd)/tmpl" \
-			clone tmpl/hooks hook-run-config 2>err &&
-		test_grep ! "active .* hook found" err &&
-		test_path_is_file hook-run-config/hook.run &&
-
-		git clone --template=tmpl tmpl/hooks hook-run-option 2>err &&
-		test_grep ! "active .* hook found" err &&
-		test_path_is_file hook-run-option/hook.run &&
-
-		git config --global init.templateDir "$(pwd)/tmpl" &&
-		git clone tmpl/hooks hook-run-global-config 2>err &&
-		git config --global --unset init.templateDir &&
-		test_grep ! "active .* hook found" err &&
-		test_path_is_file hook-run-global-config/hook.run &&
-
-		# clone ignores local `init.templateDir`; need to create
-		# a new repository because we deleted `.git/` in the
-		# `setup` test case above
-		git init local-clone &&
-		cd local-clone &&
-
-		git config init.templateDir "$(pwd)/../tmpl" &&
-		git clone ../tmpl/hooks hook-run-local-config 2>err &&
-		git config --unset init.templateDir &&
-		test_grep ! "active .* hook found" err &&
-		test_path_is_missing hook-run-local-config/hook.run
-	)
-'
-
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
