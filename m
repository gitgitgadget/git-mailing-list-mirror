Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3280C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99626603E9
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhJ3W1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhJ3W1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D6C0613F5
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 133so1557702wme.0
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQ/7T9nZi3wcujIBjqlxBoZvA1ZDwMcxmJhDBRDJkm8=;
        b=RUms76EtIPxHAhPYk46rZud+LHAp8fN0bkaqRxx/AyhzORfgVUvgVsaKE0zXtYaVaH
         uPPA8U+xbCfUnxqeB53qsj61A892AAv5psXTZxMS5vc6dmm+3fv+fDKIR7+Pxa150Ld0
         nR/+3+mdqG3Y/oZ6SQKllYqk7JKEkJ8u/ODzvGFmeZVOOJoSz8arp87HM7CgNGJndyVV
         jDI94rQ/qlXZPp6O+M8RfFcmO0d89XAmm39BJH2nkgFMwpKDZFkYVZ++siAIzcqo0Za4
         3FuJ4N1WU+t8PYJzGqUS16+KBL/4i9MIg7ORzZNQUWrhQkK8vabGarzvmsOI3PUmI9xW
         CfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQ/7T9nZi3wcujIBjqlxBoZvA1ZDwMcxmJhDBRDJkm8=;
        b=V7n6evbCjLunIyy1tJx9CdFT2Zz5eHqLbMRMPrGJJ2wFGbcRLTrb9w/qvpbwfSelXi
         Vm+zvUuUjWBzgSIQm++7KUJz//CHfTD0nl37pWftJ6EFhtEaW5fJTjhlP6ppY5z+imVe
         5Gf9ksJ8vXW7Iuu3fDq9gjThsKs3I7XKGdyzQzVbUdbq4TlYvqcXrKtLhDld7KKtiT0J
         LO/7T1a9taK1UY4bEpyGX4k/sQ2h8Oa7xijUXwRgi5rX4Ub0tu5l+z1ZArh0UugoOS91
         edus3K5RPStppGwgy8LnodQmB2g6sIbJohmxlAGcmTvedtU0PEWoMI9COA5Mx3FBeM0F
         +BQg==
X-Gm-Message-State: AOAM530EEjaarxnEqkW9i/hswZxXuUXtnZfMh1G1RdHXZD+uJbW7jmpx
        tKTFfC0AfTZUBZ2zMjFcjy4qUQagq9dwJQ==
X-Google-Smtp-Source: ABdhPJzJiaig4sDSz7VEiBEh5UBOmKzEeXaUfyue+Dt38+YONwBgugd/1XgGZtVzTKUvg7k2IBDL2w==
X-Received: by 2002:a1c:cc0b:: with SMTP id h11mr24190735wmb.111.1635632674068;
        Sat, 30 Oct 2021 15:24:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/15] leak tests: mark some apply tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:18 +0200
Message-Id: <patch-09.15-7de1a7291e6-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*apply*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4100-apply-stat.sh               | 2 ++
 t/t4101-apply-nonl.sh               | 2 ++
 t/t4102-apply-rename.sh             | 2 ++
 t/t4105-apply-fuzz.sh               | 2 ++
 t/t4106-apply-stdin.sh              | 2 ++
 t/t4109-apply-multifrag.sh          | 2 ++
 t/t4110-apply-scan.sh               | 2 ++
 t/t4112-apply-renames.sh            | 2 ++
 t/t4116-apply-reverse.sh            | 2 ++
 t/t4118-apply-empty-context.sh      | 2 ++
 t/t4119-apply-config.sh             | 2 ++
 t/t4123-apply-shrink.sh             | 2 ++
 t/t4126-apply-empty.sh              | 2 ++
 t/t4127-apply-same-fn.sh            | 2 ++
 t/t4128-apply-root.sh               | 2 ++
 t/t4129-apply-samemode.sh           | 2 ++
 t/t4130-apply-criss-cross-rename.sh | 2 ++
 t/t4132-apply-removal.sh            | 2 ++
 t/t4133-apply-filenames.sh          | 2 ++
 t/t4134-apply-submodule.sh          | 2 ++
 t/t4136-apply-check.sh              | 2 ++
 t/t4139-apply-escape.sh             | 2 ++
 22 files changed, 44 insertions(+)

diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index 9b433de8363..d503547732c 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -6,6 +6,8 @@
 test_description='git apply --stat --summary test, with --recount
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 UNC='s/^\(@@ -[1-9][0-9]*\),[0-9]* \(+[1-9][0-9]*\),[0-9]* @@/\1,999 \2,999 @@/'
diff --git a/t/t4101-apply-nonl.sh b/t/t4101-apply-nonl.sh
index e3443d004d0..b1169193ef5 100755
--- a/t/t4101-apply-nonl.sh
+++ b/t/t4101-apply-nonl.sh
@@ -6,6 +6,8 @@
 test_description='git apply should handle files with incomplete lines.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index fae305979a8..d1e06fc1ac4 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -6,6 +6,8 @@
 test_description='git apply handling copy/rename patch.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4105-apply-fuzz.sh b/t/t4105-apply-fuzz.sh
