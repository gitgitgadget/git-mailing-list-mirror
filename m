Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCF6C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489EA6044F
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhJ3W1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhJ3W1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C99C061746
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d5so7036412wrc.1
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3imPR2F4LEvucaLdGI6NieXc5bi+kngEAIcF/Rm4yl0=;
        b=YP7ZfB0kg9CIfzMW86wjQgbOzC1DXn9d+8U3PSeMLOMAtqrdtFuJ8xR9SO/BUotT5C
         lJeyjAZUE3OixgRdnUp1x8GZp5l1fpg1VeelilDxtMW2IFxRP6bnISk2ITtW+kw8NMi2
         iudypBwjrcAVacd221utsRhLuVom0xdNgEdj5Yyo4DaXntxaxwJBYTIfhoubRWvLlcrh
         GtALYNoI/4KmJ69Ya0y14hyuTzlAObyzNai9gEmygUGryleXD9ipCuNjjsP0aWgkRY0H
         ekeoXcxlwJYWQISEMtTCHF3QPp6x+jIWjl9inYr3o0IQ19slKDPO9E0Op90wesvgESM2
         TZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3imPR2F4LEvucaLdGI6NieXc5bi+kngEAIcF/Rm4yl0=;
        b=7oi3jb6QH8VLi4i6DLGlVrkSlyXKtyMp9iBzsnLVWhbh7SCG1wonOH++Tly+DSXiNi
         j4QYQS8d6Z90PEHV5vvwACKUXNyKKbjWcgScIUgB8nm8yWHnlzGC8L/tWAqtpdhTBMlv
         2agD57oKyc8B0dZZc0OYV0Pco1Ig07AYGgd+ZoNMLfZgoRgIlB26r8+Rre3h3gI+Cica
         UJJMHg13Sa4VEyh3YjuwP90KvZr/5iK2KMjiZSAby4QKROFiZno1RcBE3kYZjelHxIqc
         CU6jthVCrmYsdKCrwsnEYLVDOMSpng1Tz3PgcLyY0Lq/krPUuvMS6dDvERYbpUIz8z1U
         73Bw==
X-Gm-Message-State: AOAM5336PhPRHVFUPFjk7SVVEJfDQDapsafzSxx/SaxoQQzTV/6lkxHX
        6wJZovOR14+H1Pqaga+GrwqVfVQaH9vB3A==
X-Google-Smtp-Source: ABdhPJwZpsXKqALPGxxqLPvrIwqFAb5KxtX03P26M1HS4PosiaO8BXjK74SWR2GsvNWr/RLiSJrSxQ==
X-Received: by 2002:a05:6000:188e:: with SMTP id a14mr24388484wri.223.1635632678420;
        Sat, 30 Oct 2021 15:24:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/15] leak tests: mark some fast-import tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:24 +0200
Message-Id: <patch-15.15-8684fb2b071-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*fast-import*" as passing when git is
compiled with SANITIZE=leak. They'll now be listed as running under
the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks"
CI target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9302-fast-import-unpack-limit.sh | 2 ++
 t/t9303-fast-import-compression.sh  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/t/t9302-fast-import-unpack-limit.sh b/t/t9302-fast-import-unpack-limit.sh
index f519e4f1bfe..d8b1f9442e8 100755
--- a/t/t9302-fast-import-unpack-limit.sh
+++ b/t/t9302-fast-import-unpack-limit.sh
@@ -1,5 +1,7 @@
 #!/bin/sh
 test_description='test git fast-import unpack limit'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create loose objects on import' '
diff --git a/t/t9303-fast-import-compression.sh b/t/t9303-fast-import-compression.sh
index 57d916524ec..4f5bf40587c 100755
--- a/t/t9303-fast-import-compression.sh
+++ b/t/t9303-fast-import-compression.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='compression setting of fast-import utility'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 import_large () {
-- 
2.33.1.1570.g069344fdd45

