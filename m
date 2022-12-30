Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30431C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiL3H2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiL3H2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37CF18B3B
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so17906051wma.1
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1s5a5fcs1dWZsAOCL7oPLvyvKLfhYiVkwnXAoypRgA=;
        b=CmmUu3xWPqH1VzWtJI5O6BQIQh93scCpq+Z+zX+z9egRmjckubA2EZJEB02IXeM9ig
         dkIlPJWJc6VmRZuFhUsGSdQXMOR9xKoRbpnJoWhEIYFdu7Yql08D/XrdnfbTYkC/rUoV
         XLjwzc98woKV0/XtDiEIOQfIn94hZBnKY55Iw5CP7JWURbenz8K8bmUFQIvuZjjNU6OE
         xv8KfJn0B1gZxMbAjuE3+MC7u+A1GZIWrxDyLRL9khG+KLeAJ83aAtNNhaW8nJUDed8P
         RgV9sZuuoSfAAzMbROmPjzTbd1kkbDOqagzVCQl8MKCLJfL/4XB6cOg7kZYfRjsufctW
         8cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1s5a5fcs1dWZsAOCL7oPLvyvKLfhYiVkwnXAoypRgA=;
        b=YY5akgyy3EELaIhia8snszyGLOCCv1QaAUa7ApJ/FTmRssCYbJ+bbDS7pI9OcvDNeA
         to6SBOlv68TvQkduM5QnnuJlF6fCVb3aRRgZZyZ/T147+uhgrT0Up7XVKMaCMtNKM879
         asKzYKLYP1vHoVhNEMQFRyPuWPKVW4cjd33sZLC6/mcpNtnDXxiwK1jYpg1hyD6aR+1s
         XYhC9dpaGcQ0GfdfD9y3TQnzjy+6T9LOrCBVIW/MfZPl6C/Q86WIcBa0jtFs6ZJrpebP
         mZFtEBlJTf87siKGKdGKpO4jEiK0jSmg/gqY6WSlpGmcuXisGgM+FRz0VUiuX7NP4LEH
         yqpw==
X-Gm-Message-State: AFqh2kpSe+t/nSFsQ06i2pdmds4xBaxVnu38CY6zjAbE7opwPSyg7KtQ
        ZRDBecoPWTc+E0RdtdeGW7q921mW+DRWiw==
X-Google-Smtp-Source: AMrXdXuk/kCbT9AdFRLQtFQryVk/XR9O8gznLuXK0wTbX2RvbVpJgmaOPE+/CfXzX1jwmDckgsE7RA==
X-Received: by 2002:a1c:7c14:0:b0:3d1:f74d:4f60 with SMTP id x20-20020a1c7c14000000b003d1f74d4f60mr24928761wmc.22.1672385303198;
        Thu, 29 Dec 2022 23:28:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] builtin/revert.c: fix common leak by using replay_opts_release()
Date:   Fri, 30 Dec 2022 08:28:10 +0100
Message-Id: <patch-05.10-e2895bb9795-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the replay_opts_release() function introduced in a preceding
commit to fix a memory leak in run_sequencer().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/revert.c                  | 1 +
 t/t3419-rebase-patch-id.sh        | 1 +
 t/t3425-rebase-topology-merges.sh | 2 ++
 t/t3501-revert-cherry-pick.sh     | 1 +
 t/t3502-cherry-pick-merge.sh      | 1 +
 t/t3503-cherry-pick-root.sh       | 1 +
 t/t3506-cherry-pick-ff.sh         | 1 +
 t/t3511-cherry-pick-x.sh          | 1 +
 8 files changed, 9 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index e956d125a2b..2f656b25619 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -240,6 +240,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		cmd == 's' ? sequencer_skip :
 		sequencer_pick_revisions;
 	ret = cbfun(the_repository, opts);
+	replay_opts_release(opts);
 	return ret;
 }
 
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 7181f176b81..6c61f240cf9 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -5,6 +5,7 @@ test_description='git rebase - test patch id computation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 scramble () {
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 63acc1ea4da..a16428bdf54 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='rebase topology tests with merges'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 1f4cfc37449..2f3e3e24169 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -13,6 +13,7 @@ test_description='test cherry-pick and revert with renames
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 5495eacfec1..1b2c0d6aca6 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -11,6 +11,7 @@ test_description='cherry picking and reverting a merge
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index 95fe4feaeee..76d393dc8a3 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -5,6 +5,7 @@ test_description='test cherry-picking (and reverting) a root commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index 7e11bd4a4c5..b71bad17b85 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -5,6 +5,7 @@ test_description='test cherry-picking with --ff option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 84a587daf3a..dd5d92ef302 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -2,6 +2,7 @@
 
 test_description='Test cherry-pick -x and -s'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pristine_detach () {
-- 
2.39.0.1153.g589e4efe9dc

