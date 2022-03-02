Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B040C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbiCBR2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbiCBR2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:30 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2956DDF44
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y5so1629495wmi.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SY529CcRIlVbl/C3sDDkM+YleIbXQRB7rOTOXmu7aU=;
        b=qNjADGxx++BNisxLo9mB/QJB6Ba6OAvVM0ZZI34xlQkfyKKOu0e+GM30evhneVxFNg
         7WcAgh5fAPKvin5gh1nFAfPATBEx5IKC4TpjZfkkKaFtS/EmA96LmWt7YC2OTx8cPOJz
         d63dwI3r2ZTVSHyrCgc9BM+zm41v7tOwMvHhe8LYq+B/kNJ2PvNBBM0eiTtw85+xEFtk
         s+h4ZyRdtn0J1qzabz3pabYgajyfeRG+6hkJ3avBc6dVbPCqom7rNo89E3tWYKexB4xB
         9C5rZVDNWNiGYEhvK1YIES9ilIy9z1h/xPmmNfFLsbQL6kiGylASAACeDdnIlSYEuA/0
         edbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SY529CcRIlVbl/C3sDDkM+YleIbXQRB7rOTOXmu7aU=;
        b=fDlk35rERZnKioaCiSQdlRxtDrputG7RQJgXgjLDkTJHkGnoyRmdtCJAPgpraYsnVy
         DqkOHGH9HdeXIU73ZRVmX7aV0kzSN0UJiAEoZZQOSvyx4U33Q++jhUotEMyyg5uFFHAO
         3QXPupF+/vx0y+pIscVX06adJpWdhUWcmOaPTmeaGC2+mp59X8weVlVf7fgw8oGory1G
         FAxtvnjZDCaQxUII1sfsndip/8eJ8z4TPHIk9zzo2zMiMWngYP7UoMIIncKlzwF9KxcI
         pxHwAIL4j+/nAPcoaiTObZQcj8G6i3wF0EdR2kyojJBW/sz1YNjRMOiMTGdJAzvZy5tX
         ZnvQ==
X-Gm-Message-State: AOAM533e6T9JGpsU9LTbjUo6MQioxLojkN7AOmmc1bS4sSx06sltqZrF
        UeQvm1pigvRmYF0jiNTffqfTebLlo2Fv7A==
X-Google-Smtp-Source: ABdhPJw922095Z0mHiQblhmUQO5Twh86teB7QGzcmpkOec9Tg74KHlspNYoESEqBQoaQsNWaysoFMw==
X-Received: by 2002:a05:600c:5014:b0:381:6829:96bd with SMTP id n20-20020a05600c501400b00381682996bdmr661524wmr.123.1646242051063;
        Wed, 02 Mar 2022 09:27:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/15] tests: change some 'test $(git) = "x"' to test_cmp
Date:   Wed,  2 Mar 2022 18:27:10 +0100
Message-Id: <patch-01.15-78b9c52551f-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change some of the patterns in the test suite where we were hiding the
exit code from "git" by invoking it in a sub-shell within a "test"
expression to use temporary files and test_cmp instead.

These are not all the occurrences of this anti-pattern, but these in
particular hid issues where LSAN was dying, and I'd thus marked these
tests as passing under the linux-leaks CI job in past commits with
"TEST_PASSES_SANITIZE_LEAK=true". Let's deal with that by either
removing that marking, or skipping specific tests under
!SANITIZE_LEAK.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0002-gitfile.sh    |  6 ++++--
 t/t2200-add-update.sh | 33 +++++++++++++++++++++------------
 t/t4128-apply-root.sh | 33 ++++++++++++++++++++-------------
 t/t7103-reset-bare.sh |  7 +++++--
 4 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 76052cb5620..f6356db183b 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -65,9 +65,11 @@ test_expect_success 'check commit-tree' '
 	test_path_is_file "$REAL/objects/$(objpath $SHA)"
 '
 
-test_expect_success 'check rev-list' '
+test_expect_success !SANITIZE_LEAK 'check rev-list' '
 	git update-ref "HEAD" "$SHA" &&
-	test "$SHA" = "$(git rev-list HEAD)"
+	git rev-list HEAD >actual &&
+	echo $SHA >expected &&
+	test_cmp expected actual
 '
 
 test_expect_success 'setup_git_dir twice in subdir' '
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index acd3650d3c0..0c38f8e3569 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -14,7 +14,6 @@ only the updates to dir/sub.
 Also tested are "git add -u" without limiting, and "git add -u"
 without contents changes, and other conditions'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
@@ -41,20 +40,28 @@ test_expect_success update '
 '
 
 test_expect_success 'update noticed a removal' '
-	test "$(git ls-files dir1/sub1)" = ""
+	git ls-files dir1/sub1 >out &&
+	test_must_be_empty out
 '
 
 test_expect_success 'update touched correct path' '
-	test "$(git diff-files --name-status dir2/sub3)" = ""
+	git diff-files --name-status dir2/sub3 >out &&
+	test_must_be_empty out
 '
 
 test_expect_success 'update did not touch other tracked files' '
