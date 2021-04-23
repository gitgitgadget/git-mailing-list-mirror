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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED34AC43460
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C336961404
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbhDWHab (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:30:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC27C06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:29:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s7so47218816wru.6
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fa+MYlH0vijaOejvZrpDMGOn7QoM9c8+JLlQz8lqplk=;
        b=RSR06H0l6JVwUiiI1AgMcHAk+CB9k3H8Rl9eRpcFr0TiqFMR12PAF+cSklP43jk5DG
         8XflCF1e6HGhgF0Aij/l07PKEVcmjTbNdqt1ijSCtIAAvZNKKzBOUiFKd0tkctI5boUt
         qBPyRBm7bb9ZM92e6rM7Kk+klgD0XwJJzWhDXZ6WTe+9liHBoQD4n7zBtRCoQ0DI2Aga
         HDl+rwRUZxxC+M4CQhzsJkT6kxhM+nB/IfpyLXss3HoN6oucj1CIo65nClwA1rfCL4EX
         5eGaXoyDH2d094vIww1SunLhKJYYf/xh7kWNXGwYf5cflJTyUeNi8+eol3r1PO20/njH
         Akqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fa+MYlH0vijaOejvZrpDMGOn7QoM9c8+JLlQz8lqplk=;
        b=DHmhsA+Jfroy+ePHYq4neWZTXZZx5YBE+VR9xhNgH0OXbxTL6DwaujjEW9ZX78VYr6
         DlUYrzOO1uTl2C0zzapdycF/0e+zM6UWtKBX2jWSmSbZm2UqkLNrLkNMC1+nD8iM2X1w
         M3+/83DzBaXbQnlimg3rpGCvQvwH1IdGWkbKHXA8o0VUWfuV/zZYrzFS7ygMFCH9ITxy
         uhbPWzIhk0x235rFPokM1srz2wVfFtmR31ldzoSLdwppifJuZUwbRtMOXz6UQG8hmZao
         8KlaY/QgQm9WMOZoppd85dYXeqZBHWvZwLOVkReOXHyR2UIo+7VP7APNpPKOId4bGeJk
         Rviw==
X-Gm-Message-State: AOAM532COyuFVXU90sWHNZHZ8wlabGXfOw79sq4fiv/rlDOkhlnQf6/J
        MPbkjMn29V4ihqhZCYdBiWrTGQMK33S3MA==
X-Google-Smtp-Source: ABdhPJznIBjFQ+Un857fL5xRrJcbNbdFnDf/WXhhNYcaLmBC5utEv0dPErR+jy6+oUmQSXKPR26CWg==
X-Received: by 2002:a5d:4405:: with SMTP id z5mr2872388wrq.313.1619162992073;
        Fri, 23 Apr 2021 00:29:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r19sm8681648wmq.33.2021.04.23.00.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:29:51 -0700 (PDT)
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
Subject: [PATCH v3 4/4] test-helpers: split "file-size" into "file-size(s)"
Date:   Fri, 23 Apr 2021 09:29:46 +0200
Message-Id: <patch-4.4-ac0b920c041-20210423T072824Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.734.gdef39492517
In-Reply-To: <cover-0.4-00000000000-20210423T072824Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com> <cover-0.4-00000000000-20210423T072824Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split the "file-size" helper into two helpers, one that takes 1
argument, and another one that takes N.

This allows us to remove the "BUG" check in test-lib-functions.sh for
briefer -x output, and more importantly will clearly distinguish those
cases where we expect one argument v.s. many.

The use in t1050-large.sh wants to check just one pack, we used to
check that explicitly before 53b67a801bb (tests: consolidate the
`file_size` function into `test-lib-functions.sh`, 2020-11-07), now we
do so again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-path-utils.c  | 11 ++++++++++-
 t/t1050-large.sh            |  2 +-
 t/t5319-multi-pack-index.sh |  6 +++---
 t/test-lib-functions.sh     |  3 +--
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index eed3068ffb7..17645da4a1c 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -280,6 +280,8 @@ static int protect_ntfs_hfs_benchmark(int argc, const char **argv)
 
 int cmd__path_utils(int argc, const char **argv)
 {
+	int is_file_size, is_file_sizes;
+
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
 		char *buf = xmallocz(strlen(argv[2]));
 		int rv = normalize_path_copy(buf, argv[2]);
@@ -395,10 +397,17 @@ int cmd__path_utils(int argc, const char **argv)
 		return !!res;
 	}
 
-	if (argc > 2 && !strcmp(argv[1], "file-size")) {
+	is_file_size = !strcmp(argv[1], "file-size");
+	is_file_sizes = !strcmp(argv[1], "file-sizes");
+	if (argc > 2 && (is_file_size || is_file_sizes)) {
 		int res = 0, i;
 		struct stat st;
 
+		if (is_file_size && argc > 3) {
+			res = error("too many arguments to is-file-size, use is-file-sizes?");
+			return res;
+		}
+
 		for (i = 2; i < argc; i++)
 			if (stat(argv[i], &st))
 				res = error_errno("Cannot stat '%s'", argv[i]);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 4bab6a513c5..0b76ab0e3f9 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -23,7 +23,7 @@ do
 	test_expect_success "add with $config" '
 		test_when_finished "rm -f .git/objects/pack/pack-*.* .git/index" &&
 		git $config add large1 &&
-		sz=$(test_file_size .git/objects/pack/pack-*.pack) &&
+		sz=$(test-tool path-utils file-size .git/objects/pack/pack-*.pack) &&
 		case "$expect" in
 		small) test "$sz" -le 100000 ;;
 		large) test "$sz" -ge 100000 ;;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 5641d158dfc..baeda407b90 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -648,7 +648,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
 		test-tool chmtime =-3 .git/objects/pack/pack-B* &&
 		test-tool chmtime =-2 .git/objects/pack/pack-A* &&
 		ls .git/objects/pack >expect &&
-		MINSIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 1) &&
+		MINSIZE=$(test-tool path-utils file-sizes .git/objects/pack/*pack | sort -n | head -n 1) &&
 		git multi-pack-index repack --batch-size=$MINSIZE &&
 		ls .git/objects/pack >actual &&
 		test_cmp expect actual
@@ -672,7 +672,7 @@ test_expect_success 'repack respects repack.packKeptObjects=false' '
 		test_line_count = 5 idx-list &&
 		test-tool read-midx .git/objects | grep idx >midx-list &&
 		test_line_count = 5 midx-list &&
-		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | sed -n 3p) &&
+		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-sizes .git/objects/pack/*pack | sort -n | sed -n 3p) &&
 		BATCH_SIZE=$((THIRD_SMALLEST_SIZE + 1)) &&
 		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
 		ls .git/objects/pack/*idx >idx-list &&
@@ -687,7 +687,7 @@ test_expect_success 'repack creates a new pack' '
 		cd dup &&
 		ls .git/objects/pack/*idx >idx-list &&
 		test_line_count = 5 idx-list &&
-		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
+		THIRD_SMALLEST_SIZE=$(test-tool path-utils file-sizes .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
 		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
 		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
 		ls .git/objects/pack/*idx >idx-list &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0adb9fd124d..602d77dee37 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -839,8 +839,7 @@ test_line_count () {
 }
 
 test_file_size () {
-	test "$#" -ne 1 && BUG "1 param"
-	test-tool path-utils file-size "$1"
+	test-tool path-utils file-size "$@"
 }
 
 # Returns success if a comma separated string of keywords ($1) contains a
-- 
2.31.1.734.gdef39492517

