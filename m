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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C05C433E6
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7473564E6C
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhBLNc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhBLNbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7BAC061356
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o10so586213wmc.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfiWh32np2e9DzB2aHYGZAXeDERf88rWYdhcfZ6P3XE=;
        b=H2YwqlQxsWuF1Hr118nHBRAJEZZ4zgm8UQ+MgCUmaWbLK8CNp1CHf7rj5O2kFLTs6r
         N3igs8BxyFybGs7oxDlHvfxq31NBrq8rTdOsUx+iMbgCmVAPIauONN/s05Je366iQwjF
         hd014VWbpRkBWGgdCE1WGQPpAXk8/40UH3Hu/mUK/WFbfRTzscOdDVCgVaiw4SMl2QwA
         MZ6F3DbeUd8oxbKSEssx1YOHQoy55xI+EIBVQBjDiwb+dtiCF32XjzWUy74Cki9abApz
         HPZXfTjkCsoDjkW7lqa/34I99dONHeSbAuUkWkxW/BhVkq9rZg2DCBTILHInKCwkyqG0
         K52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfiWh32np2e9DzB2aHYGZAXeDERf88rWYdhcfZ6P3XE=;
        b=nU7myQGEu9T8dkBWml39SQ8lUuLlklZs3GF9Z8zCGoXJE3W66AooBA7lCKp6daW1Os
         7SajMSfBLAosEy8SnigI7OMXPINAI8Ih7Gl6fOBPe2o4t7fH/qQtnr+yJCwmwTlECCEo
         srgwNkfLCqXeHlKAL5O8fBhM1XgDiRnK5E9m8lq+nSRugB+sgQEhqnxQKKkZMK0vbu3N
         7TCIT6Vi2Nhtt77jlzfCeqLETjCgeEEQ/RplN30RW7XYjN+fFSgNbau44PkT41cGWTiM
         oZHcgap5usXNgyzjxzDct2LyGVFQ98p2ccbhfiitZ42hCd1FF4hA9oAI1AOYYuMUS8vv
         u+/Q==
X-Gm-Message-State: AOAM530zTJrj+7V6qvC17FiK7Rrqz+Nd8/Alnto1dJ9QA/+y4OMW2/Tl
        pAM36U7pz4YHnkufAixqV9WhIlrD5O0JLQ==
X-Google-Smtp-Source: ABdhPJzVuU9HBfikqhZMzB+iJJvx0H7hIbUU91o2io3/45+VHy9LJWZbbOQg6yzDtriCtGXy9mEOpw==
X-Received: by 2002:a05:600c:19c7:: with SMTP id u7mr2669065wmq.122.1613136603559;
        Fri, 12 Feb 2021 05:30:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:30:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/11] test-lib-functions: remove bug-inducing "diagnostics" helper param
Date:   Fri, 12 Feb 2021 14:29:41 +0100
Message-Id: <20210212132942.17325-11-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the optional "diagnostics" parameter of the
test_path_is_{file,dir,missing} functions.

We have a lot of uses of these functions, but the only legitimate use
of the diagnostics parameter is from when the functions themselves
were introduced in 2caf20c52b7 (test-lib: user-friendly alternatives
to test [-d|-f|-e], 2010-08-10).

But as the the rest of this diff demonstrates its presence did more to
silently introduce bugs in our tests. Fix such bugs in the tests added
in ae4e89e549b (gc: add --keep-largest-pack option, 2018-04-15), and
c04ba51739a (t6046: testcases checking whether updates can be skipped
in a merge, 2018-04-19).

Let's also assert that those functions are called with exactly one
parameter, a follow-up commit will add similar asserts to other
functions in test-lib-functions.sh that we didn't have existing misuse
of.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README                               |  8 ++++----
 t/t3404-rebase-interactive.sh          |  3 ++-
 t/t6426-merge-skip-unneeded-updates.sh | 16 ++++++++++++----
 t/t6500-gc.sh                          |  4 ++--
 t/test-lib-functions.sh                | 11 ++++++-----
 5 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/t/README b/t/README
index 1d80fb70041..98d4164a4e6 100644
--- a/t/README
+++ b/t/README
@@ -911,13 +911,13 @@ library for your script to use.
 
    Check whether a file has the length it is expected to.
 
- - test_path_is_file <path> [<diagnosis>]
-   test_path_is_dir <path> [<diagnosis>]
-   test_path_is_missing <path> [<diagnosis>]
+ - test_path_is_file <path>
+   test_path_is_dir <path>
+   test_path_is_missing <path>
 
    Check if the named path is a file, if the named path is a
    directory, or if the named path does not exist, respectively,
