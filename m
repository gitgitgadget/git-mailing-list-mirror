Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB9CC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351666101D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhJLN6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbhJLN6x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:58:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16343C06161C
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k7so67100664wrd.13
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GXBqiuym9buQmREG1jS8xzWNN7L+71rhz4xiWHkWUxY=;
        b=fxKkXHVsWgI8xKeTBU4h1ju9D4Xue59XbSDoeEFvx++iOl91J66STKGJ+DWEu6R46o
         chotphzqGK6CjpDRuunFlBZsuHn5fqUYWZMU8sAhStRt9TIkb5ZFURnXVhnyfgJ6MxkT
         rfDjfrnxuyno8hhTmSPY8rmbfWLLb63HEpoeqFXnralSHq0Yy9JZMTPjUBGoo/xCxK3L
         fAluAY1OnDqsQiC/zp+rL6x6D2/xgP4qLSP3Vrq7AcGprx2CM1F6YeYVj7MdV5zqdPNI
         bgRt3TYoFJp5sHY7jY2EjaYxwSTf57VrU/zZZrCyfT5hDYeJ6yrLoGGvWFPa4r6GjTi8
         IaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXBqiuym9buQmREG1jS8xzWNN7L+71rhz4xiWHkWUxY=;
        b=4fxRioWWSjb/TV8kHddu4tAkRCCx0nHUxDjD/0GSVYQshGWWMrMvsoyyQZbZptq3bB
         Z6OHHC8wNkiIxUkr2ssypwATF2/mvO4iChBzWvejyCcmoOlJUsmmPlgdV7CwEAu1IZJ2
         +1w6p4osf/V3Y4R+nRUxxY4uGtE+CxKfvNFzPfsU6uRhVv7qix+aq18FG0qBZ1nmQoSs
         cOLqUsrr2g6nkKqbreOygch0hvk4DWPshIWo1V5HOwhtpvJTt0tCMl4c5gpVmZyMudVW
         zJ8Bm2KqA9CQZb3apol/pHA7OOO/WvvMKu5BHI6qReFeNXinNGshRBMYZ/WT4JV+8/Tp
         DHYQ==
X-Gm-Message-State: AOAM530tG+RRmR+ZG7YiuTwT078i2bPFdg59hKbLyHMWJUIt7qLZwNXv
        Fcg5s1Yc8WnLo/bJMTQKt+M7YWabZE0obA==
X-Google-Smtp-Source: ABdhPJx87Hy8G5e+sMBPkqDHVaKFL0iOO+i/0UG4CZRdRs81iI/7nqTOgj3KThBJ8EAi/pNo88UVhg==
X-Received: by 2002:a05:600c:4fd1:: with SMTP id o17mr5898816wmq.110.1634047010229;
        Tue, 12 Oct 2021 06:56:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4031950wmp.1.2021.10.12.06.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:56:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/9] leak tests: run various "test-tool" tests in t00*.sh SANITIZE=leak
Date:   Tue, 12 Oct 2021 15:56:38 +0200
Message-Id: <patch-v2-2.9-6c868ae4ae1-20211012T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark various existing tests in t00*.sh that invoke a "test-tool" with
as passing when git is compiled with SANITIZE=leak.

They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0013-sha1dc.sh              | 2 ++
 t/t0052-simple-ipc.sh          | 1 +
 t/t0061-run-command.sh         | 1 +
 t/t0065-strcmp-offset.sh       | 1 +
 t/t0066-dir-iterator.sh        | 1 +
 t/t0067-parse_pathspec_file.sh | 1 +
 6 files changed, 7 insertions(+)

diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 419f31a8f7d..9ad76080aa4 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test sha1 collision detection'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 TEST_DATA="$TEST_DIRECTORY/t0013"
 
diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
index ff98be31a51..1a36a535743 100755
--- a/t/t0052-simple-ipc.sh
+++ b/t/t0052-simple-ipc.sh
@@ -2,6 +2,7 @@
 
 test_description='simple command server'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test-tool simple-ipc SUPPORTS_SIMPLE_IPC || {
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 7d599675e35..ee281909bc3 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -5,6 +5,7 @@
 
 test_description='Test run command'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >hello-script <<-EOF
diff --git a/t/t0065-strcmp-offset.sh b/t/t0065-strcmp-offset.sh
index 91fa639c4a7..94e34c83ed9 100755
--- a/t/t0065-strcmp-offset.sh
+++ b/t/t0065-strcmp-offset.sh
@@ -2,6 +2,7 @@
 
 test_description='Test strcmp_offset functionality'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 while read s1 s2 expect
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 92910e4e6c1..63a1a45cd30 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -2,6 +2,7 @@
 
 test_description='Test the dir-iterator functionality'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t0067-parse_pathspec_file.sh b/t/t0067-parse_pathspec_file.sh
index 7bab49f361a..0188d0423a0 100755
--- a/t/t0067-parse_pathspec_file.sh
+++ b/t/t0067-parse_pathspec_file.sh
@@ -2,6 +2,7 @@
 
 test_description='Test parse_pathspec_file()'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'one item from stdin' '
-- 
2.33.0.1567.g7b23ce7ed9e

