Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36420C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E962364D99
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhBBJgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhBBJfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:35:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88900C061794
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:33:57 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y10so7886927plk.7
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BU0Hi7RAV2KElXGBIE71hMJoCEINqunWPtqs8tMqIso=;
        b=QZ8kA4UWMqZL5/Aj0BW20RliHcE1kmCfovX2HGry5R3D+Jb209ZhqwSXq/N5e+EcDB
         JSTx6isR630uT98AV9HiXuCRgmPpXe/tzCWs0u/e/1qVGzbAWczXS60krFSagXtRCzDc
         pFP+/85XG7JcJE1VzGftZvItfZOM0Ub2FHBBBkGloygJjaLJiCm6fhONri0R2R465/Ix
         jKz7IReaKYtwT7kya3DVBOXZQIO9CNUwaRiCy3/EsnU1jK4XqC/0No56cmgHLWxygI3a
         4gtYb/XCaXNK/LIAQ6nHs4XcgjJl4zBZHb10WYSTrBik4vEhTx+fuUVIonmfTTgyMegv
         vQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BU0Hi7RAV2KElXGBIE71hMJoCEINqunWPtqs8tMqIso=;
        b=pYOIQTKAa79EaoVS8PxoErtsuCQyqRVbybsFl1uJ1NaUvDdN8/AiFN9OUzs1/7/do8
         KtLFCqw11qVvfEGPw59cm2LdalQM1gH0kmqpImS+GgFOZq9fvkX9TIRP409P2bzEaK2d
         qLdlgyJwWC96mAQyNENH/l9Iw9x50AAzyeYHCWajrE1tYn8LgdsJdC8EvyTTqOZF+j22
         2lNoUbnTfxvxXms0NWHDVb+cSbQrx2WVucOSfvLPd97GDcXBblpnHXTeT5/AO+6fJbcL
         afqEUODGH0Snan21/BIn6futK5ONg1VJKSQXQMeSLv6vajABZp2XlsOoOA58xvjnHuqd
         1eDw==
X-Gm-Message-State: AOAM531P+Vv17RyyKTVGkPxFBp06zwFnahhnwGJ+WG/XSJM7FLfDgf7V
        uH8vrVDXpDnZ/Qrjg65DzwEG8QfGy4k=
X-Google-Smtp-Source: ABdhPJyYsW7fk6xNshs2PYXEKOJib9OyqyZWvEjzA11jd+EHYqlg8jsH2R14RiMHPtO3uHZ4j3BJ+g==
X-Received: by 2002:a17:902:8643:b029:da:d5f9:28f6 with SMTP id y3-20020a1709028643b02900dad5f928f6mr21542137plt.8.1612258436863;
        Tue, 02 Feb 2021 01:33:56 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e21sm20584462pgv.74.2021.02.02.01.33.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:33:48 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/9] t3905: remove spaces after redirect operators
Date:   Tue,  2 Feb 2021 01:33:19 -0800
Message-Id: <0de324e3bc9b900a0e4badd9eba58d196d4f4f0a.1612258145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612258145.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For shell scripts, the usual convention is for there to be no space
after redirection operators, (e.g. `>file`, not `> file`). Remove these
spaces wherever they appear.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index f075c7f1f3..1d416944b7 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -8,16 +8,16 @@ test_description='Test git stash --include-untracked'
 . ./test-lib.sh
 
 test_expect_success 'stash save --include-untracked some dirty working directory' '
-	echo 1 > file &&
+	echo 1 >file &&
 	git add file &&
 	test_tick &&
 	git commit -m initial &&
-	echo 2 > file &&
+	echo 2 >file &&
 	git add file &&
-	echo 3 > file &&
+	echo 3 >file &&
 	test_tick &&
-	echo 1 > file2 &&
-	echo 1 > HEAD &&
+	echo 1 >file2 &&
+	echo 1 >HEAD &&
 	mkdir untracked &&
 	echo untracked >untracked/untracked &&
 	git stash --include-untracked &&
@@ -25,7 +25,7 @@ test_expect_success 'stash save --include-untracked some dirty working directory
 	git diff-index --cached --quiet HEAD
 '
 
-cat > expect <<EOF
+cat >expect <<EOF
 ?? actual
 ?? expect
 EOF
