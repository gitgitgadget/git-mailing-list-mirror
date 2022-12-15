Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FA9C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLOJLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiLOJLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:11:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8667E2AE26
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i7so2335761wrv.8
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc/AVdeBNo/O4MFtSmnlLl/fOt0AG45CEfP9RBQJuJ4=;
        b=lOR70rqyFe9anwDRhg/xsb2Jc9JjFUbjwEMOkhRN8C6LczbKY57j0f+GLBJ2nAzckl
         mWBetnNrTXLXReQ3EwZeU4Is3wVlH/1S0HupLsBnHeiDboujCVlPvoYhGQlSude0v1Qi
         W2NSnbn9VaVg8NJsl5VaVAdTywLHxONGUTqJF1VgWcAuf0EyL+4Zezsm44YFiGXaAHyi
         Fo3YaOlx1LCOfb+/EhqxJb0dG1yd8vxhS0LgFbpdTl5RwRmAThnwsiVcRjQaevjk/++e
         aHid0n7V/788BltXxpD+uGYxsVMBlqxG/giNpQii6eLHGFzOCWJ1tQf4WeEvb6/DGCLC
         R8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tc/AVdeBNo/O4MFtSmnlLl/fOt0AG45CEfP9RBQJuJ4=;
        b=QfSNtOk3VQSTJOtYvcaV0VoLvXmzFkwW02CwngukDPyg7eBHrNzdmuCtcZVDZc4Ups
         YR7Dwj7vOtqqZNq2nkSQhgEVjAXCGhYdAZkzYbY7Eqt+MYvBRT3bh+x0XAkk6WWUtHHI
         aQQrI5buOMDYAl1jaUbdlgYJ/epNmTYABFfkzoohs69O8q0rH4osNiUHUh5gORTVWRIU
         YrqK/ks2X58YnkbDJyDtdXvfkrUxAd8x5S5c59FwcrI4/o6BKwLLH6FUEQS4lSxzpbby
         1OOQCUsfAcyT4PXiTbNdQwW1WHEftwwTXUJvFlW8UbxK/mrDerEWeJxInRRdhZUz6nji
         kzog==
X-Gm-Message-State: ANoB5plMZwIrFU3WRDrvJL2eI9iJZoDcOIOsno2UEYNTFMePMR7ONs3Y
        4iCVf1vpM91yJ8nIFNg/fjXqcPguzikTow==
X-Google-Smtp-Source: AA0mqf7oJjm23vgmY9agPhCf0WDTGpO3gb/r6I0U1CeBl+ECLH+K4ncxE1LvuGJHN1dNqeESj070mQ==
X-Received: by 2002:adf:f212:0:b0:242:192c:9b34 with SMTP id p18-20020adff212000000b00242192c9b34mr17161209wro.59.1671095481736;
        Thu, 15 Dec 2022 01:11:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000024700b002366f9bd717sm6193835wrz.45.2022.12.15.01.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:11:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 4/5] strvec API users: fix leaks by using "STRVEC_INIT_NODUP"
Date:   Thu, 15 Dec 2022 10:11:10 +0100
Message-Id: <RFC-patch-4.5-6051c309d0d-20221215T090226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com> <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For these cases where all of the strings we're pushing to the "struct
strvec" are fixed strings we can fix widespread memory leaks by
skipping the xstrdup() on strvec_push().

More in-tree users could benefit from this to save needless
xstrdup()-ing, but for all of these we were munging the "v" member, so
the subsequent strvec_clear() wouldn't free the memory.

Now there's no need to free the individual elements, but we'll still
need to free the container with the strvec_clear().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c                  | 2 +-
 builtin/annotate.c            | 2 +-
 builtin/stash.c               | 2 +-
 t/t0023-crlf-am.sh            | 1 +
 t/t4152-am-subjects.sh        | 2 ++
 t/t4254-am-corrupt.sh         | 2 ++
 t/t4256-am-format-flowed.sh   | 1 +
 t/t4257-am-interactive.sh     | 2 ++
 t/t5403-post-checkout-hook.sh | 1 +
 9 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 30c9b3a9cd7..691ec1d152d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1471,7 +1471,7 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
 static int run_apply(const struct am_state *state, const char *index_file)
 {
 	struct strvec apply_paths = STRVEC_INIT;
-	struct strvec apply_opts = STRVEC_INIT;
+	struct strvec apply_opts = STRVEC_INIT_NODUP;
 	struct apply_state apply_state;
 	int res, opts_left;
 	int force_apply = 0;
diff --git a/builtin/annotate.c b/builtin/annotate.c
index de58deadfc7..99d97c1a8c0 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -9,7 +9,7 @@
 
 int cmd_annotate(int argc UNUSED, const char **argv, const char *prefix)
 {
-	struct strvec args = STRVEC_INIT;
+	struct strvec args = STRVEC_INIT_NODUP;
 	int ret;
 
 	strvec_pushl(&args, argv[0], "-c", NULL);
diff --git a/builtin/stash.c b/builtin/stash.c
index e504e22e0b9..b15dd2ebb3c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1823,7 +1823,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
 	const char *index_file;
-	struct strvec args = STRVEC_INIT;
+	struct strvec args = STRVEC_INIT_NODUP;
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
 		OPT_SUBCOMMAND("apply", &fn, apply_stash),
diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
index f9bbb91f64e..575805513a3 100755
--- a/t/t0023-crlf-am.sh
+++ b/t/t0023-crlf-am.sh
@@ -2,6 +2,7 @@
 
 test_description='Test am with auto.crlf'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >patchfile <<\EOF
diff --git a/t/t4152-am-subjects.sh b/t/t4152-am-subjects.sh
index 4c68245acad..9f2edba1f83 100755
--- a/t/t4152-am-subjects.sh
+++ b/t/t4152-am-subjects.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test subject preservation with format-patch | am'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 make_patches() {
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 54be7da1611..45f1d4f95e5 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git am with corrupt input'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 make_mbox_with_nul () {
diff --git a/t/t4256-am-format-flowed.sh b/t/t4256-am-format-flowed.sh
index 2369c4e17ad..1015273bc82 100755
--- a/t/t4256-am-format-flowed.sh
+++ b/t/t4256-am-format-flowed.sh
@@ -2,6 +2,7 @@
 
 test_description='test format=flowed support of git am'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4257-am-interactive.sh b/t/t4257-am-interactive.sh
index aed8f4de3d6..f26d7fd2dbd 100755
--- a/t/t4257-am-interactive.sh
+++ b/t/t4257-am-interactive.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='am --interactive tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up patches to apply' '
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 978f240cdac..cfaae547398 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -7,6 +7,7 @@ test_description='Test the post-checkout hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.39.0.rc2.1048.g0e5493b8d5b

