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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B2C43460
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46936144B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbhDUO7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243748AbhDUO7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:59:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C12C06138B
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d200-20020a1c1dd10000b02901384767d4a5so1462937wmd.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a1a5Sw4kknoAv7zzJUvHLJsCwqLqdiICbS6UhWYFhFw=;
        b=UKu5nPWD85DWonILPwpUinvibccC92LlRvAEKVEDZVebfI0xZRGs+mIkQQ4Dj4nhQc
         Tc4ONk56BI2O91mMeAsI6ExGG8f7yUB26qdtJGPC1nngwXUsoVuM71p2OuS8+Vk3lVLO
         QZL46j+TRztBp4LJd2T2xmYIyntL+8Inj3krqdGdhbzCgJA81Fv+l8HImzs2mLRZC9rg
         yKqlK10aV4Ga9gFnVY4jRYnvXUoUn/EzxDsnzRZmlpJvHRaaBZenKlDVlPoC3XGM5nEg
         /N2rnek7owiiGCYEz8qTyr+If5RIiLkUQjKk46gIgWxVLPgMeOFBitY06VZwO2b0uNmc
         t0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a1a5Sw4kknoAv7zzJUvHLJsCwqLqdiICbS6UhWYFhFw=;
        b=l2Th1/3HoqB3pbg4N+lkH4Nwj7dYr1GUdTXlJxIy38SSGBKimgpN8ZE4UJfQXPWNiQ
         AjSlU9vaQm2iud665sAJJgf5HyoY0nhrZVfAoLeRLPKZOQx5/iovchbbyr3XGD9yKOPi
         8sbBc9ChEtrVBUoUgvDBHiusrZRkU/yt5Im4HzCskJqVECiutNPwN57SlqlHfdP084ta
         h3itaKk2VQ/nSx1DigHNzbTrNj/gy8190M06PvkH82W8cGUYphAnt2xcuSvW7uSnu/ba
         ELX2QvNpvlYgnI7BNDi+AHF13esQAST8lqRXqOE824f794NJfkHabAEhl36LlcqbY8qq
         WsbA==
X-Gm-Message-State: AOAM532XOmz5uAcjNjLJ9ugALH26QcmlxJjSkFr+q8YMqbhyQEDCMPzd
        2DMEX39KXK/DPPoM7NRAfr9uNasT1lnkjQ==
X-Google-Smtp-Source: ABdhPJxyYDDBuAxuDHqFGDU4yJLuIbWiNO9VExk1WPBp8PleX9g+FkajOUMMpyYogStreHJKNgO1Og==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr9994587wmi.124.1619017125424;
        Wed, 21 Apr 2021 07:58:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm3394316wrd.69.2021.04.21.07.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:58:44 -0700 (PDT)
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
Subject: [PATCH v2 5/5] test-helpers: split "file-size" into "file-size(s)"
Date:   Wed, 21 Apr 2021 16:58:38 +0200
Message-Id: <patch-5.5-947791d9535-20210421T144921Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.g9a7f2f961d4
In-Reply-To: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com> <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
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
index af7d7fd5454..23970db8183 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -272,6 +272,8 @@ static int protect_ntfs_hfs_benchmark(int argc, const char **argv)
 
 int cmd__path_utils(int argc, const char **argv)
 {
+	int is_file_size, is_file_sizes;
+
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
 		char *buf = xmallocz(strlen(argv[2]));
 		int rv = normalize_path_copy(buf, argv[2]);
@@ -387,10 +389,17 @@ int cmd__path_utils(int argc, const char **argv)
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
index f8f5bf9de1e..20d1f94fd97 100644
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
2.31.1.721.gbeb6a21927

