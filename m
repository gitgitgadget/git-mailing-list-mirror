Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD5C4345B
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D057D206F4
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aY4LJyyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgGMCuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:50:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40812 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728721AbgGMCuB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:50:01 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0BC7B60A68;
        Mon, 13 Jul 2020 02:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608570;
        bh=bkn6gRdFc3a7Wl1a2vTHql6/IoBndbcv3M9Ug3dmdYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=aY4LJyypKYMzdnzDh/cBM27A+xIu/Y8XaC1YDViKfhYqFFaQo/N/3vOaGvp7vmub3
         dcyg1zngJMkarD6QlIH5oJBk7Z2JNrPJisbW5dAuQSldQXTcGDldQPH8f1xXnlD+aI
         l+h7UZZBiqJKN8R5izd+S2HTdSIR9Ok20rFh9xPTLz6UnvWbQJViMtxzFePCQsHvSM
         HOICyNoDIJNfLIY6AAcyaRDw6YA11dRLhLAX6tOCkQO2bVmLdTEqg7wF0+J05LVxJw
         2hiZF59nD3zpJ9hRd3qzAVPIK+QK9igIU1Og6wpzQzSK07Oox0zCCa5mBLEjIR/fJV
         RI3ffr+T/v1gbGTkttMGLtlWLw+34Z5E+q2hWBS09w/sRP01J2/EYVFd2EDE8oWZUj
         LTNLVfpRwOa5Qk7qsc6wGEYiYFE+D5Hoh8ne7bo6tVnvhUnUqJVp0Ik8JVmRaNZD2w
         /wBn7cA9OOfADDDuYiNWrmUjUALFAUsTN48ANFqZzZOLWlqH1Yb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 15/39] t7405: make hash size independent
Date:   Mon, 13 Jul 2020 02:48:45 +0000
Message-Id: <20200713024909.3714837-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $ZERO_OID instead of hard-coding a fixed size all-zeros object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7405-submodule-merge.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index aa33978ed2..6a1e5f8232 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -195,7 +195,7 @@ test_expect_success 'git submodule status should display the merge conflict prop
        url = $TRASH_DIRECTORY/sub
 EOF
        cat >expect <<EOF &&
-U0000000000000000000000000000000000000000 sub
+U$ZERO_OID sub
 EOF
        git submodule status > actual &&
        test_cmp expect actual &&
@@ -214,7 +214,7 @@ test_expect_success 'git submodule status should display the merge conflict prop
        url = $TRASH_DIRECTORY/sub
 EOF
        cat >expect <<EOF &&
-U0000000000000000000000000000000000000000 sub
+U$ZERO_OID sub
 EOF
        git submodule status > actual &&
        test_cmp expect actual &&
