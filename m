Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C1FC432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D3C60F22
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhHPUSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhHPUSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:18:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BE2C0617AF
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so743639wma.0
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yyG7ptp3kPeTvu91jaJSIgDSemxiR1k8pmNU3KvV//Y=;
        b=ML2BqJIKkM+e5LzL4zT5Tqvsi6j2++j2GwXLMMmP343MRDf5qU3l06dnqYDj9ay2fU
         7SZmJe/SVGuZUNORfwIKAmIMpAEMP7fpklX2RUN7DHvlLvtz7lX+ek6pbR+1bzVuF8XS
         zRH225qrKSnNlbVhoQrhyOKRSS/mcbQVDJX8LFCBWMRv6mIEaku+Y1P26wn2veibYPek
         u2CEqz1Qu5Hy6o2Oq6s91tLiPlwFoNzeCX+XpnZz+amZu+kPWg5Pt+X3XKubFCDbPrbC
         NzXDZzzz6An54v10zfpCyVdL4SCstvEHhjXOy3pl+akSy0io8o3CmtP32/Uv6Z9nlCMj
         S3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yyG7ptp3kPeTvu91jaJSIgDSemxiR1k8pmNU3KvV//Y=;
        b=grBhJ8UihQfuMH9iRv8g29QzPWv+EayV4/R2SAsu8vOAP03F5Ts7wu1KgUBWogpOiU
         JSewibc/hOC8T80DWpNWHNXm/F7jHPxWaIrpELeWbQ/2FcROPyA3zOe+uJ/3/xg/13VS
         SjIn1bOV3jkrcjyMmzXyEXDiImBbznGwBkZvA367KeyU3vgKL6iwC2onYU4sBqX/G16h
         RmakN+jof6nQIwKhg6l1AjW99yRI+JsJREXhnjP43VUfusfawrZFGk6eT0UmJUufrC8q
         vf4QLD4LkCEWkhjcw/eKvj/U/JPilQOCmB9A+CqCwWXt5mn4qYjW6Ux5c3Gfnkn8WBwe
         Uk8w==
X-Gm-Message-State: AOAM53229UAROojN+7e1/JHq0uRgwWkZl/8farfZININRQ6I1feFM0fr
        liaJljxNTkiOEFGCoMUvJKKqgrXb+zo=
X-Google-Smtp-Source: ABdhPJwFa/WRkIUSZPk5B5cH+Uj5XC3T+N6nBkDK3OBRFFGFFNmatvawS5PvZPVtFDAG99D3PjI1Dg==
X-Received: by 2002:a7b:c445:: with SMTP id l5mr22773wmi.100.1629145062496;
        Mon, 16 Aug 2021 13:17:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r129sm144016wmr.7.2021.08.16.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:42 -0700 (PDT)
Message-Id: <9f1b792459e985dd7db74fa06229ef173993eafe.1629145037.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:17:16 +0000
Subject: [PATCH v2 25/25] t1404: annotate test cases with REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
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
gitgitgadget
