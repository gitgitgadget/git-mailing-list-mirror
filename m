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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8071C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8718A60FF1
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbhDLLWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbhDLLWT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E758C06138E
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:22:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j5so11553530wrn.4
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0g9L3FOBCP0Kh5buN3rMPSqLC+WQQxOUVHzRertbgg=;
        b=F/3/abdDboihJCnWwwx2V7T7vWE4YE40/2eTiydWv06Uv1hlbGlEalK46SGAitejse
         Be/V4QnKhMktfitxm152I/KGj/SYCp4fItE6p65i3tCSv0TQ0lFnsGLmjtFIMes/XyS2
         p+FpQBoNpcgCLr4deBezLMk5DMshuhb5r7hSEh+0MP9b7aSCupTbixMrXAjzWXG0v1cE
         iz24EI48jBfrM/1+7xbYI33SqbXLlQFewnWxd9GSYRccD8tK1XWJrvnxN3u0FJwMikCs
         jKlFNQiRrpsZbMSuTFI9AH/0p41/5HfH0ApLlcrH2ZmTEsjmxduAhJrL6SklkyhXZbZr
         KJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0g9L3FOBCP0Kh5buN3rMPSqLC+WQQxOUVHzRertbgg=;
        b=ojBEMpeujorufrh3VTwR3wE7E88Uu2axWI3O4LWzSE4UFB37maQd3xKcrjJAf1o3Wg
         kHbm4dtvvQ7SU9TU9dqC+1L7TBOWf1lwbLMTmnjQwRXDkEHH9nwlwjEKJke8MqUx187m
         Z89NgvVrMvVVpXxBapxHAH4qtkm6BUaz76OsPdVoi39qoTTHpNipxWvmNWo+eRTU2+h4
         Z37yGlywl0r89b/WS/mOxzaJVrkVvjgWQQgBHgbdwDxl6epM8nsqqKgjDSJ9z/se+evd
         cNgMARbcyTYrBzlUGbDzMtes/TwT6EoXMMGmULvAO5qZ1yr2R6sh9wATR+g6uCqxCj35
         rF4A==
X-Gm-Message-State: AOAM532/Xq2a509xmklYU7DeQ945Ri9P52YZS00Rt/yQsPTvIlJ0Qs5B
        AsAskjTZdQlxa8VvIM5gTX3G+R/dumxfmA==
X-Google-Smtp-Source: ABdhPJz1Iv6PEmqzjWJk5twQt/meRAZuxeNZPETSb9OGMMi/Q92shjPZoaBCC3Si4EkgXwDmo2hfcw==
X-Received: by 2002:a5d:5711:: with SMTP id a17mr10467103wrv.342.1618226518931;
        Mon, 12 Apr 2021 04:21:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v185sm14580907wmb.25.2021.04.12.04.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:21:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] describe tests: don't rely on err.actual from "check_describe"
Date:   Mon, 12 Apr 2021 13:21:45 +0200
Message-Id: <patch-3.5-50b5a41f88d-20210412T111601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
References: <20210228195414.21372-1-avarab@gmail.com> <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the one test that relied on the "err.actual" file produced by
check_describe() to instead do its own check of "git describe"
output.

This means that the two tests won't have an inter-dependency (e.g. if
the earlier test is skipped).

An earlier version of this patch instead asserted that no other test
had any output on stderr. We're not doing that here out of fear that
"gc --auto" or another future change to "git describe" will cause it
to legitimately emit output on stderr unexpectedly[1].

I'd think that inverting the test added in 3291fe4072e (Add
git-describe test for "verify annotated tag names on output",
2008-03-03) to make checking that we don't have warnings the rule
rather than the exception would be the sort of thing the describe
tests should be catching, but for now let's leave it as it is.

1. http://lore.kernel.org/git/xmqqwnuqo8ze.fsf@gitster.c.googlers.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 13117bbcfb7..911b1928057 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -21,7 +21,7 @@ check_describe () {
 	shift
 	describe_opts="$@"
 	test_expect_success "describe $describe_opts" '
-		git describe $describe_opts 2>err.actual >raw &&
+		git describe $describe_opts >raw &&
 		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
 		echo "$expect" >expect &&
 		test_cmp expect actual
@@ -90,20 +90,17 @@ test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
 '
 
 check_describe tags/A --all A^0
-test_expect_success 'no warning was displayed for A' '
-	test_must_be_empty err.actual
-'
 
-test_expect_success 'rename tag A to Q locally' '
-	mv .git/refs/tags/A .git/refs/tags/Q
-'
-cat - >err.expect <<EOF
-warning: tag 'Q' is externally known as 'A'
-EOF
-check_describe A-8-gHASH HEAD
-test_expect_success 'warning was displayed for Q' '
-	test_cmp err.expect err.actual
-'
+test_expect_success 'renaming tag A to Q locally produces a warning' "
+	mv .git/refs/tags/A .git/refs/tags/Q &&
+	git describe HEAD 2>err >out &&
+	cat >expected <<-\EOF &&
+	warning: tag 'Q' is externally known as 'A'
+	EOF
+	test_cmp expected err &&
+	grep -E '^A-8-g[0-9a-f]+$' out
+"
+
 test_expect_success 'misnamed annotated tag forces long output' '
 	description=$(git describe --no-long Q^0) &&
 	expr "$description" : "A-0-g[0-9a-f]*$" &&
-- 
2.31.1.634.gb41287a30b0

