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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82682C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C0E64E53
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhBIXIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbhBIWas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:30:48 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B14C03C050
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id z6so23767158wrq.10
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvzUi5LvKKiUtR6NZ9Pv0F+D2nk5vWxpoheMR1k8Atw=;
        b=q+mz+j3MVpxYWwVAi78mCWufjbMlXfx2S/OYyT5I6keXkwXRLRRRExsas8DRjhNHuL
         ack3O72eBp/P6IB0LzqXnOHVD9O3yi2aI4pZeYudKsW/u2Kdk7fhyVk+h4HBQtm78wtb
         leI0s/ANkvFoZPYaR0rhL01TizThjk4TJViPFUQyZN63EWm4GpG4Ph7HTpGE3dNMYTwd
         X+HJ1WxD8ez4myd1VBmFFnuzXGE0N4M2hHQ781g+PjcXwoN53vTPqO+6bh6mbt35gv5k
         gsDxP1Kq7kF4+/HUWMccIqLdpvIQE40S3oi2ffe74AaSwMHyVlTYbUKcgDQ8AOWqsu3I
         kCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvzUi5LvKKiUtR6NZ9Pv0F+D2nk5vWxpoheMR1k8Atw=;
        b=rRi7L5LAN4M7AE+BQxhSr8xiEVZQ0bqhjLxqDYSEvao8K0s4ukiOciSPmZGLfpo+ld
         VfQbr6TT8mkLXcP+thPAiijS9XvV3Q0AI2fKQ6DSkSQGAN1ogECO2/EWPBAglmkjJq5J
         +sD7/YumXzLuRImTnDWCDKLbSGLrgp5ktt5atFM2Lmt87qnJrdqGy8rsS+dVuConsTx1
         XXsLeMUE/jQo9fV3jV0uplJX4VPCsTCZTKw8Z91vKv66OqzsZexwwoGiEaMKQLFYhBan
         5k4/CKF2eFZ5XxHeUpau7hGj/wnxZ93pFq4uDR6w+5SeYxp5bxJDY4doYK4IENeMIztu
         J+3A==
X-Gm-Message-State: AOAM533Iybd3w1EYWDfxyGb7h9hFzAG5hh4rm83WaeRhY3HmvDZ1loqh
        M//NkUeE7gwm6qe/qtDXUtXL51MdZtUjAA==
X-Google-Smtp-Source: ABdhPJwwmJjAwnSBw3U4KGYfW5TXXeVaQL9W6+H44fcU0p/q1QdhEpampi5/Z4cvlSGIvCQ8MQH06Q==
X-Received: by 2002:a5d:4287:: with SMTP id k7mr101110wrq.317.1612906939446;
        Tue, 09 Feb 2021 13:42:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/12] test-lib-functions: move function to lib-bitmap.sh
Date:   Tue,  9 Feb 2021 22:41:54 +0100
Message-Id: <20210209214159.22815-8-avarab@gmail.com>
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
index 55d58b4a6ac..f228647c2b8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1602,33 +1602,6 @@ test_set_port () {
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

