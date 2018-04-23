Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6284C1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbeDWXlb (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60662 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932723AbeDWXkh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9876F60B3D;
        Mon, 23 Apr 2018 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526837;
        bh=2WcFK2HAI4BAZWSzU5QAxbGt2HWWRNSDzhsg2YSSvQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SspfHFs01UJxMArKG9AwZDMZrBfVA7gVjVVRQAiyVI95YD5f3MkQl3z/MofLCjBQu
         wZPYy//eJkuH1IJFSzId987bi0yzy5Zw12s2CeUopLru3YUYyIkZ7R1SY9SjITk2Z4
         LbT9BTyALqlEFjN9Wk9ZVdb9riZRSwhOWMGvE7sOIdgZysz8fHhUoHf0CLfRdU3Csa
         sl4HpJCpPpqsP6CSKV29Y15rtoMATuda6RI7O1Gn/R3+P6Gp5fVf/U83191ameNhMn
         50hh58YJ9DEQhVoSiAYwml3g6ChmZx58aY+v/lLwEAGnq/XWKIIQ5C4Ixcff0x18E0
         qooBh/BfxJ6hOpGtYVBBUBomWvF4SvSw3MDcurnHXZ5Ie9r/bkOEcQiw/nK/1UVNA+
         X2mjGaMg/xu79VkpETTZzel59WRtAhb6OMdKPmNu9U5wiKkixtrag6kgwuUQevNk0J
         OhvHqQWIMeZmBcJo21m7Q43kwZyD2GUs9symbTy2IygC0EhDweb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 29/41] sequencer: convert one use of EMPTY_TREE_SHA1_HEX
Date:   Mon, 23 Apr 2018 23:39:39 +0000
Message-Id: <20180423233951.276447-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert one use of EMPTY_TREE_SHA1_HEX to use oid_to_hex and
the_hash_algo to avoid a dependency on a given hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 667f35ebdf..b879593486 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1480,7 +1480,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		unborn = get_oid("HEAD", &head);
 		if (unborn)
 			oidcpy(&head, the_hash_algo->empty_tree);
-		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD",
+		if (index_differs_from(unborn ?
+				       oid_to_hex(the_hash_algo->empty_tree) : "HEAD",
 				       NULL, 0))
 			return error_dirty_index(opts);
 	}
