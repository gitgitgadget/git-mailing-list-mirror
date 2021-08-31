Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A48CC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0190A60FE6
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhHaNg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbhHaNgw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3B8C0617AE
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so2595761wml.3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vJUiFiQnOYXNrJhMFNz7x9dwblmPjepxzZP0urzB/2M=;
        b=RbSlS158m0CO4vdhzfuauZc4DUOoCUnQnAwZZ0LxX77eA9Fnu28iFOQYD/CwmWkh+e
         a3wd9fjT+/Ei8weGaOKz8o8uP45ZTXbdMdfMJXS5kWox7kCjiniHmF4v19RBJCKd0aCn
         Eytn1ycRTso9uheYm/4nmK6nCfq1MNS0WK5aLn1Vj4wrjGrhgX++S60ujwLhib0bIJ+m
         vJfbV3jECgYuonAV9YfgTEw8FrjMRbev637YjVPws+BCe5+10BJS3nH3bOB8S/xs950o
         XbEF3L/vR3dJMmBTmT/BfwIDDzmpCYc6PtzmFilNgnZSi39q7J0H/4WuSDdFGqzx2TTB
         r3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJUiFiQnOYXNrJhMFNz7x9dwblmPjepxzZP0urzB/2M=;
        b=ljKbttPKG8zMzZsQtMId3VQk/3GKURLllvlw00LHVwoYVafJnqA1c/K7NOlNO2iq4e
         APjqry37g/gaNyjQLtt2A4xx739EvjRXR300RtMl5/JfKhJavnwf2Nfvk/8EDQILh9cq
         hnRQRZmYDBjePPyxU2TnnLtqNhh65xPPNpasEFfPGCG+X+29wcSintmOdgXPvaFOPUgs
         zTgfEuARfDOjChssgkuStt32/IS3ITadoNvzPwoD3tckBWy5RAUrY1Lb1gZt65R9w7Z9
         jVjT3aE0SBz/qXDNGl0YhYLRDr/bTknnqxxuZmiVFx302jgH/hJFR/l1bzVA209i4lel
         qzSg==
X-Gm-Message-State: AOAM533TG/W+Lc2stq2ZPjFTKT1IztveX0hwcHd3VQbYqvPaD/r0ETy6
        DN3MM1iEV3+A9sVWedo9jgpHZeotBmJxqw==
X-Google-Smtp-Source: ABdhPJyld57hfp9IS2Obzjn+lZiaiNmsocy2R67aAv58vbWqFyTMvNjzXMhT5unuCFMW1SJf80IyIQ==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr4176033wmc.102.1630416953880;
        Tue, 31 Aug 2021 06:35:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u27sm19073451wru.2.2021.08.31.06.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:35:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/8] tests: annotate select t0*.sh with TEST_PASSES_SANITIZE_LEAK=true
Date:   Tue, 31 Aug 2021 15:35:41 +0200
Message-Id: <patch-v3-7.8-ddc4d6d2cf1-20210831T132607Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Annotate a few t0*.sh tests that pass with SANITIZE=leak, these tests
now pass under GIT_TEST_PASSING_SANITIZE_LEAK=true. These aren't all
of the ones in t0*.sh that pass, I'm selecting a few ones that test
some core APIs, and the simple "git bugreport" built-in.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0030-stripspace.sh          | 1 +
 t/t0052-simple-ipc.sh          | 1 +
 t/t0061-run-command.sh         | 1 +
 t/t0063-string-list.sh         | 1 +
 t/t0066-dir-iterator.sh        | 1 +
 t/t0067-parse_pathspec_file.sh | 1 +
 t/t0091-bugreport.sh           | 1 +
 7 files changed, 7 insertions(+)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 0c24a0f9a37..d00f7dd01e8 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -5,6 +5,7 @@
 
 test_description='git stripspace'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 t40='A quick brown fox jumps over the lazy do'
diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
index ff98be31a51..f76a1f5e249 100755
--- a/t/t0052-simple-ipc.sh
+++ b/t/t0052-simple-ipc.sh
@@ -2,6 +2,7 @@
 
 test_description='simple command server'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test-tool simple-ipc SUPPORTS_SIMPLE_IPC || {
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 7d599675e35..89fd3b18e52 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -5,6 +5,7 @@
 
 test_description='Test run command'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 cat >hello-script <<-EOF
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index c6ee9f66b11..0bd69de4f75 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -5,6 +5,7 @@
 
 test_description='Test string list functionality'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_split () {
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 92910e4e6c1..edafdbbe7dc 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -2,6 +2,7 @@
 
 test_description='Test the dir-iterator functionality'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t0067-parse_pathspec_file.sh b/t/t0067-parse_pathspec_file.sh
index 7bab49f361a..cc2540db9f9 100755
--- a/t/t0067-parse_pathspec_file.sh
+++ b/t/t0067-parse_pathspec_file.sh
@@ -2,6 +2,7 @@
 
 test_description='Test parse_pathspec_file()'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'one item from stdin' '
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 526304ff95b..946909dbfde 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -2,6 +2,7 @@
 
 test_description='git bugreport'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 # Headers "[System Info]" will be followed by a non-empty line if we put some
-- 
2.33.0.805.g739b16c2189

