Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D41C4320E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF6060EE0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhHQNnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbhHQNmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:42:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC844C06124C
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso2175461wms.2
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yyG7ptp3kPeTvu91jaJSIgDSemxiR1k8pmNU3KvV//Y=;
        b=sQG/GWcn0rGTmlNCadIDndcd3LFMTaAcOHOtLSs3mBLNpxjKwGhMBAo/ilqHguOVZT
         LCZy0geUy8QcZ7JiYETbMLnruVADv32VBOaTJeMzslf0xskrmAPnNXk+HJIU//JHOpxJ
         XRpKXVovkJwAoZU2+LWpMryRogVTfQpo5VyE15CTWTv5DKcEm9uyzjLdDWbYtRjgncb1
         f9YkbBvNAYmnoEArmngkc2jQOH9BbjfmvLQLT7cGYM8o9xfZJzIgRjODScE0N35/6i3Y
         ARLuejYpxtZ370AgkbSTh4I8qg/y4EcSucbsygzoO2hn9jDcKux/WCn9c3hwnXjbg47b
         2ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yyG7ptp3kPeTvu91jaJSIgDSemxiR1k8pmNU3KvV//Y=;
        b=R3hhH6VUuGJGNl0S43DyC+Mzpff+UpfBED6NwUP1HOX0yOffdbyB9Nmp2Gxa7g56Wd
         zZlxvpv30hMnz5YW0ALR+ZQUmKaNix9mZvKCcWYOk+eCcnWenzMZ+jiXHaTgA7ylKsz8
         NzB4BUL909yWTpXr3d0qBeDQfrtR9lGjqx/3dxR6k4VMi7N4JXNlOrq/tgqnfGOPneem
         M6JJP0aOAubFFk5uSoKRfFY21cXjLaS+LN4HNZNpqJGF9Dl0Orj4LDRK53aVBIPHOvMs
         y2GCqXMUKct6ZOvOlEvJd/rALPMmgEFepHY+KVbWMtrrzyTtd3EBNkun+PT4eUBjbeJn
         5U7Q==
X-Gm-Message-State: AOAM533dRctdChkBcnh7nIhkSqB9LxSSmnVE+/aYAoMmjDt6BtMzkYJp
        ztY3Vg9HkJSloeOFmH4S2Rosx6H1xnQ=
X-Google-Smtp-Source: ABdhPJxXPWV8iL1hXXufDwZj33oIJMq3HU+LFx51baX0gQnfrk71BKV8wI//Yc+3mZ9QxqHWoNrdRA==
X-Received: by 2002:a05:600c:210d:: with SMTP id u13mr3327540wml.57.1629207651343;
        Tue, 17 Aug 2021 06:40:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm2796949wrn.8.2021.08.17.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:50 -0700 (PDT)
Message-Id: <3110d6e6758a31aa3b72842dc664ca160f07814b.1629207607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
        <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:40:07 +0000
Subject: [PATCH v3 25/25] t1404: annotate test cases with REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
