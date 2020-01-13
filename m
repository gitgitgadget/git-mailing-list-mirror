Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4015AC33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C820206D7
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PpJMpEqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMMk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:58 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37654 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728682AbgAMMkk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:40 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5A51B607FF;
        Mon, 13 Jan 2020 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919239;
        bh=1MOOFACdi6walbZenN3/PtmmpgSl97nBTVUJrzTxn5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=PpJMpEqWmneDdg0TMIqJjMq6m3cDfl0StErICGgwz5guTF6y2wvNCXeBB9oR5Yrxb
         BzWHuLKu4RB0w2A4T54U8uwCYX3U6VKe7QqTIQZ7VBXT46rEWgmZCkBSLKWsyD5bdm
         yfjx19FnBT0FvP9ocArhWSW3CPgI6jaNrb8iuukPOIQSioTYnmjsYtBBdxiqfhlAcq
         eEvC53kQkLguqEhzSjfeWtEZgb/NJG9Oqj9/C5u4FobNjIqRlyxF59iNGkyy3tizls
         3vdlXfpyV0C+FdplQaqRQL/+ChJcYkIKlEx2igdcvXfzICCfflWT5fFj+UqI0tcGXZ
         tZN/kxhAgp/kE/rPq17dW5YkFfO8JJ+gzelhAMg9n8x1Qwf1RKss/+i8+bWvpW9X6E
         y+HPsbmiEnx/ONHjk2O06QxFUlChl1MEJQejkJJI0Mvz7xN2RXYBwPQ2K5Xa+Ig4Vi
         NS+saWy18uOrOFfzjp/2rgxTb9novxRkvdywKVf8y1NS1TbEGjM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 15/24] t5321: make test hash independent
Date:   Mon, 13 Jan 2020 12:38:48 +0000
Message-Id: <20200113123857.3684632-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
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
 t/t5321-pack-large-objects.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5321-pack-large-objects.sh b/t/t5321-pack-large-objects.sh
index a75eab87d3..8a56d98a0e 100755
--- a/t/t5321-pack-large-objects.sh
+++ b/t/t5321-pack-large-objects.sh
@@ -10,8 +10,8 @@ test_description='git pack-object with "large" deltas
 . "$TEST_DIRECTORY"/lib-pack.sh
 
 # Two similar-ish objects that we have computed deltas between.
-A=01d7713666f4de822776c7622c10f1b07de280dc
-B=e68fe8129b546b101aee9510c5328e7f21ca1d18
+A=$(test_oid packlib_7_0)
+B=$(test_oid packlib_7_76)
 
 test_expect_success 'setup' '
 	clear_packs &&
