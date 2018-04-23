Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550111F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeDWXlS (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60712 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932731AbeDWXkn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EE034609CB;
        Mon, 23 Apr 2018 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526841;
        bh=PH/8/IdUjdA0S3YaPjbU9cRy94U1DG9eG5oarZsEKHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qj1rVG9LD/xgYZIpQawEjbcmXnMBj+ddxEf2OipfYwKgUWAdvtMu7XoatqhGwp509
         R+qZXnd9nKqtVUfQrKGgMq55cKjQ0ZO8h7u4xm+YYg6YsYQSaSCXmXu3CN55gOYaWd
         XEBRvROqoSOj+TvlV9anHAP4nCoW82EATLMOBiu5+lH/OQVHEUDwD+oV9zo6Kxo23b
         2z9K4ljxeFD7gA/YUYbCrQ8OS0IubFqGx1RekqkrUlW493bmGtRwnot72a7JpVkcnl
         6EVB+B7w65BuDQvmuq5cWLoXwanDGuUdqKXuaOwGaKkYutr7MugBGvwTK0+4shJ5TZ
         zBK2w5HMIcEr7eoXRPRvgEZKzC7OOEIYmTdFRojD0mo+k16KX80OKQ3aBXhclerYDV
         shHjfcsq4fyeygxsjN2I5lPOroJiVQBM9ZBGSscCxdea6AQzzHUFXMDM2ffHuZYg92
         vIOcgE0IRWxwqzGqUhvQ/dv9HWE9WvjNzf2VBkF5CoW6rAN2aDc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 33/41] builtin/reset: convert use of EMPTY_TREE_SHA1_BIN
Date:   Mon, 23 Apr 2018 23:39:43 +0000
Message-Id: <20180423233951.276447-34-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the last use of EMPTY_TREE_SHA1_BIN to use a direct copy from
the_hash_algo->empty_tree to avoid a dependency on a given hash
algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 7f1c3f02a3..a862c70fab 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -314,7 +314,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
-		hashcpy(oid.hash, EMPTY_TREE_SHA1_BIN);
+		oidcpy(&oid, the_hash_algo->empty_tree);
 	} else if (!pathspec.nr) {
 		struct commit *commit;
 		if (get_oid_committish(rev, &oid))
