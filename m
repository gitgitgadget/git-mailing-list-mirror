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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7530AC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEB461108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhEaRlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhEaRku (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66276C00874A
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so230717wmc.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Jdb8ajfDJMoXOBG2IYSvbv8EazX50BXCsc7B6qiA9HI=;
        b=uRO8wXLFgjrdY0FGcW9M0CkzSGrevRLQIHM0bBC0WN1n90vRhePkEv9PsSMvHfTwrN
         HSMwJWh5JG2o0Y3WuvaiLskHLMo/SQ9EuELopu8zqDZTdh/uG16RzLxsC0j5ZZohLYMA
         9YQrYzPD4WqWEc35kdYUExbZstvD3YX8Kx31zT3evhWIQalLgL/p9LQrzizxUZsQ65LR
         Ea+JwwU38wB9taRIdCzu1YCid8BRi/nd/seYf+gw7VBHMSvOkRcC8qBhlHxUcFdEuAd8
         ww/yzxNkU7Ja8LDad3uFBisOTLTBrCLe+0nQ3Q/289CxwcBOWm9KhsZWSmIj2FWBBnvt
         JnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Jdb8ajfDJMoXOBG2IYSvbv8EazX50BXCsc7B6qiA9HI=;
        b=P7GurSstr4Dw8DbEbdLbwgJT/zj8gyFrbifZGe5l17OPaxZmrXiB/hVsXk6hEzsT7b
         eFJKti4c6BE3zXSsHUTIO2XdYWds9Wnkh0H+NVHSZfvfYLZxONJouxdsCL+h4OsnIMd7
         OwK7nsOOIEOIpV/Z29bq5z5E3JfFiWjLw/zPu/rjcSjF0/WL4P8zqPASYj+2TcFVLWYP
         HM5Gq3JWhaIeLj1oPvmBHVWPee2tGketYdv79RMq6Mod7FIe8fl3i6ddVVyaRhJwi3+E
         +tXYpZH2Aoj3cOKDR/vKxfIWUrI821JkPjAZ6R065fLJlAEJEZ3pYOK/ikHB33wars3e
         e/Ig==
X-Gm-Message-State: AOAM531d1s6ScM7jeg0yDhisqSR/ZFLey8ae2FmsrnbtX78DFpsg7grw
        rhKOAY4T74pxyhzl1Y5oGubxdj9LzCQ=
X-Google-Smtp-Source: ABdhPJwrm9RpmDsJX2a/M5zY6BAhVIDijOmw4XA0iDv+teK7FF0l2iwmnkRQp87huNnM0MXn1lOzOg==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr45189wmc.93.1622480204109;
        Mon, 31 May 2021 09:56:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x24sm29582wmi.13.2021.05.31.09.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:43 -0700 (PDT)
Message-Id: <e76c1e71bcb0010eb3588c1e9a005da6a9460638.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:24 +0000
Subject: [PATCH v3 09/22] t5000: reformat indentation to the latest fashion
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5000-tar-tree.sh | 113 ++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 51 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7204799a0b52..8c5867b6c8ae 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -111,25 +111,34 @@ test_expect_success 'setup' '
 	EOF
 '
 
-test_expect_success \
-    'populate workdir' \
-    'mkdir a &&
-     echo simple textfile >a/a &&
-     ten=0123456789 && hundred=$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten &&
-     echo long filename >a/four$hundred &&
-     mkdir a/bin &&
-     test-tool genrandom "frotz" 500000 >a/bin/sh &&
-     printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
-     printf "A not substituted O" >a/substfile2 &&
-     if test_have_prereq SYMLINKS; then
-	ln -s a a/l1
-     else
-	printf %s a > a/l1
-     fi &&
-     (p=long_path_to_a_file && cd a &&
-      for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
-      echo text >file_with_long_path) &&
-     (cd a && find .) | sort >a.lst'
+test_expect_success 'populate workdir' '
+	mkdir a &&
+	echo simple textfile >a/a &&
+	ten=0123456789 &&
+	hundred="$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten" &&
+	echo long filename >"a/four$hundred" &&
+	mkdir a/bin &&
+	test-tool genrandom "frotz" 500000 >a/bin/sh &&
+	printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
+	printf "A not substituted O" >a/substfile2 &&
+	if test_have_prereq SYMLINKS
+	then
+		ln -s a a/l1
+	else
+		printf %s a >a/l1
+	fi &&
+	(
+		p=long_path_to_a_file &&
+		cd a &&
+		for depth in 1 2 3 4 5
+		do
+			mkdir $p &&
+			cd $p
+		done &&
+		echo text >file_with_long_path
+	) &&
+	(cd a && find .) | sort >a.lst
+'
 
 test_expect_success \
     'add ignored file' \
@@ -147,18 +156,18 @@ test_expect_success 'setup export-subst' '
 		>a/substfile1
 '
 
-test_expect_success \
-    'create bare clone' \
-    'git clone --bare . bare.git &&
-     cp .git/info/attributes bare.git/info/attributes'
+test_expect_success 'create bare clone' '
+	git clone --bare . bare.git &&
+	cp .git/info/attributes bare.git/info/attributes
+'
 
-test_expect_success \
-    'remove ignored file' \
-    'rm a/ignored'
+test_expect_success 'remove ignored file' '
+	rm a/ignored
+'
 
-test_expect_success \
-    'git archive' \
-    'git archive HEAD >b.tar'
+test_expect_success 'git archive' '
+	git archive HEAD >b.tar
+'
 
 check_tar b
 
@@ -194,26 +203,28 @@ check_added with_untracked2 untracked one/untracked
 check_added with_untracked2 untracked two/untracked
 
 test_expect_success 'git archive on large files' '
-    test_config core.bigfilethreshold 1 &&
-    git archive HEAD >b3.tar &&
-    test_cmp_bin b.tar b3.tar
+	test_config core.bigfilethreshold 1 &&
+	git archive HEAD >b3.tar &&
+	test_cmp_bin b.tar b3.tar
 '
 
-test_expect_success \
-    'git archive in a bare repo' \
-    '(cd bare.git && git archive HEAD) >b3.tar'
+test_expect_success 'git archive in a bare repo' '
+	git --git-dir bare.git archive HEAD >b3.tar
+'
 
-test_expect_success \
-    'git archive vs. the same in a bare repo' \
-    'test_cmp_bin b.tar b3.tar'
+test_expect_success 'git archive vs. the same in a bare repo' '
+	test_cmp_bin b.tar b3.tar
+'
 
-test_expect_success 'git archive with --output' \
-    'git archive --output=b4.tar HEAD &&
-    test_cmp_bin b.tar b4.tar'
+test_expect_success 'git archive with --output' '
+	git archive --output=b4.tar HEAD &&
+	test_cmp_bin b.tar b4.tar
+'
 
-test_expect_success 'git archive --remote' \
-    'git archive --remote=. HEAD >b5.tar &&
-    test_cmp_bin b.tar b5.tar'
+test_expect_success 'git archive --remote' '
+	git archive --remote=. HEAD >b5.tar &&
+	test_cmp_bin b.tar b5.tar
+'
 
 test_expect_success 'git archive --remote with configured remote' '
 	git config remote.foo.url . &&
@@ -224,13 +235,13 @@ test_expect_success 'git archive --remote with configured remote' '
 	test_cmp_bin b.tar b5-nick.tar
 '
 
-test_expect_success \
-    'validate file modification time' \
-    'mkdir extract &&
-     "$TAR" xf b.tar -C extract a/a &&
-     test-tool chmtime --get extract/a/a >b.mtime &&
-     echo "1117231200" >expected.mtime &&
-     test_cmp expected.mtime b.mtime'
+test_expect_success 'validate file modification time' '
+	mkdir extract &&
+	"$TAR" xf b.tar -C extract a/a &&
+	test-tool chmtime --get extract/a/a >b.mtime &&
+	echo "1117231200" >expected.mtime &&
+	test_cmp expected.mtime b.mtime
+'
 
 test_expect_success \
     'git get-tar-commit-id' \
-- 
gitgitgadget

