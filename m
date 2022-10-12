Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761F9C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJLJBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJLJBk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:01:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E768F964
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w18so25250248wro.7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA4LOYKHGlx0bJrVegfbP1hLoK3qw8N2dy1AH/p4Ilo=;
        b=cNlTwh4nmEcAWHd0zn8QNUGzBN/ubEmxB0iKyCjduNwIraTWDpdgwpOOk270qRSLk/
         /nLL/RKSneRLejNkNri5Jeu+q0TUT6f5OoF5KJnqtUlSJQLVU6jKENQ9RSAT2ndG4dKW
         Q3hEjio3ince54BZxSamu44SdWO4/nYoRHPAYBcxz7QTwSIpdXsW7kEV3RT/ztkPNWFN
         c4+OHdKRevTPZvF5UNVEHUciktIoctGVYLTIyL4Qogvj4TdyZoajQauQGw5UcvYVuhbW
         3rKiVfrQHEnTzsyIHgCl0jDd4scXmaegt61GEgalxSDXLpGh6Swow+aoSz9qLXptJuJy
         VF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA4LOYKHGlx0bJrVegfbP1hLoK3qw8N2dy1AH/p4Ilo=;
        b=e+3SFXnXLNetNRThgGcSMUymh/usy/DKQrTaE1mWYXGDWjJafy2WBpfq10vRACSTrB
         YzJWAfN3a+NlBB+vloH1EkVAtGV7oUb/aN+kFXynXI6uWxYfxxUE7FK78oxl3KseHQlU
         oEWjT+YEZ86n/kJ1AtC8Du8QUdmm9uBDai+3v7giOjm/MDa+lsKu1EWguKAjWZq0JOiE
         jy7x+gnKyiekcLr6ZPboL6zIycouOyn4CwE8AmR+kv4XFaSV8iQFF4tJzr2R+j4gj2Ch
         ntM05fKDW/GhCta8vy/wmz5aCfSYN/tOgJxL2itGidkbPyFxvRa2tTTh4an4TONd9YMN
         6VZQ==
X-Gm-Message-State: ACrzQf2TnwZW/vehxYYRlgNm9W+j1402TZpfM2kXBncpSegPqCOpIcL0
        LisSu0Up4c0IEmysFM8ck3AKxnViQKdvcA==
X-Google-Smtp-Source: AMsMyM6zL+my6VWH30J5hzISXsZt4w2cnAtCHdqTV6GoNZyW/qdWi42BheeVHCDV+0cQ7rwTbUJoXw==
X-Received: by 2002:a05:6000:1885:b0:22e:7851:b257 with SMTP id a5-20020a056000188500b0022e7851b257mr17184765wri.418.1665565297447;
        Wed, 12 Oct 2022 02:01:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/22] submodule tests: reset "trace.out" between "grep" invocations
Date:   Wed, 12 Oct 2022 11:01:10 +0200
Message-Id: <patch-v2-02.22-3027f5587a7-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix test patterns added in 62104ba14af (submodules: allow parallel
fetching, add tests and documentation, 2015-12-15) and
a028a1930c6 (fetching submodules: respect `submodule.fetchJobs` config
option, 2016-02-29).

In the former case we were leaving a trace.out file at the top-level
for any subsequent tests (there are none, currently). Let's clean the
file up instead.

In the latter case we were testing that a given configuration would
result in "N tasks" in the log, but we were grepping through the log
for all previous such tests, when we really meant to clear the logs
between the "grep" invocations.

In practice this resulted in no logic error, as e.g. "--fetch 7" would
not print out a "9 tasks" line, but let's be paranoid and stop
implicitly assuming that that's the case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5526-fetch-submodules.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a301b56db89..e36f9fdf242 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -177,6 +177,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
 '
 
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
+	test_when_finished "rm -f trace.out" &&
 	add_submodule_commits &&
 	(
 		cd downstream &&
@@ -704,17 +705,25 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 
 test_expect_success 'fetching submodules respects parallel settings' '
 	git config fetch.recurseSubmodules true &&
+	test_when_finished "rm -f downstream/trace.out" &&
 	(
 		cd downstream &&
 		GIT_TRACE=$(pwd)/trace.out git fetch &&
 		grep "1 tasks" trace.out &&
+		>trace.out &&
+
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 7 &&
 		grep "7 tasks" trace.out &&
+		>trace.out &&
+
 		git config submodule.fetchJobs 8 &&
 		GIT_TRACE=$(pwd)/trace.out git fetch &&
 		grep "8 tasks" trace.out &&
+		>trace.out &&
+
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
-		grep "9 tasks" trace.out
+		grep "9 tasks" trace.out &&
+		>trace.out &&
 	)
 '
 
-- 
2.38.0.971.ge79ff6d20e7

