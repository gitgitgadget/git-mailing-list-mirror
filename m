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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33821C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037CB64E74
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhB1Tz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhB1TzR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:17 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C831C061786
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w9so1801658edt.13
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmgYJrGj16qxQy2/GBSazHm3Uya0+yBPqTQa8shdcN0=;
        b=HC8H/0/JLDFyrmhOEgGIOdI/LcMAULjQMRxBoxk8piCGrB2CPjiUtvIZ8IJOpQ5xQ7
         wBQe941S6XoWpfpQjzLValqswaOnre5iLu7OWGVLSdJADmpz7e60LY7ScWSjVUEIYThU
         Ze3JJ1TUBuJ8u61B59NuGtFY9Bycxsr2vE6YxqBtVbA/06n25si8sk+nSQgrqfj2JJaF
         pbQoAE2kUUnHQFqTSjZShHJ5Tky7VqnkpD4bVkjuuvZh7ts1M7gBfsBbIjWPt89Gq5Em
         /2JabtMWUJibiedYv7QEoRKqHdLi5SUDU4E/l1A9Vm75BPkyjxqCQqPLN4feG4hVy57W
         MArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmgYJrGj16qxQy2/GBSazHm3Uya0+yBPqTQa8shdcN0=;
        b=ld1P0FnMYaWHjsC+fteNkkXf4XZO0JbTIytijIXE+Sauc0HYrCCu2enN4j0965cxDj
         ugAogs+wV5RNKQI6GKe8D5j6ypAgV+s64IQ4kC4MreeD2JwlR6zgobLIxPq7wt+CFzMJ
         8ZIh23wMna+uGAGVebMD05PGxeapU2YQPwpkaqfg616qaBJA4Js210/hyYvLm31F22Jf
         n2VRTwPnQjjeHuHcqeW6pNCXNndfrORS8X/uL9m8y72TQSfsGo5UO9QETUe6wO9ijmzk
         DOhe/SogU3zRPGnhzCdfPdLyoeHGVu/g7zLcaQnp4YVyB6rmGJeuQunRcf13yA3oRd2j
         YFdQ==
X-Gm-Message-State: AOAM533BnSkzDS7a7c0Axf6X3rquAdoOLWokLM98npgxfAJ3ovSZNvsd
        AsSkevGUcwUmri21NTtHeQgSLiJx9Z68hg==
X-Google-Smtp-Source: ABdhPJyMYFbmDjWqz+zHw/+4LKYOFltIw5XBOzPcpVg5GYPyPwdrSxZH/tuIQOZd4xU9SaU3yWRp+A==
X-Received: by 2002:a05:6402:c88:: with SMTP id cm8mr2170505edb.62.1614542075815;
        Sun, 28 Feb 2021 11:54:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] describe tests: refactor away from glob matching
Date:   Sun, 28 Feb 2021 20:54:06 +0100
Message-Id: <20210228195414.21372-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the glob matching via a "case" statement to a "test_cmp" after
we've stripped out the hash-specific g<hash-abbrev>
suffix. 5312ab11fbf (Add describe test., 2007-01-13).

This means that we can use test_cmp to compare the output. I could
omit the "-8" change of e.g. "A-*" to "A-8-gHASH", but I think it
makes sense to test that here explicitly. It means you need to add new
tests to the bottom of the file, but that's not a burden in this case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 78 ++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 7bc2aaa46e..e4fd5d567f 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -21,12 +21,10 @@ check_describe () {
 	shift
 	describe_opts="$@"
 	test_expect_success "describe $describe_opts" '
-	R=$(git describe $describe_opts 2>err.actual) &&
-	case "$R" in
-	$expect)	echo happy ;;
-	*)	echo "Oops - $R is not $expect" &&
-		false ;;
-	esac
+		git describe $describe_opts 2>err.actual >raw &&
+		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
+		echo $expect >expect &&
+		test_cmp expect actual
 	'
 }
 
@@ -91,29 +89,29 @@ test_expect_success setup '
 
 '
 
-check_describe A-* HEAD
-check_describe A-* HEAD^
-check_describe R-* HEAD^^
-check_describe A-* HEAD^^2
+check_describe A-8-gHASH HEAD
+check_describe A-7-gHASH HEAD^
+check_describe R-2-gHASH HEAD^^
+check_describe A-3-gHASH HEAD^^2
 check_describe B HEAD^^2^
-check_describe R-* HEAD^^^
+check_describe R-1-gHASH HEAD^^^
 
-check_describe c-* --tags HEAD
-check_describe c-* --tags HEAD^
-check_describe e-* --tags HEAD^^
-check_describe c-* --tags HEAD^^2
+check_describe c-7-gHASH --tags HEAD
+check_describe c-6-gHASH --tags HEAD^
+check_describe e-1-gHASH --tags HEAD^^
+check_describe c-2-gHASH --tags HEAD^^2
 check_describe B --tags HEAD^^2^
 check_describe e --tags HEAD^^^
 
 check_describe heads/main --all HEAD
-check_describe tags/c-* --all HEAD^
+check_describe tags/c-6-gHASH --all HEAD^
 check_describe tags/e --all HEAD^^^
 
-check_describe B-0-* --long HEAD^^2^
-check_describe A-3-* --long HEAD^^2
+check_describe B-0-gHASH --long HEAD^^2^
+check_describe A-3-gHASH --long HEAD^^2
 
