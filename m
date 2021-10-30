Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E823AC433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33E0603E9
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhJ3W1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhJ3W1I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881FCC0613B9
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i5so14665983wrb.2
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsBES3ZDYwWMOrMQ4gn/udb1W0OtudarTDOP2hdgqvs=;
        b=C61tfU6tu8aydmAZlZ0sKE03M9ZnthsANcllCXuUXD4BIQ8oPTos+aALuhCcTd+vN9
         i3WaThfx5rv/MCZgHqm087UUNWtkzTX91dQKBwzIJY+ghF5nUjKMoA9crD+QAYrzMUgV
         kvSP2VSAYTucUi7HEOooNaWNMr2pVigUMgIETsiEsmwkSjK0+rPqHEX3e+oDACIv5aHY
         KM6C7LVUEx/SA6q5971FGOO9Sl0aV2esC7MTYNy8xyX5ylki08Es7tC2YnmDmJvYDBBH
         9fs/XJ9FpuWRK6GD6bIiBYzKQt1p5kd0GaOdOPabDdSb3xFeZLS4jVkAIE7/NzPMLc9P
         F2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsBES3ZDYwWMOrMQ4gn/udb1W0OtudarTDOP2hdgqvs=;
        b=ljr3yxloH1vKcVpJGhZdqGe25GZKnuaBHD0p2OGNNnfxXLMdIJKB1Pk8TmxrWJCWy/
         1QCiZnD/NS91azn7yDXOxTHlkqk+QNkHLa5TzT/Zzl/at8BEKkuCM1lcXXQq/+ALcR/w
         y5ul9p9m3uFv7P+eAEcz057/HIghjXgx8qdFm5vdmIWQDRMbLzPuDEW5ij38AwlMEhRp
         vH/kXWEQ66bb+Gz5ktziB+S8z60r42S5EFDk+1IAi02MsRDWjcDvj3D2KriK5BKd3FJV
         sq8Ft4SGQWyV8XRNpBu7OVXfqk753HGgcuqA88u2p34izHE4haZWOzwXqZjL8hkJci7g
         5lEA==
X-Gm-Message-State: AOAM532z1KivXr+zO7qO4WftIjtcIoGM440BJXMJKu3ir4pzmBI0DcW+
        pyGgim8PhYMMTaOXyosLHSCn66UFEbROZg==
X-Google-Smtp-Source: ABdhPJw1J7wKhpv3cgaviCJufOOy2nVX9/C9JVSbrxcL28s1zApSiDcRhmodA4a/R2AmXONsBd3agg==
X-Received: by 2002:a5d:47a7:: with SMTP id 7mr25053140wrb.75.1635632674719;
        Sat, 30 Oct 2021 15:24:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/15] leak tests: mark some diff tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:19 +0200
Message-Id: <patch-10.15-78c76dbf5ea-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*diff*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4000-diff-format.sh             | 2 ++
 t/t4003-diff-rename-1.sh           | 2 ++
 t/t4004-diff-rename-symlink.sh     | 2 ++
 t/t4005-diff-rename-2.sh           | 2 ++
 t/t4006-diff-mode.sh               | 2 ++
 t/t4009-diff-rename-4.sh           | 2 ++
 t/t4010-diff-pathspec.sh           | 2 ++
 t/t4011-diff-symlink.sh            | 2 ++
 t/t4012-diff-binary.sh             | 1 +
 t/t4020-diff-external.sh           | 1 +
 t/t4024-diff-optimize-common.sh    | 1 +
 t/t4027-diff-submodule.sh          | 1 +
 t/t4029-diff-trailing-space.sh     | 1 +
 t/t4032-diff-inter-hunk-context.sh | 1 +
 t/t4033-diff-patience.sh           | 1 +
 t/t4034-diff-words.sh              | 1 +
 t/t4035-diff-quiet.sh              | 1 +
 t/t4037-diff-r-t-dirs.sh           | 1 +
 t/t4040-whitespace-status.sh       | 2 ++
 t/t4046-diff-unmerged.sh           | 2 ++
 t/t4049-diff-stat-count.sh         | 2 ++
 t/t4050-diff-histogram.sh          | 1 +
 t/t4054-diff-bogus-tree.sh         | 2 ++
 t/t4062-diff-pickaxe.sh            | 1 +
 t/t4063-diff-blobs.sh              | 2 ++
 25 files changed, 38 insertions(+)

diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index cce334981e1..bfcaae390f3 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -6,6 +6,8 @@
 test_description='Test built-in diff output engine.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
