Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC575C11D40
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55E424656
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BcXonqKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgBTCYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:24:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36868 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727291AbgBTCYh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Feb 2020 21:24:37 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 838A36079C;
        Thu, 20 Feb 2020 02:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582165476;
        bh=tUKafEHjcepxODMGUUwamIB7uUBqCvgbU4tAT+rHV7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BcXonqKDw10InRwBb4kfsVv1z69FgiUFFBc+pU4EgEg1zWepsaWC5FXrs5Q9SzrtW
         9/6H8h2/HrkU3sLFppK8qmUe7sxDuDuet+QzfziGllutlMndFZjrcl2rwpnHPcNT3Y
         UJ8eTOBeUt8FsXW9dNsc5zUKo9fMav5SPhyvBUuG7s7ViqKUYuGk5odLugakUWn5cF
         OJovuskK5cl5UTN+rkr62ykkhzzJqP3/n+9/dHnS7gkD6FVFtNx7n6YfOchOR4/KYZ
         9SMgHFgdy3Asz7Ivw48VhB8eVKKAx2shcvun9UjeKwbkekn1ME7X3ecnY3rJzKsq/G
         bMlzPCSXWcVL1A8dEAh/fXmttCzBawGgBHcFgFnblvBGIw6Q8KTb1Rn/z5RGSdtCSs
         b1UssZeF+oAwq8HDua0OThQkewpRgjBWSfWZy8NmBRcuh3in4jUaudc8Xf+Rtm+sSn
         63PzvNi3zznlbT3gVCMke7GLiFX+aAwkDDVFT6yY7aAL/AsIwgF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 2/5] t1300: add test for urlmatch with multiple wildcards
Date:   Thu, 20 Feb 2020 02:24:10 +0000
Message-Id: <20200220022413.258026-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200220022413.258026-1-sandals@crustytoothpaste.net>
References: <20200220022413.258026-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: brian m. carlson <bk2204@github.com>

Our urlmatch code handles multiple wildcards, but we don't currently
have a test that checks this code path. Add a test that we handle this
case correctly to avoid any regressions.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 t/t1300-config.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 5464c46c18..97ebfe1f9d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1408,6 +1408,8 @@ test_expect_success 'urlmatch favors more specific URLs' '
 		cookieFile = /tmp/wildcard.txt
 	[http "https://*.example.com/wildcardwithsubdomain"]
 		cookieFile = /tmp/wildcardwithsubdomain.txt
+	[http "https://*.example.*"]
+		cookieFile = /tmp/multiwildcard.txt
 	[http "https://trailing.example.com"]
 		cookieFile = /tmp/trailing.txt
 	[http "https://user@*.example.com/"]
@@ -1454,6 +1456,10 @@ test_expect_success 'urlmatch favors more specific URLs' '
 
 	echo http.cookiefile /tmp/sub.txt >expect &&
 	git config --get-urlmatch HTTP https://user@sub.example.com >actual &&
+	test_cmp expect actual &&
+
+	echo http.cookiefile /tmp/multiwildcard.txt >expect &&
+	git config --get-urlmatch HTTP https://wildcard.example.org >actual &&
 	test_cmp expect actual
 '
 
