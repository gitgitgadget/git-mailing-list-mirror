Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4393EC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F38B61107
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhIVLVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbhIVLVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 07:21:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6494C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:20:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q11so5607454wrr.9
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcB4N3oJDt5fYN55DzNmHFMNSHeoiOEVxs50+icou7A=;
        b=DbZQYXLOrE8/c6VngyEYQw0E+UK8GMXM7U8yB5Ea79BDouC8we5xuCbVW8o2prcmCR
         B8Y0NIdqQcLFRPcND3SB26P2k67oeiHLwQXaD5iFZFmmGmwc1hv4mpRGqg3Cdyw/shxF
         y1W8xOJ8U1n5Z81CehpOYSX//AhyA5mb3zJP5NS8ITAD4jQ3O1GqU1EwLYIRvDegGchr
         OHMXPW4GKq2F9/RJyfJ2e/A/aW6RAzHsbTvR81+WM/tnxslYtruxS20GXOUDv7wsZXgK
         lxUUNfT9gacs8KFesel9wtBq31GvULH3OlsXT7oZApLrQWmKVz8yi9fo0ZqzsvvdKLar
         9elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcB4N3oJDt5fYN55DzNmHFMNSHeoiOEVxs50+icou7A=;
        b=Ln5y3H1/kO4MA4NXGAKxQpnpbvq7lMF0ZG0pnHUcDrS5VByGr9a6LrK5Lo1F95WVi/
         O2L2SqM7rSNgpgPm6kf+UzTj2HEyLR5BH2Cjs8GKJDP73TJDdPgBb4MTLbptXU8Ufdme
         O0D2S6ThCQFJGkvv6OE/y+HJiHzisKcl9WvNG8xbhEUpUlFYL8EIqJAo1iZJsgU2RB5J
         ll80T9nmIggs4nfSSnpn+VFpfQy8AmTV/56Qrx8LcbQ0o7mDPqKBs4GeF1GylEXuIOJP
         5FghBBlDYPLWcnJCsU8xkhkxDBCSm+K9fYF4uIYMKM8yAvSXYcXhU/o6a2EOapiC/AQa
         OHrA==
X-Gm-Message-State: AOAM530gyIUu/vIYDGDj+IR1QNq1ARKl656FutSC7uP9rbgQ34tgTn3b
        4MhsaoFKfPTG0xKmpP9j3iVuwxMFPi2+Kg==
X-Google-Smtp-Source: ABdhPJzkoEjeRzRTKoEerBSG41uNu/T7d4ozfFrP6xHGb9BOjRPKOOLccylfAVixMryXp5dX3Ixtmg==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr9840837wmc.105.1632309601830;
        Wed, 22 Sep 2021 04:20:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d70sm1679165wmd.3.2021.09.22.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:20:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/7] test-lib tests: refactor common part of check_sub_test_lib_test*()
Date:   Wed, 22 Sep 2021 13:19:51 +0200
Message-Id: <patch-v4-5.7-5e95484fb61-20210922T111734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
In-Reply-To: <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
References: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the two check_sub_test_lib_test*() functions to avoid
duplicating the same comparison they did of stdout. This duplication
was initially added when check_sub_test_lib_test_err() was added in
0445e6f0a12 (test-lib: '--run' to run only specific tests,
2014-04-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 0737fab98ad..cdadc0c7fc2 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -77,18 +77,22 @@ run_sub_test_lib_test_err () {
 	_run_sub_test_lib_test_common '!' "$@"
 }
 
+_check_sub_test_lib_test_common () {
+	name="$1" &&
+	sed -e 's/^> //' -e 's/Z$//' >"$name"/expect.out &&
+	test_cmp "$name"/expect.out "$name"/out
+}
+
 check_sub_test_lib_test () {
 	name="$1" # stdin is the expected output from the test
-	test_must_be_empty "$name"/err &&
-	sed -e 's/^> //' -e 's/Z$//' >"$name"/expect &&
-	test_cmp "$name/"expect "$name"/out
+	_check_sub_test_lib_test_common "$name" &&
+	test_must_be_empty "$name"/err
 }
 
 check_sub_test_lib_test_err () {
 	name="$1" # stdin is the expected output from the test
+	_check_sub_test_lib_test_common "$name" &&
 	# expected error output is in descriptor 3
-	sed -e 's/^> //' -e 's/Z$//' >"$name"/expect.out &&
-	test_cmp "$name"/expect.out "$name"/out &&
 	sed -e 's/^> //' -e 's/Z$//' <&3 >"$name"/expect.err &&
 	test_cmp "$name"/expect.err "$name"/err
 }
-- 
2.33.0.1225.g9f062250122

