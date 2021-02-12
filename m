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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8AEC433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7979764E57
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhBLNb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhBLNbV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E3C0617A7
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o15so935807wmq.5
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VnWW199AprC0wjRueEOqHkPQqtSdB2+blXIFBFGrPk=;
        b=sLSpkNn1a57D0rHdMo2ey3AK8BCQMRIHt3mfJyBCFaD/nnXpoMt478rPh9rU04CnRR
         32r7zFUjmMKXmnHbUBY1CH7m9n6bPrQjbKIaQas+1o5QyOEZ0GLQKlO1DD/gluPIX7B8
         gW1xaCHoTZN0YHuRJrSgJ9ZQjtzEdCbP+5pSE9oKMu9ZPmpezdKECD7suvQmuTnCY5Qs
         V/CSkMbrmiCkrk8nPapFsKtqDUyaIT+j8WD0rqjq+Avzte4d3wDsGyovfeneIBHKm656
         hM+rig6nPnl8yLv94JhwjGSzpt+IvxZ8qLmTEuCUNkZdjbIf3FgYBEcJZGY7qHS5u4mh
         ZEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VnWW199AprC0wjRueEOqHkPQqtSdB2+blXIFBFGrPk=;
        b=nLfzg6ESwDhBqNvxA58JHvr+OpC/+XuS9THQhO2nEzvuXzhNGgopnwER4p2zyHdx12
         YRrfH4M/muiSuDFauJDsZsBO7wWc8+TloC6Js8wWZh+Whau1X/94CoJ3f3O5OW5VbQnE
         sJVPIEV6iSKh6+onwqmJX+FAeOdSuKFoxkTpbM76wLJ7HBD3z4a3grTItVwTZZQwnP4/
         om19YVsAio1By24HITtGsTKW1JPAbh/r8o4WfueH3FMnmRUZqEKcZ20EkEcqVaDBkT8c
         B5qBXA5CdpLtipkO7ZNdzEG867HriDMHt+ULpauF7VOBXPiu5FJxii4d1OAyimGR8uTu
         WhAA==
X-Gm-Message-State: AOAM533WGwvAFLbtAMHA9qO8iV/vA3LmfswUaJFDE0n0KKnfudS/Vln9
        VxKTuYA8kQc9ytvMUwCK0MnTgKKV8/5WHw==
X-Google-Smtp-Source: ABdhPJw8Q5oHpjrbZT8+pRMEDfgNIV/ibjq2SJkeLTV8QxnOLmt83Fr1VW9V+kShe7IkgzLDmTVbpg==
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr216248wmq.72.1613136600861;
        Fri, 12 Feb 2021 05:30:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:30:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/11] test-lib-functions: move function to lib-bitmap.sh
Date:   Fri, 12 Feb 2021 14:29:38 +0100
Message-Id: <20210212132942.17325-8-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move a function added to test-lib-functions.sh in ea047a8eb4f (t5310:
factor out bitmap traversal comparison, 2020-02-14) into a new
lib-bitmap.sh.

The test-lib-functions.sh file should be for functions that are widely
used across the test suite, if something's only used by a few tests it
makes more sense to have it in a lib-*.sh file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-bitmap.sh                    | 26 ++++++++++++++++++++++++++
 t/t5310-pack-bitmaps.sh            |  2 ++
 t/t6113-rev-list-bitmap-filters.sh |  1 +
 t/test-lib-functions.sh            | 27 ---------------------------
 4 files changed, 29 insertions(+), 27 deletions(-)
 create mode 100644 t/lib-bitmap.sh

diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
new file mode 100644
index 00000000000..fe3f98be24f
--- /dev/null
+++ b/t/lib-bitmap.sh
@@ -0,0 +1,26 @@
+# Compare a file containing rev-list bitmap traversal output to its non-bitmap
+# counterpart. You can't just use test_cmp for this, because the two produce
+# subtly different output:
+#
+#   - regular output is in traversal order, whereas bitmap is split by type,
+#     with non-packed objects at the end
+#
+#   - regular output has a space and the pathname appended to non-commit
+#     objects; bitmap output omits this
+#
+# This function normalizes and compares the two. The second file should
+# always be the bitmap output.
+test_bitmap_traversal () {
+	if test "$1" = "--no-confirm-bitmaps"
+	then
+		shift
+	elif cmp "$1" "$2"
+	then
+		echo >&2 "identical raw outputs; are you sure bitmaps were used?"
+		return 1
+	fi &&
+	cut -d' ' -f1 "$1" | sort >"$1.normalized" &&
+	sort "$2" >"$2.normalized" &&
+	test_cmp "$1.normalized" "$2.normalized" &&
+	rm -f "$1.normalized" "$2.normalized"
+}
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 5ba76031090..40b9f632441 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -5,6 +5,8 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-bundle.sh
+. "$TEST_DIRECTORY"/lib-bitmap.sh
 
 objpath () {
 	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
index 2b551e6fd0c..3f889949ca1 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -2,6 +2,7 @@
 
 test_description='rev-list combining bitmaps and filters'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-bitmap.sh
 
 test_expect_success 'set up bitmapped repo' '
 	# one commit will have bitmaps, the other will not
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 71d4e806f6d..473d2e283e6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1593,33 +1593,6 @@ test_set_port () {
 	eval $var=$port
 }
 
-# Compare a file containing rev-list bitmap traversal output to its non-bitmap
-# counterpart. You can't just use test_cmp for this, because the two produce
-# subtly different output:
-#
-#   - regular output is in traversal order, whereas bitmap is split by type,
-#     with non-packed objects at the end
-#
-#   - regular output has a space and the pathname appended to non-commit
-#     objects; bitmap output omits this
-#
-# This function normalizes and compares the two. The second file should
-# always be the bitmap output.
-test_bitmap_traversal () {
-	if test "$1" = "--no-confirm-bitmaps"
-	then
-		shift
-	elif cmp "$1" "$2"
-	then
-		echo >&2 "identical raw outputs; are you sure bitmaps were used?"
-		return 1
-	fi &&
-	cut -d' ' -f1 "$1" | sort >"$1.normalized" &&
-	sort "$2" >"$2.normalized" &&
-	test_cmp "$1.normalized" "$2.normalized" &&
-	rm -f "$1.normalized" "$2.normalized"
-}
-
 # Tests for the hidden file attribute on Windows
 test_path_is_hidden () {
 	test_have_prereq MINGW ||
-- 
2.30.0.284.gd98b1dd5eaa7

