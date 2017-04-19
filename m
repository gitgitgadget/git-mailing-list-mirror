Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1391FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 13:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934376AbdDSNPS (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 09:15:18 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35887 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763496AbdDSNPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 09:15:16 -0400
Received: by mail-qk0-f193.google.com with SMTP id v75so3235473qkb.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=PGq3imR0tl5vOLRIApFjvhPhGZfhaeYQA0pnZsBeu6rZml6hEPPSrnsWaIsdFFGhTo
         so8OQNtTv1UcYmRmSMZV5p9FrYtMRTXLm/CfJJyA8I9+cnpfIBuvHXXH0hQU6klaCu6W
         RwyUk+nYcfshETXyGnGQJ3a5YvCTQEdyG1yrRbck/0N8Zr4dEBvP6IoTFI6UbxCyiWUV
         8coNPcAByG7rHRB/R45a4j8K/qjnHf0VZDEc+sbyl28uRfPl+AM4t69K17eWHjowmGmd
         8zbX+4X4g4U6xO6Y9ABVM4CJgPdNu9l/JELKfUz746a3O3FMHgEu4ARiT4AW4AhWjaOH
         JxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=b3gcohgVgXKfKyokyKlSTAPe0hJzgIZfnKVcWndqgvmeej8ho9yeIEtJtyHyTZM9N8
         KjQs/DFXktCJtHxeW/uz/LRPGFOz6Z/VLOwojfTfZkGippDxjUMfazb9ZWjDb7NCvqFg
         cDpoCW87q4ElTBaNCbdfvPAmGOeDuFdS3nHKU3Kx7ja1soK8SIQSwameGTEPCyqkEAmO
         QFv82wjWbFKwdf6tG+cL96eWyKRcPnw71wA12l/Rf9bHo12yS1XB8RWmcWj+tcJRclRH
         7sMSgro2xsqqbCzFKmUu2+HVIUP6sC5KR+57LiEfkp44cteKEBlydTgPt1KFQrxVJcC+
         zwQg==
X-Gm-Message-State: AN3rC/52w0VWMZK3mOdF44LolROxfGpzlid7INO7Q3qIgzQmKKF4RVoy
        kWU9mpRsruB0rA==
X-Received: by 10.55.195.142 with SMTP id r14mr2262533qkl.260.1492607715848;
        Wed, 19 Apr 2017 06:15:15 -0700 (PDT)
Received: from localhost.localdomain ([201.52.189.180])
        by smtp.gmail.com with ESMTPSA id k133sm1835587qke.25.2017.04.19.06.15.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 06:15:14 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v10 2/5] remove_subtree(): test removing nested directories
Date:   Wed, 19 Apr 2017 10:14:09 -0300
Message-Id: <1492607652-36341-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
References: <1492607652-36341-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test removing a nested directory when an attempt is made to restore the
index to a state where it does not exist. A similar test could be found
previously in t/t2000-checkout-cache-clash.sh, but it did not check for
nested directories, which could allow a faulty implementation of
remove_subtree() pass the tests.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 t/t2000-checkout-cache-clash.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t2000-checkout-cache-clash.sh b/t/t2000-checkout-cache-clash.sh
index de3edb5..ac10ba3 100755
--- a/t/t2000-checkout-cache-clash.sh
+++ b/t/t2000-checkout-cache-clash.sh
@@ -57,4 +57,15 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 	git checkout-index -a -f --prefix=there/
 '
 
+test_expect_success 'git checkout-index -f should remove nested subtrees' '
+	echo content >path &&
+	git update-index --add path &&
+	rm path &&
+	mkdir -p path/with/nested/paths &&
+	echo content >path/file1 &&
+	echo content >path/with/nested/paths/file2 &&
+	git checkout-index -f -a &&
+	test ! -d path
+'
+
 test_done
-- 
2.7.4 (Apple Git-66)