index f4485a87c63..181e9683a79 100755
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -6,6 +6,8 @@
 test_description='More rename detection
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
index 3d495e37bb1..8def4d4aee9 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -9,6 +9,8 @@ The rename detection logic should be able to detect pure rename or
 copy of symbolic links, but should not produce rename/copy followed
 by an edit for them.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index 6f1b323f979..5c756dc2435 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -5,6 +5,8 @@
 
 test_description='Same rename detection as t4003 but testing diff-raw.'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 6cdee2a2164..dbd4c0da213 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -6,6 +6,8 @@
 test_description='Test mode change diffs.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sed_script='s/\(:100644 100755\) \('"$OID_REGEX"'\) \2 /\1 X X /'
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 59b7f44f058..3480781dabf 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -6,6 +6,8 @@
 test_description='Same rename detection as t4003 but testing diff-raw -z.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 1bbced79ece..9d9650eba7e 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -9,6 +9,8 @@ Prepare:
         file0
         path1/file1
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 5a25c259fe3..d7a5f7ae780 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -6,6 +6,8 @@
 test_description='Test diff of symlinks.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 33ff588ebca..00eeafb2ace 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -6,6 +6,7 @@
 test_description='Binary diff and apply
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect.binary-numstat <<\EOF
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index e009826fcbe..54bb8ef27e7 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -2,6 +2,7 @@
 
 test_description='external diff interface test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index 6b44ce14933..540f93715e4 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -2,6 +2,7 @@
 
 test_description='common tail optimization'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 z=zzzzzzzz ;# 8
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 94ef77e1dfe..6cef0da982f 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -2,6 +2,7 @@
 
 test_description='difference in submodules'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index 32b6e9a4e76..5f8ffef74b6 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -4,6 +4,7 @@
 #
 test_description='diff honors config option, diff.suppressBlankEmpty'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat <<\EOF >expected ||
diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index bada0cbd32f..7db92d0d9f4 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -2,6 +2,7 @@
 
 test_description='diff hunk fusing'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 f() {
diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
index 113304dc596..f7be7f5ef01 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -2,6 +2,7 @@
 
 test_description='patience diff algorithm'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 561c582d161..d5abcf4b4c6 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -2,6 +2,7 @@
 
 test_description='word diff colors'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 0352bf81a90..76f8034c60f 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -2,6 +2,7 @@
 
 test_description='Return value of diffs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4037-diff-r-t-dirs.sh b/t/t4037-diff-r-t-dirs.sh
index f5ce3b29a2a..b5f96fe23bd 100755
--- a/t/t4037-diff-r-t-dirs.sh
+++ b/t/t4037-diff-r-t-dirs.sh
@@ -2,6 +2,7 @@
 
 test_description='diff -r -t shows directory additions and deletions'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4040-whitespace-status.sh b/t/t4040-whitespace-status.sh
index 3c728a3ebf9..e70e020ae93 100755
--- a/t/t4040-whitespace-status.sh
+++ b/t/t4040-whitespace-status.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='diff --exit-code with whitespace'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index ff7cfd884a4..fd3f3a7260b 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='diff with unmerged index entries'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 53061b104ec..f5b35e7860e 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -2,6 +2,8 @@
 # Copyright (c) 2011, Google Inc.
 
 test_description='diff --stat-count'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4050-diff-histogram.sh b/t/t4050-diff-histogram.sh
index fd3e86a74f3..c61b30f96da 100755
--- a/t/t4050-diff-histogram.sh
+++ b/t/t4050-diff-histogram.sh
@@ -2,6 +2,7 @@
 
 test_description='histogram diff algorithm'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
diff --git a/t/t4054-diff-bogus-tree.sh b/t/t4054-diff-bogus-tree.sh
index 8c95f152b23..294fb553137 100755
--- a/t/t4054-diff-bogus-tree.sh
+++ b/t/t4054-diff-bogus-tree.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test diff with a bogus tree containing the null sha1'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create bogus tree' '
diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index 1130c8019b4..9aaa068ed9b 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -5,6 +5,7 @@
 
 test_description='Pickaxe options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4063-diff-blobs.sh b/t/t4063-diff-blobs.sh
index bc69e26c524..7e6c9d63843 100755
--- a/t/t4063-diff-blobs.sh
+++ b/t/t4063-diff-blobs.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test direct comparison of blobs via git-diff'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 run_diff () {
-- 
2.33.1.1570.g069344fdd45

