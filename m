Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C18C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DCA60C4B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhJNXj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 19:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbhJNXjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 19:39:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9EDC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 16:37:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r10so23053373wra.12
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ef40BbK5Y9M2u6Sp3crkei2YmJ2zBkMp8BW7pVGFLEI=;
        b=lhMfnaq40pAw25KEKhVLtcNLSjmbvt5YffFkKjgePcytx7N1QC+n+OzHMDg53Bq9ZP
         FlwXqd9WSqabr6qJYZxovMVWOhszAKO7x58D9b/YIwvqqYVnqiruhRcTuceXCnKa3Y2C
         5r+SM0/fACIeFVE+XBd7ONBoBQBvyidnAjAC/CVg6Dyy8SxxFJxgT38/ZU4gOporb8yT
         qfp/xwFRWKkhlLw2wyLQvoru84ekcjbMBc/QuK0FznOYeVMN6Cj0Cgc67lqDEaPTzohb
         oVcPQlG4lgre2zZu68CVJKhRPD/om4gf0SWLJop9hx9Q0AizEP8MoLtOeUKp57zXyxId
         2B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ef40BbK5Y9M2u6Sp3crkei2YmJ2zBkMp8BW7pVGFLEI=;
        b=r+CamSTyInXHHPkUANWfls7lwkeJEQi8jgsdzTxIWUBi/1weH8ZpGaDJeNSAy0JEwP
         6Ys7UlUILFIyn4Usnd22AFpiysF9mlu50LFZK7cvZRhN7CRjD9/ot4ezO2w6znsaDcji
         c2YFzZJpD8SFn2YygB1tTpjGisuHYjgpNi9BMMYmeDKtGDoGyFPrKhNBNxRWQQnO3GKb
         jD9zOhbPXmBrpAX9iqb2gHlrv2RvQpFg1hN1i9sD4eeFOoXQYFoaGlWOqYLjhSg/i+qd
         GYV9+O0XATtsRHMkK7sicXidi+hqjlRHAfCiD2IchCImKEmPQh6+J4PXxa+XHNmSbMrT
         4aFA==
X-Gm-Message-State: AOAM532B6coRaE4CzTtwGZQ9LmOov3wRrFBX93se42XjkHe6/zSmUXlo
        BPMLRKB5GLF6KJ18ZYiAjNA1mNKmiJnLQA==
X-Google-Smtp-Source: ABdhPJwliZpWFtYZOcu420BVwpfHrAcOeRllIwN/HvEIflFTLw8O/0EpJEU7n3cQ3i9FKfB8gAispQ==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr10317706wrs.110.1634254638524;
        Thu, 14 Oct 2021 16:37:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g16sm3547658wrs.90.2021.10.14.16.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 16:37:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] commit-graph tests: fix error-hiding graph_git_two_modes() helper
Date:   Fri, 15 Oct 2021 01:37:14 +0200
Message-Id: <patch-1.3-f74cc32ceea-20211014T233343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The graph_git_two_modes() helper added in 177722b3442 (commit:
integrate commit graph with commit parsing, 2018-04-10) didn't
&&-chain its "git commit-graph" invocations, which as can be seen with
SANITIZE=leak will happily mark tests as passing if both of these
commands die, since test_cmp() will be comparing two empty files.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5318-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 295c5bd94d2..88fbe004a38 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -70,8 +70,8 @@ test_expect_success 'create commits and repack' '
 '
 
 graph_git_two_modes() {
-	git -c core.commitGraph=true $1 >output
-	git -c core.commitGraph=false $1 >expect
+	git -c core.commitGraph=true $1 >output &&
+	git -c core.commitGraph=false $1 >expect &&
 	test_cmp expect output
 }
 
-- 
2.33.1.1338.g20da966911a

