Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47B21F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932690AbeDWXkO (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60486 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932680AbeDWXkI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 04868609A1;
        Mon, 23 Apr 2018 23:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526807;
        bh=TmaX5u1FnOnT/aaGXdiYO/UGZsaNceINehIaAL34XbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gngKphDLWuZ7bLTuKMzAGcQTYqg2Hli6k/a7EgeiIlUv8WuVdatTd5Qqm0ya1Fsjh
         N0G+fOBQUWOrdqa7DqVkneZrxAS7XKYZixi8RLd0ePtHBbil38fZjn7I5a8ufYbzKP
         uKoD9/I9Av2FoeVu8k/RlwZnwoWIim1G45v5VaAl+tQhQylFJRgD0ZNZH6zCwCQ88G
         r1bxouCY1X1QsylR/JeYt751aJWLt66fw7ENceQngG1s/UalE54kqc9uiDjb0mR+lD
         0qT3JdQO5XQwT3JZVZXTAC8bYeR3OdvqpRwdeFN8CVcB6K7McGnwfREdtL3watVx3J
         XCBwjpGBgPglLpb4NjoVXJNlJwzAQdoTDYABot5pcQPiTVWRfNk88VC+DSz8hJphx7
         SklzmWsv8+/V8vGhAmMRoy91DvQ60xPtr1Og7unFf2WyhfLWxw15bu1Qnc3wGbereW
         IzmSGrnh9vRS0Ov8oJ3McT06K59lI/JHDo3w4lkuQGX0TrGUL0p
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 03/41] Remove unused member in struct object_context
Date:   Mon, 23 Apr 2018 23:39:13 +0000
Message-Id: <20180423233951.276447-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tree member of struct object_context is unused except in one place
where we write to it.  Since there are no users of this member, remove
it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 1 -
 sha1_name.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/cache.h b/cache.h
index 4bca177cf3..11a989319d 100644
--- a/cache.h
+++ b/cache.h
@@ -1306,7 +1306,6 @@ static inline int hex2chr(const char *s)
 #define FALLBACK_DEFAULT_ABBREV 7
 
 struct object_context {
-	unsigned char tree[20];
 	unsigned mode;
 	/*
 	 * symlink_path is only used by get_tree_entry_follow_symlinks,
diff --git a/sha1_name.c b/sha1_name.c
index 5b93bf8da3..7043652a24 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1698,7 +1698,6 @@ static int get_oid_with_context_1(const char *name,
 								   name, len);
 				}
 			}
-			hashcpy(oc->tree, tree_oid.hash);
 			if (flags & GET_OID_RECORD_PATH)
 				oc->path = xstrdup(filename);
 
