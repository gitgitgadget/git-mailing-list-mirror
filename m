Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9C6C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C428761130
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhJFJwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhJFJwe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9850C06174E
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g8so7629026edt.7
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9cf2G9o32mymuXP7KSx1iAAdKmOAJEGaux/CFeZ1Pk=;
        b=L7sbVgEO40Uk5TaEGM06OQK1VrT+dkiOs4CBUckN1NdJyeveu6AgFlWrV/he+R76Od
         4KwmoMkt35Cmp1GuWTa/dHCEymGB7M61i/Qj08YdzHfuAkWUW1HCaVWtzkPRd/Lmukqy
         67lNgrJ1ram9yPWKSF/R6RnnHVPJbBHvAR7J/A/3ex1BEp4Y3A85OLVaBr86/zz409bP
         LOYmVch6mmUkH2F1/aHCJfjxpMgsDOAnN71TcuB5fFh2O0nq49ew005Rg3z8BaCTH3sg
         Ze+0rEGnHWQ993bRe8eEQe8BOeQWZGXSy4eKvUI/Oqn/lm6hj+Nh258PEWe+n8szblo0
         WpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9cf2G9o32mymuXP7KSx1iAAdKmOAJEGaux/CFeZ1Pk=;
        b=btGt4LF4Z4GE7jgIoT9u7T9rp0phtwnQBC/QK4Z80zIXWD+tU34G3tSa3wXULxIX5U
         JV5+/s0C6WGb0QsDY+KHqp0vJpdKONNEaaYmU8pOlg1NBLtNuOs0arND0T7ms4xSefEJ
         L0htplmy0fSUnpHXVWVHsxUOXV1relEMAoOaVKW5meJBOKZ4ZUzc2Bh41yFZmX+sIGU1
         TEkSuiZS9RvBp8HWayaWiMWuQ9ScOtW8SGQhX3UXTGSKazylhFzSzMezdLJ0hQyl55Zs
         i5M7Ym4tPHopwqpwQ2/33GQMOPMoy8/Keuqk6kK3xwyDV0EyxzCxAaNe/lpDRjcv9rlN
         lhDg==
X-Gm-Message-State: AOAM533YhHg0Si/RhLyvmtG6drsEm/k07UyZ64of/uFDg1J7gO43qJkD
        rA72+JJFXxa+UwP1CUX1txXK7pgwzuKx8A==
X-Google-Smtp-Source: ABdhPJwgRuetk32IVnlaWVRdeKMPZzTRDTTC0tmN+cJ5eSz84RzpltFU/0T24QmPUWwp4o7lwzSAMw==
X-Received: by 2002:aa7:cd90:: with SMTP id x16mr34844111edv.148.1633513840801;
        Wed, 06 Oct 2021 02:50:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] leak tests: run various "test-tool" tests in t00*.sh SANITIZE=leak
Date:   Wed,  6 Oct 2021 11:50:29 +0200
Message-Id: <patch-02.10-9a8804e1d9a-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark various existing tests in t00*.sh that invoke a "test-tool" with
as passing when git is compiled with SANITIZE=leak.

They'll now be whitelisted as running under the
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
2.33.0.1441.gbbcdb4c3c66