index 3266e394003..76e2c01b0f5 100755
--- a/t/t4105-apply-fuzz.sh
+++ b/t/t4105-apply-fuzz.sh
@@ -2,6 +2,8 @@
 
 test_description='apply with fuzz and offset'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 dotest () {
diff --git a/t/t4106-apply-stdin.sh b/t/t4106-apply-stdin.sh
index 72467a1e8ee..a57a318699e 100755
--- a/t/t4106-apply-stdin.sh
+++ b/t/t4106-apply-stdin.sh
@@ -2,6 +2,8 @@
 
 test_description='git apply --numstat - <patch'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4109-apply-multifrag.sh b/t/t4109-apply-multifrag.sh
index ac58083fe22..4dc6d8e7d3c 100755
--- a/t/t4109-apply-multifrag.sh
+++ b/t/t4109-apply-multifrag.sh
@@ -6,6 +6,8 @@
 
 test_description='git apply test patches with multiple fragments.'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cp "$TEST_DIRECTORY/t4109/patch1.patch" .
diff --git a/t/t4110-apply-scan.sh b/t/t4110-apply-scan.sh
index 09f58112e02..266302a1829 100755
--- a/t/t4110-apply-scan.sh
+++ b/t/t4110-apply-scan.sh
@@ -7,6 +7,8 @@
 test_description='git apply test for patches which require scanning forwards and backwards.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'git apply scan' '
diff --git a/t/t4112-apply-renames.sh b/t/t4112-apply-renames.sh
index f9ad183758c..d53aa4222ea 100755
--- a/t/t4112-apply-renames.sh
+++ b/t/t4112-apply-renames.sh
@@ -7,6 +7,8 @@ test_description='git apply should not get confused with rename/copy.
 
 '
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index b99e65c0863..f3b635475a4 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -7,6 +7,8 @@ test_description='git apply in reverse
 
 '
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty-context.sh
index 65f2e4c3efb..5fc6d3e4e7c 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -7,6 +7,8 @@ test_description='git apply with new style GNU diff with empty context
 
 '
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index a9a05838119..208c961d376 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -7,6 +7,8 @@ test_description='git apply --whitespace=strip and configuration file.
 
 '
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4123-apply-shrink.sh b/t/t4123-apply-shrink.sh
index 984157f03b9..ef57cd3aebb 100755
--- a/t/t4123-apply-shrink.sh
+++ b/t/t4123-apply-shrink.sh
@@ -2,6 +2,8 @@
 
 test_description='apply a patch that is larger than the preimage'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >F  <<\EOF
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index ceb6a79fe0c..a361e79a815 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -2,6 +2,8 @@
 
 test_description='apply empty'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 305b7e649eb..c27e9aec570 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -2,6 +2,8 @@
 
 test_description='apply same filename'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 modify () {
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index 6cc741a634b..cb3181e8b71 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -2,6 +2,8 @@
 
 test_description='apply same filename'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 576632f8681..a1c7686519e 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -2,6 +2,8 @@
 
 test_description='applying patch with mode bits'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-criss-cross-rename.sh
index f8a313bcb98..f3ea6327425 100755
--- a/t/t4130-apply-criss-cross-rename.sh
+++ b/t/t4130-apply-criss-cross-rename.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git apply handling criss-cross rename patch.'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_file() {
diff --git a/t/t4132-apply-removal.sh b/t/t4132-apply-removal.sh
index fec1d6fa51f..c1e3049c041 100755
--- a/t/t4132-apply-removal.sh
+++ b/t/t4132-apply-removal.sh
@@ -4,6 +4,8 @@
 
 test_description='git-apply notices removal patches generated by GNU diff'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index c5ed3b17c4a..35f1060bc8b 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -5,6 +5,8 @@
 
 test_description='git apply filename consistency check'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4134-apply-submodule.sh b/t/t4134-apply-submodule.sh
index d1c16ba33c1..aceb4c42b0f 100755
--- a/t/t4134-apply-submodule.sh
+++ b/t/t4134-apply-submodule.sh
@@ -5,6 +5,8 @@
 
 test_description='git apply submodule tests'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4136-apply-check.sh b/t/t4136-apply-check.sh
index 4c3f264a633..dfec1c5f0f6 100755
--- a/t/t4136-apply-check.sh
+++ b/t/t4136-apply-check.sh
@@ -2,6 +2,8 @@
 
 test_description='git apply should exit non-zero with unrecognized input.'
 
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4139-apply-escape.sh b/t/t4139-apply-escape.sh
index 45b5660a47d..e5c7439df13 100755
--- a/t/t4139-apply-escape.sh
+++ b/t/t4139-apply-escape.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='paths written by git-apply cannot escape the working tree'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # tests will try to write to ../foo, and we do not
-- 
2.33.1.1570.g069344fdd45

