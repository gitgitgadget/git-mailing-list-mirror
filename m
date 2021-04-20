Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A324C43470
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF65C613C0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhDTMWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhDTMWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA56C06138F
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n127so8243410wmb.5
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/nBlWuE1tdIPOvGrTELqSDs2xw15fq2mf8SutZs5hc=;
        b=o+0JVYKJgPriBpqckcnWow7XjMQurQ+o2JzQXafmEYqX7FhKu15BUhJzSM0fmp4FRz
         n6dfWEy8LbvtFlXlHm7IifKFykAvT9VYaFFO7IpfTW39JQi+NUuvRXHKUe0LEzHBh7yy
         eIbkt1FyMNVMUUGvAVgTyFzJPjYr9eSFliRRBEvmqIJM1OEZVOZicziNMrFQMg5Soqwy
         hpfuIm7245uWP2AajcnCofbCn8xgOoxFrHEgHrM2D3nEKlGpOzGv0FbNzn1FrA5tVYh8
         40s3qruKCWDRVeR2oX4mxEZqbQs1D2Y+oj7xfjnNjlYMMPYaz9vQdB6TMyCFsgYmYVC1
         2KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/nBlWuE1tdIPOvGrTELqSDs2xw15fq2mf8SutZs5hc=;
        b=mH0TM9i5D7vHNzX8dn974bHxI42OipmddYrYKCkwTrLd0nBxn/daWZne3DnjWJaafh
         kM3MIJT1QkEQLjWzDYglhxPI/mdYstmkTYtVGl8uDaijd5/HqwE3/x4bFsSFCwt58l2i
         h+MXAXrzlT8APgO5QHZOn0YmG+RqGlD/BX4ghsRX7MS4gosJi2PMnd8j58WJslDI8ZSS
         K5OY8HGdp88nTY4wktqs6GCYgqGXiHHgpXZ1q+WMCoZ9Q17xN39QtbHVNW3aMdNIqHKH
         owZEi6Jkpeb36kSkRfaU9rQ3uqWE/TjW4drAmAztHCXBFdKTIGrpt6RVgmKKuoDmSsAa
         bWpQ==
X-Gm-Message-State: AOAM530IUYiTxjBT/Q0G8AuJL1O1reBv8DIZkesWq1ysAd4C+buZo+e2
        NZm+r4l2eojkCADEqWCTaFE34pzzViuiTA==
X-Google-Smtp-Source: ABdhPJzt8taLQvkpeuW5DBN6kbZ6M5nPPqf2gUy5gQdtO1soeLXn5VPcJ+2UUhQZ/fDdFjjLURsmLw==
X-Received: by 2002:a05:600c:4b92:: with SMTP id e18mr4348661wmp.150.1618921336248;
        Tue, 20 Apr 2021 05:22:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:15 -0700 (PDT)
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
Subject: [PATCH v3 10/12] test-lib: reformat argument list in test_create_repo()
Date:   Tue, 20 Apr 2021 14:22:01 +0200
Message-Id: <patch-10.12-e0a1e2fd52-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reformat an argument list changed in 675704c74dd (init: provide useful
advice about init.defaultBranch, 2020-12-11) to have the "-c" on the
same line as the argument it sets. This whitespace-only change makes
it easier to review a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index dbeb3d9262..21271020c7 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1257,8 +1257,8 @@ test_create_repo () {
 	mkdir -p "$repo"
 	(
 		cd "$repo" || error "Cannot setup test environment"
-		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" -c \
-			init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
+		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
+			-c init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
 			init \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
-- 
2.31.1.723.gf6bad1b9ba1

