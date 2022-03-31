Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C5EC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352323AbiCaBOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352299AbiCaBOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EBA66CA6
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso1075812wmn.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=msFGNvUlUj3I+cPPdEz40z63Tgiv87b1JBf1lcu5ih0=;
        b=ZJntzh9TJrv1xs1DJ8uE2M75j482B8as89nQunyrXloiQMAzPSNxEfegDNz7W7V6qS
         bh3/O2JYs3BXfi4TJtStM2bvGTM9+sIz9FuYol8v2VkCiiid1hB33YwuQGAYqaCKTCGx
         v7YIxK3WlB/UvTbhYDBwl0h/pN3TsvNM9MC8xE1WSX/G5ke/Z4patCukPLooegkZuh1N
         kXo8Nm2bcbiineaj8ZAiFsUzreDzH3mDp796ktSMBvIYdoJosDsPczJI/5gUyNulV26r
         JsyOo3Zau9L38ZtR6i66yhQ8XvUIjFE2kOpyYsSm/OvdHwSMqoEqmvr16gc4E5slsHJY
         OEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msFGNvUlUj3I+cPPdEz40z63Tgiv87b1JBf1lcu5ih0=;
        b=ndYnOlyN94SdMh3qpMoE2fju4FodqMIbc69veAJj/iJYyruQMDC0wi6RRQ7e/5+hXh
         WIomzZWjnCvJcBDJTR17Cs3aCm/kSLvaKWj7CRXM+xKm+P8ZsH2Jz6it8vWK7uRpq2Ks
         37ku+dU2Twj2P7vCbVdX60ZHOS8lyqtcvvuPyz1BorYn5/D8RQX6jNMyYji5758ayzWj
         C8IsryaTzYvYOz0swKXXEvRmZlRpbAi8pkM4j1T0sv7CCpiELb2Dd59OVmpH9keIwrQQ
         U2Udm1IZBQC7hpIU9sjwJ32WL25+N0GoctWSAdRZtWko/0sfVU1BDLw5SHxfDhN8Ffth
         pWoA==
X-Gm-Message-State: AOAM531mmySChEwlxLsdCfjSW1Yhfz/9ODhbpQFW0s+ZtPJQjDO7uKWg
        64o/HfI8mcjFTn3UVgjRhe9UTCzfW0cbyg==
X-Google-Smtp-Source: ABdhPJyGIuHKDBShk9QZh8S9f95seKozBs7faxoEj6kBFRr3AmkGnJloTgNT+xwWe+BAomp3Dkjoqw==
X-Received: by 2002:a05:600c:3b98:b0:38c:b19d:59f2 with SMTP id n24-20020a05600c3b9800b0038cb19d59f2mr2297281wms.205.1648689144560;
        Wed, 30 Mar 2022 18:12:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:24 -0700 (PDT)
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
Subject: [PATCH v4 22/27] revisions API: clear "boundary_commits" in release_revisions()
Date:   Thu, 31 Mar 2022 03:11:27 +0200
Message-Id: <patch-v4-22.27-cb201fa1914-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
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
index c7a0e08765a..9806240770c 100644
--- a/revision.c
+++ b/revision.c
@@ -2958,6 +2958,7 @@ void release_revisions(struct rev_info *revs)
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
2.35.1.1557.g4e3e9cdb5e0

