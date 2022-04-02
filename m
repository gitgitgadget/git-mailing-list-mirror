Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C331AC433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352038AbiDBKxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354517AbiDBKwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:52:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42594141DA7
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h4so5705259edr.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fq3x08VgcV91DmqOkJyRp5kWmyDXrLuyqHHBxykuYAc=;
        b=Zpmmy2KKoIcxOXIUkAG6tpOtUu8EEa5t8E4z2MppmMpMw1a3MI8ApvDhO3mHj+Dx9g
         RlwMfJm78nMlV2qroyRr7N1jWv46jpygDVQStZCl0ry6XDyDeEn5WSMMDyD6tqQ8tVf8
         JgK2fXdR8sHYApBHMUX3FAoWZzFhfLBXWX4xuevNJREuCc9X3A00fYtEqCpi+IJ3GAZJ
         2uxRC6yFRjR5nnIc4BtJFv/E3mIkSZ4bydEZ7yUbbqY4BM0oDh/iCz/YCx+1mJTuBuHD
         7YOHQnPPgIW3e9jNb/kOWDWV9eoydQJ3tWQMFLpQ66SwoiAsOMn3PunwowiM29todAZq
         /ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fq3x08VgcV91DmqOkJyRp5kWmyDXrLuyqHHBxykuYAc=;
        b=3abu91zgIO8obsneI2XBcABdGZU5uz+rglmcpL/Dqou6LdUTc0j8JBgfNcVEDcUj9X
         8jZUitXmi448La7LVIL53/KCkjp2PZmr8tdYKFdIezeaQwA1JtuJpAVQKA57D4BjpW5K
         7VxL8PZhm3lXI9VYw4xQU0TbMjQ12c69GsM+OeY9WbBFnJ9NMN6tF7bb3x/OgFu1nlUl
         BUFJDYNG9OWmvXVBJkOPqQz1qE77kapKLVcuIvZEeQt4sDIuPkWXiXkeV2pXzW92sWgu
         A77xT7qusLHm8Pbr7Ghl5vUl931HViifTdZMqtmfEL1Myni7CEHAbHvzE1Yb1rwXxs1x
         03PA==
X-Gm-Message-State: AOAM531YrL0E8W5jV2BUNTBx8hUTjHda+samt3I+ccpEumeW3x6tgiLU
        VKIU1bJSDvEjrxANIlOqCkwYgn6JqR062g==
X-Google-Smtp-Source: ABdhPJwIyZ4uio4/NH3TmLniKcz9XDhfYI1e78JzrlsRyrI0Aftw2w1wfsqZi8rVfKMrH+JfxL/SNw==
X-Received: by 2002:aa7:c881:0:b0:419:1a3d:4437 with SMTP id p1-20020aa7c881000000b004191a3d4437mr25093349eds.378.1648896606610;
        Sat, 02 Apr 2022 03:50:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:50:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 22/27] revisions API: clear "boundary_commits" in release_revisions()
Date:   Sat,  2 Apr 2022 12:49:36 +0200
Message-Id: <patch-v5-22.27-d96642d3502-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
index 9fb18924cbf..40f59c441f7 100644
--- a/revision.c
+++ b/revision.c
@@ -2949,6 +2949,7 @@ void release_revisions(struct rev_info *revs)
 {
 	free_commit_list(revs->commits);
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
index 42694fe5841..01c74b8b075 100755
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
2.35.1.1585.gd85f8dcb745

