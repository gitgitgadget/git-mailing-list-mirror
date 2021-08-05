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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73367C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AFF60F02
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbhHEKiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbhHEKhz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:37:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F08C061799
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:37:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m19so3056387wms.0
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDSs9BlWCzFZ0RpOvDk9UWgqFVpD7P+2gAqvWk65xp0=;
        b=Nzf07hou8Z26izP7vENaFwUP1Ne9nb7YKUTMqESIeBDabXoNQdfJEzstkIECnqd/hu
         xbVesX/WQT+YCpz/LtO7GPchMXubDIxUvemh2PKs2m4ltjjrVPS0zIeT1oYmajkMhASX
         3oWTbP5c/fVS77ws0BepHZIeCh0UBV8jMCdSUpWqws6Yxeqi52xCQsYbuytX4vr7ifeO
         2old/YDy0/IAs0YQdbJcXt0NRzNpAAGJ+fUo7BHbwtnbgnTuRhycELx4c6nxEF5+sCWN
         NlGKfI8l68bnzbjdNbG124JK597outMVawl1hT9xA4keHgI/x4dEU6JdQqZJkcTCLFIa
         bpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDSs9BlWCzFZ0RpOvDk9UWgqFVpD7P+2gAqvWk65xp0=;
        b=ilJyFfDEDwQvHD1cSnB2LqzRwFHBO2wtHqI2rNm9prg8oMDtYQpxGA8qOFQ82Y1kJT
         HuUXcA8oYx0EdCeaE9/Z8wpRtYvK627Z760tMConnjvTP6xDmrBaQSgEITFjdrt4kBNL
         ca+T6tsifBjaDPWvtNYvh/fLAtpYnVSiXivfSnGjUWhzyJisVqw3GyKp/iUFM99b4q+I
         J5/uVKt8D5CGGeNCdTTN7+SSm3/mqYian54Em2db8FwswCldpYzBJUL2Z8Kr+E/k4ylw
         +KL+cdM+TuGy55yt+Kli2eB5U/wW9alaonjkqf5ZTpNKnqMv0vKwmUpE7CR/5/Z4nWyN
         cQqg==
X-Gm-Message-State: AOAM533cXm+pKzSWyowaUoSMCzBwpxav4Sw/qNKmnNeI/Lv+S8jTwa5K
        TsXl3RJu4JyRi1o2jFbjUH5S164V3uRqaQ==
X-Google-Smtp-Source: ABdhPJw04A2d0B7JnU5mLbjsVQ3Ue5xGChdthdDGiCE/TbEKHHBT5Mtre9RxPmBmvIwXkPLhNwoSqQ==
X-Received: by 2002:a7b:c083:: with SMTP id r3mr4347596wmh.65.1628159858542;
        Thu, 05 Aug 2021 03:37:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm5106152wme.6.2021.08.05.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:37:38 -0700 (PDT)
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
Subject: [PATCH v3 8/9] test-lib tests: refactor common part of check_sub_test_lib_test*()
Date:   Thu,  5 Aug 2021 12:37:27 +0200
Message-Id: <patch-v3-8.9-fda7c4fbe3-20210805T103237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com> <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
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
index 529f3a4d08..0b9ecdb6db 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -109,18 +109,22 @@ run_sub_test_lib_test_err () {
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
2.33.0.rc0.635.g0ab9d6d3b5a

