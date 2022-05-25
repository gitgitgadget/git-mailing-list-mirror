Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F10C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbiEYL1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242478AbiEYL0p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761139CF56
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso3149300wmn.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Ijzhnwbw3Ka+BjRERq0RkApj89tBYfb60KCYdObH/w=;
        b=iDdcJM5DoMzP17dVuVw2YcM6sm8tArW5MPrZCQ7SIH2NWbmx62BAmPgnKQZymR6g8j
         jEnX8bEOTJw7Z8cGBRpjzbmIJtd37JDeHnmskhPRyFTbtvqo4vV+WlqO31jguQp6lqLt
         V+JMzqB7M4/aoXzfdXC1p3rF/bG8O/39XSkYCoucR0MndQgG4l2M+7D8zhyQC2wrcXXF
         ec96JxrEI1J9WMVbv+Emp9ug5aiielWDzHpxTJbvlRA2X/Gp1jGdXdjKQMi95rFztJzO
         zKqQ9keTC+bwBr5lT/9trbLz1IOfTuHORLz5zHxLDn+nHaKt8RucaQwUeGcs4yV16qpY
         OcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Ijzhnwbw3Ka+BjRERq0RkApj89tBYfb60KCYdObH/w=;
        b=Y6EBac4E1EDi/5GPfyR3pbHKBYALTFBqoHzKVuHRUV1jMIXnA9EAJhZoEHZ5BpYqMe
         jxEKo+0GftiVQST09+6SV9PEYygd83ZxnlreXTW0KX3P3xg9t23HtxkZrFljayWIuJA8
         RtalKxU+jpjIf2Ep7BDaA/CT00KWCbyjYoRqNftHhUgd8l7cWDuxVmvX287nfw83hv99
         s/ak5T+fk1SjXxcFCnGGpGwXjVWb8YmcD24WAGuq7v9Iyohe8oaS1S9w6H1b1yS8mGle
         UJgWD/LUqJYeFPrrXhS6HJ0xoanl9MF23yvQeoT+Ee6WJPe6l2qZse9xhCNqw/gVhd+p
         xT7A==
X-Gm-Message-State: AOAM53177JnNsPF8nDYagabkjYwQ+pveQo4s7RJuFnKIo4ZY1ZZuT7X9
        LhtoxyxEmfDF0o3YmdLa2FcTnBCSBGQ1Xw==
X-Google-Smtp-Source: ABdhPJx/E5Si28gkP6NqNBkSmudoHrwiPP7zym1/t96zIdev1XXltZEacUNjwLleHWfx33DQauP9RQ==
X-Received: by 2002:a7b:ce8a:0:b0:397:37c9:254a with SMTP id q10-20020a7bce8a000000b0039737c9254amr7803769wmj.96.1653477991758;
        Wed, 25 May 2022 04:26:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 12/14] ci: call `finalize_test_case_output` a little later
Date:   Wed, 25 May 2022 13:26:01 +0200
Message-Id: <patch-v6-12.14-11dab84b0dc-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We used to call that function already before printing the final verdict.
However, now that we added grouping to the GitHub workflow output, we
will want to include even that part in the collapsible group for that
test case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0a7e067ebdb..736c6447ecf 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -783,13 +783,13 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
 # the test_expect_* functions instead.
 
 test_ok_ () {
-	finalize_test_case_output ok "$@"
 	test_success=$(($test_success + 1))
 	say_color "" "ok $test_count - $@"
+	finalize_test_case_output ok "$@"
 }
 
 test_failure_ () {
-	finalize_test_case_output failure "$@"
+	failure_label=$1
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
@@ -799,18 +799,19 @@ test_failure_ () {
 		say_color error "1..$test_count"
 		_error_exit
 	fi
+	finalize_test_case_output failure "$failure_label" "$@"
 }
 
 test_known_broken_ok_ () {
-	finalize_test_case_output fixed "$@"
 	test_fixed=$(($test_fixed+1))
 	say_color error "ok $test_count - $@ # TODO known breakage vanished"
+	finalize_test_case_output fixed "$@"
 }
 
 test_known_broken_failure_ () {
-	finalize_test_case_output broken "$@"
 	test_broken=$(($test_broken+1))
 	say_color warn "not ok $test_count - $@ # TODO known breakage"
+	finalize_test_case_output broken "$@"
 }
 
 test_debug () {
@@ -1136,10 +1137,10 @@ test_skip () {
 
 	case "$to_skip" in
 	t)
-		finalize_test_case_output skip "$@"
 
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
+		finalize_test_case_output skip "$@"
 		;;
 	*)
 		false
-- 
2.36.1.1045.gf356b5617dd

