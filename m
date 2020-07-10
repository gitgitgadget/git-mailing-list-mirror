Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6185C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0C720663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SUSXlKDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGJCs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40430 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbgGJCsu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 32C7E60A79;
        Fri, 10 Jul 2020 02:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349319;
        bh=puU39q6fMSnf5trNDk5/mM+H8GbH4/pEPwYzKdKXz5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SUSXlKDGaR/fPdEiry7W/qkdxfgWAxHRsR6TNyhHmoqPNJw1sjqlCFSh8OPSOmmv6
         Hpdp79YNN0L0qZHUFcYg5832pY1Zrz2kgFQtlleJ4njl31sBMBwRHUPpwbgxdoZtNl
         5xY3z+RoOzg8LTwqathcnRz/DSUn4knIJmiKh+BaXUiyZ8+tMVbKxJBHWuokq739r4
         NALKqvxzhLRabudXvCjA1EPWv6BKqT6DlyIv6afHC2hZpfMhMF+33ZpRY1EMG3yLwG
         DYD8s2+d3jSsYdBTg3NSbf21XvYXkk302BFSLjbh+LiB/7MPdS2rdTvr9MlZ+0lqvm
         Cce1ZTbUaH5M2DqxnKJt4vzrGlARK8a/+E3hyfPRSz3Ca88sdxcBXjPLfjx/7rSxtw
         a5GNwfnHk7T6F/AAdNyHMqU6ZuPbsWRMf8qc+SgaUqNfnMHX5JTE6GyFP/RwBdhC9x
         V3LUn41s8jQinIDMiClvp/a7EoxrEb12rlGQpWFcyNIDZ8AuQDK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 36/38] ci: run tests with SHA-256
Date:   Fri, 10 Jul 2020 02:47:26 +0000
Message-Id: <20200710024728.3100527-37-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have Git supporting SHA-256, we'd like to make sure that we
don't regress that state.  Unfortunately, it's easy to do so, so to
help, let's run one of our CI jobs with SHA-256 as the default hash.
This will help us detect any problems that may occur.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ci/run-build-and-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 17e25aade9..b41b527b15 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -22,6 +22,7 @@ linux-gcc)
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
+	export GIT_TEST_DEFAULT_HASH=sha256
 	make test
 	;;
 linux-gcc-4.8)