-check_describe c-7-* --tags
-check_describe e-3-* --first-parent --tags
+check_describe c-7-gHASH --tags
+check_describe e-3-gHASH --first-parent --tags
 
 test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
 	echo "A^0" >expect &&
@@ -134,7 +132,7 @@ test_expect_success 'rename tag A to Q locally' '
 cat - >err.expect <<EOF
 warning: tag 'Q' is externally known as 'A'
 EOF
-check_describe A-* HEAD
+check_describe A-8-gHASH HEAD
 test_expect_success 'warning was displayed for Q' '
 	test_cmp err.expect err.actual
 '
@@ -161,22 +159,22 @@ test_expect_success 'rename tag Q back to A' '
 '
 
 test_expect_success 'pack tag refs' 'git pack-refs'
-check_describe A-* HEAD
+check_describe A-8-gHASH HEAD
 
 test_expect_success 'describe works from outside repo using --git-dir' '
 	git clone --bare "$TRASH_DIRECTORY" "$TRASH_DIRECTORY/bare" &&
 	git --git-dir "$TRASH_DIRECTORY/bare" describe >out &&
-	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+$" out
+	grep -E "^A-8-g[0-9a-f]+$" out
 '
 
-check_describe "A-*[0-9a-f]" --dirty
+check_describe "A-8-gHASH" --dirty
 
 test_expect_success 'describe --dirty with --work-tree' '
 	(
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+$" out
+	grep -E "^A-8-g[0-9a-f]+$" out
 '
 
 test_expect_success 'set-up dirty work tree' '
@@ -189,7 +187,7 @@ test_expect_success 'describe --dirty with --work-tree (dirty)' '
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+-dirty$" out &&
+	grep -E "^A-8-g[0-9a-f]+-dirty$" out &&
 	test_cmp expected out
 '
 
@@ -199,7 +197,7 @@ test_expect_success 'describe --dirty=.mod with --work-tree (dirty)' '
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty=.mod >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+.mod$" out &&
+	grep -E "^A-8-g[0-9a-f]+.mod$" out &&
 	test_cmp expected out
 '
 
@@ -223,21 +221,21 @@ test_expect_success 'set-up matching pattern tests' '
 
 '
 
-check_describe "test-annotated-*" --match="test-*"
+check_describe "test-annotated-3-gHASH" --match="test-*"
 
-check_describe "test1-lightweight-*" --tags --match="test1-*"
+check_describe "test1-lightweight-2-gHASH" --tags --match="test1-*"
 
-check_describe "test2-lightweight-*" --tags --match="test2-*"
+check_describe "test2-lightweight-1-gHASH" --tags --match="test2-*"
 
-check_describe "test2-lightweight-*" --long --tags --match="test2-*" HEAD^
+check_describe "test2-lightweight-0-gHASH" --long --tags --match="test2-*" HEAD^
 
-check_describe "test2-lightweight-*" --long --tags --match="test1-*" --match="test2-*" HEAD^
+check_describe "test2-lightweight-0-gHASH" --long --tags --match="test1-*" --match="test2-*" HEAD^
 
-check_describe "test2-lightweight-*" --long --tags --match="test1-*" --no-match --match="test2-*" HEAD^
+check_describe "test2-lightweight-0-gHASH" --long --tags --match="test1-*" --no-match --match="test2-*" HEAD^
 
-check_describe "test1-lightweight-*" --long --tags --match="test1-*" --match="test3-*" HEAD
+check_describe "test1-lightweight-2-gHASH" --long --tags --match="test1-*" --match="test3-*" HEAD
 
-check_describe "test1-lightweight-*" --long --tags --match="test3-*" --match="test1-*" HEAD
+check_describe "test1-lightweight-2-gHASH" --long --tags --match="test3-*" --match="test1-*" HEAD
 
 test_expect_success 'set-up branches' '
 	git branch branch_A A &&
@@ -247,11 +245,11 @@ test_expect_success 'set-up branches' '
 	git update-ref refs/original/original_branch_A test-annotated~2
 '
 
-check_describe "heads/branch_A*" --all --match="branch_*" --exclude="branch_C" HEAD
+check_describe "heads/branch_A-11-gHASH" --all --match="branch_*" --exclude="branch_C" HEAD
 
-check_describe "remotes/origin/remote_branch_A*" --all --match="origin/remote_branch_*" --exclude="origin/remote_branch_C" HEAD
+check_describe "remotes/origin/remote_branch_A-11-gHASH" --all --match="origin/remote_branch_*" --exclude="origin/remote_branch_C" HEAD
 
-check_describe "original/original_branch_A*" --all test-annotated~1
+check_describe "original/original_branch_A-6-gHASH" --all test-annotated~1
 
 test_expect_success '--match does not work for other types' '
 	test_must_fail git describe --all --match="*original_branch_*" test-annotated~1
@@ -521,7 +519,7 @@ test_expect_success 'describe commits with disjoint bases' '
 		git tag B -a -m B &&
 		git merge --no-ff --allow-unrelated-histories main -m x &&
 
-		check_describe "A-3-*" HEAD
+		check_describe "A-3-gHASH" HEAD
 	)
 '
 
@@ -547,7 +545,7 @@ test_expect_success 'describe commits with disjoint bases 2' '
 		git tag B -a -m B &&
 		git merge --no-ff --allow-unrelated-histories main -m x &&
 
-		check_describe "B-3-*" HEAD
+		check_describe "B-3-gHASH" HEAD
 	)
 '
 
-- 
2.31.0.rc0.116.g45ec00aa00

