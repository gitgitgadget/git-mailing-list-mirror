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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2861FC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E435D610C8
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbhDMMUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhDMMUX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:20:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90055C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:20:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 12so8612201wmf.5
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OqyJm78E02n4ErE84QyxHVkehiR5d+W8uUUfKKj1oIM=;
        b=ZyNGx8C+vF1xblPNEKhdjhvHA2azy8On4BL70kG3SOdtfRC3vvZ2HsaRD6GYpVh8kU
         nP5xdQW9VrZXClv1VW8VSkwHApeD0qLn2cFw+2WFrgRXnxGYBZ6gQaRX7fTp2usXiA1/
         IJqrqLHl/AAaTRiFUAAR6ZX2USznuzW6VRurgL5tU08CK78Dwsd5jVgnlczPrYUHavFg
         lhSYJJB3hCtQNqk6HP7+Wr4pr4NgTOxyB3KX54wdLr7dwWFZXOJGJ2lpml0DcdF44q0L
         Kmr2jRgsPSmQwnhGVrozdXkD6KzwCjEl+8skegTOErE4kbEGlYnRUg4ebfEXmQBDG/Fx
         cm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqyJm78E02n4ErE84QyxHVkehiR5d+W8uUUfKKj1oIM=;
        b=S8jmarB8eqnXcO8UvOcFOE2en1fx7wYTjurGMm/QAH+bO0zTDeQb/kYqVRf/Ykf9ya
         9mYTzFrc9wdFiklzpk9MCv74X89vIrHk5gUL7PT1o4BvWMIGb3+gIjUxfnZQuOe40JAC
         Yz+JSiGncoTh7e3ERL0+iNUiaA6AexpE1escK5n3T4qsExDXr2ncP7oTvPBtyKQ7CH4w
         zxj5TTV2oIyTn7Y0zSIqClQ7ojnd2FboUYvC6m8d88iPBsN/wGFgVrzoVEgTMcMT0X8s
         z2MBuvZY7nzFQrMjRKmrk1modzgzQJo8stToJ/cC3RkfhA6W+nNvE4hah25gR39Cxv44
         1VwA==
X-Gm-Message-State: AOAM530RX5ogQhawUSRJKP19hnQSA5YbuBN1DH+LTnjB1f1VxpT26pvF
        rSIMRruLvLaWYdo8ceBgoXYkmEqzE5hdug==
X-Google-Smtp-Source: ABdhPJz7x0SbpNDRMywyHrN8HTXw2dhjHAfTybuqPBsV6R5iAB7NEouick9SkPUQC+RdB/y/8QlG3g==
X-Received: by 2002:a1c:dc41:: with SMTP id t62mr3985016wmg.14.1618316401081;
        Tue, 13 Apr 2021 05:20:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s20sm2283695wmp.48.2021.04.13.05.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:20:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: remove all uses of test_i18cmp
Date:   Tue, 13 Apr 2021 14:19:51 +0200
Message-Id: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.646.g06d606cb9c7
In-Reply-To: <20210211015353.28680-5-avarab@gmail.com>
References: <20210211015353.28680-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finish the removal I started in 1108cea7f8e (tests: remove most uses
of test_i18ncmp, 2021-02-11). At that time the function wasn't removed
due to disruption with in-flight changes, remove the occurrences that
have landed since then.

As of writing this there are no test_i18ncmp uses between "master" and
"seen", so let's also remove the function to finally put it to rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 6 +++---
 t/t6300-for-each-ref.sh         | 6 +++---
 t/test-lib-functions.sh         | 7 -------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index d0bdc7ed02d..c023fefd681 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -157,7 +157,7 @@ test_expect_success 'sequence of fixup, fixup -C & squash --signoff works' '
 		git -c commit.status=false rebase -ik --signoff A &&
 	git diff-tree --exit-code --patch HEAD B3 -- &&
 	test_cmp_rev HEAD^ A &&
-	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-squash-message" \
+	test_cmp "$TEST_DIRECTORY/t3437/expected-squash-message" \
 		actual-squash-message
 '
 
@@ -191,7 +191,7 @@ test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
 	FAKE_LINES="1 squash 2 fixup 3 fixup_-c 4" \
 		FAKE_MESSAGE_COPY=actual-combined-message \
 		git -c commit.status=false rebase -i A &&
-	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-combined-message" \
+	test_cmp "$TEST_DIRECTORY/t3437/expected-combined-message" \
 		actual-combined-message &&
 	test_cmp_rev HEAD^ A
 '
@@ -204,7 +204,7 @@ test_expect_success 'fixup -C works upon --autosquash with amend!' '
 						--signoff A &&
 	git diff-tree --exit-code --patch HEAD B3 -- &&
 	test_cmp_rev HEAD^ A &&
-	test_i18ncmp "$TEST_DIRECTORY/t3437/expected-squash-message" \
+	test_cmp "$TEST_DIRECTORY/t3437/expected-squash-message" \
 		actual-squash-message
 '
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index cac7f443d00..7cfa934913b 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -945,9 +945,9 @@ test_failing_trailer_option () {
 	test_expect_success "$title" '
 		# error message cannot be checked under i18n
 		test_must_fail git for-each-ref --format="%($option)" refs/heads/main 2>actual &&
-		test_i18ncmp expect actual &&
+		test_cmp expect actual &&
 		test_must_fail git for-each-ref --format="%(contents:$option)" refs/heads/main 2>actual &&
-		test_i18ncmp expect actual
+		test_cmp expect actual
 	'
 }
 
@@ -966,7 +966,7 @@ test_expect_success 'if arguments, %(contents:trailers) shows error if colon is
 	fatal: unrecognized %(contents) argument: trailersonly
 	EOF
 	test_must_fail git for-each-ref --format="%(contents:trailersonly)" 2>actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'basic atom: head contents:trailers' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d7339..b823c140271 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1025,13 +1025,6 @@ test_cmp_bin () {
 	cmp "$@"
 }
 
-# Wrapper for test_cmp which used to be used for
-# GIT_TEST_GETTEXT_POISON=false. Only here as a shim for other
-# in-flight changes. Should not be used and will be removed soon.
-test_i18ncmp () {
-	test_cmp "$@"
-}
-
 # Wrapper for grep which used to be used for
 # GIT_TEST_GETTEXT_POISON=false. Only here as a shim for other
 # in-flight changes. Should not be used and will be removed soon.
-- 
2.31.1.646.g06d606cb9c7

