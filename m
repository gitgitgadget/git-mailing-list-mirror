Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A34C64EBC
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E370E246CB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR+LojFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgKRXpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgKRXpC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447C3C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r17so4378693wrw.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p9BgL/b4+AfEWTATU3qPGbxhuMDOy/7UiiQs8OGY5B8=;
        b=UR+LojFJzMWd8tlFszzDYwRMhWzTm2D+9gP/pNSvAGKyP7T7boqVs6QQtwlgHJtZ9d
         OJwxcZZA3EewcJNRA/KmLjSeMLDUC6/NkxXeRFYZDTYqirICmOzxB6T8zM0O1FRJHrmB
         vnhzq8lzluWN47/2yT0io6sK+lKIP4XJ2HPSXHC7DkSmMTQ1puGjUVngKIzM3ZxzDHlD
         U33gA6IdxyUMkF2ME74IDNYMe2gN5rvFzh9rh98W2k1Z19iPOkvMekl/6Jl0DOQN22ai
         PcitiYhfkpBLelQlpRyi/2xCGRxnrS+wG9m6mP4ui3VoQhxnY+WLk0nV4ahM+iLqexUw
         qV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p9BgL/b4+AfEWTATU3qPGbxhuMDOy/7UiiQs8OGY5B8=;
        b=sXyXaF1NUPumcp6vglMm1sViK0wu0BKk2afOzUam748cqrt1DjU+WSOkXxv8Y9NqjE
         RmDZsJKRno2LKnOi0ADD7rtyC+IpRNnqZhV8QHI2umbzVsCyI+iZFv9IvU2ieNFmvjOq
         LCaKXyMuGGtBt02NKp3VWqQpgPSi26tz2c0o3oNEzCcISZi7atEt0eGS0bonzQxdImDz
         ouUdcWtibLnn/rMXs9S9mvMuNfGrkmQQRvWn3eTDr1gusogruQILbytCZ6sZUsGIzddk
         XeGK6Vvf04kSZLjMNhvYI7nhI2gZOs5pfcle67erkwL+cgnethTsRN7U3hbEgMbkPFoc
         8IsQ==
X-Gm-Message-State: AOAM531pDSESXEfX6TajsGXfsHSQiNsHR8K1f2e7omN+XyxvhlGnvJFh
        cjNsvEV8pUa/SaukCzg4m8JTKfxQ4q0=
X-Google-Smtp-Source: ABdhPJxSivPM8YFyX9Plumqps++BcW/z+m8ViLOyehXuF/5QTPT9HDH1sSXf9DXW9O4K3fKwWgkTwA==
X-Received: by 2002:adf:e551:: with SMTP id z17mr7375793wrm.374.1605743099355;
        Wed, 18 Nov 2020 15:44:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n123sm6003401wmn.38.2020.11.18.15.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:58 -0800 (PST)
Message-Id: <0164eb9745d010f04cafa3564bc65f874811d190.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:27 +0000
Subject: [PATCH v3 09/28] t4*: adjust the references to the default branch
 name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Carefully excluding t4013 and t4015, which see independent development
