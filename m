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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25B1C6377D
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998D461264
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhGUWSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhGUWR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:17:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67517C061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c12so3831318wrt.3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ca7gPfBflFJKt+Ja0OgoxM033TuU7eqZBTOXoCvk1dM=;
        b=daYOtWTka/DQPJL1G6tm7ofOCb27jiK/6I6KM2f3gE/oFegK5YQi5PdtGxg/Kr2apx
         J/jD7VVJqzissMJKmT2mIqhQu7tuVBZDYzL0BKkiW6KsngB2ZK8b/pSIYePDNl6/8b5/
         jA2DaIp1a5FPqquh94/UyTlrYsWkiyMgvFoCqKlNofYDl3Boe7Qil+KO/IVDJS/RcuTP
         JDN3mhmawENSxBmp+S/aW0bHXkb/DrfuK+Z2Ku2rVfOKXG0iH+SCKdBqVwy7MiWIaAIW
         1kKCgqZUmkN3Wb/eo6whe0GAhxwKfegWWNOUzioVov0E1jaE0vgxggUUSrQ8AGlhQATA
         esKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ca7gPfBflFJKt+Ja0OgoxM033TuU7eqZBTOXoCvk1dM=;
        b=Oko4i0q/PhLJhQLyHcZ/wH9y3aj0unVQDXjRIuVkcBvlrtf7ddlG7bMvqGXgGdIpEW
         CQijNtkv4SLb+hHRCk8d155sphcUUZXtyn29PcaLGF7BQu04RYwmImf/T7Gh6mx6vC/J
         QDupsziFfASi3Z94WH9iQa6lfXGfCfsz52tfVw+A+MeRvv2TDM8/Ifpl496e4R2yPpgE
         NV4xMj7q7pOpXXUlBYk+gIWINVu558oDYsJKKu0ia4SATonTzTH2ZLeVMucfDjZQSUoO
         JwlXgZRtvZFORWf7l/Ym+fCj+xcneleSFkkQ+vgyFVm377OWglsAN40n75L6VDATToSR
         w6DQ==
X-Gm-Message-State: AOAM530MO1Ot7EyDkIil3qOwESarJWGBP2/Tgd1r2VeGF8XuyYCWrM5y
        V4iZ528q8QmafFE/wPoTA8Ayib4ruvNVpg==
X-Google-Smtp-Source: ABdhPJwJRGrhUS0e44U5CQp4qw/ITCK3eNFWypuw4wDlQAQV84oHmR1dnZmyvPHTO9Ed/FiCOPK/6A==
X-Received: by 2002:a5d:4a4c:: with SMTP id v12mr44483387wrs.256.1626908310810;
        Wed, 21 Jul 2021 15:58:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g18sm23129818wmk.37.2021.07.21.15.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:58:30 -0700 (PDT)
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
Subject: [PATCH v2 8/8] test-lib tests: assert 1 exit code, not non-zero
Date:   Thu, 22 Jul 2021 00:57:47 +0200
Message-Id: <patch-8.8-676547e001e-20210721T225504Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com> <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the testing for test-lib.sh itself to assert that we have a
exit code of 1, not any non-zero. Improves code added in
0445e6f0a12 (test-lib: '--run' to run only specific tests,
2014-04-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 2fde75e8863..f7ad7bc7d7d 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -43,8 +43,8 @@ write_sub_test_lib_test () {
 }
 
 _run_sub_test_lib_test_common () {
-	neg="$1" name="$2" # stdin is the body of the test code
-	shift 2
+	cmp_op="$1" want_code="$2" name="$3" # stdin is the body of the test code
+	shift 3
 
 	# intercept pseudo-options at the front of the argument list that we
 	# will not pass to child script
@@ -80,33 +80,30 @@ _run_sub_test_lib_test_common () {
 		GIT_SKIP_TESTS=$skip &&
 		export GIT_SKIP_TESTS &&
 		sane_unset GIT_TEST_FAIL_PREREQS &&
-		if test -z "$neg"
-		then
-			./"$name.sh" "$@" >out 2>err
-		else
-			! ./"$name.sh" "$@" >out 2>err
-		fi
+		./"$name.sh" "$@" >out 2>err;
+		ret=$? &&
+		test "$ret" "$cmp_op" "$want_code"
 	)
 }
 
 write_and_run_sub_test_lib_test () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	write_sub_test_lib_test "$@" || return 1
-	_run_sub_test_lib_test_common '' "$@"
+	_run_sub_test_lib_test_common -eq 0 "$@"
 }
 
 write_and_run_sub_test_lib_test_err () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	write_sub_test_lib_test "$@" || return 1
-	_run_sub_test_lib_test_common '!' "$@"
+	_run_sub_test_lib_test_common -eq 1 "$@"
 }
 
 run_sub_test_lib_test () {
-	_run_sub_test_lib_test_common '' "$@"
+	_run_sub_test_lib_test_common -eq 0 "$@"
 }
 
 run_sub_test_lib_test_err () {
-	_run_sub_test_lib_test_common '!' "$@"
+	_run_sub_test_lib_test_common -eq 1 "$@"
 }
 
 _check_sub_test_lib_test_common () {
-- 
2.32.0.955.ge7c5360f7e7

