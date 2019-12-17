Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C7CC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CE4207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUXnowP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLQMBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33168 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLQMBq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id c13so6024638pls.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KC3b1V5hIhFl9AM1MF2BrwPsPvr0CMh6y606Br4avh4=;
        b=CUXnowP7Nts4IR/5gO/Pit6tbji09FhljKBAIP3LAVMhCy63hzrkSvIwebX3b60VKd
         1kfaol8RfzMIY00CCVpgWd9n1eErev27pW/W1dQHvStQxGJEczv1MwYsOdWhbTPUqarT
         9UoKmTuOWBQruip2IJx1aVGP1NU969E+2H8ZKsHlFbwma2owva8zMEq3/jdYV/FAsRj3
         fXbl5m7aSVm3UAok+zbWo9bAE3ak0sAwt18JGP1k7/FMtirYs7J5psz2EICFw7oaEsSF
         mQnbiPyYc7ZPs/Lyxj21o42S/GTBFz1yRpkScV5DxTOwQ8oQQkpTOTFh/P331km8PIMg
         D7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KC3b1V5hIhFl9AM1MF2BrwPsPvr0CMh6y606Br4avh4=;
        b=nEAiWEyEtOI+I85YGdwQ4B+6cOAwpm6TxIij7Sl9g7xR4N4sDAlsTFx2PR8z/9GdQD
         2ZrscZ736qbZqrsFEojuugg8wp0mVaG2qhZoxSC2+cXwoWblCuaErgoQOWHknq+W+UNY
         wik+vE7vVMNI9RrUYyfF5HAyHJL2Jnw9zbbEozHw+eR8M7166DZd+UOSkUa3kr8nwBdE
         eWvBFBJVR6+GWw3V5udlNDP54LiV/LVDRZCFLyAHdFJkPOKvKtHET+AF/zL7NSQ55yg6
         nBfumPI3elo8uCImVqh1bdhuasmTzJSRvX1aEgP7XnW1bYXiIfCP0Py5Zya5ztbfgWic
         O38A==
X-Gm-Message-State: APjAAAV8L346iTy1qPeJ0mxQGWB3iJOrNY5IPzKjccOpNKWkiNtywxhv
        qH+UhSaPlfjpFX0TvwIW6Nf6CPCe
X-Google-Smtp-Source: APXvYqwtR/Jz87bkuy1hnqwg52cM3vVoLuVMmfILpYm82fe8LXD8cgFXn5MkynI16H86Xlw+OX8O8Q==
X-Received: by 2002:a17:90a:c790:: with SMTP id gn16mr5646662pjb.76.1576584105468;
        Tue, 17 Dec 2019 04:01:45 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:45 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 03/15] t0000: replace test_must_fail with ! for run_sub_test_lib_test()
Date:   Tue, 17 Dec 2019 04:01:28 -0800
Message-Id: <fcfccebd7aaf120674691ba92a657802c2482d7e.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. We use
test_must_fail to test run_sub_test_lib_test() but that function does
not invoke any git commands internally. Replace these instances of
`test_must_fail` with `!`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0000-basic.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 8a81a249d0..d60ad4b78b 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -155,7 +155,7 @@ test_expect_success 'pretend we have a fully passing test suite' "
 "
 
 test_expect_success 'pretend we have a partially passing test suite' "
-	test_must_fail run_sub_test_lib_test \
+	! run_sub_test_lib_test \
 		partial-pass '2/3 tests passing' <<-\\EOF &&
 	test_expect_success 'passing test #1' 'true'
 	test_expect_success 'failing test #2' 'false'
@@ -219,7 +219,7 @@ test_expect_success 'pretend we have fixed one of two known breakages (run in su
 "
 
 test_expect_success 'pretend we have a pass, fail, and known breakage' "
-	test_must_fail run_sub_test_lib_test \
+	! run_sub_test_lib_test \
 		mixed-results1 'mixed results #1' <<-\\EOF &&
 	test_expect_success 'passing test' 'true'
 	test_expect_success 'failing test' 'false'
@@ -238,7 +238,7 @@ test_expect_success 'pretend we have a pass, fail, and known breakage' "
 "
 
 test_expect_success 'pretend we have a mix of all possible results' "
-	test_must_fail run_sub_test_lib_test \
+	! run_sub_test_lib_test \
 		mixed-results2 'mixed results #2' <<-\\EOF &&
 	test_expect_success 'passing test' 'true'
 	test_expect_success 'passing test' 'true'
@@ -274,7 +274,7 @@ test_expect_success 'pretend we have a mix of all possible results' "
 "
 
 test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
-	test_must_fail run_sub_test_lib_test \
+	! run_sub_test_lib_test \
 		t1234-verbose "test verbose" --verbose <<-\EOF &&
 	test_expect_success "passing test" true
 	test_expect_success "test with output" "echo foo"
@@ -301,7 +301,7 @@ test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 '
 
 test_expect_success 'test --verbose-only' '
-	test_must_fail run_sub_test_lib_test \
+	! run_sub_test_lib_test \
 		t2345-verbose-only-2 "test verbose-only=2" \
 		--verbose-only=2 <<-\EOF &&
 	test_expect_success "passing test" true
@@ -834,7 +834,7 @@ then
 fi
 
 test_expect_success 'tests clean up even on failures' "
-	test_must_fail run_sub_test_lib_test \
+	! run_sub_test_lib_test \
 		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
 	test_expect_success 'tests clean up even after a failure' '
 		touch clean-after-failure &&
@@ -863,7 +863,7 @@ test_expect_success 'tests clean up even on failures' "
 "
 
 test_expect_success 'test_atexit is run' "
-	test_must_fail run_sub_test_lib_test \
+	! run_sub_test_lib_test \
 		atexit-cleanup 'Run atexit commands' -i <<-\\EOF &&
 	test_expect_success 'tests clean up even after a failure' '
 		> ../../clean-atexit &&
-- 
2.24.0.627.geba02921db

