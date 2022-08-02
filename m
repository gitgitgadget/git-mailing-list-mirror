Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C1AC19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiHBPzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiHBPys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0662610F
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l19so673437wms.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=g5vlRPbSFA2Cl+yQKOKErsP5J2lmy3i2Xbucntum8eE=;
        b=ZzOO81RfsFwJUQerN/s1R+6f7An+78jLkSOVojvwcugtUMbRATzrdpHwiywpDgHz6N
         rKMlObmYXwhm0ttgsEBF/IABvCTksLORWsrnjm94ZZhhGytDGQ0szB+0u8uMU6F89Vxp
         +nwhFqqXCc/ZGIPGXsaJzPoFfPR5eqXMjQkmuwGmRJMp/uwoFNjZWJItx2BtaXhhe1/q
         3y2ZpSf1hl2OUaVlmSmx2G+Aca5i/gw5h/yFl+9Lbka4Lej1li3OejQoPoDWcT1E7m4D
         d2Ci+LH270y69UhGdJ234U+0xXXnAxLEVMxEDfHmmEcE+5uutxMMpny67UobmZ2KOd84
         1lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=g5vlRPbSFA2Cl+yQKOKErsP5J2lmy3i2Xbucntum8eE=;
        b=Z0BKGsCb6k0Cpsqh5/MtiH4QoLru5ZugZLnQkLQSWdWwdf33lRZv//FujKNvtPwr/R
         i0JiSigpeyWSwRWegMhgSVfjMhDOVUM2FRJsZgZziRJSJBNmGSo5rY5HfpepRLagR02a
         YnlazQvsAjWF5rcyb+Vg6WVKNzS+XB+kXK/Htsy2+24Rr7P53QUohej3NzEAliHlSXYK
         WtfrwCsjbNbDtokd8EEHgoz0UrPf3va30A7Dhq4jrpYvTZtf2DPxGfB7qYo4KuxHpaPK
         ZHbuLn3WZUz7bnEevOmHTRmAucheIPBJphfl8XG8llOHt0nwgdUsl4SS/uvhlUTwl0z1
         +1fQ==
X-Gm-Message-State: ACgBeo0r7SAX/WW+knU9foxuLZCE9x73ObcEQVqv1R/xIgZFBpVr6efp
        P0DchYopYogC/7Q17CgB9jBGTTbW6Yh97g==
X-Google-Smtp-Source: AA6agR4R/jj7WdYM+0am6yJaRmW8xB48dUI++tS435eEtySyqBFpLrfCq1LfGzGwuB2ERSf1B6EUxQ==
X-Received: by 2002:a05:600c:3d0d:b0:3a3:7a1a:326a with SMTP id bh13-20020a05600c3d0d00b003a37a1a326amr66045wmb.127.1659455686100;
        Tue, 02 Aug 2022 08:54:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/17] submodule--helper: fix a leak in "clone_submodule"
Date:   Tue,  2 Aug 2022 17:54:25 +0200
Message-Id: <patch-v5-01.17-118e965d401-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
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
index 5bc9cc41369..d7eaedee491 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1592,13 +1592,12 @@ static int clone_submodule(const struct module_clone_data *clone_data,
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
@@ -1683,6 +1682,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 
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
2.37.1.1233.ge8b09efaedc

