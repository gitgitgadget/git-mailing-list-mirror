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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEA3C4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F10C60F02
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbhHEKiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbhHEKhy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:37:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56082C0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:37:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso3349677wmp.1
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HObluCioIghhWS08ajLUNwADuIdpVouuMyqbQ/ZKngg=;
        b=ejh7IOe9zEMeYTSldKsrSi1lwsx/S7xmYsdzpj8aZNowYMSbs26D/vKwuYxnnMRnFW
         dZGqhPnQd4P9n6zfyJ8Uvg+KktPWPhwEE5KEfNBelwLfdr9ZW/TRi+Vid8k0Q3u3JfhH
         FQ/FKhMcpH5BnKFwI5qKpHX8pRFt70OhjReNlYlysK09dNyeUoUIWhWb/CN4nCISiPyK
         m9ZCNEsDxkjZcu/6220lb1fYmYFdb6yKc7Bzn24PUYjrgLoi+cZjBoRu2URGiYhdIb1H
         0tqpRIRFYoIbHjUt0W5R/Wl1wAX5oK75OpE9DixRxltXTCVkd/WzbioLDK2i+j403EGL
         ChZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HObluCioIghhWS08ajLUNwADuIdpVouuMyqbQ/ZKngg=;
        b=heQ5ozDXqxO/SMMsleQ3GRg2kxPW1RY6+yJqIziobLjBAjoyaV/36J6Z3DV5zUkNUl
         BWZJZnRmyiRKmBvR3OkujKH0ILV9yatugf4fuUsXSmWe1y1FHVE0mfpvyE+cbG8EBfS1
         fxQA2/N41iW0LDpanE3+ms3umjDcdQisqfJyY8sMQ7e6AQu+UKHHSJ1mgCMoTZDzPgPp
         HwzIS7OI1uTeh9qsFrYAnioqkEpIivV49e78pDLRgIMm2IjTu1kg9GjzsKcZ3A+6Jmwr
         c/EgEwNVkMfq6m6How3E4UC5a58vwYwNMLr3Uycte+5rZSb7GGBiGRojtICD4HK3Uo3w
         0Qng==
X-Gm-Message-State: AOAM533Vsp4u1i+DXw2oZ4ukWaPQKnmDBPyiKPJyJg6kNu/qY8Wfdj/c
        l9Wq/u2gyE9cfzFcbwia6o99cxcjKxBewA==
X-Google-Smtp-Source: ABdhPJz4cydt59YkXInrguTQFZG07/gvKXKU+wG5vg8IyUi3Aoz5shk0sYN6dosn2ZUvaMneINrgCw==
X-Received: by 2002:a05:600c:3b8d:: with SMTP id n13mr3104002wms.69.1628159857800;
        Thu, 05 Aug 2021 03:37:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm5106152wme.6.2021.08.05.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:37:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/9] test-lib tests: avoid subshell for "test_cmp" for readability
Date:   Thu,  5 Aug 2021 12:37:26 +0200
Message-Id: <patch-v3-7.9-48176f3e60-20210805T103237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com> <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
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
index 6857afdaa5..529f3a4d08 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -111,22 +111,16 @@ run_sub_test_lib_test_err () {
 
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
2.33.0.rc0.635.g0ab9d6d3b5a

