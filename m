Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641391FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 00:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdFHA5N (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 20:57:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34261 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdFHA5M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 20:57:12 -0400
Received: by mail-pg0-f65.google.com with SMTP id v14so2848883pgn.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 17:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KS0P/JYhjnYf86D12R2Wklmhy0+wo4ExG7dN6ZNRtz4=;
        b=zttVfiPx6OQspJXUsKJH0QebxPB7Or8s732mn/xq7zIf9h3q/ICLVQMo/K6cNkYCVu
         y0wiEYx12Z/HSrM3i+LD3hMdF3FP+wjte+EezVlA5fDFGTvehHv1Jq5hvL1BFSuYyp0F
         jBSx+v2u1aGv6PC9Eq2tCko3xJ1tkZRG8S30AqFsai4RvsaLSQtEEckCgdOLnWAWmXat
         LX3k9midEVAzWGQzPLRVc5DRMwH0mvTNzXnyagjk8Pm33wNvsv30mV6ooW5X/YC5vXZ7
         xhxJNwVfmVmkCAg5R9VQ7UgSGgoA2eCT6CmRQDeg6CFSrAAF/9CKtaW8+1wA3fQDqRFm
         dwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KS0P/JYhjnYf86D12R2Wklmhy0+wo4ExG7dN6ZNRtz4=;
        b=UIM559dqH5KpkfxnzE2dlL6juN9UF2Qls6JHA37KFQloFxrvlIQ7GUdSALVQ/isbwz
         pIWdprgjZcOPh4889XYXx5WYVz3dbE6P373lno+WgFB7oHmCBPwc2yikMvOiHIrDm2KN
         5HP+1K1MLP1BBdtT+1sOwUCtwNd2wvHoeDGz4kMvxEeW9mI8ESRoNIVvB5/pnZ02ZtCX
         90OCyY0FbyH+AQ5NPwwLypJea8NvqGP3O6ib5E4zQ/HbPAuEU7i6gRYzHezzPsgNBrNK
         VvoCycc1mGrkW3YdOXHediqlKPPRQgNqD+2by4TmeoPi47wJmoaIejCVnN4eMn4W2D29
         fjWg==
X-Gm-Message-State: AODbwcDt8l8XQqKIShzoH7Ivo8H61AzGuNTWxO6oevdyRHmhtMTmQ0cj
        EDysxIlgIzp3Lrjd7cg=
X-Received: by 10.99.119.132 with SMTP id s126mr23585013pgc.52.1496883432068;
        Wed, 07 Jun 2017 17:57:12 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id s17sm6418848pfk.112.2017.06.07.17.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jun 2017 17:57:11 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 2/5] stash: Add a test for when apply fails during stash branch
Date:   Wed,  7 Jun 2017 17:55:32 -0700
Message-Id: <20170608005535.13080-3-joel@teichroeb.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170608005535.13080-1-joel@teichroeb.net>
References: <20170608005535.13080-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the return value of merge recurisve is not checked, the stash could end
up being dropped even though it was not applied properly

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index cc923e6335..5399fb05ca 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -656,6 +656,20 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
 	git rev-parse stash@{0} --
 '
 
+test_expect_success 'stash branch should not drop the stash if the apply fails' '
+	git stash clear &&
+	git reset HEAD~1 --hard &&
+	echo foo >file &&
+	git add file &&
+	git commit -m initial &&
+	echo bar >file &&
+	git stash &&
+	echo baz >file &&
+	test_when_finished "git checkout master" &&
+	test_must_fail git stash branch new_branch stash@{0} &&
+	git rev-parse stash@{0} --
+'
+
 test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
 	git stash clear &&
 	echo 1 >subdir/subfile1 &&
-- 
2.13.0

