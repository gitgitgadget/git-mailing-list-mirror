Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9870A21847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbeEBA1t (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37804 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753491AbeEBA0y (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9D8E160B3C;
        Wed,  2 May 2018 00:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220813;
        bh=OhRUBD6ZApUZBjb6N/wyLdfAK+wid9dNn0sN/yNWv4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wLKNpoT7yTsN6dOjJpXt+HBgsGMcFmqbIyGIzPbiPEOf7/+n4lOg78LiNRo/cyH8K
         ev5ndhiGGdQ8TAg9fY9w7Vawu+GXfdzRZMVV2haFP8GmJNzltZNw59Wd45WM8y1YW5
         K5aeBrZ3/fuHqdZ3GQibwS/s7zHxhavpIjw7fDA0QyADUlApNMznuQggqjr6HZApKH
         pNxH+GLG3XR7wn1g6oNNQsFVLBnhiM4zfh3LKNu6IVwAJOIn/c2+yhVo2fuhQD4Eyy
         YJz3kU3LQa8d6JQmnXTuqr9DAENuFtvkzDupHCdP7tpJoMyS524tgZQq/2IIX/9Rh3
         LQ7M8EW5gV3PVkWkzcFbSYCMGR6jTx4omD+XJ/0wfSAZPNPxtBlrm/JRK4EM5rmrkc
         rhAN45utrd6AnHO5fX6psoNnyBpZxWVKx+e7aA1H3lsAtLGLM99hQN8eFkJVph6VJA
         CLECYWKoiqcKStYBjV5xUzRVHwu1DBCAKCJggXxfdBEQ3g+ruVn
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 30/42] sequencer: convert one use of EMPTY_TREE_SHA1_HEX
Date:   Wed,  2 May 2018 00:25:58 +0000
Message-Id: <20180502002610.915892-31-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert one use of EMPTY_TREE_SHA1_HEX to use empty_tree_oid_hex to
avoid a dependency on a given hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 5e3a50fafc..75ed9676fe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1481,7 +1481,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		unborn = get_oid("HEAD", &head);
 		if (unborn)
 			oidcpy(&head, the_hash_algo->empty_tree);
-		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD",
+		if (index_differs_from(unborn ? empty_tree_oid_hex() : "HEAD",
 				       NULL, 0))
 			return error_dirty_index(opts);
 	}
