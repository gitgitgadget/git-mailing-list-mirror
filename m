Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFF8C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiG0XN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiG0XNx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:13:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B84D17D
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso208036wmq.3
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xStBtPE5M0Au360I4uK5eYJJdLP0mEUY5gniDHaTijw=;
        b=m8gaOyEL+q/cPz/a7PSDbS5OmEiK/2jc/yTNusCgn1DFK6uBDIbbC44QvIT9A12FOD
         g1i5F0Ddpfh1kDxFFB+2apw+b31c2RLox5Vcl6ErJMWPF79DeUzaaHa6iEDQnRNqMn5z
         GgrMigFc5Gzy89vyQEcZwAzrMBf7OJztAhRPW1/QuBBVHs3DNrW33o2yz9P2KrpwdM2K
         DLv8yqjdePxXu2vOUThjSirpuEEblrhmJ3cTK6J/7huqheyOJfIgbUvdh+xQs29fochB
         5xezDT5Nz1suX252qUeFQhxUsnan0UqYM2zmuQsocSrJeIplW0uv1gb+5M7Gl6Z/HX3u
         PG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xStBtPE5M0Au360I4uK5eYJJdLP0mEUY5gniDHaTijw=;
        b=DTx4crNbdTXj59TxxuMLHJIK9vJV+5PHwDRYR4P6XUURPlc6U18c8K+8GygJbzehLv
         CTN6VzotVFN+igogBV4NeB2yTJUueJRKPHpCQAuvzujWGJb6tYMoNkxhjTASb8Nnhtwd
         F7P/pe3SJoxmdNqJPo0Ho0bixWO5czoeW7SvJutuU5FmKN+5st7bnJnYHSMkLhSriWfU
         wV/fpI9usk6l78RlCldwLNW/Na+OKdLfp3kHryRcel/QcwtI9UipNO8z4d0ykegEpDvR
         LOeN+fyeLAsViPQ703oHqH+Opt5FMcLTiwGbeQJP329BhzzRpXP/8lxURSlWx7+ZmavZ
         eMaQ==
X-Gm-Message-State: AJIora9djrAMYS0kCFQu8tVIlOh0pwkP3qLRpH9XchHXVbVK0AiwRrA/
        ycC6ulpcW6jwsFrGulTXHoTwpG6nLviWVw==
X-Google-Smtp-Source: AGRyM1vfVwPhiCasrtRqJfYyRgkE4zUnN5ahrFJvLg5oMwO2R9R+DrHGEe5rTuWuGWAXSkwdQf8fEw==
X-Received: by 2002:a1c:7c0d:0:b0:3a3:5e3f:497e with SMTP id x13-20020a1c7c0d000000b003a35e3f497emr4646647wmc.135.1658963629379;
        Wed, 27 Jul 2022 16:13:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:13:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/15] test-lib: use $1, not $@ in test_known_broken_{ok,failure}_
Date:   Thu, 28 Jul 2022 01:13:29 +0200
Message-Id: <patch-v3-01.15-65930cc1445-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify that these two functions never take N arguments, they'll only
ever receive one. They've needlessly used $@ over $1 since
41ac414ea2b (Sane use of test_expect_failure, 2008-02-01).

In the future we might want to pass the test source to these, but now
that's not the case. This preparatory change helps to clarify a
follow-up change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7726d1da88a..3f11ce35112 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -804,14 +804,14 @@ test_failure_ () {
 
 test_known_broken_ok_ () {
 	test_fixed=$(($test_fixed+1))
-	say_color error "ok $test_count - $@ # TODO known breakage vanished"
-	finalize_test_case_output fixed "$@"
+	say_color error "ok $test_count - $1 # TODO known breakage vanished"
+	finalize_test_case_output fixed "$1"
 }
 
 test_known_broken_failure_ () {
 	test_broken=$(($test_broken+1))
-	say_color warn "not ok $test_count - $@ # TODO known breakage"
-	finalize_test_case_output broken "$@"
+	say_color warn "not ok $test_count - $1 # TODO known breakage"
+	finalize_test_case_output broken "$1"
 }
 
 test_debug () {
-- 
2.37.1.1127.g4ecf1c08f67

