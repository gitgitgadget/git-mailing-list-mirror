Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC59C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1826822B43
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 00:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbhAKAjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 19:39:16 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50548 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726995AbhAKAjQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 19:39:16 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4147C6081F;
        Mon, 11 Jan 2021 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610325475;
        bh=I74n+sMDQczOQbATZv+EOmOHt/wClxEbGAeMZOAGddk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Bp6NS6xh6BfW7TZxqF9D1mjvd2WKAQHEt7bbtenijSNzqs57JVijPFFqv7EmS5kHT
         dNhgu+TwfeRCcidBLsxBjWRGFyXZrWTZ1jQmiJodqVPxsA0447/e0On6w/o3X4aJZz
         Q76AMUe8CzA+Y2MOhsearRW43+5Q0hDwdtZYZK55oTTe4GCZRK/02eYMoaSLMm4C8s
         WY0DSoVgvnGH68uCE5izykOka/LjPcihjvWywhetw4LQvZJC7i0Ixa1y2HWQuwRiK4
         G/oL1uPwyhFhX6vfBRfiT6Xg6wwOUAF6h2ZRsRERvROyXAVnkqOl9kulwe9Uap8kjt
         kUOs+GYQ2efdJ+hrlsej3M81XgH4awHXnHCXh9TE0xvlwzJMri/VlV/IR4Veqmq8TL
         fSGf10PFfU3BqKH1kZVnRCQiRBgUQF/H8WzvnDNlckeuvVUdABQxw/cA19qUyrtwDH
         ybvLSq7NXtJS69QJTxufBZk4t/qogBwZi0sxSJGfxBd+Icy9d4Q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 5/6] fixup! commit: ignore additional signatures when parsing signed commits
Date:   Mon, 11 Jan 2021 00:37:38 +0000
Message-Id: <20210111003740.1319996-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 commit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/commit.c b/commit.c
index 7bbab5add4..23020c0bca 100644
--- a/commit.c
+++ b/commit.c
@@ -1058,7 +1058,6 @@ int parse_buffer_signed_by_header(const char *buffer,
 	int in_signature = 0, saw_signature = 0, other_signature = 0;
 	const char *line, *tail, *p;
 	const char *gpg_sig_header = gpg_sig_headers[hash_algo_by_ptr(algop)];
-	int gpg_sig_header_len = strlen(gpg_sig_header);
 
 	line = buffer;
 	tail = buffer + size;
