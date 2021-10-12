Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D95C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6627961040
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbhJLN6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbhJLN6x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:58:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47F3C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m22so67373239wrb.0
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vbQXfw+oKY/Tx2WyRJ+xvxT1HHv2L4z13fimtbN/4g=;
        b=gz7B8MtDQkSdEjjVXUxy+Ux1Sqm3UJc8hXJPNIOeHleehKvolxZGC+0RHAGE1jZNuY
         /fOYisilBLLlyyZ24Lxjfq+y0NBPdOMeZaLECkQ6qjPu0v2LfeyBPLkxXtY6NHfFM6xj
         nK7VXRzN1SAn+xVqbo+fhU0OzQT3RlwydIILxnfC6VdYmHz7sm75uDrVtlSiFt3qFBWk
         RxGCSuCIw7bUk5+frOQpjJ2l3ZoL6X6im+FGICp/bkrtvRvT1FLuTKySjhSHDXJiesRg
         suSaUvBLILxyz5hQ2OLc3fkhlMTEB9V2Q42mRNB9a6wtqHFsyldbooWWpxf0rDporIHD
         Zktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vbQXfw+oKY/Tx2WyRJ+xvxT1HHv2L4z13fimtbN/4g=;
        b=dS2kaWaFcTJ2pYtjJX+O4LhlvvDDoe02YQ+HZsF5S8A2VtmfIv+Jbtv224FLHgZR4c
         5a9YE1iCvKVz4GcQuXpkCtKjsOvYpDxaDnroKKp1atMGghcuMOGppt16TFi8QqRS07r7
         QsR9+rBlaEss4OebVBLuZZe4eJhy/cFEfptRoxZiIPB+ZXUAxpU2crakmJwNMC+/+I2W
         SRwBwjMdQHRW+V2J92kb3zpydR6hFhDTkYjEN3QlWmtSVocOQiR4by3Ix21PbzJPk+MV
         OrHsOWAZ1SzRy6HqXIu8KCd2Dito6m2XprajU9R14nVN01FusNM+MNhXyOEIKJayAMEG
         T7Fg==
X-Gm-Message-State: AOAM530oASyIzJ0gisEq3afFImpc84xpTdO+bfj+MpiKu7OR5U8UTE0P
        EWmqB/nTfjqO5Hep8MgpvOt0KHZLnxy4Sw==
X-Google-Smtp-Source: ABdhPJzHfOvsotpAUJ/1W9DxEN+vvOp+HPld7DrRFnMaexXY56juIybXlc8OE5XhGz8+BajEPOMK/w==
X-Received: by 2002:a1c:2c2:: with SMTP id 185mr5821716wmc.85.1634047009469;
        Tue, 12 Oct 2021 06:56:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4031950wmp.1.2021.10.12.06.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:56:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] leak tests: run various built-in tests in t00*.sh SANITIZE=leak
Date:   Tue, 12 Oct 2021 15:56:37 +0200
Message-Id: <patch-v2-1.9-4a426acf701-20211012T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark various existing tests in t00*.sh that invoke git built-ins with
TEST_PASSES_SANITIZE_LEAK=true as passing when git is compiled with
SANITIZE=leak.

They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0001-init.sh              | 1 +
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
 13 files changed, 15 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index df544bb321f..7603ad2f82b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -2,6 +2,7 @@
 
 test_description='git init'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
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
2.33.0.1567.g7b23ce7ed9e

