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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102BEC43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E606660FF1
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhDLLWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbhDLLWR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB6FC06138C
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:21:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f12so12561598wro.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqxcifFKVUW1bv/7lpqZYYaJqb1/kFxeL0jjw3GJ1q8=;
        b=FPzd/nmSdN52fdHLZTIT4FScD5Cs/d9A7LyClU9jfwHnMqMzQyjesKG5rSAvdCaeM4
         nN6+TOW6GJhd63Z9/+UAdUaORsaXu+GUL8PzeuRUUpVrjqCq0EbqNxILfasOHFq1wnUl
         6b3yPdTgQkLMJde/nkDP2iiEOGQ7Zrsj7ry2j5+wP5dIaz56r+1kcqDYmU8DAZNKAvDi
         hNOkW6pFtgfOqxUJPyw7QXi25U7d5zXID0nHiMFD5hF6oKkZ7mN+JcHhbCfNXV8QgK8Y
         iwA6bEcr9NnHnI1pALLCAzZiE7ktF5xOGPKdE0bS185J8oBNRJVGJD0VR+6PNEfpzwSx
         IQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqxcifFKVUW1bv/7lpqZYYaJqb1/kFxeL0jjw3GJ1q8=;
        b=jvYjxZt7TuQqdFqAmbts4wrgdM45lGQYPRcDoPbis1hjDmFjlo4n/EN1h1gG9wwO01
         8UMVoIPUbltAP7d5R3HMmabEQFO+3qijfl9kGPVIQ0hOEey5pTaYl2b3G+wsQcguhKEN
         WMZ+jUeRvdrH8jXq6W/wKXbGjhGtYAZMbBAtWu9Xbf9sE+Jx2I2aHz4U6DfaFZx/N215
         eF6/jvzp0Qbfz4JQm8eGVypMueLloF2X80o4dZmLcif9rSsV377NRWPjv7Wf51qHn7Q3
         Q/C2Y0AcbRnZ69liV38/XZAfLO2P95xIn8eNkZfZ69VNRiE9vtaT07FdlkATpVlGSJ3E
         NGkQ==
X-Gm-Message-State: AOAM530P1nGJ2IwikM1hpse++VHBkB/pkPXGDmZxrw+CF1QOHADvmQCn
        8rBWMq/qmlZssncIF+hR3ULRKyORW2lZTw==
X-Google-Smtp-Source: ABdhPJyfjrTJj0lDqrXITQmFiluwUTgZQlHiIPJYcdRz+gVeiSnNVejlJoHC7wpmByb7YbudOKLkLw==
X-Received: by 2002:a05:6000:1789:: with SMTP id e9mr31174083wrg.237.1618226518045;
        Mon, 12 Apr 2021 04:21:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v185sm14580907wmb.25.2021.04.12.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:21:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] describe tests: refactor away from glob matching
Date:   Mon, 12 Apr 2021 13:21:44 +0200
Message-Id: <patch-2.5-b428f468d68-20210412T111601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
References: <20210228195414.21372-1-avarab@gmail.com> <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
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
index a83ea15faaf..13117bbcfb7 100755
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
+		echo "$expect" >expect &&
+		test_cmp expect actual
 	'
 }
 
@@ -59,29 +57,29 @@ test_expect_success setup '
 	test_commit --no-tag x file
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
@@ -102,7 +100,7 @@ test_expect_success 'rename tag A to Q locally' '
 cat - >err.expect <<EOF
 warning: tag 'Q' is externally known as 'A'
 EOF
-check_describe A-* HEAD
+check_describe A-8-gHASH HEAD
 test_expect_success 'warning was displayed for Q' '
 	test_cmp err.expect err.actual
 '
@@ -129,22 +127,22 @@ test_expect_success 'rename tag Q back to A' '
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
@@ -157,7 +155,7 @@ test_expect_success 'describe --dirty with --work-tree (dirty)' '
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+-dirty$" out &&
+	grep -E "^A-8-g[0-9a-f]+-dirty$" out &&
 	test_cmp expected out
 '
 
@@ -167,7 +165,7 @@ test_expect_success 'describe --dirty=.mod with --work-tree (dirty)' '
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty=.mod >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+.mod$" out &&
+	grep -E "^A-8-g[0-9a-f]+.mod$" out &&
 	test_cmp expected out
 '
 
@@ -191,21 +189,21 @@ test_expect_success 'set-up matching pattern tests' '
 
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
@@ -215,11 +213,11 @@ test_expect_success 'set-up branches' '
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
@@ -489,7 +487,7 @@ test_expect_success 'describe commits with disjoint bases' '
 		git tag B -a -m B &&
 		git merge --no-ff --allow-unrelated-histories main -m x &&
 
-		check_describe "A-3-*" HEAD
+		check_describe "A-3-gHASH" HEAD
 	)
 '
 
@@ -515,7 +513,7 @@ test_expect_success 'describe commits with disjoint bases 2' '
 		git tag B -a -m B &&
 		git merge --no-ff --allow-unrelated-histories main -m x &&
 
-		check_describe "B-3-*" HEAD
+		check_describe "B-3-gHASH" HEAD
 	)
 '
 
-- 
2.31.1.634.gb41287a30b0

