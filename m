Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB5BC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiGUTNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiGUTNn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:13:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB18AB21
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv24so3614007wrb.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7Wv8cbvbu5WQTD8J8Zt33E2UZj6Ng7pf5hJ4tlPb6Q=;
        b=A8+vfHq60saYYxV0i8b/gAi4z8HWGLce1/Xe9uSxi4zSFUAQyUx4dDjYzRmyeLLu6X
         ppGUUgaZ1x/+Gb7bTQX3HWydb2c4dSI5eri6Hpa+zfQENFA+OXnp21TZE445cy9ugzPD
         CEUrhdhzabw/XImdZHkfTNP86uUzsXKpwQ2/7Fng0W2c3Ymmrke+YBDpNUwwB/k9BQXW
         HxfQnTQ83cTFmdU1S36uyXoVwU1UajrK4/ByhT4kblm+yjGEU70oBkBnG3yD/fou8enL
         Na8zMT58VIuJ3WuFGpMCArBc6Xk7yQyM46oEkr1fcYKbfVEB6GgC0OLoS6VnlWgi05t9
         PCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7Wv8cbvbu5WQTD8J8Zt33E2UZj6Ng7pf5hJ4tlPb6Q=;
        b=6MxIhiZAyCDom/Y+07xxfgjT45Zauxj8pVValbFFkle5QmkJR9hwUuVnWGA5d0+H/O
         49T9ULucjmzxJ/GEltCITArxz2G2gZDvAKboE2Zh7gNeO9hOmCB21VAFgme6NIzvxEta
         ibP/6xVCAgQjcxdodxUN53RlfrrpEI0NnAypCxSpWF4wWSFBeJue4sHhxhQZO24OWqA+
         Gsog2k4b/tiLynk8Z6w1200fF8jTX78aeXo4dFDM7Q7UNWaZGVqrY7UdJhzo0n0VN+9p
         Uu9J/ta3Wp37QXMoJDgWj5hV16cSCx24aj8ZBJ59McxHlVTeSt5alrgpt6J7fUWo+JOG
         GzPA==
X-Gm-Message-State: AJIora/nDrrmE2eG04mD0ElSfyMyf8LA0xc7YChuaUk6KboZUiEepYqO
        Se+xD7aqw2d00Nr57KkA3/4fkUFZyJDA2A==
X-Google-Smtp-Source: AGRyM1usMCGDLiqGse96swOvoA5Nt9en9mtsOoVuRHPxqvM/YcX2b8ssiMDcz1XITCpF4pwa9QjZrQ==
X-Received: by 2002:a5d:64ce:0:b0:21e:5064:a529 with SMTP id f14-20020a5d64ce000000b0021e5064a529mr5447906wri.213.1658430819364;
        Thu, 21 Jul 2022 12:13:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/26] submodule--helper: fix a leak in "clone_submodule"
Date:   Thu, 21 Jul 2022 21:13:00 +0200
Message-Id: <patch-v3-04.26-26f0caf0386-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
and we don't need to free our own "clone_data_path".

In the case of the module_clone() caller it's from "argv", and doesn't
need to be free'd, and in the case of the add_submodule() caller we
get a pointer to "sm_path", which doesn't need to be directly free'd
either.

Fixing this leak makes several tests pass, so let's mark them as
passing with TEST_PASSES_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c   | 6 ++++--
 t/t1500-rev-parse.sh          | 1 +
 t/t6008-rev-list-submodule.sh | 1 +
 t/t7414-submodule-mistakes.sh | 2 ++
 t/t7506-status-submodule.sh   | 1 +
 t/t7507-commit-verbose.sh     | 2 ++
 6 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7d5ee6a6261..1ddce8e19c1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1658,14 +1658,15 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const char *clone_data_path;
+	char *to_free = NULL;
 
 	if (!is_absolute_path(clone_data->path)) {
 		struct strbuf sb = STRBUF_INIT;
 
 		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
-		clone_data_path = strbuf_detach(&sb, NULL);
+		clone_data_path = to_free = strbuf_detach(&sb, NULL);
 	} else {
-		clone_data_path = xstrdup(clone_data_path);
+		clone_data_path = clone_data->path;
 	}
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
@@ -1750,6 +1751,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 
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
2.37.1.1095.g0bd6f54ba8a

