Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CC3C4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C2B6137B
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhHWMOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbhHWMOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:14:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844FDC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so766669wms.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMBzCRb2lJcY83Rf3gXJ3lcRFccz+H2Bl2MJKU3ZqPo=;
        b=eVIq4nhK0QSaFcuTEMl7hHBF1UTXOON77oSPoypzfxTKWdujk9Ud5zUUA/mGjFhvcT
         W1MGb9Kcpr+D9y48sMKaNjmvG87tJGTNMzF4TH5iw6cigW7V7rfO1EXCvpbY7LtajRG8
         rRhoNtrJ4KvFj2nsw6L74REmQdBDliiu5+yjOXA/Rc6gA3z/xIn0RLOdmrwCXmXEFQgO
         SB2Qs1j+NUqtBLDoyoNC6rvQRI3baISktj3E+CH4AXpmR31N726/BhWbih2ukjGgv6dJ
         qnztWz6km9N3kqV8LED2t23OsQK4dgAEO7WPPBvVW9R3p/uUno3u+8oUTF9CEE2y/dgn
         N3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMBzCRb2lJcY83Rf3gXJ3lcRFccz+H2Bl2MJKU3ZqPo=;
        b=ON8f/CZINtiqp/gwybsuOjaSZOIc7XTnTqUZCI7bbqo99SeB+AY1Yxf0YXiPQx/Q+O
         v5uDYzJbifK8ZnToGXZJMiVyEXooCEYVd7CFKEPY3xbjX6SpAUt3m8k8is2pOdUW22s1
         MCRyGr9ZcveMbc2UFCeEM7JkIBPWhvt0dOKZcb8zC7Mq8WKz/UMBrhp19QG7JBBWSn2y
         BtgujwkNEINgpq3GKC1D0kr0Z3GD/JJuRQAYOFhAoPP0t+vl/+vOEcF6cdS2cMn/YlwG
         q4VIYL3B5PL9y7G+xQWM9xA/M0N67t8Wviy4ztai1e8s9aidsGTHKNCnwvoLOt4V+0Ju
         SmUw==
X-Gm-Message-State: AOAM530/l2fINsIfHSEJ6VTgcdrqkX0JJ+iAnqakW1cbZapYPEZ1y3GC
        6RVjOG6QXkWm+55H9dZ83dpbzzbl2LasK3Fs
X-Google-Smtp-Source: ABdhPJzUIQP+hr1Q+V585hRpA2xUTu/2lCGf5F2NLv9wvXZO9hsDBUaW4XNyXBUszdVwbFJ1G2+QbA==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr16267873wmz.98.1629720796830;
        Mon, 23 Aug 2021 05:13:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 25/28] t1404: annotate test cases with REFFILES
Date:   Mon, 23 Aug 2021 14:12:36 +0200
Message-Id: <patch-v4-25.28-0b3db9fc2d6-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

* Reftable for now lacks detailed error messages for directory/file conflicts.
  Skip message comparisons.

* Mark tests that muck with .git directly as REFFILES.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1404-update-ref-errors.sh | 56 +++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index b729c1f4803..811d5bb56d4 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -27,7 +27,9 @@ test_update_rejected () {
 	fi &&
 	printf "create $prefix/%s $C\n" $create >input &&
 	test_must_fail git update-ref --stdin <input 2>output.err &&
-	test_i18ngrep -F "$error" output.err &&
+	if test_have_prereq REFFILES ; then
+		test_i18ngrep -F "$error" output.err
+	fi &&
 	git for-each-ref $prefix >actual &&
 	test_cmp unchanged actual
 }
@@ -101,7 +103,9 @@ df_test() {
 		printf "%s\n" "delete $delname" "create $addname $D"
 	fi >commands &&
 	test_must_fail git update-ref --stdin <commands 2>output.err &&
-	test_cmp expected-err output.err &&
+	if test_have_prereq REFFILES ; then
+		test_cmp expected-err output.err
+	fi &&
 	printf "%s\n" "$C $delref" >expected-refs &&
 	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
 	test_cmp expected-refs actual-refs
@@ -336,7 +340,9 @@ test_expect_success 'missing old value blocks update' '
 	EOF
 	printf "%s\n" "update $prefix/foo $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks update' '
@@ -347,7 +353,9 @@ test_expect_success 'incorrect old value blocks update' '
 	EOF
 	printf "%s\n" "update $prefix/foo $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'existing old value blocks create' '
@@ -358,7 +366,9 @@ test_expect_success 'existing old value blocks create' '
 	EOF
 	printf "%s\n" "create $prefix/foo $E" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks delete' '
@@ -369,7 +379,9 @@ test_expect_success 'incorrect old value blocks delete' '
 	EOF
 	printf "%s\n" "delete $prefix/foo $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'missing old value blocks indirect update' '
@@ -380,7 +392,9 @@ test_expect_success 'missing old value blocks indirect update' '
 	EOF
 	printf "%s\n" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks indirect update' '
@@ -392,7 +406,9 @@ test_expect_success 'incorrect old value blocks indirect update' '
 	EOF
 	printf "%s\n" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'existing old value blocks indirect create' '
@@ -404,7 +420,9 @@ test_expect_success 'existing old value blocks indirect create' '
 	EOF
 	printf "%s\n" "create $prefix/symref $E" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks indirect delete' '
@@ -416,7 +434,9 @@ test_expect_success 'incorrect old value blocks indirect delete' '
 	EOF
 	printf "%s\n" "delete $prefix/symref $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'missing old value blocks indirect no-deref update' '
@@ -427,7 +447,9 @@ test_expect_success 'missing old value blocks indirect no-deref update' '
 	EOF
 	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks indirect no-deref update' '
@@ -439,7 +461,9 @@ test_expect_success 'incorrect old value blocks indirect no-deref update' '
 	EOF
 	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'existing old value blocks indirect no-deref create' '
@@ -451,7 +475,9 @@ test_expect_success 'existing old value blocks indirect no-deref create' '
 	EOF
 	printf "%s\n" "option no-deref" "create $prefix/symref $E" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success 'incorrect old value blocks indirect no-deref delete' '
@@ -463,7 +489,9 @@ test_expect_success 'incorrect old value blocks indirect no-deref delete' '
 	EOF
 	printf "%s\n" "option no-deref" "delete $prefix/symref $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-	test_cmp expected output.err
+	if test_have_prereq REFFILES ; then
+		test_cmp expected output.err
+	fi
 '
 
 test_expect_success REFFILES 'non-empty directory blocks create' '
-- 
2.33.0.662.gbaddc25a55e

