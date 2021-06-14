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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C71BC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44F0613F5
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhFNK5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhFNKyK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:54:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674AC0619F6
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c9so14013780wrt.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tq9OQUaO5L8L+PfdMbxMlXsuFQSlHnVpPqwMUeEPegM=;
        b=BBQneYHtr+LjXTY4hsmkbCUC+7ptgV1qpwltipR6bJnWAnC7DTl5vQeaxH2LhoT6j9
         aQrFVtIceciMgviGRys+B/08YQ6H1tE3z+OVebSTCkkYapqHOrnGdupY6q/pmJQbRFjD
         nP+/kxpaAOS96HmLHZfNg5758meeQ5WNgy3HxjiPpTUlbEwCDAmyCG3inXoXwizlM8Yt
         Cv7c97UKRV3mQ+dkGOf4M4QH54XAn4ARmh5kwm5z1bGa74GFxiKBDcyxYik1aFu8AB3y
         g5VJGrM9DeDaTniqvnodOSpg92IrpRWGtA1uN85vcBJ3nTqgfyfjbEGrRTY9pQbSq2Ts
         Tv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tq9OQUaO5L8L+PfdMbxMlXsuFQSlHnVpPqwMUeEPegM=;
        b=hr+in3so+ZLxVyWQAhnJ7HZUdOXCBmGxe0a1cJV5Mirh7mejx13UFBvcKr+CbtZXc1
         D4F5jHsl5/nsd50sQQANqKo1HZ8vzKv+rSeyFUbZ9P9gguxfOWn0KYjoWmm7ZWOHyIk/
         1VAEt4NGSGSQ0eqqRs2k0euEe4O8E7F5Rj/ci+ejv6M00FFxpMboB4tpdW+a3ldvFBnu
         99r9yWrSn3emIiUklmKqWtPcoW5OoPxqwmQ+HkPJ8f3Hn3T2F0fvutlyN0Dy0xDtdaK3
         p87YgVigatjuc0UzC55780ikEctV5QVHbYTz8Mf+GG/vc7Z8Y3iUCyjb7EKW5P9MAEC2
         1AWw==
X-Gm-Message-State: AOAM533J469JNaDIflGN7luo0IAj+GtR2esAyzXTlLqV0WOTQRyaeTKN
        Cb39gJAqyemXMVjILVPHxiv4dl2J1H5TdQ==
X-Google-Smtp-Source: ABdhPJzj6NW9QRYo90apAx7hLkaRx5oesN3rh2I94cTcFQB82Q6gw8THPF7fksGjMj+87pj2HtZ8eg==
X-Received: by 2002:adf:a291:: with SMTP id s17mr17866630wra.399.1623667704446;
        Mon, 14 Jun 2021 03:48:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m23sm15153732wms.2.2021.06.14.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:48:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/8] test-lib tests: avoid subshell for "test_cmp" for readability
Date:   Mon, 14 Jun 2021 12:48:12 +0200
Message-Id: <patch-6.8-2f717e437e6-20210614T104351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of a sub-shell for running the test_cmp of stdout/stderr for
the test author was introduced in this form in 565b6fa87bb (tests:
refactor mechanics of testing in a sub test-lib, 2012-12-16), but from
looking at the history that seemed to have diligently copied my
original ad-hoc implementation in 7b905119703 (t/t0000-basic.sh: Run
the passing TODO test inside its own test-lib, 2010-08-19).

There's no reason to use a subshell here, we try to avoid it in
general. It also improves readability, if the test fails we print out
the relative path in the trash directory that needs to be looked
at.

Before that was mostly obscured, since the "write_sub_test_lib_test"
will pick the directory for you from the test name.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 4834db6c4ca..8f4935faf43 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -89,22 +89,16 @@ run_sub_test_lib_test_err () {
 
 check_sub_test_lib_test () {
 	name="$1" # stdin is the expected output from the test
-	(
-		cd "$name" &&
-		test_must_be_empty err &&
-		sed -e 's/^> //' -e 's/Z$//' >expect &&
-		test_cmp expect out
-	)
+	test_must_be_empty "$name"/err &&
+	sed -e 's/^> //' -e 's/Z$//' >"$name"/expect &&
+	test_cmp "$name/"expect "$name"/out
 }
 
 check_sub_test_lib_test_err () {
 	name="$1" # stdin is the expected output from the test
 	# expected error output is in descriptor 3
-	(
-		cd "$name" &&
-		sed -e 's/^> //' -e 's/Z$//' >expect.out &&
-		test_cmp expect.out out &&
-		sed -e 's/^> //' -e 's/Z$//' <&3 >expect.err &&
-		test_cmp expect.err err
-	)
+	sed -e 's/^> //' -e 's/Z$//' >"$name"/expect.out &&
+	test_cmp "$name"/expect.out "$name"/out &&
+	sed -e 's/^> //' -e 's/Z$//' <&3 >"$name"/expect.err &&
+	test_cmp "$name"/expect.err "$name"/err
 }
-- 
2.32.0.rc3.434.gd8aed1f08a7

