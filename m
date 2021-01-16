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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D96FC433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71E2227BF
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbhAPRGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbhAPQbE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 11:31:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF77C06134C
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 6so4931507wri.3
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzkgtII+vG8W//1MFeS4m/pMge8EnccbgB86+vMPwyA=;
        b=XhC0PXGMvWb5MC7+UDmgp9/SIc0tZIQHglrEGp9QRKq1gcI6wh7aLz2dqn/iihPdlJ
         fy9lgCbl1FqXhncgwXNs78pftSh0hwDOhWJioaqhUPvt/1C7ppQfcS4CRejw5Gam/3xN
         Cd5DhbX/pIl9KWe05py9iIfQXjx1jwaGQFSh5jVJXnvvcX8tlNWukNTiW45tevL5e9N9
         Rr14QKoJk+O0UteXjPybu5WDdQEFOIX5S/6FCoTP1gvtiGHPn6ek/QlRyPjVFmTy2+hN
         /okESr7Tusym9ikYWtQmdTJZ9co1UAys6vK244MSnckbZM5a8/RR6uu/CDFvRuzPQfco
         8plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzkgtII+vG8W//1MFeS4m/pMge8EnccbgB86+vMPwyA=;
        b=Gy57vuLcj/8Gbx5tCmY/39x1aNk14voVZW3OEhpWcnxRLvn7bZspCDjSXJ88KGXnck
         4UySqe/1pU0u6Kmmvqpxeg8pfJuaF9mI/CBMPddgcgGRTR2+OfEOY3QZ094Pu+0RegbN
         ABDbbeMQRgsR3Ma+MFAdlPHBezZM5krp0CpV3FAZKWwFNrKzeBbq4oQZeAh3MxDvbAI0
         v8ySAA/zeAv+9s9uh/ZasEyHEjBy/QETt7REhHipUL3tB9pQsPcngikavJi8Ayc/XwV+
         ILG1z5THJPloUo0/WJG/DF3Eyc3HwASwr5GvbaiQ3z41RS/Pp+Id4qsXoyoqSxnXRjVT
         Tb8g==
X-Gm-Message-State: AOAM532mDZY7iNGgAlAiKSkqw5tpT4n/SAKDGW0bf8fxAnzWoyCYA+g3
        yysSl9g7Y4ubMMgGYTumP2dyCK006nMe9A==
X-Google-Smtp-Source: ABdhPJyNm/eSK3Cxaf4eNUxAVik1ceGOLwSDqLY/bvtokbBbVIVeCoFTbT2nOKHNu9ryrxkLzReNlQ==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr18348243wrr.61.1610811365869;
        Sat, 16 Jan 2021 07:36:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:36:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/11] git-svn tests: rewrite brittle tests to use "--[no-]merges".
Date:   Sat, 16 Jan 2021 16:35:49 +0100
Message-Id: <20210116153554.12604-7-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Rewrite a brittle tests which used "rev-list" without "--[no-]merges"
to figure out if a set of commits turned into merge commits or not.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Commit-message-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9151-svn-mergeinfo.sh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 806eff4023..c33bae91fb 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -17,21 +17,17 @@ test_expect_success 'load svn dump' "
 "
 
 test_expect_success 'all svn merges became git merge commits' '
-	git rev-list --parents --all --grep=Merge |
-		grep -v " .* " | cut -f1 -d" " >unmarked &&
+	git rev-list --all --no-merges --grep=Merge >unmarked &&
 	test_must_be_empty unmarked
 '
 
-
 test_expect_success 'cherry picks did not become git merge commits' '
-	git rev-list --parents --all --grep=Cherry |
-		grep " .* " | cut -f1 -d" " >bad-cherries &&
+	git rev-list --all --merges --grep=Cherry >bad-cherries &&
 	test_must_be_empty bad-cherries
 '
 
 test_expect_success 'svn non-merge merge commits did not become git merge commits' '
-	git rev-list --parents --all --grep=non-merge |
-		grep " .* " | cut -f1 -d" " >bad-non-merges &&
+	git rev-list --all --merges --grep=non-merge >bad-non-merges &&
 	test_must_be_empty bad-non-merges
 '
 
-- 
2.29.2.222.g5d2a92d10f8