elsewhere at the time of writing, we use `main` as the default branch
name in t4*. This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t4*.sh t4211/*.export &&
	   git checkout HEAD -- t4013\*)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4014-format-patch.sh              | 178 +++++++++++++--------------
 t/t4017-diff-retval.sh               |   4 +-
 t/t4038-diff-combined.sh             |  16 +--
 t/t4041-diff-submodule-option.sh     |   4 +-
 t/t4048-diff-combined-binary.sh      |  12 +-
 t/t4052-stat-output.sh               |   6 +-
 t/t4056-diff-order.sh                |   4 +-
 t/t4057-diff-combined-paths.sh       |  22 ++--
 t/t4061-diff-indent.sh               |  26 ++--
 t/t4066-diff-emit-delay.sh           |   4 +-
 t/t4068-diff-symmetric-merge-base.sh |  50 ++++----
 t/t4103-apply-binary.sh              |  38 +++---
 t/t4108-apply-threeway.sh            |  16 +--
 t/t4121-apply-diffs.sh               |   4 +-
 t/t4122-apply-symlink-inside.sh      |   8 +-
 t/t4150-am.sh                        |  28 ++---
 t/t4200-rerere.sh                    |  22 ++--
 t/t4201-shortlog.sh                  |   4 +-
 t/t4202-log.sh                       | 108 ++++++++--------
 t/t4203-mailmap.sh                   |   4 +-
 t/t4204-patch-id.sh                  |  28 ++---
 t/t4207-log-decoration-colors.sh     |   8 +-
 t/t4208-log-magic-pathspec.sh        |   6 +-
 t/t4211-line-log.sh                  |   2 +-
 t/t4211/history.export               |   2 +-
 t/t4214-log-graph-octopus.sh         |   4 +-
 t/t4216-log-bloom.sh                 |   6 +-
 t/t4253-am-keep-cr-dos.sh            |  22 ++--
 t/t4257-am-interactive.sh            |   2 +-
 29 files changed, 319 insertions(+), 319 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 276aea32a6..66630c8413 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -5,7 +5,7 @@
 
 test_description='various format-patch tests'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -35,11 +35,11 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m "Side changes #3 with \\n backslash-n in it." &&
 
-	git checkout master &&
+	git checkout main &&
 	git diff-tree -p C2 >patch &&
 	git apply --index <patch &&
 	test_tick &&
-	git commit -m "Master accepts moral equivalent of #2" &&
+	git commit -m "Main accepts moral equivalent of #2" &&
 
 	git checkout side &&
 	git checkout -b patchid &&
@@ -59,39 +59,39 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m "patchid 3" &&
 
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream' '
-	git format-patch --stdout master..side >patch0 &&
+	git format-patch --stdout main..side >patch0 &&
 	grep "^From " patch0 >from0 &&
 	test_line_count = 3 from0
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream' '
 	git format-patch --stdout \
-		--ignore-if-in-upstream master..side >patch1 &&
+		--ignore-if-in-upstream main..side >patch1 &&
 	grep "^From " patch1 >from1 &&
 	test_line_count = 2 from1
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
 	git tag -a v1 -m tag side &&
-	git tag -a v2 -m tag master &&
+	git tag -a v2 -m tag main &&
 	git format-patch --stdout --ignore-if-in-upstream v2..v1 >patch1 &&
 	grep "^From " patch1 >from1 &&
 	test_line_count = 2 from1
 '
 
 test_expect_success "format-patch doesn't consider merge commits" '
-	git checkout -b feature master &&
+	git checkout -b feature main &&
 	echo "Another line" >>file &&
 	test_tick &&
 	git commit -am "Feature branch change #1" &&
 	echo "Yet another line" >>file &&
 	test_tick &&
 	git commit -am "Feature branch change #2" &&
-	git checkout -b merger master &&
+	git checkout -b merger main &&
 	test_tick &&
 	git merge --no-ff feature &&
 	git format-patch -3 --stdout >patch &&
@@ -100,16 +100,16 @@ test_expect_success "format-patch doesn't consider merge commits" '
 '
 
 test_expect_success 'format-patch result applies' '
-	git checkout -b rebuild-0 master &&
+	git checkout -b rebuild-0 main &&
 	git am -3 patch0 &&
-	git rev-list master.. >list &&
+	git rev-list main.. >list &&
 	test_line_count = 2 list
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream result applies' '
-	git checkout -b rebuild-1 master &&
+	git checkout -b rebuild-1 main &&
 	git am -3 patch1 &&
-	git rev-list master.. >list &&
+	git rev-list main.. >list &&
 	test_line_count = 2 list
 '
 
@@ -133,7 +133,7 @@ test_expect_success 'extra headers' '
 " &&
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>
 " &&
-	git format-patch --stdout master..side >patch2 &&
+	git format-patch --stdout main..side >patch2 &&
 	sed -e "/^\$/q" patch2 >hdrs2 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs2 &&
 	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs2
@@ -142,7 +142,7 @@ test_expect_success 'extra headers' '
 test_expect_success 'extra headers without newlines' '
 	git config --replace-all format.headers "To: R E Cipient <rcipient@example.com>" &&
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>" &&
-	git format-patch --stdout master..side >patch3 &&
+	git format-patch --stdout main..side >patch3 &&
 	sed -e "/^\$/q" patch3 >hdrs3 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs3 &&
 	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs3
@@ -151,7 +151,7 @@ test_expect_success 'extra headers without newlines' '
 test_expect_success 'extra headers with multiple To:s' '
 	git config --replace-all format.headers "To: R E Cipient <rcipient@example.com>" &&
 	git config --add format.headers "To: S E Cipient <scipient@example.com>" &&
-	git format-patch --stdout master..side >patch4 &&
+	git format-patch --stdout main..side >patch4 &&
 	sed -e "/^\$/q" patch4 >hdrs4 &&
 	grep "^To: R E Cipient <rcipient@example.com>,\$" hdrs4 &&
 	grep "^ *S E Cipient <scipient@example.com>\$" hdrs4
@@ -159,7 +159,7 @@ test_expect_success 'extra headers with multiple To:s' '
 
 test_expect_success 'additional command line cc (ascii)' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --cc="S E Cipient <scipient@example.com>" --stdout master..side >patch5 &&
+	git format-patch --cc="S E Cipient <scipient@example.com>" --stdout main..side >patch5 &&
 	sed -e "/^\$/q" patch5 >hdrs5 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
 	grep "^ *S E Cipient <scipient@example.com>\$" hdrs5
@@ -167,7 +167,7 @@ test_expect_success 'additional command line cc (ascii)' '
 
 test_expect_failure 'additional command line cc (rfc822)' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side >patch5 &&
+	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout main..side >patch5 &&
 	sed -e "/^\$/q" patch5 >hdrs5 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
 	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
@@ -175,14 +175,14 @@ test_expect_failure 'additional command line cc (rfc822)' '
 
 test_expect_success 'command line headers' '
 	git config --unset-all format.headers &&
-	git format-patch --add-header="Cc: R E Cipient <rcipient@example.com>" --stdout master..side >patch6 &&
+	git format-patch --add-header="Cc: R E Cipient <rcipient@example.com>" --stdout main..side >patch6 &&
 	sed -e "/^\$/q" patch6 >hdrs6 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>\$" hdrs6
 '
 
 test_expect_success 'configuration headers and command line headers' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --add-header="Cc: S E Cipient <scipient@example.com>" --stdout master..side >patch7 &&
+	git format-patch --add-header="Cc: S E Cipient <scipient@example.com>" --stdout main..side >patch7 &&
 	sed -e "/^\$/q" patch7 >hdrs7 &&
 	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs7 &&
 	grep "^ *S E Cipient <scipient@example.com>\$" hdrs7
@@ -190,40 +190,40 @@ test_expect_success 'configuration headers and command line headers' '
 
 test_expect_success 'command line To: header (ascii)' '
 	git config --unset-all format.headers &&
-	git format-patch --to="R E Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	git format-patch --to="R E Cipient <rcipient@example.com>" --stdout main..side >patch8 &&
 	sed -e "/^\$/q" patch8 >hdrs8 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_failure 'command line To: header (rfc822)' '
-	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout main..side >patch8 &&
 	sed -e "/^\$/q" patch8 >hdrs8 &&
 	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_failure 'command line To: header (rfc2047)' '
-	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout main..side >patch8 &&
 	sed -e "/^\$/q" patch8 >hdrs8 &&
 	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_success 'configuration To: header (ascii)' '
 	git config format.to "R E Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side >patch9 &&
+	git format-patch --stdout main..side >patch9 &&
 	sed -e "/^\$/q" patch9 >hdrs9 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs9
 '
 
 test_expect_failure 'configuration To: header (rfc822)' '
 	git config format.to "R. E. Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side >patch9 &&
+	git format-patch --stdout main..side >patch9 &&
 	sed -e "/^\$/q" patch9 >hdrs9 &&
 	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs9
 '
 
 test_expect_failure 'configuration To: header (rfc2047)' '
 	git config format.to "R Ä Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side >patch9 &&
+	git format-patch --stdout main..side >patch9 &&
 	sed -e "/^\$/q" patch9 >hdrs9 &&
 	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
 '
@@ -237,35 +237,35 @@ check_patch () {
 }
 
 test_expect_success 'format.from=false' '
-	git -c format.from=false format-patch --stdout master..side >patch &&
+	git -c format.from=false format-patch --stdout main..side >patch &&
 	sed -e "/^\$/q" patch >hdrs &&
 	check_patch patch &&
 	! grep "^From: C O Mitter <committer@example.com>\$" hdrs
 '
 
 test_expect_success 'format.from=true' '
-	git -c format.from=true format-patch --stdout master..side >patch &&
+	git -c format.from=true format-patch --stdout main..side >patch &&
 	sed -e "/^\$/q" patch >hdrs &&
 	check_patch hdrs &&
 	grep "^From: C O Mitter <committer@example.com>\$" hdrs
 '
 
 test_expect_success 'format.from with address' '
-	git -c format.from="F R Om <from@example.com>" format-patch --stdout master..side >patch &&
+	git -c format.from="F R Om <from@example.com>" format-patch --stdout main..side >patch &&
 	sed -e "/^\$/q" patch >hdrs &&
 	check_patch hdrs &&
 	grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--no-from overrides format.from' '
-	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout master..side >patch &&
+	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout main..side >patch &&
 	sed -e "/^\$/q" patch >hdrs &&
 	check_patch hdrs &&
 	! grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--from overrides format.from' '
-	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout master..side >patch &&
+	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout main..side >patch &&
 	sed -e "/^\$/q" patch >hdrs &&
 	check_patch hdrs &&
 	! grep "^From: F R Om <from@example.com>\$" hdrs
@@ -274,7 +274,7 @@ test_expect_success '--from overrides format.from' '
 test_expect_success '--no-to overrides config.to' '
 	git config --replace-all format.to \
 		"R E Cipient <rcipient@example.com>" &&
-	git format-patch --no-to --stdout master..side >patch10 &&
+	git format-patch --no-to --stdout main..side >patch10 &&
 	sed -e "/^\$/q" patch10 >hdrs10 &&
 	check_patch hdrs10 &&
 	! grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
@@ -284,7 +284,7 @@ test_expect_success '--no-to and --to replaces config.to' '
 	git config --replace-all format.to \
 		"Someone <someone@out.there>" &&
 	git format-patch --no-to --to="Someone Else <else@out.there>" \
-		--stdout master..side >patch11 &&
+		--stdout main..side >patch11 &&
 	sed -e "/^\$/q" patch11 >hdrs11 &&
 	check_patch hdrs11 &&
 	! grep "^To: Someone <someone@out.there>\$" hdrs11 &&
@@ -294,7 +294,7 @@ test_expect_success '--no-to and --to replaces config.to' '
 test_expect_success '--no-cc overrides config.cc' '
 	git config --replace-all format.cc \
 		"C E Cipient <rcipient@example.com>" &&
-	git format-patch --no-cc --stdout master..side >patch12 &&
+	git format-patch --no-cc --stdout main..side >patch12 &&
 	sed -e "/^\$/q" patch12 >hdrs12 &&
 	check_patch hdrs12 &&
 	! grep "^Cc: C E Cipient <rcipient@example.com>\$" hdrs12
@@ -303,7 +303,7 @@ test_expect_success '--no-cc overrides config.cc' '
 test_expect_success '--no-add-header overrides config.headers' '
 	git config --replace-all format.headers \
 		"Header1: B E Cipient <rcipient@example.com>" &&
-	git format-patch --no-add-header --stdout master..side >patch13 &&
+	git format-patch --no-add-header --stdout main..side >patch13 &&
 	sed -e "/^\$/q" patch13 >hdrs13 &&
 	check_patch hdrs13 &&
 	! grep "^Header1: B E Cipient <rcipient@example.com>\$" hdrs13
@@ -312,7 +312,7 @@ test_expect_success '--no-add-header overrides config.headers' '
 test_expect_success 'multiple files' '
 	rm -rf patches/ &&
 	git checkout side &&
-	git format-patch -o patches/ master &&
+	git format-patch -o patches/ main &&
 	ls patches/0001-Side-changes-1.patch patches/0002-Side-changes-2.patch patches/0003-Side-changes-3-with-n-backslash-n-in-it.patch
 '
 
@@ -372,7 +372,7 @@ test_expect_success 'filename limit applies only to basename' '
 
 test_expect_success 'reroll count' '
 	rm -fr patches &&
-	git format-patch -o patches --cover-letter --reroll-count 4 master..side >list &&
+	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
 	! grep -v "^patches/v4-000[0-3]-" list &&
 	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
 	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
@@ -380,7 +380,7 @@ test_expect_success 'reroll count' '
 
 test_expect_success 'reroll count (-v)' '
 	rm -fr patches &&
-	git format-patch -o patches --cover-letter -v4 master..side >list &&
+	git format-patch -o patches --cover-letter -v4 main..side >list &&
 	! grep -v "^patches/v4-000[0-3]-" list &&
 	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
 	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
@@ -416,7 +416,7 @@ EOF
 
 test_expect_success 'no threading' '
 	git checkout side &&
-	check_threading expect.no-threading master
+	check_threading expect.no-threading main
 '
 
 cat >expect.thread <<EOF
@@ -433,7 +433,7 @@ References: <0>
 EOF
 
 test_expect_success 'thread' '
-	check_threading expect.thread --thread master
+	check_threading expect.thread --thread main
 '
 
 cat >expect.in-reply-to <<EOF
@@ -453,7 +453,7 @@ EOF
 
 test_expect_success 'thread in-reply-to' '
 	check_threading expect.in-reply-to --in-reply-to="<test.message>" \
-		--thread master
+		--thread main
 '
 
 cat >expect.cover-letter <<EOF
@@ -474,7 +474,7 @@ References: <0>
 EOF
 
 test_expect_success 'thread cover-letter' '
-	check_threading expect.cover-letter --cover-letter --thread master
+	check_threading expect.cover-letter --cover-letter --thread main
 '
 
 cat >expect.cl-irt <<EOF
@@ -501,12 +501,12 @@ EOF
 
 test_expect_success 'thread cover-letter in-reply-to' '
 	check_threading expect.cl-irt --cover-letter \
-		--in-reply-to="<test.message>" --thread master
+		--in-reply-to="<test.message>" --thread main
 '
 
 test_expect_success 'thread explicit shallow' '
 	check_threading expect.cl-irt --cover-letter \
-		--in-reply-to="<test.message>" --thread=shallow master
+		--in-reply-to="<test.message>" --thread=shallow main
 '
 
 cat >expect.deep <<EOF
@@ -524,7 +524,7 @@ References: <0>
 EOF
 
 test_expect_success 'thread deep' '
-	check_threading expect.deep --thread=deep master
+	check_threading expect.deep --thread=deep main
 '
 
 cat >expect.deep-irt <<EOF
@@ -547,7 +547,7 @@ EOF
 
 test_expect_success 'thread deep in-reply-to' '
 	check_threading expect.deep-irt  --thread=deep \
-		--in-reply-to="<test.message>" master
+		--in-reply-to="<test.message>" main
 '
 
 cat >expect.deep-cl <<EOF
@@ -571,7 +571,7 @@ References: <0>
 EOF
 
 test_expect_success 'thread deep cover-letter' '
-	check_threading expect.deep-cl --cover-letter --thread=deep master
+	check_threading expect.deep-cl --cover-letter --thread=deep main
 '
 
 cat >expect.deep-cl-irt <<EOF
@@ -601,27 +601,27 @@ EOF
 
 test_expect_success 'thread deep cover-letter in-reply-to' '
 	check_threading expect.deep-cl-irt --cover-letter \
-		--in-reply-to="<test.message>" --thread=deep master
+		--in-reply-to="<test.message>" --thread=deep main
 '
 
 test_expect_success 'thread via config' '
 	test_config format.thread true &&
-	check_threading expect.thread master
+	check_threading expect.thread main
 '
 
 test_expect_success 'thread deep via config' '
 	test_config format.thread deep &&
-	check_threading expect.deep master
+	check_threading expect.deep main
 '
 
 test_expect_success 'thread config + override' '
 	test_config format.thread deep &&
-	check_threading expect.thread --thread master
+	check_threading expect.thread --thread main
 '
 
 test_expect_success 'thread config + --no-thread' '
 	test_config format.thread deep &&
-	check_threading expect.no-threading --no-thread master
+	check_threading expect.no-threading --no-thread main
 '
 
 test_expect_success 'excessive subject' '
@@ -634,7 +634,7 @@ test_expect_success 'excessive subject' '
 	after=$(git rev-parse --short $after) &&
 	git update-index file &&
 	git commit -m "This is an excessively long subject line for a message due to the habit some projects have of not having a short, one-line subject at the start of the commit message, but rather sticking a whole paragraph right at the start as the only thing in the commit message. It had better not become the filename for the patch." &&
-	git format-patch -o patches/ master..side &&
+	git format-patch -o patches/ main..side &&
 	ls patches/0004-This-is-an-excessively-long-subject-line-for-a-messa.patch
 '
 
@@ -896,13 +896,13 @@ test_expect_success 'options no longer allowed for format-patch' '
 '
 
 test_expect_success 'format-patch --numstat should produce a patch' '
-	git format-patch --numstat --stdout master..side >output &&
+	git format-patch --numstat --stdout main..side >output &&
 	grep "^diff --git a/" output >diff &&
 	test_line_count = 5 diff
 '
 
 test_expect_success 'format-patch -- <path>' '
-	git format-patch master..side -- file 2>error &&
+	git format-patch main..side -- file 2>error &&
 	! grep "Use .--" error
 '
 
@@ -1676,9 +1676,9 @@ test_expect_success 'cover letter with invalid --cover-from-description and conf
 	test_config branch.rebuild-1.description "config subject
 
 body" &&
-	test_must_fail git format-patch --cover-letter --cover-from-description garbage master &&
+	test_must_fail git format-patch --cover-letter --cover-from-description garbage main &&
 	test_config format.coverFromDescription garbage &&
-	test_must_fail git format-patch --cover-letter master
+	test_must_fail git format-patch --cover-letter main
 '
 
 test_expect_success 'cover letter with format.coverFromDescription = default' '
@@ -1687,7 +1687,7 @@ test_expect_success 'cover letter with format.coverFromDescription = default' '
 body" &&
 	test_config format.coverFromDescription default &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter master >actual &&
+	git format-patch --stdout --cover-letter main >actual &&
 	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	grep "^config subject$" actual &&
@@ -1699,7 +1699,7 @@ test_expect_success 'cover letter with --cover-from-description default' '
 
 body" &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter --cover-from-description default master >actual &&
+	git format-patch --stdout --cover-letter --cover-from-description default main >actual &&
 	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	grep "^config subject$" actual &&
@@ -1712,7 +1712,7 @@ test_expect_success 'cover letter with format.coverFromDescription = none' '
 body" &&
 	test_config format.coverFromDescription none &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter master >actual &&
+	git format-patch --stdout --cover-letter main >actual &&
 	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
 	grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	! grep "^config subject$" actual &&
@@ -1724,7 +1724,7 @@ test_expect_success 'cover letter with --cover-from-description none' '
 
 body" &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter --cover-from-description none master >actual &&
+	git format-patch --stdout --cover-letter --cover-from-description none main >actual &&
 	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
 	grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	! grep "^config subject$" actual &&
@@ -1737,7 +1737,7 @@ test_expect_success 'cover letter with format.coverFromDescription = message' '
 body" &&
 	test_config format.coverFromDescription message &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter master >actual &&
+	git format-patch --stdout --cover-letter main >actual &&
 	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	grep "^config subject$" actual &&
@@ -1749,7 +1749,7 @@ test_expect_success 'cover letter with --cover-from-description message' '
 
 body" &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter --cover-from-description message master >actual &&
+	git format-patch --stdout --cover-letter --cover-from-description message main >actual &&
 	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	grep "^config subject$" actual &&
@@ -1762,7 +1762,7 @@ test_expect_success 'cover letter with format.coverFromDescription = subject' '
 body" &&
 	test_config format.coverFromDescription subject &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter master >actual &&
+	git format-patch --stdout --cover-letter main >actual &&
 	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	! grep "^config subject$" actual &&
@@ -1774,7 +1774,7 @@ test_expect_success 'cover letter with --cover-from-description subject' '
 
 body" &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter --cover-from-description subject master >actual &&
+	git format-patch --stdout --cover-letter --cover-from-description subject main >actual &&
 	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	! grep "^config subject$" actual &&
@@ -1787,7 +1787,7 @@ test_expect_success 'cover letter with format.coverFromDescription = auto (short
 body" &&
 	test_config format.coverFromDescription auto &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter master >actual &&
+	git format-patch --stdout --cover-letter main >actual &&
 	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	! grep "^config subject$" actual &&
@@ -1799,7 +1799,7 @@ test_expect_success 'cover letter with --cover-from-description auto (short subj
 
 body" &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter --cover-from-description auto master >actual &&
+	git format-patch --stdout --cover-letter --cover-from-description auto main >actual &&
 	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	! grep "^config subject$" actual &&
@@ -1812,7 +1812,7 @@ test_expect_success 'cover letter with format.coverFromDescription = auto (long
 body" &&
 	test_config format.coverFromDescription auto &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter master >actual &&
+	git format-patch --stdout --cover-letter main >actual &&
 	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	grep "^this is a really long first line and it is over 100 characters long which is the threshold for long subjects$" actual &&
@@ -1824,7 +1824,7 @@ test_expect_success 'cover letter with --cover-from-description auto (long subje
 
 body" &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter --cover-from-description auto master >actual &&
+	git format-patch --stdout --cover-letter --cover-from-description auto main >actual &&
 	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	grep "^this is a really long first line and it is over 100 characters long which is the threshold for long subjects$" actual &&
@@ -1837,7 +1837,7 @@ test_expect_success 'cover letter with command-line --cover-from-description ove
 body" &&
 	test_config format.coverFromDescription none &&
 	git checkout rebuild-1 &&
-	git format-patch --stdout --cover-letter --cover-from-description subject master >actual &&
+	git format-patch --stdout --cover-letter --cover-from-description subject main >actual &&
 	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
 	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
 	! grep "^config subject$" actual &&
@@ -1847,7 +1847,7 @@ body" &&
 test_expect_success 'cover letter using branch description (1)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
-	git format-patch --stdout --cover-letter master >actual &&
+	git format-patch --stdout --cover-letter main >actual &&
 	grep hello actual
 '
 
@@ -1861,14 +1861,14 @@ test_expect_success 'cover letter using branch description (2)' '
 test_expect_success 'cover letter using branch description (3)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
-	git format-patch --stdout --cover-letter ^master rebuild-1 >actual &&
+	git format-patch --stdout --cover-letter ^main rebuild-1 >actual &&
 	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (4)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
-	git format-patch --stdout --cover-letter master.. >actual &&
+	git format-patch --stdout --cover-letter main.. >actual &&
 	grep hello actual
 '
 
@@ -1935,8 +1935,8 @@ test_expect_success 'From line has expected format' '
 
 test_expect_success 'format-patch -o with no leading directories' '
 	rm -fr patches &&
-	git format-patch -o patches master..side &&
-	count=$(git rev-list --count master..side) &&
+	git format-patch -o patches main..side &&
+	count=$(git rev-list --count main..side) &&
 	ls patches >list &&
 	test_line_count = $count list
 '
@@ -1944,16 +1944,16 @@ test_expect_success 'format-patch -o with no leading directories' '
 test_expect_success 'format-patch -o with leading existing directories' '
 	rm -rf existing-dir &&
 	mkdir existing-dir &&
-	git format-patch -o existing-dir/patches master..side &&
-	count=$(git rev-list --count master..side) &&
+	git format-patch -o existing-dir/patches main..side &&
+	count=$(git rev-list --count main..side) &&
 	ls existing-dir/patches >list &&
 	test_line_count = $count list
 '
 
 test_expect_success 'format-patch -o with leading non-existing directories' '
 	rm -rf non-existing-dir &&
-	git format-patch -o non-existing-dir/patches master..side &&
-	count=$(git rev-list --count master..side) &&
+	git format-patch -o non-existing-dir/patches main..side &&
+	count=$(git rev-list --count main..side) &&
 	test_path_is_dir non-existing-dir &&
 	ls non-existing-dir/patches >list &&
 	test_line_count = $count list
@@ -1962,8 +1962,8 @@ test_expect_success 'format-patch -o with leading non-existing directories' '
 test_expect_success 'format-patch format.outputDirectory option' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches &&
-	git format-patch master..side &&
-	count=$(git rev-list --count master..side) &&
+	git format-patch main..side &&
+	count=$(git rev-list --count main..side) &&
 	ls patches >list &&
 	test_line_count = $count list
 '
@@ -1971,7 +1971,7 @@ test_expect_success 'format-patch format.outputDirectory option' '
 test_expect_success 'format-patch -o overrides format.outputDirectory' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches patchset &&
-	git format-patch master..side -o patchset &&
+	git format-patch main..side -o patchset &&
 	test_path_is_missing patches &&
 	test_path_is_dir patchset
 '
@@ -2068,14 +2068,14 @@ test_expect_success 'format-patch --base errors out when base commit is not ance
 	#	  ------------W
 	#
 	# If "format-patch Z..X" is given, P and Z can not be specified as the base commit
-	git checkout -b topic1 master &&
+	git checkout -b topic1 main &&
 	git rev-parse HEAD >commit-id-base &&
 	test_commit P &&
 	git rev-parse HEAD >commit-id-P &&
 	test_commit Z &&
 	git rev-parse HEAD >commit-id-Z &&
 	test_commit Y &&
-	git checkout -b topic2 master &&
+	git checkout -b topic2 main &&
 	test_commit W &&
 	git merge topic1 &&
 	test_commit X &&
@@ -2088,7 +2088,7 @@ test_expect_success 'format-patch --base errors out when base commit is not ance
 '
 
 test_expect_success 'format-patch --base=auto' '
-	git checkout -b upstream master &&
+	git checkout -b upstream main &&
 	git checkout -b local upstream &&
 	git branch --set-upstream-to=upstream &&
 	test_commit N1 &&
@@ -2109,11 +2109,11 @@ test_expect_success 'format-patch errors out when history involves criss-cross'
 	#  \ / \
 	#   C---M2---E
 	#
-	git checkout master &&
+	git checkout main &&
 	test_commit A &&
-	git checkout -b xb master &&
+	git checkout -b xb main &&
 	test_commit B &&
-	git checkout -b xc master &&
+	git checkout -b xc main &&
 	test_commit C &&
 	git checkout -b xbc xb -- &&
 	git merge xc &&
@@ -2233,7 +2233,7 @@ test_expect_success 'format-patch --pretty=mboxrd' '
 '
 
 test_expect_success 'interdiff: setup' '
-	git checkout -b boop master &&
+	git checkout -b boop main &&
 	test_commit fnorp blorp &&
 	test_commit fleep blorp
 '
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 0b379c307b..ed461f481e 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -2,7 +2,7 @@
 
 test_description='Return value of diffs'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -114,7 +114,7 @@ test_expect_success 'check detects leftover conflict markers' '
 	git checkout HEAD^ &&
 	echo binary >>b &&
 	git commit -m "side" b &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	git add b &&
 	test_expect_code 2 git --no-pager diff --cached --check >test.out &&
 	test 3 = $(grep "conflict marker" test.out | wc -l) &&
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index e873abb1da..09ad491a59 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -2,7 +2,7 @@
 
 test_description='combined diff'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -118,7 +118,7 @@ test_expect_success 'check --cc --raw with forty trees' '
 '
 
 test_expect_success 'setup combined ignore spaces' '
-	git checkout master &&
+	git checkout main &&
 	>test &&
 	git add test &&
 	git commit -m initial &&
@@ -146,7 +146,7 @@ test_expect_success 'setup combined ignore spaces' '
 	EOF
 	git commit -m "test other space changes" -a &&
 
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	tr -d Q <<-\EOF >test &&
 	eol spaces Q
 	space  change
@@ -407,7 +407,7 @@ test_expect_success 'combine diff missing delete bug' '
 test_expect_success 'combine diff gets tree sorting right' '
 	# create a directory and a file that sort differently in trees
 	# versus byte-wise (implied "/" sorts after ".")
-	git checkout -f master &&
+	git checkout -f main &&
 	mkdir foo &&
 	echo base >foo/one &&
 	echo base >foo/two &&
@@ -417,9 +417,9 @@ test_expect_success 'combine diff gets tree sorting right' '
 
 	# one side modifies a file in the directory, along with the root
 	# file...
-	echo master >foo/one &&
-	echo master >foo.ext &&
-	git commit -a -m master &&
+	echo main >foo/one &&
+	echo main >foo.ext &&
+	git commit -a -m main &&
 
 	# the other side modifies the other file in the directory
 	git checkout -b other HEAD^ &&
@@ -429,7 +429,7 @@ test_expect_success 'combine diff gets tree sorting right' '
 	# And now we merge. The files in the subdirectory will resolve cleanly,
 	# meaning that a combined diff will not find them interesting. But it
 	# will find the tree itself interesting, because it had to be merged.
-	git checkout master &&
+	git checkout main &&
 	git merge other &&
 
 	printf "MM\tfoo\n" >expect &&
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 8014cd684b..9b326fe935 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -9,7 +9,7 @@ test_description='Support for verbose submodule differences in git diff
 This test tries to verify the sanity of the --submodule option of git diff.
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -541,7 +541,7 @@ test_expect_success 'diff --submodule with objects referenced by alternates' '
 	(cd super &&
 		(cd sub &&
 			git fetch &&
-			git checkout origin/master
+			git checkout origin/main
 		) &&
 		git diff --submodule > ../actual
 	) &&
diff --git a/t/t4048-diff-combined-binary.sh b/t/t4048-diff-combined-binary.sh
index e2780e697a..0260cf64f5 100755
--- a/t/t4048-diff-combined-binary.sh
+++ b/t/t4048-diff-combined-binary.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='combined and merge diff handle binary files and textconv'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup binary merge conflict' '
 	echo threeQ3 | q_to_nul >binary &&
 	git commit -a -m three &&
 	three=$(git rev-parse --short HEAD:binary) &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	echo resolvedQhooray | q_to_nul >binary &&
 	git commit -a -m resolved &&
 	res=$(git rev-parse --short HEAD:binary)
@@ -65,14 +65,14 @@ test_expect_success 'diff --cc indicates binary-ness' '
 '
 
 test_expect_success 'setup non-binary with binary attribute' '
-	git checkout master &&
+	git checkout main &&
 	test_commit one text &&
 	test_commit two text &&
 	two=$(git rev-parse --short HEAD:text) &&
 	git checkout -b branch-text HEAD^ &&
 	test_commit three text &&
 	three=$(git rev-parse --short HEAD:text) &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	test_commit resolved text &&
 	res=$(git rev-parse --short HEAD:text) &&
 	echo text -diff >.gitattributes
@@ -209,11 +209,11 @@ index $three,$two..0000000
  +THREE
 ++=======
 + TWO
-++>>>>>>> MASTER
+++>>>>>>> MAIN
 EOF
 test_expect_success 'diff --cc respects textconv on worktree file' '
 	git reset --hard HEAD^ &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	git diff >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index a9aef7f986..9eba436211 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -5,7 +5,7 @@
 
 test_description='test --stat output of various commands'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -356,7 +356,7 @@ cat >expect <<'EOF'
 EOF
 test_expect_success 'merge --stat respects COLUMNS (big change)' '
 	git checkout -b branch HEAD^^ &&
-	COLUMNS=100 git merge --stat --no-ff master^ >output &&
+	COLUMNS=100 git merge --stat --no-ff main^ >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
@@ -365,7 +365,7 @@ cat >expect <<'EOF'
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++
 EOF
 test_expect_success 'merge --stat respects COLUMNS (long filename)' '
-	COLUMNS=100 git merge --stat --no-ff master >output &&
+	COLUMNS=100 git merge --stat --no-ff main >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index 723eee4e8e..63ea7144bb 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -2,7 +2,7 @@
 
 test_description='diff order'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -109,7 +109,7 @@ done
 test_expect_success 'setup for testing combine-diff order' '
 	git checkout -b tmp HEAD~ &&
 	create_files 3 &&
-	git checkout master &&
+	git checkout main &&
 	git merge --no-commit -s ours tmp &&
 	create_files 5
 '
diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-paths.sh
index 71af157bf9..7e5b74f72e 100755
--- a/t/t4057-diff-combined-paths.sh
+++ b/t/t4057-diff-combined-paths.sh
@@ -2,7 +2,7 @@
 
 test_description='combined diff show only paths that are different to all parents'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -27,9 +27,9 @@ test_expect_success 'trivial merge - combine-diff empty' '
 		echo $i/2 >>$i.txt
 	done &&
 	git commit -a -m "side 2-9" &&
-	git checkout master &&
+	git checkout main &&
 	echo 1/2 >1.txt &&
-	git commit -a -m "master 1" &&
+	git commit -a -m "main 1" &&
 	git merge side &&
 	>diffc.expect &&
 	diffc_verify
@@ -44,19 +44,19 @@ test_expect_success 'only one truly conflicting path' '
 	done &&
 	echo "4side" >>4.txt &&
 	git commit -a -m "side 2-9 +4" &&
-	git checkout master &&
+	git checkout main &&
 	for i in $(test_seq 1 9)
 	do
 		echo $i/3 >>$i.txt
 	done &&
-	echo "4master" >>4.txt &&
-	git commit -a -m "master 1-9 +4" &&
+	echo "4main" >>4.txt &&
+	git commit -a -m "main 1-9 +4" &&
 	test_must_fail git merge side &&
 	cat <<-\EOF >4.txt &&
 	4
 	4/2
 	4/3
-	4master
+	4main
 	4side
 	EOF
 	git add 4.txt &&
@@ -72,12 +72,12 @@ test_expect_success 'merge introduces new file' '
 		echo $i/4 >>$i.txt
 	done &&
 	git commit -a -m "side 5-9" &&
-	git checkout master &&
+	git checkout main &&
 	for i in $(test_seq 1 3)
 	do
 		echo $i/4 >>$i.txt
 	done &&
-	git commit -a -m "master 1-3 +4hello" &&
+	git commit -a -m "main 1-3 +4hello" &&
 	git merge side &&
 	echo "Hello World" >4hello.txt &&
 	git add 4hello.txt &&
@@ -93,12 +93,12 @@ test_expect_success 'merge removed a file' '
 		echo $i/5 >>$i.txt
 	done &&
 	git commit -a -m "side 5-9" &&
-	git checkout master &&
+	git checkout main &&
 	for i in $(test_seq 1 3)
 	do
 		echo $i/4 >>$i.txt
 	done &&
-	git commit -a -m "master 1-3" &&
+	git commit -a -m "main 1-3" &&
 	git merge side &&
 	git rm 4.txt &&
 	git commit --amend &&
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index cbe64d5f79..bcf7493740 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -3,7 +3,7 @@
 test_description='Test diff indent heuristic.
 
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -269,7 +269,7 @@ test_expect_success 'diff-index: nice spaces with --indent-heuristic' '
 	git reset --soft HEAD~ &&
 	git diff-index --indent-heuristic -p old -- spaces.txt >out-diff-index-compacted &&
 	compare_diff spaces-compacted-expect out-diff-index-compacted &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'diff-index: nice spaces with diff.indentHeuristic=true' '
@@ -277,7 +277,7 @@ test_expect_success 'diff-index: nice spaces with diff.indentHeuristic=true' '
 	git reset --soft HEAD~ &&
 	git -c diff.indentHeuristic=true diff-index -p old -- spaces.txt >out-diff-index-compacted2 &&
 	compare_diff spaces-compacted-expect out-diff-index-compacted2 &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'diff-index: ugly spaces with --no-indent-heuristic' '
@@ -285,7 +285,7 @@ test_expect_success 'diff-index: ugly spaces with --no-indent-heuristic' '
 	git reset --soft HEAD~ &&
 	git diff-index --no-indent-heuristic -p old -- spaces.txt >out-diff-index &&
 	compare_diff spaces-expect out-diff-index &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'diff-index: ugly spaces with diff.indentHeuristic=false' '
@@ -293,7 +293,7 @@ test_expect_success 'diff-index: ugly spaces with diff.indentHeuristic=false' '
 	git reset --soft HEAD~ &&
 	git -c diff.indentHeuristic=false diff-index -p old -- spaces.txt >out-diff-index2 &&
 	compare_diff spaces-expect out-diff-index2 &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'diff-index: --indent-heuristic overrides config' '
@@ -301,7 +301,7 @@ test_expect_success 'diff-index: --indent-heuristic overrides config' '
 	git reset --soft HEAD~ &&
 	git -c diff.indentHeuristic=false diff-index --indent-heuristic -p old -- spaces.txt >out-diff-index-compacted3 &&
 	compare_diff spaces-compacted-expect out-diff-index-compacted3 &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'diff-index: --no-indent-heuristic overrides config' '
@@ -309,7 +309,7 @@ test_expect_success 'diff-index: --no-indent-heuristic overrides config' '
 	git reset --soft HEAD~ &&
 	git -c diff.indentHeuristic=true diff-index --no-indent-heuristic -p old -- spaces.txt >out-diff-index3 &&
 	compare_diff spaces-expect out-diff-index3 &&
-	git checkout -f master
+	git checkout -f main
 '
 
 # --- diff-files tests ----------------------------------------------------
@@ -320,7 +320,7 @@ test_expect_success 'diff-files: nice spaces with --indent-heuristic' '
 	git diff-files --indent-heuristic -p spaces.txt >out-diff-files-raw &&
 	grep -v index out-diff-files-raw >out-diff-files-compacted &&
 	compare_diff spaces-compacted-expect out-diff-files-compacted &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'diff-files: nice spaces with diff.indentHeuristic=true' '
@@ -329,7 +329,7 @@ test_expect_success 'diff-files: nice spaces with diff.indentHeuristic=true' '
 	git -c diff.indentHeuristic=true diff-files -p spaces.txt >out-diff-files-raw2 &&
 	grep -v index out-diff-files-raw2 >out-diff-files-compacted2 &&
 	compare_diff spaces-compacted-expect out-diff-files-compacted2 &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'diff-files: ugly spaces with --no-indent-heuristic' '
@@ -338,7 +338,7 @@ test_expect_success 'diff-files: ugly spaces with --no-indent-heuristic' '
 	git diff-files --no-indent-heuristic -p spaces.txt >out-diff-files-raw &&
 	grep -v index out-diff-files-raw >out-diff-files &&
 	compare_diff spaces-expect out-diff-files &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'diff-files: ugly spaces with diff.indentHeuristic=false' '
@@ -347,7 +347,7 @@ test_expect_success 'diff-files: ugly spaces with diff.indentHeuristic=false' '
 	git -c diff.indentHeuristic=false diff-files -p spaces.txt >out-diff-files-raw2 &&
 	grep -v index out-diff-files-raw2 >out-diff-files &&
 	compare_diff spaces-expect out-diff-files &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'diff-files: --indent-heuristic overrides config' '
@@ -356,7 +356,7 @@ test_expect_success 'diff-files: --indent-heuristic overrides config' '
 	git -c diff.indentHeuristic=false diff-files --indent-heuristic -p spaces.txt >out-diff-files-raw3 &&
 	grep -v index out-diff-files-raw3 >out-diff-files-compacted &&
 	compare_diff spaces-compacted-expect out-diff-files-compacted &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_expect_success 'diff-files: --no-indent-heuristic overrides config' '
@@ -365,7 +365,7 @@ test_expect_success 'diff-files: --no-indent-heuristic overrides config' '
 	git -c diff.indentHeuristic=true diff-files --no-indent-heuristic -p spaces.txt >out-diff-files-raw4 &&
 	grep -v index out-diff-files-raw4 >out-diff-files &&
 	compare_diff spaces-expect out-diff-files &&
-	git checkout -f master
+	git checkout -f main
 '
 
 test_done
diff --git a/t/t4066-diff-emit-delay.sh b/t/t4066-diff-emit-delay.sh
index 1983f1ebbe..a1de63b77f 100755
--- a/t/t4066-diff-emit-delay.sh
+++ b/t/t4066-diff-emit-delay.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='test combined/stat/moved interaction'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -16,7 +16,7 @@ test_expect_success 'set up history with a merge' '
 	test_commit B &&
 	git checkout -b side HEAD^ &&
 	test_commit C &&
-	git merge -m M master &&
+	git merge -m M main &&
 	test_commit D
 '
 
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index 55d47352ba..2d650d8f10 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -2,17 +2,17 @@
 
 test_description='behavior of diff with symmetric-diff setups and --merge-base'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
 # build these situations:
 #  - normal merge with one merge base (br1...b2r);
-#  - criss-cross merge ie 2 merge bases (br1...master);
-#  - disjoint subgraph (orphan branch, br3...master).
+#  - criss-cross merge ie 2 merge bases (br1...main);
+#  - disjoint subgraph (orphan branch, br3...main).
 #
-#     B---E   <-- master
+#     B---E   <-- main
 #    / \ /
 #   A   X
 #    \ / \
@@ -35,9 +35,9 @@ test_expect_success setup '
 	git add c &&
 	git commit -m C &&
 	git tag commit-C &&
-	git merge -m D master &&
+	git merge -m D main &&
 	git tag commit-D &&
-	git checkout master &&
+	git checkout main &&
 	git merge -m E commit-C &&
 	git checkout -b br2 commit-C &&
 	echo f >f &&
@@ -61,7 +61,7 @@ test_expect_success 'diff with one merge base' '
 # It should have one of those two, which comes out
 # to seven lines.
 test_expect_success 'diff with two merge bases' '
-	git diff br1...master >tmp 2>err &&
+	git diff br1...main >tmp 2>err &&
 	test_line_count = 7 tmp &&
 	test_line_count = 1 err
 '
@@ -72,22 +72,22 @@ test_expect_success 'diff with no merge bases' '
 '
 
 test_expect_success 'diff with too many symmetric differences' '
-	test_must_fail git diff br1...master br2...br3 2>err &&
+	test_must_fail git diff br1...main br2...br3 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with symmetric difference and extraneous arg' '
-	test_must_fail git diff master br1...master 2>err &&
+	test_must_fail git diff main br1...main 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with two ranges' '
-	test_must_fail git diff master br1..master br2..br3 2>err &&
+	test_must_fail git diff main br1..main br2..br3 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with ranges and extra arg' '
-	test_must_fail git diff master br1..master commit-D 2>err &&
+	test_must_fail git diff main br1..main commit-D 2>err &&
 	test_i18ngrep "usage" err
 '
 
@@ -96,21 +96,21 @@ test_expect_success 'diff --merge-base with no commits' '
 '
 
 test_expect_success 'diff --merge-base with three commits' '
-	test_must_fail git diff --merge-base br1 br2 master 2>err &&
+	test_must_fail git diff --merge-base br1 br2 main 2>err &&
 	test_i18ngrep "usage" err
 '
 
 for cmd in diff-index diff
 do
 	test_expect_success "$cmd --merge-base with one commit" '
-		git checkout master &&
+		git checkout main &&
 		git $cmd commit-C >expect &&
 		git $cmd --merge-base br2 >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "$cmd --merge-base with one commit and unstaged changes" '
-		git checkout master &&
+		git checkout main &&
 		test_when_finished git reset --hard &&
 		echo unstaged >>c &&
 		git $cmd commit-C >expect &&
@@ -119,7 +119,7 @@ do
 	'
 
 	test_expect_success "$cmd --merge-base with one commit and staged and unstaged changes" '
-		git checkout master &&
+		git checkout main &&
 		test_when_finished git reset --hard &&
 		echo staged >>c &&
 		git add c &&
@@ -130,7 +130,7 @@ do
 	'
 
 	test_expect_success "$cmd --merge-base --cached with one commit and staged and unstaged changes" '
-		git checkout master &&
+		git checkout main &&
 		test_when_finished git reset --hard &&
 		echo staged >>c &&
 		git add c &&
@@ -141,19 +141,19 @@ do
 	'
 
 	test_expect_success "$cmd --merge-base with non-commit" '
-		git checkout master &&
-		test_must_fail git $cmd --merge-base master^{tree} 2>err &&
+		git checkout main &&
+		test_must_fail git $cmd --merge-base main^{tree} 2>err &&
 		test_i18ngrep "fatal: --merge-base only works with commits" err
 	'
 
 	test_expect_success "$cmd --merge-base with no merge bases and one commit" '
-		git checkout master &&
+		git checkout main &&
 		test_must_fail git $cmd --merge-base br3 2>err &&
 		test_i18ngrep "fatal: no merge base found" err
 	'
 
 	test_expect_success "$cmd --merge-base with multiple merge bases and one commit" '
-		git checkout master &&
+		git checkout main &&
 		test_must_fail git $cmd --merge-base br1 2>err &&
 		test_i18ngrep "fatal: multiple merge bases found" err
 	'
@@ -162,13 +162,13 @@ done
 for cmd in diff-tree diff
 do
 	test_expect_success "$cmd --merge-base with two commits" '
-		git $cmd commit-C master >expect &&
-		git $cmd --merge-base br2 master >actual &&
+		git $cmd commit-C main >expect &&
+		git $cmd --merge-base br2 main >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "$cmd --merge-base commit and non-commit" '
-		test_must_fail git $cmd --merge-base br2 master^{tree} 2>err &&
+		test_must_fail git $cmd --merge-base br2 main^{tree} 2>err &&
 		test_i18ngrep "fatal: --merge-base only works with commits" err
 	'
 
@@ -178,13 +178,13 @@ do
 	'
 
 	test_expect_success "$cmd --merge-base with multiple merge bases and two commits" '
-		test_must_fail git $cmd --merge-base master br1 2>err &&
+		test_must_fail git $cmd --merge-base main br1 2>err &&
 		test_i18ngrep "fatal: multiple merge bases found" err
 	'
 done
 
 test_expect_success 'diff-tree --merge-base with one commit' '
-	test_must_fail git diff-tree --merge-base master 2>err &&
+	test_must_fail git diff-tree --merge-base main 2>err &&
 	test_i18ngrep "fatal: --merge-base only works with two commits" err
 '
 
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index ee4a74b132..fad6d3f542 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -6,7 +6,7 @@
 test_description='git apply handling binary patches
 
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -34,64 +34,64 @@ test_expect_success 'setup' '
 	git update-index --add --remove file1 file2 file3 file4 &&
 	git commit -m "Second Version" &&
 
-	git diff-tree -p master binary >B.diff &&
-	git diff-tree -p -C master binary >C.diff &&
+	git diff-tree -p main binary >B.diff &&
+	git diff-tree -p -C main binary >C.diff &&
 
-	git diff-tree -p --binary master binary >BF.diff &&
-	git diff-tree -p --binary -C master binary >CF.diff &&
+	git diff-tree -p --binary main binary >BF.diff &&
+	git diff-tree -p --binary -C main binary >CF.diff &&
 
-	git diff-tree -p --full-index master binary >B-index.diff &&
-	git diff-tree -p -C --full-index master binary >C-index.diff &&
+	git diff-tree -p --full-index main binary >B-index.diff &&
+	git diff-tree -p -C --full-index main binary >C-index.diff &&
 
-	git diff-tree -p --binary --no-prefix master binary -- file3 >B0.diff &&
+	git diff-tree -p --binary --no-prefix main binary -- file3 >B0.diff &&
 
 	git init other-repo &&
 	(
 		cd other-repo &&
-		git fetch .. master &&
+		git fetch .. main &&
 		git reset --hard FETCH_HEAD
 	)
 '
 
 test_expect_success 'stat binary diff -- should not fail.' \
-	'git checkout master &&
+	'git checkout main &&
 	 git apply --stat --summary B.diff'
 
 test_expect_success 'stat binary -p0 diff -- should not fail.' '
-	 git checkout master &&
+	 git checkout main &&
 	 git apply --stat -p0 B0.diff
 '
 
 test_expect_success 'stat binary diff (copy) -- should not fail.' \
-	'git checkout master &&
+	'git checkout main &&
 	 git apply --stat --summary C.diff'
 
 test_expect_success 'check binary diff -- should fail.' \
-	'git checkout master &&
+	'git checkout main &&
 	 test_must_fail git apply --check B.diff'
 
 test_expect_success 'check binary diff (copy) -- should fail.' \
-	'git checkout master &&
+	'git checkout main &&
 	 test_must_fail git apply --check C.diff'
 
 test_expect_success \
 	'check incomplete binary diff with replacement -- should fail.' '
-	git checkout master &&
+	git checkout main &&
 	test_must_fail git apply --check --allow-binary-replacement B.diff
 '
 
 test_expect_success \
     'check incomplete binary diff with replacement (copy) -- should fail.' '
-	 git checkout master &&
+	 git checkout main &&
 	 test_must_fail git apply --check --allow-binary-replacement C.diff
 '
 
 test_expect_success 'check binary diff with replacement.' \
-	'git checkout master &&
+	'git checkout main &&
 	 git apply --check --allow-binary-replacement BF.diff'
 
 test_expect_success 'check binary diff with replacement (copy).' \
-	'git checkout master &&
+	'git checkout main &&
 	 git apply --check --allow-binary-replacement CF.diff'
 
 # Now we start applying them.
@@ -99,7 +99,7 @@ test_expect_success 'check binary diff with replacement (copy).' \
 do_reset () {
 	rm -f file? &&
 	git reset --hard &&
-	git checkout -f master
+	git checkout -f main
 }
 
 test_expect_success 'apply binary diff -- should fail.' \
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 0a091dc5a0..d62db3fbe1 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -2,7 +2,7 @@
 
 test_description='git apply --3way'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -27,14 +27,14 @@ test_expect_success setup '
 	test_tick &&
 	test_write_lines 1 two 3 4 5 six 7 >one &&
 	test_write_lines 1 two 3 4 5 6 7 >two &&
-	git commit -a -m master &&
+	git commit -a -m main &&
 
 	git checkout side &&
 	test_write_lines 1 2 3 4 five 6 7 >one &&
 	test_write_lines 1 2 3 4 five 6 7 >two &&
 	git commit -a -m side &&
 
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'apply without --3way' '
@@ -42,7 +42,7 @@ test_expect_success 'apply without --3way' '
 
 	# should fail to apply
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	test_must_fail git apply --index P.diff &&
 	# should leave things intact
 	git diff-files --exit-code &&
@@ -55,14 +55,14 @@ test_apply_with_3way () {
 
 	# The corresponding conflicted merge
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	test_must_fail git merge --no-commit side &&
 	git ls-files -s >expect.ls &&
 	print_sanitized_conflicted_diff >expect.diff &&
 
 	# should fail to apply
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	test_must_fail git apply --index --3way P.diff &&
 	git ls-files -s >actual.ls &&
 	print_sanitized_conflicted_diff >actual.diff &&
@@ -89,7 +89,7 @@ test_expect_success 'apply with --3way with rerere enabled' '
 
 	# The corresponding conflicted merge
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	test_must_fail git merge --no-commit side &&
 
 	# Manually resolve and record the resolution
@@ -99,7 +99,7 @@ test_expect_success 'apply with --3way with rerere enabled' '
 
 	# should fail to apply
 	git reset --hard &&
-	git checkout master^0 &&
+	git checkout main^0 &&
 	test_must_fail git apply --index --3way P.diff &&
 
 	# but rerere should have replayed the recorded resolution
diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
index 60deb3bf78..b45454aaf4 100755
--- a/t/t4121-apply-diffs.sh
+++ b/t/t4121-apply-diffs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git apply for contextually independent diffs'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -26,7 +26,7 @@ test_expect_success 'setup' \
 	git commit -a -q -m 2 &&
 	echo 9 >>file &&
 	git commit -a -q -m 3 &&
-	git checkout master'
+	git checkout main'
 
 test_expect_success \
 	'check if contextually independent diffs for the same file apply' \
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 71deaf779d..aa52de401b 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='apply to deeper directory without getting fooled with symlink'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -38,11 +38,11 @@ test_expect_success apply '
 
 test_expect_success 'check result' '
 
-	git diff --exit-code master &&
-	git diff --exit-code --cached master &&
+	git diff --exit-code main &&
+	git diff --exit-code --cached main &&
 	test_tick &&
 	git commit -m replay &&
-	T1=$(git rev-parse "master^{tree}") &&
+	T1=$(git rev-parse "main^{tree}") &&
 	T2=$(git rev-parse "HEAD^{tree}") &&
 	test "z$T1" = "z$T2"
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index e1ffc04852..99987515dc 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -2,7 +2,7 @@
 
 test_description='git am running'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -182,8 +182,8 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m "added another file" &&
 
-	git format-patch --stdout master >lorem-move.patch &&
-	git format-patch --no-prefix --stdout master >lorem-zero.patch &&
+	git format-patch --stdout main >lorem-move.patch &&
+	git format-patch --no-prefix --stdout main >lorem-zero.patch &&
 
 	git checkout -b rename &&
 	git mv file renamed &&
@@ -456,11 +456,11 @@ test_expect_success 'am changes committer and keeps author' '
 	git checkout first &&
 	git am patch2 &&
 	test_path_is_missing .git/rebase-apply &&
-	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
-	git diff --exit-code master..HEAD &&
-	git diff --exit-code master^..HEAD^ &&
-	compare author master HEAD &&
-	compare author master^ HEAD^ &&
+	test "$(git rev-parse main^^)" = "$(git rev-parse HEAD^^)" &&
+	git diff --exit-code main..HEAD &&
+	git diff --exit-code main^..HEAD^ &&
+	compare author main HEAD &&
+	compare author main^ HEAD^ &&
 	test "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" = \
 	     "$(git log -1 --pretty=format:"%cn <%ce>" HEAD)"
 '
@@ -762,7 +762,7 @@ test_expect_success 'am takes patches from a Pine mailbox' '
 	git checkout first &&
 	cat pine patch1 | git am &&
 	test_path_is_missing .git/rebase-apply &&
-	git diff --exit-code master^..HEAD
+	git diff --exit-code main^..HEAD
 '
 
 test_expect_success 'am fails on mail without patch' '
@@ -1115,21 +1115,21 @@ test_expect_success 'am and .gitattibutes' '
 		test_commit sixth &&
 
 		git checkout test &&
-		git format-patch --stdout master..HEAD >patches &&
-		git reset --hard master &&
+		git format-patch --stdout main..HEAD >patches &&
+		git reset --hard main &&
 		git am patches &&
 		grep "smudged" a.txt &&
 
 		git checkout removal &&
 		git reset --hard &&
-		git format-patch --stdout master..HEAD >patches &&
-		git reset --hard master &&
+		git format-patch --stdout main..HEAD >patches &&
+		git reset --hard main &&
 		git am patches &&
 		grep "clean" a.txt &&
 
 		git checkout conflict &&
 		git reset --hard &&
-		git format-patch --stdout master..HEAD >patches &&
+		git format-patch --stdout main..HEAD >patches &&
 		git reset --hard fourth &&
 		test_must_fail git am -3 patches &&
 		grep "<<<<<<<<<<" a.txt
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 1f1a809c60..9f8c76dffb 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -8,7 +8,7 @@ test_description='git rerere
 ! [fifth] version1
  ! [first] first
   ! [fourth] version1
-   ! [master] initial
+   ! [main] initial
     ! [second] prefer first over second
      ! [third] version2
 ------
@@ -19,10 +19,10 @@ test_description='git rerere
     -  [second] prefer first over second
  +  +  [first] first
     +  [second^] second
-++++++ [master] initial
+++++++ [main] initial
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -60,7 +60,7 @@ test_expect_success 'setup' '
 	test_tick &&
 	git commit -q -a -m first &&
 
-	git checkout -b second master &&
+	git checkout -b second main &&
 	git show first:a1 |
 	sed -e "s/To die, t/To die! T/" -e "s/Some title/Some Title/" >a1 &&
 	echo "* END *" >>a1 &&
@@ -171,7 +171,7 @@ test_expect_success 'first postimage wins' '
 
 	oldmtimepost=$(test-tool chmtime --get -60 $rr/postimage) &&
 
-	git checkout -b third master &&
+	git checkout -b third main &&
 	git show second^:a1 | sed "s/To die: t/To die! T/" >a1 &&
 	git commit -q -a -m third &&
 
@@ -583,13 +583,13 @@ test_expect_success 'multiple identical conflicts' '
 test_expect_success 'rerere with unexpected conflict markers does not crash' '
 	git reset --hard &&
 
-	git checkout -b branch-1 master &&
+	git checkout -b branch-1 main &&
 	echo "bar" >test &&
 	git add test &&
 	git commit -q -m two &&
 
 	git reset --hard &&
-	git checkout -b branch-2 master &&
+	git checkout -b branch-2 main &&
 	echo "foo" >test &&
 	git add test &&
 	git commit -q -a -m one &&
@@ -604,7 +604,7 @@ test_expect_success 'rerere with unexpected conflict markers does not crash' '
 test_expect_success 'rerere with inner conflict markers' '
 	git reset --hard &&
 
-	git checkout -b A master &&
+	git checkout -b A main &&
 	echo "bar" >test &&
 	git add test &&
 	git commit -q -m two &&
@@ -613,7 +613,7 @@ test_expect_success 'rerere with inner conflict markers' '
 	git commit -q -m three &&
 
 	git reset --hard &&
-	git checkout -b B master &&
+	git checkout -b B main &&
 	echo "foo" >test &&
 	git add test &&
 	git commit -q -a -m one &&
@@ -654,11 +654,11 @@ test_expect_success 'setup simple stage 1 handling' '
 		git add original &&
 		git commit -m original &&
 
-		git checkout -b A master &&
+		git checkout -b A main &&
 		git mv original A &&
 		git commit -m "rename to A" &&
 
-		git checkout -b B master &&
+		git checkout -b B main &&
 		git mv original B &&
 		git commit -m "rename to B"
 	)
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index ad6d3eebe5..3095b1b2ff 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -6,7 +6,7 @@
 test_description='git shortlog
 '
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -194,7 +194,7 @@ test_expect_success 'shortlog with revision pseudo options' '
 '
 
 test_expect_success 'shortlog with --output=<file>' '
-	git shortlog --output=shortlog -1 master >output &&
+	git shortlog --output=shortlog -1 main >output &&
 	test_must_be_empty output &&
 	test_line_count = 3 shortlog
 '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6c7a3cfc2c..350cfa3593 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2,7 +2,7 @@
 
 test_description='git log'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -481,7 +481,7 @@ test_expect_success 'set up merge history' '
 	git checkout -b side HEAD~4 &&
 	test_commit side-1 1 1 &&
 	test_commit side-2 2 2 &&
-	git checkout master &&
+	git checkout main &&
 	git merge side
 '
 
@@ -544,17 +544,17 @@ test_expect_success 'log --graph with merge with log.graphColors' '
 '
 
 test_expect_success 'log --raw --graph -m with merge' '
-	git log --raw --graph --oneline -m master | head -n 500 >actual &&
+	git log --raw --graph --oneline -m main | head -n 500 >actual &&
 	grep "initial" actual
 '
 
 test_expect_success 'diff-tree --graph' '
-	git diff-tree --graph master^ | head -n 500 >actual &&
+	git diff-tree --graph main^ | head -n 500 >actual &&
 	grep "one" actual
 '
 
 cat > expect <<\EOF
-*   commit master
+*   commit main
 |\  Merge: A B
 | | Author: A U Thor <author@example.com>
 | |
@@ -570,22 +570,22 @@ cat > expect <<\EOF
 | |
 | |     side-1
 | |
-* | commit master~1
+* | commit main~1
 | | Author: A U Thor <author@example.com>
 | |
 | |     Second
 | |
-* | commit master~2
+* | commit main~2
 | | Author: A U Thor <author@example.com>
 | |
 | |     sixth
 | |
-* | commit master~3
+* | commit main~3
 | | Author: A U Thor <author@example.com>
 | |
 | |     fifth
 | |
-* | commit master~4
+* | commit main~4
 |/  Author: A U Thor <author@example.com>
 |
 |       fourth
@@ -616,19 +616,19 @@ test_expect_success 'log --graph with full output' '
 test_expect_success 'set up more tangled history' '
 	git checkout -b tangle HEAD~6 &&
 	test_commit tangle-a tangle-a a &&
-	git merge master~3 &&
+	git merge main~3 &&
 	git merge side~1 &&
-	git checkout master &&
+	git checkout main &&
 	git merge tangle &&
 	git checkout -b reach &&
 	test_commit reach &&
-	git checkout master &&
+	git checkout main &&
 	git checkout -b octopus-a &&
 	test_commit octopus-a &&
-	git checkout master &&
+	git checkout main &&
 	git checkout -b octopus-b &&
 	test_commit octopus-b &&
-	git checkout master &&
+	git checkout main &&
 	test_commit seventh &&
 	git merge octopus-a octopus-b &&
 	git merge reach
@@ -653,7 +653,7 @@ cat > expect <<\EOF
 |\
 | *   Merge branch 'side' (early part) into tangle
 | |\
-| * \   Merge branch 'master' (early part) into tangle
+| * \   Merge branch 'main' (early part) into tangle
 | |\ \
 | * | | tangle-a
 * | | |   Merge branch 'side'
@@ -797,7 +797,7 @@ test_expect_success 'multiple decorate-refs' '
 
 test_expect_success 'decorate-refs-exclude with glob' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach (HEAD -> master)
+	Merge-tag-reach (HEAD -> main)
 	Merge-tags-octopus-a-and-octopus-b
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
@@ -814,7 +814,7 @@ test_expect_success 'decorate-refs-exclude with glob' '
 
 test_expect_success 'decorate-refs-exclude without globs' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach (HEAD -> master)
+	Merge-tag-reach (HEAD -> main)
 	Merge-tags-octopus-a-and-octopus-b
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b, octopus-b)
@@ -831,7 +831,7 @@ test_expect_success 'decorate-refs-exclude without globs' '
 
 test_expect_success 'multiple decorate-refs-exclude' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach (HEAD -> master)
+	Merge-tag-reach (HEAD -> main)
 	Merge-tags-octopus-a-and-octopus-b
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
@@ -854,7 +854,7 @@ test_expect_success 'multiple decorate-refs-exclude' '
 
 test_expect_success 'decorate-refs and decorate-refs-exclude' '
 	cat >expect.no-decorate <<-\EOF &&
-	Merge-tag-reach (master)
+	Merge-tag-reach (main)
 	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b
@@ -869,7 +869,7 @@ test_expect_success 'decorate-refs and decorate-refs-exclude' '
 
 test_expect_success 'deocrate-refs and log.excludeDecoration' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach (master)
+	Merge-tag-reach (main)
 	Merge-tags-octopus-a-and-octopus-b
 	seventh
 	octopus-b (octopus-b)
@@ -884,7 +884,7 @@ test_expect_success 'deocrate-refs and log.excludeDecoration' '
 
 test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	cat >expect.decorate <<-\EOF &&
-	Merge-tag-reach (HEAD -> master)
+	Merge-tag-reach (HEAD -> main)
 	reach (tag: reach, reach)
 	seventh (tag: seventh)
 	Merge-branch-tangle
@@ -1083,7 +1083,7 @@ cat >expect <<\EOF
 | |\ \  Merge: MERGE_PARENTS
 | | | | Author: A U Thor <author@example.com>
 | | | |
-| | | |     Merge branch 'master' (early part) into tangle
+| | | |     Merge branch 'main' (early part) into tangle
 | | | |
 | * | | commit COMMIT_OBJECT_NAME
 | | | | Author: A U Thor <author@example.com>
@@ -1358,7 +1358,7 @@ cat >expect <<\EOF
 *** | |\ \  Merge: MERGE_PARENTS
 *** | | | | Author: A U Thor <author@example.com>
 *** | | | |
-*** | | | |     Merge branch 'master' (early part) into tangle
+*** | | | |     Merge branch 'main' (early part) into tangle
 *** | | | |
 *** | * | | commit COMMIT_OBJECT_NAME
 *** | | | | Author: A U Thor <author@example.com>
@@ -1591,24 +1591,24 @@ test_expect_success 'dotdot is a parent directory' '
 '
 
 test_expect_success GPG 'setup signed branch' '
-	test_when_finished "git reset --hard && git checkout master" &&
-	git checkout -b signed master &&
+	test_when_finished "git reset --hard && git checkout main" &&
+	git checkout -b signed main &&
 	echo foo >foo &&
 	git add foo &&
 	git commit -S -m signed_commit
 '
 
 test_expect_success GPG 'setup signed branch with subkey' '
-	test_when_finished "git reset --hard && git checkout master" &&
-	git checkout -b signed-subkey master &&
+	test_when_finished "git reset --hard && git checkout main" &&
+	git checkout -b signed-subkey main &&
 	echo foo >foo &&
 	git add foo &&
 	git commit -SB7227189 -m signed_commit
 '
 
 test_expect_success GPGSM 'setup signed branch x509' '
-	test_when_finished "git reset --hard && git checkout master" &&
-	git checkout -b signed-x509 master &&
+	test_when_finished "git reset --hard && git checkout main" &&
+	git checkout -b signed-x509 main &&
 	echo foo >foo &&
 	git add foo &&
 	test_config gpg.format x509 &&
@@ -1641,12 +1641,12 @@ test_expect_success GPGSM 'log --graph --show-signature x509' '
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
-	test_when_finished "git reset --hard && git checkout master" &&
-	git checkout -b plain master &&
+	test_when_finished "git reset --hard && git checkout main" &&
+	git checkout -b plain main &&
 	echo aaa >bar &&
 	git add bar &&
 	git commit -m bar_commit &&
-	git checkout -b tagged master &&
+	git checkout -b tagged main &&
 	echo bbb >baz &&
 	git add baz &&
 	git commit -m baz_commit &&
@@ -1660,12 +1660,12 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag in shallow clone' '
-	test_when_finished "git reset --hard && git checkout master" &&
-	git checkout -b plain-shallow master &&
+	test_when_finished "git reset --hard && git checkout main" &&
+	git checkout -b plain-shallow main &&
 	echo aaa >bar &&
 	git add bar &&
 	git commit -m bar_commit &&
-	git checkout --detach master &&
+	git checkout --detach main &&
 	echo bbb >baz &&
 	git add baz &&
 	git commit -m baz_commit &&
@@ -1680,12 +1680,12 @@ test_expect_success GPG 'log --graph --show-signature for merged tag in shallow
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag with missing key' '
-	test_when_finished "git reset --hard && git checkout master" &&
-	git checkout -b plain-nokey master &&
+	test_when_finished "git reset --hard && git checkout main" &&
+	git checkout -b plain-nokey main &&
 	echo aaa >bar &&
 	git add bar &&
 	git commit -m bar_commit &&
-	git checkout -b tagged-nokey master &&
+	git checkout -b tagged-nokey main &&
 	echo bbb >baz &&
 	git add baz &&
 	git commit -m baz_commit &&
@@ -1699,12 +1699,12 @@ test_expect_success GPG 'log --graph --show-signature for merged tag with missin
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag with bad signature' '
-	test_when_finished "git reset --hard && git checkout master" &&
-	git checkout -b plain-bad master &&
+	test_when_finished "git reset --hard && git checkout main" &&
+	git checkout -b plain-bad main &&
 	echo aaa >bar &&
 	git add bar &&
 	git commit -m bar_commit &&
-	git checkout -b tagged-bad master &&
+	git checkout -b tagged-bad main &&
 	echo bbb >baz &&
 	git add baz &&
 	git commit -m baz_commit &&
@@ -1721,12 +1721,12 @@ test_expect_success GPG 'log --graph --show-signature for merged tag with bad si
 '
 
 test_expect_success GPG 'log --show-signature for merged tag with GPG failure' '
-	test_when_finished "git reset --hard && git checkout master" &&
-	git checkout -b plain-fail master &&
+	test_when_finished "git reset --hard && git checkout main" &&
+	git checkout -b plain-fail main &&
 	echo aaa >bar &&
 	git add bar &&
 	git commit -m bar_commit &&
-	git checkout -b tagged-fail master &&
+	git checkout -b tagged-fail main &&
 	echo bbb >baz &&
 	git add baz &&
 	git commit -m baz_commit &&
@@ -1740,14 +1740,14 @@ test_expect_success GPG 'log --show-signature for merged tag with GPG failure' '
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
-	test_when_finished "git reset --hard && git checkout master" &&
+	test_when_finished "git reset --hard && git checkout main" &&
 	test_config gpg.format x509 &&
 	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
-	git checkout -b plain-x509 master &&
+	git checkout -b plain-x509 main &&
 	echo aaa >bar &&
 	git add bar &&
 	git commit -m bar_commit &&
-	git checkout -b tagged-x509 master &&
+	git checkout -b tagged-x509 main &&
 	echo bbb >baz &&
 	git add baz &&
 	git commit -m baz_commit &&
@@ -1761,14 +1761,14 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 missing key' '
-	test_when_finished "git reset --hard && git checkout master" &&
+	test_when_finished "git reset --hard && git checkout main" &&
 	test_config gpg.format x509 &&
 	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
-	git checkout -b plain-x509-nokey master &&
+	git checkout -b plain-x509-nokey main &&
 	echo aaa >bar &&
 	git add bar &&
 	git commit -m bar_commit &&
-	git checkout -b tagged-x509-nokey master &&
+	git checkout -b tagged-x509-nokey main &&
 	echo bbb >baz &&
 	git add baz &&
 	git commit -m baz_commit &&
@@ -1781,14 +1781,14 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad signature' '
-	test_when_finished "git reset --hard && git checkout master" &&
+	test_when_finished "git reset --hard && git checkout main" &&
 	test_config gpg.format x509 &&
 	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
-	git checkout -b plain-x509-bad master &&
+	git checkout -b plain-x509-bad main &&
 	echo aaa >bar &&
 	git add bar &&
 	git commit -m bar_commit &&
-	git checkout -b tagged-x509-bad master &&
+	git checkout -b tagged-x509-bad main &&
 	echo bbb >baz &&
 	git add baz &&
 	git commit -m baz_commit &&
@@ -1838,7 +1838,7 @@ test_expect_success 'log diagnoses bogus HEAD' '
 	git init empty &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep does.not.have.any.commits stderr &&
-	echo 1234abcd >empty/.git/refs/heads/master &&
+	echo 1234abcd >empty/.git/refs/heads/main &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep broken stderr &&
 	echo "ref: refs/heads/invalid.lock" >empty/.git/HEAD &&
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 8a2f8984f6..3f82c651b4 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -2,7 +2,7 @@
 
 test_description='.mailmap configurations'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -197,7 +197,7 @@ test_expect_success 'No mailmap files, but configured' '
 
 test_expect_success 'setup mailmap blob tests' '
 	git checkout -b map &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	cat >just-bugs <<- EOF &&
 	Blob Guy <bugs@company.xx>
 	EOF
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 46ecb777f4..f120857c20 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -2,7 +2,7 @@
 
 test_description='git patch-id'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -16,9 +16,9 @@ test_expect_success 'setup' '
 	test_write_lines $as b >foo &&
 	test_write_lines $as b >bar &&
 	git commit -a -m first &&
-	git checkout -b same master &&
+	git checkout -b same main &&
 	git commit --amend -m same-msg &&
-	git checkout -b notsame master &&
+	git checkout -b notsame main &&
 	echo c >foo &&
 	echo c >bar &&
 	git commit --amend -a -m notsame-msg &&
@@ -49,31 +49,31 @@ get_patch_id () {
 }
 
 test_expect_success 'patch-id detects equality' '
-	get_patch_id master &&
+	get_patch_id main &&
 	get_patch_id same &&
-	test_cmp patch-id_master patch-id_same
+	test_cmp patch-id_main patch-id_same
 '
 
 test_expect_success 'patch-id detects inequality' '
-	get_patch_id master &&
+	get_patch_id main &&
 	get_patch_id notsame &&
-	! test_cmp patch-id_master patch-id_notsame
+	! test_cmp patch-id_main patch-id_notsame
 '
 
 test_expect_success 'patch-id supports git-format-patch output' '
-	get_patch_id master &&
+	get_patch_id main &&
 	git checkout same &&
 	git format-patch -1 --stdout | calc_patch_id same &&
-	test_cmp patch-id_master patch-id_same &&
+	test_cmp patch-id_main patch-id_same &&
 	set $(git format-patch -1 --stdout | git patch-id) &&
 	test "$2" = $(git rev-parse HEAD)
 '
 
 test_expect_success 'whitespace is irrelevant in footer' '
-	get_patch_id master &&
+	get_patch_id main &&
 	git checkout same &&
 	git format-patch -1 --stdout | sed "s/ \$//" | calc_patch_id same &&
-	test_cmp patch-id_master patch-id_same
+	test_cmp patch-id_main patch-id_same
 '
 
 cmp_patch_id () {
@@ -91,7 +91,7 @@ test_patch_id_file_order () {
 	shift
 	name="order-${1}-$relevant"
 	shift
-	get_top_diff "master" | calc_patch_id "$name" "$@" &&
+	get_top_diff "main" | calc_patch_id "$name" "$@" &&
 	git checkout same &&
 	git format-patch -1 --stdout -O foo-then-bar |
 		calc_patch_id "ordered-$name" "$@" &&
@@ -140,10 +140,10 @@ test_expect_success '--stable overrides patchid.stable = false' '
 '
 
 test_expect_success 'patch-id supports git-format-patch MIME output' '
-	get_patch_id master &&
+	get_patch_id main &&
 	git checkout same &&
 	git format-patch -1 --attach --stdout | calc_patch_id same &&
-	test_cmp patch-id_master patch-id_same
+	test_cmp patch-id_main patch-id_same
 '
 
 test_expect_success 'patch-id respects config from subdir' '
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 6c868df38d..b870942498 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -5,7 +5,7 @@
 
 test_description='Test for "git log --decorate" colors'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -43,13 +43,13 @@ test_expect_success setup '
 
 cat >expected <<EOF
 ${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD ->\
- ${c_reset}${c_branch}master${c_reset}${c_commit},\
+ ${c_reset}${c_branch}main${c_reset}${c_commit},\
  ${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit},\
  ${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
 ${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit},\
- ${c_reset}${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset} A1
+ ${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
 ${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset}\
- On master: Changes to A.t
+ On main: Changes to A.t
 ${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
 EOF
 
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 1938d4a58f..5e10136e9a 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -2,7 +2,7 @@
 
 test_description='magic pathspec tests using git-log'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -29,7 +29,7 @@ test_expect_success '"git log :/a -- " should not be ambiguous' '
 '
 
 test_expect_success '"git log :/detached -- " should find a commit only in HEAD' '
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git checkout --detach &&
 	# Must manually call `test_tick` instead of using `test_commit`,
 	# because the latter additionally creates a tag, which would make
@@ -122,7 +122,7 @@ test_expect_success 'command line pathspec parsing for "git log"' '
 	git checkout HEAD^ &&
 	echo 2 >a &&
 	git commit -a -m "update a to 2" &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	git add a &&
 	git log --merge -- a
 '
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 59c258429d..560127cc07 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='test log -L'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
diff --git a/t/t4211/history.export b/t/t4211/history.export
index f9f41e211e..006972a1f2 100644
--- a/t/t4211/history.export
+++ b/t/t4211/history.export
@@ -316,7 +316,7 @@ long f(long x)
 	return s;
 }
 
-commit refs/heads/master
+commit refs/heads/main
 mark :19
 author Thomas Rast <trast@student.ethz.ch> 1362045024 +0100
 committer Thomas Rast <trast@student.ethz.ch> 1362045024 +0100
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 981b83513a..f70c46bbbf 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -2,7 +2,7 @@
 
 test_description='git log --graph of skewed left octopus merge.'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -20,7 +20,7 @@ test_cmp_colored_graph () {
 test_expect_success 'set up merge history' '
 	test_commit initial &&
 	for i in 1 2 3 4 ; do
-		git checkout master -b $i || return $?
+		git checkout main -b $i || return $?
 		# Make tag name different from branch name, to avoid
 		# ambiguity error when calling checkout.
 		test_commit $i $i $i tag$i || return $?
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index b3f3820dbb..0f16c4b9d5 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git log for a path with Bloom filters'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -24,7 +24,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	test_commit c10 file_to_be_deleted &&
 	git checkout -b side HEAD~4 &&
 	test_commit side-1 file4 &&
-	git checkout master &&
+	git checkout main &&
 	git merge side &&
 	test_commit c11 file5 &&
 	mv file5 file5_renamed &&
@@ -97,7 +97,7 @@ do
 		      "--topo-order" \
 		      "--date-order" \
 		      "--author-date-order" \
-		      "--ancestry-path side..master"
+		      "--ancestry-path side..main"
 	do
 		test_expect_success "git log option: $option for path: $path" '
 			test_bloom_filters_used "$option -- $path" &&
diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
index ec7ba62d67..0ee69d2a0c 100755
--- a/t/t4253-am-keep-cr-dos.sh
+++ b/t/t4253-am-keep-cr-dos.sh
@@ -6,7 +6,7 @@
 test_description='git-am mbox with dos line ending.
 
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -46,7 +46,7 @@ test_expect_success 'setup repository with dos files' '
 
 test_expect_success 'am with dos files without --keep-cr' '
 	git checkout -b dosfiles initial &&
-	git format-patch -k initial..master &&
+	git format-patch -k initial..main &&
 	test_must_fail git am -k -3 000*.patch &&
 	git am --abort &&
 	rm -rf .git/rebase-apply 000*.patch
@@ -54,23 +54,23 @@ test_expect_success 'am with dos files without --keep-cr' '
 
 test_expect_success 'am with dos files with --keep-cr' '
 	git checkout -b dosfiles-keep-cr initial &&
-	git format-patch -k --stdout initial..master >output &&
+	git format-patch -k --stdout initial..main >output &&
 	git am --keep-cr -k -3 output &&
-	git diff --exit-code master
+	git diff --exit-code main
 '
 
 test_expect_success 'am with dos files config am.keepcr' '
 	git config am.keepcr 1 &&
 	git checkout -b dosfiles-conf-keepcr initial &&
-	git format-patch -k --stdout initial..master >output &&
+	git format-patch -k --stdout initial..main >output &&
 	git am -k -3 output &&
-	git diff --exit-code master
+	git diff --exit-code main
 '
 
 test_expect_success 'am with dos files config am.keepcr overridden by --no-keep-cr' '
 	git config am.keepcr 1 &&
 	git checkout -b dosfiles-conf-keepcr-override initial &&
-	git format-patch -k initial..master &&
+	git format-patch -k initial..main &&
 	test_must_fail git am -k -3 --no-keep-cr 000*.patch &&
 	git am --abort &&
 	rm -rf .git/rebase-apply 000*.patch
@@ -78,14 +78,14 @@ test_expect_success 'am with dos files config am.keepcr overridden by --no-keep-
 
 test_expect_success 'am with dos files with --keep-cr continue' '
 	git checkout -b dosfiles-keep-cr-continue initial &&
-	git format-patch -k initial..master &&
+	git format-patch -k initial..main &&
 	append_cr <file1a >file &&
 	git commit -m "different patch" file &&
 	test_must_fail git am --keep-cr -k -3 000*.patch &&
 	append_cr <file2 >file &&
 	git add file &&
 	git am -3 --resolved &&
-	git diff --exit-code master
+	git diff --exit-code main
 '
 
 test_expect_success 'am with unix files config am.keepcr overridden by --no-keep-cr' '
@@ -93,9 +93,9 @@ test_expect_success 'am with unix files config am.keepcr overridden by --no-keep
 	git checkout -b unixfiles-conf-keepcr-override initial &&
 	cp -f file1 file &&
 	git commit -m "line ending to unix" file &&
-	git format-patch -k initial..master &&
+	git format-patch -k initial..main &&
 	git am -k -3 --no-keep-cr 000*.patch &&
-	git diff --exit-code -w master
+	git diff --exit-code -w main
 '
 
 test_done
diff --git a/t/t4257-am-interactive.sh b/t/t4257-am-interactive.sh
index 5344bd248a..aed8f4de3d 100755
--- a/t/t4257-am-interactive.sh
+++ b/t/t4257-am-interactive.sh
@@ -10,7 +10,7 @@ test_expect_success 'set up patches to apply' '
 	git format-patch --stdout -2 >mbox &&
 
 	git reset --hard unrelated &&
-	test_commit conflict-master file master base
+	test_commit conflict-main file main base
 '
 
 # Sanity check our setup.
-- 
gitgitgadget

