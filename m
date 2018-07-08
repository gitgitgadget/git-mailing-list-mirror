Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E4D1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeGHXhK (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54410 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933155AbeGHXhI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:37:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 183FB60747;
        Sun,  8 Jul 2018 23:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093026;
        bh=NlGf3VybX9bV3HFHY8hgPzR6yd0wnlt8MmRfi2O5WdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MTrkZ73NfWpc6IeNX9IVMHkxa0/DNcSQQGuQUd8TtNMKzi6vGyGS9iGRMYVAl6Qab
         E1QVUgFMCQ6owO50LSlCobl+i/9PzDl4S+0ViMAjUy/NU7/vp5/nRiEBEh6axGAqHW
         dwtpsETHtyki8St+QuOCulKhdVH3mQ+g4neXWIQufR3BHGF45kAeOKwLG2PUQiSIzS
         sLuZon+fTm78sAxdEhyvWAI5og3EUV/+NsFZH+n7r0zl1kOj3MIpeXIbExkSPRtzl2
         j5farJDUSGKov3TlwULOLlyqXnRPFafTl7Qgd/Ily3Qu7lgfJN3+8efhhcPQHUIots
         5BLiV/GftXpr410SrgR/d2xI4Na/+xBT9RQ3Hb0eDu5lMOJFIQiMOcsuON4zszpwmJ
         JvrP/oxmn2m9lKuaTxqLEb0wMJ2Ch2xlTKWujusd+4enz/RE+y69TbGh/CqEiPkZlj
         0sejHsgqC150mVmkIX0Z/ZuRMPKNtgdpiQ6u5/d4x7WGMN4NG8i
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 17/17] pretty: switch hard-coded constants to the_hash_algo
Date:   Sun,  8 Jul 2018 23:36:38 +0000
Message-Id: <20180708233638.520172-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch several hard-coded constants into expressions based either on
GIT_MAX_HEXSZ or the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 703fa6ff7b..b0e653ff25 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1575,7 +1575,7 @@ static void pp_header(struct pretty_print_context *pp,
 		}
 
 		if (starts_with(line, "parent ")) {
-			if (linelen != 48)
+			if (linelen != the_hash_algo->hexsz + 8)
 				die("bad parent line in commit");
 			continue;
 		}
@@ -1583,7 +1583,7 @@ static void pp_header(struct pretty_print_context *pp,
 		if (!parents_shown) {
 			unsigned num = commit_list_count(commit->parents);
 			/* with enough slop */
-			strbuf_grow(sb, num * 50 + 20);
+			strbuf_grow(sb, num * (GIT_MAX_HEXSZ + 10) + 20);
 			add_merge_info(pp, sb, commit);
 			parents_shown = 1;
 		}
