Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C1ECCA47F
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbiGSUrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiGSUra (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D809E52895
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b6so9135419wmq.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ru+qiGxT5AZalzcbfc3whtai58teDxjj8ImMZWZPAvc=;
        b=MQHtkrW2XPejB5H6FUXs3IbWR75VHqiYT3rON2HXP0CjjK9XZLWO7bC/ftMQRiIygf
         JEPsOGj8QxV3dq+6Z1y4LfEmZ/yIWectwq27tb8Md6CS91D7wlM66auCizxZVse4ZRQ6
         Z4ko0CtbYfwHKKljagliRV2kcUHVgJM0JZUrb0MlASszbKSxRycSVpSMmZpu2cUauGoG
         kG4XkDqiE2RK1vD6eg4dd7ol3+16zgM4INT1ICSrQt1GtjGySEwkJ83EuECtDs6j7gaM
         y+Q2LRH3AD7WbrvKF3qDMzRFc/t9a3bkh0kKPREcytF0HCj3glZZ21sbj0LZlWLX+Nfn
         n23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ru+qiGxT5AZalzcbfc3whtai58teDxjj8ImMZWZPAvc=;
        b=dS2oB+NmlvKdrEfpkzwQQPzpbyJqEsK+/ZbtuXOgieizecjb/g61v3GOdN3FfAu8Bt
         J+lIfJCOcIx4CG16+5ok/ShuTBDnURQ2ye34pqKcYhwh/JJ5/7E1HogbVU9CMrx6Y3nb
         lEoPNctS9FeKRnpDDRogVAsARWlcbwsThXDGj2KwWdCFQGWnVC4Eg3gH0I3scGSt1MAp
         Wrm6Tmz+Fs4/HlRxcJWKZM7FntOvVPQl5fQqJm8cHOJnAsSQIbEW5Yk9xAM26qOMXvLe
         yutnNMtZFDyDlW9tQ8b/jtiP5smqO+nqXoMbKNKbDlDwLDoIvvRvOMubyqbpiVncAF0S
         2Q6A==
X-Gm-Message-State: AJIora+T+2sHgEDn0TA1FyFQa6LL+Rn505fTDQnE123JEPc/GC2TGifA
        dEi4WglDVjqYMAtslJ43Uim/8QrD/wje8g==
X-Google-Smtp-Source: AGRyM1sMF1E6ToWq5HFLcIvTrRshGMDucJOypTPxkF69gIGHrmWvGdOhB5harfjAL7eDYS4PEdQrsA==
X-Received: by 2002:a7b:c85a:0:b0:3a3:1884:6391 with SMTP id c26-20020a7bc85a000000b003a318846391mr898619wml.196.1658263646039;
        Tue, 19 Jul 2022 13:47:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/24] submodule--helper: fix a leak in "clone_submodule"
Date:   Tue, 19 Jul 2022 22:46:53 +0200
Message-Id: <patch-v2-02.24-130a396b837-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak of the "path" member of the "struct
module_clone_data" in clone_submodule(). This fixes leaks in code
added in f8eaa0ba98b (submodule--helper, module_clone: always operate
on absolute paths, 2016-03-31).

For the "else" case we don't need to xstrdup() the "clone_data->path",
if we're not creating a new one we'll leave it to our caller to keep
track of it.

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
index 73717be957c..4155d2450e0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1644,6 +1644,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct strbuf sb = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
+	char *to_free = NULL;
 
 	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
 	sm_gitdir = absolute_pathdup(sb.buf);
@@ -1651,9 +1652,9 @@ static int clone_submodule(struct module_clone_data *clone_data)
 
 	if (!is_absolute_path(clone_data->path)) {
 		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
-		clone_data->path = strbuf_detach(&sb, NULL);
+		clone_data->path = to_free = strbuf_detach(&sb, NULL);
 	} else {
-		clone_data->path = xstrdup(clone_data->path);
+		clone_data->path = clone_data->path;
 	}
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
@@ -1737,6 +1738,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	strbuf_release(&sb);
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
2.37.1.1062.g385eac7fccf

