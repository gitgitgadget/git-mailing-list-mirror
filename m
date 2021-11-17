Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA75BC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0787613A2
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbhKQLqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbhKQLqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 06:46:44 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42606C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:43:46 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id az33-20020a05600c602100b00333472fef04so4514403wmb.5
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uxvEk8bsWNHYdCvBbz/8vZfbARJ8yJa5f/BX1xrBVRM=;
        b=GQzo2ZS4BbqR+7hNBcVjmSHwhkNG/GCPu8VN9xiL0LeZK1kRdsLqilXpg1IvTLZyWy
         oJWIAgxGrgz2yprD8Ms8Zd00OpQCNWCJmANwZp7AI0t6MQlVYaSb10/HAyTd7ZrFluKG
         aMAQgRLvJzYGUrqUjPHnz1RgBBDYkND7Kn4Pt79jH96YcU/IdgM2FGNA5XDP2Lyc/MSN
         F8h7y1ovp0cgbKeSokj5JRlU186SYOr2DxAlka2zhmZ6aI0K+LQBPE/G4XKiCpcF9M6c
         bzsK0nNa5Vt75bFHuvsUmRMnD93uDkbmEgBaczM+qeFA03uJHgUsN4wpqutnVJJINwsm
         i6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uxvEk8bsWNHYdCvBbz/8vZfbARJ8yJa5f/BX1xrBVRM=;
        b=ZBNdyTmdFctxUZywG7VBdbIm1aJHuuJ8J00YxVxMmQfeN0TMVvfMd06pU7RQQB2Bjr
         OmGToP7h/dtNg0WHfQy/ujCzsvruFTkhubQLa1/YLB6SOzUku6jPCfCXDM+7IFvkHdtW
         fg9R0H7l2Fe6PTSrKNSQgogNPQl4nM0Wec9Hkad6X053sY+6fpzaAztJe/VYSLNibz1m
         vCZV8T9coQ/Lc1qWnDA5CuMq736Pv0M7kvNHYD4RXPviSrFHryiy8ecDeILwL9rTJULn
         sf0uZe+T60hWvY9QoQtRDVubFIaUWYAscDENVjxoHScWw9WiTRL97cj3dIAN4v+EzgPr
         JlSg==
X-Gm-Message-State: AOAM5325ULCVoj1HkKaX39Tfz79uhI4r7i9SXq3cMeZAXqiQCSbOGksT
        ztkMeEoMKi/3ESBmO8CslYxBMNIqXQlFsw==
X-Google-Smtp-Source: ABdhPJzDtFtaf6x5ApLAF2+9ClR8152PTC2C2L4zACMj2h/+OlGfvhjGYPUwslKd460XRF48vmQ3xA==
X-Received: by 2002:a05:600c:4e02:: with SMTP id b2mr73830652wmq.105.1637149424524;
        Wed, 17 Nov 2021 03:43:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e18sm20398678wrs.48.2021.11.17.03.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:43:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/2] submodule: add test mode for checking absence of "superProjectGitDir"
Date:   Wed, 17 Nov 2021 12:43:40 +0100
Message-Id: <RFC-patch-2.2-b49d4c8db7d-20211117T113134Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com>
References: <20211117005701.371808-1-emilyshaffer@google.com> <RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=false test mode to
assert what happens if "submodule.superProjectGitDir" is absent or
missing, this checks if the "fallback" codepath in
get_superproject_working_tree() is equivalent to the config lookup.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/run-build-and-tests.sh          |  1 +
 git-submodule.sh                   |  2 +-
 submodule.c                        |  7 +++++++
 t/lib-submodule-superproject.sh    | 24 ++++++++++++++++++++++++
 t/t7406-submodule-update.sh        |  9 ++++-----
 t/t7412-submodule-absorbgitdirs.sh | 19 ++++++-------------
 6 files changed, 43 insertions(+), 19 deletions(-)
 create mode 100644 t/lib-submodule-superproject.sh

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cc62616d806..5132a210057 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -33,6 +33,7 @@ linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
+	export GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=false
 	make test
 	;;
 linux-clang)
diff --git a/git-submodule.sh b/git-submodule.sh
index 7c247bee7f6..2b423ee05bc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -453,7 +453,7 @@ cmd_update()
 		# changed, unless it's a fresh clone. Write to worktree if
 		# applicable, and point to superproject's worktree gitdir if
 		# applicable.
-		if test -z "$just_cloned"
+		if test -z "$just_cloned" && test "$GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR" != "false"
 		then
 			sm_gitdir="$(git -C "$sm_path" rev-parse --absolute-git-dir)"
 			relative_gitdir="$(git rev-parse --path-format=relative \
diff --git a/submodule.c b/submodule.c
index ad95cdda07d..f0411a320a8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2143,6 +2143,9 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	if (!git_configset_get_bool(&sub_cs, "extensions.worktreeConfig", &tmp))
 		strbuf_addstr(&config_path, ".worktree");
 
