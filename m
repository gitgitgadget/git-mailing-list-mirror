Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA274C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F65610FC
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbhJFJwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhJFJwl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D24C061768
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p13so7845756edw.0
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bukQqy+ILKSTk9hWDrvHeiYchkFcsRgJQjP9E+O5dx0=;
        b=UiCWcjez3odxddeYRO5WHzouSKLmHWbABTiv+CdjASu4bx1VnZQq0C9oOVAZ4gqAhg
         gHmDkaFlRn2Nte5mqf9itz3weoqdh+epGC084H4a3IHuqHfelrNXVHSelHLvH8J5M5e3
         A/VV/MFWK1XC7voPO3t2dFBsx3cntjp3DPobkFTY39KkgRAjLbw1kHTtvk70wxsoIfQz
         bX0EYmt3Q8gL7ocT7UoDiG8GnVkzqUuRlh+/s+PRizDai7ELwmzEbMEgh+But6WZ2HPb
         5RWhMzq/amHMrixg7XTwG7T1g1yhC+4SyWZf8C1I8Mre5k0G5r94qqAolUh7rzzCmFG+
         QZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bukQqy+ILKSTk9hWDrvHeiYchkFcsRgJQjP9E+O5dx0=;
        b=PYFzRS69hqLVRefPONIR6WttdSFhGeszYaCsw18d3ysu0KmaBIYR2mF+MEFbUxp9Iq
         6k39u3+1CfHpRJNPFCKVIdVv/1HTwb98w9BhkhJLdgfVBBYOlpnRhPl3wLY3dQeV+kjU
         0nNfD4xQkutW1MwijHCrOVCgLuNcp72HWn20cwt7iyJ2WjYj2hMQNyD7Hf/yzSQYITDQ
         g2GkMQvPEE8mXbPccNvzVhdl3Z9X100R8ve9M0xkjESJmWQECJT+JKoLkLeWPQlh/ntc
         VP+CgYDwhYCZnQ/b+TJpp+ocYBhEOtJv11984q108rz0s2Yy5wpLilOWewNigK2jP4t7
         22Sw==
X-Gm-Message-State: AOAM531cLPghAflVmPvGEd3/QY4Hu4guytamvngiqc5+sBHAG2/DECze
        0yQXEvlosJMnnnvJW51ge8XZDdFvZGm03g==
X-Google-Smtp-Source: ABdhPJw/eLQe2St3/Bwx0CVGjDmpmIuDT6ZHymtxjT/5ZEpKIJW3DhvpU2O+Gc79p3VkHtvMLnd0jQ==
X-Received: by 2002:a17:906:d215:: with SMTP id w21mr30901450ejz.448.1633513847142;
        Wed, 06 Oct 2021 02:50:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/10] leak tests: mark some misc tests as passing with SANITIZE=leak
Date:   Wed,  6 Oct 2021 11:50:37 +0200
Message-Id: <patch-10.10-1b68890f614-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*{mktree,commit,diff,grep,rm,merge,hunk}*"
as passing when git is compiled with SANITIZE=leak. They'll now be
whitelisted as running under the "GIT_TEST_PASSING_SANITIZE_LEAK=true"
test mode (the "linux-leaks" CI target).

These were picked because we still have a lot of failures in adjacent
areas, and we didn't have much if any coverage of e.g. grep and diff
before this change, we could still whitelist a lot more tests, but
let's stop for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1010-mktree.sh               | 1 +
 t/t1100-commit-tree-options.sh  | 1 +
 t/t3601-rm-pathspec-file.sh     | 1 +
 t/t4002-diff-basic.sh           | 2 ++
 t/t4016-diff-quote.sh           | 1 +
 t/t4019-diff-wserror.sh         | 1 +
 t/t4025-hunk-header.sh          | 1 +
 t/t4300-merge-tree.sh           | 2 ++
 t/t7812-grep-icase-non-ascii.sh | 1 +
 t/t7813-grep-icase-iso.sh       | 1 +
 t/t7816-grep-binary-pattern.sh  | 1 +
 11 files changed, 13 insertions(+)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index b946f876864..48bfad07abc 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -2,6 +2,7 @@
 
 test_description='git mktree'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index ae66ba5babf..0f37a43fd3c 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -12,6 +12,7 @@ Also make sure that command line parser understands the normal
 "flags first and then non flag arguments" command line.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expected <<EOF
diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
index 7de21f8bcff..b2a8db69afc 100755
--- a/t/t3601-rm-pathspec-file.sh
+++ b/t/t3601-rm-pathspec-file.sh
@@ -2,6 +2,7 @@
 
 test_description='rm --pathspec-from-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 6a9f010197c..ea52e5b91b7 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -6,6 +6,8 @@
 test_description='Test diff raw-output.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-read-tree-m-3way.sh
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 876271d6826..5a8d8876831 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -6,6 +6,7 @@
 test_description='Quoting paths in diff output.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 P0='pathname'
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index c6135c75488..c68729ac098 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -2,6 +2,7 @@
 
 test_description='diff whitespace error detection'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4025-hunk-header.sh b/t/t4025-hunk-header.sh
index 35578f2bb91..6356961de46 100755
--- a/t/t4025-hunk-header.sh
+++ b/t/t4025-hunk-header.sh
@@ -2,6 +2,7 @@
 
 test_description='diff hunk header truncation'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 N='日本語'
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index e59601e5fe9..c52c8a21fae 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='git merge-tree'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index e5d1e4ea686..79419ead025 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -2,6 +2,7 @@
 
 test_description='grep icase on non-English locales'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success GETTEXT_LOCALE 'setup' '
diff --git a/t/t7813-grep-icase-iso.sh b/t/t7813-grep-icase-iso.sh
index 701e08a8e59..1227885737b 100755
--- a/t/t7813-grep-icase-iso.sh
+++ b/t/t7813-grep-icase-iso.sh
@@ -2,6 +2,7 @@
 
 test_description='grep icase on non-English locales'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success GETTEXT_ISO_LOCALE 'setup' '
diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern.sh
index 9d67a5fc4cf..fdb2355649e 100755
--- a/t/t7816-grep-binary-pattern.sh
+++ b/t/t7816-grep-binary-pattern.sh
@@ -2,6 +2,7 @@
 
 test_description='git grep with a binary pattern files'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 nul_match_internal () {
-- 
2.33.0.1441.gbbcdb4c3c66

