Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACE6C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiG1QaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiG1QaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298AD64C7
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l22so2891628wrz.7
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=d8q7zEFl8mKBKagMnt3ypvC+lSzqbRASaEJBkaJS/p0=;
        b=YlEKpNbsmA+tCFxMTeXHsebaIrldNZZYkZkhkc3FpU4h9iZ1Z4U2exJ8HfDCnOMyme
         6jDwqRgkIGnaRIm7YvOEsFmyvoQnjOm+VJ1yQ4SQClJiL3wCRGRK/E7FarnHQGutwgLq
         QlPwj2jhTVTR5nOjEI8uXWohNfSCVbIiYrCldAm0cwRPHV+9Fzx6MPwhdmuDxJTPsWiY
         vV6MEbASoNsF/tpTOCwI9q9/p2egiWz19RgjEZwxoMBOh4iiQlveJ5Vq61tELEpJMuYf
         cQbBU+KrFjHBk4HGpX7DFA3wfe0TerTfhbQ1PJRGFAGcjFLrlQZeNl5B5rfh3XRZhbTt
         P5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=d8q7zEFl8mKBKagMnt3ypvC+lSzqbRASaEJBkaJS/p0=;
        b=sQfrTCE3x3i6VZVLyRfUKcMEZR1+LvaVmOJGchlb94tgD+FO7t6aOq6YaYaXUf38LW
         fwQ47QJrRcf6gE1qRirF8TQkyi2JAdgeUPsFWVkyTw+xJ3PbBJwuVnWz/HUpzLoCaxAz
         rnDvSY8Fk0JOxcUYtBAGcHiw0f/aionkMCLsZuOVVN50Hl7fVyXEFgZvqrPYJ49RKBH5
         9VlFPiCrmerF5Xg43Rj6krAx9s+kk8ritTd/6ZdD8dSJqFJn8+Ph4GGnjAODNNBD56I7
         loyT5xZnkz8naKjmvpPz1O3Mer8WInUA4GnDd0Oilgr7leYiVoI8U2RD5viEjGcCH5CR
         OM6A==
X-Gm-Message-State: AJIora+UpDT72YYMMtxoSCYEQhenvGfhkV7RASM9becb66xePcc3CCNO
        jZNJ6jYqqIdB/yNLFJWVz8k73DN/Sj0IXg==
X-Google-Smtp-Source: AGRyM1vxstP0ielTtkxAkrcsSDVIGP0azyXYy3XAHifKItgdyO+XouOsJ1xBHuWXReN0EFm9phr11g==
X-Received: by 2002:a05:6000:1241:b0:21e:f1e1:2ca2 with SMTP id j1-20020a056000124100b0021ef1e12ca2mr3049779wrx.122.1659025817165;
        Thu, 28 Jul 2022 09:30:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/17] submodule--helper: fix a leak in "clone_submodule"
Date:   Thu, 28 Jul 2022 18:29:55 +0200
Message-Id: <patch-v4-01.17-aac987a414a-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
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
index 22c79353bb0..d3dd47588d5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1572,13 +1572,12 @@ static int clone_submodule(const struct module_clone_data *clone_data,
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
@@ -1663,6 +1662,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 
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
2.37.1.1197.g7ed548b7807

