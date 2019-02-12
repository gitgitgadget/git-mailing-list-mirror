Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8AD21F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfBLBXx (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34366 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727265AbfBLBXn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:43 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B346960E5D;
        Tue, 12 Feb 2019 01:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934622;
        bh=R+M5dowM78UrTslSQWMskTM3dmdYk2a7spt8mNSWcP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Oa10VZFhDBmzm6oO9JtuGAworfVrW0vjtAghtfuI8faYJfFGHaFV8ZAHvnmPZSM4o
         zwx1XNDjVTftl5zv55jpvP1BzsaHdASuO+MBAM2fb94geQOQ/ga/x7HbXVRY5aA8pZ
         abOKbu7TxX/F0/eHx2SoTT5gq9OmxJ+s02tsyqVKhs/6JHqPb7mfkq+j0GXgPti2I/
         yoB+YDqGZj/xazP3jVYfr+h67s+WCahr8iKtkTC/L3YtmtK2nJzpqVOFBvQX+y860U
         zYH0jDlmRy53Hp/wKE5dxPf318DNCPqQyQTyhXQehuKrxhsZs2hdu4p99ue2CuWs5J
         jo3psEX25W2pG9AtBRZ909LybnkBzuT9hrsMAPfuNG5529yYVQAOEUMXJwcW55H3PB
         3ggtcnTcPqNxRIGGX2Y+8JtEvdcUvznNzXAmQ3QKHsQCfV1wSgpwIjTW+SKo6+f47H
         yYTd8WiG/cqpASFiGKt+H+5S4chY+WHlCi2tcav2xiP7MeJwQ6G
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 26/31] refspec: make hash size independent
Date:   Tue, 12 Feb 2019 01:22:51 +0000
Message-Id: <20190212012256.1005924-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch a use of GIT_SHA1_HEXSZ to use the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index f529092fd6..9a9bf21934 100644
--- a/refspec.c
+++ b/refspec.c
@@ -72,7 +72,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		/* LHS */
 		if (!*item->src)
 			; /* empty is ok; it means "HEAD" */
-		else if (llen == GIT_SHA1_HEXSZ && !get_oid_hex(item->src, &unused))
+		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
 			item->exact_sha1 = 1; /* ok */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */
