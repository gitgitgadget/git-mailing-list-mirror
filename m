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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAE9C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE69A64DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhBPMBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhBPL7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB09EC061788
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n6so12566972wrv.8
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPMc4KTMO+zJiAqeaKGHHgKp1EEKuVngK9vDEBwJD08=;
        b=hTiQKbvb4YP40OSumV1YT/U1P/Pa/p/DBBj8FAdQUC2zkn9Lqgx3zgM0nwfUkcLbpH
         t9pM+m89V3J3/7PMlqz14CvGSSCODWjrWzl0DhD5cSz+fuqYRG8XFf3qNJhvN0LRrSuN
         tYC5LjRffDGnS/Kf+FU1KVZ5VxnEi4MyHWkQr9qYBc+mvfhRO2uJ5YEbz0lDCXiRltNa
         VZzGjwqDovtLN2wZgUimelf4p+Dk+3mlEzZzJ54QYwzr1hne0U7z79jkqlXSIz3I3cvY
         DR4eQ1O5W4nL+b24ZT5CTfIAMObVPi+2kCZe+6TcVr9IhRjV5iuPHxwh1CFat0R+cM25
         gR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPMc4KTMO+zJiAqeaKGHHgKp1EEKuVngK9vDEBwJD08=;
        b=h7piXmAwM2Bv9jwG1hDatHIAXqPSezReiOd5qIU8FArIgqyXFhPruccV4e/H5E1eo/
         XLr9l0l558szXPJnncN54WagW0m0VhKme2pBcwlIbbQKU1VW1y0w0MzUNbjQ91VzJWgb
         c/K6tDeG58jraHMzUJEiGLi8V8k4FTezxnAYuqu4UTI+Pi+iNLniE1X83Dte1WGc9j8P
         QH3n7E4gYsu+rjek5mJH4mhq9mzPk4r82Kn5BxTiaLzJWCFGPr1Mud05LVrz6l+Kr1Yz
         Yh8M12nRbC+CctpD5aEUWz272Dpa6fiYHlMUul053biZtEa1BCHc8G5pAKWsWVkPXh4d
         Q0VA==
X-Gm-Message-State: AOAM530uovZeKyaJDAdm85auHRiU6lXvQvIMoa5tc5ylSR/MXfU2qyIR
        PQMZV9shu5Tk+BVVQaVJaE/IMw7VqxBYOA==
X-Google-Smtp-Source: ABdhPJzFQFFg5gjb7KYfoAVnOuJKYQcn2lp4yXN/L+9RlrnvNkNngbNoNxeYFoRKNDdn+bVwegoOgQ==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr23383656wro.73.1613476696392;
        Tue, 16 Feb 2021 03:58:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/22] test-lib functions: add --printf option to test_commit
Date:   Tue, 16 Feb 2021 12:57:43 +0100
Message-Id: <20210216115801.4773-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
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
index be6c84c52a2..bad28d29de5 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -179,8 +179,7 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
 
 test_expect_success 'rerere forget (binary)' '
 	git checkout -f side &&
-	printf "a\0c" >binary &&
-	git commit -a -m binary &&
+	test_commit binary binary "a\0c" &&
 	test_must_fail git merge second &&
 	git rerere forget binary
 '
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 03489aff14e..8fd60424142 100755
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
index 4cb9f0e523d..6e1e7e38ff4 100755
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
index 5af92347123..5e49dd6b864 100644
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
@@ -188,6 +192,7 @@ debug () {
 
 test_commit () {
 	notick= &&
+	echo=echo &&
 	append= &&
 	author= &&
 	signoff= &&
@@ -199,6 +204,9 @@ test_commit () {
 		--notick)
 			notick=yes
 			;;
+		--printf)
+			echo=printf
+			;;
 		--append)
 			append=yes
 			;;
@@ -232,9 +240,9 @@ test_commit () {
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
2.30.0.284.gd98b1dd5eaa7

