Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFB4C433E5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257C4207E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="L+z5UZXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgG1XfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729844AbgG1Xe6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:34:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A7DE360CF7;
        Tue, 28 Jul 2020 23:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979298;
        bh=YnqhRm5cXPRi/ZkOai5UFwRTufPby2S7+lcAS3bYyKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=L+z5UZXSNLakevBvrxqlqFNCKg2OmNVMOZI1gLO+gJzdL3AlbkLy05CAWMGD1L+FU
         qNzd97b/AIsV/zKq0UbG0MOWPHv+R94tYtx8PETKsrhSx/9RYwkiQhEDzbwolD2hV1
         tpC07vb1PihEn9JmChx4gj62sy4JZ16pFab6mrSMJz6ZaCsZC7Bk0h3wni/QJIi0dq
         tXKJI6lYkzTAKhhGTIdMUBZNJk1V3jf9jXOCyg5dFm+oYkGXo8nnzhL2K98nKwAJBa
         y6TJAFMso32gSRrv/3sKZABBN0BMxRN1k76Jxv03K5VuhCpxNJvFM88FIy7mJnexyY
         7z9xVB672UILWWVaakjDU3fmXMf3+yAgFGtIGGGUbTH1mcTfHjP6xIfyjV9uSP235x
         UICUPOOjA8ozeMj+rM9U0JVY4Ij2guPpf1sqMm+waqX1uibStRu7z2I8aWxxmYcVwz
         1lLkx/p9Rr5zMASNBRgEd9mZI2OI3P/PI6lAibd1t5sl/oNBpqe
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 06/39] t6101: make hash size independent
Date:   Tue, 28 Jul 2020 23:34:13 +0000
Message-Id: <20200728233446.3066485-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $OID_REGEX instead of a hard-coded regular expression.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6101-rev-parse-parents.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 7683e4a114..7531262a5e 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -34,7 +34,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'start is valid' '
-	git rev-parse start | grep "^[0-9a-f]\{40\}$"
+	git rev-parse start | grep "^$OID_REGEX$"
 '
 
 test_expect_success 'start^0' '
