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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53319C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D18961574
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhFNK5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhFNKyK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:54:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D081AC0611BE
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so12497959wmq.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7MG4ZQ4gKCciMaU2Ld1S7Jt4tLEBck9dAjSmNV89Poc=;
        b=gAFQy3UCjnDFlCeO1gr40gdF78Q7rxtu6xK3TUV+14S8URBkVvy/wsXW0Y8ZlhhtYU
         k+X6CyAtnvnQaaInDV3DosfxV05rjs39Aq9m9Z0aJPUAZ7Stp0xpIBEAkV+b0DuKHBW7
         z8VKCO1h1DpSwsLKndeTHErKjI1LOi+sWR25lKTmaGGLDssk7GTRurDclJa2ZpxfBMYM
         YtIldXNvd+YSz7XpblurBGmE7SMsNe9jWt617wTkmRhN58yP2SKu3W5uOV/uoLX7NGZj
         nCOL+F0bkkAS9OT/QUDulAgGqj/H8e+YouiorzpHclWoDFSRPhR61uuiDjRijgPv8wSK
         hkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7MG4ZQ4gKCciMaU2Ld1S7Jt4tLEBck9dAjSmNV89Poc=;
        b=qfDXMR/tKSpHSOCNT3+cxfzHlzUU3o/xbgq5LzCfwBl1IeYhUvt/s2dmfXCVTAz885
         FOrSqES7N5CUVlTX7r51AyxekamoDA1CqEm8ikEDyib5YoUSw+EP0lNQP8JeO1RceKbS
         ukDLifBnlGJhBHbD/Zd2YP/uePVl3OSG3k7/Kia8yohr14T0xBaS6MMIB2UPmCdYOC61
         4pq6kCda+MwXmms3SydcPliIVTdG5N7N2xUnZYyFxspG0JOA7vV9JdyyYlxOYIcbF5vc
         ktbfEQ1xi0sRx/4404leqUkdWrTykhyvDukdicGPWiMcJkH58MWPXSpklg3PX0DL/Yo2
         n5dA==
X-Gm-Message-State: AOAM5330zZqOGMT2MicjbMGqv2VD4anktHq75y3XQEmhFxO//tMAGD2v
        mnlbZlURYVimWIubVYogpbWRUL6h39Y07g==
X-Google-Smtp-Source: ABdhPJxCwv8j1W9HuCQNIq1lDbhJAEaUAH4wX1xMGwOXHiQv8Ik/TQaPl8+G+oxl8+54hsEMgNmoBA==
X-Received: by 2002:a1c:ed14:: with SMTP id l20mr31453705wmh.20.1623667705257;
        Mon, 14 Jun 2021 03:48:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m23sm15153732wms.2.2021.06.14.03.48.24
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
Subject: [PATCH 7/8] test-lib tests: refactor common part of check_sub_test_lib_test*()
Date:   Mon, 14 Jun 2021 12:48:13 +0200
Message-Id: <patch-7.8-1f32eb60411-20210614T104351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
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
index 8f4935faf43..02864c9d0e0 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -87,18 +87,22 @@ run_sub_test_lib_test_err () {
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
2.32.0.rc3.434.gd8aed1f08a7

