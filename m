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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B3C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BEF611AC
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhDQMyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbhDQMyG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E631BC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so15434055wmg.0
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8oQj7l8b8RJ87h0wxJOrz4NRYs2AWVXt2zPNoVfC8g=;
        b=Teyv2Y0Xjw7rLA/b2/RdNnu1WbsAV4FHqOf7wxYp56roWhV1iSsm3fI6WZGE64TsFd
         0JKG/LqFKy6eHmUQFoXiJmzQUPC3Wo64QhL4fw14rV1X5MFP3uvmdswg0BRxkVsyiHbm
         fyN8Cjgd5AUlqvX3od6Klva8/JXzCSLlfJCz6SgZybdUkk1mijFkxLnveTK5nisnxV9R
         /UoEen2Pw6qqHAHubxQTpQe/fJbiQS8xtcx8Xe5dLr5nj3Krm4p3c4rNAaaYE0e+2vnp
         4UxRdF0OZJFRKQC4sXZxp2+s3FpiRQ2AIs0fW6pjYxOsWPXaXLdwQ7WqP2LMHIcJJLXb
         8Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8oQj7l8b8RJ87h0wxJOrz4NRYs2AWVXt2zPNoVfC8g=;
        b=o71oLfGoYs3o/CYIaXbGqH7uZwXUM6BV4b2sevlzySafO6iNjQPu3Y/Zl0NIE+avmQ
         mFyvt04lSeoxv0IOEeCGy1Yflhrb9x8KVHF0uET+hOlLIhHoBk9J6Mi9FIGvrYkjL7bj
         qz5zhws0oMauhA3RO/Cu+sMmm3bGSOElWMXlb4tq8+9DB3Sk/2QGN5CbUS563bSAiffd
         L854vD3Cl3rzJ7xnXbAb/hvxe8mvbuCs2d5oi/WjdQwiVBzooMrN/KNpnPHILb5IForm
         R/bCBeTZhUxb1pvIuu1nsvcWmI4GjvGzXK0FaSjxJWSLj90+AW8qSbjFwZ8lBGKwvgLG
         ddsw==
X-Gm-Message-State: AOAM533MWB8aPZJ5WId1umKZ/aCU145NIWfIS16hnBgNL0VXYg3D/Kx4
        9irl3eyTm4t6nz12ePPkbif3K0bV85a69w==
X-Google-Smtp-Source: ABdhPJwtp8vz3sY/94lyKBQDmaWn6+NmIKieUl5gd5ZlNKkhnZyoo2M9hLf3NsUpuXu7M5mIvjKhMg==
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr12736472wmk.182.1618664018446;
        Sat, 17 Apr 2021 05:53:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:37 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/12] test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
Date:   Sat, 17 Apr 2021 14:52:36 +0200
Message-Id: <patch-03.12-d669ce31961-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop setting the GIT_TEST_FRAMEWORK_SELFTEST variable. This was originally needed
back in 4231d1ba99 (t0000: do not get self-test disrupted by
environment warnings, 2018-09-20).

It hasn't been needed since I deleted the relevant code in test-lib.sh
in c0eedbc009 (test-lib: remove check_var_migration, 2021-02-09), I
just didn't notice that it was set here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 705d62cc27a..2c6e34b9478 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -84,10 +84,6 @@ _run_sub_test_lib_test_common () {
 		passing metrics
 		'
 
-		# Tell the framework that we are self-testing to make sure
-		# it yields a stable result.
-		GIT_TEST_FRAMEWORK_SELFTEST=t &&
-
 		# Point to the t/test-lib.sh, which isn't in ../ as usual
 		. "\$TEST_DIRECTORY"/test-lib.sh
 		EOF
-- 
2.31.1.722.g788886f50a2