-	test "$(git diff-files --name-status check)" = "M	check" &&
-	test "$(git diff-files --name-status top)" = "M	top"
+	echo "M	check" >expect &&
+	git diff-files --name-status check >actual &&
+	test_cmp expect actual &&
+
+	echo "M	top" >expect &&
+	git diff-files --name-status top >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'update did not touch untracked files' '
-	test "$(git ls-files dir2/other)" = ""
+	git ls-files dir2/other >out &&
+	test_must_be_empty out
 '
 
 test_expect_success 'cache tree has not been corrupted' '
@@ -76,9 +83,8 @@ test_expect_success 'update from a subdirectory' '
 '
 
 test_expect_success 'change gets noticed' '
-
-	test "$(git diff-files --name-status dir1)" = ""
-
+	git diff-files --name-status dir1 >out &&
+	test_must_be_empty out
 '
 
 test_expect_success 'non-qualified update in subdir updates from the root' '
@@ -103,7 +109,8 @@ test_expect_success 'replace a file with a symlink' '
 test_expect_success 'add everything changed' '
 
 	git add -u &&
-	test -z "$(git diff-files)"
+	git diff-files >out &&
+	test_must_be_empty out
 
 '
 
@@ -111,7 +118,8 @@ test_expect_success 'touch and then add -u' '
 
 	touch check &&
 	git add -u &&
-	test -z "$(git diff-files)"
+	git diff-files >out &&
+	test_must_be_empty out
 
 '
 
@@ -119,7 +127,8 @@ test_expect_success 'touch and then add explicitly' '
 
 	touch check &&
 	git add check &&
-	test -z "$(git diff-files)"
+	git diff-files >out &&
+	test_must_be_empty out
 
 '
 
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index cb3181e8b71..ba89a2f2d73 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -2,8 +2,6 @@
 
 test_description='apply same filename'
 
-
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
@@ -26,10 +24,11 @@ diff a/bla/blub/dir/file b/bla/blub/dir/file
 EOF
 
 test_expect_success 'apply --directory -p (1)' '
-
 	git apply --directory=some/sub -p3 --index patch &&
-	test Bello = $(git show :some/sub/dir/file) &&
-	test Bello = $(cat some/sub/dir/file)
+	echo Bello >expect &&
+	git show :some/sub/dir/file >actual &&
+	test_cmp expect actual &&
+	test_cmp expect some/sub/dir/file
 
 '
 
@@ -37,8 +36,10 @@ test_expect_success 'apply --directory -p (2) ' '
 
 	git reset --hard initial &&
 	git apply --directory=some/sub/ -p3 --index patch &&
-	test Bello = $(git show :some/sub/dir/file) &&
-	test Bello = $(cat some/sub/dir/file)
+	echo Bello >expect &&
+	git show :some/sub/dir/file >actual &&
+	test_cmp expect actual &&
+	test_cmp expect some/sub/dir/file
 
 '
 
@@ -55,8 +56,10 @@ EOF
 test_expect_success 'apply --directory (new file)' '
 	git reset --hard initial &&
 	git apply --directory=some/sub/dir/ --index patch &&
-	test content = $(git show :some/sub/dir/newfile) &&
-	test content = $(cat some/sub/dir/newfile)
+	echo content >expect &&
+	git show :some/sub/dir/newfile >actual &&
+	test_cmp expect actual &&
+	test_cmp expect some/sub/dir/newfile
 '
 
 cat > patch << EOF
@@ -72,8 +75,10 @@ EOF
 test_expect_success 'apply --directory -p (new file)' '
 	git reset --hard initial &&
 	git apply -p2 --directory=some/sub/dir/ --index patch &&
-	test content = $(git show :some/sub/dir/newfile2) &&
-	test content = $(cat some/sub/dir/newfile2)
+	echo content >expect &&
+	git show :some/sub/dir/newfile2 >actual &&
+	test_cmp expect actual &&
+	test_cmp expect some/sub/dir/newfile2
 '
 
 cat > patch << EOF
@@ -107,8 +112,10 @@ EOF
 test_expect_success 'apply --directory (quoted filename)' '
 	git reset --hard initial &&
 	git apply --directory=some/sub/dir/ --index patch &&
-	test content = $(git show :some/sub/dir/quotefile) &&
-	test content = $(cat some/sub/dir/quotefile)
+	echo content >expect &&
+	git show :some/sub/dir/quotefile >actual &&
+	test_cmp expect actual &&
+	test_cmp expect some/sub/dir/quotefile
 '
 
 test_done
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index 0de83e36199..a60153f9f32 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -63,9 +63,12 @@ test_expect_success '"mixed" reset is not allowed in bare' '
 	test_must_fail git reset --mixed HEAD^
 '
 
-test_expect_success '"soft" reset is allowed in bare' '
+test_expect_success !SANITIZE_LEAK '"soft" reset is allowed in bare' '
 	git reset --soft HEAD^ &&
-	test "$(git show --pretty=format:%s | head -n 1)" = "one"
+	git show --pretty=format:%s >out &&
+	echo one >expect &&
+	head -n 1 out >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.35.1.1226.g8b497615d32

