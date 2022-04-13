Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CE2C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbiDMUAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiDMUAG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:00:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551837893F
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4657759wme.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WoqTf6Sb1mCn+wDyRrkMVwa1Ih51AjSZ25Uaz2v1YZs=;
        b=nCrdwWHKweoJmCWCBWeNmDM0KeA68DYJXUSFgUtkDMRmv2MkA3pOLtRv0B1Xz9UKtd
         DH41Cea+B3Q5S6qkQtBsk+5oy4uzeSzTBFokORldwKD2bfPY6V1VjBCazBaZFLTD+FHJ
         ULShm8gYSl4k3iwjwGkyXpSBrZRvANQCbMfuP0mgWiPiubblKrYaCZqvjq69Ek/YN6D3
         CpKR+roUr16AM1Qrz1pMm8DDfTl4XjumwsHUANoT1jmOn3A2W3YJf5z1foUK+m3o8bX7
         9+yxs3Ga4wmhaWfhO/k8c3ZvvhZRM6cUxeQbXYX7ONg20ZBEuYWjDBOqaOadg1PeO6wJ
         lBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoqTf6Sb1mCn+wDyRrkMVwa1Ih51AjSZ25Uaz2v1YZs=;
        b=MqDOX/Us0UfB5HqkfPXTifbmv2ZMdk47qbyLrgpCThJfHCs3xJair+/igjxm7XpNJa
         mXHn3H/0uwtjrDnCUeivIMt5H9n0t8QbrzoSqDKv1VkeSXwd93gYgTFHClGCYHId5cZf
         hGF/RKHq0mNnSgPFAuzF7KOdpoQJAnoUSXzRNka5tgUOgNRRlpbuU3Ho1+PoPtKZGHHv
         rJAdg3RAoK2HIG/H5kKyQpK/USR9adVmWnZX7Y87ARwnuhTzygIKhlBijo4POz6bocjy
         DFV+tk7iY7tFcov2SPLwU932ZZCEI4A8uaVOlR9hSTXyGowD9smIqu20soMTB+WkUHie
         1tvw==
X-Gm-Message-State: AOAM533E6iwTBdLJHmcg+rX7tjfe8PKYflcYmxD8SLNdNh7f1kbWC4Br
        lbcs6onhls2ZVB08ALuVz+3iah7X6qkxpw==
X-Google-Smtp-Source: ABdhPJz/3qm03n9iBUmQNuL89WG6R4orbmMpgQtl5I+GlNmqFIYxyun4rAaNZIrKD5Y6wS3Ohde5QA==
X-Received: by 2002:a05:600c:1c10:b0:38f:f033:b665 with SMTP id j16-20020a05600c1c1000b0038ff033b665mr281530wms.85.1649879856536;
        Wed, 13 Apr 2022 12:57:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm4547802wmq.27.2022.04.13.12.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:57:35 -0700 (PDT)
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
Subject: [RFC PATCH v4 6/6] ci: call `finalize_test_case_output` a little later
Date:   Wed, 13 Apr 2022 21:57:28 +0200
Message-Id: <RFC-patch-v4-6.6-b291f64821c-20220413T195514Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
References: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com> <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
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
index 8a63b4b64c9..1ceba46215f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -782,13 +782,13 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
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
@@ -798,18 +798,19 @@ test_failure_ () {
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
@@ -1135,10 +1136,10 @@ test_skip () {
 
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
2.36.0.rc2.843.g193535c2aa7