-   and fail otherwise, showing the <diagnosis> text.
+   and fail otherwise.
 
  - test_when_finished <script>
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1e738df81d5..28c2d15d807 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -101,7 +101,8 @@ test_expect_success 'rebase -i with the exec command' '
 	) &&
 	test_path_is_file touch-one &&
 	test_path_is_file touch-two &&
-	test_path_is_missing touch-three " (should have stopped before)" &&
+	# Missing because we should have stopped by now.
+	test_path_is_missing touch-three &&
 	test_cmp_rev C HEAD &&
 	git rebase --continue &&
 	test_path_is_file touch-three &&
diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
index d7eeee43106..7b5f1c1dcd1 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -492,7 +492,9 @@ test_expect_success '3a-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 		test_cmp expect actual &&
 
 		test_must_fail git rev-parse HEAD:bq HEAD:foo/bq &&
-		test_path_is_missing bq foo/bq foo/whatever
+		test_path_is_missing bq &&
+		test_path_is_missing foo/bq &&
+		test_path_is_missing foo/whatever
 	)
 '
 
@@ -522,7 +524,9 @@ test_expect_success '3a-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 		test_cmp expect actual &&
 
 		test_must_fail git rev-parse HEAD:bq HEAD:foo/bq &&
-		test_path_is_missing bq foo/bq foo/whatever
+		test_path_is_missing bq &&
+		test_path_is_missing foo/bq &&
+		test_path_is_missing foo/whatever
 	)
 '
 
@@ -588,7 +592,9 @@ test_expect_success '3b-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 		test_cmp expect actual &&
 
 		test_must_fail git rev-parse HEAD:bq HEAD:foo/bq &&
-		test_path_is_missing bq foo/bq foo/whatever
+		test_path_is_missing bq &&
+		test_path_is_missing foo/bq &&
+		test_path_is_missing foo/whatever
 	)
 '
 
@@ -618,7 +624,9 @@ test_expect_success '3b-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 		test_cmp expect actual &&
 
 		test_must_fail git rev-parse HEAD:bq HEAD:foo/bq &&
-		test_path_is_missing bq foo/bq foo/whatever
+		test_path_is_missing bq &&
+		test_path_is_missing foo/bq &&
+		test_path_is_missing foo/whatever
 	)
 '
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 4a3b8f48ac6..7879a6b8c51 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -78,7 +78,7 @@ test_expect_success 'gc --keep-largest-pack' '
 		git gc &&
 		( cd .git/objects/pack && ls *.pack ) >pack-list &&
 		test_line_count = 1 pack-list &&
-		BASE_PACK=.git/objects/pack/pack-*.pack &&
+		cp pack-list base-pack-list &&
 		test_commit four &&
 		git repack -d &&
 		test_commit five &&
@@ -90,7 +90,7 @@ test_expect_success 'gc --keep-largest-pack' '
 		test_line_count = 2 pack-list &&
 		awk "/^P /{print \$2}" <.git/objects/info/packs >pack-info &&
 		test_line_count = 2 pack-info &&
-		test_path_is_file $BASE_PACK &&
+		test_path_is_file .git/objects/pack/$(cat base-pack-list) &&
 		git fsck
 	)
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 473d2e283e6..a5f63c0af6b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -717,12 +717,12 @@ test_external_without_stderr () {
 }
 
 # debugging-friendly alternatives to "test [-f|-d|-e]"
-# The commands test the existence or non-existence of $1. $2 can be
-# given to provide a more precise diagnosis.
+# The commands test the existence or non-existence of $1
 test_path_is_file () {
+	test "$#" -ne 1 && BUG "1 param"
 	if ! test -f "$1"
 	then
-		echo "File $1 doesn't exist. $2"
+		echo "File $1 doesn't exist"
 		false
 	fi
 }
@@ -730,15 +730,16 @@ test_path_is_file () {
 test_path_is_dir () {
 	if ! test -d "$1"
 	then
-		echo "Directory $1 doesn't exist. $2"
+		echo "Directory $1 doesn't exist"
 		false
 	fi
 }
 
 test_path_exists () {
+	test "$#" -ne 1 && BUG "1 param"
 	if ! test -e "$1"
 	then
-		echo "Path $1 doesn't exist. $2"
+		echo "Path $1 doesn't exist"
 		false
 	fi
 }
-- 
2.30.0.284.gd98b1dd5eaa7

