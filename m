Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BA3C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5209860238
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbhJLN7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbhJLN65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:58:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7AFC06161C
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y3so34188968wrl.1
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4t3mxyFv3n4UuJI5K6T0XnkGvww/nHBHQWevXpHxeU=;
        b=HoFpGKm30VEM4Q5NnAybDGvqt4V7msYjR5LJ+VnTt5/UO/8tKaNbXOth7UtTns1pD0
         /p+H2OMF3ZBpoUdj/TA6HDNsLdzUf3O4CyurfJSE6T4Nix6p6mH/sMBaPg+zyQVZzR7+
         zFK442+Hy1SeXa57eKnuxCeqvQRcqp1L40WE6//Ax/kGYnwQdZj/RlWNlsBTjK0y7uDX
         E4DkB0aWI3nyYBqXqBPh25Th4gLp+mPjfpyIQjLaSmVShybpTuwIJUP6iGuJtUkdc26M
         rWJQ10WQzGvwKrr8qKUsoI/ANOPyZJOsW+bboDvPm/pb6zgPd9+q82hFusevxHqn+rjW
         0GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4t3mxyFv3n4UuJI5K6T0XnkGvww/nHBHQWevXpHxeU=;
        b=DQjFTyI5Afik/TBENVDZrAEKMnS9wsELQ1cm/VN8FqMGMukQxG6t+cMxTmKw5wBGIU
         znnXx5K6MyR/VdwSrA+A1NXrFhISNU6YUovUOS/SAx7jxHRiUpKUUNjJHVOjgGTth0Ja
         B1FqXx8mPcKJbbppIOjcCZFycG9EW1edtfS1QQS1yPJTNGsIxNrOO9C1Dn+Dkhwka4o/
         2oZp8dLzqQy8kwHJbxU5sbn8kgNoN6axWCIfwiJZwihIpOiaOqSEkQ2rHk98Yqyg/LFi
         N1TOesPog7siq7xCvblQdIHSh8QGpxzoAr1XkX/904cAtEZL3hBguG+/ijImwwpPXlRY
         Nnrg==
X-Gm-Message-State: AOAM531w/Ety/civUeycOCvqv8dz95Xr1ppXddakabDK+LLKdHswlVYk
        zmVJN2oZ15fJqWCKZeaXl0E86HZIyD/QgQ==
X-Google-Smtp-Source: ABdhPJySzJjU3JYbb7keTnciUO3asHMvmB8c16kpd5+nuu2wiFv4x1pObJw4mOW1ph5Fw+JIATBPbQ==
X-Received: by 2002:a05:6000:11:: with SMTP id h17mr10649496wrx.278.1634047013300;
        Tue, 12 Oct 2021 06:56:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4031950wmp.1.2021.10.12.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:56:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/9] leak tests: mark some ls-files tests as passing with SANITIZE=leak
Date:   Tue, 12 Oct 2021 15:56:42 +0200
Message-Id: <patch-v2-6.9-45d3f07cd15-20211012T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*ls-files*" as passing when git is
compiled with SANITIZE=leak. They'll now be listed as running under
the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks"
CI target). We still have others that match '*ls-files*" that fail
under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3000-ls-files-others.sh              | 2 ++
 t/t3002-ls-files-dashpath.sh            | 2 ++
 t/t3003-ls-files-exclude.sh             | 2 ++
 t/t3004-ls-files-basic.sh               | 1 +
 t/t3006-ls-files-long.sh                | 2 ++
 t/t3008-ls-files-lazy-init-name-hash.sh | 1 +
 6 files changed, 10 insertions(+)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 740ce56eab5..11af4552f74 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -15,6 +15,8 @@ filesystem.
     path3/file3 - a file in a directory
     path4       - an empty directory
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t3002-ls-files-dashpath.sh b/t/t3002-ls-files-dashpath.sh
index 8704b04e1b4..54d22a45dfb 100755
--- a/t/t3002-ls-files-dashpath.sh
+++ b/t/t3002-ls-files-dashpath.sh
@@ -12,6 +12,8 @@ filesystem.
     -foo	- a file with a funny name.
     --		- another file with a funny name.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
index c41c4f046ab..7933dff9b38 100755
--- a/t/t3003-ls-files-exclude.sh
+++ b/t/t3003-ls-files-exclude.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='ls-files --exclude does not affect index files'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create repo with file' '
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 9fd5a1f188a..a16e25c79bd 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -6,6 +6,7 @@ This test runs git ls-files with various unusual or malformed
 command-line arguments.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'ls-files in empty repository' '
diff --git a/t/t3006-ls-files-long.sh b/t/t3006-ls-files-long.sh
index e109c3fbfb5..2aaf91ebc8c 100755
--- a/t/t3006-ls-files-long.sh
+++ b/t/t3006-ls-files-long.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='overly long paths'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 85f37049587..51d3dffaa66 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -2,6 +2,7 @@
 
 test_description='Test the lazy init name hash with various folder structures'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test 1 -eq $(test-tool online-cpus)
-- 
2.33.0.1567.g7b23ce7ed9e

