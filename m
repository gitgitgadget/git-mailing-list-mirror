Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01761F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfHZBoC (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58266 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfHZBoC (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 44D0B60736;
        Mon, 26 Aug 2019 01:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783840;
        bh=P8yCDhvUZ0BVNjy3lVDLrSRJYFvrMTlDtO5h5NmPOdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yOEKXqdCLtkIaendjS1N3+LRSWfzP0NGshsT1NdxUgrK94nHA4XaVVGPv1Mr6oKP8
         DdiwGuOxbcKW5Q1e/7vvvzsUDCS9hMhc1iHjviumezlNmqCBCS52Kwog6Cz1rQLMAo
         h3Z6UVTzV46mqGbY26iSOopxAu27G/d9pCaX7Nk3DwuIPsGMw+2U1UDLnkPnuWR85Q
         aJS30vdSvQDIzriFMU1PBRtxKU6auZdmuXKVf4W4lpHkQbjWQaj28cM0+a5S+Vx/nX
         tO+eMJbo/i9+Nc21RIeZloIhg3uvGZr3MoI3GxcPsL8i5GhXG8mTErMjtNMoz3U/j6
         zx6B/bhPTXkoUmEUxO+zKn9U3cz3m3EyNrWtLzHsMHSuF0JO7IGi0qaO13tbBbW2K4
         8bSWkY8/FGF2NmV/Nfm1a2Ri05owk5HYVdsQvYzQlsF3hFshUk0M6/GmRlis9i1maw
         5KF7ekWhNILPaOJ2pFr+jwrGqAcHZLcT4cgeraaGwB1o9sGHeWN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 01/14] t3201: abstract away SHA-1-specific constants
Date:   Mon, 26 Aug 2019 01:43:31 +0000
Message-Id: <20190826014344.16008-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3201-branch-contains.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 0ea4fc4694..40251c9f8f 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -192,10 +192,10 @@ test_expect_success 'branch --merged with --verbose' '
 	EOF
 	test_cmp expect actual &&
 	git branch --verbose --merged topic >actual &&
-	cat >expect <<-\EOF &&
-	  master c77a0a9 second on master
-	* topic  2c939f4 [ahead 1] foo
-	  zzz    c77a0a9 second on master
+	cat >expect <<-EOF &&
+	  master $(git rev-parse --short master) second on master
+	* topic  $(git rev-parse --short topic ) [ahead 1] foo
+	  zzz    $(git rev-parse --short zzz   ) second on master
 	EOF
 	test_i18ncmp expect actual
 '
