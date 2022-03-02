Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0E7C4332F
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbiCBR24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243908AbiCBR2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6033012AB3
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i8so3896889wrr.8
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9TrVgCuBOb7yuOG4o98H3LBVPyEe8tnm83mzh3DWAI=;
        b=XAe2sjt6R3GOpEIvl+qUy+ahkq18bicowvhwYmyIRYaT/VKA4nwS2oCWXik1+kCNys
         hOgqU3T/HgPuVVzKkKPV8sKA2yR4dwPoah8gNopaHfjQQ5sLRnuJXS/ZU8hVVCrkaof9
         mrfNSreEqeU8GJ1VyWLYmTR4Zn/4tHEKO4qQXCeb1n+oIgcCLwvx2Ce2VVH2Wvoxjw7l
         Mi9+XmaFl/XliYagBFDeEAOTnD8ekjT/meKq7DOfCT5tm6JSYDmT7BtqUdH1ZWGcDHJc
         L/8hvi7IrnfBoWlWHC1UwITLFlwKXWNwce7WF7dpZe2wzbq/E83taF7jZcuwrutPkNMh
         n4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9TrVgCuBOb7yuOG4o98H3LBVPyEe8tnm83mzh3DWAI=;
        b=ktKSZ8k9I5yvXeeQX9zKQjS+/aeObT8v6Ufdw3IUdvS5AsfUDFuQwBCymyIXLuNAuf
         R7qfQ1I0CXaAmav8w7Ukygu1FCPFsUJW0KQXi57bAQd0xlcXwfkCatHKzde99sNvMA1T
         uZx6wYZRYaXHgMvs6uGRNOtrWujw48NcxGyZ3TtiwkOFibuJdp3Z1CXvQEqE+g2VC/2G
         QudUPyB2IWd61OFuk6xe30pCPIQnPuOGo9ahTf61EKgkq3nIDZVKe7ul+U0s1n4JbN+L
         Kmf56VfQvzw7Lz6EiQYAFcSe+rQuGGibOqtofsU2/JXW2J/1GZdjf+ubLFLM9S+0fqPj
         P3qA==
X-Gm-Message-State: AOAM5328D+j36VNHjQV3Je/CCa/rMBV1RXCJZIRIgBZv92cjBmpZrw6l
        /mJDAUhxQzp1IwR8oBo9aGCeRkRNjDtgvw==
X-Google-Smtp-Source: ABdhPJyCo1s4QLhR2GMUpoGdXG+1HwJe6dzScatiGgnMkn+dCGUi+mO7ROsOEPnFUd5NGjEEu2V+gQ==
X-Received: by 2002:adf:dbd2:0:b0:1ea:9382:6bff with SMTP id e18-20020adfdbd2000000b001ea93826bffmr23548551wrj.705.1646242059686;
        Wed, 02 Mar 2022 09:27:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/15] rev-list tests: don't hide abort() in "test_expect_failure"
Date:   Wed,  2 Mar 2022 18:27:20 +0100
Message-Id: <patch-11.15-26c838f0560-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a couple of uses of "test_expect_failure" to use a
"test_expect_success" to positively assert the current behavior, and
replace the intent of "test_expect_failure" with a "TODO" comment int
the description.

As noted in [1] the "test_expect_failure" feature is overly eager to
accept any failure as OK, and thus by design hides segfaults, abort()
etc. Because of that I didn't notice in dd9cede9136 (leak tests: mark
some rev-list tests as passing with SANITIZE=leak, 2021-10-31) that
this test leaks memory under SANITIZE=leak.

I have some larger local changes to add a better
"test_expect_failure", which would work just like
"test_expect_success", but would allow us say "test_todo" here (and
"success" would emit a "not ok [...] # TODO", not "ok [...]".

In lieu of those larger changes let's more narrowly fix the problem at
hand here and stop conflating the current "success" with actual
SANITIZE=leak failures.

1. https://lore.kernel.org/git/87tuhmk19c.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6102-rev-list-unexpected-objects.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 6f0902b8638..cf0195e8263 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -17,8 +17,13 @@ test_expect_success 'setup unexpected non-blob entry' '
 	broken_tree="$(git hash-object -w --literally -t tree broken-tree)"
 '
 
-test_expect_failure 'traverse unexpected non-blob entry (lone)' '
-	test_must_fail git rev-list --objects $broken_tree
+test_expect_success !SANITIZE_LEAK 'TODO (should fail!): traverse unexpected non-blob entry (lone)' '
+	sed "s/Z$//" >expect <<-EOF &&
+	$broken_tree Z
+	$tree foo
+	EOF
+	git rev-list --objects $broken_tree >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'traverse unexpected non-blob entry (seen)' '
@@ -116,8 +121,8 @@ test_expect_success 'setup unexpected non-blob tag' '
 	tag=$(git hash-object -w --literally -t tag broken-tag)
 '
 
-test_expect_failure 'traverse unexpected non-blob tag (lone)' '
-	test_must_fail git rev-list --objects $tag
+test_expect_success !SANITIZE_LEAK 'TODO (should fail!): traverse unexpected non-blob tag (lone)' '
+	git rev-list --objects $tag
 '
 
 test_expect_success 'traverse unexpected non-blob tag (seen)' '
-- 
2.35.1.1226.g8b497615d32

