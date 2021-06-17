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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59171C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B5C613C1
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhFQKzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhFQKzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:55:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3122DC06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:53:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c5so6225392wrq.9
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MDo3zv4nqdbgXSYHHI4fYxg5rx+MAOAz0ylsRiiUM8=;
        b=P37SdoeGU82KPAUILtRd+UfUVSdo2fdJFGA6UQz5929qAxMStyAy1hnTnOd7Tz76dR
         PatwHsvrwXxERL+X9JaRp585bflyQln4+mi6ZDW8WbUkkjY/kkk/EMkn1dzncvX/A3ca
         g/ytalkZlP6p8IGFoRW5S6WH/DoCpnmOydIkQ4Sc0ZZ8vVL0FsX3312bdWnNCjuAo4B2
         CQ3HZivCSLDKv1L/j6MiwTb33So9aIdwp523wiMH/OVNfDISivBo74Jr5CXN3T+k4bCH
         ARPdclktVlKS4cEUJQ/PKYHpG1y8TAdg7bf340RtzVnezsYt7kXPJbORYzpFnH9MdDxt
         FxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MDo3zv4nqdbgXSYHHI4fYxg5rx+MAOAz0ylsRiiUM8=;
        b=CPfieFtxX1PnOJ2JTIQ+Kd1zp8KyFlWF8yfDB86MVjQeJH/wIdXmTFjiVKyEAGA5fs
         kOni2UXKbfTyXMcJ5bhzN6JaSVU+obVHjGJZZXHeVfXZMpO0KRyfUNSXaUaINYJKNlLJ
         gQTKvLJa1sIrnAqo2LB+Z+kOnx3A+M8In1pGPGpasA0kG9J7UfhXdBdRr1J/A+lbyauz
         NrNzG73bVSW0CISVx68K0B/AcpuipOTP/bEOa3h1/zYhVVpDvXANBGcgCn9vVYuo3n4O
         fh+nmZy7w/KXXUMT7z5h6NzQjYjSQuEscFbBqqszfAotFoh0eVOPhv5y/YwMLNtHSb28
         xs2A==
X-Gm-Message-State: AOAM532Ls0Bw24ag5Y3sjC5IIiTS8Er0KSzBLFqK3MJHMAph43+nd1+M
        c4537gYxz//rN4aI9Ho2SJ7YP4lpy5PaKw==
X-Google-Smtp-Source: ABdhPJzAGS9/DNOgB03pCfy+S/TKOnDFhH6yAhYgBt3/T7bFo7Zj2VeqsOAwyvkztFeSwEnf9PD78Q==
X-Received: by 2002:adf:e948:: with SMTP id m8mr4923166wrn.205.1623927221400;
        Thu, 17 Jun 2021 03:53:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 61sm5409586wrp.4.2021.06.17.03.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:53:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] show-branch tests: rename the one "show-branch" test file
Date:   Thu, 17 Jun 2021 12:53:35 +0200
Message-Id: <patch-1.4-7b8ac43339-20210617T105245Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com> <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the only *show-branch* test file to indicate that more tests
belong it in than just the one-off octopus test it now contains.

The test was initially added in ce567d1867a (Add test to show that
show-branch misses out the 8th column, 2008-07-23) and
11ee57bc4c4 (sort_in_topological_order(): avoid setting a commit flag,
2008-07-23). Those two add almost the same content, one with a
test_expect_success and the other a test_expect_failure (a bug being
tested for was fixed on one of the branches).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/{t3202-show-branch-octopus.sh => t3202-show-branch.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t3202-show-branch-octopus.sh => t3202-show-branch.sh} (95%)

diff --git a/t/t3202-show-branch-octopus.sh b/t/t3202-show-branch.sh
similarity index 95%
rename from t/t3202-show-branch-octopus.sh
rename to t/t3202-show-branch.sh
index 5cb0126cfe..8cfbbf79c1 100755
--- a/t/t3202-show-branch-octopus.sh
+++ b/t/t3202-show-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test show-branch with more than 8 heads'
+test_description='test show-branch'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-- 
2.32.0.571.gdba276db2c

