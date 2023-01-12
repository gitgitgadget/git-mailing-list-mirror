Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E45BC54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 11:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjALLJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjALLIP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 06:08:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008BB2019
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 03:00:38 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id l22so14086310eja.12
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 03:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSnD3oj50yMKxc2IjMOHpDrQQSmCGlPi0WGyE394pEY=;
        b=cx7MRiZQcmvs45706qXZ+0NOSctbbckj3Kz6Cjr+sAGIRiCA/JRWgTiU0E1Gn09hFR
         9UQmmGVrWu01Qf9oFNxd7FKPO+X8LUVtQpqgB3tLesSw7VkVMzZuAGxpPLKDYn6vBRl8
         RwIegq52zQjLTk16U3ylMiavF3+7o8l6/ufehYRP54ePqUhSBRvxphi+bkKyXjxABW++
         G+VqRwAHmImTWLaIjGGYEJ4UFdOCf8Inb5Zm5qCTFLmOxI3tsjCVfDeWmw06/E8nkcl0
         avRI94xIgdOBfvAzoBOHjrs8FHaK0PLg4hsoNVWReUEUTTYvvaSzovChC6lVpGQoe37T
         SCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSnD3oj50yMKxc2IjMOHpDrQQSmCGlPi0WGyE394pEY=;
        b=EHur9JQ0rNXewjv4PtkIiCOY9tLuWVsog8GHcw2TbHGrxdBbz0QcoUcCYfvBSXWBAh
         SAaY4vNfizX55aMkMK2SJ8wvXu6N5RuViZcyL0BcPJD6yKN+UErTqozGXFcqXmn+IkAa
         LpHlTFm8dLqrYMEZajPvhVjF+iv0MIldaU70kV0JyxofVKxXkImXkJlu2is7ORqHCJAR
         xad8+HDZvwGWD91h9l1dqzq078+RHV2doYYKKfamGyKPLBwnavfQ3NIs09bgHlfuhRf2
         DJOaGPHd5v1AXd3bdgA9tyNP6L8rlgsh81R6ansfUfjdYeXNsMO2RidliCjTCobmFdxt
         DCVw==
X-Gm-Message-State: AFqh2krzu17qlsRzw8KhlCvyJNQI2Ff64NX2N0rF0g03M5ENpPs4SaxY
        T/zR9xBeisy7rB1xRbs69q72XzuI+jM=
X-Google-Smtp-Source: AMrXdXvtFfuY0cwsqIEJywob3Gk6pEtwfjJxv+5g5fnWqIV+AmA3YxQXNPZBHTsjeDzyPtyeryIAaA==
X-Received: by 2002:a17:906:b10a:b0:84d:c58:f52d with SMTP id u10-20020a170906b10a00b0084d0c58f52dmr20586888ejy.35.1673521236635;
        Thu, 12 Jan 2023 03:00:36 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id g18-20020a1709061c9200b007c1675d2626sm7418868ejh.96.2023.01.12.03.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 03:00:36 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood@dunelm.org.uk, sunshine@sunshineco.com,
        Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com
Subject: [PATCH v6 1/2] t0003: move setup for `--all` into new block
Date:   Thu, 12 Jan 2023 12:00:30 +0100
Message-Id: <622475417916cf48b8fb48e3587f6c87750d43ed.1673521102.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673521102.git.karthik.188@gmail.com>
References: <https://lore.kernel.org/git/cover.1671793109.git.karthik.188@gmail.com/> <cover.1673521102.git.karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is some setup code which is used by multiple tests being setup in
`attribute test: --all option`. This means when we run "sh
./t0003-attributes.sh --run=setup,<num>" there is a chance of failing
since we missed this setup block.

So to ensure that setups are independent of test logic, move this to a
new setup block.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Co-authored-by: toon@iotcl.com
---
 t/t0003-attributes.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f7ee2f2ff0..b3aabb8aa3 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -203,9 +203,12 @@ test_expect_success 'attribute test: read paths from stdin' '
 	test_cmp expect actual
 '
 
-test_expect_success 'attribute test: --all option' '
+test_expect_success 'setup --all option' '
 	grep -v unspecified <expect-all | sort >specified-all &&
-	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
+	sed -e "s/:.*//" <expect-all | uniq >stdin-all
+'
+
+test_expect_success 'attribute test: --all option' '
 	git check-attr --stdin --all <stdin-all >tmp &&
 	sort tmp >actual &&
 	test_cmp specified-all actual
-- 
2.39.0

