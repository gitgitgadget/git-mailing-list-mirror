Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F29C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C10610FB
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbhJFJwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbhJFJwe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C61C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v18so7522498edc.11
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fSwB1hHAPZKoUSoTx2bRQFzzYpQjUXSyF4qHGYWC5nE=;
        b=mKiaZKew/Ja9gAGx8xtUG91/ydEvFihgC4D3OkRgug7XCGFYUsMGv+sSFzKKTbQ6Gp
         oK7DRQgL5yywSMxRXZ9C93SK48ha/bPwb+mc12cTEaV5Iy0TMDlMQTw29qZ4laxLWzcw
         vgH0T2Qpi2nbermxpi5XlibZc7ulSOEx8Z8HNLYj2+30jdp6Mm8p4zFpNFzyZLxFxC2H
         stFI2vu5mRDihMwF8GOchXUMhcDjj1nAg5tNOWsXET4BJFb1YytJrrPlcXqCA0+1v9QH
         +3HihpZWIyRqxzHCd9F+EpsFP1t/X5zBK2U23kIZAWAwoxXewAZhRvF61tyOxPuoTC5g
         yBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSwB1hHAPZKoUSoTx2bRQFzzYpQjUXSyF4qHGYWC5nE=;
        b=pyGAoMqvPVX99cjFBwOENrdvTeRySlb0Y7q8hBYulvz77nju9lHo3V5RHSU8pYWt9I
         l1L7Ns8NlQowDAUQYQHV/iQ+kZNmdgy21npl4GYAC7DNNI1ASe0mFKWs4uOeeUK5Q/Ik
         fT+IZxBVRfHnNvVR/D+ifUiK5h8WCNTy0PUTTxW5j54rBKX4fXbhRAwmSpaeBEQB6J3p
         nFwxpVQCvqcL8AFwpYxvZflOhGzJ1De2kTjIaL4x2Cn2oUU7YRIIooVr3oYMNAw1s60D
         nHSu+zjAjQzmvlBkRsj9DKovk80BiJX7uZOVDOMlnEYrlQAlAlLuWFl1R7p/otFt+IiA
         5FVg==
X-Gm-Message-State: AOAM531ap9Y7sbK78I/IMkdNRN3ZCjEPb55ETCPA8MSJ5yBjf0y81uA3
        dU1sa2lxJoubZIcActVt1WMUmMWCzxrgng==
X-Google-Smtp-Source: ABdhPJzRu4rSYqwn375uEuEoBR8tlsY6xFKnjeGAS37sCan3ppJ1RnqlRHAso7fQTAQcw2EPjzEdFA==
X-Received: by 2002:a50:9d49:: with SMTP id j9mr31895476edk.39.1633513839966;
        Wed, 06 Oct 2021 02:50:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] leak tests: run various built-in tests in t00*.sh SANITIZE=leak
Date:   Wed,  6 Oct 2021 11:50:28 +0200
Message-Id: <patch-01.10-67fbd70c55a-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark various existing tests in t00*.sh that invoke git built-ins with
TEST_PASSES_SANITIZE_LEAK=true as passing when git is compiled with
SANITIZE=leak.

They'll now be whitelisted as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0002-gitfile.sh           | 1 +
 t/t0003-attributes.sh        | 1 +
 t/t0005-signals.sh           | 2 ++
 t/t0007-git-var.sh           | 2 ++
 t/t0008-ignores.sh           | 1 +
 t/t0010-racy-git.sh          | 1 +
 t/t0022-crlf-rename.sh       | 1 +
 t/t0024-crlf-archive.sh      | 1 +
 t/t0025-crlf-renormalize.sh  | 1 +
 t/t0026-eol-config.sh        | 1 +
 t/t0029-core-unsetenvvars.sh | 1 +
 t/t0055-beyond-symlinks.sh   | 1 +
 12 files changed, 14 insertions(+)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 8440e6add12..76052cb5620 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -7,6 +7,7 @@ Verify that plumbing commands work when .git is a file
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 objpath() {
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 1e4c672b84a..b9ed612af13 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -2,6 +2,7 @@
 
 test_description=gitattributes
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 attr_check_basic () {
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 4c214bd11c4..a5ec6a0315c 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='signals work as we expect'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect <<EOF
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 88b9ae81588..53af92d571a 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='basic sanity checks for git var'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'get GIT_AUTHOR_IDENT' '
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index a594b4aa7d0..532637de882 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -2,6 +2,7 @@
 
 test_description=check-ignore
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 init_vars () {
diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
index 5657c5a87b6..837c8b7228b 100755
--- a/t/t0010-racy-git.sh
+++ b/t/t0010-racy-git.sh
@@ -2,6 +2,7 @@
 
 test_description='racy GIT'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test can give false success if your machine is sufficiently
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 7af3fbcc7b9..c1a331e9e93 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -2,6 +2,7 @@
 
 test_description='ignore CR in CRLF sequence while computing similiarity'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index 4e9fa3cd684..a34de564207 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -2,6 +2,7 @@
 
 test_description='respect crlf in git archive'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
index e13363ade5c..81447978b7f 100755
--- a/t/t0025-crlf-renormalize.sh
+++ b/t/t0025-crlf-renormalize.sh
@@ -2,6 +2,7 @@
 
 test_description='CRLF renormalization'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index c5203e232c8..cdcafcdff72 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -2,6 +2,7 @@
 
 test_description='CRLF conversion'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 has_cr() {
diff --git a/t/t0029-core-unsetenvvars.sh b/t/t0029-core-unsetenvvars.sh
index 24ce46a6ea1..b138e1d9cbc 100755
--- a/t/t0029-core-unsetenvvars.sh
+++ b/t/t0029-core-unsetenvvars.sh
@@ -2,6 +2,7 @@
 
 test_description='test the Windows-only core.unsetenvvars setting'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq MINGW
diff --git a/t/t0055-beyond-symlinks.sh b/t/t0055-beyond-symlinks.sh
index 0c6ff567a1d..6bada370225 100755
--- a/t/t0055-beyond-symlinks.sh
+++ b/t/t0055-beyond-symlinks.sh
@@ -2,6 +2,7 @@
 
 test_description='update-index and add refuse to add beyond symlinks'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success SYMLINKS setup '
-- 
2.33.0.1441.gbbcdb4c3c66

