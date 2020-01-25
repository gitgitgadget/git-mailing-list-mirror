Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66043C35243
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8D22071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OQ7bexlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgAYXBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:01:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46812 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727441AbgAYXAq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:46 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1460A60FC8;
        Sat, 25 Jan 2020 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993246;
        bh=rt5DiMkEaojCqryZXItjFk7ouIEXKkpQBMjtvt74YP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OQ7bexlSGGfZ2tsYgp0puY9p/Cqgm8mRn3jCbPzb850fpxjrHkB/Eo8Q9GPpLU6pv
         KtyezbXGbgp7eBDSkGpvC+twn70zsnlGANQT0QSvir8c+Y0X1C/KKBPTwUMWz9C4/1
         LRTeFkdnHhFRjtlEctq84PxjtA+R7hAzlpEd97cN5ZFuo5kuz9TnGCPNXjg7LPDkGg
         AU5o0cB1wmOYGvqYYn9ffUIAr8MQKzBdFF7baFLuaMFaoCsK2xnXQtuw3w8gPByHd6
         ZjPtE7V3y6beeQcNZ6zG9HmvbBa9F9JMFzjsQec7RjVnBCJsVrkPLPj39RR4njFo1O
         N0qOi/RaYHi1wSWb6kn0txaKpgoOnQHtDvGwhWdyT6H/zsOe7WKnwHjDncI9vW/7NU
         QVzQVdy798s2izINAV91f9mqtNPTeLjztpXoynvSQnEW9P41Qo72Ov39U/zFFkAWXl
         rhJct0CvCNxuaWM86L9wR4+Lg9r6ka7/PMAmrVW7sHMTgdKIuHN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/22] t5309: make test hash independent
Date:   Sat, 25 Jan 2020 23:00:18 +0000
Message-Id: <20200125230035.136348-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the proper pack constants defined in lib-pack.sh to make this test
work with SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5309-pack-delta-cycles.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 491556dad9..b6b9792913 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -4,15 +4,9 @@ test_description='test index-pack handling of delta cycles in packfiles'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
-if ! test_have_prereq SHA1
-then
-       skip_all='not using SHA-1 for objects'
-       test_done
-fi
-
 # Two similar-ish objects that we have computed deltas between.
-A=01d7713666f4de822776c7622c10f1b07de280dc
-B=e68fe8129b546b101aee9510c5328e7f21ca1d18
+A=$(test_oid packlib_7_0)
+B=$(test_oid packlib_7_76)
 
 # double-check our hand-constucted packs
 test_expect_success 'index-pack works with a single delta (A->B)' '
