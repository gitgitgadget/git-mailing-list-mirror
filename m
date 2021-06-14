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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC9C4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3822261450
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhFNKs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhFNKqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:46:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA2DC061A30
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:39:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c9so13986220wrt.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZYFeQnaICp57Ix46hTEcGxaIEbgN1x4VmhJiympPrM=;
        b=PH+RrFOp66OaKLC3myHAmWTTIEX13W9sK93tbfrV3o6KrhXO4ISpYYXp3p+Cdj+Yt8
         XZ0Ny/UNNzdg7U+ey2IC5mxTBt6MHUbcFBLTeeXdLCyrgB5fOZiUwNqS2dSfQFlKlsN1
         xmPv/IxCOey/IvU3RFRBZ2VcDCQD35JFFqTOhnIcg1CaQ4WN5hqEMHzzvXfxWht4BH+A
         HRrKgKAdE3C8gAdoMSYtq7I5nTHDCV3UCrtcjiu78WMKPhN214Kp9LdeGrUmVOfpR6FG
         EpT1l5gH1NmdMaYE1DEIn6QaDg17nqbIUiHfTRN7VKfDpcwa1fN4+ihh+WQFnpJwowPm
         1w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZYFeQnaICp57Ix46hTEcGxaIEbgN1x4VmhJiympPrM=;
        b=kN1D3Mcay2yGBOmZCGSVj3gQKz6FU+MfLZBgKcJ0COJF6t/co05MFJg1T2TyOFjihq
         II0IeI3x4FD1Ddtq99itOe6S/dop5chQBrYueeV7Ft/KWzLLQd6s8FoPCJHqALxxGaby
         p9WSiqTI9+eJK/o8RO54pyajxSdtwX0aoo+0nY87vVpG5g51kTuSUsuDOGWcHsXhHhlK
         pJB8O/f7eXHLSAAUtZAHG9ekyJgFPswciQXlmaIx7IIgPwhV5b39++qL6hS92q/RzmLN
         xvGHbxPBTyIG1WuL0eoqDHVNEQk9vv9n09vVDjKr9OiiPMfxNzLWQ85Sf0zJKMFMikH/
         j78A==
X-Gm-Message-State: AOAM533I93Eif6XWWcRXK2dsYsAm3YGVJB2gaLULOSYjgld1ihk2mm/a
        jLpT38DQ0ZqtCZlPnxp5+WR6hiHoFxfRZQ==
X-Google-Smtp-Source: ABdhPJxbzCkBpBp9bfZEBPt3U6QAJvr+qJx92pRkx7nekB1WHQn3ELmbIi8sZ8ykg/sUMMqSsDqGTA==
X-Received: by 2002:a5d:540b:: with SMTP id g11mr18568424wrv.390.1623667167516;
        Mon, 14 Jun 2021 03:39:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g10sm16052490wrq.12.2021.06.14.03.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:39:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] gc tests: add a test for the "pre-auto-gc" hook
Date:   Mon, 14 Jun 2021 12:39:25 +0200
Message-Id: <patch-1.1-17f520ad5ac-20210614T103814Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing test for the behavior of the pre-auto-gc hook added in
0b85d92661e (Documentation/hooks: add pre-auto-gc hook, 2008-04-02).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A missing pre-auto-gc test that the in-flight hook refactoring
topic(s) benefit from. Split off from v2 of my
https://lore.kernel.org/git/cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com/

 t/t6500-gc.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 60d961b5260..10c7ae7f09c 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -95,6 +95,52 @@ test_expect_success 'gc --keep-largest-pack' '
 	)
 '
 
+test_expect_success 'pre-auto-gc hook can stop auto gc' '
+	cat >err.expect <<-\EOF &&
+	no gc for you
+	EOF
+
+	git init pre-auto-gc-hook &&
+	(
+		cd pre-auto-gc-hook &&
+		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
+		echo >&2 no gc for you &&
+		exit 1
+		EOF
+
+		git config gc.auto 3 &&
+		git config gc.autoDetach false &&
+
+		# We need to create two object whose sha1s start with 17
+		# since this is what git gc counts.  As it happens, these
+		# two blobs will do so.
+		test_commit "$(test_oid obj1)" &&
+		test_commit "$(test_oid obj2)" &&
+
+		git gc --auto >../out.actual 2>../err.actual
+	) &&
+	test_must_be_empty out.actual &&
+	test_cmp err.expect err.actual &&
+
+	cat >err.expect <<-\EOF &&
+	will gc for you
+	Auto packing the repository for optimum performance.
+	See "git help gc" for manual housekeeping.
+	EOF
+
+	(
+		cd pre-auto-gc-hook &&
+		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
+		echo >&2 will gc for you &&
+		exit 0
+		EOF
+		git gc --auto >../out.actual 2>../err.actual
+	) &&
+
+	test_must_be_empty out.actual &&
+	test_cmp err.expect err.actual
+'
+
 test_expect_success 'auto gc with too many loose objects does not attempt to create bitmaps' '
 	test_config gc.auto 3 &&
 	test_config gc.autodetach false &&
-- 
2.32.0.rc3.434.gd8aed1f08a7

