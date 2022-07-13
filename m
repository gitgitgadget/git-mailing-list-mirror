Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B13DC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiGMNQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiGMNQb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A248B89
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r14so15507285wrg.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZDH3b6x8h+OcaYWfKRk+Vhl12tgBLrgywlkNhczg4VU=;
        b=Jh6Oi/Yf9hRb9HUNBgRXKbEr9DoDfZsei1q42RcPns93vXKt8ITWyE8sC8RdqdZsK2
         PlCukMMWwv8WzPriK+khU1stU8csceFUuIiDn8/Zke6HieNavVbz0qUFiKa2m0Wp8Mu0
         sR2gdyYibCdoOws/TiW/eA+QTBs9iiWbUS1pHfHB71g3WnFhriPe5rBdibgcnNYA8yfN
         Z+7rKSi1oBFQeADYqYwxJ059q5ctKjI8XHQmZHrTF8Rb4b3ZBj7UZFrBCyyQs4EdJ6XF
         HHDURAbv/5lGo3NwAf1JFmdTrEz66oHzVHD3vZHy+/EcNCfJvV60YRkcNbneuCexuyhc
         Z4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZDH3b6x8h+OcaYWfKRk+Vhl12tgBLrgywlkNhczg4VU=;
        b=xHmEPPaOFKMGllK5CRZbt9w0t4MH20iBYVUO3+o7Xyu0m+X8GDb7xoWvZ8fkMpgskw
         Wtv15qrLb4T6xIE1oJrhmcEYDNynO7VylGcHz6lyUl93HkKVh+y+qaMikw/6zKQ82DVV
         KBlPNkzMZ5ekZnwWg78PGuDvnD2SDUqe4wW3gbTDq1M8ceUZ7J5BmRB2GvwwbB07GTgB
         8DL8+ZOU4ztfghnP6b8VWhzr4cUFF6cVhk7onr1sr/leKWyHDjLGzk3vuUz6ZSguwUpA
         XhPoFnrBxoCSGZCn0PqAwpbKghzZoHdTmHkSkWTuL8Sx/lOkXj7JdITZYeGFZLVnvfSa
         m//w==
X-Gm-Message-State: AJIora9S/A6f/pf67947QwQCd5C+yIwdwaAJKabOkrU09DZmyhjKM+AZ
        Hjm9B4O3t4mkCOl1dCUTpHHQe3P6mJC9bg==
X-Google-Smtp-Source: AGRyM1uBfNs8V4wR0T4+VRNygf1uOmghVFy2FCohAondUSPNYmha7eZN0967qKjBWHZbcMkWTePAgg==
X-Received: by 2002:a05:6000:1acf:b0:21d:b410:59b2 with SMTP id i15-20020a0560001acf00b0021db41059b2mr3377609wry.31.1657718187809;
        Wed, 13 Jul 2022 06:16:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/11] submodule--helper: fix "module_clone_data" memory leaks
Date:   Wed, 13 Jul 2022 15:16:08 +0200
Message-Id: <patch-03.11-e5ec6945409-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks related to the "struct module_clone_data" by creating
a module_clone_data_release() function to go with the
MODULE_CLONE_DATA_INIT added in a98b02c1128 (submodule--helper:
refactor module_clone(), 2021-07-10).

The "path" member can come from "argv" (i.e. not malloc'd), or it can
be something we determine at runtime. In the latter case let's save
away a pointer to free() to avoid leaking memory.

Fixing this leak makes several tests pass, so let's mark them as
passing with TEST_PASSES_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c   | 24 +++++++++++++++++++-----
 t/t6008-rev-list-submodule.sh |  1 +
 t/t7414-submodule-mistakes.sh |  2 ++
 t/t7506-status-submodule.sh   |  1 +
 t/t7507-commit-verbose.sh     |  2 ++
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 73717be957c..23ab9c7e349 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1511,6 +1511,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 struct module_clone_data {
 	const char *prefix;
 	const char *path;
+	char *path_free;
 	const char *name;
 	const char *url;
 	const char *depth;
@@ -1527,6 +1528,11 @@ struct module_clone_data {
 	.single_branch = -1, \
 }
 
+static void module_clone_data_release(struct module_clone_data *cd)
+{
+	free(cd->path_free);
+}
+
 struct submodule_alternate_setup {
 	const char *submodule_name;
 	enum SUBMODULE_ALTERNATE_ERROR_MODE {
@@ -1651,9 +1657,9 @@ static int clone_submodule(struct module_clone_data *clone_data)
 
 	if (!is_absolute_path(clone_data->path)) {
 		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
-		clone_data->path = strbuf_detach(&sb, NULL);
+		clone_data->path = clone_data->path_free = strbuf_detach(&sb, NULL);
 	} else {
-		clone_data->path = xstrdup(clone_data->path);
+		clone_data->path = clone_data->path_free = xstrdup(clone_data->path);
 	}
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
@@ -1801,6 +1807,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 	clone_submodule(&clone_data);
 	list_objects_filter_release(&filter_options);
+
+	module_clone_data_release(&clone_data);
 	return 0;
 }
 
@@ -3016,6 +3024,7 @@ static int add_submodule(const struct add_data *add_data)
 {
 	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
+	int ret;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
@@ -3077,8 +3086,10 @@ static int add_submodule(const struct add_data *add_data)
 		if (add_data->depth >= 0)
 			clone_data.depth = xstrfmt("%d", add_data->depth);
 
-		if (clone_submodule(&clone_data))
-			return -1;
+		if (clone_submodule(&clone_data)) {
+			ret = -1;
+			goto cleanup;
+		}
 
 		prepare_submodule_repo_env(&cp.env);
 		cp.git_cmd = 1;
@@ -3097,7 +3108,10 @@ static int add_submodule(const struct add_data *add_data)
 		if (run_command(&cp))
 			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
 	}
-	return 0;
+	ret = 0;
+cleanup:
+	module_clone_data_release(&clone_data);
+	return ret;
 }
 
 static int config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
diff --git a/t/t6008-rev-list-submodule.sh b/t/t6008-rev-list-submodule.sh
index 3153a0d8910..12e67e187ef 100755
--- a/t/t6008-rev-list-submodule.sh
+++ b/t/t6008-rev-list-submodule.sh
@@ -8,6 +8,7 @@ test_description='git rev-list involving submodules that this repo has'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
index f2e7df59cf2..3269298197c 100755
--- a/t/t7414-submodule-mistakes.sh
+++ b/t/t7414-submodule-mistakes.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='handling of common mistakes people may make with submodules'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create embedded repository' '
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 3fcb44767f5..f5426a8e589 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -2,6 +2,7 @@
 
 test_description='git status for submodule'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_create_repo_with_commit () {
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index ed2653d46fe..92462a22374 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='verbose commit template'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 write_script "check-for-diff" <<\EOF &&
-- 
2.37.0.932.g7b7031e73bc

