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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F715C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59987613F6
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbhDWHWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbhDWHWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72AC06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cq11so12716172edb.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrXIOI4L0plac890N48Qghwz38Dol/MaG/KKajqW4c0=;
        b=VZv0tNVvLA7BnlXIKP+YF3rCiLbeq5v9JVSUW91zs11QzAbxNQQbvDBPfYKtOP7dLd
         Xh06cAqcr6IM6IDgMOfQH14ecfID2rxYCV8wZ2+6IoAlQXk1JzMSkwX/hUXq4EN9gkJM
         XImFblEfBIvM8r5/bJoZ7cwJUzdtasANMvsoc2XeNfSA2sQcVM4wvcbwSHBHuqXnn3Fs
         yVYm2EKgbg8iu7/C8uHaP13o8xhz8aJS5L9kdVCWIjdOjcVzCyrM/OKSKZgdXUnOCjbc
         Ds9U1amPDKsG4dWA5Drdha4OeIxIlASDxVPXUoD0O/xBeibrsPHxzfpmy/7D2fCBuzUT
         IWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrXIOI4L0plac890N48Qghwz38Dol/MaG/KKajqW4c0=;
        b=GqMWVIBU0nf7RrSQlCi98M8kdcwLugo3Hu8gCVUVh7rD+ly1y5NwCeS4KsJjxG7iEv
         YWL3NwQt/mA0yQ8bYxIENbpvkaMgfzPqTzta7yIbZnUzkV4cLkEScrmCFcbf3sqUtgF2
         LUtLAh1i1nGYkObLZXoOI0o3NjXR+ly/dG91/jc44gxIYvQVfUCcLJXYUtyuZ3RmPBny
         A36W0Yz1Yzam+EWqPuEWXskR4MK+Qeq+LTotj6PbUGeyqPN3RoDs5WkMW5NdwfNNPBKE
         sU+2K4leMQ318dJIQsa4vB4xd5nRerD93oVADIcazG1AC/j8XnEXS/+bvuyzpJu2EAxO
         haJg==
X-Gm-Message-State: AOAM533Xl1ehQR7xJXxJ3uJR/JQO6AG498qvA31/4VptRo6uMIDZlQqT
        WOCAHs0VuII4JLMhAf/Ouc4cC3qUizxklA==
X-Google-Smtp-Source: ABdhPJwqyCYOQOfoHu/NEcEHSYLVTeladNglt3L1tsbhMYXnQ9NHZ456GhKbg4sMzIzicUJ8013HJg==
X-Received: by 2002:aa7:c789:: with SMTP id n9mr2855087eds.352.1619162488342;
        Fri, 23 Apr 2021 00:21:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/11] test-lib functions: add --printf option to test_commit
Date:   Fri, 23 Apr 2021 09:21:11 +0200
Message-Id: <patch-07.11-a0fe0640148-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --printf option to test_commit to allow writing to the file with
"printf" instead of "echo".

This is useful for writing "\n", "\0" etc., in particular in
combination with the --append option added in 3373518cc8 (test-lib
functions: add an --append option to test_commit, 2021-01-12).

I'm converting a few tests to use the new option rather than a manual
printf/add/commit combination to demonstrate its usefulness. While I'm
at it use "test_create_repo" where appropriate, and give the
first/second commit a meaningful/more conventional log message in
cases where no test cared about that message.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1307-config-blob.sh    |  4 +---
 t/t2030-unresolve-info.sh |  3 +--
 t/t4006-diff-mode.sh      |  6 ++----
 t/t4030-diff-textconv.sh  |  8 ++------
 t/t5520-pull.sh           | 10 ++--------
 t/test-lib-functions.sh   | 12 ++++++++++--
 6 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index 002e6d3388e..930dce06f0f 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -65,9 +65,7 @@ test_expect_success 'parse errors in blobs are properly attributed' '
 '
 
 test_expect_success 'can parse blob ending with CR' '
-	printf "[some]key = value\\r" >config &&
-	git add config &&
-	git commit -m CR &&
+	test_commit --printf CR config "[some]key = value\\r" &&
 	echo value >expect &&
 	git config --blob=HEAD:config some.key >actual &&
 	test_cmp expect actual
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index be6c84c52a2..f691e6d9032 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -179,8 +179,7 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
 
 test_expect_success 'rerere forget (binary)' '
 	git checkout -f side &&
-	printf "a\0c" >binary &&
-	git commit -a -m binary &&
+	test_commit --printf binary binary "a\0c" &&
 	test_must_fail git merge second &&
 	git rerere forget binary
 '
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 275ce5fa15b..6cdee2a2164 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -26,10 +26,8 @@ test_expect_success 'chmod' '
 '
 
 test_expect_success 'prepare binary file' '
-	git commit -m rezrov &&
-	printf "\00\01\02\03\04\05\06" >binbin &&
-	git add binbin &&
-	git commit -m binbin
+	git commit -m one &&
+	test_commit --printf two binbin "\00\01\02\03\04\05\06"
 '
 
 test_expect_success '--stat output after text chmod' '
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index c906320b60d..a39a626664d 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -26,12 +26,8 @@ EOF
 chmod +x hexdump
 
 test_expect_success 'setup binary file with history' '
-	printf "\\0\\n" >file &&
-	git add file &&
-	git commit -m one &&
-	printf "\\01\\n" >>file &&
-	git add file &&
-	git commit -m two
+	test_commit --printf one file "\\0\\n" &&
+	test_commit --printf --append two file "\\01\\n"
 '
 
 test_expect_success 'file is considered binary by porcelain' '
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a09411327f9..e2c0c510222 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -746,14 +746,8 @@ test_expect_success 'pull --rebase fails on corrupt HEAD' '
 '
 
 test_expect_success 'setup for detecting upstreamed changes' '
-	mkdir src &&
-	(
-		cd src &&
-		git init &&
-		printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" > stuff &&
-		git add stuff &&
-		git commit -m "Initial revision"
-	) &&
+	test_create_repo src &&
+	test_commit -C src --printf one stuff "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" &&
 	git clone src dst &&
 	(
 		cd src &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 827c8502b10..701518f5fd3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -173,6 +173,10 @@ debug () {
 #	Do not call test_tick before making a commit
 #   --append
 #	Use ">>" instead of ">" when writing "<contents>" to "<file>"
+#   --printf
+#       Use "printf" instead of "echo" when writing "<contents>" to
+#       "<file>". You will need to provide your own trailing "\n". You
+#       can only supply the FORMAT for the printf(1), not its ARGUMENT(s).
 #   --signoff
 #	Invoke "git commit" with --signoff
 #   --author <author>
@@ -191,6 +195,7 @@ debug () {
 
 test_commit () {
 	notick= &&
+	echo=echo &&
 	append= &&
 	author= &&
 	signoff= &&
@@ -202,6 +207,9 @@ test_commit () {
 		--notick)
 			notick=yes
 			;;
+		--printf)
+			echo=printf
+			;;
 		--append)
 			append=yes
 			;;
@@ -238,9 +246,9 @@ test_commit () {
 	file=${2:-"$1.t"} &&
 	if test -n "$append"
 	then
-		echo "${3-$1}" >>"$indir$file"
+		$echo "${3-$1}" >>"$indir$file"
 	else
-		echo "${3-$1}" >"$indir$file"
+		$echo "${3-$1}" >"$indir$file"
 	fi &&
 	git ${indir:+ -C "$indir"} add "$file" &&
 	if test -z "$notick"
-- 
2.31.1.737.g98b508eba36

