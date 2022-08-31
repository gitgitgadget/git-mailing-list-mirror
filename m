Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C2FECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiHaXO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiHaXOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6CC26A
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso429475wmb.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bjHn49QNWUcCrQDZ1Nyq7ulMnZPyRUd+CXbc93Hw/cA=;
        b=OzNCKwYL/Leb4Yekvx8sJBpJ2XYY+FNgubFyECahHHoPlIrGzK6pWrxeJtIhkFgc6A
         +tt8uuiRJH0eGbgX+WdryBFQuEr/q0Xt/TQJ/tU7w8oeVplXRzSz4/+bW3aouI39c7WA
         uQn677Pf0N450CC9QhdYWLDvCmkd1Bahms65mevi2TwRe0v5RcoWJiQX6zuK9gbEETaB
         zQL5KV4AnTAZokXpFnJ/Yi5vmBvil3hKAs2LItGmVHty8bniv0B5Xt6nvakAojiFN5ly
         NdnaCVaJpwnFXSuriqpSdyzD+UUOkNEMDrzpZQpj5I5WSQRspEZ08zpMDFVb2cB8XNqi
         vcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bjHn49QNWUcCrQDZ1Nyq7ulMnZPyRUd+CXbc93Hw/cA=;
        b=tWAAFzpFrvyAUERT4WhbfRBWWQen/r48Z8h978OyJI+6AuSs0xB7jZlirgKI8tAa+U
         vYF85yhCPwovhqrwUin+s9ZTw2U2xhNFntN+FEZh9xLVZoZofGaTgdvn/8XJYmJ8t7zO
         X8Fp6ITCOHYTLb39LwYujuFnaS4I+RxPuDByyUfkwvLtaBL78XkKkIHuJmxXNB00Jasx
         BqxMQmUr8fYJ/GGNwrK3JTBCSu5ip8J08ZZ1xUnEBUc/cz9FbiI29YbhrR2tfkJkpB0I
         Ohv+QicDkxTTaZVZihPUwE/pP3kpBLKOGJ4D6N/6HCyP/gjROByl8uFROcqwuC6nncbf
         MxTQ==
X-Gm-Message-State: ACgBeo02HG72zOYn1y47HerGeWUDte+2vQ0luomMWAejKxuTRmgDWxIo
        Wav3nrp2J0aFKvTYiwFSxIQ4zHnSgp3+MA==
X-Google-Smtp-Source: AA6agR57EPnW2tR+HRX2UNmTLMyaoEg5wTu24YsWYaRYJo6RRXwQMVrg8JSIQUWMi2LDgk9/MJB8Qw==
X-Received: by 2002:a7b:cb95:0:b0:3a6:166:6e23 with SMTP id m21-20020a7bcb95000000b003a601666e23mr3289333wmi.15.1661987683454;
        Wed, 31 Aug 2022 16:14:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 01/17] submodule--helper: fix a leak in "clone_submodule"
Date:   Thu,  1 Sep 2022 01:14:08 +0200
Message-Id: <patch-v7-01.17-40d4aef60fa-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
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
index c4149f11e7f..2e042c8a043 100644
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
2.37.3.1420.g76f8a3d556c