+	if (!git_env_bool("GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR", 1))
+		goto fallback;
+
 	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
 			       relative_path(absolute_path(get_git_dir()),
 					     real_new_git_dir, &sb));
@@ -2150,6 +2153,8 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	git_configset_clear(&sub_cs);
 	strbuf_release(&config_path);
 	strbuf_release(&sb);
+
+fallback:
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
@@ -2332,6 +2337,8 @@ int get_superproject_working_tree(struct strbuf *buf)
 	const char *wt_prefix = "worktree ";
 	int rc = 0;
 
+	if (!git_env_bool("GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR", 1))
+		goto fallback;
 
 	/* Do we know we have a superproject? */
 	if (git_config_get_string("submodule.superprojectgitdir", &super_gitdir))
diff --git a/t/lib-submodule-superproject.sh b/t/lib-submodule-superproject.sh
new file mode 100644
index 00000000000..4d49dd3782e
--- /dev/null
+++ b/t/lib-submodule-superproject.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_lazy_prereq SUBMODULE_CACHE_SUPERPROJECT_DIR '
+	test_bool_env GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR true
+'
+
+test_cmp_submodule_superprojectgitdir () {
+	if ! test_have_prereq SUBMODULE_CACHE_SUPERPROJECT_DIR
+	then
+		return 0
+	fi
+
+	git -C "$1" config submodule.superprojectGitDir >actual &&
+	test_cmp expect actual
+}
+
+test_file_not_empty_superprojectgitdir () {
+	if ! test_have_prereq SUBMODULE_CACHE_SUPERPROJECT_DIR
+	then
+		return 0
+	fi
+
+	test_file_not_empty "$(git -C $1 rev-parse --absolute-git-dir)/$2"
+}
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 01e1acaf300..f362f8d0ef0 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-superproject.sh
 
 
 compare_head()
@@ -1068,8 +1069,7 @@ test_expect_success 'submodule update adds superproject gitdir to older repos' '
 	 test-tool path-utils relative_path \
 		"$(git rev-parse --absolute-git-dir)" \
 		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
-	 git -C submodule config submodule.superprojectGitdir >actual &&
-	 test_cmp expect actual
+	 test_cmp_submodule_superprojectgitdir submodule
 	)
 '
 
@@ -1081,10 +1081,9 @@ test_expect_success 'submodule update uses config.worktree if applicable' '
 	 test-tool path-utils relative_path \
 		"$(git rev-parse --absolute-git-dir)" \
 		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
-	 git -C submodule config submodule.superprojectGitdir >actual &&
-	 test_cmp expect actual &&
+	 test_cmp_submodule_superprojectgitdir submodule &&
 
-	 test_file_not_empty "$(git -C submodule rev-parse --absolute-git-dir)/config.worktree"
+	 test_file_not_empty_superprojectgitdir submodule config.worktree
 	)
 '
 
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 5753f902687..6faab7e56e9 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -7,6 +7,7 @@ directory into the superproject.
 '
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-superproject.sh
 
 test_expect_success 'setup a real submodule' '
 	git init sub1 &&
@@ -38,9 +39,7 @@ test_expect_success 'absorb the git dir' '
 
 	test-tool path-utils relative_path "$superproject_gitdir" \
 		"$submodule_gitdir" >expect &&
-	git -C sub1 config submodule.superprojectGitDir >actual &&
-
-	test_cmp expect actual
+	test_cmp_submodule_superprojectgitdir sub1
 '
 
 test_expect_success 'absorbing does not fail for deinitialized submodules' '
@@ -78,9 +77,7 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 
 	test-tool path-utils relative_path "$sub1_gitdir" "$sub1_nested_gitdir" \
 		>expect &&
-	git -C sub1/nested config submodule.superprojectGitDir >actual &&
-
-	test_cmp expect actual
+	test_cmp_submodule_superprojectgitdir sub1
 '
 
 test_expect_success 're-setup nested submodule' '
@@ -170,9 +167,7 @@ test_expect_success 'absorbgitdirs works when called from a superproject worktre
 
 	test-tool path-utils relative_path "$superproject_gitdir" \
 		"$submodule_gitdir" >expect &&
-	git -C sub4 config submodule.superprojectGitDir >actual &&
-
-	test_cmp expect actual
+	test_cmp_submodule_superprojectgitdir sub4
 	)
 '
 
@@ -199,12 +194,10 @@ test_expect_success 'absorbgitdirs works with a submodule with worktree config'
 
 	test-tool path-utils relative_path "$superproject_gitdir" \
 		"$submodule_gitdir" >expect &&
-	git -C sub5 config submodule.superprojectGitDir >actual &&
-
-	test_cmp expect actual &&
+	test_cmp_submodule_superprojectgitdir sub5 &&
 
 	# make sure the config went into the submodule config.worktree
-	test_file_not_empty "$submodule_gitdir/config.worktree"
+	test_file_not_empty_superprojectgitdir sub5 config.worktree
 	)
 '
 
-- 
2.34.0.796.g2c87ed6146a

