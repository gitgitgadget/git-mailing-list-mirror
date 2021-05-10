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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4CBC43460
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65716120D
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbhEJPQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbhEJPNp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:13:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C314FC0515F1
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l13so16844840wru.11
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DiO0EDbsEvg9ZoYYMqLG6vTOsTJoQS0VOwazoDlHqHE=;
        b=Hp3TwtNDxU5IB5i1K/9bag09cpek4jEwC0VIWc3SKl63w5T4hSAo7ofdK5mN1D1H9I
         8YwD8Oh6QxmPAEMvrDkwsXj82IuF9b+JCf43tM9Rz151XwGDcv7ywq02PW0jIaqSK7pA
         cT5Rm1mt1ulBsHTYQxkuec0a1/WcpQQH9dvAol2p3YHKjvmmqDyo9TRqxnJuuLU+JV1k
         H4uIMEngQSKGJOGVCBSCaM8lRQS2JFvRoX8rkNIQ93i/0K7BqFxQZHMHb+2sE4FMxR+n
         bZhfI2SeuDQtAMUWwYBH5oNdoVoT9fQl/uBLA0bPfy7jDBw5oeq5Q3wM840TVCcCRY+J
         J0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiO0EDbsEvg9ZoYYMqLG6vTOsTJoQS0VOwazoDlHqHE=;
        b=qFkB3YV3C3csyD4yY6uf2h3zseqG++jOXZSDP5sf8Fpp4lJYlWlrM0dE3mLgO/C2hn
         X5WycjImt5oybM5Ruho2USpnZEG3U4AGmkZw6lrw042LaztEjvwWxfXKDEtUYpmuOvne
         c7W9cYlzwUnEoUc81D2k37uLlys65gLDxGTFvBovODTqCpUBmbrsGbSAk2kXXO/IOXXn
         xhGP1lTS3czw81IBsu4u90DkEd2pFzsx284tY7C4ytCjItno8q6jJSMm8700NweOQyqL
         mLQXmTCkzoHJjzqi9QtTybgyy4h8HZeqWd2VLwwGcBR+lqy9SXMIla28GVYm5ZzocJjB
         bo6w==
X-Gm-Message-State: AOAM532J5wtQqcX2jo4ePDZvSzbFdFl4ipYBXLA6JBrqRkyDnUyXJhu4
        0loNPFJ1SybK9QexYgvxeXwNnHfqv/z4Dw==
X-Google-Smtp-Source: ABdhPJwBMLG2G127QY6aIfKcfIUT5pwYPMw9+YHue28dTNyoxK0ntlQPTtvnmZBMUvtQcul+IS5uXw==
X-Received: by 2002:a05:6000:2a2:: with SMTP id l2mr31249945wry.285.1620657140217;
        Mon, 10 May 2021 07:32:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q10sm22421839wre.92.2021.05.10.07.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:32:19 -0700 (PDT)
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
Subject: [PATCH v6 07/11] test-lib functions: add --printf option to test_commit
Date:   Mon, 10 May 2021 16:19:06 +0200
Message-Id: <patch-07.11-5aaeadf01ff-20210510T141055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com> <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
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
 t/test-lib-functions.sh   | 14 ++++++++++++--
 6 files changed, 20 insertions(+), 25 deletions(-)

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
index 827c8502b10..b242ecf5cd2 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -173,6 +173,12 @@ debug () {
 #	Do not call test_tick before making a commit
 #   --append
 #	Use ">>" instead of ">" when writing "<contents>" to "<file>"
+#   --printf
+#       Use "printf" instead of "echo" when writing "<contents>" to
+#       "<file>", use this to write escape sequences such as "\0", a
+#       trailing "\n" won't be added automatically. This option
+#       supports nothing but the FORMAT of printf(1), i.e. no custom
+#       ARGUMENT(s).
 #   --signoff
 #	Invoke "git commit" with --signoff
 #   --author <author>
@@ -191,6 +197,7 @@ debug () {
 
 test_commit () {
 	notick= &&
+	echo=echo &&
 	append= &&
 	author= &&
 	signoff= &&
@@ -202,6 +209,9 @@ test_commit () {
 		--notick)
 			notick=yes
 			;;
+		--printf)
+			echo=printf
+			;;
 		--append)
 			append=yes
 			;;
@@ -238,9 +248,9 @@ test_commit () {
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
2.31.1.838.g924d365b763

