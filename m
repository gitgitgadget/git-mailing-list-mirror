Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C4C433FE
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 00:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiCRAfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiCRAfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 20:35:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC5A247C2F
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso4052647wmz.4
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=te9jPeDd0qITItP5w4s3dApKBm5YVDXmW8yGGhR2wN8=;
        b=OCMvs+rRL0dlh6iq3WYvGQ6dXthT2cakPXVHI0o5BZh7QiCXJjOgd7JIbhKDua6uFH
         l0AFWLD5UJOMHbecM1PP/iM9kTmcmgXfQfASk2ARwa9BMIaHQ7F+9pRfc8rqrWedJQ+L
         OG51j9lzNd0soJjzPpTfOhtdIvYcAL7oI2pn35ThdPS7bjdFofBhUQf9vTqbUVXXq12b
         99WCHIjITuVJ81TpdB0FN3YrE55PlefVU+svWUDbNdBNqfHCN6q1DusEo1XUnMKa/3nX
         5LbFjGAaudbc6EDIlB3zo7qkk0+8wz90TDrUgfa4uX7CZSHtkXbN9E2YO+fCUZDvblJ+
         2ssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=te9jPeDd0qITItP5w4s3dApKBm5YVDXmW8yGGhR2wN8=;
        b=SERaARw8pt1C70CwKGSAshQHSq4QiZ1UQ3Cyc0V/84UfiuhqgvmUmwHMiKCAldb7pA
         Km1fEcVV5a+oYfLITdZ5F+D5AxKzxsB2sxfjcD37ffSuV4ySpDb7b7YgVT/jfUQJXMrI
         7+CMq+KbMy6t/9jXH5Lo2b1tA1ue8ivf6JZ/XumZXqI457Te0J+PKaVuTZIypK5bZent
         9SMNHBI0M1XZVTMB8gzVtksKqwbb1WOx0TxDLp5sW5PjmO9vo1SYRlcQVoAFarurCHNM
         qXdHoHHymxI7bVrHrqUKEx1M95Mj4UH0GKnPa33+n6aG2CDTcyfMWmwUwZzVCWShqZnJ
         uIdg==
X-Gm-Message-State: AOAM533fZADLYC+C7r6xZeK7CxgzGeiblnmytYrNegb4Wu/39Olx9rdS
        FKW4pb+ntQBtFFeKUbWKo2xfOFLthp0pZQ==
X-Google-Smtp-Source: ABdhPJxEd3Ugyp9phd6VJ0/Cse4F2SYYoqkCpSGqMLbWV1pbUKkbDibgfP60reHp6eh0ZX8s/D81rg==
X-Received: by 2002:a05:600c:4ece:b0:38c:7938:d73c with SMTP id g14-20020a05600c4ece00b0038c7938d73cmr4554886wmq.165.1647563654018;
        Thu, 17 Mar 2022 17:34:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b00203dde8d82bsm5096548wro.88.2022.03.17.17.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:34:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/7] test-lib-functions: add and use a "todo_test_path" helper
Date:   Fri, 18 Mar 2022 01:34:00 +0100
Message-Id: <patch-5.7-553670da8a9-20220318T002951Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1436.g756b814e59f
In-Reply-To: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "todo_test_path" helper and convert an additional test added
in 45bde58ef8f (grep: demonstrate bug with textconv attributes and
submodules, 2021-09-29) to use it in conjunction with
"test_expect_todo".

Like the "todo_test_cmp" function introduced in a preceding commit,
this function is a trivial wrapper around "test_todo". Rather than a
more verbose:

	test_todo \
		--want "test_path_is_missing" \
		--expect "test_path_is_file" \
		-- "$super_textconv_cache"

We can do:

	todo_test_path is_missing is_file "$super_textconv_cache"

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7814-grep-recurse-submodules.sh |  6 +++---
 t/test-lib-functions.sh            | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 8d9b53ccfed..8df692ee9a0 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -549,7 +549,7 @@ test_expect_todo 'grep --textconv correctly reads submodule .git/info/attributes
 	todo_test_cmp want expect actual
 '
 
-test_expect_failure 'grep saves textconv cache in the appropriate repository' '
+test_expect_todo 'grep saves textconv cache in the appropriate repository' '
 	reset_and_clean &&
 	test_config_global diff.d2x_cached.textconv "sed -e \"s/d/x/\"" &&
 	test_config_global diff.d2x_cached.cachetextconv true &&
@@ -562,8 +562,8 @@ test_expect_failure 'grep saves textconv cache in the appropriate repository' '
 	super_textconv_cache="$(git rev-parse --git-path refs/notes/textconv/d2x_cached)" &&
 	sub_textconv_cache="$(git -C submodule rev-parse \
 			--path-format=absolute --git-path refs/notes/textconv/d2x_cached)" &&
-	test_path_is_missing "$super_textconv_cache" &&
-	test_path_is_file "$sub_textconv_cache"
+	todo_test_path is_missing is_file "$super_textconv_cache" &&
+	todo_test_path is_file is_missing "$sub_textconv_cache"
 '
 
 test_expect_success 'grep partially-cloned submodule' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4d1eca380e8..3febf4b0811 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1036,6 +1036,31 @@ test_todo () {
 	BUG "a test_todo didn't pass with either --want ('$want') or --expect ('$expect')"
 }
 
+# todo_test_path is a test_path_* for use in conjunction with
+# "test_expect_todo".
+#
+# It takes "want_fn" and "expect_fn" arguments of e.g. "is_file" or
+# "is_dir", which will be turned into corresponding "test_file_*"
+# calls. Use it like:
+#
+#	test_expect_todo 'foo should be a directory' '
+#		>foo &&
+#		todo_test_path is_dir is_file foo
+#	'
+todo_test_path () {
+	test "$#" -ne 3 && BUG "3 param, not $#"
+	local want_fn=$1
+	local expect_fn=$2
+	local path=$3 &&
+	shift 3 &&
+
+	test_todo \
+		--want "test_path_$want_fn" \
+		--expect "test_path_$expect_fn" \
+		-- \
+		"$path"
+}
+
 # test_line_count checks that a file has the number of lines it
 # ought to. For example:
 #
-- 
2.35.1.1436.g756b814e59f

