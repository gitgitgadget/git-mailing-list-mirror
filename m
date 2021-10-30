Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C6C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F67603E9
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhJ3W11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhJ3W1P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99797C06120B
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso5230584wmc.2
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tGAcq2+Dwrj7jpb7O6iDGsmES7nrTxNeReGBqE8Ubxg=;
        b=opaHNKobUxnkR9EAgaElWFved3/3wryizl0TZUGQcmqqLEHQIS+rRTMlLLuk3qNOwF
         zexTtQB1PNK5wDzH1ycbWTtwkmYK2l5WR9Yn/LTi6altuucstogOeB8aZ/pCzPhOLxKI
         3J2MrxsycDxfTQe2xd1J8zH+Q/DNivFSam7wXSZl7PXSIx76J7km4hwt/30hqqa9G4UB
         7Jpwl9CQcl/OW4icYML5z87/2M6RzOugxRaHUvo8Mg6/bv08ALYdL7zqJlwsgUZsQGcL
         IbTADLB2z1l9kkQClS4M9qDaiBDr1LmD8MXUCQF3V/yRK4XiT8kGtMLsLh5qmj2TGdbZ
         WECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGAcq2+Dwrj7jpb7O6iDGsmES7nrTxNeReGBqE8Ubxg=;
        b=VuJgThfsv71jfvxlJ86UwVvzbOJHrii5K1VMW58bduiHnv78khVX3lCNbDk9p7X9sb
         +F7n3Vt95u70NghCW7aZ3a03DUVn3XEC9/nObdl7eM1Qcq3v+2NuveKeWhzRoTmaxK/v
         ZGddqq772qMl6bzo9HdCLZZ4ox2Lav4yffvYpQM2fYVU/N0d/0hxE1VvbTUKp5l0KHtC
         iPWduMBoS/UTHgR8xsp2l8rsZNSRWjIJOG6bmm+LVkmygknxy1ASe13dYN3dbAS7CpJh
         DtfbfSGXqbyRlsy8QvJ/KQcHPV6Y2DIuwVnilhWk49OT604r3RTKYAsDJxz3wCLSiiH4
         TWdA==
X-Gm-Message-State: AOAM532fkvWC0RvPmM8KZwpOWivaXgkTy1nsPfdP8U17nryzRLBG1pSV
        wYaptEzTGn97do6zQLvd/FBKNhuTDck61A==
X-Google-Smtp-Source: ABdhPJwUJgCxN9beEuxXD+71nQqHAZxPgFaajCkAxnXItzwuK5lO1Cbjokenor1ugLUXWwzBZKhEww==
X-Received: by 2002:a1c:ed0c:: with SMTP id l12mr28800907wmh.68.1635632677050;
        Sat, 30 Oct 2021 15:24:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/15] leak tests: mark some status tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:22 +0200
Message-Id: <patch-13.15-bc21cc8565b-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*status*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7511-status-index.sh    | 1 +
 t/t7515-status-symlinks.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t7511-status-index.sh b/t/t7511-status-index.sh
index b5fdc048a54..4ffa45a7bf3 100755
--- a/t/t7511-status-index.sh
+++ b/t/t7511-status-index.sh
@@ -2,6 +2,7 @@
 
 test_description='git status with certain file name lengths'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 files="0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z"
diff --git a/t/t7515-status-symlinks.sh b/t/t7515-status-symlinks.sh
index 9f989be01b9..e3d6bb67bf9 100755
--- a/t/t7515-status-symlinks.sh
+++ b/t/t7515-status-symlinks.sh
@@ -2,6 +2,7 @@
 
 test_description='git status and symlinks'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.33.1.1570.g069344fdd45

