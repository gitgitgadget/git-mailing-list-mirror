Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4311C4332F
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiCYTfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiCYTea (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:34:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6228EA03
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso4973787wmr.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONQV67ewCOrSEssrNjujcNGuRnwVdO+8PBGDsXaFnK8=;
        b=py9l75oCAp8NoGLlA7E08UQKmx2saNDG2t4d29QQw2CbhuUvpREc53yYTfPOSEIQHM
         H1Ykr2bkJeSM9M2kaEIA6VzllRhqsnxuA9XpdtXTD/+7RbHyNAKMcczdHamWa+dqYDgQ
         2uR7rD4nZQxUf18TuxGSNlIBmYo+RlcecyDK/oLc/MiknnUhEI03tvxhRRMOyToQ5MGZ
         PDAGrrZsz6KOZXXw2SbHcPNHPPOc6tT4r0oZ1UfNYqfsNI3W7j023TGiHfgTL42WAbar
         fypwD2vDrWKq92+9F/lV8WWyLuxiTrO2tUbu2F+/I//nTqbWQXbiv9efTxiFS8Nv3OOS
         X6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONQV67ewCOrSEssrNjujcNGuRnwVdO+8PBGDsXaFnK8=;
        b=ne/3nBsGrEgTkqj30weyzdFVKFqFRgAv1YziHqDx7rqsaXozahY8kZQA/E4Zd7sVrU
         o0Lpi+nkCViHWjWM/5y82mWLTmKvIKEvwXahQgtV4nW1dESNd+HilGe5WXP2vTNbkL6/
         57zOf3qN7B+NFPWlgIeoULadGcbwMpJ5DJZwfEzqXEZp3YTW+gpHjRPJVPiNuzjerC2I
         DR6KRbSCQBBI61fJZgcBYP2AYRX5rpy4kBkmwlZkaEYGYzjRoH4K4fMwWawEnV2ATMkx
         +pCwAmVMWp+w4RCI/z2C0YP13yOiKdqenNOW8nMOPO0j3l50W+7yYLaXeb69w9cgdjb5
         Vt6w==
X-Gm-Message-State: AOAM531cllgvkitu9ROpJtlRmqF6D8IbGG3eerUffs2a6nGBdyE5XxVB
        9SY3HSwNAF/iBny9boQkdgowGwz2RwbI3A==
X-Google-Smtp-Source: ABdhPJwhH9kedPacgq2XgOKmCLEPB3LtcqEwN7bEKP2pk43Iow+y7TGDf2qUzDIwzc2KVZ1PDcHJ0w==
X-Received: by 2002:a05:600c:4f82:b0:38c:9185:1ecd with SMTP id n2-20020a05600c4f8200b0038c91851ecdmr20698729wmq.130.1648236263569;
        Fri, 25 Mar 2022 12:24:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c020600b0038cbb21fb00sm4999704wmi.39.2022.03.25.12.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:24:23 -0700 (PDT)
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v3 6/6] ci: call `finalize_test_case_output` a little later
Date:   Fri, 25 Mar 2022 20:24:15 +0100
Message-Id: <RFC-patch-v3-6.6-1d2b94436fc-20220325T183946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
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
index 5ba4051d588..b3ee37988e2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -782,30 +782,31 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
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
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" = "" || _error_exit
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
@@ -1131,10 +1132,10 @@ test_skip () {
 
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
2.35.1.1517.g20a06c426a7

