Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8780B1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbdFHA5S (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 20:57:18 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33727 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdFHA5S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 20:57:18 -0400
Received: by mail-pg0-f67.google.com with SMTP id a70so2850361pge.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CEgQZk0vrh4eRmyjKxujpxsVINsWPqZjE7CwrBNqbyI=;
        b=dcP6LHQDgTcJejId36s0JRg7P21k/ZUil2waB0H6TXZTfC6B/sG+rHzgqD7kI/qPrG
         4qf1Ao+KS0HVBRHtduq8Cc5GAsfvG+SeDTPEupgflrlRgkH+K65MYRCnaWZ9sXFlLIQz
         hgWb3+53plPjxM+IThejCGpEiaMwy5+pqMTPJMKGPUVO4xKVHLlJT0owXZDpeJmBLkKJ
         AAM4H868qjrIHyXJLRP88SUIQ6xk0n/kmvl1/WIdSCWAmjGu6nEL8b3WzdDoGVIUhZLz
         WldqLlvZ1sY2xzs1FAnEn/2XqIkH77JjEfSwYAidfpQ9dh+Uc0bWvNFidtfJyL3WiAHG
         WhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CEgQZk0vrh4eRmyjKxujpxsVINsWPqZjE7CwrBNqbyI=;
        b=fEE6PEg8s6xqtb1jISFEHxn5dSThcsiZtiPqnjQptgUGxxnluLsIDTC6Sp4PDz39nh
         Xmwv97Ck6c9NH0rU69wpQuh4j1cntC8iprDDbHUvRsdQ0BJsYf4/H29FrADhVSzE7TTQ
         M5J4Nxf3rKaUCqqPqIVlSDCS5l0MNT2yObYA8QFm6FQm2v3UKnJ9H4NUBTVox8zZyGaI
         3i0S+JE7iRPsxESvNn3y88UB0QV/07bITAOIdCsumDyhkOF17+Exk7qI7T0pKbdYPG6+
         wSn1AdSUeNI4ioFO4IUzNRNH2fSJGzj62dEax0cp9XeH1j+euKTgRZDVdzJL4no6A5Bu
         hsAg==
X-Gm-Message-State: AODbwcDXdiRnvVOKGRuslgHNZAUbCyCerkXj6+rWF04I2pZpQIOW4UZz
        4kP4ScDPY6Qih2BD5Zs=
X-Received: by 10.99.63.140 with SMTP id m134mr30423327pga.170.1496883437302;
        Wed, 07 Jun 2017 17:57:17 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id s17sm6418848pfk.112.2017.06.07.17.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jun 2017 17:57:16 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 3/5] stash: add test for stashing in a detached state
Date:   Wed,  7 Jun 2017 17:55:33 -0700
Message-Id: <20170608005535.13080-4-joel@teichroeb.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170608005535.13080-1-joel@teichroeb.net>
References: <20170608005535.13080-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5399fb05ca..ce4c8fe3d6 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -822,6 +822,18 @@ test_expect_success 'create with multiple arguments for the message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create in a detached state' '
+	test_when_finished "git checkout master" &&
+	git checkout HEAD~1 &&
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create) &&
+	HEAD_ID=$(git rev-parse --short HEAD) &&
+	echo "WIP on (no branch): ${HEAD_ID} initial" >expect &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stash -- <pathspec> stashes and restores the file' '
 	>foo &&
 	>bar &&
-- 
2.13.0

