Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F5DC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiCYRdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiCYRdP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:33:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD8E119873
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:31:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u3so11246712ljd.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LEAKC3fRe9d1WIOOeFKAQ/hMlyD/c/E0Ad0qYB53cSk=;
        b=V6PPo4/pwrSNvK2mX33I6bgSintt457FFb4uxzZoYmTTSZruESE/ZpYe9rtfuAVIaU
         Afim+QXc5RgbwuozuO5pgdKQBPN3nwUOKeCPhi0ORwTGwqSO6WUKiEyTsiaC3ayAQqT6
         5Xop7trWFhXP1WqZxCz+T5C6fmG5kSkHW9gameGG8JM5kkSUKpBt1t15WfOwpOIT8lOi
         4533W0t9I36sBc6L35EBjLAFzvJNM4Ip6c6ep4Kq/uh+BDGJpNQ9E8TWYIYsfAnAZfM5
         e1NyiyQXEM0hFNrjMOgP8i6zwRqroDRoR1foZ3roEp+AzL4vKyouny58UhCPY2VzkHOH
         Qajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LEAKC3fRe9d1WIOOeFKAQ/hMlyD/c/E0Ad0qYB53cSk=;
        b=aCN4SSMWCy5ARHHgIJVhTIt0BC/2pUVUSdoz4ttsZc1yaVpCX3MbVvSst9XuntZmSe
         Fp9yfE+O7CZTRin5UjYouKqIEhtgNN/2v7zrzS6wyWfodC8yfHTJ0fxZsp2e+VbyEYHa
         /1auBLZBVJCSCY2c21kuDgCPVpPOMdz8Xq3nCheeFuEIfOtDZfbLGpps8BNzZBqUKz54
         kKiOTTZUVAkO82a7LV2EzFRH9aDbiCm4j5GqV0pkcN1b+jBmVWfsrXJL9D3a11Aih3rB
         GJK/7TBuUFXTzT28ipCbBTrXAEomgLFOv+FpkCzKNdgseoo61XxG8pMI4bMTNW0D0U3B
         zZuQ==
X-Gm-Message-State: AOAM532Fq9bxp3vJ5r83cn0yzIWHSVvfQSFy9aBnb9D5RedJ/to3wxzn
        z1/ZHp/4Dt+lxYNf8n99H1w6SIfAk85nbQ==
X-Google-Smtp-Source: ABdhPJzuYZOX3jXtEj16g/wSumrrf0WN+qNXG/2FEhZjXkWYIejpqVpD11mGNEUB2uyDtOSg8HmXxQ==
X-Received: by 2002:a5d:47a6:0:b0:205:97fc:8e98 with SMTP id 6-20020a5d47a6000000b0020597fc8e98mr7822381wrb.103.1648228792315;
        Fri, 25 Mar 2022 10:19:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 22/27] revisions API: clear "boundary_commits" in release_revisions()
Date:   Fri, 25 Mar 2022 18:18:46 +0100
Message-Id: <patch-v3-22.27-bf93197993c-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clear the "boundary_commits" object_array in release_revisions(). This
makes a few more tests pass under SANITIZE=leak, including
"t/t4126-apply-empty.sh" which started failed as an UNLEAK() in
cmd_format_patch() was removed in a preceding commit.

This also re-marks the various tests relying on "git format-patch" as
passing under "SANITIZE=leak", in the preceding "revisions API users:
use release_revisions() in builtin/log.c" commit those were marked as
failing as we removed the UNLEAK(rev) from cmd_format_patch() in
"builtin/log.c".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c                           | 1 +
 t/t4021-format-patch-numbered.sh     | 1 +
 t/t4028-format-patch-mime-headers.sh | 2 ++
 t/t4036-format-patch-signer-mime.sh  | 1 +
 t/t4122-apply-symlink-inside.sh      | 1 +
 t/t4126-apply-empty.sh               | 1 +
 t/t6110-rev-list-sparse.sh           | 1 +
 t/t9001-send-email.sh                | 1 +
 t/t9116-git-svn-log.sh               | 1 -
 9 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 6fd582819fe..53b3ab6dc2d 100644
--- a/revision.c
+++ b/revision.c
@@ -2954,6 +2954,7 @@ void release_revisions(struct rev_info *revs)
 {
 	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
+	object_array_clear(&revs->boundary_commits);
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
 	clear_pathspec(&revs->prune_data);
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 9be65fd4440..1219aa226dc 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -5,6 +5,7 @@
 
 test_description='Format-patch numbering options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4028-format-patch-mime-headers.sh b/t/t4028-format-patch-mime-headers.sh
index 204ba673cb5..60cb819c42e 100755
--- a/t/t4028-format-patch-mime-headers.sh
+++ b/t/t4028-format-patch-mime-headers.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='format-patch mime headers and extra headers do not conflict'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create commit with utf-8 body' '
diff --git a/t/t4036-format-patch-signer-mime.sh b/t/t4036-format-patch-signer-mime.sh
index 98d9713d8b2..48655bcc789 100755
--- a/t/t4036-format-patch-signer-mime.sh
+++ b/t/t4036-format-patch-signer-mime.sh
@@ -2,6 +2,7 @@
 
 test_description='format-patch -s should force MIME encoding as needed'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index aa52de401b9..96965373036 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -4,6 +4,7 @@ test_description='apply to deeper directory without getting fooled with symlink'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 66a7ba8ab8f..ece9fae207d 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -2,6 +2,7 @@
 
 test_description='apply empty'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6110-rev-list-sparse.sh b/t/t6110-rev-list-sparse.sh
index 13c1da53528..ddefc7f24ee 100755
--- a/t/t6110-rev-list-sparse.sh
+++ b/t/t6110-rev-list-sparse.sh
@@ -4,6 +4,7 @@ test_description='operations that cull histories in unusual ways'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 84d0f40d76a..dfa6b20f7a6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -4,6 +4,7 @@ test_description='git send-email'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # May be altered later in the test
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 34f6c80dea3..d74d7b2de68 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn log tests'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'setup repository and import' '
-- 
2.35.1.1509.ge4eeb5bd39e