@@ -37,7 +37,7 @@ test_expect_success 'stash save --include-untracked cleaned the untracked files'
 
 tracked=$(git rev-parse --short $(echo 1 | git hash-object --stdin))
 untracked=$(git rev-parse --short $(echo untracked | git hash-object --stdin))
-cat > expect.diff <<EOF
+cat >expect.diff <<EOF
 diff --git a/HEAD b/HEAD
 new file mode 100644
 index 0000000..$tracked
@@ -60,7 +60,7 @@ index 0000000..$untracked
 @@ -0,0 +1 @@
 +untracked
 EOF
-cat > expect.lstree <<EOF
+cat >expect.lstree <<EOF
 HEAD
 file2
 untracked
@@ -85,7 +85,7 @@ test_expect_success 'stash save --patch --all fails' '
 
 git clean --force --quiet
 
-cat > expect <<EOF
+cat >expect <<EOF
  M file
 ?? HEAD
 ?? actual
@@ -105,14 +105,14 @@ test_expect_success 'stash pop after save --include-untracked leaves files untra
 git clean --force --quiet -d
 
 test_expect_success 'stash save -u dirty index' '
-	echo 4 > file3 &&
+	echo 4 >file3 &&
 	git add file3 &&
 	test_tick &&
 	git stash -u
 '
 
 blob=$(git rev-parse --short $(echo 4 | git hash-object --stdin))
-cat > expect <<EOF
+cat >expect <<EOF
 diff --git a/file3 b/file3
 new file mode 100644
 index 0000000..$blob
@@ -128,12 +128,12 @@ test_expect_success 'stash save --include-untracked dirty index got stashed' '
 	test_cmp expect actual
 '
 
-git reset > /dev/null
+git reset >/dev/null
 
 # Must direct output somewhere where it won't be considered an untracked file
 test_expect_success 'stash save --include-untracked -q is quiet' '
-	echo 1 > file5 &&
-	git stash save --include-untracked --quiet > .git/stash-output.out 2>&1 &&
+	echo 1 >file5 &&
+	git stash save --include-untracked --quiet >.git/stash-output.out 2>&1 &&
 	test_line_count = 0 .git/stash-output.out &&
 	rm -f .git/stash-output.out
 '
@@ -141,7 +141,7 @@ test_expect_success 'stash save --include-untracked -q is quiet' '
 test_expect_success 'stash save --include-untracked removed files' '
 	rm -f file &&
 	git stash save --include-untracked &&
-	echo 1 > expect &&
+	echo 1 >expect &&
 	test_cmp expect file
 '
 
@@ -152,14 +152,14 @@ test_expect_success 'stash save --include-untracked removed files got stashed' '
 	test_path_is_missing file
 '
 
-cat > .gitignore <<EOF
+cat >.gitignore <<EOF
 .gitignore
 ignored
 ignored.d/
 EOF
 
 test_expect_success 'stash save --include-untracked respects .gitignore' '
-	echo ignored > ignored &&
+	echo ignored >ignored &&
 	mkdir ignored.d &&
 	echo ignored >ignored.d/untracked &&
 	git stash -u &&
@@ -169,7 +169,7 @@ test_expect_success 'stash save --include-untracked respects .gitignore' '
 '
 
 test_expect_success 'stash save -u can stash with only untracked files different' '
-	echo 4 > file4 &&
+	echo 4 >file4 &&
 	git stash -u &&
 	test_path_is_missing file4
 '
@@ -214,7 +214,7 @@ test_expect_success 'stash push with $IFS character' '
 	test_path_is_file bar
 '
 
-cat > .gitignore <<EOF
+cat >.gitignore <<EOF
 ignored
 ignored.d/*
 EOF
@@ -224,7 +224,7 @@ test_expect_success 'stash previously ignored file' '
 	git add .gitignore &&
 	git commit -m "Add .gitignore" &&
 	>ignored.d/foo &&
-	echo "!ignored.d/foo" >> .gitignore &&
+	echo "!ignored.d/foo" >>.gitignore &&
 	git stash save --include-untracked &&
 	test_path_is_missing ignored.d/foo &&
 	git stash pop &&
-- 
2.30.0.478.g8a0d178c01

