Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D404BC433FE
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD7C610FB
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbhJFJwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbhJFJwk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5120CC061765
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v18so7523302edc.11
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tmrZeDBkaq6Ms1ciD2oMJ0uB+9heOiOGoAWIW1z0jcc=;
        b=dHT+/9yvXqz2ClfNllLHhEm1gjmiJwPHlO6vLKdJ1ynXFqjN45IymfqEIeQ95kwKgs
         fEhSMpZgC99s7657QNLGh8zOPPc5NljB8Y8IrTk8FWZF4O+rHIru4dMWvw9g3nU3lvt5
         A45erTCnRyzBlU1DQRd7f5YR2atP5Xuy7mvQ9wZ2AOr1rz08zPoyU3XNN5avdLoISniw
         TRTWH4tymVYCTRoh0WEh89/Rb4594PLI0TMovGndH+JUYqcZEPJoHRJEl0bazBDTNmpU
         TWaq/vB0sQ9rPPvar3g/qWVydKPUrEOjB708ZUtSSk2x4MzAc7r2lZAYTIElA6DnOKq1
         HZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tmrZeDBkaq6Ms1ciD2oMJ0uB+9heOiOGoAWIW1z0jcc=;
        b=BICoO7bCE6CmRJIQwjl29q/CcYlINxeVqp+jXwnSjHlubgNcjRDS5kW8dSlnOgn4UM
         +Odp1L4UhcE7B7FWPYsN40CZ0SiYjckYwcA6k7I8cpIxWbB9QElvIuic5qrP6lA5b3f3
         mEgbNH1sTM8qk6FsiHKNK6yTrVS/1wFoeQrncGVt58C0gRoJhZ6Z/o19fW7hvJIEVu3p
         YSWkeNq6cMqb93w2mo3WU4ldHCpt2BDNeNVI3f+OuWDgkbomhxqgvyQYssOoevGUXi6c
         gf8E3OnAyL7wwh5LNOGZehH8Y4cyvK+eERxYwyu+t/bnvzQ2wcdocnVc8DmAE34oUMOD
         fdtA==
X-Gm-Message-State: AOAM5325JHNZtXi9ptihX5LrwJd4+zvBNQT00fLLgQAbWrBdR7MBUMEa
        XoVsPvRR7rbZSW+lvKq5jMT10xOF5CitoA==
X-Google-Smtp-Source: ABdhPJwZ71ZcEPCMIF6gikIexosTc0rWiPpSBsWWr3jnUDsKEgNZ5jtH6jUg58KEroPajfZfF+KmIw==
X-Received: by 2002:a05:6402:2790:: with SMTP id b16mr32413024ede.3.1633513845435;
        Wed, 06 Oct 2021 02:50:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] leak tests: mark some read-tree tests as passing with SANITIZE=leak
Date:   Wed,  6 Oct 2021 11:50:35 +0200
Message-Id: <patch-08.10-d2d7f9f9f8c-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*read-tree*" as passing when git is
compiled with SANITIZE=leak. They'll now be whitelisted as running
under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the
"linux-leaks" CI target). We still have around half the tests that
match "*read-tree*" failing, but let's whitelist those that don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1000-read-tree-m-3way.sh    | 2 ++
 t/t1003-read-tree-prefix.sh    | 1 +
 t/t1009-read-tree-new-index.sh | 1 +
 t/t1012-read-tree-df.sh        | 1 +
 t/t1014-read-tree-confusing.sh | 2 ++
 5 files changed, 7 insertions(+)

diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index 013c5a7bc32..0e8c0dfbbee 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -71,6 +71,8 @@ In addition:
  DF: a special case, where A makes a directory and B makes a file.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 . "$TEST_DIRECTORY"/lib-read-tree-m-3way.sh
diff --git a/t/t1003-read-tree-prefix.sh b/t/t1003-read-tree-prefix.sh
index b6111cd150f..e0db2066f31 100755
--- a/t/t1003-read-tree-prefix.sh
+++ b/t/t1003-read-tree-prefix.sh
@@ -6,6 +6,7 @@
 test_description='git read-tree --prefix test.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1009-read-tree-new-index.sh b/t/t1009-read-tree-new-index.sh
index 2935f68f8d2..fc179ac5dd6 100755
--- a/t/t1009-read-tree-new-index.sh
+++ b/t/t1009-read-tree-new-index.sh
@@ -5,6 +5,7 @@ test_description='test read-tree into a fresh index file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1012-read-tree-df.sh b/t/t1012-read-tree-df.sh
index 57f0770df14..cde93d22cde 100755
--- a/t/t1012-read-tree-df.sh
+++ b/t/t1012-read-tree-df.sh
@@ -2,6 +2,7 @@
 
 test_description='read-tree D/F conflict corner cases'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1014-read-tree-confusing.sh b/t/t1014-read-tree-confusing.sh
index da3376b3bb2..8ea8d36818b 100755
--- a/t/t1014-read-tree-confusing.sh
+++ b/t/t1014-read-tree-confusing.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='check that read-tree rejects confusing paths'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create base tree' '
-- 
2.33.0.1441.gbbcdb4c3c66

