Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C86C32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiHUOCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiHUOBu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C4024952
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a4so10316439wrq.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Z7lJBdPZL4AcV9OXa3DWl8WClrWy7fRP1JXrhHlSJLc=;
        b=CHwaNHf5MwTkQSHR+RCHfENNMzgcV9EQwzFNydf1mNaxmf6Xu6dmtlyZe5q8VYe19m
         e3OeBybxc1XjctU42/LvKzLxtvL2maKwwr3y3RXFKQP+V72l6qKiL4WZuz87HmklPXOJ
         owPTz+CQpyC217Cf6ZUoIoYicbseFodnxwEmohEdKninaRX6G3cvavy+FStgv9h/fkP7
         qZ3nidipiS2Wv7VamFd87lmxUOKfndqocpQ0hqxugGfo/7/NK2AmUaMTAagqeOD724tS
         /jJsKIKl77qExD5aRRT2YtbU0bGEYFu4ryCGLqoj81ZaOe/H1jHhXOArtt6+rhldFJ9g
         E2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Z7lJBdPZL4AcV9OXa3DWl8WClrWy7fRP1JXrhHlSJLc=;
        b=aonOu3OSkMlD9i6hu+ZzvMHC+XZPdfzidK2LBxhDO3es+Z8I08IVR6fCreXvw+qeZU
         Q1//WCdXpZBg5OpsCpX1Rh6MPqskhivTFi3wlkfJsxx9TVXy/6e/gsArnx1+rKAe8+I/
         cREzSe1drwscsue+cwlFB/ADDpIcnR43FeuC3tg5nByrtgZ3ah5Tw4LXRQNGsLqQrslB
         CpnULJoikr2RAUz3+AcdBuDLVyn7EqTUtesKAmIjmQzKkQUnXf3zaCXEXU2gWwgOeZox
         U1Rr0lATa/w2wc+zPk4ILUpTeb7X1rWP+0KqVwgI99uJ869K0bbiEn3lum8ssfrld9SR
         yA+w==
X-Gm-Message-State: ACgBeo2qtUyiYLOe8Wxhhx6hq4uJWfTCiIY0+eW7j9FQRS4dpfX7UzCb
        0RCJ/KQWknNSLZGPo8DllsmN5unmdv5C5gyj
X-Google-Smtp-Source: AA6agR78e3UrBqA23d4S7peMbkX6iaKzTLGXxEI/9stCrRUBGtvvD+QniIERuV0ewHScRVU7RmRY+w==
X-Received: by 2002:a05:6000:82:b0:225:21ff:a389 with SMTP id m2-20020a056000008200b0022521ffa389mr8309553wrx.22.1661090462584;
        Sun, 21 Aug 2022 07:01:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 01/17] submodule--helper: fix a leak in "clone_submodule"
Date:   Sun, 21 Aug 2022 15:59:25 +0200
Message-Id: <patch-v6-01.17-0f60ea6f7c6-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak of the "clone_data_path" variable that we copy or
derive from the "struct module_clone_data" in clone_submodule(). This
code was refactored in preceding commits, but the leak has been with
us since f8eaa0ba98b (submodule--helper, module_clone: always operate
on absolute paths, 2016-03-31).

For the "else" case we don't need to xstrdup() the "clone_data->path",
and we don't need to free our own "clone_data_path". We can therefore
assign the "clone_data->path" to our own "clone_data_path" right away,
and only override it (and remember to free it!) if we need to
xstrfmt() a replacement.

In the case of the module_clone() caller it's from "argv", and doesn't
need to be free'd, and in the case of the add_submodule() caller we
get a pointer to "sm_path", which doesn't need to be directly free'd
either.

Fixing this leak makes several tests pass, so let's mark them as
passing with TEST_PASSES_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c   | 10 +++++-----
 t/t1500-rev-parse.sh          |  1 +
 t/t6008-rev-list-submodule.sh |  1 +
 t/t7414-submodule-mistakes.sh |  2 ++
 t/t7506-status-submodule.sh   |  1 +
 t/t7507-commit-verbose.sh     |  2 ++
 6 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e489a0f6b10..2774f1884b0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1590,13 +1590,12 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 	char *sm_gitdir = clone_submodule_sm_gitdir(clone_data->name);
 	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *clone_data_path;
+	const char *clone_data_path = clone_data->path;
+	char *to_free = NULL;
 
 	if (!is_absolute_path(clone_data->path))
-		clone_data_path = xstrfmt("%s/%s", get_git_work_tree(),
-					  clone_data->path);
-	else
-		clone_data_path = xstrdup(clone_data->path);
+		clone_data_path = to_free = xstrfmt("%s/%s", get_git_work_tree(),
+						    clone_data->path);
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
 		die(_("refusing to create/use '%s' in another submodule's "
@@ -1681,6 +1680,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 
 	free(sm_gitdir);
 	free(p);
+	free(to_free);
 	return 0;
 }
 
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 1c2df08333b..0e13bcb4ebb 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -4,6 +4,7 @@ test_description='test git rev-parse'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_one () {
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
2.37.2.1279.g64dec4e13cf

